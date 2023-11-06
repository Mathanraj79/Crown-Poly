xmlport 50011 "Open AP Import"
{
    Caption = 'Open AR Import';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
        textelement(OpenAP)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                MinOccurs = Once;
                XmlName = 'AP';
                textelement(PostingDate)
                {
                    TextType = Text;

                    trigger OnAfterAssignVariable()
                    begin
                        EVALUATE("Gen. Journal Line"."Posting Date", PostingDate);
                    end;
                }
                fieldelement(DocType; "Gen. Journal Line"."Document Type")
                {
                }
                fieldelement(DocDate; "Gen. Journal Line"."Document Date")
                {
                }
                fieldelement(ExtDoc; "Gen. Journal Line"."External Document No.")
                {
                }
                fieldelement(DocNo; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(VendorNo; "Gen. Journal Line"."Account No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Vendor;

                        IF Vendor.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                            IF VPG.GET(Vendor."Vendor Posting Group") THEN
                                "Gen. Journal Line"."Bal. Account No." := VPG."Payables Account";
                        END;
                    end;
                }
                fieldelement(Description; "Gen. Journal Line".Description)
                {
                }
                fieldelement(CurrencyCode; "Gen. Journal Line"."Currency Code")
                {
                }
                fieldelement(Amount; "Gen. Journal Line".Amount)
                {
                }
                textelement(BalAccType)
                {
                }
                textelement(BalAccountNo)
                {
                }
                fieldelement(DueDate; "Gen. Journal Line"."Due Date")
                {
                }
                fieldelement(PmtDiscountDate; "Gen. Journal Line"."Pmt. Discount Date")
                {
                }
                tableelement("Dimension Set Entry"; "Dimension Set Entry")
                {
                    LinkTable = "Gen. Journal Line";
                    MinOccurs = Zero;
                    XmlName = 'LED';
                    UseTemporary = true;
                    fieldelement(Dim; "Dimension Set Entry"."Dimension Code")
                    {
                    }
                    fieldelement(DimVal; "Dimension Set Entry"."Dimension Value Code")
                    {
                    }

                    trigger OnAfterInitRecord()
                    begin
                        "Dimension Set Entry"."Dimension Set ID" := LineNo;
                    end;

                    trigger OnAfterInsertRecord()
                    begin
                        DimValue.GET("Dimension Set Entry"."Dimension Code", "Dimension Set Entry"."Dimension Value Code");
                        TempDimSetEntry.INIT();
                        TempDimSetEntry.VALIDATE("Dimension Code", "Dimension Set Entry"."Dimension Code");
                        TempDimSetEntry.VALIDATE("Dimension Value Code", "Dimension Set Entry"."Dimension Value Code");
                        TempDimSetEntry.VALIDATE("Dimension Value ID", DimValue."Dimension Value ID");
                        TempDimSetEntry.INSERT();

                        GLS.GET();
                        IF GLS."Global Dimension 1 Code" = "Dimension Set Entry"."Dimension Code" THEN
                            "Gen. Journal Line"."Shortcut Dimension 1 Code" := "Dimension Set Entry"."Dimension Value Code";

                        IF GLS."Global Dimension 2 Code" = "Dimension Set Entry"."Dimension Code" THEN
                            "Gen. Journal Line"."Shortcut Dimension 2 Code" := "Dimension Set Entry"."Dimension Value Code";
                    end;
                }

                trigger OnAfterModifyRecord()
                begin
                    "Gen. Journal Line"."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                    "Gen. Journal Line".MODIFY();

                    IF NOT TempDimSetEntry.ISEMPTY THEN
                        TempDimSetEntry.DELETEALL(TRUE);
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "Gen. Journal Line"."Journal Template Name" := 'GENERAL';
                    "Gen. Journal Line"."Journal Batch Name" := 'OPENAP';
                    "Gen. Journal Line"."Line No." := LineNo;
                    "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Vendor;
                    "Gen. Journal Line"."Source Code" := 'GENJNL';

                    LineNo := LineNo + 10000;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    // label()
                    // {
                    // }
                    field(BatchName; BatchName)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the BatchName field.';
                        Caption = 'BatchName';
                    }
                }
            }
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
        GGL.SETRANGE("Journal Batch Name", 'OPENAP');
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
        VPG: Record "Vendor Posting Group";
        Vendor: Record Vendor;
        GLS: Record "General Ledger Setup";
}

