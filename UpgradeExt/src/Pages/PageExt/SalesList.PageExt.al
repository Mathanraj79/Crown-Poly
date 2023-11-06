pageextension 50115 "Sales List" extends "Sales List"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
