pageextension 50117 "Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {

    }
    actions
    {
        modify(InsertExtTexts)
        {
            Caption = 'Insert &Ext. Text';
        }
        addafter(GetLineDiscount)
        {
            action("Custom Pricing")
            {
                CaptionML = ENU = 'Custom Pricing';
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    SalesHeader.GET(rec."Document Type", rec."Document No.");
                    //  SalesHeader.TESTFIELD(rec."Override Pricing", FALSE);
                    //SalesHeader.CustomPricing(SalesHeader); 
                end;
            }
        }
    }
    var
        SalesHeader: Record "Sales Header";
}
