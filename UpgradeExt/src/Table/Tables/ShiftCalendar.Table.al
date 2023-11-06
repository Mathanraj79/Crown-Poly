table 50047 "Shift Calendar"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; ProdDate; Date)
        {
            Caption = 'ProdDate';
        }
        field(2; AMPM; Text[10])
        {
            Caption = 'AMPM';
        }
        field(3; Shift; Text[10])
        {
            Caption = 'Shift';
        }
        field(4; Shift_T; Text[10])
        {
            Caption = 'Shift_T';
        }
    }

    keys
    {
        key(Key1; ProdDate, AMPM)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

