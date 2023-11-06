pageextension 50114 "Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
        addafter("Posting Description")
        {
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }
        }

    }

}
