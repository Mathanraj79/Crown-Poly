pageextension 50169 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }

        }
        addafter("Job Queue Status")
        {
            field(Finalized; Rec.Finalized)
            {
                ApplicationArea = all;
            }
        }
    }
}
