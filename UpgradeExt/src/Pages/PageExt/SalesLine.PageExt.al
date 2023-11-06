pageextension 50147 "Sales Line " extends "Sales Lines"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Est. Shipment Date"; Rec."Est. Shipment Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
