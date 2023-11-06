pageextension 50139 "Sales Journal" extends "Sales Journal"
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
