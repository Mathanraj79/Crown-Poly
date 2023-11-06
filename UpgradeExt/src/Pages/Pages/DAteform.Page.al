page 50020 DAteform
{
    Caption = 'DAteform';
    PageType = List;
    SourceTable = Date;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Period Type"; Rec."Period Type")
                {
                    Caption = 'Period Type';
                    ToolTip = 'Specifies the value of the Period Type field.';
                    ApplicationArea = All;
                }
                field("Period Start"; Rec."Period Start")
                {
                    Caption = 'Period Start';
                    ToolTip = 'Specifies the value of the Period Start field.';
                    ApplicationArea = All;
                }
                field("Period End"; Rec."Period End")
                {
                    Caption = 'Period End';
                    ToolTip = 'Specifies the value of the Period End field.';
                    ApplicationArea = All;
                }
                field("Period No."; Rec."Period No.")
                {
                    Caption = 'Period No.';
                    ToolTip = 'Specifies the value of the Period No. field.';
                    ApplicationArea = All;
                }
                field("Period Name"; Rec."Period Name")
                {
                    Caption = 'Period Name';
                    ToolTip = 'Specifies the value of the Period Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

