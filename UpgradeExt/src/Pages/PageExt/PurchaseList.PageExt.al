pageextension 50121 "Purchase List" extends "Purchase List"
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
        addafter("Currency Code")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field("No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = all;
            }
        }
    }
}
