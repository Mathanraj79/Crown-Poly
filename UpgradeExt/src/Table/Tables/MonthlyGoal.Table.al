table 50038 "Monthly Goal"
{
    Caption = 'Monthly Goal';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Work Center Code"; Code[20])
        {
            Caption = 'Work Center Code';
            TableRelation = "Work Center";
        }
        field(2; Month; Integer)
        {
            Caption = 'Month';
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
        }
        field(4; Goal; Decimal)
        {
            Caption = 'Goal';
        }
        field(5; "Goal (Actual)"; Decimal)
        {
            Caption = 'Goal (Actual)';
        }
    }

    keys
    {
        key(Key1; "Work Center Code", Month, Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

