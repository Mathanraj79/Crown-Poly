pageextension 50170 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addafter("Requested Receipt Date")
        {
            field("No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = all;
            }
        }
    }
}
