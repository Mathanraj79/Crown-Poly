report 50034 "Admin Daily/Mon Prod. Totals"
{
    // CP1002 19Jun09
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\AdminDailyMonProdTotals.rdl';
    Caption = 'Admin Daily/Mon Prod. Totals';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Machine Center"; "Machine Center")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Work Center No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(AsofDate; AsofDate)
            {
            }
            column(Machine_Center__No__; "No.")
            {
            }
            column(NumberofUnits; NumberofUnits)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthNumberofUnits; MonthNumberofUnits)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthAdjUnits; MonthAdjUnits)
            {
                DecimalPlaces = 0 : 0;
            }
            column(AdjUnits; AdjUnits)
            {
                DecimalPlaces = 0 : 0;
            }
            column(TotalExpectedCases; TotalExpectedCases)
            {
            }
            column(MonthPer1000; MonthPer1000)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Per1000; Per1000)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Scrap; Scrap)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthScrap; MonthScrap)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ScrapPercent___100; ScrapPercent * 100)
            {
            }
            column(MonthScrapPercent___100; MonthScrapPercent * 100)
            {
            }
            column(DieCutPercent___100; DieCutPercent * 100)
            {
            }
            column(MonthDieCutPercent___100; MonthDieCutPercent * 100)
            {
            }
            column(DieCut; DieCut)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthDieCut; MonthDieCut)
            {
                DecimalPlaces = 0 : 0;
            }
            column(EfficencyPercent___100; EfficencyPercent * 100)
            {
            }
            column(MonthEfficencyPercent___100; MonthEfficencyPercent * 100)
            {
            }
            column(DaysRemaining; DaysRemaining)
            {
            }
            column(NumberofDays; NumberofDays)
            {
            }
            column(DaysinMonth; DaysinMonth)
            {
            }
            column(MonthGoal_Goal; MonthGoal.Goal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthProduction; MonthProduction)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthProductionActual; MonthProductionActual)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MonthGoal__Goal__Actual__; MonthGoal."Goal (Actual)")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Admin_Daily_Monthly_Product_TotalsCaption; Admin_Daily_Monthly_Product_TotalsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(As_of_Date_Caption; As_of_Date_CaptionLbl)
            {
            }
            column(Line_No_Caption; Line_No_CaptionLbl)
            {
            }
            column(Efficency__Caption; Efficency__CaptionLbl)
            {
            }
            column(Die_Cut__Caption; Die_Cut__CaptionLbl)
            {
            }
            column(Die_Cut__LBS_Caption; Die_Cut__LBS_CaptionLbl)
            {
            }
            column(Scrap__Caption; Scrap__CaptionLbl)
            {
            }
            column(Scrap__LBS_Caption; Scrap__LBS_CaptionLbl)
            {
            }
            column(Per_1000Caption; Per_1000CaptionLbl)
            {
            }
            column(Adj__UnitsCaption; Adj__UnitsCaptionLbl)
            {
            }
            column(UnitsCaption; UnitsCaptionLbl)
            {
            }
            column(Daily_TotalsCaption; Daily_TotalsCaptionLbl)
            {
            }
            column(Month_to_Date_TotalsCaption; Month_to_Date_TotalsCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(Month_to_Date_Totals_Caption; Month_to_Date_Totals_CaptionLbl)
            {
            }
            column(Days_Remaining_Caption; Days_Remaining_CaptionLbl)
            {
            }
            column(Month_Goal_Caption; Month_Goal_CaptionLbl)
            {
            }
            column(At_Current_Rate__Month_Production_will_be_Caption; At_Current_Rate__Month_Production_will_be_CaptionLbl)
            {
            }
            column(Month_Goal__Actual_Units__Caption; Month_Goal__Actual_Units__CaptionLbl)
            {
            }
            column(WorkCenterNumber; WorkCenterNumber)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Machine Center Code" = FIELD("No.");
                DataItemTableView = SORTING("Posting Date")
                                    WHERE("Entry Type" = FILTER("Output" | "Positive Adjmt."));

                trigger OnAfterGetRecord()
                begin
                    //IF CONFIRM('%1', TRUE, "Posting Date") THEN ERROR('stop');
                    CALCFIELDS("Total Resin Pounds");
                    Item.GET("Item No.");
                    WorkCenter.GET("Work Center Code");

                    //AS of TOTAL
                    IF ("Entry Type" = "Entry Type"::Output) AND ("Posting Date" = AsofDate) THEN BEGIN
                        NumberofUnits += Quantity;
                        IF (Item."Rolls/Bundles per Case" = 0) OR (Item."Bags per Roll/Bundle" = 0) THEN
                            AdjUnits += Quantity
                        ELSE
                            AdjUnits += Item."Rolls/Bundles per Case" * Item."Bags per Roll/Bundle" * Quantity / WorkCenter."Adj. Cases";
                        Per1000 += Item."Rolls/Bundles per Case" * Item."Bags per Roll/Bundle" * Quantity / 1000;
                    END;

                    IF ("Entry Type" = "Entry Type"::"Positive Adjmt.") AND ("Posting Date" = AsofDate) THEN
                        IF (Item.Scrap) AND (NOT Item."Die Cut Scrap") THEN
                            Scrap += Quantity
                        ELSE
                            IF Item."Die Cut Scrap" THEN
                                DieCut += Quantity;

                    //MONTHLY TOTALS
                    IF ("Entry Type" = "Entry Type"::Output) THEN BEGIN
                        MonthNumberofUnits += Quantity;
                        IF (Item."Rolls/Bundles per Case" = 0) OR (Item."Bags per Roll/Bundle" = 0) THEN
                            MonthAdjUnits += Quantity
                        ELSE
                            MonthAdjUnits += Item."Rolls/Bundles per Case" * Item."Bags per Roll/Bundle" * Quantity / WorkCenter."Adj. Cases";
                        MonthPer1000 += Item."Rolls/Bundles per Case" * Item."Bags per Roll/Bundle" * Quantity / 1000;

                    END;

                    IF ("Entry Type" = "Entry Type"::"Positive Adjmt.") THEN
                        IF (Item.Scrap) AND (NOT Item."Die Cut Scrap") THEN
                            MonthScrap += Quantity
                        ELSE
                            IF Item."Die Cut Scrap" THEN
                                MonthDieCut += Quantity;

                    TotalResinPounds2 += "Total Resin Pounds" * Quantity;
                    IF AsofDate = "Posting Date" THEN
                        TotalResinPounds += "Total Resin Pounds" * Quantity;
                end;

                trigger OnPostDataItem()
                begin
                    MonthNumberofUnits := ROUND(MonthNumberofUnits, 1);

                    ItemLedgEntry2.RESET();
                    ItemLedgEntry2.SETCURRENTKEY(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code");
                    ItemLedgEntry2.SETRANGE("Work Center Code", WorkCenter."No.");
                    ItemLedgEntry2.SETFILTER("Posting Date", '%1..%2', StartDate, AsofDate);
                    ItemLedgEntry2.SETFILTER("Entry Type", '%1|%2', ItemLedgEntry2."Entry Type"::"Positive Adjmt.", ItemLedgEntry2."Entry Type"::"Negative Adjmt.");
                    ItemLedgEntry2.CALCFIELDS("Scarp Item");
                    ItemLedgEntry2.SETRANGE("Scarp Item", TRUE);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        TotalScrap2 += ItemLedgEntry2.Quantity;
                        //IF AsofDate = ItemLedgEntry2."Posting Date" THEN
                        //  TotalScrap += ItemLedgEntry2.Quantity;
                    END;
                    ItemLedgEntry2.SETRANGE("Posting Date", AsofDate);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        TotalScrap += ItemLedgEntry2.Quantity;
                    END;

                    IF TotalResinPounds <> 0 THEN BEGIN
                        ScrapPercent := ROUND((Scrap / TotalResinPounds), 0.01);
                        DieCutPercent := ROUND((DieCut / TotalResinPounds), 0.01);
                    END;

                    IF TotalResinPounds2 <> 0 THEN BEGIN
                        MonthDieCutPercent := ROUND((MonthDieCut / (TotalResinPounds2)), 0.01);
                        MonthScrapPercent := ROUND((MonthScrap / (TotalResinPounds2)), 0.01);
                    END;

                    IF "Machine Center"."Expected Cases" <> 0 THEN BEGIN
                        EfficencyPercent := AdjUnits / ("Machine Center"."Expected Cases" * 2);
                        MonthEfficencyPercent := MonthAdjUnits / ("Machine Center"."Expected Cases" * 2 * NumberofDays);
                        TotalExpectedCases += "Machine Center"."Expected Cases";
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    ClearVariables();
                    SETFILTER("Posting Date", '%1..%2', StartDate, AsofDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                WorkCenter.GET("Work Center No.");
                IF MonthGoal.GET("Work Center No.", DATE2DMY(AsofDate, 2), DATE2DMY(AsofDate, 3)) THEN;
            end;

            trigger OnPostDataItem()
            begin
                IF TotalResinPounds <> 0 THEN BEGIN
                    MonthScrapPercent := ROUND((MonthScrap / (TotalResinPounds2)), 0.01);
                    ScrapPercent := ROUND((Scrap / TotalResinPounds), 0.01);
                    MonthDieCutPercent := ROUND((MonthDieCut / (TotalResinPounds2)), 0.01);
                    DieCutPercent := ROUND((DieCut / TotalResinPounds), 0.01);
                END;

                IF "Machine Center"."Expected Cases" <> 0 THEN BEGIN
                    EfficencyPercent := AdjUnits / (TotalExpectedCases * 2);
                    MonthEfficencyPercent := MonthAdjUnits / (TotalExpectedCases * 2 * NumberofDays);
                END;

                MonthProduction := MonthAdjUnits / NumberofDays * DaysinMonth;
                MonthProductionActual := MonthNumberofUnits / NumberofDays * DaysinMonth;
            end;

            trigger OnPreDataItem()
            begin
                // CurrReport.CREATETOTALS(NumberofUnits, AdjUnits, Per1000, Scrap, DieCut, MonthNumberofUnits, MonthAdjUnits, MonthPer1000,
                //   MonthScrap, MonthDieCut);
                // CurrReport.CREATETOTALS(TotalScrap2, TotalResinPounds, TotalResinPounds2, EfficencyPercent, MonthEfficencyPercent);

                LastFieldNo := FIELDNO("No.");
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
                    field("As of Date"; AsofDate)
                    {
                        ToolTip = 'Specifies the value of the AsofDate field.';
                        ApplicationArea = all;
                        Caption = 'As of Date';
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
        AsofDate := CALCDATE('<-1D>', TODAY);
    end;

    trigger OnPreReport()
    begin
        IF AsofDate = 0D THEN
            ERROR('Please enter as of Date.');

        WorkCenterNumber := "Machine Center".GETFILTER("Work Center No.");
        IF WorkCenterNumber = '' THEN
            ERROR('Please Enter Work Center');

        //IF MonthGoal.GET(WorkCenterNumber, DATE2DMY(AsofDate, 2), DATE2DMY(AsofDate, 3)) THEN;

        NumberofDays := DATE2DMY(AsofDate, 1);
        DaysinMonth := DATE2DMY(CALCDATE('<CM>', AsofDate), 1);
        StartDate := CALCDATE('<-CM>', AsofDate);
        //if confirm('%1', true, startdate) then error('stop');
        DaysRemaining := CALCDATE('<CM>', AsofDate) - AsofDate;
    end;

    var
        ItemLedgEntry2: Record "Item Ledger Entry";
        //Item2: Record Item;
        Item: Record Item;
        WorkCenter: Record "Work Center";
        MonthGoal: Record "Monthly Goal";
        LastFieldNo: Integer;
        // FooterPrinted: Boolean;
        // ItemLedgerEntry: Integer;
        NumberofUnits: Decimal;
        AdjUnits: Decimal;
        Per1000: Decimal;
        Scrap: Decimal;
        DieCut: Decimal;
        ScrapPercent: Decimal;
        DieCutPercent: Decimal;
        EfficencyPercent: Decimal;
        MonthNumberofUnits: Decimal;
        MonthAdjUnits: Decimal;
        MonthPer1000: Decimal;
        MonthScrap: Decimal;
        MonthDieCut: Decimal;
        MonthScrapPercent: Decimal;
        MonthDieCutPercent: Decimal;
        MonthEfficencyPercent: Decimal;
        AsofDate: Date;
        StartDate: Date;
        DaysRemaining: Integer;
        TotalResinPounds: Decimal;

        TotalScrap2: Decimal;
        TotalScrap: Decimal;
        TotalResinPounds2: Decimal;
        NumberofDays: Integer;
        MonthProduction: Decimal;
        MonthProductionActual: Decimal;
        DaysinMonth: Integer;

        WorkCenterNumber: Code[50];
        TotalExpectedCases: Decimal;
        Admin_Daily_Monthly_Product_TotalsCaptionLbl: Label 'Admin Daily/Monthly Product Totals';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        As_of_Date_CaptionLbl: Label 'As of Date:';
        Line_No_CaptionLbl: Label 'Line No.';
        Efficency__CaptionLbl: Label 'Efficency %';
        Die_Cut__CaptionLbl: Label 'Die Cut %';
        Die_Cut__LBS_CaptionLbl: Label 'Die Cut (LBS)';
        Scrap__CaptionLbl: Label 'Scrap %';
        Scrap__LBS_CaptionLbl: Label 'Scrap (LBS)';
        Per_1000CaptionLbl: Label 'Per 1000';
        Adj__UnitsCaptionLbl: Label 'Adj. Units';
        UnitsCaptionLbl: Label 'Units';
        // Efficency__Caption_Control1000000040Lbl: Label 'Efficency %';
        // Die_Cut__Caption_Control1000000041Lbl: Label 'Die Cut %';
        // Die_Cut__LBS_Caption_Control1000000042Lbl: Label 'Die Cut (LBS)';
        // Scrap__Caption_Control1000000044Lbl: Label 'Scrap %';
        // Scrap__LBS_Caption_Control1000000046Lbl: Label 'Scrap (LBS)';
        // Per_1000Caption_Control1000000048Lbl: Label 'Per 1000';
        // Adj__UnitsCaption_Control1000000050Lbl: Label 'Adj. Units';
        // UnitsCaption_Control1000000052Lbl: Label 'Units';
        Daily_TotalsCaptionLbl: Label 'Daily Totals';
        Month_to_Date_TotalsCaptionLbl: Label 'Month-to Date Totals';
        TotalsCaptionLbl: Label 'Totals';
        Month_to_Date_Totals_CaptionLbl: Label 'Month-to Date Totals:';
        Days_Remaining_CaptionLbl: Label 'Days Remaining:';
        Month_Goal_CaptionLbl: Label 'Month Goal:';
        At_Current_Rate__Month_Production_will_be_CaptionLbl: Label 'At Current Rate, Month Production will be:';
        //At_Current_Rate__Month_Production_will_be_Caption_Control1000000136Lbl: Label 'At Current Rate, Month Production will be:';
        Month_Goal__Actual_Units__CaptionLbl: Label 'Month Goal (Actual Units):';

    procedure ClearVariables()
    begin
        NumberofUnits := 0;
        AdjUnits := 0;
        Per1000 := 0;
        Scrap := 0;
        DieCut := 0;
        ScrapPercent := 0;
        DieCutPercent := 0;
        EfficencyPercent := 0;
        MonthNumberofUnits := 0;
        MonthAdjUnits := 0;
        MonthPer1000 := 0;
        MonthScrap := 0;
        MonthDieCut := 0;
        MonthScrapPercent := 0;
        MonthDieCutPercent := 0;
        MonthEfficencyPercent := 0;
        TotalResinPounds := 0;
        TotalScrap2 := 0;
        TotalScrap := 0;
        TotalResinPounds2 := 0;
    end;
}

