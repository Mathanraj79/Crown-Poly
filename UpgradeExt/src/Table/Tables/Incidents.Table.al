table 50006 Incidents
{
    Caption = 'Incidents';
    DataClassification = CustomerContent;
    //LookupPageID = 50006;

    fields
    {
        field(1; "Incident Code"; Code[20])
        {
            Caption = 'Incident Code';
        }
        field(2; "Incident Name"; Text[50])
        {
            Caption = 'Incident Name';
        }
        field(3; "Default Description"; Text[250])
        {
            Caption = 'Default Description';
        }
    }

    keys
    {
        key(Key1; "Incident Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

