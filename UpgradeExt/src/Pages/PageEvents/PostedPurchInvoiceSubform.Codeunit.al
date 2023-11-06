codeunit 50103 "Posted Purch. Invoice Subform"
{

    VAR
        Item: Record 27;
        UserSetup: Record 91;
        LineAmount: Decimal;
        DirectUnitCost: Decimal;

    PROCEDURE CheckResin(var PurchaseInvLine: Record "Purch. Inv. Line");
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF PurchaseInvLine.Type = PurchaseInvLine.Type::Item THEN BEGIN
                    IF Item.GET(PurchaseInvLine."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            DirectUnitCost := 0;
                            LineAmount := 0;
                        END ELSE BEGIN
                            IF DirectUnitCost = 0 THEN
                                DirectUnitCost := PurchaseInvLine."Direct Unit Cost";
                            IF LineAmount = 0 THEN
                                LineAmount := PurchaseInvLine."Line Amount";
                        END;
                    END;
                END ELSE BEGIN
                    DirectUnitCost := PurchaseInvLine."Direct Unit Cost";
                    LineAmount := PurchaseInvLine."Line Amount";
                END;
            END ELSE BEGIN
                DirectUnitCost := PurchaseInvLine."Direct Unit Cost";
                LineAmount := PurchaseInvLine."Line Amount";
            END;
        END;
    END;


}
