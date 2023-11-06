report 50021 "Broker Commissions to Excel"
{
    Caption = 'Broker Commissions to Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Commision Setup"; "Sales Commision Setup")
        {
            DataItemTableView = SORTING("Salesperson Code", "Item No.", "Customer No.")
                                WHERE(Broker = FILTER(true));
            RequestFilterFields = "Salesperson Code", "Customer No.";

            trigger OnAfterGetRecord()
            begin
                TempCust.INIT();
                TempCust."Field 1" := "Salesperson Code";
                TempCust."Field 2" := "Customer No.";
                //TempCust."Field 3" := "Item No.";
                IF TempCust.INSERT() THEN;
            end;

            trigger OnPreDataItem()
            begin
                SalesSetup.GET();
                TempCust.DELETEALL();

                PrintToExcel := TRUE;
                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'CROWN POLY INC.', TRUE, FALSE, TRUE);
                    RowNo += 1;
                    EnterCell(RowNo, 1, '5700 BICKETT Street', TRUE, FALSE, TRUE);
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'HUNTINGTON PARK, CA 90255', TRUE, FALSE, TRUE);
                    RowNo += 2;

                    EnterCell(RowNo, 1, 'Sales Invoice Number', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 2, 'Invoice Date', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 3, 'Customer No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 4, 'Item No.', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 5, 'Cases Shipped', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 6, 'Base Price/Case', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 7, 'Gross Sales', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 8, 'Freight/Case', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 9, 'Total Freight Charge', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 10, 'Rebate/Case', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 11, 'Total Rebate', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 12, 'COGA', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 13, 'Total COGA', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 14, 'Comm. Price for Broker', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 15, 'Comm. Sales', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 16, 'Comm. Rate/Case', TRUE, FALSE, TRUE);
                    EnterCell(RowNo, 17, 'Total Commission', TRUE, FALSE, TRUE);
                END;
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Sell-to Customer No.", "Posting Date", "No.";
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending)
                                        WHERE(Type = FILTER(Item));
                    RequestFilterFields = Type, "No.";

                    trigger OnAfterGetRecord()
                    var
                        SalesCommisionSetup: Record "Sales Commision Setup";
                        SalesCommiSionAmt: Decimal;

                        TotalCommision: Decimal;
                        SplitCommision: Decimal;
                        SplitQuantity: Decimal;
                    begin
                        IF "Unit Price" = 0 THEN
                            CurrReport.SKIP();

                        TotalNetPrice.RESET();
                        TotalNetPrice.SETRANGE("Customer No.", "Sales Invoice Line"."Sell-to Customer No.");
                        TotalNetPrice.SETRANGE("Item No.", "Sales Invoice Line"."No.");
                        IF NOT TotalNetPrice.FINDFIRST() THEN;

                        IF PrintToExcel THEN BEGIN
                            RowNo += 1;
                            EnterCell(RowNo, 1, "Document No.", FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 3, "Sales Invoice Header"."Sell-to Customer No.", FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 4, "Sales Invoice Line"."No.", FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 5, FORMAT(Quantity), FALSE, FALSE, FALSE);
                            TotalCases += Quantity;

                            SalesCommisionSetup.SETCURRENTKEY("Item No.", "Customer No.", Broker);
                            SalesCommisionSetup.SETRANGE("Item No.", "Sales Invoice Line"."No.");
                            SalesCommisionSetup.SETRANGE("Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                            SalesCommisionSetup.SETRANGE(Broker, TRUE);
                            IF SalesCommisionSetup.COUNT > 1 THEN BEGIN
                                SalesCommisionSetup.CALCSUMS("Commision %");
                                TotalCommision := SalesCommisionSetup."Commision %";
                                SalesCommisionSetup.SETRANGE("Salesperson Code", SalesCommisionSetup."Salesperson Code");
                                IF SalesCommisionSetup.FINDFIRST() THEN BEGIN
                                    SplitCommision := SalesCommisionSetup."Commision %" / TotalCommision;
                                    SplitQuantity := SplitCommision * Quantity;
                                END ELSE
                                    SplitQuantity := Quantity;
                            END ELSE
                                SplitQuantity := Quantity;

                            SalesCommisionSetup.RESET();
                            SalesCommisionSetup.SETCURRENTKEY("Item No.", "Customer No.", Broker);
                            SalesCommisionSetup.SETRANGE("Item No.", '');
                            SalesCommisionSetup.SETRANGE("Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                            SalesCommisionSetup.SETRANGE(Broker, TRUE);
                            IF SalesCommisionSetup.COUNT > 1 THEN BEGIN
                                SalesCommisionSetup.CALCSUMS("Commision %");
                                TotalCommision := SalesCommisionSetup."Commision %";
                                SalesCommisionSetup.SETRANGE("Salesperson Code", SalesCommisionSetup."Salesperson Code");
                                IF SalesCommisionSetup.FINDFIRST() THEN BEGIN
                                    SplitCommision := SalesCommisionSetup."Commision %" / TotalCommision;
                                    SplitQuantity := SplitCommision * Quantity;
                                END ELSE
                                    SplitQuantity := Quantity;
                            END ELSE
                                SplitQuantity := Quantity;

                            EnterCell(RowNo, 6, FORMAT("Unit Price"), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 7, FORMAT(Quantity * "Unit Price"), FALSE, FALSE, FALSE);
                            TotalSales += Quantity * "Unit Price";

                            EnterCell(RowNo, 8, FORMAT(TotalNetPrice.Freight), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 9, FORMAT(TotalNetPrice.Freight * Quantity), FALSE, FALSE, FALSE); //scssm01
                            TotalFreight += TotalNetPrice.Freight * Quantity;

                            EnterCell(RowNo, 10, FORMAT(TotalNetPrice.Instant + TotalNetPrice.POD + TotalNetPrice.Quarterly +
                              TotalNetPrice.Annually), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 11, FORMAT((TotalNetPrice.Instant + TotalNetPrice.POD + TotalNetPrice.Quarterly +
                              TotalNetPrice.Annually) * Quantity), FALSE, FALSE, FALSE);
                            TotalRebate += (TotalNetPrice.Instant + TotalNetPrice.POD + TotalNetPrice.Quarterly + TotalNetPrice.Annually) * Quantity;

                            EnterCell(RowNo, 12, FORMAT(TotalNetPrice."Case Cost Deduction"), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 13, FORMAT((TotalNetPrice."Case Cost Deduction") * Quantity), FALSE, FALSE, FALSE);
                            TotalCOGA += (TotalNetPrice."Case Cost Deduction") * Quantity;

                            EnterCell(RowNo, 14, FORMAT(TotalNetPrice."Single Net Price"), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 15, FORMAT(TotalNetPrice."Single Net Price" * Quantity), FALSE, FALSE, FALSE);
                            TotalNetSales += TotalNetPrice."Single Net Price" * Quantity;

                            EnterCell(RowNo, 16, FORMAT(TotalNetPrice."Broker Commission Percent"), FALSE, FALSE, FALSE);
                            EnterCell(RowNo, 17, FORMAT(TotalNetPrice."Broker Commission Percent" * SplitQuantity), FALSE, FALSE, FALSE);
                            TotalComm += TotalNetPrice."Broker Commission Percent" * SplitQuantity;
                        END;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Sell-to Customer No.", TempCust."Field 2");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Nooflines = 1 THEN
                    TempCust.FINDSET()
                ELSE
                    TempCust.NEXT();

                Nooflines += 1;
                IF TotalCases > 0 THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 4, 'Total', TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 5, FORMAT(TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 6, FORMAT(TotalSales / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 7, FORMAT(TotalSales), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 8, FORMAT(TotalFreight / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 9, FORMAT(TotalFreight), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 10, FORMAT(TotalRebate / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 11, FORMAT(TotalRebate), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 12, FORMAT(TotalCOGA / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 13, FORMAT(TotalCOGA), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 14, FORMAT(TotalNetSales / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 15, FORMAT(TotalNetSales), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 16, FORMAT(TotalComm / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 17, FORMAT(TotalComm), TRUE, FALSE, FALSE);
                END;

                TotalCases := 0;
                TotalSales := 0;
                TotalFreight := 0;
                TotalRebate := 0;
                TotalCOGA := 0;
                TotalNetSales := 0;
                TotalComm := 0;
            end;

            trigger OnPostDataItem()
            begin
                IF TotalCases > 0 THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 4, 'Total', TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 5, FORMAT(TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 6, FORMAT(TotalSales / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 7, FORMAT(TotalSales), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 8, FORMAT(TotalFreight / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 9, FORMAT(TotalFreight), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 10, FORMAT(TotalRebate / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 11, FORMAT(TotalRebate), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 12, FORMAT(TotalCOGA / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 13, FORMAT(TotalCOGA), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 14, FORMAT(TotalNetSales / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 15, FORMAT(TotalNetSales), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 16, FORMAT(TotalComm / TotalCases), TRUE, FALSE, FALSE);
                    EnterCell(RowNo, 17, FORMAT(TotalComm), TRUE, FALSE, FALSE);
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, TempCust.COUNT);
                Nooflines := 1;
                TotalCases := 0;
                TotalSales := 0;
                TotalFreight := 0;
                TotalRebate := 0;
                TotalCOGA := 0;
                TotalNetSales := 0;
                TotalComm := 0;
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
            TempExcelBuffer.CreateNewBook('Broker Commissions');
            TempExcelBuffer.WriteSheet('Broker Commissions', COMPANYNAME, USERID);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.OpenExcel();
            // TempExcelBuffer.GiveUserControl;
        END;
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TotalNetPrice: Record "Total Net Price";
        SalesSetup: Record "Sales & Receivables Setup";
        TempCust: Record "Temp Commision Table" temporary;
        PrintToExcel: Boolean;
        RowNo: Integer;
        Nooflines: Integer;
        TotalCases: Decimal;
        TotalSales: Decimal;
        TotalFreight: Decimal;
        TotalRebate: Decimal;
        TotalCOGA: Decimal;
        TotalNetSales: Decimal;
        TotalComm: Decimal;

    local procedure EnterCell(RowNumber: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNumber);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        IF (ColumnNo > 4) AND (RowNumber > 5) THEN
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number
        ELSE
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Text;
        TempExcelBuffer.INSERT();
    end;
}

