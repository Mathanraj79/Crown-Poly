page 50005 "Report Incidents"
{
    Caption = 'Report Incidents';
    PageType = List;
    SourceTable = "Report Incidents";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    ApplicationArea = all;
                }
                field(Shift; Rec.Shift)
                {
                    Caption = 'Shift';
                    ToolTip = 'Specifies the value of the Shift field.';
                    ApplicationArea = all;
                }
                field("Machine Center"; Rec."Machine Center")
                {
                    Caption = 'Machine Center';
                    ToolTip = 'Specifies the value of the Machine Center field.';
                    ApplicationArea = all;
                }
                field("Incident Code"; Rec."Incident Code")
                {
                    Caption = 'Incident Code';
                    ToolTip = 'Specifies the value of the Incident Code field.';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = all;
                }
                field("Start Time"; Rec."Start Time")
                {
                    Caption = 'Start Time';
                    ToolTip = 'Specifies the value of the Start Time field.';
                    ApplicationArea = all;
                }
                field("End Time"; Rec."End Time")
                {
                    Caption = 'End Time';
                    ToolTip = 'Specifies the value of the End Time field.';
                    ApplicationArea = all;
                }
                field("Problem Area"; Rec."Problem Area")
                {
                    Caption = 'Problem Area';
                    ToolTip = 'Specifies the value of the Problem Area field.';
                    ApplicationArea = all;
                }
                field("Line Cleaned"; Rec."Line Cleaned")
                {
                    Caption = 'Line Cleaned';
                    ToolTip = 'Specifies the value of the Line Cleaned field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

