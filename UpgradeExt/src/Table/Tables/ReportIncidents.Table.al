table 50005 "Report Incidents"
{
    Caption = 'Report Incidents';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; Shift; Code[10])
        {
            Caption = 'Shift';
        }
        field(5; "Machine Center"; Code[10])
        {
            Caption = 'Machine Center';
            TableRelation = "Machine Center";
        }
        field(6; "Incident Code"; Code[20])
        {
            Caption = 'Incident Code';
            TableRelation = Incidents;
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
        }
        field(9; "End Time"; DateTime)
        {
            Caption = 'End Time';
        }
        field(10; "Problem Area"; Text[100])
        {
            Caption = 'Problem Area';
            TableRelation = "Fixed Asset";
        }
        field(11; "Line Cleaned"; Boolean)
        {
            Caption = 'Line Cleaned';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date", Shift, "Machine Center")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Posting Date" = 0D THEN
            "Posting Date" := WORKDATE();

        ReportingIncident.INIT();
        IF ReportingIncident.FIND('+') THEN
            "Entry No." := ReportingIncident."Entry No." + 1
        ELSE
            "Entry No." := 1;

        "Machine Center" := xRec."Machine Center";
    end;

    var
        ReportingIncident: Record "Report Incidents";
}

