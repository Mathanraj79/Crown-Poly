pageextension 50144 "Check Ledger Entries" extends "Check Ledger Entries"
{
    layout
    {
        modify("Check Date")
        {
            Editable = false;
        }
        modify("Check No.")
        {
            Editable = false;
        }
        addafter("Check No.")
        {
            field(Held; Rec.Held)
            {
                ApplicationArea = all;
            }
        }
        modify("Bank Account No.")
        {
            Editable = false;
        }
        modify (Description)
        {
            Editable = false;
        }
        modify(Amount)
        {
            Editable = false;
        }
        modify("Bal. Account Type")
        {
            Editable = false;
        }
        modify("Bal. Account No.")
        {
            Editable = false;
        }
        modify("Entry Status")
        {
            Editable = false;
        }
        modify("Original Entry Status")
        {
            Editable = false;
        }
        modify("Bank Payment Type")
        {
            Editable = true;
        }
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Document Type")
        {
            Editable = false;
        }
        modify("Document No.")
        {
            Editable = false;
        }
        modify("Entry No.")
        {
            Editable = false;
        }
    }


}
