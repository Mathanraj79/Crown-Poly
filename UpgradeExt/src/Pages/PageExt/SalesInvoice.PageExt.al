pageextension 50113 "Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addbefore("Ship-to Code")
        {
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }
        }
    }
}
