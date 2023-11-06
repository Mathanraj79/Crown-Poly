report 50002 "Stock Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\StockStatus.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Stock Status';
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Global Dimension 1 Code")
                                ORDER(Ascending);
            RequestFilterFields = "Global Dimension 1 Code";
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(DateThru; DateThru)
            {
            }
            column(DateText_3_; DateText[3])
            {
            }
            column(DateText_2_; DateText[2])
            {
            }
            column(DateText_5_; DateText[5])
            {
            }
            column(DateText_4_; DateText[4])
            {
            }
            column(Item_Resin; Resin)
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(SixMonthAverage; SixMonthAverage)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ThreeMonthAverage; ThreeMonthAverage)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQty_2_; InvQty[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQty_3_; InvQty[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQty_4_; InvQty[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQty_5_; InvQty[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(LAOnhand; LAOnhand)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_Inventory; Inventory)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_Item__Qty__on_Sales_Order_; Item."Qty. on Sales Order")
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOhman; QtyOhman)
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyConn; QtyConn)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_Item__Maximum_Inventory_; Item."Maximum Inventory")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_Item__Reorder_Point_; Item."Safety Stock Quantity")
            {
                DecimalPlaces = 0 : 0;
            }
            column(recItem2__Adj__Transfers_; recItem2."Adj. Transfers")
            {
                DecimalPlaces = 0 : 0;
            }
            column(recItem2__Sales_Cases_; recItem2."Sales Cases")
            {
                DecimalPlaces = 0 : 0;
            }
            column(recItem2__Production_Cases_; recItem2."Production Cases")
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyConnTotal; QtyConnTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(QtyOhmanTotal; QtyOhmanTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(LAOnhandTotal; LAOnhandTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(AdjCasesTotal; AdjCasesTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(SalesCasesTotal; SalesCasesTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ProdCasesTotal; ProdCasesTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQtyTotal_2_; InvQtyTotal[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQtyTotal_3_; InvQtyTotal[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQtyTotal_4_; InvQtyTotal[4])
            {
                DecimalPlaces = 0 : 0;
            }
            column(InvQtyTotal_5_; InvQtyTotal[5])
            {
                DecimalPlaces = 0 : 0;
            }
            column(ThreeMonthsAverageTotal; ThreeMonthsAverageTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(SixMonthsAverageTotal; SixMonthsAverageTotal)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__Global_Dimension_1_Code______Division_Totals__; Item."Global Dimension 1 Code" + ' Division Totals:')
            {

            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(STOCK_STATUS_REPORTCaption; STOCK_STATUS_REPORTCaptionLbl)
            {
            }
            column(Month_To_Date_ThroughCaption; Month_To_Date_ThroughCaptionLbl)
            {
            }
            column(Item_ResinCaption; FIELDCAPTION(Resin))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Ave__Monthly_SalesCaption; Ave__Monthly_SalesCaptionLbl)
            {
            }
            column(V3_Mo_Caption; V3_Mo_CaptionLbl)
            {
            }
            column(V6_Mo_Caption; V6_Mo_CaptionLbl)
            {
            }
            column(InventoryCaption; InventoryCaptionLbl)
            {
            }
            column(Current_Month_ActivityCaption; Current_Month_ActivityCaptionLbl)
            {
            }
            column(LA_on_HandCaption; LA_on_HandCaptionLbl)
            {
            }
            column(LevelsCaption; LevelsCaptionLbl)
            {
            }
            column(MaxCaption; MaxCaptionLbl)
            {
            }
            column(MinCaption; MinCaptionLbl)
            {
            }
            column(All_LocationsCaption; All_LocationsCaptionLbl)
            {
            }
            column(Avail_Caption; Avail_CaptionLbl)
            {
            }
            column(Commit_Caption; Commit_CaptionLbl)
            {
            }
            column(OhmanCaption; OhmanCaptionLbl)
            {
            }
            column(OnCaption; OnCaptionLbl)
            {
            }
            column(ConnCaption; ConnCaptionLbl)
            {
            }
            column(HandCaption; HandCaptionLbl)
            {
            }
            column(Adj____TransferCaption; Adj____TransferCaptionLbl)
            {
            }
            column(Sales_CasesCaption; Sales_CasesCaptionLbl)
            {
            }
            column(Production_CaseCaption; Production_CaseCaptionLbl)
            {
            }
            column(Item_Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(CaseCaption; CaseCaptionLbl)
            {
            }
            column(CasesCaption; CasesCaptionLbl)
            {
            }
            column(TransferCaption; TransferCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(recItem);
                CLEAR(recItem2);
                CLEAR(InvQty);
                ThreeMonthAverage := 0;
                SixMonthAverage := 0;
                LAOnhand := 0;
                CALCFIELDS(Inventory);
                recItem3.RESET();
                recItem3 := Item;
                recItem3.SETFILTER("Location Filter", 'LA');
                recItem3.CALCFIELDS(Inventory);
                LAOnhand := recItem3.Inventory;
                LAOnhandTotal += LAOnhand;

                recItem := Item;
                recItem.RESET();
                Date1[1] := CALCDATE('<-CM - 3M>', DateThru);
                Date1[2] := CALCDATE('<-CM - 1D>', DateThru);
                recItem.SETFILTER("Date Filter", '%1..%2', Date1[1], Date1[2]);
                //IF CONFIRM('What are my Filters %1 to %2', TRUE, Date1[1], Date1[2]) THEN
                //  ERROR('Stop');

                recItem.CALCFIELDS("Sales (Qty.)");
                ThreeMonthAverage := ROUND(recItem."Sales (Qty.)" / 3, 1);
                ThreeMonthsAverageTotal += ThreeMonthAverage;

                recItem.RESET();
                Date1[3] := CALCDATE('<-CM - 6M>', DateThru);
                Date1[4] := CALCDATE('<-CM -1D>', DateThru);
                //IF CONFIRM('What are my Filters %1 to %2', TRUE, Date1[3], Date1[4]) THEN
                //  ERROR('Stop');

                recItem.SETFILTER("Date Filter", '%1..%2', Date1[3], Date1[4]);
                recItem.CALCFIELDS("Sales (Qty.)");
                SixMonthAverage := ROUND(recItem."Sales (Qty.)" / 6, 1);
                SixMonthsAverageTotal += SixMonthAverage;

                FOR j := 2 TO 5 DO BEGIN
                    //InvQty[j] := GetInventory(recItem,DateCaption[j]);
                    recItem.RESET();
                    recItem.SETFILTER("Date Filter", '..%1', CALCDATE('<CM>', DateCaption[j]));
                    recItem.SETFILTER("Location Filter", 'LA');
                    recItem.CALCFIELDS(Inventory);
                    InvQty[j] := recItem.Inventory;
                    InvQtyTotal[j] += InvQty[j];
                END;


                recItem2.RESET();
                recItem2 := Item;
                recItem2.SETRANGE("Location Filter", 'AMZN');
                recItem2.CALCFIELDS(Inventory);
                QtyOhman := recItem2.Inventory;
                QtyOhmanTotal += QtyOhman;

                recItem2.RESET();
                recItem2.SETRANGE("Location Filter", 'CT');
                recItem2.CALCFIELDS(Inventory);
                QtyConn := recItem2.Inventory;
                QtyConnTotal += QtyConn;

                recItem2.RESET();
                recItem2.SETFILTER("Date Filter", '%1..%2', CALCDATE('<-CM>', DateThru), DateThru);
                recItem2.SETFILTER("Location Filter", 'LA');
                recItem2.CALCFIELDS("Production Cases", "Sales Cases", "Adj. Transfers");
                ProdCasesTotal += recItem2."Production Cases";
                SalesCasesTotal += recItem2."Sales Cases";
                AdjCasesTotal += recItem2."Adj. Transfers";
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
                    field(DateThru; DateThru)
                    {
                        Caption = 'Date Through';
                        ToolTip = 'Specifies the value of the Date Through field.';
                        ApplicationArea = all;
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
        DateThru := TODAY;
    end;

    trigger OnPreReport()
    begin
        IF DateThru = 0D THEN
            ERROR('Please Enter Date');
        IF DateThru <> 0D THEN BEGIN
            FOR i := 2 TO 5 DO
                IF i = 2 THEN
                    DateCaption[1] := DateThru;
            DateCaption[i] := CALCDATE('<-CM - 1D>', DateCaption[i - 1]);
            MonthText[i] := FORMAT(DateCaption[i], 3, '<Month Text>');
            YearText[i] := FORMAT(DateCaption[i], 4, '<Year>');
            DateText[i] := MonthText[i] + COPYSTR(YearText[i], 3, 2);
            //FORMAT(DateThru, 8, '<Month Text>'));
        END;
    end;

    var
        recItem3: Record Item;
        recItem: Record Item;
        recItem2: Record Item;
        ThreeMonthAverage: Decimal;
        SixMonthAverage: Decimal;
        DateThru: Date;
        DateCaption: array[5] of Date;
        DateText: array[10] of Text[30];
        MonthText: array[10] of Text[30];
        YearText: array[10] of Text[30];
        //MonthsQuantity: array[10] of Integer;
        i: Integer;
        //QtyInventory: array[10] of Decimal;
        j: Integer;
        Date1: array[10] of Date;
        InvQty: array[10] of Decimal;
        InvQtyTotal: array[10] of Decimal;
        QtyOhman: Decimal;
        QtyConn: Decimal;
        // CurrInventory: Decimal;
        LAOnhand: Decimal;

        ThreeMonthsAverageTotal: Decimal;
        SixMonthsAverageTotal: Decimal;
        QtyOhmanTotal: Decimal;
        QtyConnTotal: Decimal;
        LAOnhandTotal: Decimal;
        ProdCasesTotal: Decimal;
        SalesCasesTotal: Decimal;
        AdjCasesTotal: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        STOCK_STATUS_REPORTCaptionLbl: Label 'STOCK STATUS REPORT';
        Month_To_Date_ThroughCaptionLbl: Label 'Month-To-Date Through';
        Ave__Monthly_SalesCaptionLbl: Label 'Ave. Monthly Sales';
        V3_Mo_CaptionLbl: Label '3 Mo.';
        V6_Mo_CaptionLbl: Label '6 Mo.';
        InventoryCaptionLbl: Label 'Inventory';
        Current_Month_ActivityCaptionLbl: Label 'Current Month Activity';
        LA_on_HandCaptionLbl: Label 'LA on';
        HandCaptionLbl: Label 'Hand';
        LevelsCaptionLbl: Label 'Levels';
        MaxCaptionLbl: Label 'Max';
        MinCaptionLbl: Label 'Min';
        All_LocationsCaptionLbl: Label 'All Locations';
        Avail_CaptionLbl: Label 'Avail.';
        Commit_CaptionLbl: Label 'Commit.';
        OhmanCaptionLbl: Label 'Amazon';
        OnCaptionLbl: Label 'On';
        ConnCaptionLbl: Label 'Conn';
        //OnCaption_Control1000000094Lbl: Label 'On';
        Adj____TransferCaptionLbl: Label 'Adj. &';
        TransferCaptionLbl: Label 'Transfer';
        Sales_CasesCaptionLbl: Label 'Sales';
        Production_CaseCaptionLbl: Label 'Production';
        CaseCaptionLbl: Label 'Case';
        CasesCaptionLbl: Label 'Cases';

    procedure GetInventory(var recItem: Record Item; var MonthDate: Date) InventoryQuantity: Decimal
    begin
        recItem.RESET();
        //IF CONFIRM('What are my Filters %1 to %2', TRUE, CALCDATE('-CM',MonthDate), CALCDATE('CM', MonthDate)) THEN
        //  ERROR('Stop');
        recItem.SETFILTER("Date Filter", '%1..%2', CALCDATE('<-CM>', MonthDate), CALCDATE('<CM>', MonthDate));
        recItem.SETFILTER("Location Filter", 'LA');
        recItem.CALCFIELDS(Inventory);
        InventoryQuantity := recItem.Inventory;
    end;
}

