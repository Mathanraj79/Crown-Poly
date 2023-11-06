report 50017 "EDI Export"
{
    // SCSFN 110907
    //  - Added Additional Columns
    Caption = 'EDI Export';
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("EDI Customer" = FILTER(true));
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.", "Posting Date");
                RequestFilterFields = "No.";
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        WHERE(Type = FILTER(Item));

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(Item1);
                        RowNo += 1;
                        IF PrintToExcel THEN BEGIN
                            EnterCell(RowNo, 4, "Sales Invoice Header"."No.", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 5, '', TRUE, FALSE, TRUE);

                            EnterCell(RowNo, 6, FORMAT("Sales Invoice Header"."Posting Date"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 7, "Sales Invoice Header"."Sell-to Customer No.", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 8, "Sales Invoice Header"."Order No.", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 9, '', TRUE, FALSE, TRUE);

                            EnterCell(RowNo, 10, BillToAddress[1], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 11, BillToAddress[2], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 12, BillToAddress[3], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 13, BillToAddress[4], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 14, BillToAddress[5], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 15, BillToAddress[6], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 16, BillToAddress[7], TRUE, FALSE, TRUE);

                            EnterCell(RowNo, 17, ShipToAddress[1], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 18, ShipToAddress[2], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 19, ShipToAddress[3], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 20, ShipToAddress[4], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 21, ShipToAddress[5], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 22, ShipToAddress[6], TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 23, ShipToAddress[7], TRUE, FALSE, TRUE);

                            EnterCell(RowNo, 24, FORMAT("Sales Invoice Header"."Posting Date"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 25, "Sales Invoice Header"."External Document No.", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 26, ShipmentMethod.Description, TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 27, FOB.Description, TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 28, PaymentTerms.Description, TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 29, "Sales Invoice Header"."Sell-to Contact", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 30, FORMAT("Sales Invoice Header"."Due Date"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 31, "Sales Invoice Header"."Location Code", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 32, SalesPurchPerson.Name, TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 33, txtBroker, TRUE, FALSE, TRUE);

                            EnterCell(RowNo, 34, "No.", TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 35, Description, TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 36, FORMAT(Quantity), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 37, '', TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 38, FORMAT("Unit Price"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 39, FORMAT("Line Amount"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 40, FORMAT("Sales Invoice Line"."Line Discount Amount"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 41, FORMAT("Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount), TRUE, FALSE, TRUE);
                            //SCSFN 110907
                            EnterCell(RowNo, 42, FORMAT("Sales Invoice Header"."Posting Date"), TRUE, FALSE, TRUE);
                            EnterCell(RowNo, 43, FORMAT("Sales Invoice Header"."Document Date"), TRUE, FALSE, TRUE);
                            IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                                Item1.GET("No.");
                                EnterCell(RowNo, 44, Item1."UPC Code", TRUE, FALSE, TRUE);
                            END;
                            //SCSFN 110907
                        END;
                    end;

                    trigger OnPostDataItem()
                    begin
                        //SCSFN 110907
                        RowNo += 1;
                        EnterCell(RowNo, 43, 'Total', TRUE, FALSE, TRUE);
                        EnterCell(RowNo, 44, FORMAT("Sales Invoice Header"."Amount Including VAT"), TRUE, FALSE, TRUE);
                        //SCSFN 110907
                        //EdiSalesInvoiceTrue.RUN("Sales Invoice Header");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    bROKER: Record "Salesperson/Purchaser";
                    Territory: Record Territory;
                    Customer: Record Customer;
                begin
                    CALCFIELDS("Amount Including VAT");

                    IF "Salesperson Code" = '' THEN
                        CLEAR(SalesPurchPerson)
                    ELSE
                        SalesPurchPerson.GET("Salesperson Code");

                    //SCSSM01 START
                    txtBroker := '';
                    HeaderBroker := '';
                    IF "Sales Invoice Header"."Broker 1" <> '' THEN BEGIN
                        HeaderBroker := 'BROKER';
                        bROKER.INIT();
                        IF bROKER.GET("Sales Invoice Header"."Broker 1") THEN
                            txtBroker := FORMAT(bROKER.Name);
                    END
                    ELSE BEGIN
                        HeaderBroker := 'TERRITORY';
                        Customer.INIT();
                        IF Customer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                            Territory.INIT();
                            IF Territory.GET(Customer."Territory Code") THEN
                                txtBroker := FORMAT(Territory.Name);
                        END;
                    END;

                    FOB.INIT();
                    IF FOB.GET("Sales Invoice Header"."F.O.B.") THEN;
                    //SCSSM01 END

                    FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                    FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");

                    IF "Payment Terms Code" = '' THEN
                        CLEAR(PaymentTerms)
                    ELSE
                        PaymentTerms.GET("Payment Terms Code");

                    IF "Shipment Method Code" = '' THEN
                        CLEAR(ShipmentMethod)
                    ELSE
                        ShipmentMethod.GET("Shipment Method Code");
                    //SCSFN 110907 DELETE
                    //"Sales Invoice Header"."EDI Invoice Porcessed" := TRUE;
                    //MODIFY;
                end;

                trigger OnPreDataItem()
                begin
                    //SCSFN 110907 BEGIN delete
                    //IF NOT RepProcessed THEN
                    //  "Sales Invoice Header".SETRANGE("EDI Invoice Porcessed",FALSE);
                    //SCSFN 110907 END
                end;
            }

            trigger OnPreDataItem()
            begin
                PrintToExcel := TRUE;
                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'CROWN POLY INC.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 2, '5700 BICKETT Street', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 3, 'HUNTINGTON PARK, CA 90255', TRUE, FALSE, TRUE);

                    EnterCell(RowNo, 4, 'Invoice Number', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 5, 'Apply To', TRUE, FALSE, TRUE);

                    EnterCell(RowNo, 6, 'Invoice Date', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 7, 'Customer No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 8, 'Work Order No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 9, 'B.O', TRUE, FALSE, TRUE);

                    EnterCell(RowNo, 10, 'Sold-To Name', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 11, 'Sold-To Address', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 12, 'Sold-To Address 2', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 13, 'Sold-To Address 3', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 14, 'Sold-To Address 4', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 15, 'Sold-To Address 5', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 16, 'Sold-To Address 6', TRUE, FALSE, TRUE);

                    EnterCell(RowNo, 17, 'Ship-To Name', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 18, 'Ship-To Address', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 19, 'Ship-To Address 2', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 20, 'Ship-To Address 3', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 21, 'Ship-To Address 4', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 22, 'Ship-To Address 5', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 23, 'Ship-To Address 6', TRUE, FALSE, TRUE);

                    EnterCell(RowNo, 24, 'Date Shipped', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 25, 'Purchase Order No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 26, 'Ship Via', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 27, 'FOB', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 28, 'Terms', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 29, 'Buyer', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 30, 'Date Requested', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 31, 'Location', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 32, 'Salesperson', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 33, 'Territory', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 34, 'Item No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 35, 'Description', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 36, 'Quantity Ordered', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 37, 'Quantity Shipped', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 38, 'Unit Price', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 39, 'Gross Amount', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 40, 'Discount Amount', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 41, 'Tax', TRUE, FALSE, TRUE);
                    //SCSFN 110907
                    EnterCell(RowNo, 42, 'Posting Date', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 43, 'Document Date', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 44, 'UPC', TRUE, FALSE, TRUE);
                    //SCSFN 110907
                END;
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN

            //TempExcelBuffer.GiveUserControl;
            TempExcelBuffer.CreateNewBook('EDI Invoices');
            TempExcelBuffer.WriteSheet('EDI Invoices', CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.OpenExcel();
        END;
    end;

    var
        FOB: Record FOB;
        //ShippingAgent: Record "Shipping Agent";
        Item1: Record Item;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        // CompanyInformation: Record "Company Information";
        // OrderLine: Record "Sales Line";
        // ShipmentLine: Record "Sales Shipment Line";
        // TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        // RespCenter: Record "Responsibility Center";
        // Language: Record Language;
        // TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        // TaxArea: Record "Tax Area";
        // TempItem: Record Item;
        // SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        // SalesTaxCalc: Codeunit "Sales Tax Calculate";
        // SegManagement: Codeunit SegManagement;

        //RepProcessed: Boolean;
        PrintToExcel: Boolean;
        RowNo: Integer;

        // TaxLiable: Decimal;
        // OrderedQuantity: Decimal;
        // UnitPriceToPrint: Decimal;
        // AmountExclInvDisc: Decimal;

        // CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        // CopyTxt: Text[10];
        // DescriptionToPrint: Text[210];
        // HighDescriptionToPrint: Text[210];
        // LowDescriptionToPrint: Text[210];
        // PrintCompany: Boolean;
        // PrintFooter: Boolean;
        // TaxFlag: Boolean;
        // NoCopies: Integer;
        // NoLoops: Integer;
        // CopyNo: Integer;
        // NumberOfLines: Integer;
        // OnLineNumber: Integer;
        // HighestLineNo: Integer;
        // SpacePointer: Integer;

        // LogInteraction: Boolean;
        // TaxRegNo: Text[30];
        // TaxRegLabel: Text[30];
        // TotalTaxLabel: Text[30];
        // BreakdownTitle: Text[30];
        // BreakdownLabel: array[4] of Text[30];
        // BreakdownAmt: array[4] of Decimal;
        // BrkIdx: Integer;
        // PrevPrintOrder: Integer;
        // PrevTaxPercent: Decimal;
        // TotalCases: Decimal;
        // TotalPallets: Decimal;

        txtBroker: Text[50];
        HeaderBroker: Text[50];

    local procedure EnterCell(RowNumber: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNumber);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        IF RowNumber = 1 THEN
            TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        IF TempExcelBuffer.NumberFormat <> '' THEN
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number
        ELSE
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Text;
        TempExcelBuffer.INSERT();
    end;
}

