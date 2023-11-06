table 50025 "Posted BOL Lines"
{
    Caption = 'Posted BOL Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "NMFC Item No."; Code[20])
        {
            Caption = 'NMFC Item No.';
            TableRelation = Item."No.";
        }
        field(4; Description; Text[120])
        {
            Caption = 'Description';
        }
        field(5; "Package Type"; Code[20])
        {
            Caption = 'Package Type';
        }
        field(6; "Shipping Units (Qty.)"; Decimal)
        {
            Caption = 'Shipping Units (Qty.)';
            DecimalPlaces = 0 : 0;
        }
        field(7; Class; Decimal)
        {
            Caption = 'Class';
            DecimalPlaces = 0 : 0;
        }
        field(8; Weight; Decimal)
        {
            Caption = 'Weight';
        }
        field(9; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

