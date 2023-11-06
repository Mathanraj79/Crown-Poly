codeunit 50031 "Posted Sales Shippment"
{


    var
        UserSetup: Record 91;
        ActualDeliveryDateEditable: Boolean;

    procedure onInitEvent()
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF NOT UserSetup."Shipping Manager" THEN
                ActualDeliveryDateEditable := FALSE
            ELSE
                ActualDeliveryDateEditable := TRUE;
        END ELSE
            ActualDeliveryDateEditable := FALSE;
        //SCSML END

        ActualDeliveryDateEditable := TRUE;
    end;
}
