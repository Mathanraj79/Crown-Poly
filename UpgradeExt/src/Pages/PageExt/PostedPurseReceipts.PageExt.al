pageextension 50137 "Posted Purse Receipts" extends "Posted Purchase Receipts"
{

    layout
    {
        addafter("Purchaser Code")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;

            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
