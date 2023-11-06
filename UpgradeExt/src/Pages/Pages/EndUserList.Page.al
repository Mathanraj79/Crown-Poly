page 50082 "End User List"
{
    Caption = 'End User List';
    Editable = false;
    PageType = List;
    SourceTable = "End User";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("End User No."; Rec."End User No.")
                {
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = All;
                }
                field("End User Table"; Rec."End User Table")
                {
                    Caption = 'End User Table';
                    ToolTip = 'Specifies the value of the End User Table field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

