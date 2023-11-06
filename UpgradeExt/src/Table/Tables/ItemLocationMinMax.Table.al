table 50009 "Item Location Min/Max"
{
    Caption = 'Item Location Min/Max';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(3; "Min"; Decimal)
        {
            Caption = 'Min';
        }
        field(4; "Max"; Decimal)
        {
            Caption = 'Max';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

