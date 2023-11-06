page 50021 "BOL Order List"
{
    Caption = 'BOL Order List';
    Editable = false;
    PageType = List;
    SourceTable = "BOL Order";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("BOL No."; Rec."BOL No.")
                {
                    Caption = 'BOL No.';
                    ToolTip = 'Specifies the value of the BOL No. field.';
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

