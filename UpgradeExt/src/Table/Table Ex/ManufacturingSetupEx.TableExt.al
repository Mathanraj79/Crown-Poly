tableextension 50054 "Manufacturing SetupEx" extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "Time Interval"; Integer)
        {
            Caption = 'Time Interval';
            DataClassification = CustomerContent;
        }
        field(50001; "No. of Records to Process"; Integer)
        {
            Caption = 'No. of Records to Process';
            DataClassification = CustomerContent;
        }
        field(50002; "Default Location for PO"; Code[20])
        {
            Caption = 'Default Location for PO';
            DataClassification = CustomerContent;
            TableRelation = Location;
            Description = 'SCSSM01';
        }
        field(50003; "Daily Production To EmailIDs"; Text[250])
        {
            Caption = 'Daily Production To EmailIDs';
            DataClassification = CustomerContent;
        }
        field(50004; "Daily Production From Email ID"; Text[250])
        {
            Caption = 'Daily Production From Email ID';
            DataClassification = CustomerContent;
        }
    }
}
