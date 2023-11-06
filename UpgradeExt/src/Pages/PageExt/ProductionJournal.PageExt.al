pageextension 50150 "Production Journal" extends "Production Journal"
{

    layout
    {
        addafter("Posting Date")
        {
            field(Shift; Rec.Shift)
            {
                ApplicationArea = all;
            }
        }
    }
}
