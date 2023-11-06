report 50036 "Import Phys Inv Jnl from Excel"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = all;
    Caption = 'Import Phys Inv Jnl from Excel';
    dataset
    {
        dataitem("Excel Buffer"; "Excel Buffer")
        {
            DataItemTableView = SORTING("Row No.", "Column No.")
                                ORDER(Ascending);

            trigger OnPostDataItem()
            begin
                MESSAGE('Done importing ...');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Import from")
                {
                    Caption = 'Import from';
                    field(FileName; FileName)
                    {
                        Caption = 'Workbook File Name';
                        ApplicationArea = all;
                        Editable = false;
                        ToolTip = 'Specifies the value of the Workbook File Name field.';
                        trigger OnAssistEdit()
                        begin
                            RequestFile();
                            SheetName := "Excel Buffer".SelectSheetsNameStream(InStr);
                        end;

                        trigger OnValidate()
                        begin
                            FileNameOnAfterValidate();
                        end;
                    }
                    field(SheetName; SheetName)
                    {
                        Caption = 'Worksheet Name';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Worksheet Name field.';
                        ApplicationArea = all;
                        trigger OnAssistEdit()
                        begin
                            IF ServerFileName = '' THEN
                                RequestFile();

                            SheetName := "Excel Buffer".SelectSheetsNameStream(InStr);
                        end;
                    }
                }
            }
        }
    }


    labels
    {
    }

    trigger OnPostReport()
    begin
        TempExcelBuf.DELETEALL();
        CLEAR(TempExcelBuf);
    end;

    trigger OnPreReport()
    begin
        TempExcelBuf.DELETEALL();
        CLEAR(TempExcelBuf);
        TotalRow := 0;
        CurrentRow := 2;
        LineNo := 10000;

        ItemJnlBatch.GET(TemplateNameLbl, SheetName);
        IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
            CLEAR(NoSeriesMgt);
            DocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", TODAY, FALSE);
        END;

        ReadExcelSheet();
        AnalyzeData();
    end;

    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        RebateProgHdr: Record "Rebate Program Header";
        ItemJnlLine: Record "Item Journal Line";
        recItem: Record Item;
        ItemJnlBatch: Record "Item Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FileMgt: Codeunit "File Management";
        FileName: Text;
        Text005: Label 'Imported from Excel ';
        Text006Lbl: Label 'Import Excel File';
        TotalRow: Integer;
        CurrentRow: Integer;
        ServerFileName: Text;
        SheetName: Text[250];
        Text022Lbl: Label 'You must enter a file name.';
        LineNo: Decimal;
        DocNo: Code[20];
        UnitCost: Decimal;
        UnitAmount: Decimal;
        InStr: InStream;
        TemplateNameLbl: Label 'PHYS. INVE';
        SourceCodeLbl: Label 'PHYSINVJNL';

    procedure ReadExcelSheet()
    begin
        //TempExcelBuf.OpenBook(ServerFileName, SheetName);
        TempExcelBuf.OpenBookStream(InStr, SheetName);
        TempExcelBuf.ReadSheet();
    end;

    procedure AnalyzeData()
    var
        strItem: Text;
    begin
        IF TempExcelBuf.FINDLAST() THEN
            TotalRow := TempExcelBuf."Row No.";

        REPEAT
            TempExcelBuf.RESET();
            TempExcelBuf.SETRANGE("Row No.", CurrentRow);
            IF NOT TempExcelBuf.FINDFIRST() THEN
                CurrReport.QUIT();

            ItemJnlLine.INIT();
            ItemJnlLine."Journal Template Name" := TemplateNameLbl;
            ItemJnlLine."Journal Batch Name" := SheetName;
            ItemJnlLine."Line No." := LineNo;
            ItemJnlLine."Document No." := DocNo;
            ItemJnlLine."Source Code" := SourceCodeLbl;

            REPEAT
                CASE TempExcelBuf."Column No." OF
                    1:
                        BEGIN
                            EVALUATE(ItemJnlLine."Posting Date", TempExcelBuf."Cell Value as Text");
                            ItemJnlLine.VALIDATE("Posting Date");
                        END;
                    2:
                        BEGIN
                            strItem := DELCHR(TempExcelBuf."Cell Value as Text", '=', ',');
                            ItemJnlLine.VALIDATE("Item No.", strItem);
                        END;
                    3:
                        IF TempExcelBuf."Cell Value as Text" <> '' THEN
                            ItemJnlLine.Description := TempExcelBuf."Cell Value as Text";
                    4:
                        BEGIN
                            EVALUATE(ItemJnlLine."Location Code", TempExcelBuf."Cell Value as Text");
                            ItemJnlLine.VALIDATE("Location Code");
                        END;
                    5:
                        BEGIN
                            ItemJnlLine."Phys. Inventory" := TRUE;
                            EVALUATE(ItemJnlLine."Qty. (Calculated)", TempExcelBuf."Cell Value as Text");
                            ItemJnlLine.VALIDATE("Qty. (Calculated)");
                        END;
                    6:
                        BEGIN
                            ItemJnlLine."Phys. Inventory" := TRUE;
                            EVALUATE(ItemJnlLine."Qty. (Phys. Inventory)", TempExcelBuf."Cell Value as Text");
                            ItemJnlLine.VALIDATE("Qty. (Phys. Inventory)");
                        END;
                    7:
                        BEGIN
                            //EVALUATE(ItemJnlLine."Entry Type",TempExcelBuf."Cell Value as Text");
                            //ItemJnlLine.VALIDATE("Entry Type");
                        END;
                END;
            UNTIL TempExcelBuf.NEXT() = 0;
            // SCS 07/28/2008 SCS PancaU - Begin
            recItem.SETCURRENTKEY("No.");
            recItem.SETRANGE("No.", ItemJnlLine."Item No.");
            IF recItem.FIND('-') THEN BEGIN
                UnitCost := recItem."Unit Cost";
                UnitAmount := recItem."Unit Cost";
            END ELSE BEGIN
                UnitCost := 0;
                UnitAmount := 0;
            END;
            ItemJnlLine.VALIDATE(ItemJnlLine."Unit Cost", UnitCost);
            ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount", UnitAmount);
            // SCS 07/28/2008 SCS PancaU - End

            ItemJnlLine.INSERT(TRUE);
            LineNo += 10000;
            CurrentRow += 1;
        UNTIL CurrentRow > TotalRow;
    end;

    procedure RequestFile()
    begin
        UploadIntoStream(Text006Lbl, '', '', FileName, InStr);
        IF FileName <> '' THEN
            ServerFileName := FileMgt.GetFileName(FileName)
        //ServerFileName := FileMgt.UploadFile(Text006Lbl, FileName)
        ELSE
            ServerFileName := FileMgt.GetFileName('.xlsx');
        // ServerFileName := FileMgt.UploadFile(Text006Lbl, '.xlsx');

        ValidateServerFileName();
        FileName := FileMgt.GetFileName(ServerFileName);
    end;

    local procedure FileNameOnAfterValidate()
    begin
        RequestFile();
    end;

    local procedure ValidateServerFileName()
    begin
        IF ServerFileName = '' THEN BEGIN
            FileName := '';
            SheetName := '';
            ERROR(Text022Lbl);
        END;
    end;
}

