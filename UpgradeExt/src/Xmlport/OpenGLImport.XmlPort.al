xmlport 50013 "Open GL Import"
{
    Caption = 'Open WMS Inv Import';
    DefaultFieldsValidation = false;
    //Encoding = UTF8;
    FieldSeparator = '<TAB>';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;

    schema
    {
        textelement(WJL)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoUpdate = false;
                XmlName = 'GJL';
                fieldelement(JTN; "Gen. Journal Line"."Posting Date")
                {

                    trigger OnAfterAssignField()
                    begin
                        D1 := '';
                        D2 := '';
                        D3 := '';
                        D4 := '';
                        D5 := '';
                        D6 := '';
                        D7 := '';
                    end;
                }
                fieldelement(JTB; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(LineNo; "Gen. Journal Line".Amount)
                {
                }
                textelement(D1)
                {
                }
                textelement(D2)
                {
                }
                textelement(D3)
                {
                }
                textelement(D4)
                {
                }
                textelement(D5)
                {
                }
                textelement(D6)
                {
                }
                textelement(D7)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //IF NOT TempDimSetEntry.ISEMPTY THEN
                    TempDimSetEntry.DELETEALL(TRUE);


                    IF D1 <> '' THEN BEGIN
                        DimValue.GET('CUSTOMER', D1);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'CUSTOMER');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D1);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D2 <> '' THEN BEGIN
                        DimValue.GET('DIVISION', D2);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'DIVISION');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D2);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D3 <> '' THEN BEGIN
                        DimValue.GET('FIXED ASSET', D3);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'FIXED ASSET');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D3);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D4 <> '' THEN BEGIN
                        DimValue.GET('ITEM CATEGORY', D4);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'ITEM CATEGORY');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D4);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D5 <> '' THEN BEGIN
                        DimValue.GET('NOTES PAYABLE', D5);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'NOTES PAYABLE');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D5);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D6 <> '' THEN BEGIN
                        DimValue.GET('PRODUCTION OVERHEAD', D6);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'PRODUCTION OVERHEAD');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D6);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF D7 <> '' THEN BEGIN
                        DimValue.GET('PROJECT', D7);
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", 'PROJECT');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", D7);
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();
                    END;

                    IF NOT TempDimSetEntry.ISEMPTY THEN BEGIN
                        "Gen. Journal Line"."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        "Gen. Journal Line".MODIFY();
                    END;

                    /*
                    D1:='';
                    D2:='';
                    D3:='';
                    D4:='';
                    D5:='';
                    D6:='';
                    D7:='';
                    */

                end;

                trigger OnBeforeInsertRecord()
                begin
                    "Gen. Journal Line"."Journal Template Name" := 'GENERAL';
                    "Gen. Journal Line"."Journal Batch Name" := 'OPENGL';
                    "Gen. Journal Line"."Line No." := LineNo;
                    "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::"G/L Account";
                    "Gen. Journal Line"."Source Code" := 'GENJNL';
                    "Gen. Journal Line"."Document No." := 'OPENGL';
                    "Gen. Journal Line"."Shortcut Dimension 1 Code" := D2;
                    "Gen. Journal Line"."Shortcut Dimension 2 Code" := D1;

                    LineNo := LineNo + 10000;
                end;
            }
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

    trigger OnPreXmlPort()
    begin
        LineNo := 10000;


        GGL.RESET();
        GGL.SETRANGE("Journal Template Name", 'GENERAL');
        GGL.SETRANGE("Journal Batch Name", 'OPENGL');
        IF GGL.FINDLAST() THEN LineNo := GGL."Line No.";
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        LineNo: Integer;
        GGL: Record "Gen. Journal Line";
        TemplateName: Code[10];
        BatchName: Code[10];
        DimSetID: Integer;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValue: Record "Dimension Value";
        DimSetIDnew: Integer;
        ReservEntry: Record "Whse. Item Tracking Line";
        EntryNo: Integer;
        rItem: Record Item;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLS: Record "General Ledger Setup";
}

