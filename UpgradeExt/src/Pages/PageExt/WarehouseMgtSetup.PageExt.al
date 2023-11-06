pageextension 50154 "Warehouse Mgt. Setup" extends "Warehouse Setup"
{
    layout
    {
        addafter("Shipment Posting Policy")
        {
            field("Mandatory Pick Ticket";Rec."Mandatory Pick Ticket")
            {
                ApplicationArea = all;
            }
            field("Pallet Weight";Rec."Pallet Weight")
            {
                ApplicationArea = all;
            }
        }
    }
}
