codeunit 50104 "Post Purchase Cr. memo"
{

    VAR
        Item: Record Item;
        UserSetup: Record "User Setup";
        DirectUnitCost: Decimal;
        UnitCost: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;

    PROCEDURE CheckResin(Var PurchaseCR: Record "Purch. Cr. Memo Line");
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF PurchaseCR.Type = PurchaseCR.Type::Item THEN BEGIN
                    IF Item.GET(PurchaseCR."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            DirectUnitCost := 0;
                            UnitCost := 0;
                            UnitPrice := 0;
                            LineAmount := 0;
                        END ELSE BEGIN
                            IF UnitCost <> PurchaseCR."Unit Cost (LCY)" THEN
                                UnitCost := PurchaseCR."Unit Cost (LCY)";
                            IF DirectUnitCost <> PurchaseCR."Direct Unit Cost" THEN
                                DirectUnitCost := PurchaseCR."Direct Unit Cost";
                            IF UnitPrice <> PurchaseCR."Unit Price (LCY)" THEN
                                UnitPrice := PurchaseCR."Unit Price (LCY)";
                            IF LineAmount <> PurchaseCR."Line Amount" THEN
                                LineAmount := PurchaseCR."Line Amount";
                        END;
                    END;
                END ELSE BEGIN
                    IF UnitCost <> PurchaseCR."Unit Cost (LCY)" THEN
                        UnitCost := PurchaseCR."Unit Cost (LCY)";
                    IF DirectUnitCost <> PurchaseCR."Direct Unit Cost" THEN
                        DirectUnitCost := PurchaseCR."Direct Unit Cost";
                    IF UnitPrice <> PurchaseCR."Unit Price (LCY)" THEN
                        UnitPrice := PurchaseCR."Unit Price (LCY)";
                    IF LineAmount <> PurchaseCR."Line Amount" THEN
                        LineAmount := PurchaseCR."Line Amount";
                END;
            END ELSE BEGIN
                UnitCost := PurchaseCR."Unit Cost (LCY)";
                DirectUnitCost := PurchaseCR."Direct Unit Cost";
                UnitPrice := PurchaseCR."Unit Price (LCY)";
                LineAmount := PurchaseCR."Line Amount";
            END;
        END;
    END;

}
