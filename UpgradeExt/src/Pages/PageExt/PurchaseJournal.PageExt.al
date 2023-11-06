pageextension 50140 "Purchase Journal" extends "Purchase Journal"
{
    layout
    {
        modify("Payment Discount %")
        {
            Visible = true;
        }
    }

    actions
    {
        modify("Insert Conv. LCY Rndg. Lines")
        {
            CaptionML = ENU = 'Insert Conv. $ Rndg. Lines';
        }
    }
}
