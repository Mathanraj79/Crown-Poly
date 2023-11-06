pageextension 50148 "Salesperson/Purchaser Card" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addbefore(Invoicing)
        {
            field(Broker; Rec.Broker)
            {
                ApplicationArea = all;
            }
        }
    }
}
