pageextension 50128 "Posted Sales Invoice SubForm" extends "Posted Sales Invoice Subform"
{
    layout
    {
        modify("Unit Cost (LCY)")
        {
            HideValue = true;
        }
        modify("Line Amount")
        {
            Visible = false;
            HideValue = true;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
            HideValue = true;

        }
        modify("Line Discount Amount")
        {
            HideValue = true;
        }
    }
}
