report 50018 "Excess Inventory Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ExcessInventoryReport.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Excess Inventory Report';
    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory;
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE(Inventory = FILTER(> 0));
            RequestFilterFields = "No.";
            column(No_Item; Item."No.")
            {
            }
            column(Inventory_Item; Item.Inventory)
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(RepCaption; RepCaptionLbl)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesShipmentLine.RESET();
                SalesShipmentLine.SETFILTER(SalesShipmentLine."Shipment Date", '%1..%2', CALCDATE('<-6M>', WORKDATE()), WORKDATE());
                SalesShipmentLine.SETFILTER(SalesShipmentLine.Type, '%1', SalesShipmentLine.Type::Item);
                SalesShipmentLine.SETRANGE(SalesShipmentLine."No.", Item."No.");
                IF SalesShipmentLine.FINDFIRST() THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();
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
        SalesShipmentLine: Record "Sales Shipment Line";
        CompInfo: Record "Company Information";
        RepCaptionLbl: Label 'Excess Inventory Report';

}

