page 50051 "Adjust Cost Run - Log"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Adjust Cost Run - Log";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Entry No"; Rec."Entry No")
                {
                    Caption = 'Entry No';
                    ToolTip = 'Specifies the value of the Entry No field.';
                    ApplicationArea = All;
                }
                field("Start DateTime"; Rec."Start DateTime")
                {
                    Caption = 'Start DateTime';
                    ToolTip = 'Specifies the value of the Start DateTime field.';
                    ApplicationArea = All;

                }
                field("End DateTime"; Rec."End DateTime")
                {
                    Caption = 'End DateTime';
                    ToolTip = 'Specifies the value of the End DateTime field.';
                    ApplicationArea = All;

                }
                field("Run Duration"; Rec."Run Duration")
                {
                    Caption = 'Run Duration';
                    ToolTip = 'Specifies the value of the Run Duration field.';
                    ApplicationArea = All;

                }
                field("Report Filters"; Rec."Report Filters")
                {
                    Caption = 'Report Filters';
                    ToolTip = 'Specifies the value of the Report Filters field.';
                    ApplicationArea = All;

                }

            }
        }
    }

    actions
    {
    }
}

