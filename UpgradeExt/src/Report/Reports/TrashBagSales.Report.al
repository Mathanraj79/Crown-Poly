report 50005 "Trash Bag Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\TrashBagSales.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Trash Bag Sales';
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(JanSale; JanSale)
            {
            }
            column(FebSale; FebSale)
            {
            }
            column(MarSale; MarSale)
            {
            }
            column(AprSale; AprSale)
            {
            }
            column(MaySale; MaySale)
            {
            }
            column(JunSale; JunSale)
            {
            }
            column(JulSale; JulSale)
            {
            }
            column(AugSale; AugSale)
            {
            }
            column(SepSale; SepSale)
            {
            }
            column(OctSale; OctSale)
            {
            }
            column(NovSale; NovSale)
            {
            }
            column(DecSale; DecSale)
            {
            }
            column(PriorJanSale; PriorJanSale)
            {
            }
            column(PriorFebSale; PriorFebSale)
            {
            }
            column(PriorMarSale; PriorMarSale)
            {
            }
            column(PriorAprSale; PriorAprSale)
            {
            }
            column(PriorMaySale; PriorMaySale)
            {
            }
            column(PriorJunSale; PriorJunSale)
            {
            }
            column(PriorJulSale; PriorJulSale)
            {
            }
            column(PriorAugSale; PriorAugSale)
            {
            }
            column(PriorSepSale; PriorSepSale)
            {
            }
            column(PriorOctSale; PriorOctSale)
            {
            }
            column(PriorNovSale; PriorNovSale)
            {
            }
            column(PriorDecSale; PriorDecSale)
            {
            }
            column(IntForYear; IntForYear)
            {
            }
            column(AvgMonth; AvgMonth)
            {
            }
            column(TotJanSale; TotJanSale)
            {
            }
            column(TotFebSale; TotFebSale)
            {
            }
            column(TotMarSale; TotMarSale)
            {
            }
            column(TotAprSale; TotAprSale)
            {
            }
            column(TotMaySale; TotMaySale)
            {
            }
            column(TotJunSale; TotJunSale)
            {
            }
            column(TotJulSale; TotJulSale)
            {
            }
            column(TotAugSale; TotAugSale)
            {
            }
            column(TotSepSale; TotSepSale)
            {
            }
            column(TotOctSale; TotOctSale)
            {
            }
            column(TotNovSale; TotNovSale)
            {
            }
            column(TotDecSale; TotDecSale)
            {
            }
            column(TotPriorJanSale; TotPriorJanSale)
            {
            }
            column(TotPriorFebSale; TotPriorFebSale)
            {
            }
            column(TotPriorMarSale; TotPriorMarSale)
            {
            }
            column(TotPriorAprSale; TotPriorAprSale)
            {
            }
            column(TotPriorMaySale; TotPriorMaySale)
            {
            }
            column(TotPriorJunSale; TotPriorJunSale)
            {
            }
            column(TotPriorJulSale; TotPriorJulSale)
            {
            }
            column(TotPriorAugSale; TotPriorAugSale)
            {
            }
            column(TotPriorSepSale; TotPriorSepSale)
            {
            }
            column(TotPriorOctSale; TotPriorOctSale)
            {
            }
            column(TotPriorNovSale; TotPriorNovSale)
            {
            }
            column(TotPriorDecSale; TotPriorDecSale)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "No.");
                CalMonthSales();
                //MakeExcelDataBody;
            end;

            trigger OnPostDataItem()
            begin
                //MakeExcelDataFooter;
                Window.CLOSE();
                //CreateExcelbook;
            end;

            trigger OnPreDataItem()
            begin
                //MakeExcelDataHeader;
                Window.OPEN(Text000Lbl + ' #1########');
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
                    field(ForYear; ForYear)
                    {
                        Caption = 'Sales For Year';
                        Visible = false;
                        ToolTip = 'Specifies the value of the Sales For Year field.';
                        ApplicationArea = all;
                        CaptionClass = '2017,2016,2015,2014,2013,2012,2011,2010,2009,2018,2019,2020';
                    }
                    field(AsOfDate; AsOfDate)
                    {
                        Caption = 'As of Date';
                        ToolTip = 'Specifies the value of the As of Date field.';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            AsOfDate := TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF ForYear = ForYear::"2015" THEN
            IntForYear := 2015
        ELSE
            IF ForYear = ForYear::"2014" THEN
                IntForYear := 2014
            ELSE
                IF ForYear = ForYear::"2013" THEN
                    IntForYear := 2013
                ELSE
                    IF ForYear = ForYear::"2012" THEN
                        IntForYear := 2012
                    ELSE
                        IF ForYear = ForYear::"2011" THEN
                            IntForYear := 2011
                        ELSE
                            IF ForYear = ForYear::"2010" THEN
                                IntForYear := 2010
                            ELSE
                                IF ForYear = ForYear::"2009" THEN
                                    IntForYear := 2009
                                ELSE
                                    IF ForYear = ForYear::"2016" THEN
                                        IntForYear := 2016
                                    ELSE
                                        IF ForYear = ForYear::"2017" THEN
                                            IntForYear := 2017
                                        ELSE
                                            IF ForYear = ForYear::"2018" THEN
                                                IntForYear := 2018
                                            ELSE
                                                IF ForYear = ForYear::"2019" THEN
                                                    IntForYear := 2019
                                                ELSE
                                                    IF ForYear = ForYear::"2020" THEN IntForYear := 2020;
        /*
        IF IntForYear <> DATE2DMY(TODAY,3) THEN
           AvgMonth := 12
        ELSE
           AvgMonth := DATE2DMY(TODAY,2);
        */
        IntForYear := DATE2DMY(AsOfDate, 3);
        AvgMonth := DATE2DMY(AsOfDate, 2);

    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ForYear: Option "2017","2016","2015","2014","2013","2012","2011","2010","2009","2018","2019","2020";
        IntForYear: Integer;
        Window: Dialog;
        MonthCount: Integer;
        JanSale: Decimal;
        FebSale: Decimal;
        MarSale: Decimal;
        AprSale: Decimal;
        MaySale: Decimal;
        JunSale: Decimal;
        JulSale: Decimal;
        AugSale: Decimal;
        SepSale: Decimal;
        OctSale: Decimal;
        NovSale: Decimal;
        DecSale: Decimal;
        PriorJanSale: Decimal;
        PriorFebSale: Decimal;
        PriorMarSale: Decimal;
        PriorAprSale: Decimal;
        PriorMaySale: Decimal;
        PriorJunSale: Decimal;
        PriorJulSale: Decimal;
        PriorAugSale: Decimal;
        PriorSepSale: Decimal;
        PriorOctSale: Decimal;
        PriorNovSale: Decimal;
        PriorDecSale: Decimal;
        Text000Lbl: Label 'Going through customers ';
        TotJanSale: Decimal;
        TotFebSale: Decimal;
        TotMarSale: Decimal;
        TotAprSale: Decimal;
        TotMaySale: Decimal;
        TotJunSale: Decimal;
        TotJulSale: Decimal;
        TotAugSale: Decimal;
        TotSepSale: Decimal;
        TotOctSale: Decimal;
        TotNovSale: Decimal;
        TotDecSale: Decimal;
        TotPriorJanSale: Decimal;
        TotPriorFebSale: Decimal;
        TotPriorMarSale: Decimal;
        TotPriorAprSale: Decimal;
        TotPriorMaySale: Decimal;
        TotPriorJunSale: Decimal;
        TotPriorJulSale: Decimal;
        TotPriorAugSale: Decimal;
        TotPriorSepSale: Decimal;
        TotPriorOctSale: Decimal;
        TotPriorNovSale: Decimal;
        TotPriorDecSale: Decimal;
        RowNo: Integer;
        AvgMonth: Integer;
        AsOfDate: Date;

    procedure CalMonthSales()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        MonthCount := 0;
        REPEAT
            MonthCount += 1;

            StartDate := DMY2DATE(1, MonthCount, IntForYear);
            IF MonthCount = 12 THEN
                EndDate := DMY2DATE(31, 12, IntForYear)
            ELSE
                EndDate := CALCDATE('<-1D>', DMY2DATE(1, MonthCount + 1, IntForYear));

            //Month Sale
            Customer.SETRANGE("Date Filter", StartDate, EndDate);
            Customer.CALCFIELDS("Trash Bag Sold Qty", "Trash Bag Cr. Qty");
            SetMonthSale(MonthCount, Customer."Trash Bag Sold Qty" - Customer."Trash Bag Cr. Qty", FALSE);
            Customer.SETRANGE("Date Filter");

            //Prior Month Sale
            Customer.SETRANGE("Date Filter", CALCDATE('<-1Y>', StartDate), CALCDATE('<-1Y>', EndDate));
            Customer.CALCFIELDS("Trash Bag Sold Qty", "Trash Bag Cr. Qty");
            SetMonthSale(MonthCount, Customer."Trash Bag Sold Qty" - Customer."Trash Bag Cr. Qty", TRUE);
            Customer.SETRANGE("Date Filter");
        UNTIL MonthCount = AvgMonth;
    end;

    procedure SetMonthSale(Fmonth: Integer; SalesAmount: Decimal; IsPrior: Boolean)
    begin
        IF NOT IsPrior THEN BEGIN
            IF Fmonth = 1 THEN BEGIN
                JanSale := SalesAmount;
                TotJanSale += SalesAmount
            END
            ELSE
                IF Fmonth = 2 THEN BEGIN
                    FebSale := SalesAmount;
                    TotFebSale += SalesAmount
                END
                ELSE
                    IF Fmonth = 3 THEN BEGIN
                        MarSale := SalesAmount;
                        TotMarSale += SalesAmount
                    END
                    ELSE
                        IF Fmonth = 4 THEN BEGIN
                            AprSale := SalesAmount;
                            TotAprSale += SalesAmount
                        END
                        ELSE
                            IF Fmonth = 5 THEN BEGIN
                                MaySale := SalesAmount;
                                TotMaySale += SalesAmount
                            END
                            ELSE
                                IF Fmonth = 6 THEN BEGIN
                                    JunSale := SalesAmount;
                                    TotJunSale += SalesAmount
                                END
                                ELSE
                                    IF Fmonth = 7 THEN BEGIN
                                        JulSale := SalesAmount;
                                        TotJulSale += SalesAmount
                                    END
                                    ELSE
                                        IF Fmonth = 8 THEN BEGIN
                                            AugSale := SalesAmount;
                                            TotAugSale += SalesAmount
                                        END
                                        ELSE
                                            IF Fmonth = 9 THEN BEGIN
                                                SepSale := SalesAmount;
                                                TotSepSale += SalesAmount
                                            END
                                            ELSE
                                                IF Fmonth = 10 THEN BEGIN
                                                    OctSale := SalesAmount;
                                                    TotOctSale += SalesAmount
                                                END
                                                ELSE
                                                    IF Fmonth = 11 THEN BEGIN
                                                        NovSale := SalesAmount;
                                                        TotNovSale += SalesAmount
                                                    END
                                                    ELSE
                                                        IF Fmonth = 12 THEN BEGIN DecSale := SalesAmount; TotDecSale += SalesAmount END;
        END
        ELSE BEGIN
            IF Fmonth = 1 THEN BEGIN
                PriorJanSale := SalesAmount;
                TotPriorJanSale += SalesAmount
            END
            ELSE
                IF Fmonth = 2 THEN BEGIN
                    PriorFebSale := SalesAmount;
                    TotPriorFebSale += SalesAmount
                END
                ELSE
                    IF Fmonth = 3 THEN BEGIN
                        PriorMarSale := SalesAmount;
                        TotPriorMarSale += SalesAmount
                    END
                    ELSE
                        IF Fmonth = 4 THEN BEGIN
                            PriorAprSale := SalesAmount;
                            TotPriorAprSale += SalesAmount
                        END
                        ELSE
                            IF Fmonth = 5 THEN BEGIN
                                PriorMaySale := SalesAmount;
                                TotPriorMaySale += SalesAmount
                            END
                            ELSE
                                IF Fmonth = 6 THEN BEGIN
                                    PriorJunSale := SalesAmount;
                                    TotPriorJunSale += SalesAmount
                                END
                                ELSE
                                    IF Fmonth = 7 THEN BEGIN
                                        PriorJulSale := SalesAmount;
                                        TotPriorJulSale += SalesAmount
                                    END
                                    ELSE
                                        IF Fmonth = 8 THEN BEGIN
                                            PriorAugSale := SalesAmount;
                                            TotPriorAugSale += SalesAmount
                                        END
                                        ELSE
                                            IF Fmonth = 9 THEN BEGIN
                                                PriorSepSale := SalesAmount;
                                                TotPriorSepSale += SalesAmount
                                            END
                                            ELSE
                                                IF Fmonth = 10 THEN BEGIN
                                                    PriorOctSale := SalesAmount;
                                                    TotPriorOctSale += SalesAmount
                                                END
                                                ELSE
                                                    IF Fmonth = 11 THEN BEGIN
                                                        PriorNovSale := SalesAmount;
                                                        TotPriorNovSale += SalesAmount
                                                    END
                                                    ELSE
                                                        IF Fmonth = 12 THEN BEGIN PriorDecSale := SalesAmount; TotPriorDecSale += SalesAmount END;
        END;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('TRASH BAG SALES' + FORMAT(IntForYear), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        MonthCount := 0;
        REPEAT
            MonthCount += 1;
            ExcelBuf.AddColumn(FORMAT(GetMonthName(MonthCount)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        UNTIL MonthCount = AvgMonth;
        ExcelBuf.AddColumn(FORMAT('TOTAL BAGS - ' + FORMAT(IntForYear)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('AVG BAGS PER MONTH - ' + FORMAT(IntForYear)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT('AVG BAGS PER MONTH - ' + FORMAT(IntForYear - 1)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

        RowNo := 3;
    end;

    local procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        RowNo += 1;
        MonthCount := 0;
        REPEAT
            MonthCount += 1;
            ExcelBuf.AddColumn(FORMAT(GetMonthNameValue(MonthCount, FALSE)), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        UNTIL MonthCount = AvgMonth;
        ExcelBuf.AddColumn(FORMAT(ReturnTotal(FALSE)), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT('=N' + FORMAT(RowNo) + '/' + FORMAT(DATE2DMY(TODAY, 2))), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT('=' + FORMAT(ReturnTotal(TRUE))) + '/' + FORMAT(DATE2DMY(TODAY, 2)), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
    end;

    local procedure CreateExcelbook()
    begin
        /*
        ExcelBuf.CreateBook('Trash Bag sales');
        ExcelBuf.WriteSheet('Trash Bag sales',COMPANYNAME,USERID);
        ExcelBuf.CloseBook;
        ExcelBuf.OpenExcel;
        ExcelBuf.GiveUserControl;
        */

    end;

    procedure GetMonthName(Fmonth: Integer): Text[30]
    begin
        IF Fmonth = 1 THEN
            EXIT('JAN') ELSE
            IF Fmonth = 2 THEN
                EXIT('FEB') ELSE
                IF Fmonth = 3 THEN
                    EXIT('MAR')
                ELSE
                    IF Fmonth = 4 THEN
                        EXIT('APR') ELSE
                        IF Fmonth = 5 THEN
                            EXIT('MAY') ELSE
                            IF Fmonth = 6 THEN
                                EXIT('JUN')
                            ELSE
                                IF Fmonth = 7 THEN
                                    EXIT('JUL') ELSE
                                    IF Fmonth = 8 THEN
                                        EXIT('AUG') ELSE
                                        IF Fmonth = 9 THEN
                                            EXIT('SEP')
                                        ELSE
                                            IF Fmonth = 10 THEN EXIT('OCT') ELSE IF Fmonth = 11 THEN EXIT('NOV') ELSE IF Fmonth = 12 THEN EXIT('DEC');
    end;

    procedure GetMonthNameValue(Fmonth: Integer; IsPrior: Boolean): Decimal
    begin
        IF NOT IsPrior THEN BEGIN
            IF Fmonth = 1 THEN
                EXIT(JanSale)
            ELSE
                IF Fmonth = 2 THEN
                    EXIT(FebSale)
                ELSE
                    IF Fmonth = 3 THEN
                        EXIT(MarSale)
                    ELSE
                        IF Fmonth = 4 THEN
                            EXIT(AprSale)
                        ELSE
                            IF Fmonth = 5 THEN
                                EXIT(MaySale)
                            ELSE
                                IF Fmonth = 6 THEN
                                    EXIT(JunSale)
                                ELSE
                                    IF Fmonth = 7 THEN
                                        EXIT(JulSale)
                                    ELSE
                                        IF Fmonth = 8 THEN
                                            EXIT(AugSale)
                                        ELSE
                                            IF Fmonth = 9 THEN
                                                EXIT(SepSale)
                                            ELSE
                                                IF Fmonth = 10 THEN
                                                    EXIT(OctSale)
                                                ELSE
                                                    IF Fmonth = 11 THEN
                                                        EXIT(NovSale)
                                                    ELSE
                                                        IF Fmonth = 12 THEN EXIT(DecSale);
        END
        ELSE BEGIN
            IF Fmonth = 1 THEN
                EXIT(PriorJanSale)
            ELSE
                IF Fmonth = 2 THEN
                    EXIT(PriorFebSale)
                ELSE
                    IF Fmonth = 3 THEN
                        EXIT(PriorMarSale)
                    ELSE
                        IF Fmonth = 4 THEN
                            EXIT(PriorAprSale)
                        ELSE
                            IF Fmonth = 5 THEN
                                EXIT(PriorMaySale)
                            ELSE
                                IF Fmonth = 6 THEN
                                    EXIT(PriorJunSale)
                                ELSE
                                    IF Fmonth = 7 THEN
                                        EXIT(PriorJulSale)
                                    ELSE
                                        IF Fmonth = 8 THEN
                                            EXIT(PriorAugSale)
                                        ELSE
                                            IF Fmonth = 9 THEN
                                                EXIT(PriorSepSale)
                                            ELSE
                                                IF Fmonth = 10 THEN
                                                    EXIT(PriorOctSale)
                                                ELSE
                                                    IF Fmonth = 11 THEN
                                                        EXIT(PriorNovSale)
                                                    ELSE
                                                        IF Fmonth = 12 THEN EXIT(PriorDecSale);
        END;
    end;

    procedure ReturnTotal(IsPrior: Boolean): Decimal
    begin
        IF NOT IsPrior THEN
            EXIT(JanSale + FebSale + MarSale + AprSale + MaySale + JunSale + JulSale + AugSale + SepSale + OctSale + NovSale + DecSale)
        ELSE
            EXIT(PriorJanSale + PriorFebSale + PriorMarSale + PriorAprSale + PriorMaySale + PriorJunSale + PriorJulSale + PriorAugSale + PriorSepSale + PriorOctSale + PriorNovSale + PriorDecSale);
    end;

    procedure MakeExcelDataFooter()
    begin
        //Current Year
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(IntForYear) + ' TOTAL', TRUE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(TotJanSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotFebSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotMarSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotAprSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotMaySale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotJunSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotJulSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotAugSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotSepSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotOctSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotNovSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotDecSale), TRUE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);

        //Prior Year
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(FORMAT(IntForYear - 1) + ' TOTAL', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(TotPriorJanSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorFebSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorMarSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorAprSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorMaySale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorJunSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorJulSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorAugSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorSepSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorOctSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorNovSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(FORMAT(TotPriorDecSale), FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        /*
        //% Change
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(' %Change',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('=(B' + FORMAT(RowNo+1) + '-B' + FORMAT(RowNo+2) + ')/B' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(C' + FORMAT(RowNo+1) + '-C' + FORMAT(RowNo+2) + ')/C' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(D' + FORMAT(RowNo+1) + '-D' + FORMAT(RowNo+2) + ')/D' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(E' + FORMAT(RowNo+1) + '-E' + FORMAT(RowNo+2) + ')/E' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(F' + FORMAT(RowNo+1) + '-F' + FORMAT(RowNo+2) + ')/F' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(G' + FORMAT(RowNo+1) + '-G' + FORMAT(RowNo+2) + ')/G' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(H' + FORMAT(RowNo+1) + '-H' + FORMAT(RowNo+2) + ')/H' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(I' + FORMAT(RowNo+1) + '-I' + FORMAT(RowNo+2) + ')/I' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(J' + FORMAT(RowNo+1) + '-J' + FORMAT(RowNo+2) + ')/J' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(K' + FORMAT(RowNo+1) + '-K' + FORMAT(RowNo+2) + ')/K' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(L' + FORMAT(RowNo+1) + '-L' + FORMAT(RowNo+2) + ')/L' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('=(M' + FORMAT(RowNo+1) + '-M' + FORMAT(RowNo+2) + ')/M' + FORMAT(RowNo+2),FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        */

    end;
}

