codeunit 50100 "Purchase Order Subform"
{

    procedure CheckResin(var PurchaseLine: Record "Purchase Line"): Boolean
    var
        UserSetup: Record "User Setup";
        Item: Record Item;
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                    IF Item.GET(PurchaseLine."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            PurchaseLine."Resin Unit Cost" := 0;
                            PurchaseLine."Resin Direct Unit Cost" := 0;
                            PurchaseLine."Resin Line Amount" := 0;
                            exit(false);
                        END ELSE BEGIN
                            IF PurchaseLine."Resin Unit Cost" <> PurchaseLine."Unit Cost (LCY)" THEN
                                PurchaseLine."Resin Unit Cost" := PurchaseLine."Unit Cost (LCY)";
                            IF PurchaseLine."Resin Direct Unit Cost" <> PurchaseLine."Direct Unit Cost" THEN
                                PurchaseLine."Resin Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                            IF PurchaseLine."Resin Line Amount" <> PurchaseLine."Line Amount" THEN
                                PurchaseLine."Resin Line Amount" := PurchaseLine."Line Amount";
                            exit(true);
                        END;
                    END;
                END ELSE BEGIN
                    IF PurchaseLine."Resin Unit Cost" <> PurchaseLine."Unit Cost (LCY)" THEN
                        PurchaseLine."Resin Unit Cost" := PurchaseLine."Unit Cost (LCY)";
                    IF PurchaseLine."Resin Direct Unit Cost" <> PurchaseLine."Direct Unit Cost" THEN
                        PurchaseLine."Resin Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                    IF PurchaseLine."Resin Line Amount" <> PurchaseLine."Line Amount" THEN
                        PurchaseLine."Resin Line Amount" := PurchaseLine."Line Amount";
                    exit(true);
                END;
            END ELSE BEGIN
                PurchaseLine."Resin Unit Cost" := PurchaseLine."Unit Cost (LCY)";
                PurchaseLine."Resin Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
                PurchaseLine."Resin Line Amount" := PurchaseLine."Line Amount";
                exit(true);
            END;
        END;
    END;

    procedure PurchaseQuantity(var Purchase: Record "Purchase Line")
    var
        UserSetup: Record "User Setup";
        TempItem: Record Item;
    begin
        IF Purchase.Type = Purchase.Type::Item THEN BEGIN
            TempItem.GET(Purchase."No.");
            IF TempItem.Resin THEN BEGIN
                IF UserSetup.GET() THEN BEGIN
                    IF UserSetup.Resin THEN BEGIN
                        Purchase."Resin Line Amount" := Purchase."Line Amount";
                    END ELSE
                        Purchase."Resin Line Amount" := 0;
                END;
            END ELSE
                Purchase."Resin Line Amount" := Purchase."Line Amount";
        END;


    end;
}
