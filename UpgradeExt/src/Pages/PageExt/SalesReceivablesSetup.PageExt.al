pageextension 50146 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Archive Orders")
        {
            field("Case Cost Deduction"; Rec."Case Cost Deduction")
            {
                ApplicationArea = all;
            }
            field("No COGA"; Rec."No COGA")
            {
                ApplicationArea = all;
            }
            field("HJ CCA"; Rec."HJ CCA")
            {
                ApplicationArea = all;
            }
            field("TShirt CCA"; Rec."TShirt CCA")
            {
                ApplicationArea = all;
            }
            field("No COGA No Broker"; Rec."No COGA No Broker")
            {
                ApplicationArea = all;
            }
            field("Superfund Tax Enabled"; Rec."Superfund Tax Enabled")
            {
                ApplicationArea = all;
            }
            field("Superfund Tax Rate"; Rec."Superfund Tax Rate")
            {
                ApplicationArea = all;
            }
            field("Superfund Tax Account"; Rec."Superfund Tax Account")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("BOL No. Series"; Rec."BOL No. Series")
            {
                ApplicationArea = all;
            }
        }
    }
}
