pageextension 50141 "Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        addafter("Tax Area Code")
        {
            field("Default Ship-to Address"; Rec."Default Ship-to Address")
            {
                ApplicationArea = all;
            }
            field("F.O.B.";Rec."F.O.B.")
            {
                ApplicationArea = all;
            }
            field(Notes;Rec.Notes)
            {
                ApplicationArea = all;
                MultiLine = true;
            }
        }
    }
}
