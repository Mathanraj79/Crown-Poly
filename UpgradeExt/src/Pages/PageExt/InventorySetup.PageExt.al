pageextension 50002 "Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("Scrap Jnl. Batch Name"; Rec."Scrap Jnl. Batch Name")
            {
                ApplicationArea = all;
            }
            field("Allow Neg. Invt."; Rec."Allow Neg. Invt.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Location Mandatory")
        {
            group("For Transfer Order")
            {
                field("Default Transfer-from Location"; Rec."Default Transfer-from Location")
                {
                    ApplicationArea = all;
                }
                field("Default In Transit Location"; Rec."Default In Transit Location")
                {
                    ApplicationArea = all;
                }
            }

        }
    }
}
