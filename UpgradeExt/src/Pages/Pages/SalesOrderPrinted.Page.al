page 50003 "Sales Order Printed"
{
    Caption = 'Sales Order Printed';
    PageType = List;
    SourceTable = "Sales Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                field("Sales Order Printed"; Rec."Sales Order Printed")
                {
                    Caption = 'Sales Order Printed';
                    ToolTip = 'Specifies the value of the Sales Order Printed field.';
                    ApplicationArea = all;
                }
                field("Pick List Printed"; Rec."Pick List Printed")
                {
                    Caption = 'Pick List Printed';
                    ToolTip = 'Specifies the value of the Pick List Printed field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

