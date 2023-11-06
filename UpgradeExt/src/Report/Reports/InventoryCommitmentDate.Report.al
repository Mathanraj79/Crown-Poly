report 50009 "Inventory Commitment - Date"
{
    // SCSFN
    //   -  Inventory Commitment by Date
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\InventoryCommitmentDate.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inventory Commitment - Date';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Shipment Date")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Shipment Date", "Location Code";
            column(TIME; TIME)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Page_No______FORMAT_CurrReport_PAGENO_; 'Page No. ' + FORMAT(CurrReport.PAGENO()))
            {
            }
            column(INVENTORY_COMMITMENT_BY_DATECaption; INVENTORY_COMMITMENT_BY_DATECaptionLbl)
            {
            }
            column(DailyTotal; DailyTotal)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            column(Sales_Header__Shipment_Date_; "Shipment Date")
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(CommittedCaption; CommittedCaptionLbl)
            {
            }
            column(Requested_Del_DateCaption; Requested_Del_DateCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Customer_POCaption; Customer_POCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Shipment_DateCaption; Shipment_DateCaptionLbl)
            {
            }
            column(Daily_TotalCaption; Daily_TotalCaptionLbl)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order),
                                          Type = CONST(Item),
                                          "No." = FILTER(<> ''));
                RequestFilterFields = "No.";
                column(Sales_Header___Shipment_Date_; "Sales Header"."Shipment Date")
                {
                }
                column(Sales_Line__Document_No__; "Document No.")
                {
                }
                column(ExtDocNo; ExtDocNo)
                {
                }
                column(SalesHeader__Bill_to_Name_; SalesHeader."Bill-to Name")
                {
                }
                column(Sales_Line__No__; "No.")
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Committed; Committed)
                {
                }
                column(Sales_Line__Requested_Delivery_Date_; "Requested Delivery Date")
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Line_Unit_Price; "Unit Price")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Committed := 0;
                    Committed := Quantity - "Quantity Shipped";
                    DailyTotal += Committed;
                    ExtDocNo := '';
                    IF SalesHeader.GET("Document Type"::Order, "Document No.") THEN
                        ExtDocNo := SalesHeader."External Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(Committed);
                end;
            }
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
        SalesHeader: Record "Sales Header";
        Committed: Decimal;
        ExtDocNo: Code[35];

        DailyTotal: Decimal;
        INVENTORY_COMMITMENT_BY_DATECaptionLbl: Label 'INVENTORY COMMITMENT BY DATE';
        DescriptionCaptionLbl: Label 'Description';
        CommittedCaptionLbl: Label 'Committed';
        Requested_Del_DateCaptionLbl: Label 'Requested Del Date';
        Order_No_CaptionLbl: Label 'Order No.';
        Customer_POCaptionLbl: Label 'Customer PO';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Item_No_CaptionLbl: Label 'Item No.';
        Shipment_DateCaptionLbl: Label 'Shipment Date';
        Daily_TotalCaptionLbl: Label 'Daily Total';
}

