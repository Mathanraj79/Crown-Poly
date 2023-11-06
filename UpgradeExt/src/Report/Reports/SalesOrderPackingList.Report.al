report 50025 "Sales Order Packing List"
{
    // SCS1.1 Add Logo
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\SalesOrderPackingList.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Order';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            column(TOTAL_CASES______FORMAT_TotalCases_; 'TOTAL CASES: ' + FORMAT(TotalCases))
            {
            }
            column(TOTAL_PALLETS______FORMAT_TotalPallets_; 'TOTAL PALLETS: ' + FORMAT(TotalPallets))
            {
            }
            column(Shiptoaddress2_Notes; Shiptoaddress2.Notes)
            {
            }
            column(REQUESTED_DEL__DATE____FORMAT__Sales_Header___Requested_Delivery_Date__; 'REQUESTED DEL. DATE:' + FORMAT("Sales Header"."Requested Delivery Date"))
            {
            }
            column(ITEM_NO_Caption; ITEM_NO_CaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(QUANTITY_ORDEREDCaption; QUANTITY_ORDEREDCaptionLbl)
            {
            }
            column(QUANTITY_BACK_ORDERCaption; QUANTITY_BACK_ORDERCaptionLbl)
            {
            }
            column(QUANTITY_SHIPPEDCaption; QUANTITY_SHIPPEDCaptionLbl)
            {
            }
            column(V5700_Bickett_St____Huntington_Park__CA__90255_; '5700 Bickett St.,  Huntington Park, CA  90255')
            {
            }
            column(BillToAddress_1_; BillToAddress[1])
            {
            }
            column(BillToAddress_2_; BillToAddress[2])
            {
            }
            column(BillToAddress_3_; BillToAddress[3])
            {
            }
            column(BillToAddress_4_; BillToAddress[4])
            {
            }
            column(BillToAddress_5_; BillToAddress[5])
            {
            }
            column(BillToAddress_6_; BillToAddress[6])
            {
            }
            column(BillToAddress_7_; BillToAddress[7])
            {
            }
            column(ShipToAddress_1_; ShipToAddress[1])
            {
            }
            column(ShipToAddress_2_; ShipToAddress[2])
            {
            }
            column(ShipToAddress_3_; ShipToAddress[3])
            {
            }
            column(ShipToAddress_4_; ShipToAddress[4])
            {
            }
            column(ShipToAddress_5_; ShipToAddress[5])
            {
            }
            column(ShipToAddress_6_; ShipToAddress[6])
            {
            }
            column(ShipToAddress_7_; ShipToAddress[7])
            {
            }
            column(Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
            {
            }
            column(SalesPurchPerson_Name; SalesPurchPerson.Name)
            {
            }
            column(BillToAddress_8_; BillToAddress[8])
            {
            }
            column(ShipToAddress_8_; ShipToAddress[8])
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(Sales_Header___Order_Date_; "Sales Header"."Order Date")
            {
            }
            column(Sales_Header___Shipment_Date_; "Sales Header"."Shipment Date")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(Sales_Header___Location_Code_; "Sales Header"."Location Code")
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(Tel__323_585_5522_______Fax__323_585_7707_; 'Tel: 323.585.5522   -   Fax: 323.585.7707')
            {
            }
            column(Sales_Header___Sell_to_Contact_; "Sales Header"."Sell-to Contact")
            {
            }
            column(txtBroker; txtBroker)
            {
            }
            column(FOB_Description; FOB.Description)
            {
            }
            column(Sales_Header___No__; "Sales Header"."No.")
            {
            }
            column(HeaderBroker; HeaderBroker)
            {
            }
            column(S_O_L_D___T_OCaption; S_O_L_D___T_OCaptionLbl)
            {
            }
            column(PURCHASE_ORDER_NO_Caption; PURCHASE_ORDER_NO_CaptionLbl)
            {
            }
            column(SALESPERSONCaption; SALESPERSONCaptionLbl)
            {
            }
            column(S_H_I_P__T_OCaption; S_H_I_P__T_OCaptionLbl)
            {
            }
            column(PACKING_LISTCaption; PACKING_LISTCaptionLbl)
            {
            }
            column(Ship_ViaCaption; Ship_ViaCaptionLbl)
            {
            }
            column(TERMSCaption; TERMSCaptionLbl)
            {
            }
            column(ORDER_DATECaption; ORDER_DATECaptionLbl)
            {
            }
            column(SCHED_SHIP_DATE_WEEK_OFCaption; SCHED_SHIP_DATE_WEEK_OFCaptionLbl)
            {
            }
            column(PAGE_NO_Caption; PAGE_NO_CaptionLbl)
            {
            }
            column(CUST__NOCaption; CUST__NOCaptionLbl)
            {
            }
            column(F_O_B_Caption; F_O_B_CaptionLbl)
            {
            }
            column(BUYERCaption; BUYERCaptionLbl)
            {
            }
            column(EST__SHIPMENT_DATECaption; EST__SHIPMENT_DATECaptionLbl)
            {
            }
            column(LOCATIONCaption; LOCATIONCaptionLbl)
            {
            }
            column(SALES_ORDER_NO_Caption; SALES_ORDER_NO_CaptionLbl)
            {
            }
            column(PageLoop_Number; PageLoop.Number)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order));

                trigger OnAfterGetRecord()
                begin
                    //SCSFN 112807
                    IF ("Outstanding Quantity" = 0) AND (Type = Type::Item) THEN
                        CurrReport.SKIP();
                    //SCSFN 112807

                    TempSalesLine := "Sales Line";
                    TempSalesLine.INSERT();
                    HighestLineNo := "Line No.";
                    IF "Sales Header"."Tax Area Code" <> '' THEN
                        SalesTaxCalc.AddSalesLine(TempSalesLine);
                end;

                trigger OnPostDataItem()
                begin
                    IF "Sales Header"."Tax Area Code" <> '' THEN BEGIN
                        SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
                        SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                        BrkIdx := 0;
                        PrevPrintOrder := 0;
                        PrevTaxPercent := 0;
                        TempSalesTaxAmtLine.RESET();
                        TempSalesTaxAmtLine.SETCURRENTKEY(TempSalesTaxAmtLine."Print Order", TempSalesTaxAmtLine."Tax Area Code for Key", TempSalesTaxAmtLine."Tax Jurisdiction Code");
                        IF TempSalesTaxAmtLine.FIND('-') THEN
                            REPEAT
                                IF (TempSalesTaxAmtLine."Print Order" = 0) OR
                                   (TempSalesTaxAmtLine."Print Order" <> PrevPrintOrder) OR
                                   (TempSalesTaxAmtLine."Tax %" <> PrevTaxPercent)
                                THEN BEGIN
                                    BrkIdx := BrkIdx + 1;
                                    IF BrkIdx > 1 THEN
                                        IF TaxArea."Country/Region" = TaxArea."Country/Region"::CA THEN
                                            BreakdownTitle := Text006Lbl
                                        ELSE
                                            BreakdownTitle := Text003Lbl;
                                    IF BrkIdx > ARRAYLEN(BreakdownAmt) THEN BEGIN
                                        BrkIdx := BrkIdx - 1;
                                        BreakdownLabel[BrkIdx] := Text004Lbl;
                                    END ELSE
                                        BreakdownLabel[BrkIdx] := STRSUBSTNO(TempSalesTaxAmtLine."Print Description", TempSalesTaxAmtLine."Tax %");
                                END;
                                BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + TempSalesTaxAmtLine."Tax Amount";
                            UNTIL TempSalesTaxAmtLine.NEXT() = 0;
                        IF BrkIdx = 1 THEN BEGIN
                            CLEAR(BreakdownLabel);
                            CLEAR(BreakdownAmt);
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesLine.RESET();
                    TempSalesLine.DELETEALL();
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    WHERE("Document Type" = CONST(Order),
                                          "Print On Order Confirmation" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine.INIT();
                    TempSalesLine."Document Type" := "Sales Header"."Document Type";
                    TempSalesLine."Document No." := "Sales Header"."No.";
                    TempSalesLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesLine."Line No.";
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                        TempSalesLine.Description := Comment;
                        TempSalesLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                    END;
                    TempSalesLine.INSERT();
                end;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CopyNo; CopyNo)
                    {
                    }
                    dataitem(SalesLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(STRSUBSTNO_Text001_CurrReport_PAGENO___1_; STRSUBSTNO(Text001Lbl, CurrReport.PAGENO() - 1))
                        {
                        }
                        column(TempSalesLine__No__; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLine_Quantity; TempSalesLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesLine_Description_________TempSalesLine__Description_2_; TempSalesLine.Description + ' ' + TempSalesLine."Description 2")
                        {
                        }
                        column(QtyBackOrdered; QtyBackOrdered)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesLine__Qty__to_Ship_; TempSalesLine."Qty. to Ship")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(STRSUBSTNO_Text002_CurrReport_PAGENO___1_; STRSUBSTNO(Text002Lbl, CurrReport.PAGENO() + 1))
                        {
                        }
                        column(SalesLine_Number; Number)
                        {
                        }
                        column(Printfooter; PrintFooter)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF OnLineNumber = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT();

                            IF TempSalesLine.Type = TempSalesLine.Type::" " THEN BEGIN
                                TempSalesLine."No." := '';
                                TempSalesLine."Unit of Measure" := '';
                                TempSalesLine."Line Amount" := 0;
                                TempSalesLine."Inv. Discount Amount" := 0;
                                TempSalesLine.Quantity := 0;
                            END ELSE
                                IF TempSalesLine.Type = TempSalesLine.Type::"G/L Account" THEN
                                    TempSalesLine."No." := '';

                            TaxAmount := TempSalesLine."Amount Including VAT" - TempSalesLine.Amount;
                            IF TaxAmount <> 0 THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := TempSalesLine.Amount;
                            END ELSE BEGIN
                                TaxFlag := FALSE;
                                TaxLiable := 0;
                            END;

                            AmountExclInvDisc := TempSalesLine."Line Amount";
                            //SCSML START
                            IF TempSalesLine.Type = TempSalesLine.Type::Item THEN BEGIN
                                IF Item.GET(TempSalesLine."No.") THEN
                                    IF Item."Item Category Code" = 'FG' THEN
                                        TotalCases += (TempSalesLine.Quantity - TempSalesLine."Quantity Shipped");
                                Item.INIT();
                                IF Item.GET(TempSalesLine."No.") THEN
                                    IF Item."Case Count" <> 0 THEN
                                        TotalPallets += TempSalesLine.Quantity / Item."Case Count";
                            END;
                            //SCSML END
                            IF TempSalesLine.Quantity = 0 THEN
                                UnitPriceToPrint := 0
                            // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / TempSalesLine.Quantity, 0.00001);


                            QtyBackOrdered := 0;
                            //IF TempSalesLine."Quantity Shipped" <> 0 THEN
                            QtyBackOrdered := TempSalesLine.Quantity - TempSalesLine."Qty. to Ship" - TempSalesLine."Quantity Shipped";

                            IF OnLineNumber = NumberOfLines THEN PrintFooter := TRUE;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TotalPallets := ROUND(TotalPallets, 1, '>');
                            CLEAR(Shiptoaddress2);
                            IF Shiptoaddress2.GET(Shiptoaddress2."Customer No.", Shiptoaddress2.Code) THEN;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable, TaxAmount, AmountExclInvDisc, TempSalesLine."Line Amount", TempSalesLine."Inv. Discount Amount");
                            NumberOfLines := TempSalesLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                            TotalCases := 0;
                            TotalPallets := 0;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    //SalesPost: Codeunit 80;
                begin
                   // CurrReport.PAGENO := 1;

                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            SalesPrinted.RUN("Sales Header");
                        CurrReport.BREAK();
                    END ELSE
                        CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000Lbl;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF PrintCompany THEN BEGIN
                    IF RespCenter.GET("Responsibility Center") THEN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                    CompanyInformation."Phone No." := RespCenter."Phone No.";
                    CompanyInformation."Fax No." := RespCenter."Fax No.";
                END;
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                //SCSML START
                txtBroker := '';
                HeaderBroker := '';
                IF "Sales Header"."Broker 1" <> '' THEN BEGIN
                    HeaderBroker := 'BROKER';
                    Broker.INIT();
                    IF Broker.GET("Sales Header"."Broker 1") THEN
                        txtBroker := FORMAT(Broker.Name);
                END
                ELSE BEGIN
                    HeaderBroker := 'TERRITORY';
                    Customer.INIT();
                    IF Customer.GET("Sales Header"."Sell-to Customer No.") THEN BEGIN
                        Territory.INIT();
                        IF Territory.GET(Customer."Territory Code") THEN
                            txtBroker := FORMAT(Territory.Name);
                    END;
                END;

                FOB.INIT();
                IF FOB.GET("Sales Header"."F.O.B.") THEN;
                //SCSML END

                IF "Salesperson Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Salesperson Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;

                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008Lbl;
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    CASE TaxArea."Country/Region" OF
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005Lbl;
                        TaxArea."Country/Region"::CA:
                            BEGIN
                                TotalTaxLabel := Text007Lbl;
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            END;
                    END;
                    SalesTaxCalc.StartSalesTaxCalculation();
                END;

                IF "Posting Date" <> 0D THEN
                    UseDate := "Posting Date"
                ELSE
                    UseDate := WORKDATE();
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET('');
                //SCS1.1
                PrintCompany := TRUE;
                CompanyInformation.CALCFIELDS(Picture);
                //

                IF PrintCompany THEN
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                ELSE
                    CLEAR(CompanyAddress);
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
                    field("Number of Copies"; NoCopies)
                    {
                        ToolTip = 'Specifies the value of the NoCopies field.';
                        caption = 'Number of Copies';
                        ApplicationArea = all;
                    }
                    field("Print Company Address"; PrintCompany)
                    {
                        ToolTip = 'Specifies the value of the PrintCompany field.';
                        caption = 'Print Company Address';
                        ApplicationArea = all;
                    }
                    field("Archive Document"; ArchiveDocument)
                    {
                        ToolTip = 'Specifies the value of the ArchiveDocument field.';
                        caption = 'Archive Document';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin

                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ToolTip = 'Specifies the value of the LogInteraction field.';
                        caption = 'Log Interaction';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin

                            IF LogInteraction THEN
                                ArchiveDocument := TRUE;
                        end;
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
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        TempSalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Broker: Record "Salesperson/Purchaser";
        Territory: Record Territory;
        Customer: Record Customer;
        FOB: Record FOB;
        Item: Record Item;
        Shiptoaddress2: Record "Ship-to Address";
        SalesPrinted: Codeunit "Sales-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        Text000Lbl: Label 'COPY';
        Text001Lbl: Label 'Transferred from page %1', Comment = '%1';
        Text002Lbl: Label 'Transferred to page %1', Comment = '%1';
        Text003Lbl: Label 'Sales Tax Breakdown:';
        Text004Lbl: Label 'Other Taxes';
        Text005Lbl: Label 'Total Sales Tax:';
        Text006Lbl: Label 'Tax Breakdown:';
        Text007Lbl: Label 'Total Tax:';
        Text008Lbl: Label 'Tax:';
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        TaxRegNo: Text[30];
        TaxRegLabel: Text;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        HeaderBroker: Text[50];
        UseDate: Date;
        txtBroker: Code[50];
        TotalCases: Decimal;
        TotalPallets: Decimal;
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        TaxAmount: Decimal;
        BreakdownAmt: array[4] of Decimal;
        PrevTaxPercent: Decimal;
        QtyBackOrdered: Decimal;
        S_O_L_D___T_OCaptionLbl: Label 'S O L D  T O';
        PURCHASE_ORDER_NO_CaptionLbl: Label 'PURCHASE ORDER NO.';
        SALESPERSONCaptionLbl: Label 'SALESPERSON';
        S_H_I_P__T_OCaptionLbl: Label 'S H I P  T O';
        PACKING_LISTCaptionLbl: Label 'PACKING LIST';
        Ship_ViaCaptionLbl: Label 'Ship Via';
        TERMSCaptionLbl: Label 'TERMS';
        ORDER_DATECaptionLbl: Label 'ORDER DATE';
        SCHED_SHIP_DATE_WEEK_OFCaptionLbl: Label 'SCHED SHIP DATE WEEK OF';
        PAGE_NO_CaptionLbl: Label 'PAGE NO.';
        CUST__NOCaptionLbl: Label 'CUST. NO';
        F_O_B_CaptionLbl: Label 'F.O.B.';
        BUYERCaptionLbl: Label 'BUYER';
        EST__SHIPMENT_DATECaptionLbl: Label 'EST. SHIPMENT DATE';
        LOCATIONCaptionLbl: Label 'LOCATION';
        SALES_ORDER_NO_CaptionLbl: Label 'SALES ORDER NO.';
        ITEM_NO_CaptionLbl: Label 'ITEM NO.';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        QUANTITY_ORDEREDCaptionLbl: Label 'QUANTITY ORDERED';
        QUANTITY_BACK_ORDERCaptionLbl: Label 'QUANTITY BACK ORDER';
        QUANTITY_SHIPPEDCaptionLbl: Label 'QUANTITY SHIPPED';

}

