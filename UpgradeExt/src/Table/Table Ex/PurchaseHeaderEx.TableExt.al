tableextension 50012 PurchaseHeaderEx extends "Purchase Header"
{
    fields
    {
        field(50003; "Expected Rcpt. Date"; Date)
        {
            Caption = 'Expected Rcpt. Date';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50004; Tax; Decimal)
        {
            Caption = 'Tax';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50005; "Total PO Amount"; Decimal)
        {
            Caption = 'Total PO Amount';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50010; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50020; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(50021; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));

        }
        field(50022; Allocation; Boolean)
        {
            Caption = 'Allocation';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50023; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50024; "Resin Total Amount"; Decimal)
        {
            Caption = 'Resin Total Amount';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
    }
    var
        PurchLine2: Record "Purchase Line";
        Vend2: Record Vendor;



    PROCEDURE InsertDefaultGLAccount();
    VAR
        PurchaseHeader: Record "Purchase Header";
        LineNo: Integer;
    BEGIN
        //SCS1.1
        IF ("Document Type" <> "Document Type"::Invoice) AND ("Document Type" <> "Document Type"::Order) THEN
            EXIT;

        IF "Buy-from Vendor No." = '' THEN
            EXIT;

        Vend2.GET("Buy-from Vendor No.");
        IF Vend2."Default G/L Account" <> '' THEN BEGIN
            PurchLine2.SETRANGE("Document Type", "Document Type");
            PurchLine2.SETRANGE("Document No.", "No.");
            PurchLine2.SETRANGE("No.", Vend2."Default G/L Account");
            IF NOT PurchLine2.FINDFIRST() THEN BEGIN
                PurchLine2.SETRANGE("No.");
                IF PurchLine2.FIND('+') THEN
                    LineNo := PurchLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;

                PurchLine2.INIT();
                PurchLine2."Document Type" := "Document Type";
                PurchLine2."Document No." := "No.";
                PurchLine2."Line No." := LineNo;
                PurchLine2.INSERT(TRUE);
                PurchLine2.VALIDATE(Type, PurchLine2.Type::"G/L Account");
                PurchLine2.VALIDATE("No.", Vend2."Default G/L Account");
                PurchLine2.VALIDATE(Quantity, 1);
                PurchaseHeader.GET(PurchLine2."Document Type", PurchLine2."Document No.");
                PurchLine2."IRS 1099 Liable" := (PurchaseHeader."IRS 1099 Code" <> '');
                PurchLine2.MODIFY(TRUE);
            END;
        END;
    END;
}
