table 50029 "Sales Info."
{
    Caption = 'Sales Info.';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(3; "Invoice Date"; Date)
        {
            Caption = 'Invoice Date';
        }
        field(4; "Sell-To Customer No."; Code[20])
        {
            Caption = 'Sell-To Customer No.';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(8; Reference; Decimal)
        {
            Caption = 'Reference';
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Sell-To Customer No.", "Item No.", "Invoice Date")
        {
            SumIndexFields = Quantity, "Unit Price", Reference, Amount;
        }
        key(Key3; "Sell-To Customer No.", "Invoice Date")
        {
            SumIndexFields = Reference;
        }
    }

    fieldgroups
    {
    }
}

