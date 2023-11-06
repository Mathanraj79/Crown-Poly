xmlport 50010 "Open AR Import"
{
    Caption = 'Open AR Import';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
        textelement(OpenAR)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                MinOccurs = Once;
                XmlName = 'AR';
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
                fieldelement(CustNo; "Gen. Journal Line"."Account No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Customer;

                        IF Customer.GET("Gen. Journal Line"."Account No.") THEN
                            IF CPG.GET(Customer."Customer Posting Group") THEN
                                "Gen. Journal Line"."Bal. Account No." := CPG."Receivables Account";

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
                fieldelement(PmtDiscountPerc; "Gen. Journal Line"."New Payment Discount %")
                {
                }
                fieldelement(PmtDiscountAmt; "Gen. Journal Line"."New Discount Amount")
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
                        MaxOccurs = Once;
                        MinOccurs = Once;
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
                    //MESSAGE('after insert %1,%2',TempDimSetEntry."Dimension Code",TempDimSetEntry."Dimension Value Code");

                    //TempDimSetEntry.RESET;
                    //MESSAGE('Rec:%1',TempDimSetEntry.COUNT);
                    "Gen. Journal Line"."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                    "Gen. Journal Line".MODIFY();

                    IF NOT TempDimSetEntry.ISEMPTY THEN
                        TempDimSetEntry.DELETEALL(TRUE);

                    //MESSAGE('Dim Set ID:%1',"Gen. Journal Line"."Dimension Set ID");
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "Gen. Journal Line"."Journal Template Name" := 'GENERAL';
                    "Gen. Journal Line"."Journal Batch Name" := 'OPENAR';
                    "Gen. Journal Line"."Line No." := LineNo;
                    "Gen. Journal Line"."Account Type" := "Gen. Journal Line"."Account Type"::Customer;
                    "Gen. Journal Line"."Source Code" := 'GENJNL';

                    LineNo := LineNo + 10000;

                    //IF NOT TempDimSetEntry.ISEMPTY THEN
                    //  TempDimSetEntry.DELETEALL(TRUE);
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
                group(general)
                {
                    // label()
                    // {
                    // }
                    field(BatchName; BatchName)
                    {
                        ApplicationArea = all;
                        Caption = 'BatchName';
                        ToolTip = 'Specifies the value of the BatchName field.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin

        /*
        DimValue.GET('CUSTOMER','DIST');
        TempDimSetEntry.INIT;
        TempDimSetEntry.VALIDATE("Dimension Code",'CUSTOMER');
        TempDimSetEntry.VALIDATE("Dimension Value Code",'DIST');
        TempDimSetEntry.VALIDATE("Dimension Value ID",DimValue."Dimension Value ID");
        TempDimSetEntry.INSERT;
        
        DimSetIDnew:= DimMgt.GetDimensionSetID(TempDimSetEntry);
        
        MESSAGE('setid:%1',DimSetIDnew);
        
        
        DimValue.GET(Dim,DimVal);
        TempDimSetEntry.INIT;
        TempDimSetEntry.VALIDATE("Dimension Code",Dim);
        TempDimSetEntry.VALIDATE("Dimension Value Code",DimVal);
        TempDimSetEntry.VALIDATE("Dimension Value ID",DimValue."Dimension Value ID");
        TempDimSetEntry.INSERT;
        
        //MESSAGE('%1,%2,%3',TempDimSetEntry."Dimension Code",TempDimSetEntry."Dimension Value Code",TempDimSetEntry."Dimension Value ID");
        
        //DimSetIDnew:= DimMgt.GetDimensionSetID(TempDimSetEntry);
        //MESSAGE('setid:%1',DimSetIDnew);
        
        
        */

    end;

    trigger OnPreXmlPort()
    begin
        LineNo := 10000;


        GGL.RESET();
        GGL.SETRANGE("Journal Template Name", 'GENERAL');
        GGL.SETRANGE("Journal Batch Name", 'OPENAR');
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
        CPG: Record "Customer Posting Group";
        Customer: Record Customer;
        GLS: Record "General Ledger Setup";
}

