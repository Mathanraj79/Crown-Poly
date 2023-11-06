report 50035 "Export Phys Inv Jnl to Excel"
{
    ProcessingOnly = true;
    Caption = 'Export Phys Inv Jnl to Excel';
    ApplicationArea = all;
    UsageCategory = Tasks;
    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                                WHERE("Journal Template Name" = CONST('PHYS. INVE'));
            RequestFilterFields = "Journal Batch Name";

            trigger OnAfterGetRecord()
            begin
                IF gBatchName <> "Item Journal Line"."Journal Batch Name" THEN BEGIN
                    IF gBatchName <> '' THEN BEGIN
                        //    TempExcelBuf.UpdateBook(gBatchName,gBatchName);
                        TempExcelBuf.WriteSheet(gBatchName, COMPANYNAME, USERID);
                        TempExcelBuf.DELETEALL();
                    END;
                    gBatchName := "Item Journal Line"."Journal Batch Name";
                    MakeExcelDataHeader();
                END;

                MakeExcelDataBody();
            end;

            trigger OnPostDataItem()
            begin
                IF gBatchName <> '' THEN BEGIN
                    //  TempExcelBuf.UpdateBook(gBatchName,gBatchName);
                    TempExcelBuf.WriteSheet(gBatchName, COMPANYNAME, USERID);
                    TempExcelBuf.CloseBook();
                    TempExcelBuf.OpenExcel();
                    TempExcelBuf.DELETEALL();
                END;
                DELETEALL();
            end;

            trigger OnPreDataItem()
            begin
                gBatchName := '';
                TempExcelBuf.DELETEALL();
                CLEAR(TempExcelBuf);
                TempExcelBuf.CreateNewBook('PHYSINVEN');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        // TempExcelBuf.GiveUserControl;
    end;

    var
        TempExcelBuf: Record "Excel Buffer";
        Window: Dialog;
        // Text001: ;
        gBatchName: Code[10];
        CellType: Option;

    procedure MakeExcelDataHeader()
    begin
        TempExcelBuf.ClearNewRow();
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Posting Date"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Item No."), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Location Code"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Qty. (Calculated)"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Qty. (Phys. Inventory)"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Entry Type"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuf."Cell Type"::Text);

        /*
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Journal Template Name"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Journal Batch Name"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Source No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Document No."),FALSE,'',TRUE,FALSE,TRUE,'');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Inventory Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Source Posting Group"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION(Quantity),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Invoiced Quantity"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Unit Amount"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION("Unit Cost"),FALSE,'',TRUE,FALSE,TRUE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".FIELDCAPTION(Amount),FALSE,'',TRUE,FALSE,TRUE,'@');
        */

    end;

    procedure MakeExcelDataBody()
    begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn("Item Journal Line"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuf."Cell Type"::Date);
        TempExcelBuf.AddColumn("Item Journal Line"."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line".Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line"."Location Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Item Journal Line"."Qty. (Calculated)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn("Item Journal Line"."Qty. (Phys. Inventory)", FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn("Item Journal Line"."Entry Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuf."Cell Type"::Text);

        /*
        TempExcelBuf.AddColumn("Item Journal Line"."Journal Template Name",FALSE,'',FALSE,FALSE,FALSE,'@');
        TempExcelBuf.AddColumn("Item Journal Line"."Journal Batch Name",FALSE,'',FALSE,FALSE,FALSE,'@');
        TempExcelBuf.AddColumn("Item Journal Line"."Source No.",FALSE,'',FALSE,FALSE,FALSE,'@');
        TempExcelBuf.AddColumn("Item Journal Line"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
        TempExcelBuf.AddColumn("Item Journal Line"."Inventory Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@');
        TempExcelBuf.AddColumn("Item Journal Line"."Source Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@');
        TempExcelBuf.AddColumn("Item Journal Line".Quantity,FALSE,'',FALSE,FALSE,FALSE,'');
        TempExcelBuf.AddColumn("Item Journal Line"."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'');
        TempExcelBuf.AddColumn("Item Journal Line"."Unit Amount",FALSE,'',FALSE,FALSE,FALSE,'');
        TempExcelBuf.AddColumn("Item Journal Line"."Unit Cost",FALSE,'',FALSE,FALSE,FALSE,'');
        TempExcelBuf.AddColumn("Item Journal Line".Amount,FALSE,'',FALSE,FALSE,FALSE,'');
        */

    end;
}

