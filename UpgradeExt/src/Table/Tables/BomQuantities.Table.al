table 50035 "Bom Quantities"
{
    Caption = 'Bom Quantities';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Bom No."; Code[20])
        {
            Caption = 'Bom No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 2 : 6;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; "Bom No.", "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

