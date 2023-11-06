page 50032 "G/L Allocation"
{
    Caption = 'G/L Allocation';
    PageType = List;
    SourceTable = "G/L Allocation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Division Code"; Rec."Division Code")
                {
                    Caption = 'Division Code';
                    ToolTip = 'Specifies the value of the Division Code field.';
                    ApplicationArea = All;
                }
                field("Allocation Value"; Rec."Allocation Value")
                {
                    Caption = 'Allocation Value';
                    ToolTip = 'Specifies the value of the Allocation Value field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

