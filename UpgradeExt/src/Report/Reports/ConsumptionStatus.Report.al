report 50014 "Consumption Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ConsumptionStatus.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Consumption Status';
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Physical Inventory Group Code";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(filters; filters)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Description_Item; Description)
            {
            }
            column(YTDCons; YTDCons)
            {
            }
            column(SixMnthAvg; SixMnthAvg)
            {
            }
            column(ThMnthAvg; ThMnthAvg)
            {
            }
            column(MonthCons_1; MonthCons[1])
            {
            }
            column(MonthCons_2; MonthCons[2])
            {
            }
            column(MonthCons_3; MonthCons[3])
            {
            }
            column(MonthCons_4; MonthCons[4])
            {
            }
            column(MonthCons_5; MonthCons[5])
            {
            }
            column(MonthCons_6; MonthCons[6])
            {
            }
            column(MonthCons_7; MonthCons[7])
            {
            }
            column(MonthCons_8; MonthCons[8])
            {
            }
            column(MonthCons_9; MonthCons[9])
            {
            }
            column(MonthCons_10; MonthCons[10])
            {
            }
            column(MonthCons_11; MonthCons[11])
            {
            }
            column(MonthCons_12; MonthCons[12])
            {
            }
            column(MonthCaption_1; MonthCaption[1])
            {
            }
            column(MonthCaption_2; MonthCaption[2])
            {
            }
            column(MonthCaption_3; MonthCaption[3])
            {
            }
            column(MonthCaption_4; MonthCaption[4])
            {
            }
            column(MonthCaption_5; MonthCaption[5])
            {
            }
            column(MonthCaption_6; MonthCaption[6])
            {
            }
            column(MonthCaption_7; MonthCaption[7])
            {
            }
            column(MonthCaption_8; MonthCaption[8])
            {
            }
            column(MonthCaption_9; MonthCaption[9])
            {
            }
            column(MonthCaption_10; MonthCaption[10])
            {
            }
            column(MonthCaption_11; MonthCaption[11])
            {
            }
            column(MonthCaption_12; MonthCaption[12])
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Phy_Inv_Grp_Code; "Physical Inventory Group Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ClearVar();
                Item_Id += 1;
                MonthLoop := 1;
                CurrMonth := DATE2DMY(Asondate, 2);
                CurrYear := DATE2DMY(Asondate, 3);

                SETFILTER("Date Filter", '%1..%2', DMY2DATE(1, 1, DATE2DMY(TODAY, 3)), TODAY);
                CALCFIELDS("Consumptions (Qty.)");
                YTDCons := "Consumptions (Qty.)";
                SETRANGE("Date Filter");

                REPEAT
                    StartDate := DMY2DATE(1, CurrMonth, CurrYear);
                    EndDate := GETMonthEndDate(CurrMonth, CurrYear);
                    SETFILTER("Date Filter", '%1..%2', StartDate, EndDate);
                    CALCFIELDS("Consumptions (Qty.)");
                    MonthCons[MonthLoop] := "Consumptions (Qty.)";
                    IF Item_Id = 1 THEN
                        MonthCaption[MonthLoop] := GetMonthCaption(CurrMonth) + ' ' + FORMAT(CurrYear);

                    CurrMonth += 1;
                    IF CurrMonth > 12 THEN BEGIN
                        CurrMonth := 1;
                        CurrYear += 1;
                    END;
                    MonthLoop += 1;
                    SETRANGE("Date Filter");
                UNTIL MonthLoop = 7;

                StartDate := DMY2DATE(1, DATE2DMY(CALCDATE('<-6M>', TODAY), 2), DATE2DMY(CALCDATE('<-6M>', TODAY), 3));
                EndDate := GETMonthEndDate(DATE2DMY(CALCDATE('<-6M>', TODAY), 2), DATE2DMY(CALCDATE('<-6M>', TODAY), 3));
                SETFILTER("Date Filter", '%1..%2', StartDate, EndDate);
                CALCFIELDS("Consumptions (Qty.)");
                MonthCons[MonthLoop] := "Consumptions (Qty.)";
                SETRANGE("Date Filter");

                SixMnthAvg := (MonthCons[7] + MonthCons[5] + MonthCons[4] + MonthCons[3] + MonthCons[2] + MonthCons[1]) / 6;
                ThMnthAvg := (MonthCons[5] + MonthCons[4] + MonthCons[3]) / 3;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Item_Id);
                Asondate := CALCDATE('<-5M>', TODAY);
                filters := GETFILTERS();
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

    var
        YTDCons: Decimal;
        MonthCons: array[12] of Decimal;
        MonthCaption: array[12] of Text[30];
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrYear: Integer;
        MonthLoop: Integer;
        Item_Id: Integer;
        Asondate: Date;
        filters: Text;
        SixMnthAvg: Decimal;
        ThMnthAvg: Decimal;


    procedure GETMonthEndDate(Month: Integer; Year: Integer): Date
    begin
        IF Month = 12 THEN
            EXIT(CALCDATE('<-1D>', DMY2DATE(1, 1, Year + 1)))
        ELSE
            EXIT(CALCDATE('<-1D>', DMY2DATE(1, Month + 1, Year)));
    end;


    procedure GetMonthCaption(Month: Integer): Text
    begin
        CASE Month OF
            1:
                EXIT('JAN');
            2:
                EXIT('FEB');
            3:
                EXIT('MAR');
            4:
                EXIT('APR');
            5:
                EXIT('MAY');
            6:
                EXIT('JUN');
            7:
                EXIT('JUL');
            8:
                EXIT('AUG');
            9:
                EXIT('SEP');
            10:
                EXIT('OCT');
            11:
                EXIT('NOV');
            12:
                EXIT('DEC');
        END;
    end;

    procedure ClearVar()
    begin
        CLEAR(YTDCons);
        CLEAR(MonthCons);
        CLEAR(SixMnthAvg);
        CLEAR(ThMnthAvg);
    end;
}

