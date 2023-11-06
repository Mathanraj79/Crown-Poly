report 50030 "Consumption Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ConsumptionReport.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Consumption Report';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Posting Date", Shift;
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
            column(Item_Ledger_Entry__Lot_No__; "Lot No.")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Item_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Item_Ledger_Entry_Shift; Shift)
            {
            }
            column(Item_Ledger_Entry__Machine_Center_Code_; "Machine Center Code")
            {
            }
            column(Consumption_ReportCaption; Consumption_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Lot_No__Caption; FIELDCAPTION("Lot No."))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(ShiftCaption; ShiftCaptionLbl)
            {
            }
            column(Line__Caption; Line__CaptionLbl)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                SETFILTER("Entry Type", 'Consumption');
                SETFILTER("Item No.", 'MRT30000..MST99999MASTER');
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
        Consumption_ReportCaptionLbl: Label 'Consumption Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ShiftCaptionLbl: Label 'Shift';
        Line__CaptionLbl: Label 'Line #';
}

