codeunit 50032 "Posted Return Shipment Subform"
{
    VAR
        Item: Record Item;
        UserSetup: Record "User Setup";
        DirectUnitCost: Decimal;

    PROCEDURE CheckResin(var ReturnShipment: Record "Return Shipment Line");
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF ReturnShipment.Type = ReturnShipment.Type::Item THEN BEGIN
                    IF Item.GET(ReturnShipment."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            DirectUnitCost := 0;
                        END ELSE BEGIN
                            IF DirectUnitCost <> ReturnShipment."Direct Unit Cost" THEN
                                DirectUnitCost := ReturnShipment."Direct Unit Cost";
                        END;
                    END;
                END ELSE BEGIN
                    IF DirectUnitCost <> ReturnShipment."Direct Unit Cost" THEN
                        DirectUnitCost := ReturnShipment."Direct Unit Cost";
                END;
            END ELSE BEGIN
                DirectUnitCost := ReturnShipment."Direct Unit Cost";
            END;
        END;
    END;

}
