table 50046 "Adjust Cost Run - Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No';
        }
        field(2; "Start DateTime"; DateTime)
        {
            Caption = 'Start DateTime';
        }
        field(4; "End DateTime"; DateTime)
        {
            Caption = 'End DateTime';
        }
        field(6; "Run Duration"; Duration)
        {
            Caption = 'Run Duration';
        }
        field(12; "Report Filters"; Text[250])
        {
            Caption = 'Report Filters';
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

