codeunit 50101 "Sales Quote SubForm"
{

    PROCEDURE CheckResin(SalesLine: record "Sales Line"): Boolean
    var
        Item: Record Item;
        UserSetup: Record "User Setup";
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET() THEN BEGIN
            IF NOT UserSetup.Resin THEN BEGIN
                IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                    Item.INIT();
                    IF Item.GET(SalesLine."No.") THEN BEGIN
                        IF Item.Resin THEN BEGIN
                            SalesLine."Resin Unit Cost" := 0;
                            SalesLine."Resin Unit Price" := 0;
                            exit(false);
                        END ELSE BEGIN
                            IF SalesLine."Resin Unit Cost" <> SalesLine."Unit Cost (LCY)" THEN
                                SalesLine."Resin Unit Cost" := SalesLine."Unit Cost (LCY)";
                            IF SalesLine."Resin Unit Price" <> SalesLine."Unit Price" THEN
                                SalesLine."Resin Unit Price" := SalesLine."Unit Price";
                            exit(true);
                        END;
                    END;
                END ELSE BEGIN
                    IF SalesLine."Resin Unit Cost" <> SalesLine."Unit Cost (LCY)" THEN
                        SalesLine."Resin Unit Cost" := SalesLine."Unit Cost (LCY)";
                    IF SalesLine."Resin Unit Price" <> SalesLine."Unit Price" THEN
                        SalesLine."Resin Unit Price" := SalesLine."Unit Price";
                    exit(true);
                END;
            END ELSE BEGIN
                IF SalesLine."Resin Unit Cost" <> SalesLine."Unit Cost (LCY)" THEN
                    SalesLine."Resin Unit Cost" := SalesLine."Unit Cost (LCY)";
                IF SalesLine."Resin Unit Price" <> SalesLine."Unit Price" THEN
                    SalesLine."Resin Unit Price" := SalesLine."Unit Price";
                exit(true);
            END;
        END;
    END;


}
