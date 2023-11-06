pageextension 50116 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify("Unit Cost (LCY)")
        {
            Caption = 'Resin unit Cost';
            Editable = ResinEditable;
        }
        addafter("VAT Prod. Posting Group")
        {
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
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

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IF rec.Type = rec.Type::Item THEN
            CheckResin();
    end;

    var
        ResinEditable: Boolean;
        SalesHeader: Record "Sales Header";

    PROCEDURE CheckResin();
    VAR
        UserSetup: Record 91;
        Item: Record 27;
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            // IF NOT UserSetup.Resin THEN BEGIN
            //   IF Item.GET("No.") THEN BEGIN
            //     IF Item.Resin THEN BEGIN
            //       "Resin Unit Cost" := 0;
            //       "Resin Unit Price" :=0;
            //       ResinEditable := FALSE;
            //     END
            //     ELSE BEGIN
            //       "Resin Unit Cost" := "Unit Cost (LCY)";
            //       "Resin Unit Price" := "Unit Price";
            //       ResinEditable := TRUE;
            //     END;
            //   END;
            // END
            // ELSE BEGIN
            //   "Resin Unit Cost" := "Unit Cost (LCY)";
            //   "Resin Unit Price" := "Unit Price";
            //   ResinEditable := TRUE;
            // END;
        END;
    END;
}
