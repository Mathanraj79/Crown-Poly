pageextension 50122 "Purchase Order Subform " extends "Purchase Order Subform"
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                ResinEditable := PurchaseOrder.CheckResin(Rec);
            end;
        }
        modify("Unit Cost (LCY)")
        {

            Caption = 'Unit Cost';
            Editable = ResinEditable;
        }
        modify("Line Amount")
        {
            Caption = 'Resin Line Amount';
            Editable = ResinEditable;
        }
        modify("Direct Unit Cost")
        {
            Caption = 'Resin Direct unit Cost';
            Editable = ResinEditable;
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                TempItem: Record Item;
            begin
                IF rec.Type = rec.Type::Item THEN BEGIN
                    TempItem.GET(rec."No.");
                    IF TempItem.Resin THEN BEGIN
                        IF UserSetup.GET() THEN BEGIN
                            IF UserSetup.Resin THEN BEGIN
                                rec."Resin Line Amount" := rec."Line Amount";
                            END ELSE
                                rec."Resin Line Amount" := 0;
                        END;
                    END ELSE
                        rec."Resin Line Amount" := rec."Line Amount";
                END ELSE
                    rec."Resin Line Amount" := rec."Line Amount";

                CurrPage.UPDATE();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()

            begin
                PurchaseOrder.PurchaseQuantity(rec);
            end;
        }
    }
    actions
    {
        modify("Insert Ext. Texts")
        {
            CaptionML = ENU = 'Insert Ext. Text';
        }
    }

    trigger OnAfterGetRecord()
    begin
        PurchaseOrder.CheckResin(Rec);
    end;

    var
        PurchaseOrder: Codeunit "Purchase Order Subform";
        ResinEditable: Boolean;

}
