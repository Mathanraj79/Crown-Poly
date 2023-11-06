report 50038 "Admin Daily/Mon Prod.Total-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\AdminDailyMonProdTotalNew.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Admin Daily/Mon Prod.Total-New';
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
                // DecimalPlaces = 0 : 0;
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
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending);
                MaxIteration = 1;

                trigger OnAfterGetRecord()
                begin
                    //AS of TOTAL -- OUTPUT
                    ItemLedgEntry2.RESET();
                    ItemLedgEntry2.SETCURRENTKEY(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code");
                    ItemLedgEntry2.SETRANGE("Machine Center Code", "Machine Center"."No.");
                    ItemLedgEntry2.SETFILTER("Posting Date", '%1', AsofDate);
                    ItemLedgEntry2.SETFILTER("Entry Type", '%1', ItemLedgEntry2."Entry Type"::Output);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        NumberofUnits := ItemLedgEntry2.Quantity;
                    END;
                    ItemLedgEntry2.CALCFIELDS("Rolls/Bundles per Case", "Bags per Roll/Bundle");
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        IF (ItemLedgEntry2."Rolls/Bundles per Case" = 0) OR (ItemLedgEntry2."Bags per Roll/Bundle" = 0) THEN
                            AdjUnits := ItemLedgEntry2.Quantity
                        ELSE
                            AdjUnits := ItemLedgEntry2."Rolls/Bundles per Case" * ItemLedgEntry2."Bags per Roll/Bundle" * ItemLedgEntry2.Quantity / WorkCenter."Adj. Cases";
                        Per1000 := ItemLedgEntry2."Rolls/Bundles per Case" * ItemLedgEntry2."Bags per Roll/Bundle" * ItemLedgEntry2.Quantity / 1000;
                    END;

                    //AS of TOTAL -- POSITIVE ADJUSTMENT
                    ItemLedgEntry2.RESET();
                    ItemLedgEntry2.SETCURRENTKEY(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code");
                    ItemLedgEntry2.SETRANGE("Machine Center Code", "Machine Center"."No.");
                    ItemLedgEntry2.SETFILTER("Posting Date", '%1', AsofDate);
                    ItemLedgEntry2.SETFILTER("Entry Type", '%1', ItemLedgEntry2."Entry Type"::"Positive Adjmt.");
                    ItemLedgEntry2.CALCFIELDS("Scarp Item", "Die Cut Scrap");
                    ItemLedgEntry2.SETRANGE("Scarp Item", TRUE);
                    ItemLedgEntry2.SETRANGE("Die Cut Scrap", FALSE);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        Scrap := ItemLedgEntry2.Quantity
                    END;
                    ItemLedgEntry2.SETRANGE("Scarp Item");
                    ItemLedgEntry2.SETRANGE("Die Cut Scrap", TRUE);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        DieCut := ItemLedgEntry2.Quantity
                    END;

                    //MONTHLY TOTALS -- Output
                    ItemLedgEntry2.RESET();
                    ItemLedgEntry2.SETCURRENTKEY(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code");
                    ItemLedgEntry2.SETRANGE("Machine Center Code", "Machine Center"."No.");
                    ItemLedgEntry2.SETFILTER("Posting Date", '%1..%2', StartDate, AsofDate);
                    ItemLedgEntry2.SETFILTER("Entry Type", '%1', ItemLedgEntry2."Entry Type"::Output);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        MonthNumberofUnits := ItemLedgEntry2.Quantity;
                    END;
                    ItemLedgEntry2.CALCFIELDS("Rolls/Bundles per Case", "Bags per Roll/Bundle");
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        IF (ItemLedgEntry2."Rolls/Bundles per Case" = 0) OR (ItemLedgEntry2."Bags per Roll/Bundle" = 0) THEN
                            MonthAdjUnits := ItemLedgEntry2.Quantity
                        ELSE
                            MonthAdjUnits := ItemLedgEntry2."Rolls/Bundles per Case" * ItemLedgEntry2."Bags per Roll/Bundle" * ItemLedgEntry2.Quantity / WorkCenter."Adj. Cases";
                        MonthPer1000 := ItemLedgEntry2."Rolls/Bundles per Case" * ItemLedgEntry2."Bags per Roll/Bundle" * ItemLedgEntry2.Quantity / 1000;
                    END;

                    //MONTHLY TOTALS -- Positive Adjustment
                    ItemLedgEntry2.RESET();
                    ItemLedgEntry2.SETCURRENTKEY(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code");
                    ItemLedgEntry2.SETRANGE("Machine Center Code", "Machine Center"."No.");
                    ItemLedgEntry2.SETFILTER("Posting Date", '%1..%2', StartDate, AsofDate);
                    ItemLedgEntry2.SETFILTER("Entry Type", '%1', ItemLedgEntry2."Entry Type"::"Positive Adjmt.");
                    ItemLedgEntry2.CALCFIELDS("Scarp Item", "Die Cut Scrap");
                    ItemLedgEntry2.SETRANGE("Scarp Item", TRUE);
                    ItemLedgEntry2.SETRANGE("Die Cut Scrap", FALSE);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        MonthScrap := ItemLedgEntry2.Quantity
                    END;
                    ItemLedgEntry2.SETRANGE("Scarp Item");
                    ItemLedgEntry2.SETRANGE("Die Cut Scrap", TRUE);
                    IF ItemLedgEntry2.FINDSET() THEN BEGIN
                        ItemLedgEntry2.CALCSUMS(Quantity);
                        MonthDieCut := ItemLedgEntry2.Quantity
                    END;

                    Item.RESET();
                    Item.SETFILTER("Machine Center Filter", '%1', "Machine Center"."No.");
                    Item.SETFILTER("Date Filter", '%1..%2', StartDate, AsofDate);
                    Item.CALCFIELDS("Count Ledg Entries");
                    Item.SETFILTER("Count Ledg Entries", '>%1', 0);
                    IF Item.FINDSET() THEN
                        REPEAT
                            Item.CALCFIELDS(Item."Resin Pound Qty.", Item."Resin Pound");
                            TotalResinPounds2 += Item."Resin Pound Qty." * Item."Resin Pound";

                            Item.SETFILTER("Date Filter", '%1', AsofDate);
                            Item.CALCFIELDS(Item."Resin Pound Qty.", Item."Resin Pound");
                            TotalResinPounds += Item."Resin Pound Qty." * Item."Resin Pound";
                        UNTIL Item.NEXT() = 0;
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
                        Caption = 'As Of Date';
                        ApplicationArea = all;
                        ToolTip = 'Specifies the As of Date';
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
        DaysRemaining := CALCDATE('<CM>', AsofDate) - AsofDate;
    end;

    var
        Item: Record Item;
        WorkCenter: Record "Work Center";
        MonthGoal: Record "Monthly Goal";

        ItemLedgEntry2: Record "Item Ledger Entry";
        // Item2: Record Item;
        LastFieldNo: Integer;
        //FooterPrinted: Boolean;
        //ItemLedgerEntry: Integer;
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

        TotalScrap2: Decimal;
        TotalScrap: Decimal;
        TotalResinPounds2: Decimal;
        NumberofDays: Integer;
        MonthProduction: Decimal;
        StartDate: Date;
        DaysRemaining: Integer;
        TotalResinPounds: Decimal;
        MonthProductionActual: Decimal;
        DaysinMonth: Integer;
        WorkCenterNumber: Code[20];
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

