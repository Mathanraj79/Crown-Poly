report 50000 "Shipping Log"
{
    // 
    // SCSFN
    //   - Added BOL No. and Pro No.
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ShippingLog.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Shipping Log';
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("Order No.");
            RequestFilterFields = "No.", "Posting Date", "Sell-to Customer No.";
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
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            column(Sales_Shipment_Header__Order_No__; "Order No.")
            {
            }
            column(Sales_Shipment_Header__External_Document_No__; "External Document No.")
            {
            }
            column(Sales_Shipment_Header___Ship_to_Name_; "Sales Shipment Header"."Ship-to Name")
            {
            }
            column(Sales_Shipment_Header_Weight; Weight)
            {
            }
            column(TotalCases; TotalCases)
            {
            }
            column(Sales_Shipment_Header___Freight_Bills_; "Sales Shipment Header"."Freight Bills")
            {
            }
            column(Sales_Shipment_Header___Shipping_Agent_Code_; "Sales Shipment Header"."Shipping Agent Code")
            {
            }
            column(Sales_Shipment_Header___Shipment_Date_; "Sales Shipment Header"."Shipment Date")
            {
            }
            column(Sales_Shipment_Header___Posting_Date_; "Sales Shipment Header"."Posting Date")
            {
            }
            column(ShipStatus; ShipStatus)
            {
            }
            column(Sales_Shipment_Header___Requested_Delivery_Date_; "Sales Shipment Header"."Requested Delivery Date")
            {
            }
            column(Sales_Shipment_Header___Actual_Delivery_Date_; "Sales Shipment Header"."Actual Delivery Date")
            {
            }
            column(DelvStatus; DelvStatus)
            {
            }
            column(Sales_Shipment_Header___BOL_No__; "Sales Shipment Header"."BOL No.")
            {
            }
            column(Sales_Shipment_Header___Package_Tracking_No__; "Sales Shipment Header"."Package Tracking No.")
            {
            }
            column(TotalPallets; TotalPallets)
            {
                DecimalPlaces = 0 : 0;
            }
            column(CaseLBS; CaseLBS)
            {
            }
            column(Shipping_LogCaption; Shipping_LogCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(W_O_Caption; W_O_CaptionLbl)
            {
            }
            column(P_O_Caption; P_O_CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(WeightCaption; WeightCaptionLbl)
            {
            }
            column(Total_CSCaption; Total_CSCaptionLbl)
            {
            }
            column(Total_PLTSCaption; Total_PLTSCaptionLbl)
            {
            }
            column(Freight_CostCaption; Freight_CostCaptionLbl)
            {
            }
            column(Cost_per_LBSCaption; Cost_per_LBSCaptionLbl)
            {
            }
            column(CarrierCaption; CarrierCaptionLbl)
            {
            }
            column(PRO__Caption; PRO__CaptionLbl)
            {
            }
            column(Est_Ship_DateCaption; Est_Ship_DateCaptionLbl)
            {
            }
            column(Actual_Ship_DateCaption; Actual_Ship_DateCaptionLbl)
            {
            }
            column(Ship_StatusCaption; Ship_StatusCaptionLbl)
            {
            }
            column(Req_Delv_DateCaption; Req_Delv_DateCaptionLbl)
            {
            }
            column(Actual_Delv_DateCaption; Actual_Delv_DateCaptionLbl)
            {
            }
            column(Delv_StatusCaption; Delv_StatusCaptionLbl)
            {
            }
            column(BOL_No_Caption; BOL_No_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ShipStatus := '';
                DelvStatus := '';
                i := 0; //SCSFN
                ProNumber := ''; //SCSFN
                TotalCases := 0;
                TotalPallets := 0;
                TotalNetWeight := 0;
                SalesShipmentLine.INIT();
                SalesShipmentLine.RESET();
                SalesShipmentLine.SETRANGE("Document No.", "No.");
                IF SalesShipmentLine.FIND('-') THEN
                    REPEAT
                        i += 1; //SCSFN
                        IF SalesShipmentLine.Type = SalesShipmentLine.Type::Item THEN
                            ItemRec.INIT();
                        IF ItemRec.GET(SalesShipmentLine."No.") THEN
                            IF ItemRec."Item Category Code" = 'FG' THEN
                                TotalCases += SalesShipmentLine.Quantity;
                        IF ItemRec."Case Count" <> 0 THEN
                            TotalPallets += SalesShipmentLine.Quantity / ItemRec."Case Count";
                        TotalNetWeight += SalesShipmentLine.Quantity * SalesShipmentLine."Net Weight";
                        //SCSFN BEGIN
                        IF i = 1 THEN
                            ProNumber := SalesShipmentLine."Package Tracking No.";
                    //SCSFN END
                    UNTIL SalesShipmentLine.NEXT() = 0;

                IF "Shipment Date" > "Posting Date" THEN
                    ShipStatus := 'EARLY'
                ELSE
                    IF "Shipment Date" < "Posting Date" THEN
                        ShipStatus := 'LATE'
                    ELSE
                        ShipStatus := 'ON TIME';


                IF "Requested Delivery Date" > "Actual Delivery Date" THEN
                    ShipStatus := 'EARLY'
                ELSE
                    IF "Requested Delivery Date" < "Actual Delivery Date" THEN
                        ShipStatus := 'LATE'
                    ELSE
                        ShipStatus := 'ON TIME';


                IF Weight <> 0 THEN
                    CaseLBS := ROUND("Freight Bills" / Weight, 0.01)
                ELSE
                    CaseLBS := 0;

                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, "Order No.", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, "External Document No.", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, "Ship-to Name", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 4, "Ship-to City", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 5, "Ship-to County", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 6, "Ship-to Post Code", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 7, FORMAT(Weight), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 8, FORMAT(TotalCases), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 9, FORMAT(TotalPallets), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 10, FORMAT("Freight Bills"), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 11, FORMAT(CaseLBS), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    EnterCell(RowNo, 12, FORMAT("Shipping Agent Code"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 13, FORMAT("Package Tracking No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 14, FORMAT("Shipment Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    EnterCell(RowNo, 15, FORMAT("Posting Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    EnterCell(RowNo, 16, ShipStatus, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 17, FORMAT("Requested Delivery Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    EnterCell(RowNo, 18, FORMAT("Actual Delivery Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    EnterCell(RowNo, 19, DelvStatus, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 20, "BOL No.", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);  //SCSFN
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    //   TempExcelBuffer.CreateBook('Shipping Log');
                    //   TempExcelBuffer.UpdateBook('Shipping Log','Shipping Log');
                    //   TempExcelBuffer.CreateBookAndOpenExcel('Shipping Log','Shipping Log',COMPANYNAME,USERID);

                    // TempExcelBuffer.GiveUserControl; charmee comment 
                    TempExcelBuffer.CreateNewBook('Shipping Log');
                    TempExcelBuffer.WriteSheet('Shipping Log', CompanyName, UserId);
                    TempExcelBuffer.CloseBook();
                    TempExcelBuffer.OpenExcel();
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'W/O#', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, 'P.O#', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, 'Customer Name', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 4, 'City', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 5, 'State', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 6, 'Zip', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 7, 'Weight', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 8, 'Total CS', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 9, 'Total PLTS', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 10, 'Freight Cost', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 11, 'Cost per LBS', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 12, 'Carrier', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 13, 'Pro #', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 14, 'Est. Ship Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 15, 'Actual Ship Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 16, 'Ship Status', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 17, 'Req. Delv Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 18, 'Actual Delv Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 19, 'Delv Status', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 20, 'BOL No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text); //SCSFN
                END;
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
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print To Excel';
                        ToolTip = 'Specifies the value of the Print To Excel field.';
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

    var
        ItemRec: Record Item;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SalesShipmentLine: Record "Sales Shipment Line";
        ShipStatus: Text[30];
        DelvStatus: Text[30];
        ProNumber: Text[30];
        TotalCases: Decimal;
        TotalNetWeight: Decimal;
        TotalPLTS: Decimal;
        TotalPallets: Decimal;
        CaseLBS: Decimal;
        Shipping_LogCaptionLbl: Label 'Shipping Log';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        W_O_CaptionLbl: Label 'W/O#';
        P_O_CaptionLbl: Label 'P.O#';
        Customer_NameCaptionLbl: Label 'Customer Name';
        WeightCaptionLbl: Label 'Weight';
        Total_CSCaptionLbl: Label 'Total CS';
        Total_PLTSCaptionLbl: Label 'Total PLTS';
        Freight_CostCaptionLbl: Label 'Freight Cost';
        Cost_per_LBSCaptionLbl: Label 'Cost per LBS';
        CarrierCaptionLbl: Label 'Carrier';
        PRO__CaptionLbl: Label 'PRO #';
        Est_Ship_DateCaptionLbl: Label 'Est Ship Date';
        Actual_Ship_DateCaptionLbl: Label 'Actual Ship Date';
        Ship_StatusCaptionLbl: Label 'Ship Status';
        Req_Delv_DateCaptionLbl: Label 'Req Delv Date';
        Actual_Delv_DateCaptionLbl: Label 'Actual Delv Date';
        Delv_StatusCaptionLbl: Label 'Delv Status';
        BOL_No_CaptionLbl: Label 'BOL No.';
        RowNo: Integer;
        i: Integer;
        PrintToExcel: Boolean;

    local procedure EnterCell(RowNumber: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNumber);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := Format;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.INSERT();
    end;
}

