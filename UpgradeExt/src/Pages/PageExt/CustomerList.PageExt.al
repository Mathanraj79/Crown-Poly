pageextension 50102 "Customer List" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                // Visible = true;
                ApplicationArea = all;
            }
            field(County; Rec.County)
            {
                //Visible = true;
                ApplicationArea = all;
            }
        }
        addafter(Contact)
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = true;
                ApplicationArea = all;
            }
        }

    }
    trigger OnOpenPage()

    begin
        rec.SetFilter(Blocked, '%1', Rec.Blocked::" ");
    end;

}
