codeunit 50102 "Purchase Quote Subform"
{

    var
        ResinEditable: Boolean;
        Item: Record Item;
        UserSetup: Record "User Setup";
        TempItem: Record Item;


    PROCEDURE CheckResin(Var PurchaseQuote: Record "Purchase Line"): Boolean
    begin
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF PurchaseQuote.Type = PurchaseQuote.Type::Item THEN BEGIN
                    IF Item.GET(PurchaseQuote."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            PurchaseQuote."Resin Unit Cost" := 0;
                            PurchaseQuote."Resin Direct Unit Cost" := 0;
                            PurchaseQuote."Resin Line Amount" := 0;
                            ResinEditable := FALSE;
                        END ELSE BEGIN
                            IF PurchaseQuote."Resin Unit Cost" <> PurchaseQuote."Unit Cost (LCY)" THEN
                                PurchaseQuote."Resin Unit Cost" := PurchaseQuote."Unit Cost (LCY)";
                            IF PurchaseQuote."Resin Direct Unit Cost" <> PurchaseQuote."Direct Unit Cost" THEN
                                PurchaseQuote."Resin Direct Unit Cost" := PurchaseQuote."Direct Unit Cost";
                            IF PurchaseQuote."Resin Line Amount" <> PurchaseQuote."Line Amount" THEN
                                PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
                            ResinEditable := TRUE;
                        END;
                    END;
                END ELSE BEGIN
                    IF PurchaseQuote."Resin Unit Cost" <> PurchaseQuote."Unit Cost (LCY)" THEN
                        PurchaseQuote."Resin Unit Cost" := PurchaseQuote."Unit Cost (LCY)";
                    IF PurchaseQuote."Resin Direct Unit Cost" <> PurchaseQuote."Direct Unit Cost" THEN
                        PurchaseQuote."Resin Direct Unit Cost" := PurchaseQuote."Direct Unit Cost";
                    IF PurchaseQuote."Resin Line Amount" <> PurchaseQuote."Line Amount" THEN
                        PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
                    ResinEditable := TRUE;
                END;
            END ELSE BEGIN
                PurchaseQuote."Resin Unit Cost" := PurchaseQuote."Unit Cost (LCY)";
                PurchaseQuote."Resin Direct Unit Cost" := PurchaseQuote."Direct Unit Cost";
                PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
                ResinEditable := TRUE;
            END;
        END;
    END;

    procedure DirectUnitCost(var PurchaseQuote: Record "Purchase Line")
    begin
        IF PurchaseQuote.Type = PurchaseQuote.Type::Item THEN BEGIN
            TempItem.GET(PurchaseQuote."No.");
            IF TempItem.Resin THEN BEGIN
                IF UserSetup.GET() THEN BEGIN
                    IF UserSetup.Resin THEN BEGIN
                        PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
                    END ELSE
                        PurchaseQuote."Resin Line Amount" := 0;
                END;
            END ELSE
                PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
        END;
    END;

    procedure Quantity(var PurchaseQuote: Record "Purchase Line")
    begin
        IF PurchaseQuote.Type = PurchaseQuote.Type::Item THEN BEGIN
            TempItem.GET(PurchaseQuote."No.");
            IF TempItem.Resin THEN BEGIN
                IF UserSetup.GET() THEN BEGIN
                    IF UserSetup.Resin THEN BEGIN
                        PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
                    END ELSE
                        PurchaseQuote."Resin Line Amount" := 0;
                END;
            END ELSE
                PurchaseQuote."Resin Line Amount" := PurchaseQuote."Line Amount";
        END;
    end;



}
