pageextension 50003 TransferOrderSubformEx extends "Transfer Order Subform"
{
    actions
    {
        modify(Receipt)
        {
            Visible = false;
        }
        addafter(Shipment)
        {
            action(Receipt1)
            {
                ApplicationArea = ItemTracking;
                Caption = 'Receipt';
                Image = Receipt;
                ShortCutKey = 'Shift+Ctrl+R';
                ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                trigger OnAction()
                begin
                    Rec.OpenItemTrackingLinesWithReclass1("Transfer Direction"::Inbound);
                end;
            }
        }

    }

}
