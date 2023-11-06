report 50033 "Production Postings"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ProductionPostings.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Production Postings';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Posting Date", Shift, "Machine Center Code";
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
            column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
            {
            }
            column(Item_Ledger_Entry__Machine_Center_Code_; "Machine Center Code")
            {
            }
            column(Item_Ledger_Entry_Shift; Shift)
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Production_PostingsCaption; Production_PostingsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Entry_Type_Caption; FIELDCAPTION("Entry Type"))
            {
            }
            column(LineCaption; LineCaptionLbl)
            {
            }
            column(Item_Ledger_Entry_ShiftCaption; FIELDCAPTION(Shift))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Item Ledger Entry".Shift = '' THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                IF bOutput AND bScrap AND bConsumption THEN
                    "Item Ledger Entry".SETFILTER("Entry Type", 'Output|Positive Adjmt.|Consumption')
                ELSE
                    IF bOutput AND bScrap AND NOT bConsumption THEN
                        "Item Ledger Entry".SETFILTER("Entry Type", 'Output|Positive Adjmt.')
                    ELSE
                        IF bOutput AND NOT bScrap AND bConsumption THEN
                            "Item Ledger Entry".SETFILTER("Entry Type", 'Output|Consumption')
                        ELSE
                            IF NOT bOutput AND bScrap AND bConsumption THEN
                                "Item Ledger Entry".SETFILTER("Entry Type", 'Positive Adjmt.|Consumption')
                            ELSE
                                IF bOutput AND NOT bScrap AND NOT bConsumption THEN
                                    "Item Ledger Entry".SETFILTER("Entry Type", 'Output')
                                ELSE
                                    IF NOT bOutput AND NOT bScrap AND bConsumption THEN
                                        "Item Ledger Entry".SETFILTER("Entry Type", 'Consumption')
                                    ELSE
                                        IF NOT bOutput AND bScrap AND NOT bConsumption THEN
                                            "Item Ledger Entry".SETFILTER("Entry Type", 'Positive Adjmt.');
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
                    field(Output; bOutput)
                    {
                        ToolTip = 'Specifies the value of the bOutput field.';
                        ApplicationArea = all;
                        Caption = 'Output';
                    }
                    field(Scrap; bScrap)
                    {
                        ToolTip = 'Specifies the value of the bScrap field.';
                        ApplicationArea = all;
                        Caption = 'Scrap';
                    }
                    field(Consumption; bConsumption)
                    {
                        ToolTip = 'Specifies the value of the bConsumption field.';
                        ApplicationArea = all;
                        Caption = 'Consumption';
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
        bScrap := TRUE;
        bOutput := TRUE;
        bConsumption := TRUE;
    end;

    var
        bScrap: Boolean;
        bOutput: Boolean;
        bConsumption: Boolean;
        Production_PostingsCaptionLbl: Label 'Production Postings';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        LineCaptionLbl: Label 'Line';
}

