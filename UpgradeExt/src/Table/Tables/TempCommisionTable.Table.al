table 50037 "Temp Commision Table"
{
    Caption = 'Temp Commision Table';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Field 1"; Code[20])
        {
            Caption = 'Field 1';
        }
        field(2; "Field 2"; Code[20])
        {
            Caption = 'Field 2';
        }
        field(3; "Field 3"; Code[20])
        {
            Caption = 'Field 3';
        }
    }

    keys
    {
        key(Key1; "Field 1", "Field 2")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

