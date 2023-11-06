pageextension 50105 "Vendor List" extends "Vendor List"
{
    layout
    {
        addafter(Name)
        {
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = all;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = all;
            }

        }
        addafter("Location Code")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }

        }

    }
}
