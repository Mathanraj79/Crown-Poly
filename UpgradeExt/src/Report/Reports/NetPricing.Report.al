report 50020 "Net Pricing"
{
    Caption = 'Net Pricing';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Sell-to Customer No.", Type, "No.")
                                WHERE(Type = FILTER(Item));
            RequestFilterFields = "Header Posting Date";

            trigger OnAfterGetRecord()
            begin
                TempSalesInvoiceLine.RESET();
                TempSalesInvoiceLine.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                TempSalesInvoiceLine.SETRANGE(Type, Type);
                TempSalesInvoiceLine.SETRANGE("No.", "No.");
                IF NOT TempSalesInvoiceLine.FINDFIRST() THEN BEGIN
                    TempSalesInvoiceLine.INIT();
                    TempSalesInvoiceLine."Document No." := "Document No.";
                    TempSalesInvoiceLine."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 10000;
                    TempSalesInvoiceLine."Sell-to Customer No." := "Sell-to Customer No.";
                    TempSalesInvoiceLine.Type := Type;
                    TempSalesInvoiceLine."No." := "No.";
                    TempSalesInvoiceLine.Quantity := Quantity;
                    TempSalesInvoiceLine."Unit Price" := "Unit Price";
                    TempSalesInvoiceLine.INSERT();
                END ELSE BEGIN
                    TempSalesInvoiceLine.Quantity := TempSalesInvoiceLine.Quantity + Quantity;
                    TempSalesInvoiceLine.MODIFY();
                END;
            end;

            trigger OnPreDataItem()
            begin
                TotalCases := 0;
                FreightAmount := 0;

                NetPricing.RESET();
                NetPricing.DELETEALL();

                TempSalesInvoiceLine.RESET();
                TempSalesInvoiceLine.DELETEALL();

                LastNetPricing.RESET();
                IF LastNetPricing.FINDLAST() THEN
                    LastEntryNo := LastNetPricing."Entry No.";

                LastTotalNetPricing.RESET();
                IF LastTotalNetPricing.FINDLAST() THEN
                    TotallastEntryNo := LastTotalNetPricing."Entry No.";

                SalesSetup.GET();

                NextLineNo := 10000;
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    TempSalesInvoiceLine.FINDSET()
                ELSE
                    TempSalesInvoiceLine.NEXT();

                IF GUIALLOWED THEN BEGIN
                    Window.UPDATE(1, TempSalesInvoiceLine."Sell-to Customer No.");
                    Window.UPDATE(2, TempSalesInvoiceLine."No.");
                END;

                SalesInvHeader.RESET();
                SalesInvHeader.SETRANGE("Sell-to Customer No.", TempSalesInvoiceLine."Sell-to Customer No.");
                SalesInvHeader.CALCSUMS("Freight Bills");
                FreightAmount := SalesInvHeader."Freight Bills";

                //Find Total Quantity of Invoice
                TotalCases := TempSalesInvoiceLine.Quantity;

                LastYearDate := CALCDATE('<-1Y>', WORKDATE());

                SalesHistory.RESET();
                SalesHistory.SETRANGE("Sell-To Customer No.", TempSalesInvoiceLine."Sell-to Customer No.");
                SalesHistory.SETRANGE("Item No.", TempSalesInvoiceLine."No.");
                SalesHistory.SETRANGE("Invoice Date", LastYearDate, WORKDATE());
                SalesHistory.CALCSUMS(Quantity);
                TotalCases := TotalCases + SalesHistory.Quantity;

                IF TotalCases <> 0 THEN
                    FreightAmount := FreightAmount / TotalCases;

                //Caluclate Total Claimed Qty
                RebateLedgerEntries.RESET();
                RebateLedgerEntries.SETRANGE("No.", TempSalesInvoiceLine."Sell-to Customer No.");
                RebateLedgerEntries.SETRANGE("Item No.", TempSalesInvoiceLine."No.");
                RebateLedgerEntries.SETRANGE("Date Claimed", LastYearDate, WORKDATE());
                RebateLedgerEntries.CALCSUMS("Quantity Claimed");
                TotalClaimedQty := RebateLedgerEntries."Quantity Claimed";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserInstantRebate := RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserPODtRebate := RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserMonthlyRebate := RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserYearlyRebate := RebateLedgerEntries."Rebate Amount";


                RebateLedgerEntries.RESET();
                RebateLedgerEntries.SETRANGE("End User Cust No.", TempSalesInvoiceLine."Sell-to Customer No.");
                RebateLedgerEntries.SETRANGE("Item No.", TempSalesInvoiceLine."No.");
                RebateLedgerEntries.SETRANGE("Date Claimed", LastYearDate, WORKDATE());
                RebateLedgerEntries.CALCSUMS("Quantity Claimed");
                TotalClaimedQty += RebateLedgerEntries."Quantity Claimed";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserInstantRebate += RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserPODtRebate += RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserMonthlyRebate += RebateLedgerEntries."Rebate Amount";

                RebateLedgerEntries.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                RebateLedgerEntries.CALCSUMS("Rebate Amount");
                EndUserYearlyRebate += RebateLedgerEntries."Rebate Amount";

                CatchupCases := TotalCases - TotalClaimedQty;

                IF CatchupCases < 0 THEN
                    CatchupCases := 0;

                EndUser.RESET();
                EndUser.SETRANGE("Customer No.", TempSalesInvoiceLine."Sell-to Customer No.");
                REPEAT
                    NetPricing.INIT();
                    NetPricing."Entry No." := LastEntryNo + 1;
                    NetPricing."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";
                    NetPricing."End User No." := EndUser."End User No.";
                    NetPricing."Item No." := TempSalesInvoiceLine."No.";

                    RebateLedgerEntries2.RESET();
                    RebateLedgerEntries2.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::"End User");
                    RebateLedgerEntries2.SETRANGE("No.", EndUser."End User No.");
                    RebateLedgerEntries2.SETRANGE("Item No.", TempSalesInvoiceLine."No.");
                    RebateLedgerEntries2.SETRANGE("Date Claimed", LastYearDate, WORKDATE());
                    RebateLedgerEntries2.CALCSUMS("Quantity Claimed");

                    RebateLedgerEntries2.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                    RebateLedgerEntries2.CALCSUMS("Rebate Amount");
                    EndUserInstantRebate += RebateLedgerEntries2."Rebate Amount";

                    RebateLedgerEntries2.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                    RebateLedgerEntries2.CALCSUMS("Rebate Amount");
                    EndUserPODtRebate += RebateLedgerEntries2."Rebate Amount";

                    RebateLedgerEntries2.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                    RebateLedgerEntries2.CALCSUMS("Rebate Amount");
                    EndUserMonthlyRebate += RebateLedgerEntries2."Rebate Amount";

                    RebateLedgerEntries2.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                    RebateLedgerEntries2.CALCSUMS("Rebate Amount");
                    EndUserYearlyRebate += RebateLedgerEntries2."Rebate Amount";

                    IF TotalClaimedQty <> 0 THEN
                        NetPricing."End User Case Percent" := (RebateLedgerEntries2."Quantity Claimed" / TotalClaimedQty) * 0.01;

                    //Rebate Information
                    NetPricing.Instant := NetPricing."End User Case Percent" * EndUserInstantRebate;
                    NetPricing.POD := NetPricing."End User Case Percent" * EndUserPODtRebate;
                    NetPricing.Quarterly := NetPricing."End User Case Percent" * EndUserMonthlyRebate;
                    NetPricing.Annually := NetPricing."End User Case Percent" * EndUserYearlyRebate;

                    // Calculate Base Price
                    IF TempSalesInvoiceLine.Quantity <> 0 THEN
                        NetPricing."Base Price Case" := TempSalesInvoiceLine."Unit Price";

                    // Caluclate Freight
                    IF TotalCases <> 0 THEN
                        NetPricing.Freight := FreightAmount;

                    NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";

                    // Single Net Price Calculation
                    NetPricing."Single Net Price" :=
                      NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                    //No COGA
                    IF NetPricing."Single Net Price" < SalesSetup."No COGA" THEN
                        NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";

                    // Calculate Brokerage
                    TempSalesInvoiceLine.CALCFIELDS("Header Broker 1", "Header Salesperson Code");

                    SalespersonCommision."Salesperson Code" := TempSalesInvoiceLine."Header Broker 1";
                    SalespersonCommision."Item No." := TempSalesInvoiceLine."No.";
                    SalespersonCommision."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";

                    IF Broker.GET(TempSalesInvoiceLine."Header Broker 1") THEN
                        NetPricing."Broker Commission Percent" :=
                          NetPricing."Single Net Price" * 0.01 * FindCommisionRec.FindCommision(SalespersonCommision, TRUE);

                    //Double Net Price is Net Price minus Broker Commission
                    NetPricing."Double Net Price" := NetPricing."Single Net Price" - NetPricing."Broker Commission Percent";

                    // Calculate Sales Person Commision
                    SalespersonCommision."Salesperson Code" := TempSalesInvoiceLine."Header Salesperson Code";
                    SalespersonCommision."Item No." := TempSalesInvoiceLine."No.";
                    SalespersonCommision."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";

                    IF Salesperson.GET(TempSalesInvoiceLine."Header Salesperson Code") THEN
                        NetPricing."Sales Commission Percent" :=
                          NetPricing."Double Net Price" * 0.01 * FindCommisionRec.FindCommision(SalespersonCommision, FALSE);

                    //Triple Net Price is Double Net Price minus Salesperson Commission
                    NetPricing."Triple Net Price" := NetPricing."Double Net Price" - NetPricing."Sales Commission Percent";

                    NetPricing.INSERT();
                    LastEntryNo += 1;

                UNTIL EndUser.NEXT() = 0;

                IF CatchupCases <> 0 THEN BEGIN
                    NetPricing.INIT();
                    NetPricing."Entry No." := LastEntryNo + 1;
                    NetPricing."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";

                    IF NOT enduser2.GET(TempSalesInvoiceLine."Sell-to Customer No." + '-"' + TempSalesInvoiceLine."Sell-to Customer No.") THEN BEGIN
                        enduser2."End User No." := TempSalesInvoiceLine."Sell-to Customer No." + '-"' + TempSalesInvoiceLine."Sell-to Customer No.";
                        enduser2."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";
                        enduser2.INSERT();
                    END;

                    NetPricing."End User No." := TempSalesInvoiceLine."Sell-to Customer No." + '-"' + TempSalesInvoiceLine."Sell-to Customer No.";
                    NetPricing."Item No." := TempSalesInvoiceLine."No.";

                    RebateLedgerEntries3.RESET();
                    RebateLedgerEntries3.SETRANGE("Customer Type", RebateLedgerEntries2."Customer Type"::Customer);
                    RebateLedgerEntries3.SETRANGE("No.", TempSalesInvoiceLine."Sell-to Customer No.");
                    RebateLedgerEntries3.SETRANGE("Date Claimed", LastYearDate, WORKDATE());

                    RebateLedgerEntries3.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::"Instant Credit");
                    RebateLedgerEntries3.CALCSUMS("Rebate Amount");
                    EndUserInstantRebate2 += RebateLedgerEntries3."Rebate Amount";

                    RebateLedgerEntries3.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Monthly);
                    RebateLedgerEntries3.CALCSUMS("Rebate Amount");
                    EndUserPODtRebate2 += RebateLedgerEntries3."Rebate Amount";

                    RebateLedgerEntries3.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Quarterly);
                    RebateLedgerEntries3.CALCSUMS("Rebate Amount");
                    EndUserMonthlyRebate2 += RebateLedgerEntries3."Rebate Amount";

                    RebateLedgerEntries3.SETRANGE("Rebate Type", RebateLedgerEntries."Rebate Type"::Annual);
                    RebateLedgerEntries3.CALCSUMS("Rebate Amount");
                    EndUserYearlyRebate2 += RebateLedgerEntries3."Rebate Amount";

                    IF TotalClaimedQty <> 0 THEN
                        NetPricing."End User Case Percent" := (CatchupCases / TotalClaimedQty) * 0.01;

                    //Rebate Information
                    NetPricing.Instant := NetPricing."End User Case Percent" * EndUserInstantRebate2;
                    NetPricing.POD := NetPricing."End User Case Percent" * EndUserPODtRebate2;
                    NetPricing.Quarterly := NetPricing."End User Case Percent" * EndUserMonthlyRebate2;
                    NetPricing.Annually := NetPricing."End User Case Percent" * EndUserYearlyRebate2;

                    // Calculate Base Price
                    IF TempSalesInvoiceLine.Quantity <> 0 THEN
                        NetPricing."Base Price Case" := TempSalesInvoiceLine."Unit Price";

                    // Calculate Freight
                    IF TotalCases <> 0 THEN
                        NetPricing.Freight := FreightAmount;

                    NetPricing."Case Cost Deduction" := SalesSetup."Case Cost Deduction";

                    // Single Net Price Calculation
                    NetPricing."Single Net Price" :=
                      NetPricing."Base Price Case" - NetPricing.Freight - (NetPricing.Instant + NetPricing.POD + NetPricing.Quarterly + NetPricing.Annually);

                    //No COGA
                    IF NetPricing."Single Net Price" < SalesSetup."No COGA" THEN
                        NetPricing."Single Net Price" -= SalesSetup."Case Cost Deduction";

                    // Caluclate Brokerage
                    SalespersonCommision."Salesperson Code" := TempSalesInvoiceLine."Header Broker 1";
                    SalespersonCommision."Item No." := TempSalesInvoiceLine."No.";
                    SalespersonCommision."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";

                    IF Broker.GET(TempSalesInvoiceLine."Header Broker 1") THEN
                        NetPricing."Broker Commission Percent" :=
                          NetPricing."Single Net Price" * 0.01 * FindCommisionRec.FindCommision(SalespersonCommision, TRUE);

                    //Double Net Price is Net Price minus Broker Commission
                    NetPricing."Double Net Price" := NetPricing."Single Net Price" - NetPricing."Broker Commission Percent";

                    // Calculate Sales Person Commision
                    SalespersonCommision."Salesperson Code" := TempSalesInvoiceLine."Header Salesperson Code";
                    SalespersonCommision."Item No." := TempSalesInvoiceLine."No.";
                    SalespersonCommision."Customer No." := TempSalesInvoiceLine."Sell-to Customer No.";

                    IF Salesperson.GET(TempSalesInvoiceLine."Header Salesperson Code") THEN
                        NetPricing."Sales Commission Percent" :=
                          NetPricing."Double Net Price" * 0.01 * FindCommisionRec.FindCommision(SalespersonCommision, FALSE);

                    //Triple Net Price is Double Net Price minus Salesperson Commission
                    NetPricing."Triple Net Price" := NetPricing."Double Net Price" - NetPricing."Sales Commission Percent";

                    NetPricing.INSERT();
                    LastEntryNo += 1;
                END;
            end;

            trigger OnPreDataItem()
            begin
                TempSalesInvoiceLine.RESET();

                SETRANGE(Number, 1, TempSalesInvoiceLine.COUNT);
            end;
        }
        dataitem("Net Price"; "Net Price")
        {
            DataItemTableView = SORTING("Customer No.", "Item No.");

            trigger OnAfterGetRecord()
            begin
                IF PrevCustNo <> "Customer No." THEN BEGIN
                    IF PrevCustNo <> '' THEN BEGIN
                        TotalNetPrice."End User Case Percent" := TotalNetPrice."End User Case Percent" / OnLineNumber;
                        TotalNetPrice."Base Price Case" := TotalNetPrice."Base Price Case" / OnLineNumber;
                        TotalNetPrice.Freight := TotalNetPrice.Freight / OnLineNumber;
                        TotalNetPrice.Instant := TotalNetPrice.Instant / OnLineNumber;
                        TotalNetPrice.POD := TotalNetPrice.POD / OnLineNumber;
                        TotalNetPrice.Quarterly := TotalNetPrice.Quarterly / OnLineNumber;
                        TotalNetPrice.Annually := TotalNetPrice.Annually / OnLineNumber;
                        TotalNetPrice."Broker Commission Percent" := TotalNetPrice."Broker Commission Percent" / OnLineNumber;
                        TotalNetPrice."Sales Commission Percent" := TotalNetPrice."Sales Commission Percent" / OnLineNumber;
                        TotalNetPrice."Single Net Price" := TotalNetPrice."Single Net Price" / OnLineNumber;
                        TotalNetPrice."Double Net Price" := TotalNetPrice."Double Net Price" / OnLineNumber;
                        TotalNetPrice."Triple Net Price" := TotalNetPrice."Triple Net Price" / OnLineNumber;
                        TotalNetPrice.INSERT();
                    END;

                    OnLineNumber := 1;

                    TotalNetPrice.INIT();
                    TotallastEntryNo := TotallastEntryNo + 1;
                    TotalNetPrice."Entry No." := TotallastEntryNo;
                    TotalNetPrice."Customer No." := "Customer No.";
                    TotalNetPrice."End User Case Percent" := NetPricing."End User Case Percent";
                    TotalNetPrice."Base Price Case" := TotalNetPrice."Base Price Case";
                    TotalNetPrice.Freight := NetPricing.Freight;
                    TotalNetPrice.Instant := NetPricing.Instant;
                    TotalNetPrice.POD := NetPricing.POD;
                    TotalNetPrice.Quarterly := NetPricing.Quarterly;
                    TotalNetPrice.Annually := NetPricing.Annually;
                    TotalNetPrice."Broker Commission Percent" := NetPricing."Broker Commission Percent";
                    TotalNetPrice."Sales Commission Percent" := NetPricing."Sales Commission Percent";
                    TotalNetPrice."Single Net Price" := NetPricing."Single Net Price";
                    TotalNetPrice."Double Net Price" := NetPricing."Double Net Price";
                    TotalNetPrice."Triple Net Price" := NetPricing."Triple Net Price";
                END ELSE BEGIN
                    TotalNetPrice."End User Case Percent" := TotalNetPrice."End User Case Percent" + NetPricing."End User Case Percent";
                    TotalNetPrice."Base Price Case" := TotalNetPrice."Base Price Case" + TotalNetPrice."Base Price Case";
                    TotalNetPrice.Freight := TotalNetPrice.Freight + NetPricing.Freight;
                    TotalNetPrice.Instant := TotalNetPrice.Instant + NetPricing.Instant;
                    TotalNetPrice.POD := TotalNetPrice.POD + NetPricing.POD;
                    TotalNetPrice.Quarterly := TotalNetPrice.Quarterly + NetPricing.Quarterly;
                    TotalNetPrice.Annually := TotalNetPrice.Annually + NetPricing.Annually;
                    TotalNetPrice."Broker Commission Percent" := TotalNetPrice."Broker Commission Percent" + NetPricing."Broker Commission Percent";
                    TotalNetPrice."Sales Commission Percent" := TotalNetPrice."Sales Commission Percent" + NetPricing."Sales Commission Percent";
                    TotalNetPrice."Single Net Price" := TotalNetPrice."Single Net Price" + NetPricing."Single Net Price";
                    TotalNetPrice."Double Net Price" := TotalNetPrice."Double Net Price" + NetPricing."Double Net Price";
                    TotalNetPrice."Triple Net Price" := TotalNetPrice."Triple Net Price" + NetPricing."Triple Net Price";

                    OnLineNumber := OnLineNumber + 1;
                END;

                PrevCustNo := "Customer No.";
            end;

            trigger OnPostDataItem()
            begin
                TotalNetPrice.INIT();
                TotalNetPrice."Entry No." := TotallastEntryNo + 1;
                TotalNetPrice."Customer No." := "Net Price"."Customer No.";
                TotalNetPrice."End User Case Percent" := NetPricing."End User Case Percent" / OnLineNumber;
                TotalNetPrice."Base Price Case" := TotalNetPrice."Base Price Case" / OnLineNumber;
                TotalNetPrice.Freight := NetPricing.Freight / OnLineNumber;
                TotalNetPrice.Instant := NetPricing.Instant / OnLineNumber;
                TotalNetPrice.POD := NetPricing.POD / OnLineNumber;
                TotalNetPrice.Quarterly := NetPricing.Quarterly / OnLineNumber;
                TotalNetPrice.Annually := NetPricing.Annually / OnLineNumber;
                TotalNetPrice."Broker Commission Percent" := NetPricing."Broker Commission Percent" / OnLineNumber;
                TotalNetPrice."Sales Commission Percent" := NetPricing."Sales Commission Percent" / OnLineNumber;
                TotalNetPrice."Single Net Price" := NetPricing."Single Net Price" / OnLineNumber;
                TotalNetPrice."Double Net Price" := NetPricing."Double Net Price" / OnLineNumber;
                TotalNetPrice."Triple Net Price" := NetPricing."Triple Net Price" / OnLineNumber;
                TotalNetPrice.INSERT();
            end;

            trigger OnPreDataItem()
            begin
                OnLineNumber := 0;

                TotalNetPrice.RESET();
                TotalNetPrice.DELETEALL();

                PrevCustNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        IF GUIALLOWED THEN
            Window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text001Lbl);
    end;

    var
        EndUser: Record "End User";
        enduser2: Record "End User";
        NetPricing: Record "Net Price";
        LastNetPricing: Record "Net Price";
        TotalNetPrice: Record "Total Net Price";
        LastTotalNetPricing: Record "Total Net Price";
        SalesInvHeader: Record "Sales Invoice Header";
        //SalesInvoiceLine: Record "Sales Invoice Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        Broker: Record "Salesperson/Purchaser";
        Salesperson: Record "Salesperson/Purchaser";
        //RebateEndUser: Record "Rebate Program - End User";
        SalesHistory: Record "Sales Info.";
        SalespersonCommision: Record "Sales Commision Setup";
        RebateLedgerEntries: Record "Rebate Ledger Entries";
        RebateLedgerEntries2: Record "Rebate Ledger Entries";
        RebateLedgerEntries3: Record "Rebate Ledger Entries";
        FindCommisionRec: Codeunit "Find Commision";
        Window: Dialog;
        TotalCases: Decimal;
        FreightAmount: Decimal;
        // SPPercent: Decimal;
        // BrokerPercent: Decimal;
        TotalClaimedQty: Decimal;
        EndUserInstantRebate: Decimal;
        EndUserPODtRebate: Decimal;
        EndUserMonthlyRebate: Decimal;
        EndUserYearlyRebate: Decimal;
        EndUserInstantRebate2: Decimal;
        EndUserPODtRebate2: Decimal;
        EndUserMonthlyRebate2: Decimal;
        EndUserYearlyRebate2: Decimal;
        CatchupCases: Decimal;
        LastEntryNo: Integer;
        TotallastEntryNo: Integer;
        OnLineNumber: Integer;
        PrevCustNo: Code[20];
        LastYearDate: Date;
        NextLineNo: Integer;
        Text001Lbl: Label 'Processing...\Customer No. #1##########\Item No.    #2##########', Comment = '%1 Customer No. %2 Item No.';
}

