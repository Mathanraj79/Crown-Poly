page 50002 "Item Location Min/Max List"
{
    Caption = 'Item Location Min/Max List';
    PageType = List;
    SourceTable = "Item Location Min/Max";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field(Min; Rec.Min)
                {
                    Caption = 'Min';
                    ToolTip = 'Specifies the value of the Min field.';
                    ApplicationArea = All;
                }
                field(Max; Rec.Max)
                {
                    Caption = 'Max';
                    ToolTip = 'Specifies the value of the Max field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

