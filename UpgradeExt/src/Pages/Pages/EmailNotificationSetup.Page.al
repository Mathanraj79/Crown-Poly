page 50033 "Email Notification Setup"
{
    Caption = 'Email Notification Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Email Notification Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Email)
            {
                Caption = 'Email';
                field("Shipping Email Address"; Rec."Shipping Email Address")
                {
                    Caption = 'Shipping Email Address';
                    ToolTip = 'Specifies the value of the Shipping Email Address field.';
                    ApplicationArea = All;
                }
                field("Customer Service Email Address"; Rec."Customer Service Email Address")
                {
                    Caption = 'Customer Service Email Address';
                    ToolTip = 'Specifies the value of the Customer Service Email Address field.';
                    ApplicationArea = All;
                }
                field("Credit Manager Email Address"; Rec."Credit Manager Email Address")
                {
                    Caption = 'Credit Manager Email Address';
                    ToolTip = 'Specifies the value of the Credit Manager Email Address field.';
                    ApplicationArea = All;
                }
                field("Cost Manager Email Address"; Rec."Cost Manager Email Address")
                {
                    Caption = 'Cost Manager Email Address';
                    ToolTip = 'Specifies the value of the Cost Manager Email Address field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

