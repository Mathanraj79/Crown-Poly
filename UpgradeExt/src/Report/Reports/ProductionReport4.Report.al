report 50026 "Production Report 4"
{
    // //CP1002 19Jun09
    // 
    // ----------------------------------------------------------------------------------------------------------
    // ---------------------------------------------iWEB ETC-----------------------------------------------------
    // ----------------------------------------------------------------------------------------------------------
    // Task            Date             Developer                            Comments
    // ----------------------------------------------------------------------------------------------------------
    // 001             07.23.16         iWEB DJ                              To update TotalItemQty to 0 by Shift.
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ProductionReport4.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Production Report 4';
    dataset
    {
        dataitem(mc; "Machine Center")
        {
            DataItemTableView = SORTING("No.");
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(tPostDate; tPostDate)
            {
            }
            column(tShift; tShift)
            {
            }
            column(tWorkCenter; tWorkCenter)
            {
            }
            column(TotalCases; TotalCases)
            {
            }
            column(TempLine_COUNT; TempLine.COUNT)
            {
            }
            column(TotalCalcScrap; TotalCalcScrap)
            {
            }
            column(ScrapPerc; ScrapPerc)
            {
            }
            column(TotalScrap2; TotalScrap2)
            {
            }
            column(Item_Ledger_Entry___Posting_Date_; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Item_Ledger_Entry__Shift; "Item Ledger Entry".Shift)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Production_Report_Caption; Production_Report_CaptionLbl)
            {
            }
            column(Posting_Date_Caption; Posting_Date_CaptionLbl)
            {
            }
            column(Shift_Caption; Shift_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(TotalCasesCaption; TotalCasesCaptionLbl)
            {
            }
            column(TotalAdjCasesCaption; TotalAdjCasesCaptionLbl)
            {
            }
            column(Lines_RunningCaption; Lines_RunningCaptionLbl)
            {
            }
            column(Total_W_Scrap_Caption; Total_W_Scrap_CaptionLbl)
            {
            }
            column(TotalCalcScrapCaption; TotalCalcScrapCaptionLbl)
            {
            }
            column(ScrapPercCaption; ScrapPercCaptionLbl)
            {
            }
            column(Posting_Date_Caption_Control1000000066; Posting_Date_Caption_Control1000000066Lbl)
            {
            }
            column(Shift_Caption_Control1000000065; Shift_Caption_Control1000000065Lbl)
            {
            }
            column(Report_StatisticsCaption; Report_StatisticsCaptionLbl)
            {
            }
            column(mc_No_; "No.")
            {
            }
            column(Workcenter_Adj_Cases; Workcenter."Adj. Cases")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Machine Center Code" = FIELD("No.");
                DataItemTableView = SORTING(Shift, "Machine Center Code", "Item No.", "Entry Type", "Posting Date", "Work Center Code")
                                    WHERE("Entry Type" = FILTER("Output" | "Positive Adjmt."));
                RequestFilterFields = "Posting Date", "Work Center Code", Shift;
                column(PrintILE; PrintILE)
                {
                }
                column(Item_Ledger_Entry__Machine_Center_Code_; "Machine Center Code")
                {
                }
                column(txtCase; txtCase)
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry_Entry_Type; "Item Ledger Entry"."Entry Type")
                {
                }
                column(EntryType; EntryType)
                {
                }
                column(FooterPrinted; FooterPrinted)
                {
                }
                column(Item_Ledger_Entry__Item_Desciption_; "Item Desciption")
                {
                }
                column(Item_Ledger_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Routing_No; Item."Routing No.")
                {
                }
                column(TotalFor____Line__; TotalForLbl + 'Line')
                {
                }
                column(TotalOutputperline; TotalOutputperline)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(AdjCases; AdjCases)
                {
                }
                column(ScrapRate; ScrapRate)
                {
                }
                column(DownTime; DownTime)
                {
                }
                column(ConvEff; ConvEff)
                {
                }
                column(OverallEff; OverallEff)
                {
                }
                column(TotalPrintScrap___TotalClearScrap__TotalDiecustScrap; TotalPrintScrap + TotalClearScrap + TotalDiecustScrap)
                {
                }
                column(TotalResinPounds; TotalResinPounds)
                {
                }
                column(TotalScrap; TotalScrap)
                {
                }
                column(TotalResinPounds2; TotalResinPounds2)
                {
                }
                column(TotalScrap1; TotalScrap1)
                {
                }
                column(TotalClearScrap; TotalClearScrap)
                {
                }
                column(TotalPrintScrap; TotalPrintScrap)
                {
                }
                column(TotalDiecustScrap; TotalDiecustScrap)
                {
                }
                column(TotalClearScrap1; TotalClearScrap1)
                {
                }
                column(TotalPrintScrap1; TotalPrintScrap1)
                {
                }
                column(TotalDiecustScrap1; TotalDiecustScrap1)
                {
                }
                column(TotalOutput; TotalOutput)
                {
                }
                column(Line_Caption; Line_CaptionLbl)
                {
                }
                column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(ScrapRateCaption; ScrapRateCaptionLbl)
                {
                }
                column(Line_StatisticsCaption; Line_StatisticsCaptionLbl)
                {
                }
                column(DownTimeCaption; DownTimeCaptionLbl)
                {
                }
                column(ConvEffCaption; ConvEffCaptionLbl)
                {
                }
                column(OverallEffCaption; OverallEffCaptionLbl)
                {
                }
                column(Print_ScrapCaption; Print_ScrapCaptionLbl)
                {
                }
                column(Total_ScrapCaption; Total_ScrapCaptionLbl)
                {
                }
                column(Clear_ScrapCaption; Clear_ScrapCaptionLbl)
                {
                }
                column(Diecut_ScrapCaption; Diecut_ScrapCaptionLbl)
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Shift; Shift)
                {
                }
                column(TotalItemQty; TotalItemQty)
                {
                }
                dataitem("Report Incidents"; "Report Incidents")
                {
                    DataItemLink = "Posting Date" = FIELD("Posting Date"),
                                   "Shift" = FIELD("Shift"),
                                   "Machine Center" = FIELD("Machine Center Code");
                    DataItemTableView = SORTING("Posting Date", "Shift", "Machine Center");
                    column(Report_Incidents__Report_Incidents___Problem_Area_; "Report Incidents"."Problem Area")
                    {
                    }
                    column(Incident__Incident_Name_; Incident."Incident Name")
                    {
                    }
                    column(DiffTime_60000; DiffTime / 60000)
                    {
                    }
                    column(Report_Incidents__Report_Incidents__Description; "Report Incidents".Description)
                    {
                    }
                    column(Problem_Area_Caption; Problem_Area_CaptionLbl)
                    {
                    }
                    column(Incident_CodeCaption; Incident_CodeCaptionLbl)
                    {
                    }
                    column(DescriptionCaption_Control1000000030; DescriptionCaption_Control1000000030Lbl)
                    {
                    }
                    column(Diff_Time__Mins_Caption; Diff_Time__Mins_CaptionLbl)
                    {
                    }
                    column(Reporting_Incidents_for_Line_Caption; Reporting_Incidents_for_Line_CaptionLbl)
                    {
                    }
                    column(Report_Incidents_Entry_No_; "Entry No.")
                    {
                    }
                    column(PrintHeader; PrintHeader)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        DiffTime := "Report Incidents"."End Time" - "Report Incidents"."Start Time";
                        DownTime += DiffTime / 60000;
                        IF Incident.GET("Report Incidents"."Incident Code") THEN;
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempMachineCenter."No." := mc."No.";
                        IF TempMachineCenter.INSERT() THEN BEGIN
                            SETRANGE("Posting Date", "Item Ledger Entry"."Posting Date");
                            SETRANGE(Shift, "Item Ledger Entry".GETFILTER(Shift));
                            SETRANGE("Machine Center", mc."No.");
                            IF FINDFIRST() THEN
                                PrintHeader := TRUE
                            ELSE
                                PrintHeader := FALSE;
                        END ELSE BEGIN
                            CurrReport.BREAK();
                            PrintHeader := FALSE;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    LItem: Record Item;
                    LWorkCenter: Record "Work Center";
                begin
                    //CP1002 19Jun09 Start

                    //************************************************************************************//
                    // 001 START
                    IF ("Machine Center Code" <> xMCCode) OR ("Item No." <> xItemNo) OR (Shift <> xShift) THEN
                        TotalItemQty := 0;
                    // 001 END
                    TotalItemQty += "Item Ledger Entry".Quantity;
                    xMCCode := "Machine Center Code";
                    xItemNo := "Item No.";
                    // 001 START
                    xShift := Shift;
                    // 001 END
                    PrintILE := TRUE;
                    CALCFIELDS("Total Srcap %", "Total Resin Pounds", "Scarp Item");
                    //CALCFIELDS("Total Srcap %","Scarp Item");

                    IF LItem.GET("Item No.") THEN BEGIN
                        LWorkCenter.GET("Item Ledger Entry"."Work Center Code");

                        AdjCases += LItem."Rolls/Bundles per Case" * LItem."Bags per Roll/Bundle" * Quantity;
                        TotalResinPounds += "Total Resin Pounds" * Quantity;
                        TotalResinPounds2 += "Total Resin Pounds" * Quantity;

                        IF ("Entry Type" = "Entry Type"::Output) THEN BEGIN
                            TotalOutputperline += Quantity;
                            TotalOutput += Quantity;
                            TotalCases += Quantity;
                        END ELSE
                            IF ("Entry Type" = "Entry Type"::"Positive Adjmt.") AND ("Scarp Item") THEN BEGIN
                                IF (LItem."Print Scrap") AND (LItem."Clear Scrap") THEN begin
                                    TotalPrintScrap += Quantity;
                                    TotalClearScrap += Quantity;
                                    TotalScrap += Quantity;

                                    TotalPrintScrap1 += Quantity;
                                    TotalClearScrap1 += Quantity;
                                    TotalScrap1 += Quantity;
                                end ELSE BEGIN
                                    IF LItem."Clear Scrap" THEN begin 
                                        TotalClearScrap += Quantity;
                                    TotalScrap += Quantity;

                                    TotalClearScrap1 += Quantity;
                                    TotalScrap1 += Quantity;
                                END ELSE
                                IF LItem."Print Scrap" THEN BEGIN
                                    TotalPrintScrap += Quantity;
                                    TotalScrap += Quantity;

                                    TotalPrintScrap1 += Quantity;
                                    TotalScrap1 += Quantity;
                                END ELSE BEGIN
                                    IF LItem."Die Cut Scrap" THEN
                                        TotalDiecustScrap += Quantity;

                                    TotalDiecustScrap1 += Quantity;

                                END;
                            END;
                            end;



                        TempLine."No." := "Item Ledger Entry"."Machine Center Code";
                        //CP1002 19Jun09 End;

                        IF TempLine.INSERT() THEN;
                        IF Item.GET("Item No.") THEN;

                        IF ("Entry Type" = "Entry Type"::Output) THEN
                            EntryType := TRUE
                        ELSE
                            EntryType := FALSE;

                        //FooterPrinted := TRUE;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    LinesRunning := TempLine.COUNT;
                end;

                trigger OnPreDataItem()
                begin
                    IF GPostDate <> 0D THEN
                        "Item Ledger Entry".SETFILTER("Posting Date", '%1', GPostDate);
                    IF GShift <> '' THEN
                        "Item Ledger Entry".SETFILTER(Shift, GShift);
                    IF GWCCode <> '' THEN
                        "Item Ledger Entry".SETFILTER("Work Center Code", GWCCode);

                    LastFieldNo := FIELDNO("Item No.");
                    PrintILE := FALSE;
                    PrintHeader := FALSE;

                    CLEAR(xMCCode);
                    CLEAR(xItemNo);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ClearMCVariable();
                //CP1002 19Jun09 End;

                FooterPrinted := FALSE;
                IF Workcenter.GET(tWorkCenter) THEN;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Work Center No.", "Item Ledger Entry".GETFILTER("Work Center Code"));
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

    trigger OnPreReport()
    begin
        IF GPostDate <> 0D THEN
            "Item Ledger Entry".SETFILTER("Posting Date", '%1', GPostDate);
        IF GShift <> '' THEN
            "Item Ledger Entry".SETFILTER(Shift, GShift);
        IF GWCCode <> '' THEN
            "Item Ledger Entry".SETFILTER("Work Center Code", GWCCode);

        tPostDate := "Item Ledger Entry".GETFILTER("Posting Date");
        tShift := "Item Ledger Entry".GETFILTER(Shift);
        tWorkCenter := "Item Ledger Entry".GETFILTER("Work Center Code");

        IF tWorkCenter = '' THEN
            ERROR(Error001Lbl);

        IF tShift = '' THEN
            ERROR(Error002Lbl);

        IF tPostDate = '' THEN
            ERROR(Error003Lbl);
    end;

    var
        Workcenter: Record "Work Center";
        TempLine: Record Item temporary;
        //TempReportIncident: Record "Report Incidents" temporary;
        TempMachineCenter: Record "Machine Center" temporary;
        Incident: Record Incidents;
        Item: Record Item;
        tPostDate: text;
        tShift: Text;
        tWorkCenter: Text;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalForLbl: Label 'Total for ';
        // PrintScrap: Decimal;
        // ClearScrap: Decimal;
        TotalScrap: Decimal;
        TotalCases: Decimal;
        AdjCases: Decimal;
        TotalCalcScrap: Decimal;
        ScrapPerc: Decimal;
        TotalResinPounds: Decimal;
        LinesRunning: Integer;
        // NoofLines: Integer;
        // ProbDesc: Text[30];
        DiffTime: Integer;
        txtCase: Text[30];
        //WorkCentercode: Code[20];
        TotalPrintScrap: Decimal;
        TotalClearScrap: Decimal;
        //TotalScrappercentage: Decimal;
        ConvEff: Decimal;
        OverallEff: Decimal;
        ScrapRate: Decimal;
        DownTime: Decimal;
        //TotalAdjCases: Decimal;
        TotalOutput: Decimal;
        TotalOutputperline: Decimal;

        PrintHeader: Boolean;
        TotalScrap2: Decimal;
        TotalDiecustScrap: Decimal;

        TotalResinPounds2: Decimal;
        TotalScrap1: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Production_Report_CaptionLbl: Label 'Production Report:';
        Posting_Date_CaptionLbl: Label 'Posting Date:';
        Shift_CaptionLbl: Label 'Shift:';
        Department_CaptionLbl: Label 'Department:';
        TotalCasesCaptionLbl: Label 'Total Cases:';
        TotalAdjCasesCaptionLbl: Label 'Adj Cases:';
        Lines_RunningCaptionLbl: Label 'Lines Running';
        Total_W_Scrap_CaptionLbl: Label 'Total W Scrap:';
        TotalCalcScrapCaptionLbl: Label 'Total Calc Scrap:';
        ScrapPercCaptionLbl: Label 'Percent Scrap:';
        Posting_Date_Caption_Control1000000066Lbl: Label 'Posting Date:';
        Shift_Caption_Control1000000065Lbl: Label 'Shift:';
        Report_StatisticsCaptionLbl: Label 'Report Statistics';
        Line_CaptionLbl: Label 'Line:';
        DescriptionCaptionLbl: Label 'Description';
        ScrapRateCaptionLbl: Label 'Scrap Rate';
        Line_StatisticsCaptionLbl: Label 'Line Statistics';
        DownTimeCaptionLbl: Label 'Down Time:';
        ConvEffCaptionLbl: Label 'Conversion Efficiency:';
        OverallEffCaptionLbl: Label 'Overall Efficiency:';
        Print_ScrapCaptionLbl: Label 'Print Scrap';
        Total_ScrapCaptionLbl: Label 'Total Scrap';
        Clear_ScrapCaptionLbl: Label 'Clear Scrap';
        Diecut_ScrapCaptionLbl: Label 'Diecut Scrap';
        Problem_Area_CaptionLbl: Label 'Problem Area:';
        Incident_CodeCaptionLbl: Label 'Incident Code';
        DescriptionCaption_Control1000000030Lbl: Label 'Description';
        Diff_Time__Mins_CaptionLbl: Label 'Diff Time (Mins)';
        Reporting_Incidents_for_Line_CaptionLbl: Label 'Reporting Incidents for Line:';
        EntryType: Boolean;

        PrintILE: Boolean;
        // MachineCentre: Code[20];
        Error001Lbl: Label 'Please select "Work Center Code"';
        Error002Lbl: Label 'Please select "Shift"';
        Error003Lbl: Label 'Please select "Posting Date"';
        TotalDiecustScrap1: Decimal;
        TotalPrintScrap1: Decimal;
        TotalClearScrap1: Decimal;
        TotalItemQty: Decimal;
        xMCCode: Code[20];
        xItemNo: Code[20];
        xShift: Code[10];
        GPostDate: Date;
        GShift: Text[30];
        GWCCode: Text[30];

    procedure ClearMCVariable()
    begin
        //CP1002 19Jun09 Start

        TotalResinPounds := 0;
        TotalScrap := 0;
        TotalClearScrap := 0;
        TotalPrintScrap := 0;
        TotalDiecustScrap := 0;
        TotalOutputperline := 0;

        //CP1002 19Jun09 End

        DownTime := 0;
    end;

    procedure InitParameters(LShift: Code[20]; LPostDate: Date; LWCCode: Code[20])
    begin
        GPostDate := LPostDate;
        GShift := LShift;
        GWCCode := LWCCode;
    end;
}

