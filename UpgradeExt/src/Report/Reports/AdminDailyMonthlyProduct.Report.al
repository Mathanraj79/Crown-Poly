report 50006 "Admin Daily Monthly Product"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\AdminDailyMonthlyProduct.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Admin Daily Monthly Product';
    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            column(Item_Journal_Line___Machine_Center_Code_; "Item Journal Line"."Machine Center Code")
            {
            }
            column(Item_Journal_Line__Quantity; "Item Journal Line".Quantity)
            {
            }
            column(Item_Journal_Line__Adjustment; "Item Journal Line".Adjustment)
            {
            }
            column(Item_Journal_Line___Scrap_Quantity_; "Item Journal Line"."Scrap Quantity")
            {
            }
            column(Item_Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Item_Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Item_Journal_Line_Line_No_; "Line No.")
            {
            }
            column(FORMAT_WORKDATE_; FORMAT(WORKDATE()))
            {
            }
            column(Admin_Daily_Monthly_Product_Totals_Caption; Admin_Daily_Monthly_Product_Totals_CaptionLbl)
            {
            }
            column(LineCaption; LineCaptionLbl)
            {
            }
            column(UnitsCaption; UnitsCaptionLbl)
            {
            }
            column(Adj_CasesCaption; Adj_CasesCaptionLbl)
            {
            }
            column(Eff_Caption; Eff_CaptionLbl)
            {
            }
            column(ScrapCaption; ScrapCaptionLbl)
            {
            }
            column(Mo_Eff_Caption; Mo_Eff_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                SETRANGE("Journal Template Name", 'OUTPUT');
                SETRANGE("Journal Batch Name", 'DEFAULT');
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
        Admin_Daily_Monthly_Product_Totals_CaptionLbl: Label 'Admin Daily/Monthly Product Totals:';
        LineCaptionLbl: Label 'Line';
        UnitsCaptionLbl: Label 'Units';
        Adj_CasesCaptionLbl: Label 'Adj Cases';
        Eff_CaptionLbl: Label 'Eff%';
        ScrapCaptionLbl: Label 'Scrap';
        Mo_Eff_CaptionLbl: Label 'Mo Eff%';
}

