report 50004 "PNP Daily Totals"
{
    // SSC17 - 20100601 - "Daily PNP Report"
    //   Added 2 fields in Request Form and some codes
    // 
    // //SSC67 - 20101103 - "PNP Daily updates"

    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending);
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Sales Amount (Actual)";
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    /*PostingDate := "Item Ledger Entry"."Posting Date";
                    //CLEAR(Amounts);
                    TotalUpSales;
                    HippoSales;*/
                    CLEAR(Customer);

                    Item.INIT();
                    Item.GET("Item No.");

                    IF Item."Routing No." = 'REPRO' THEN
                        CurrReport.SKIP();

                    IF Item."Routing No." = 'PULL-N-PAK' THEN BEGIN
                        Found := FALSE;

                        //SAFEWAY >>>>>>>>>> BEGIN
                        Position := 0;

                        ////SSC67 - 20101103 Start
                        /*Position := STRPOS("Item Ledger Entry"."Source No.",'SAF');*/
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'JOS');
                        ////SSC67 - 20101103 End

                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[1] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[1] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;

                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'CPS');
                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[1] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[1] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;

                        //SAFEWAY <<<<<<< END

                        //KROGER >>>>>>>>>>>>> BEGIN
                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'KRO');
                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;

                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'PEY');
                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;

                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'FRY');
                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[2] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;
                        //KROGER <<<<<<<<< END

                        //BUNZL >>>>> BEGIN
                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'BUN');
                        IF Position <> 0 THEN BEGIN
                            IF ("Item Ledger Entry"."Source No." <> 'BUN57') THEN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[3] += ROUND(-"Item Ledger Entry".Quantity, 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[3] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                       * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;
                        //BUNZL <<<< END

                        //WALMART >>>>>>> BEGIN
                        Position := 0;
                        Position := STRPOS("Item Ledger Entry"."Source No.", 'WAL');
                        IF Position <> 0 THEN BEGIN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[4] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[4] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                   * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            Found := TRUE;
                        END;
                        //WALMART <<<<<< END

                        IF Found = FALSE THEN BEGIN
                            Customer.INIT();
                            IF Customer.GET("Item Ledger Entry"."Source No.") THEN
                                IF Customer."Global Dimension 2 Code" = 'EXPOR' THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[7] += ROUND(-"Item Ledger Entry".Quantity, 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[7] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                           * Item."Rolls/Bundles per Case" / AdjCases, 1)
                                ELSE
                                    IF ("Item Ledger Entry"."Source No." <> 'OHM01')
                                 AND ("Item Ledger Entry"."Source No." <> 'SLL01') THEN
                                        //SSC17 - 20100601 Start
                                        IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            Amounts[5] += ROUND(-"Item Ledger Entry".Quantity, 1)
                                        ELSE //SSC17 - 20100601 End
                                            Amounts[5] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                             * Item."Rolls/Bundles per Case" / AdjCases, 1);
                        END;
                        IF Customer."Global Dimension 2 Code" <> 'EXPOR' THEN
                            IF ("Item Ledger Entry"."Source No." <> 'OHM01')
                              AND ("Item Ledger Entry"."Source No." <> 'SLL01') THEN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[6] += ROUND(-"Item Ledger Entry".Quantity, 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[6] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                       * Item."Rolls/Bundles per Case" / AdjCases, 1);

                    END
                    //SCSFN 020108 DELETE
                    /*
                    ELSE IF Item."Routing No." <> 'REPRO' THEN
                      IF (Item."Routing No." = 'HIPPO SAK CONV') THEN
                        //SSC17 - 20100601 Start
                        IF QtyInActualCase  THEN
                          Amounts[8] += ROUND(-"Item Ledger Entry".Quantity,1)
                        else //SSC17 - 20100601 End
                          Amounts[8] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                             * Item."Rolls/Bundles per Case" / AdjCases, 1);
                    */
                    //SCSFN 020108 DELETE END
                    ELSE
                        IF STRPOS(Item."No.", 'T') = 1 THEN
                            //SSC17 - 20100601 Start
                            IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                Amounts[8] += ROUND(-"Item Ledger Entry".Quantity, 1)
                            ELSE //SSC17 - 20100601 End
                                Amounts[8] += ROUND(-"Item Ledger Entry".Quantity * Item."Bags per Roll/Bundle"
                                              * Item."Rolls/Bundles per Case" / AdjCases2, 1);


                    /* IF PrintToExcel THEN BEGIN

                       RowNo += 1;
                       EnterCell(RowNo,1,FORMAT(Date2."Period Start"),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,2,FORMAT(Amounts[1]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,3,FORMAT(Amounts[2]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,4,FORMAT(Amounts[3]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,5,FORMAT(Amounts[4]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,6,FORMAT(Amounts[5]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,7,FORMAT(Amounts[6]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,8,FORMAT((100/Formula) * Amounts[6]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,9,FORMAT(Amounts[7]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,10,FORMAT(Amounts[6]+Amounts[7]),FALSE,FALSE,FALSE);
                       EnterCell(RowNo,11,FORMAT(Amounts[8]),FALSE,FALSE,FALSE);
                     END;    */

                end;

                trigger OnPostDataItem()
                begin
                    IF PrintToExcel THEN BEGIN
                        IF Date2."Period Start" = AsofDate THEN
                            IF NOT PNPDaily.GET(Date2."Period Start") THEN BEGIN
                                PNPDaily.INIT();
                                PNPDaily.Date := Date2."Period Start";
                                PNPDaily.Safeway := Amounts[1];
                                PNPDaily.Kroger := Amounts[2];
                                PNPDaily.Bunzl := Amounts[3];
                                PNPDaily.Walmart := Amounts[4];
                                PNPDaily.Others := Amounts[5];
                                PNPDaily.Domestic := Amounts[6];
                                PNPDaily."Project Total" := 100 / Formula2 * Amounts[6];
                                PNPDaily.Export := Amounts[7];
                                PNPDaily.Totals := Amounts[6] + Amounts[7];
                                PNPDaily."Hippo Sak" := Amounts[8];
                                PNPDaily.INSERT();
                            END ELSE
                                PNPDaily.Safeway := Amounts[1];
                        PNPDaily.Kroger := Amounts[2];
                        PNPDaily.Bunzl := Amounts[3];
                        PNPDaily.Walmart := Amounts[4];
                        PNPDaily.Others := Amounts[5];
                        PNPDaily.Domestic := Amounts[6];
                        PNPDaily."Project Total" := 100 / Formula2 * Amounts[6];
                        PNPDaily.Export := Amounts[7];
                        PNPDaily.Totals := Amounts[6] + Amounts[7];
                        PNPDaily."Hippo Sak" := Amounts[8];
                        PNPDaily.MODIFY();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry Type", "Entry Type"::Sale);

                    PostingDate := Date2."Period Start";
                    SETRANGE("Posting Date", Date2."Period Start");

                    itemLedgerEntryRec.INIT();
                    itemLedgerEntryRec.RESET();
                    itemLedgerEntryRec.COPYFILTERS("Item Ledger Entry");
                    //TempitemLedgerEntry.SETRANGE("Entry Type",TempitemLedgerEntry."Entry Type"::Sale);
                    //TempitemLedgerEntry.SETRANGE("Posting Date",Date2."Period Start");
                    itemLedgerEntryRec.SETCURRENTKEY("Posting Date"); //SSC17 - 20100601
                    IF NOT itemLedgerEntryRec.FIND('-') THEN BEGIN
                        IF PrintToExcel THEN
                            /*RowNo += 1;
                            EnterCell(RowNo,1,FORMAT(Date2."Period Start"),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,2,FORMAT(Amounts[1]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,3,FORMAT(Amounts[2]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,4,FORMAT(Amounts[3]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,5,FORMAT(Amounts[4]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,6,FORMAT(Amounts[5]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,7,FORMAT(Amounts[6]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,8,FORMAT((100/Formula) * Amounts[6]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,9,FORMAT(Amounts[7]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,10,FORMAT(Amounts[6]+Amounts[7]),FALSE,FALSE,FALSE);
                            EnterCell(RowNo,11,FORMAT(Amounts[8]),FALSE,FALSE,FALSE);*/
                            IF Date2."Period Start" = AsofDate THEN
                                IF NOT PNPDaily.GET(Date2."Period Start") THEN BEGIN
                                    PNPDaily.INIT();
                                    PNPDaily.Date := Date2."Period Start";
                                    PNPDaily.Safeway := Amounts[1];
                                    PNPDaily.Kroger := Amounts[2];
                                    PNPDaily.Bunzl := Amounts[3];
                                    PNPDaily.Walmart := Amounts[4];
                                    PNPDaily.Others := Amounts[5];
                                    PNPDaily.Domestic := Amounts[6];
                                    PNPDaily."Project Total" := 100 / Formula2 * Amounts[6];
                                    PNPDaily.Export := Amounts[7];
                                    PNPDaily.Totals := Amounts[6] + Amounts[7];
                                    PNPDaily."Hippo Sak" := Amounts[8];
                                    PNPDaily.INSERT();
                                END ELSE
                                    PNPDaily.Safeway := Amounts[1];
                        PNPDaily.Kroger := Amounts[2];
                        PNPDaily.Bunzl := Amounts[3];
                        PNPDaily.Walmart := Amounts[4];
                        PNPDaily.Others := Amounts[5];
                        PNPDaily.Domestic := Amounts[6];
                        PNPDaily."Project Total" := 100 / Formula2 * Amounts[6];
                        PNPDaily.Export := Amounts[7];
                        PNPDaily.Totals := Amounts[6] + Amounts[7];
                        PNPDaily."Hippo Sak" := Amounts[8];
                        PNPDaily.MODIFY();
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //CLEAR(Amounts);
                DateCounter += 1;

                CASE DateCounter OF
                    1:
                        Formula := 32.4;
                    2:
                        Formula := 34.7;
                    3:
                        Formula := 36;
                    4:
                        Formula := 41.1;
                    5:
                        Formula := 43.6;
                    6:
                        Formula := 47.2;
                    7:
                        Formula := 52.3;
                    8:
                        Formula := 54.5;
                    9:
                        Formula := 57.5;
                    10:
                        Formula := 61;
                    11:
                        Formula := 63.6;
                    12:
                        Formula := 66;
                    13:
                        Formula := 69.2;
                    14:
                        Formula := 74.2;
                    15:
                        Formula := 75.9;
                    16:
                        Formula := 78;
                    17:
                        Formula := 81.7;
                    18:
                        Formula := 84.2;
                    19:
                        Formula := 86.6;
                    20:
                        Formula := 89.6;
                    21:
                        Formula := 90.9;
                    22:
                        Formula := 92.5;
                    23:
                        Formula := 93.7;
                    24:
                        Formula := 95.1;
                    25:
                        Formula := 97;
                    26:
                        Formula := 98.4;
                    27:
                        Formula := 100.1;
                    28:
                        Formula := 100.4;
                    29:
                        Formula := 100.9;
                    30:
                        Formula := 100.9;
                    31:
                        Formula := 100;
                END;

                IF FirstDate = FALSE THEN BEGIN
                    Date2.FIND('-');
                    FirstDate := TRUE;
                END
                ELSE
                    IF Date2.NEXT(1) = 0 THEN;
                TotalUpSales();
                HippoSales();
            end;

            trigger OnPreDataItem()
            begin
                PrintToExcel := TRUE;

                WorkCenter.GET('PULL-N-PAK');
                AdjCases := WorkCenter."Adj. Cases";
                WorkCenter2.GET('HIPPO SAK CONV');
                AdjCases2 := WorkCenter2."Adj. Cases";

                Date2.INIT();
                Date2.SETRANGE("Period Type", Date2."Period Type"::Date);
                Date2.SETRANGE("Period Start", StartDate, EndDate);
                //Date2.SETRANGE("Period End",EndDate);
                //IF Date2.FIND
                Counter := Date2.COUNT;

                SETRANGE(Number, 1, Counter);

                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    //SSC67 - 20101103 Start
                    /*EnterCell(RowNo,1,'Daily Totals PNP Bag Orders',TRUE,FALSE,TRUE);*/
                    EnterCell(RowNo, 1, 'Daily Totals', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, 'PNP Bag Orders', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    //SSC67 - 20101103 End

                    EnterCell(RowNo, 9, FORMAT(WORKDATE(), 0, 4), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 10, FORMAT(TIME), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                    RowNo += 2;
                    //SSC67 - 20101103 Start
                    /*EnterCell(RowNo,1,'Date Filters: ' + FORMAT(StartDate) + '..' + FORMAT(EndDate),TRUE,FALSE,TRUE);*/
                    EnterCell(RowNo, 1, 'Date Filters: ', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, FORMAT(StartDate) + '..', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(EndDate), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);


                    RowNo += 1;
                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                        EnterCell(RowNo, 1, 'Qty: Actual', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text)
                    ELSE
                        EnterCell(RowNo, 1, 'Qty: Adjusted', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    //SSC67 - 20101103 End


                    RowNo += 2;
                    EnterCell(RowNo, 1, 'Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                    //SSC67 - 20101103 Start
                    /*EnterCell(RowNo,2,'Safeway',TRUE,FALSE,TRUE);*/
                    EnterCell(RowNo, 2, 'Joshen', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    //SSC67 - 20101103 End

                    EnterCell(RowNo, 3, 'Kroger', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 4, 'Bunzl', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 5, 'Walmart', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 6, 'Others', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 7, 'Domestic', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 8, 'Projected Total', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 9, 'Export', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 10, 'Totals', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 11, 'Hippo Sak', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                END;

                DateCounter := 0;

                SalesHeader.INIT();
                SalesHeader.RESET();
                SalesHeader.SETFILTER("Order Date", '..%1', PreStartDate);
                SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
                IF SalesHeader.FIND('-') THEN
                    REPEAT
                        SalesLine.INIT();
                        SalesLine.RESET();
                        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        IF SalesLine.FIND('-') THEN
                            REPEAT
                                Item.INIT();
                                IF Item.GET(SalesLine."No.") THEN
                                    IF Item."Routing No." = 'PULL-N-PAK' THEN
                                        Found := FALSE;

                                ////SSC67 - 20101103 Start
                                /*//SAFEWAY >>>>>>>> BEGIN*/
                                //Joshen >>>>>>>> BEGIN
                                //SSC67 - 20101103 End

                                Position := 0;
                                ////SSC67 - 20101103 Start
                                /*Position := STRPOS(SalesHeader."Sell-to Customer No.",'SAF');*/
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'JOS');
                                ////SSC67 - 20101103 End
                                IF Position <> 0 THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[1] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[1] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;


                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'CPS');
                                IF Position <> 0 THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[1] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[1] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;

                                ////SSC67 - 20101103 Start
                                /*//SAFEWAY <<<<<<<<< END*/
                                //Joshen <<<<<<<<< END
                                //SSC67 - 20101103 End


                                //KROGER >>>>>>>>> BEGIN
                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'KRO');
                                IF Position <> 0 THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);

                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'PEY');
                                IF Position <> 0 THEN BEGIN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                    Found := TRUE;
                                END;

                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'FRY');
                                IF Position <> 0 THEN BEGIN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                    Found := TRUE;
                                END;

                                //KROGER <<<<<<<<<<< END

                                //BUNZL >>>>>> BEGIN
                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'BUN');
                                IF Position <> 0 THEN BEGIN
                                    IF (SalesHeader."Sell-to Customer No." <> 'BUN57') THEN
                                        //SSC17 - 20100601 Start
                                        IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            Amounts[3] += ROUND(SalesLine."Outstanding Quantity", 1)
                                        ELSE //SSC17 - 20100601 End
                                            Amounts[3] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                              * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                    Found := TRUE;
                                END;
                                //BUNZL <<<<<< END

                                //WALMART >>>>>> BEGIN
                                Position := 0;
                                Position := STRPOS(SalesHeader."Sell-to Customer No.", 'WAL');
                                IF Position <> 0 THEN BEGIN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[4] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[4] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                    Found := TRUE;
                                END;
                                //WALMART <<<<<< END

                                /*IF SalesHeader."Customer Posting Group" ='DOMESTIC' THEN BEGIN
                                  //SSC17 - 20100601 Start
                                  IF QtyInActualCase  THEN
                                    Amounts[6] += ROUND(SalesLine."Outstanding Quantity",1)
                                  else //SSC17 - 20100601 End
                                    Amounts[6] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                  Found := TRUE;
                                END;  */

                                IF SalesHeader."Shortcut Dimension 2 Code" = 'EXPOR' THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[7] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[7] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;

                                IF Found = FALSE THEN
                                    IF (SalesHeader."Sell-to Customer No." <> 'OHM01')
                                      AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                                        //SSC17 - 20100601 Start
                                        IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            Amounts[5] += ROUND(SalesLine."Outstanding Quantity", 1)
                                        ELSE //SSC17 - 20100601 End
                                            Amounts[5] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                              * Item."Rolls/Bundles per Case" / AdjCases, 1);

                                IF SalesHeader."Shortcut Dimension 2 Code" <> 'EXPOR' THEN
                                    IF (SalesHeader."Sell-to Customer No." <> 'OHM01')
                                      AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                                        //SSC17 - 20100601 Start
                                        IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            Amounts[6] += ROUND(SalesLine."Outstanding Quantity", 1)
                                        ELSE //SSC17 - 20100601 End
                                            Amounts[6] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                              * Item."Rolls/Bundles per Case" / AdjCases, 1);
                            UNTIL SalesLine.NEXT() = 0;
                    UNTIL SalesHeader.NEXT() = 0;

                SalesHeader.INIT();
                SalesHeader.RESET();
                SalesHeader.SETFILTER("Order Date", '..%1', PreStartDate);
                SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
                IF SalesHeader.FIND('-') THEN
                    REPEAT
                        IF (SalesHeader."Sell-to Customer No." <> 'OHM01') AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                            SalesLine.INIT();
                        SalesLine.RESET();
                        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        IF SalesLine.FIND('-') THEN
                            REPEAT
                                Item.INIT();
                                IF Item.GET(SalesLine."No.") THEN
                                    IF (Item."Routing No." = 'HIPPO SAK CONV') THEN
                                        Amounts[8] += SalesLine."Outstanding Quantity";

                            UNTIL SalesLine.NEXT() = 0;
                    UNTIL SalesHeader.NEXT() = 0;
            END;

        }
        dataitem("PNP Daily"; "PNP Daily")
        {
            DataItemTableView = SORTING("Date");

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                EnterCell(RowNo, 1, FORMAT(Date), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                /*
                EnterCell(RowNo,2,FORMAT(Safeway),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,3,FORMAT(Kroger),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,4,FORMAT(Bunzl),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,5,FORMAT(Walmart),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,6,FORMAT(Others),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,7,FORMAT(Domestic),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,8,FORMAT("Project Total"),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,9,FORMAT(Export),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,10,FORMAT(Totals),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo,11,FORMAT("Hippo Sak"),FALSE,FALSE,FALSE,'#,##0.00',TempExcelBuffer."Cell Type"::Number);
                */
                EnterCell(RowNo, 2, FORMAT(Safeway), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 3, FORMAT(Kroger), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 4, FORMAT(Bunzl), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 5, FORMAT(Walmart), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 6, FORMAT(Others), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 7, FORMAT(Domestic), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 8, FORMAT("Project Total"), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 9, FORMAT(Export), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 10, FORMAT(Totals), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                EnterCell(RowNo, 11, FORMAT("Hippo Sak"), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);

            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Date, StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Print To Excel"; PrintToExcel)
                    {
                        ToolTip = 'Specifies the value of the PrintToExcel field.';
                        ApplicationArea = all;
                        caption = 'Print To Excel';
                    }
                    field("Start Date"; StartDate)
                    {
                        ToolTip = 'Specifies the value of the StartDate field.';
                        ApplicationArea = all;
                        caption = 'Start Date';
                    }
                    field("End Date"; EndDate)
                    {
                        ToolTip = 'Specifies the value of the EndDate field.';
                        ApplicationArea = all;
                        caption = 'End Date';
                    }
                    field("As of Date"; AsofDate)
                    {
                        ToolTip = 'Specifies the value of the AsofDate field.';
                        ApplicationArea = all;
                        caption = 'As of Date';
                        trigger OnValidate()
                        begin
                            StartDate := CALCDATE('<-CM>', AsofDate);
                            EndDate := CALCDATE('<CM>', AsofDate);
                        end;
                    }
                    field("Qty In"; QtyIn)
                    {
                        ToolTip = 'Specifies the value of the QtyIn field.';
                        ApplicationArea = all;
                        caption = 'Qty In';
                        OptionCaption = 'Qty in Actual Case,Qty in Adjusted Case';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //SSC17 - 20100601 Start
            QtyIn := QtyIn::"Qty in Actual Case";
            //SSC17 - 20100601 End
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        AsofDate := TODAY;
        StartDate := CALCDATE('<-CM>', AsofDate);
        EndDate := CALCDATE('<CM>', AsofDate);
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            //  TempExcelBuffer.CreateBook('Daily Totals');
            //  TempExcelBuffer.UpdateBook('Daily Totals','Daily Totals');
            // TempExcelBuffer.GiveUserControl; charmee comment

            TempExcelBuffer.CreateNewBook('Daily Totals');
            TempExcelBuffer.WriteSheet('Daily Totals', CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.OpenExcel();
        END;
    end;

    trigger OnPreReport()
    begin
        PreStartDate := CALCDATE('<-1D>', StartDate);
        AsofDay := DATE2DMY(AsofDate, 1);
        CASE AsofDay OF
            1:
                Formula2 := 32.4;
            2:
                Formula2 := 34.7;
            3:
                Formula2 := 36;
            4:
                Formula2 := 41.1;
            5:
                Formula2 := 43.6;
            6:
                Formula2 := 47.2;
            7:
                Formula2 := 52.3;
            8:
                Formula2 := 54.5;
            9:
                Formula2 := 57.5;
            10:
                Formula2 := 61;
            11:
                Formula2 := 63.6;
            12:
                Formula2 := 66;
            13:
                Formula2 := 69.2;
            14:
                Formula2 := 74.2;
            15:
                Formula2 := 75.9;
            16:
                Formula2 := 78;
            17:
                Formula2 := 81.7;
            18:
                Formula2 := 84.2;
            19:
                Formula2 := 86.6;
            20:
                Formula2 := 89.6;
            21:
                Formula2 := 90.9;
            22:
                Formula2 := 92.5;
            23:
                Formula2 := 93.7;
            24:
                Formula2 := 95.1;
            25:
                Formula2 := 97;
            26:
                Formula2 := 98.4;
            27:
                Formula2 := 100.1;
            28:
                Formula2 := 100.4;
            29:
                Formula2 := 100.9;
            30:
                Formula2 := 100.9;
            31:
                Formula2 := 100;
        END;
    end;

    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        itemLedgerEntryRec: Record "Item Ledger Entry";
        WorkCenter: Record "Work Center";
        WorkCenter2: Record "Work Center";
        PNPDaily: Record "PNP Daily";
        Date2: Record Date;
        Amounts: array[8] of Decimal;
        Position: Integer;
        PostingDate: Date;
        Found: Boolean;
        TotalAmount: Decimal;
        PrintToExcel: Boolean;
        RowNo: Integer;
        StartDate: Date;
        EndDate: Date;
        PreStartDate: Date;
        Counter: Integer;
        FirstDate: Boolean;
        DateCounter: Integer;
        Formula: Decimal;
        AdjCases: Decimal;
        AdjCases2: Decimal;
        AsofDate: Date;
        AsofDay: Integer;
        Formula2: Decimal;
        QtyIn: Option "Qty in Actual Case","Qty in Adjusted Case";

    procedure TotalUpSales()
    begin
        SalesHeader.INIT();
        SalesHeader.RESET();
        SalesHeader.SETRANGE("Order Date", Date2."Period Start");
        SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
        IF SalesHeader.FIND('-') THEN
            REPEAT
                SalesLine.INIT();
                SalesLine.RESET();
                SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        Item.INIT();
                        IF Item.GET(SalesLine."No.") THEN BEGIN
                            IF Item."Routing No." = 'PULL-N-PAK' THEN
                                Found := FALSE;

                            //SAFEWAY >>>>>>>> BEGIN
                            Position := 0;

                            ////SSC67 - 20101103 Start
                            /*Position := STRPOS(SalesHeader."Sell-to Customer No.",'SAF');*/
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'JOS');
                            ////SSC67 - 20101103 End


                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[1] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[1] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;

                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'CPS');
                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[1] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[1] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;
                            //SAFEWAY <<<<<<<<< END

                            //KROGER >>>>>>>>> BEGIN
                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'KRO');
                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;

                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'PEY');
                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;

                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'FRY');
                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[2] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;

                            //KROGER <<<<<<<<<<< END

                            //BUNZL >>>>>> BEGIN
                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'BUN');
                            IF Position <> 0 THEN BEGIN
                                IF (SalesHeader."Sell-to Customer No." <> 'BUN57') THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[3] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[3] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;
                            //BUNZL <<<<<< END

                            //WALMART >>>>>> BEGIN
                            Position := 0;
                            Position := STRPOS(SalesHeader."Sell-to Customer No.", 'WAL');
                            IF Position <> 0 THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[4] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[4] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;
                            //WALMART <<<<<< END

                            /*IF SalesHeader."Customer Posting Group" ='DOMESTIC' THEN BEGIN
                              //SSC17 - 20100601 Start
                              IF QtyInActualCase  THEN
                                Amounts[6] += ROUND(SalesLine."Outstanding Quantity",1)
                              else //SSC17 - 20100601 End
                                Amounts[6] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                  * Item."Rolls/Bundles per Case" / AdjCases, 1);
                              Found := TRUE;
                            END;  */

                            IF SalesHeader."Shortcut Dimension 2 Code" = 'EXPOR' THEN BEGIN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[7] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[7] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                Found := TRUE;
                            END;

                            IF Found = FALSE THEN
                                IF (SalesHeader."Sell-to Customer No." <> 'OHM01')
                                  AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[5] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[5] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);

                            IF SalesHeader."Shortcut Dimension 2 Code" <> 'EXPOR' THEN
                                IF (SalesHeader."Sell-to Customer No." <> 'OHM01')
                                  AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                                    //SSC17 - 20100601 Start
                                    IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        Amounts[6] += ROUND(SalesLine."Outstanding Quantity", 1)
                                    ELSE //SSC17 - 20100601 End
                                        Amounts[6] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                          * Item."Rolls/Bundles per Case" / AdjCases, 1);
                        END;
                    UNTIL SalesLine.NEXT() = 0;
            UNTIL SalesHeader.NEXT() = 0;
    end;

    procedure HippoSales()
    begin
        SalesHeader.INIT();
        SalesHeader.RESET();
        SalesHeader.SETRANGE("Order Date", Date2."Period Start");
        SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
        IF SalesHeader.FIND('-') THEN
            REPEAT
                IF (SalesHeader."Sell-to Customer No." <> 'OHM01') AND (SalesHeader."Sell-to Customer No." <> 'SLL01') THEN
                    SalesLine.INIT();
                SalesLine.RESET();
                SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        Item.INIT();
                        IF Item.GET(SalesLine."No.") THEN
                            IF (Item."Routing No." = 'HIPPO SAK CONV') THEN
                                //SSC17 - 20100601 Start
                                IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                    Amounts[8] += ROUND(SalesLine."Outstanding Quantity", 1)
                                ELSE //SSC17 - 20100601 End
                                    Amounts[8] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle"
                                      * Item."Rolls/Bundles per Case" / AdjCases2, 1);
                    UNTIL SalesLine.NEXT() = 0;
            UNTIL SalesHeader.NEXT() = 0;
    END;

    local procedure EnterCell(RowNumber: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNumber);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := Format;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.INSERT();
    end;
}

