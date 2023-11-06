tableextension 50005 CustomerLedgerEntryEx extends "Cust. Ledger Entry"
{
    fields
    {
        field(50005; "New Payment Discount %"; Decimal)
        {
            Caption = 'New Payment Discount %';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            Editable = false;
        }
        field(50010; "New Payment Discount Amount"; Decimal)
        {
            Caption = 'New Payment Discount Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            Editable = false;
        }
        field(50011; "Ship-To State"; Text[30])
        {
            Caption = 'Ship-To State';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Ship-to County" WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(50012; "Bill-To State"; Text[30])
        {
            Caption = 'Bill-To State';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Bill-to County" WHERE("Bill-to Customer No." = FIELD("Customer No."),
             "No." = FIELD("Document No.")));
            Editable = false;

        }
    }
    keys
    {
        key(key37; "External Document No.", "Posting Date") { }
    }
}
