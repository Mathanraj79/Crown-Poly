codeunit 50000 "Find Commision"
{

    trigger OnRun()
    begin
    end;


    procedure FindCommision(var SalespersonCommision: Record "Sales Commision Setup"; Broker2: Boolean): Decimal
    var
        Cust: Record Customer;
        Broker: Record "Salesperson/Purchaser";
        SalespersonCommision2: Record "Sales Commision Setup";
    begin
        IF Broker2 THEN BEGIN

            SalespersonCommision2.SETCURRENTKEY("Item No.", "Customer No.", Broker);
            SalespersonCommision2.SETRANGE("Item No.", SalespersonCommision."Item No.");
            SalespersonCommision2.SETRANGE("Customer No.", SalespersonCommision."Customer No.");
            SalespersonCommision2.SETRANGE(Broker, TRUE);
            SalespersonCommision2.CALCSUMS("Commision %");
            IF SalespersonCommision2."Commision %" > 0 THEN
                EXIT(SalespersonCommision2."Commision %");

            SalespersonCommision2.SETCURRENTKEY("Item No.", "Customer No.", Broker);
            SalespersonCommision2.SETRANGE("Item No.", '');
            SalespersonCommision2.SETRANGE("Customer No.", SalespersonCommision."Customer No.");
            SalespersonCommision2.SETRANGE(Broker, TRUE);
            SalespersonCommision2.CALCSUMS("Commision %");
            EXIT(SalespersonCommision2."Commision %");

            EXIT(0);
        END ELSE BEGIN
            SalespersonCommision2.SETCURRENTKEY("Item No.", "Customer No.", Broker);
            SalespersonCommision2.SETRANGE("Item No.", SalespersonCommision."Item No.");
            SalespersonCommision2.SETRANGE("Customer No.", SalespersonCommision."Customer No.");
            SalespersonCommision2.SETRANGE(Broker, FALSE);
            SalespersonCommision2.CALCSUMS("Commision %");
            IF SalespersonCommision2."Commision %" > 0 THEN
                EXIT(SalespersonCommision2."Commision %");

            SalespersonCommision2.SETCURRENTKEY("Item No.", "Customer No.", Broker);
            SalespersonCommision2.SETRANGE("Item No.", '');
            SalespersonCommision2.SETRANGE("Customer No.", SalespersonCommision."Customer No.");
            SalespersonCommision2.SETRANGE(Broker, FALSE);
            SalespersonCommision2.CALCSUMS("Commision %");
            EXIT(SalespersonCommision2."Commision %");

            EXIT(0);
        END;
    end;
}

