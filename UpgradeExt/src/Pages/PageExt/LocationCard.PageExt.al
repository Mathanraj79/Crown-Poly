pageextension 50152 "Location Card" extends "Location Card"
{
    layout
    {
        addafter("Provincial Tax Area Code")
        {
            field("In Transit Code";Rec."In Transit Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
