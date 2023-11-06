pageextension 50151 "Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Machine Center Code";Rec."Machine Center Code")
            {
                ApplicationArea = all;
            }
            field("Operating Lease Acq. Cost";Rec."Operating Lease Acq. Cost")
            {
                ApplicationArea = all;
            }
            
        }
    }
}
