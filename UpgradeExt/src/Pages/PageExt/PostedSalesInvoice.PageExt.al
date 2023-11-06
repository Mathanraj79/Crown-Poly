pageextension 50135 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Bill-to Post Code")
        {
            field("Bill-to County"; Rec."Bill-to County")
            {
                CaptionML = ENU = 'Sell-to State',
                           ESM = 'Fact. a-Provincia',
                           FRC = 'Comt, de facturation',
                           ENC = 'Province/State';
            }
        }
        modify("Ship-to Post Code")
        {
            Visible = true;
        }
        modify("Shipment Method Code")
        {
            Visible = true;
        }
    }
}
