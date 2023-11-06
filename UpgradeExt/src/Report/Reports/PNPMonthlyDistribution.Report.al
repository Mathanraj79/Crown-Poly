report 50031 "PNP Monthly Distribution"
{
    // CP1004 16Jul2009 "1000 Pack Case"
    // CP1007 13Jan2010 "Change in Posting Date"
    // SSC66 - 20101109 - "Add Credit Memos to Monthly Reports"
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\PNPMonthlyDistribution.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'PNP Monthly Distribution';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = Broker, "Salesperson Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(CaseDisplay; CaseDisplay)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CompleteMonths; CompleteMonths)
            {
            }
            column(MonthlyTotals_1_; MonthlyTotals[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_2_; MonthlyTotals[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_3_; MonthlyTotals[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_4_; MonthlyTotals[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_5_; MonthlyTotals[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_6_; MonthlyTotals[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_7_; MonthlyTotals[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_8_; MonthlyTotals[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_9_; MonthlyTotals[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_10_; MonthlyTotals[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_11_; MonthlyTotals[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyTotals_12_; MonthlyTotals[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YTDTotals; YTDTotals)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthlyAvg; MonthlyAvg)
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_12_; YearlyTotals[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_11_; YearlyTotals[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_10_; YearlyTotals[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_9_; YearlyTotals[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_8_; YearlyTotals[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_7_; YearlyTotals[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_6_; YearlyTotals[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_5_; YearlyTotals[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_4_; YearlyTotals[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_3_; YearlyTotals[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_2_; YearlyTotals[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(YearlyTotals_1_; YearlyTotals[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(FORMAT_StartDate_4___YEAR4________Totals_; FORMAT(StartDate, 4, '<YEAR4>') + ' Totals')
            {
            }
            column(PrevYearlyTotals_12_; PrevYearlyTotals[12])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_11_; PrevYearlyTotals[11])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_10_; PrevYearlyTotals[10])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_9_; PrevYearlyTotals[9])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_8_; PrevYearlyTotals[8])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_7_; PrevYearlyTotals[7])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_6_; PrevYearlyTotals[6])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_5_; PrevYearlyTotals[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_4_; PrevYearlyTotals[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_3_; PrevYearlyTotals[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_2_; PrevYearlyTotals[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYearlyTotals_1_; PrevYearlyTotals[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(FORMAT_CALCDATE___1Y___StartDate__4___YEAR4________Totals_; FORMAT(CALCDATE('<-1Y>', StartDate), 4, '<YEAR4>') + ' Totals')
            {
            }
            column(Percentage_Inc_Dec_; 'Percentage Inc/Dec')
            {
            }
            column(YTDIncrease; YTDIncrease)
            {
                DecimalPlaces = 2 : 2;
            }
            column(AvgIncrease; AvgIncrease)
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_1_; YearlyIncrease[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_2_; YearlyIncrease[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_3_; YearlyIncrease[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_4_; YearlyIncrease[4])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_5_; YearlyIncrease[5])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_6_; YearlyIncrease[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_7_; YearlyIncrease[7])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_8_; YearlyIncrease[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_9_; YearlyIncrease[9])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_10_; YearlyIncrease[10])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_11_; YearlyIncrease[11])
            {
                DecimalPlaces = 2 : 2;
            }
            column(YearlyIncrease_12_; YearlyIncrease[12])
            {
                DecimalPlaces = 2 : 2;
            }
            column(AllYTDTotals; AllYTDTotals)
            {
                DecimalPlaces = 0 : 0;
            }
            column(AllMonthlyAvg; AllMonthlyAvg)
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevYTDTotals; PrevYTDTotals)
            {
                DecimalPlaces = 0 : 0;
            }
            column(PrevMonthlyAvg; PrevMonthlyAvg)
            {
                DecimalPlaces = 0 : 0;
            }
            column(PNP_Monthly_Distribution_ReportCaption; PNP_Monthly_Distribution_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(JANCaption; JANCaptionLbl)
            {
            }
            column(FEBCaption; FEBCaptionLbl)
            {
            }
            column(MARCaption; MARCaptionLbl)
            {
            }
            column(APRCaption; APRCaptionLbl)
            {
            }
            column(MAYCaption; MAYCaptionLbl)
            {
            }
            column(JUNCaption; JUNCaptionLbl)
            {
            }
            column(JULCaption; JULCaptionLbl)
            {
            }
            column(AUGCaption; AUGCaptionLbl)
            {
            }
            column(SEPCaption; SEPCaptionLbl)
            {
            }
            column(OCTCaption; OCTCaptionLbl)
            {
            }
            column(NOVCaption; NOVCaptionLbl)
            {
            }
            column(DECCaption; DECCaptionLbl)
            {
            }
            column(YTDCaption; YTDCaptionLbl)
            {
            }
            column(AVGCaption; AVGCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(MonthlyTotals);
                YTDTotals := 0;
                PrevYTDTotals := 0;
                BegDate := StartDate;
                EndDate := CALCDATE('<+1M-1D>', BegDate);

                FOR i := 1 TO 12 DO BEGIN
                    recSales.INIT();

                    //CP1007 13Jan2010 Start
                    recSales.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code");
                    //CP1007 13Jan2010 End

                    recSales.SETFILTER("Sell-to Customer No.", '''' + Customer."No." + '''');

                    //CP1007 13Jan2010 Start
                    recSales.SETRANGE("Posting Date", BegDate, EndDate);
                    //CP1007 13Jan2010 End

                    recSales.SETFILTER("Shortcut Dimension 1 Code", 'PNP');
                    IF recSales.FIND('-') THEN
                        REPEAT
                            recItem.INIT();
                            IF recItem.GET(recSales."No.") THEN
                                //CP1004 16Jul2009 Start
                                IF CaseDisplay = CaseDisplay::"1000 Per Case" THEN
                                    MonthlyTotals[i] += ROUND(recSales.Quantity * recItem."Bags per Roll/Bundle"
                                      * recItem."Rolls/Bundles per Case" / AdjCases, 1)
                                ELSE
                                    MonthlyTotals[i] += ROUND(recSales.Quantity, 1);
                        //CP1004 16Jul2009 End
                        UNTIL recSales.NEXT() = 0;

                    //SSC66 - 20101109 Start
                    //**** sales calculation for credit memo ****//
                    recCrMemo.INIT();
                    recCrMemo.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code");
                    recCrMemo.SETFILTER("Sell-to Customer No.", '''' + Customer."No." + '''');
                    recCrMemo.SETRANGE("Posting Date", BegDate, EndDate);
                    recCrMemo.SETFILTER("Shortcut Dimension 1 Code", 'PNP');
                    IF recCrMemo.FIND('-') THEN
                        REPEAT
                            IF recItem.GET(recCrMemo."No.") THEN
                                IF CaseDisplay = CaseDisplay::"1000 Per Case" THEN
                                    MonthlyTotals[i] -= ROUND(recCrMemo.Quantity * recItem."Bags per Roll/Bundle"
                                      * recItem."Rolls/Bundles per Case" / AdjCases, 1)
                                ELSE
                                    MonthlyTotals[i] -= ROUND(recCrMemo.Quantity, 1);

                        UNTIL recCrMemo.NEXT() = 0;
                    //SSC66 - 20101109 End


                    YearlyTotals[i] += MonthlyTotals[i];
                    IF i <= CompleteMonths THEN
                        YTDTotals += MonthlyTotals[i];
                    BegDate := CALCDATE('<+1D>', EndDate);
                    EndDate := CALCDATE('<+1M-1D>', BegDate);
                END;
                AllYTDTotals += YTDTotals;
                MonthlyAvg := YTDTotals / CompleteMonths;


                BegDate := CALCDATE('<-1Y>', StartDate);
                EndDate := CALCDATE('<+1M-1D>', BegDate);
                FOR i := 1 TO 12 DO BEGIN
                    recSales.INIT();

                    //CP1007 13Jan2010 Start
                    recSales.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code");
                    //CP1007 13Jan2010 End

                    recSales.SETFILTER("Sell-to Customer No.", '''' + Customer."No." + '''');

                    //CP1007 13Jan2010 Start
                    recSales.SETRANGE("Posting Date", BegDate, EndDate);
                    //CP1007 13Jan2010 End

                    recSales.SETFILTER("Shortcut Dimension 1 Code", 'PNP');
                    IF recSales.FIND('-') THEN
                        REPEAT
                            recItem.INIT();
                            IF recItem.GET(recSales."No.") THEN
                                //CP1004 16Jul2009 Start
                                IF CaseDisplay = CaseDisplay::"1000 Per Case" THEN
                                    PrevYearlyTotals[i] += ROUND(recSales.Quantity * recItem."Bags per Roll/Bundle"
                                      * recItem."Rolls/Bundles per Case" / AdjCases, 1)
                                ELSE
                                    PrevYearlyTotals[i] += ROUND(recSales.Quantity, 1);
                        //CP1004 16Jul2009 End
                        UNTIL recSales.NEXT() = 0;


                    //SSC66 - 20101109 Start
                    //**** sales calculation for credit memo ****//
                    recCrMemo.INIT();
                    recCrMemo.SETCURRENTKEY("Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code");
                    recCrMemo.SETFILTER("Sell-to Customer No.", '''' + Customer."No." + '''');
                    recCrMemo.SETRANGE("Posting Date", BegDate, EndDate);
                    recCrMemo.SETFILTER("Shortcut Dimension 1 Code", 'PNP');
                    IF recCrMemo.FINDSET() THEN
                        REPEAT
                            IF recItem.GET(recCrMemo."No.") THEN
                                IF CaseDisplay = CaseDisplay::"1000 Per Case" THEN
                                    PrevYearlyTotals[i] -= ROUND(recCrMemo.Quantity * recItem."Bags per Roll/Bundle"
                                      * recItem."Rolls/Bundles per Case" / AdjCases, 1)
                                ELSE
                                    PrevYearlyTotals[i] -= ROUND(recCrMemo.Quantity, 1);

                        UNTIL recCrMemo.NEXT() = 0;


                    //SSC66 - 20101109 End
                    IF i <= CompleteMonths THEN
                        PrevYTDTotals += PrevYearlyTotals[i];

                    BegDate := CALCDATE('<+1D>', EndDate);
                    EndDate := CALCDATE('<+1M-1D>', BegDate);
                END;

                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, Customer."No.", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, Customer.Name, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(MonthlyTotals[1]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 4, FORMAT(MonthlyTotals[2]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 5, FORMAT(MonthlyTotals[3]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 6, FORMAT(MonthlyTotals[4]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 7, FORMAT(MonthlyTotals[5]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 8, FORMAT(MonthlyTotals[6]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 9, FORMAT(MonthlyTotals[7]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 10, FORMAT(MonthlyTotals[8]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 11, FORMAT(MonthlyTotals[9]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 12, FORMAT(MonthlyTotals[10]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 13, FORMAT(MonthlyTotals[11]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 14, FORMAT(MonthlyTotals[12]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 15, FORMAT(YTDTotals), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 16, FORMAT(MonthlyAvg), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                END;
            end;

            trigger OnPostDataItem()
            begin
                //FOR i := 1 TO CompleteMonths DO BEGIN
                //    PrevYTDTotals += PrevYearlyTotals[i];
                //END;
                PrevMonthlyAvg := PrevYTDTotals / CompleteMonths;
                AllMonthlyAvg := AllYTDTotals / CompleteMonths;
                FOR i := 1 TO 12 DO BEGIN
                    IF PrevYearlyTotals[i] <> 0 THEN
                        YearlyIncrease[i] := YearlyTotals[i] / PrevYearlyTotals[i] - 1
                    ELSE
                        YearlyIncrease[i] := 0;
                    YearlyIncrease[i] := YearlyIncrease[i] * 100;
                END;
                IF PrevYTDTotals <> 0 THEN
                    YTDIncrease := AllYTDTotals / PrevYTDTotals - 1
                ELSE
                    YTDIncrease := 0;
                IF PrevMonthlyAvg <> 0 THEN
                    AvgIncrease := AllMonthlyAvg / PrevMonthlyAvg - 1
                ELSE
                    AvgIncrease := 0;
                YTDIncrease := YTDIncrease * 100;
                AvgIncrease := AvgIncrease * 100;

                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 2, FORMAT(StartDate, 4, '<YEAR4>') + ' Totals', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(YearlyTotals[1]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 4, FORMAT(YearlyTotals[2]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 5, FORMAT(YearlyTotals[3]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 6, FORMAT(YearlyTotals[4]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 7, FORMAT(YearlyTotals[5]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 8, FORMAT(YearlyTotals[6]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 9, FORMAT(YearlyTotals[7]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 10, FORMAT(YearlyTotals[8]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 11, FORMAT(YearlyTotals[9]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 12, FORMAT(YearlyTotals[10]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 13, FORMAT(YearlyTotals[11]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 14, FORMAT(YearlyTotals[12]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 15, FORMAT(AllYTDTotals), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 16, FORMAT(AllMonthlyAvg), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

                    RowNo += 1;
                    EnterCell(RowNo, 2, FORMAT(CALCDATE('<-1Y>', StartDate), 4, '<YEAR4>') + ' Totals', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(PrevYearlyTotals[1]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 4, FORMAT(PrevYearlyTotals[2]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 5, FORMAT(PrevYearlyTotals[3]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 6, FORMAT(PrevYearlyTotals[4]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 7, FORMAT(PrevYearlyTotals[5]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 8, FORMAT(PrevYearlyTotals[6]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 9, FORMAT(PrevYearlyTotals[7]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 10, FORMAT(PrevYearlyTotals[8]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 11, FORMAT(PrevYearlyTotals[9]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 12, FORMAT(PrevYearlyTotals[10]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 13, FORMAT(PrevYearlyTotals[11]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 14, FORMAT(PrevYearlyTotals[12]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 15, FORMAT(PrevYTDTotals), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 16, FORMAT(PrevMonthlyAvg), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

                    RowNo += 1;
                    EnterCell(RowNo, 2, 'Percentage Inc/Dec', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, FORMAT(YearlyIncrease[1]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 4, FORMAT(YearlyIncrease[2]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 5, FORMAT(YearlyIncrease[3]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 6, FORMAT(YearlyIncrease[4]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 7, FORMAT(YearlyIncrease[5]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 8, FORMAT(YearlyIncrease[6]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 9, FORMAT(YearlyIncrease[7]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 10, FORMAT(YearlyIncrease[8]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 11, FORMAT(YearlyIncrease[9]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 12, FORMAT(YearlyIncrease[10]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 13, FORMAT(YearlyIncrease[11]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 14, FORMAT(YearlyIncrease[12]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 15, FORMAT(YTDIncrease), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 16, FORMAT(AvgIncrease), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'PNP Monthly Distribution Report', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 16, FORMAT(WORKDATE(), 0, 4) + FORMAT(TIME), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'Year: ' + FORMAT(StartDate, 4, '<YEAR4>'), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    RowNo += 2;
                    EnterCell(RowNo, 1, 'No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, 'Name', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, 'JAN', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 4, 'FEB', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 5, 'MAR', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 6, 'APR', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 7, 'MAY', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 8, 'JUN', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 9, 'JUL', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 10, 'AUG', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 11, 'SEP', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 12, 'OCT', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 13, 'NOV', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 14, 'DEC', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 15, 'YTD', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 16, 'AVG', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                END;
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
                    field("Start Date"; StartDate)
                    {
                        ToolTip = 'Specifies the value of the StartDate field.';
                        Caption = 'As Of Date';
                        ApplicationArea = all;
                    }
                    field("Completed Months"; CompleteMonths)
                    {
                        ToolTip = 'Specifies the value of the CompleteMonths field.';
                        Caption = 'Completed Months';
                        ApplicationArea = all;
                    }
                    field("Print To Excel"; PrintToExcel)
                    {
                        ToolTip = 'Specifies the value of the PrintToExcel field.';
                        Caption = 'Print To Excel';
                        ApplicationArea = all;
                    }
                    field("Case Display"; CaseDisplay)
                    {
                        ToolTip = 'Specifies the value of the CaseDisplay field.';
                        Caption = 'Case Display';
                        ApplicationArea = all;
                        CaptionClass = 'Actual Case,1000 Per Case';
                    }
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

    trigger OnInitReport()
    begin
        StartDate := CALCDATE('<D1-M1>');
        CompleteMonths := DATE2DMY(WORKDATE(), 2);
        recWC.GET('PULL-N-PAK');

        //AdjCases := recWC."Adj. Cases";
        AdjCases := 1000;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            //  TempExcelBuffer.CreateBook('PNP Monthly Distribution');
            //  TempExcelBuffer.UpdateBook('PNP Monthly Distribution','PNP Monthly Distribution');

            //TempExcelBuffer.GiveUserControl;
            TempExcelBuffer.CreateNewBook('PNP Monthly Distribution');
            TempExcelBuffer.WriteSheet('PNP Monthly Distribution', CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.OpenExcel();
        END;
    end;

    var

        recSales: Record "Sales Invoice Line";
        recCrMemo: Record "Sales Cr.Memo Line";
        recItem: Record Item;
        recWC: Record "Work Center";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        BegDate: Date;
        EndDate: Date;
        PrintToExcel: Boolean;
        RowNo: Integer;
        CompleteMonths: Integer;
        i: Integer;
        CaseDisplay: Option "Actual Case","1000 Per Case";
        PNP_Monthly_Distribution_ReportCaptionLbl: Label 'PNP Monthly Distribution Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        JANCaptionLbl: Label 'JAN';
        FEBCaptionLbl: Label 'FEB';
        MARCaptionLbl: Label 'MAR';
        APRCaptionLbl: Label 'APR';
        MAYCaptionLbl: Label 'MAY';
        JUNCaptionLbl: Label 'JUN';
        JULCaptionLbl: Label 'JUL';
        AUGCaptionLbl: Label 'AUG';
        SEPCaptionLbl: Label 'SEP';
        OCTCaptionLbl: Label 'OCT';
        NOVCaptionLbl: Label 'NOV';
        DECCaptionLbl: Label 'DEC';
        YTDCaptionLbl: Label 'YTD';
        AVGCaptionLbl: Label 'AVG';
        MonthlyTotals: array[20] of Decimal;
        YearlyTotals: array[20] of Decimal;
        PrevYearlyTotals: array[20] of Decimal;
        YearlyIncrease: array[20] of Decimal;
        PrevYTDTotals: Decimal;
        PrevMonthlyAvg: Decimal;
        YTDIncrease: Decimal;
        AvgIncrease: Decimal;
        YTDTotals: Decimal;
        MonthlyAvg: Decimal;
        AllYTDTotals: Decimal;
        AllMonthlyAvg: Decimal;
        AdjCases: Decimal;

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

