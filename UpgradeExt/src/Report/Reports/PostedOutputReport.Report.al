report 50019 "Posted Output Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\PostedOutputReport.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Posted Output Report';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Entry Type", "Item No.")
                                WHERE("Entry Type" = FILTER(Output | Consumption | "Positive Adjmt." | "Negative Adjmt."));
            RequestFilterFields = "Posting Date", "Entry Type", "Document No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
            {
            }
            column(Item_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Item_Ledger_Entry__Machine_Center_Code_; "Machine Center Code")
            {
            }
            column(Item_Ledger_Entry__Lot_No__; "Lot No.")
            {
            }
            column(Summarized; Summarized)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Posted_Output_Report_Caption; Posted_Output_Report_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Entry_Type_Caption; FIELDCAPTION("Entry Type"))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Machine_Center_Caption; Machine_Center_CaptionLbl)
            {
            }
            column(Lot__Caption; Lot__CaptionLbl)
            {
            }
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
                    field(Summarized; Summarized)
                    {
                        ToolTip = 'Specifies the value of the Summarized field.';
                        ApplicationArea = all;
                        Caption = 'Summarized';
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

    var

        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Posted_Output_Report_CaptionLbl: Label 'Posted Output Report:';
        Machine_Center_CaptionLbl: Label 'Machine Center ';
        Lot__CaptionLbl: Label 'Lot #';
        Summarized: Boolean;
}

