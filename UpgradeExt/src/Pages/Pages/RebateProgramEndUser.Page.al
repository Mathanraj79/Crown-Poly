page 50076 "Rebate Program - End User"
{
    Caption = 'Rebate Program - End User';
    PageType = ListPart;
    SourceTable = "Rebate Program - End User";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("End User No."; Rec."End User No.")
                {
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

