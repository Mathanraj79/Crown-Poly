page 50006 Incidents
{
    Caption = 'Incidents';
    PageType = List;
    SourceTable = Incidents;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Incident Code"; Rec."Incident Code")
                {
                    Caption = 'Incident Code';
                    ToolTip = 'Specifies the value of the Incident Code field.';
                    ApplicationArea = All;
                }
                field("Incident Name"; Rec."Incident Name")
                {
                    Caption = 'Incident Name';
                    ToolTip = 'Specifies the value of the Incident Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

