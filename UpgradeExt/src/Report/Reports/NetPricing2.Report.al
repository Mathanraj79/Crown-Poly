report 50044 "Net Pricing 2"
{
    Caption = 'Net Pricing';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem(Item; Item)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.";

                trigger OnAfterGetRecord()
                var
                    EndUser: Record "End User";
                    RebateDetails: Record "Rebate Program Details";
                    RebateEndUser2: Record "Rebate Program - End User";
                    FindCommisionRec: Codeunit "Find Commision";
                    SalespersonCommision: Record "Sales Commision Setup";
                    SalesHistory: Record "Sales Info.";
                    RebateLedgerEntries2: Record "Rebate Ledger Entries";
                    RebateLedgerEntries3: Record "Rebate Ledger Entries";
                    EndUserInstantRebate: Decimal;
                    EndUserPODtRebate: Decimal;
                    EndUserMonthlyRebate: Decimal;
                    EndUserYearlyRebate: Decimal;
                    LastYearDate: Date;
                    CatchupCases: Decimal;
                    enduser2: Record "End User";
                    EndUserInstantRebate2: Decimal;
                    EndUserPODtRebate2: Decimal;
                    EndUserMonthlyRebate2: Decimal;
                    EndUserYearlyRebate2: Decimal;
                    SalesPrice: Decimal;
                    BrokerCommiSion: Decimal;
                    BrokerCommiSionAmt: Decimal;
                    SalesCommiSion: Decimal;
                    salesCommiSionAmt: Decimal;
                    RebateInformation: Record "Rebate Information";
                    SalesPrice1: Decimal;
                    SalesPrice2: Decimal;
                    TotalClaimedQty: Decimal;
                    TotalCases: Decimal;
                    RebateLedgerEntries: Record "Rebate Ledger Entries";
                    Commisionperct: Decimal;
                    CustomerInstantRebate2: Decimal;
                    CustomerPODtRebate2: Decimal;
                    CustomerMonthlyRebate2: Decimal;
                    CustomerYearlyRebate2: Decimal;
                    CustomerClaimedQty: Decimal;
                    SalespersonCommision3: Record "Sales Commision Setup";
                    CompCOGA: Decimal;
                    SalesSetup: Record "Sales & Receivables Setup";
                    CGD: Decimal;
                    SalesHistory3: Record "Sales Info.";
                    SalesInvoiceLine3: Record "Sales Invoice Line";
                    UsePricingDates: Boolean;
                begin
                    //Find Total Quantity of Invoice
                    Window.UPDATE(2, "No.");

                    SalesPrice1 := 0;
                    SalesPrice2 := 0;
                    SalesPrice := 0;

                    SalesInvoiceLine.RESET();
                    SalesInvoiceLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                    SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                    SalesInvoiceLine.SETRANGE("No.", "No.");
                    SalesInvoiceLine.SETRANGE("Posting Date", PricingStartDate, PricingEndDate);
                    SalesInvoiceLine.SETRANGE("Zero Price", FALSE);
                    SalesInvoiceLine.CALCSUMS(Quantity, Amount);
                    TotalCases := SalesInvoiceLine.Quantity;
                    IF TotalCases > 0 THEN
                        SalesPrice1 := SalesInvoiceLine.Amount / TotalCases;

                    SalesHistory.RESET();
                    SalesHistory.SETRANGE("Sell-To Customer No.", Customer."No.");
                    SalesHistory.SETRANGE("Item No.", "No.");
                    SalesHistory.SETRANGE("Invoice Date", PricingStartDate, PricingEndDate);
                    SalesHistory.CALCSUMS(Quantity, Amount);
                    TotalCases += SalesHistory.Quantity;

                    IF SalesHistory.Quantity > 0 THEN
                        SalesPrice2 := SalesHistory.Amount / SalesHistory.Quantity;

                    IF (SalesPrice1 <> 0) AND (SalesPrice2 <> 0) THEN
                        SalesPrice := (SalesPrice1 + SalesPrice2) / 2
                    ELSE
                        IF (SalesPrice1 = 0) THEN
                            SalesPrice := SalesPrice2
                        ELSE
                            SalesPrice := SalesPrice1;

                    SalesHistory3.RESET();
                    SalesHistory3.SETRANGE("Sell-To Customer No.", Customer."No.");
                    SalesHistory3.SETRANGE("Item No.", "No.");
                    SalesHistory3.SETRANGE("Invoice Date", StartingDate, EndingDate);
                    IF NOT SalesHistory3.FINDFIRST() THEN BEGIN
                        SalesInvoiceLine3.SETRANGE("Sell-to Customer No.", Customer."No.");
                        SalesInvoiceLine3.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                        SalesInvoiceLine3.SETRANGE("No.", "No.");
                        SalesInvoiceLine3.SETRANGE("Posting Date", StartingDate, EndingDate);
                        IF NOT SalesInvoiceLine3.FINDFIRST() THEN
                            UsePricingDates := TRUE
                        ELSE
                            UsePricingDates := FALSE
                    END ELSE
                        UsePricingDates := FALSE;

                    SalesInvoiceLine.RESET();
                    SalesInvoiceLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                    SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                    SalesInvoiceLine.SETRANGE("No.", "No.");
                    IF NOT UsePricingDates THEN
                        SalesInvoiceLine.SETRANGE("Posting Date", StartingDate, EndingDate)
                    ELSE
                        SalesInvoiceLine.SETRANGE("Posting Date", PricingStartDate, PricingEndDate);
                    SalesInvoiceLine.CALCSUMS(Quantity, Amount);
                    TotalCases := SalesInvoiceLine.Quantity;

                    SalesHistory.RESET();
                    SalesHistory.SETRANGE("Sell-To Customer No.", Customer."No.");
                    SalesHistory.SETRANGE("Item No.", "No.");
                    IF NOT UsePricingDates THEN
                        SalesHistory.SETRANGE("Invoice Date", StartingDate, EndingDate)
                    ELSE
                        SalesHistory.SETRANGE("Invoice Date", PricingStartDate, PricingEndDate);
                    SalesHistory.CALCSUMS(Quantity, Amount);
                    TotalCases += SalesHistory.Quantity;

                    //Caluclate Total Claimed Qty
                    RebateInformation.RESET();
                    RebateInformation.SETRANGE("Customer Type", RebateInformation."Customer Type"::"End User");
                    RebateInformation.SETRANGE("Customer No.", Customer."No.");
                    RebateInformation.SETRANGE("Item No.", "No.");
                    RebateInformation.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateInformation.CALCSUMS("Quantity Claimed");
                    TotalClaimedQty += RebateInformation."Quantity Claimed";

                    CatchupCases := TotalCases - TotalClaimedQty;

                    RebateInformation.RESET();
                    RebateInformation.SETRANGE("Customer Type", RebateInformation."Customer Type"::Customer);
                    RebateInformation.SETRANGE("No.", Customer."No.");
                    RebateInformation.SETRANGE("Item No.", "No.");
                    RebateInformation.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateInformation.CALCSUMS("Quantity Claimed");
                    CustomerClaimedQty := RebateInformation."Quantity Claimed";

                    RebateLedgerEntries.RESET();
                    RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                    RebateLedgerEntries.SETRANGE("No.", Customer."No.");
                    RebateLedgerEntries.SETRANGE("Item No.", "No.");
                    RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                    RebateLedgerEntries.CALCSUMS("Rebate Amount");
                    CustomerInstantRebate2 := RebateLedgerEntries."Rebate Amount";

                    RebateLedgerEntries.RESET();
                    RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                    RebateLedgerEntries.SETRANGE("No.", Customer."No.");
                    RebateLedgerEntries.SETRANGE("Item No.", "No.");
                    RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                    RebateLedgerEntries.CALCSUMS("Rebate Amount");
                    CustomerPODtRebate2 := RebateLedgerEntries."Rebate Amount";

                    RebateLedgerEntries.RESET();
                    RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                    RebateLedgerEntries.SETRANGE("No.", Customer."No.");
                    RebateLedgerEntries.SETRANGE("Item No.", "No.");
                    RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                    RebateLedgerEntries.CALCSUMS("Rebate Amount");
                    CustomerMonthlyRebate2 := RebateLedgerEntries."Rebate Amount";

                    RebateLedgerEntries.RESET();
                    RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                    RebateLedgerEntries.SETRANGE("No.", Customer."No.");
                    RebateLedgerEntries.SETRANGE("Item No.", "No.");
                    RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                    RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                    RebateLedgerEntries.CALCSUMS("Rebate Amount");
                    CustomerYearlyRebate2 := RebateLedgerEntries."Rebate Amount";

                    IF CustomerClaimedQty > 0 THEN BEGIN
                        CustomerInstantRebate2 := CustomerInstantRebate2 / CustomerClaimedQty;
                        CustomerPODtRebate2 := CustomerPODtRebate2 / CustomerClaimedQty;
                        CustomerMonthlyRebate2 := CustomerMonthlyRebate2 / CustomerClaimedQty;
                        CustomerYearlyRebate2 := CustomerYearlyRebate2 / CustomerClaimedQty;
                    END;

                    EndUser.RESET();
                    EndUser.SETRANGE("Customer No.", Customer."No.");
                    IF EndUser.FINDSET() THEN
                        REPEAT
                            NetPricing.INIT();
                            NetPricing.RESET();
                            NetPricing."Entry No." := LastEntryNo + 1;
                            NetPricing."Customer No." := Customer."No.";
                            NetPricing."End User No." := EndUser."End User No.";
                            NetPricing."Item No." := Item."No.";

                            RebateInformation.RESET();
                            RebateInformation.SETRANGE("Customer Type", RebateInformation."Customer Type"::"End User");
                            RebateInformation.SETRANGE("No.", EndUser."End User No.");
                            RebateInformation.SETRANGE("Item No.", Item."No.");
                            RebateInformation.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateInformation.CALCSUMS("Quantity Claimed");
                            NetPricing."End User Cases" := RebateInformation."Quantity Claimed";

                            RebateLedgerEntries.RESET();
                            RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                            RebateLedgerEntries.SETRANGE("No.", EndUser."End User No.");
                            RebateLedgerEntries.SETRANGE("Item No.", Item."No.");
                            RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateLedgerEntries.CALCSUMS("Quantity Claimed");

                            RebateLedgerEntries.RESET();
                            RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                            RebateLedgerEntries.SETRANGE("No.", EndUser."End User No.");
                            RebateLedgerEntries.SETRANGE("Item No.", Item."No.");
                            RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                            RebateLedgerEntries.CALCSUMS("Rebate Amount");
                            EndUserInstantRebate := RebateLedgerEntries."Rebate Amount";

                            RebateLedgerEntries.RESET();
                            RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                            RebateLedgerEntries.SETRANGE("No.", EndUser."End User No.");
                            RebateLedgerEntries.SETRANGE("Item No.", Item."No.");
                            RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                            RebateLedgerEntries.CALCSUMS("Rebate Amount");
                            EndUserPODtRebate := RebateLedgerEntries."Rebate Amount";

                            RebateLedgerEntries.RESET();
                            RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                            RebateLedgerEntries.SETRANGE("No.", EndUser."End User No.");
                            RebateLedgerEntries.SETRANGE("Item No.", Item."No.");
                            RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                            RebateLedgerEntries.CALCSUMS("Rebate Amount");
                            EndUserMonthlyRebate := RebateLedgerEntries."Rebate Amount";

                            RebateLedgerEntries.RESET();
                            RebateLedgerEntries.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                            RebateLedgerEntries.SETRANGE("No.", EndUser."End User No.");
                            RebateLedgerEntries.SETRANGE("Item No.", Item."No.");
                            RebateLedgerEntries.SETRANGE("Date Claimed", StartingDate, EndingDate);
                            RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                            RebateLedgerEntries.CALCSUMS("Rebate Amount");
                            EndUserYearlyRebate := RebateLedgerEntries."Rebate Amount";

                            IF TotalCases <> 0 THEN
                                NetPricing."End User Case Percent" := (RebateInformation."Quantity Claimed" / TotalCases) * 100;

                            //Rebate Information
                            IF NetPricing."End User Cases" > 0 THEN BEGIN
                                NetPricing.Instant := (EndUserInstantRebate / NetPricing."End User Cases") + CustomerInstantRebate2;
                                NetPricing.POD := (EndUserPODtRebate / NetPricing."End User Cases") + CustomerPODtRebate2;
                                NetPricing.Quarterly := (EndUserMonthlyRebate / NetPricing."End User Cases") + CustomerMonthlyRebate2;
                                NetPricing.Annually := (EndUserYearlyRebate / NetPricing."End User Cases") + CustomerYearlyRebate2;
                            END;

                            // Caluclate Base Price
                            NetPricing."Base Price Case" := SalesPrice;

                            // Caluclate Freight
                            IF TotalCases <> 0 THEN
                                NetPricing.Freight := ROUND(FreightAmount * Item."Gross Weight", 0.01);

                            // Single Net Price Calculation
                            NetPricing."Single Net Price" :=
                             NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                            CompCOGA := 0;
                            CGD := 0;
                            CompCOGA :=
                              NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                            SalesSetup.GET();
                            SalespersonCommision3.RESET();
                            SalespersonCommision3.SETRANGE("Customer No.", Customer."No.");
                            SalespersonCommision3.SETRANGE(Broker, TRUE);
                            IF SalespersonCommision3.FINDFIRST() THEN BEGIN
                                IF Item."Hippo Junior" THEN BEGIN
                                    IF CompCOGA < SalesSetup."No COGA" THEN BEGIN
                                        NetPricing."Case Cost Deduction" := SalesSetup."HJ CCA";
                                        NetPricing."Single Net Price" -= SalesSetup."HJ CCA";
                                    END;
                                END ELSE BEGIN
                                    IF Item."T Shirt" THEN BEGIN
                                        IF CompCOGA < SalesSetup."No COGA" THEN BEGIN
                                            NetPricing."Case Cost Deduction" := SalesSetup."TShirt CCA";
                                            NetPricing."Single Net Price" -= SalesSetup."TShirt CCA";
                                        END
                                    END ELSE BEGIN
                                        IF CompCOGA < SalesSetup."No COGA" THEN BEGIN
                                            NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";
                                            NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";
                                        END ELSE
                                            NetPricing."Case Cost Deduction" := 0;
                                    END;
                                END;
                            END ELSE BEGIN
                                IF Item."Hippo Junior" THEN BEGIN
                                    IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                        NetPricing."Case Cost Deduction" := SalesSetup."HJ CCA";
                                        NetPricing."Single Net Price" -= SalesSetup."HJ CCA";
                                    END;
                                END ELSE BEGIN
                                    IF Item."T Shirt" THEN BEGIN
                                        IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                            NetPricing."Case Cost Deduction" := SalesSetup."TShirt CCA";
                                            NetPricing."Single Net Price" -= SalesSetup."TShirt CCA";
                                        END;
                                    END ELSE BEGIN
                                        IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                            NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";
                                            NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";

                                        END ELSE
                                            NetPricing."Case Cost Deduction" := 0;
                                    END;
                                END;
                            END;
                            CGD := NetPricing."Case Cost Deduction";

                            // Caluclate Brokerage
                            BrokerCommiSion := 0;
                            BrokerCommiSionAmt := 0;
                            SalespersonCommision.RESET();
                            SalespersonCommision.VALIDATE("Item No.", Item."No.");
                            SalespersonCommision.VALIDATE("Customer No.", Customer."No.");
                            Commisionperct := FindCommisionRec.FindCommision(SalespersonCommision, TRUE);

                            SalespersonCommision.RESET();
                            SalespersonCommision.SETRANGE("Item No.", Item."No.");
                            SalespersonCommision.SETRANGE("Customer No.", Customer."No.");
                            SalespersonCommision.SETRANGE(Broker, TRUE);
                            IF NOT SalespersonCommision.FINDFIRST() THEN BEGIN
                                SalespersonCommision.SETRANGE("Item No.", '');
                                SalespersonCommision.SETRANGE("Customer No.", Customer."No.");
                                SalespersonCommision.SETRANGE(Broker, TRUE);
                                IF SalespersonCommision.FINDFIRST() THEN;
                            END;

                            IF SalespersonCommision."Commision Type" = SalespersonCommision."Commision Type"::"%" THEN
                                BrokerCommiSion := Commisionperct
                            ELSE
                                BrokerCommiSionAmt := Commisionperct;

                            NetPricing."Broker Commission Percent" := ((NetPricing."Single Net Price" * BrokerCommiSion * 0.01) + BrokerCommiSionAmt);

                            //Double Net Price is Net Price minus Broker Commission
                            NetPricing."Double Net Price" :=
                              NetPricing."Single Net Price" - ((NetPricing."Single Net Price" * BrokerCommiSion * 0.01) + BrokerCommiSionAmt);

                            // Caluclate Sales Person Commision
                            SalesCommiSion := 0;
                            salesCommiSionAmt := 0;
                            SalespersonCommision.RESET();
                            SalespersonCommision.VALIDATE("Item No.", Item."No.");
                            SalespersonCommision.VALIDATE("Customer No.", Customer."No.");

                            Commisionperct := FindCommisionRec.FindCommision(SalespersonCommision, FALSE);

                            SalespersonCommision.RESET();
                            SalespersonCommision.SETCURRENTKEY("Item No.", "Customer No.", Broker);
                            SalespersonCommision.SETRANGE("Item No.", Item."No.");
                            SalespersonCommision.SETRANGE("Customer No.", Customer."No.");
                            SalespersonCommision.SETRANGE(Broker, FALSE);
                            IF NOT SalespersonCommision.FINDFIRST() THEN BEGIN
                                SalespersonCommision.SETCURRENTKEY("Item No.", "Customer No.", Broker);
                                SalespersonCommision.SETRANGE("Item No.", '');
                                SalespersonCommision.SETRANGE("Customer No.", Customer."No.");
                                SalespersonCommision.SETRANGE(Broker, FALSE);
                                IF SalespersonCommision.FINDFIRST() THEN;
                            END;

                            IF SalespersonCommision."Commision Type" = SalespersonCommision."Commision Type"::"%" THEN
                                SalesCommiSion += Commisionperct
                            ELSE
                                salesCommiSionAmt += Commisionperct;

                            NetPricing."Sales Commission Percent" :=
                              ((SalesCommiSion * 0.01 * NetPricing."Double Net Price") + salesCommiSionAmt);

                            //Triple Net Price is Double Net Price minus Salesperson Commission
                            NetPricing."Triple Net Price" :=
                              NetPricing."Double Net Price" - ((SalesCommiSion * 0.01 * NetPricing."Double Net Price") + salesCommiSionAmt);

                            IF NetPricing."End User Cases" > 0 THEN
                                IF NOT (EndUser."End User No." = COPYSTR(Customer."No.", 1, 9) + '-' + COPYSTR(Customer."No.", 1, 9)) THEN
                                    NetPricing.INSERT();
                            LastEntryNo += 1;

                        UNTIL EndUser.NEXT() = 0;

                    IF CatchupCases <> 0 THEN BEGIN
                        NetPricing.INIT();
                        NetPricing."Entry No." := LastEntryNo + 1;
                        NetPricing."Customer No." := Customer."No.";

                        IF NOT enduser2.GET(
                        COPYSTR(Customer."No.", 1, 9) + '-' + COPYSTR(Customer."No.", 1, 9)) THEN BEGIN
                            enduser2."End User No." := COPYSTR(Customer."No.", 1, 9) + '-' + COPYSTR(Customer."No.", 1, 9);
                            enduser2."Customer No." := Customer."No.";
                            enduser2.INSERT();
                        END;

                        NetPricing."End User No." := COPYSTR(Customer."No.", 1, 9) + '-' + COPYSTR(Customer."No.", 1, 9);
                        NetPricing."Customer No." := Customer."No.";
                        NetPricing."Item No." := Item."No.";

                        RebateLedgerEntries3.RESET();
                        RebateLedgerEntries3.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                        RebateLedgerEntries3.SETRANGE("No.", Customer."No.");
                        RebateLedgerEntries3.SETRANGE("Item No.", Item."No.");
                        RebateLedgerEntries3.SETRANGE("Date Claimed", StartingDate, EndingDate);
                        RebateLedgerEntries3.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                        RebateLedgerEntries3.CALCSUMS("Rebate Amount");
                        EndUserInstantRebate2 := RebateLedgerEntries3."Rebate Amount";

                        NetPricing."End User Cases" := CatchupCases;

                        IF TotalCases <> 0 THEN
                            NetPricing."End User Case Percent" := (CatchupCases / TotalCases) * 100;

                        //Rebate Information
                        NetPricing.Instant := CustomerInstantRebate2;
                        NetPricing.POD := CustomerPODtRebate2;
                        NetPricing.Quarterly := CustomerMonthlyRebate2;
                        NetPricing.Annually := CustomerYearlyRebate2;

                        // Calculate Base Price
                        NetPricing."Base Price Case" := SalesPrice;

                        // Calculate Freight
                        IF TotalCases <> 0 THEN
                            NetPricing.Freight := FreightAmount * Item."Gross Weight";

                        // Single Net Price Calculation
                        NetPricing."Single Net Price" :=
                          NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);
                        CompCOGA := NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                        CompCOGA := 0;
                        CGD := 0;
                        CompCOGA := NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                        SalesSetup.GET();
                        SalespersonCommision3.RESET();
                        SalespersonCommision3.SETRANGE("Customer No.", Customer."No.");
                        SalespersonCommision3.SETRANGE(Broker, TRUE);
                        IF SalespersonCommision3.FINDFIRST() THEN
                            IF Item."Hippo Junior" THEN BEGIN
                                IF CompCOGA < SalesSetup."No COGA" THEN BEGIN
                                    NetPricing."Case Cost Deduction" := SalesSetup."HJ CCA";
                                    NetPricing."Single Net Price" -= SalesSetup."HJ CCA";
                                END;
                            END ELSE BEGIN
                                IF Item."T Shirt" THEN BEGIN
                                    IF CompCOGA < SalesSetup."No COGA" THEN
                                        NetPricing."Case Cost Deduction" := SalesSetup."TShirt CCA";
                                    NetPricing."Single Net Price" -= SalesSetup."TShirt CCA";

                                END ELSE BEGIN
                                    IF CompCOGA < SalesSetup."No COGA" THEN BEGIN
                                        NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";
                                        NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";
                                    END ELSE
                                        NetPricing."Case Cost Deduction" := 0;
                                END;
                            END
                        ELSE BEGIN
                            IF Item."Hippo Junior" THEN BEGIN
                                IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                    NetPricing."Case Cost Deduction" := SalesSetup."HJ CCA";
                                    NetPricing."Single Net Price" -= SalesSetup."HJ CCA";
                                END;
                            END ELSE BEGIN
                                IF Item."T Shirt" THEN BEGIN
                                    IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                        NetPricing."Case Cost Deduction" := SalesSetup."TShirt CCA";
                                        NetPricing."Single Net Price" -= SalesSetup."TShirt CCA";
                                    END;
                                END ELSE BEGIN
                                    IF CompCOGA < SalesSetup."No COGA No Broker" THEN BEGIN
                                        NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";
                                        NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";
                                    END ELSE
                                        NetPricing."Case Cost Deduction" := 0;
                                END;
                            END;
                        END;
                        CGD := NetPricing."Case Cost Deduction";

                        NetPricing."Broker Commission Percent" := ((NetPricing."Single Net Price" * BrokerCommiSion * 0.01) + BrokerCommiSionAmt);

                        //Double Net Price is Net Price minus Broker Commission
                        NetPricing."Double Net Price" := NetPricing."Single Net Price" - ((NetPricing."Single Net Price" * BrokerCommiSion * 0.01) + BrokerCommiSionAmt);
                        NetPricing."Sales Commission Percent" := ((SalesCommiSion * 0.01 * NetPricing."Double Net Price") + salesCommiSionAmt);

                        //Triple Net Price is Double Net Price minus Salesperson Commission
                        NetPricing."Triple Net Price" := NetPricing."Double Net Price" - ((SalesCommiSion * 0.01 * NetPricing."Double Net Price") + salesCommiSionAmt);
                        NetPricing.INSERT();

                        LastEntryNo += 1;

                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesInvHeader: Record "Sales Invoice Header";
                SalesHistory: Record "Sales Info.";
                SalesInvoiceLine: Record "Sales Invoice Line";
                ItemRec2: Record Item;
                ItemRec3: Record Item;
                TotalHistoryPounds: Decimal;
                TotalInvPounds: Decimal;
            begin
                Window.UPDATE(1, "No.");

                FreightAmount := 0;
                SalesInvHeader.RESET();
                SalesInvHeader.SETRANGE("Sell-to Customer No.", "No.");
                SalesInvHeader.SETRANGE("Posting Date", PricingStartDate, PricingEndDate);
                IF SalesInvHeader.FINDSET() THEN
                    REPEAT
                        SalesInvHeader.CALCFIELDS(Amount);
                        IF SalesInvHeader.Amount > 0 THEN
                            FreightAmount += SalesInvHeader."Freight Bills";
                    UNTIL SalesInvHeader.NEXT() = 0;

                TotalHistoryPounds := 0;
                SalesHistory.RESET();
                SalesHistory.SETRANGE("Sell-To Customer No.", "No.");
                SalesHistory.SETRANGE("Invoice Date", PricingStartDate, PricingEndDate);
                SalesHistory.CALCSUMS(Reference);
                IF SalesHistory.FINDSET() THEN
                    REPEAT
                        ItemRec2.GET(SalesHistory."Item No.");
                        TotalHistoryPounds += SalesHistory.Quantity * ItemRec2."Gross Weight";
                    UNTIL SalesHistory.NEXT() = 0;

                FreightAmount += SalesHistory.Reference;

                TotalInvPounds := 0;
                SalesInvoiceLine.RESET();
                SalesInvoiceLine.SETRANGE("Sell-to Customer No.", "No.");
                SalesInvoiceLine.SETRANGE("Posting Date", PricingStartDate, PricingEndDate);
                SalesInvoiceLine.SETRANGE("Zero Price", FALSE);
                IF SalesInvoiceLine.FINDSET() THEN
                    REPEAT
                        IF SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item THEN BEGIN
                            ItemRec3.GET(SalesInvoiceLine."No.");
                            TotalInvPounds += SalesInvoiceLine.Quantity * ItemRec3."Gross Weight";
                        END;
                    UNTIL SalesInvoiceLine.NEXT() = 0;

                IF TotalHistoryPounds + TotalInvPounds > 0 THEN
                    FreightAmount := ROUND(FreightAmount / (TotalHistoryPounds + TotalInvPounds), 0.0001);
            end;

            trigger OnPreDataItem()
            var
                genLedgSetup: Record "General Ledger Setup";
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                genLedgSetup.GET();
                IF genLedgSetup."Lock Net Pricing" THEN
                    ERROR(Text001Lbl);

                SalesSetup.GET();

                NetPricing.INIT();
                NetPricing.DELETEALL();

                LastNetPricing.RESET();
                IF LastNetPricing.FINDLAST() THEN;
                LastEntryNo := LastNetPricing."Entry No.";

                LastTotalNetPricing.RESET();
                IF LastTotalNetPricing.FINDLAST() THEN;
                TotallastEntryNo := LastTotalNetPricing."Entry No.";

                FreightAmount := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Starting Date"; StartingDate)
                {
                    ToolTip = 'Specifies the value of the StartingDate field.';
                    ApplicationArea = all;
                    Caption = 'Starting Date';
                }
                field("Ending Date"; EndingDate)
                {
                    ToolTip = 'Specifies the value of the EndingDate field.';
                    ApplicationArea = all;
                    Caption = 'Ending Date';
                }
                field("Pricing Start Date"; PricingStartDate)
                {
                    ToolTip = 'Specifies the value of the PricingStartDate field.';
                    ApplicationArea = all;
                    Caption = 'Pricing Start Date';
                }
                field("Pricing End Date"; PricingEndDate)
                {
                    ToolTip = 'Specifies the value of the PricingEndDate field.';
                    ApplicationArea = all;
                    Caption = 'Pricing End Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        Window.OPEN(text50000Lbl);
    end;

    var
        // Broker: Record "Salesperson/Purchaser";
        // Salesperson: Record "Salesperson/Purchaser";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LastNetPricing: Record "Net Price";
        NetPricing: Record "Net Price";
        LastTotalNetPricing: Record "Total Net Price";
        Window: Dialog;
        FreightAmount: Decimal;
        // SPPercent: Decimal;
        // BrokerPercent: Decimal;
        LastEntryNo: Integer;
        TotallastEntryNo: Integer;
        //OnLineNumber: Integer;
        StartingDate: Date;
        EndingDate: Date;
        text50000Lbl: Label 'Processing Customer: ##1###### \ Processing Item: ##2########', Comment = '%1  %2 ';
        //FreightAmount2: Decimal;
        PricingStartDate: Date;
        PricingEndDate: Date;
        Text001Lbl: Label 'Net Pricing is locked for commissions.';


    procedure CustomPricing(qty: Decimal): Decimal
    var
        Pricing: Record Pricing;
        UnitPrice: Decimal;
    begin
        Pricing.RESET();
        Pricing.SETRANGE("Customer No.", Customer."No.");
        Pricing.SETRANGE("Item No.", Item."No.");
        Pricing.SETFILTER("Start Date", '<=%1', WORKDATE());
        Pricing.SETFILTER("End Date", '>%1|=%2', WORKDATE(), 0D);
        Pricing.SETFILTER("Min. Qty", '<=%1', qty);
        IF Pricing.FINDFIRST() THEN
            UnitPrice := Pricing."Unit Price";

        EXIT(UnitPrice);
    end;
}

