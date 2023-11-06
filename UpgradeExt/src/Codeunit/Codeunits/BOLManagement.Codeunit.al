codeunit 50001 BOLManagement
{

    trigger OnRun()
    begin
    end;

    var
        Text001Lbl: Label 'Do you want to create a new Bill of Lading?';
        Text002Lbl: Label 'Process Canceled.';
        Text003Lbl: Label 'No Bill of Ladding was created.';
        Text004Lbl: Label 'There is nothing to Post.';
        Text005Lbl: Label 'Order %1 has been posted.', Comment = '%1 Order no.';
        Text006Lbl: Label 'No Bill of Ladding Exist for Order No. %1.', Comment = '%1 no.';


    procedure CreateBOL(var recSalesHeader: Record "Sales Header")
    var
        recBOLHeader: Record "BOL Header";
        recBOLLines: Record "BOL Lines";
        SalesSetup: Record "Sales & Receivables Setup";
        //recBOLHeader2: Record "BOL Header";
        recBOLLines2: Record "BOL Lines";
        BOLOrder: Record "BOL Order";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "BOLNo.": Code[20];


    begin
        IF NOT CONFIRM(Text001Lbl, TRUE) THEN
            ERROR(Text002Lbl)
        ELSE BEGIN
            SalesSetup.GET();
            "BOLNo." := NoSeriesMgt.GetNextNo(SalesSetup."BOL No. Series", TODAY, TRUE);

            recBOLHeader.RESET();
            recBOLHeader."No." := "BOLNo.";
            recBOLHeader.VALIDATE("Customer No.", recSalesHeader."Sell-to Customer No.");
            recBOLHeader.VALIDATE("Customer Name", recSalesHeader."Sell-to Customer Name");
            recBOLHeader."Ship-to Code" := recSalesHeader."Ship-to Code";
            recBOLHeader."Ship-to Name" := recSalesHeader."Ship-to Name";
            recBOLHeader."Ship-to Address" := recSalesHeader."Ship-to Address";
            recBOLHeader."Ship-to Address 2" := recSalesHeader."Ship-to Address 2";
            recBOLHeader."Ship-to City" := recSalesHeader."Ship-to City";
            recBOLHeader."Ship-to State" := recSalesHeader."Ship-to County";
            recBOLHeader."Ship-to Post Code" := recSalesHeader."Ship-to Post Code";
            recBOLHeader."Ship-to Country" := recSalesHeader."Ship-to Country/Region Code";
            recBOLHeader."BOL Date" := recSalesHeader."Shipment Date";
            recBOLHeader."PU Date" := recSalesHeader."Shipment Date";
            recBOLHeader.Notes := recSalesHeader.Notes;
            recBOLHeader."Ship-to Contact" := recSalesHeader."Ship-to Contact";
            recBOLHeader.SCAC := recSalesHeader."Shipping Agent Code";

            recBOLLines.RESET();
            recBOLLines."No." := "BOLNo.";
            recBOLLines."Order No." := recSalesHeader."No.";
            recBOLLines2.RESET();
            recBOLLines2.SETRANGE("No.", recSalesHeader."No.");
            IF recBOLLines2.FINDLAST() THEN
                recBOLLines."Line No." := recBOLLines2."Line No." + 1000
            ELSE
                recBOLLines."Line No." := 1000;

            IF recBOLHeader.INSERT(TRUE) THEN BEGIN
                recSalesHeader."BOL No." := "BOLNo.";
                recSalesHeader.MODIFY();
                recBOLLines.INSERT(TRUE);

                BOLOrder.RESET();
                BOLOrder."Order No." := recSalesHeader."No.";
                BOLOrder."BOL No." := "BOLNo.";
                BOLOrder.INSERT();
            END ELSE
                ERROR(Text003Lbl);
        END;

        COMMIT();
    end;

    procedure PostBOL(var recBOLHeader: Record "BOL Header") Posted: Boolean
    var
        recPostedBOLHeader: Record "Posted BOL Header";
        recPostedBOLLines: Record "Posted BOL Lines";
        recBOLLines: Record "BOL Lines";
        BOLOrder: Record "BOL Order";
    begin
        IF recBOLHeader."No." = '' THEN
            ERROR(Text004Lbl);

        recPostedBOLHeader.TRANSFERFIELDS(recBOLHeader);
        recPostedBOLHeader.INSERT();

        recBOLLines.RESET();
        recBOLLines.SETRANGE("No.", recBOLHeader."No.");
        IF recBOLLines.FINDSET() THEN
            REPEAT
                recPostedBOLLines.TRANSFERFIELDS(recBOLLines);
                recPostedBOLLines.INSERT();
            UNTIL recBOLLines.NEXT() = 0;
        recBOLLines.DELETEALL();

        BOLOrder.RESET();
        BOLOrder.SETRANGE("BOL No.", recBOLHeader."No.");
        IF BOLOrder.FINDSET() THEN
            REPEAT
                BOLOrder.Posted := TRUE;
                BOLOrder.MODIFY();
            UNTIL BOLOrder.NEXT() = 0;

        recBOLHeader.DELETE();

        Posted := TRUE;
        MESSAGE(Text005Lbl, recPostedBOLHeader."No.");
    end;


    procedure ListBOL(SalesHeader: Record "Sales Header")
    var
        BOLOrder: Record "BOL Order";
        //SalesHeader2: Record "Sales Header";
        BOLHeader: Record "BOL Header";
        BOLOrderList: Page "BOL Order List";
        BOL: Page "BOL Form";
    begin
        BOLOrder.RESET();
        BOLOrder.SETRANGE("Order No.", SalesHeader."No.");
        IF BOLOrder.FINDFIRST() THEN BEGIN
            IF BOLOrder.COUNT > 0 THEN BEGIN
                BOLOrderList.SETTABLEVIEW(BOLOrder);
                IF BOLOrderList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    BOLOrderList.GETRECORD(BOLOrder);
                    BOLHeader.RESET();
                    BOLHeader.SETRANGE("No.", BOLOrder."BOL No.");
                    IF BOLHeader.FINDFIRST() THEN BEGIN
                        BOL.SETTABLEVIEW(BOLHeader);
                        BOL.RUNMODAL();
                    END;
                END;
            END;
        END ELSE
            ERROR(Text006Lbl, SalesHeader."No.");
    end;
}

