page 50041 "Mini Screen - Main Menu"
{
    // SSC56 - new object

    Caption = 'Main Menu';
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Main Menu")
            {
                Caption = 'Main Menu';
                group(WELCOME)
                {
                    Caption = 'WELCOME';
                    field(USERID; USERID)
                    {
                        Caption = 'User ID';
                        ColumnSpan = 2;
                        Editable = false;
                        Enabled = false;
                        ToolTip = 'Specifies the value of the User ID field.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("FG Moved to WH")
            {
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'FG Moved to WH';
                ToolTip = 'Executes the FG Moved to WH action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RUNMODAL(Page::"Mini Screen - FG Moved to WH");
                end;
            }
            action("Transfer Order Receive")
            {
                Image = TransferReceipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Transfer Order Receive';
                ToolTip = 'Executes the Transfer Order Receive action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RUNMODAL(Page::"Mini Screen - Transer Order");
                end;
            }
            action("Sales Order Pick - WH")
            {
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Sales Order Pick - WH';
                ToolTip = 'Executes the Sales Order Pick - WH action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RUNMODAL(Page::"Mini Screen - SO Pick WH");
                end;
            }
            action("Sales Order Pick - Non WH")
            {
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Sales Order Pick - Non WH';
                ToolTip = 'Executes the Sales Order Pick - Non WH action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PAGE.RUNMODAL(Page::"Mini Screen - SO Pick NonWH");
                end;
            }
        }
    }

}

