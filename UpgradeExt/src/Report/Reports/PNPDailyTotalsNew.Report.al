report 50041 "PNP Daily Totals - New"
{
    ProcessingOnly = true;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending);
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Sales Amount (Actual)";
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                    ColumnNo: Integer;
                begin
                    CLEAR(Customer);
                    Item.GET("Item No.");

                    IF Item."Routing No." = 'REPRO' THEN
                        CurrReport.SKIP();

                    ColumnNo := 1;
                    ItemLedgEntry.RESET();
                    ItemLedgEntry.SETRANGE("Entry No.", "Entry No.");
                    DailyCaseFormula.RESET();
                    IF DailyCaseFormula.FINDFIRST() THEN
                        REPEAT
                            IF WorkCenter.GET(DailyCaseFormula."Item Routing") THEN
                                AdjCases := WorkCenter."Adj. Cases";

                            //CUSTOMER NO FILTER
                            IF DailyCaseFormula."Customer No. Filter" <> '' THEN
                                ItemLedgEntry.SETFILTER("Source No.", DailyCaseFormula."Customer No. Filter")
                            ELSE
                                ItemLedgEntry.SETRANGE("Source No.");

                            // Customer category code filter (Global Dim 2 )
                            IF DailyCaseFormula."Global Dimension 2 Filter" <> '' THEN
                                ItemLedgEntry.SETFILTER("Global Dimension 2 Code", DailyCaseFormula."Global Dimension 2 Filter")
                            ELSE
                                ItemLedgEntry.SETRANGE("Global Dimension 2 Code");

                            // Item No. Filter
                            IF DailyCaseFormula."Item No. Filter" <> '' THEN
                                ItemLedgEntry.SETFILTER("Item No.", DailyCaseFormula."Item No. Filter")
                            ELSE
                                ItemLedgEntry.SETRANGE("Item No.");

                            IF DailyCaseFormula."Global Dimension 1 Filter" <> '' THEN
                                ItemLedgEntry.SETFILTER("Global Dimension 1 Code", DailyCaseFormula."Global Dimension 1 Filter")
                            ELSE
                                ItemLedgEntry.SETRANGE("Global Dimension 1 Code");

                            IF ItemLedgEntry.FINDFIRST() THEN
                                IF DailyCaseFormula."Item Type Filter" <> DailyCaseFormula."Item Type Filter"::" " THEN BEGIN
                                    IF Item."Item Type" = DailyCaseFormula."Item Type Filter" THEN
                                        //IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN BEGIN
                                        //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        IF NOT DailyCaseFormula."1000 bag count" THEN
                                            Amounts[ColumnNo] += ROUND(-ItemLedgEntry.Quantity, 1)
                                        ELSE
                                            Amounts[ColumnNo] += ROUND(-ItemLedgEntry.Quantity * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                    IF DailyCaseFormula."Projected Total" THEN
                                        ProjectedAmount := Amounts[ColumnNo];
                                    //END
                                END
                                ELSE
                                    IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN BEGIN
                                        //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                        IF NOT DailyCaseFormula."1000 bag count" THEN
                                            Amounts[ColumnNo] += ROUND(-ItemLedgEntry.Quantity, 1)
                                        ELSE
                                            Amounts[ColumnNo] += ROUND(-ItemLedgEntry.Quantity * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                        IF DailyCaseFormula."Projected Total" THEN
                                            ProjectedAmount := Amounts[ColumnNo];
                                    END;
                            ColumnNo += 1;
                        UNTIL DailyCaseFormula.NEXT() = 0;
                END;

                trigger OnPostDataItem()
                begin
                    IF Date2."Period Start" = AsofDate THEN
                        IF NOT PNPDaily.GET(Date2."Period Start") THEN BEGIN
                            PNPDaily.INIT();
                            PNPDaily.Date := Date2."Period Start";
                            PNPDaily."Column 1" := Amounts[1];
                            PNPDaily."Column 2" := Amounts[2];
                            PNPDaily."Column 3" := Amounts[3];
                            PNPDaily."Column 4" := Amounts[4];
                            PNPDaily."Column 5" := Amounts[5];
                            PNPDaily."Column 6" := Amounts[6];
                            PNPDaily."Column 7" := Amounts[7];
                            PNPDaily."Column 8" := Amounts[8];
                            PNPDaily."Column 9" := Amounts[9];
                            PNPDaily."Column 10" := Amounts[10];
                            PNPDaily."Column 11" := Amounts[11];
                            PNPDaily."Column 12" := Amounts[12];
                            PNPDaily."Column 13" := Amounts[13];
                            PNPDaily."Column 14" := Amounts[14];
                            PNPDaily."Column 15" := Amounts[15];
                            //PNPDaily."Projected Total" := 100/Formula2 * ProjectedAmount;
                            PNPDaily."Projected Total" := ProjectedAmount / Formula2;
                            PNPDaily.INSERT();
                        END ELSE BEGIN
                            PNPDaily."Column 1" := Amounts[1];
                            PNPDaily."Column 2" := Amounts[2];
                            PNPDaily."Column 3" := Amounts[3];
                            PNPDaily."Column 4" := Amounts[4];
                            PNPDaily."Column 5" := Amounts[5];
                            PNPDaily."Column 6" := Amounts[6];
                            PNPDaily."Column 7" := Amounts[7];
                            PNPDaily."Column 8" := Amounts[8];
                            PNPDaily."Column 9" := Amounts[9];
                            PNPDaily."Column 10" := Amounts[10];
                            PNPDaily."Column 11" := Amounts[11];
                            PNPDaily."Column 12" := Amounts[12];
                            PNPDaily."Column 13" := Amounts[13];
                            PNPDaily."Column 14" := Amounts[14];
                            PNPDaily."Column 15" := Amounts[15];
                            //PNPDaily."Projected Total" := 100/Formula2 * ProjectedAmount;
                            PNPDaily."Projected Total" := ProjectedAmount / Formula2;
                            PNPDaily.MODIFY();
                        END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry Type", "Entry Type"::Sale);

                    PostingDate := Date2."Period Start";
                    SETRANGE("Posting Date", Date2."Period Start");

                    itemLedgerEntry.INIT();
                    itemLedgerEntry.RESET();
                    itemLedgerEntry.COPYFILTERS("Item Ledger Entry");
                    itemLedgerEntry.SETCURRENTKEY("Posting Date");
                    IF NOT itemLedgerEntry.FIND('-') THEN BEGIN
                        IF Date2."Period Start" = AsofDate THEN
                            IF NOT PNPDaily.GET(Date2."Period Start") THEN
                                PNPDaily.INIT();
                        PNPDaily.Date := Date2."Period Start";
                        PNPDaily."Column 1" := Amounts[1];
                        PNPDaily."Column 2" := Amounts[2];
                        PNPDaily."Column 3" := Amounts[3];
                        PNPDaily."Column 4" := Amounts[4];
                        PNPDaily."Column 5" := Amounts[5];
                        PNPDaily."Column 6" := Amounts[6];
                        PNPDaily."Column 7" := Amounts[7];
                        PNPDaily."Column 8" := Amounts[8];
                        PNPDaily."Column 9" := Amounts[9];
                        PNPDaily."Column 10" := Amounts[10];
                        PNPDaily."Column 11" := Amounts[11];
                        PNPDaily."Column 12" := Amounts[12];
                        PNPDaily."Column 13" := Amounts[13];
                        PNPDaily."Column 14" := Amounts[14];
                        PNPDaily."Column 15" := Amounts[15];
                        //PNPDaily."Projected Total" := 100/Formula2 * ProjectedAmount;
                        PNPDaily."Projected Total" := ProjectedAmount / Formula2;
                        PNPDaily.INSERT();
                    END ELSE BEGIN
                        PNPDaily."Column 1" := Amounts[1];
                        PNPDaily."Column 2" := Amounts[2];
                        PNPDaily."Column 3" := Amounts[3];
                        PNPDaily."Column 4" := Amounts[4];
                        PNPDaily."Column 5" := Amounts[5];
                        PNPDaily."Column 6" := Amounts[6];
                        PNPDaily."Column 7" := Amounts[7];
                        PNPDaily."Column 8" := Amounts[8];
                        PNPDaily."Column 9" := Amounts[9];
                        PNPDaily."Column 10" := Amounts[10];
                        PNPDaily."Column 11" := Amounts[11];
                        PNPDaily."Column 12" := Amounts[12];
                        PNPDaily."Column 13" := Amounts[13];
                        PNPDaily."Column 14" := Amounts[14];
                        PNPDaily."Column 15" := Amounts[15];
                        //PNPDaily."Projected Total" := 100/Formula2 * ProjectedAmount;
                        PNPDaily."Projected Total" := ProjectedAmount / Formula2;
                        PNPDaily.MODIFY();
                    END;
                END;
            }

            trigger OnAfterGetRecord()
            begin
                DateCounter += 1;

                IF FirstDate = FALSE THEN BEGIN
                    Date2.FIND('-');
                    FirstDate := TRUE;
                END
                ELSE
                    IF Date2.NEXT(1) = 0 THEN;
                TotalUpSales();
                //OrderedValue;
            end;

            trigger OnPreDataItem()
            begin
                Date2.INIT();
                Date2.SETRANGE("Period Type", Date2."Period Type"::Date);
                Date2.SETRANGE("Period Start", StartDate, EndDate);
                Counter := Date2.COUNT;
                SETRANGE(Number, 1, Counter);
                MakeExcelHeader();
                DateCounter := 0;
                CalcAmount();
            end;
        }
        dataitem("PNP Daily - New"; "PNP Daily - New")
        {
            DataItemTableView = SORTING(Date);

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                EnterCell(RowNo, 1, FORMAT(Date), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);

                ColumnCounter := 1;

                DailyCaseFormula.RESET();
                IF DailyCaseFormula.FINDFIRST() THEN
                    REPEAT
                        ColumnCounter += 1;
                        EnterCell(RowNo, ColumnCounter, FORMAT(GETColumnVal("PNP Daily - New", DailyCaseFormula."PNP Daily Field ID")), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                        IF DailyCaseFormula."PNP Daily Field Name" = 'Total Dom' THEN
                            ColumnCounter += 1;
                        EnterCell(RowNo, ColumnCounter, FORMAT("PNP Daily - New"."Projected Total"), FALSE, FALSE, FALSE, '#,##0', TempExcelBuffer."Cell Type"::Number);
                    UNTIL DailyCaseFormula.NEXT() = 0;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Date, StartDate, EndDate);
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
                    field("Start Date"; StartDate)
                    {
                        ToolTip = 'Specifies the value of the StartDate field.';
                        ApplicationArea = all;
                        caption = 'Start Date';
                    }
                    field("End Date"; EndDate)
                    {
                        ToolTip = 'Specifies the value of the EndDate field.';
                        ApplicationArea = all;
                        caption = 'End Date';
                    }
                    field("As of Date"; AsofDate)
                    {
                        ToolTip = 'Specifies the value of the AsofDate field.';
                        ApplicationArea = all;
                        caption = 'As of Date';
                        trigger OnValidate()
                        begin
                            StartDate := CALCDATE('<-CM>', AsofDate);
                            EndDate := CALCDATE('<CM>', AsofDate);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            QtyIn := QtyIn::"Qty in Actual Case";
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        AsofDate := TODAY;
        StartDate := CALCDATE('<-CM>', AsofDate);
        EndDate := CALCDATE('<CM>', AsofDate);
        AsofDay := DATE2DMY(AsofDate, 1);
        CASE AsofDay OF
            1:
                Formula2 := 0.4888;
            2:
                Formula2 := 0.50852;
            3:
                Formula2 := 0.54065;
            4:
                Formula2 := 0.56343;
            5:
                Formula2 := 0.59405;
            6:
                Formula2 := 0.62107;
            7:
                Formula2 := 0.65286;
            8:
                Formula2 := 0.67856;
            9:
                Formula2 := 0.71084;
            10:
                Formula2 := 0.73136;
            11:
                Formula2 := 0.75791;
            12:
                Formula2 := 0.79107;
            13:
                Formula2 := 0.81196;
            14:
                Formula2 := 0.82529;
            15:
                Formula2 := 0.85271;
            16:
                Formula2 := 0.86569;
            17:
                Formula2 := 0.89437;
            18:
                Formula2 := 0.92335;
            19:
                Formula2 := 0.95086;
            20:
                Formula2 := 0.95997;
            21:
                Formula2 := 0.96812;
            22:
                Formula2 := 0.97926;
            23:
                Formula2 := 0.98549;
            24:
                Formula2 := 0.99602;
            25:
                Formula2 := 1.00355;
            26:
                Formula2 := 1.01102;
            27:
                Formula2 := 1.01847;
            28:
                Formula2 := 1.0213;
            29:
                Formula2 := 1.02146;
            30:
                Formula2 := 1.01977;
            31:
                Formula2 := 1.01454;
        END;
    end;

    trigger OnPostReport()
    begin
        // TempExcelBuffer.GiveUserControl;
        TempExcelBuffer.CreateNewBook('Daily Totals');
        TempExcelBuffer.WriteSheet('Daily Totals', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    trigger OnPreReport()
    begin
        PreStartDate := CALCDATE('<-1D>', StartDate);
        AsofDay := DATE2DMY(AsofDate, 1);
    end;

    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        itemLedgerEntry: Record "Item Ledger Entry";
        Date2: Record Date;
        WorkCenter: Record "Work Center";
        //WorkCenter2: Record "Work Center";
        PNPDaily: Record "PNP Daily - New";
        DailyCaseFormula: Record "Daily Case Report Formula";
        //FieldList: Record Field;
        Amounts: array[15] of Decimal;
        // TotalAmount: Decimal;
        AdjCases: Decimal;
        // AdjCases2: Decimal;
        // Position: Integer;
        RowNo: Integer;
        Counter: Integer;
        DateCounter: Integer;
        AsofDay: Integer;
        //Found: Boolean;
        FirstDate: Boolean;
        QtyIn: Option "Qty in Actual Case","Qty in Adjusted Case";
        PostingDate: Date;
        StartDate: Date;
        EndDate: Date;
        PreStartDate: Date;
        AsofDate: Date;
        ColumnCounter: Integer;
        Formula2: Decimal;
        // Formula: Decimal;
        ProjectedAmount: Decimal;
        OrderedAmount: Decimal;

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

    procedure MakeExcelHeader()
    begin
        RowNo += 1;
        EnterCell(RowNo, 1, 'Daily Totals', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, 'PNP Orders', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 9, FORMAT(WORKDATE(), 0, 4), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 10, FORMAT(TIME), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        RowNo += 2;
        EnterCell(RowNo, 1, 'Date Filters: ', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, FORMAT(StartDate) + '..', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 3, FORMAT(EndDate), TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        RowNo += 1;
        IF QtyIn = QtyIn::"Qty in Actual Case" THEN
            EnterCell(RowNo, 1, 'Qty: Actual', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text)
        ELSE
            EnterCell(RowNo, 1, 'Qty: Adjusted', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        RowNo += 2;
        EnterCell(RowNo, 1, 'Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

        ColumnCounter := 1;
        DailyCaseFormula.RESET();
        IF DailyCaseFormula.FINDFIRST() THEN
            REPEAT
                ColumnCounter += 1;
                EnterCell(RowNo, ColumnCounter, DailyCaseFormula."PNP Daily Field Name", TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                IF DailyCaseFormula."PNP Daily Field Name" = 'Total Dom' THEN
                    ColumnCounter += 1;
                EnterCell(RowNo, ColumnCounter, 'Dom Projected', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
            UNTIL DailyCaseFormula.NEXT() = 0;
    END;

    procedure GETColumnVal(LPNPDaily: Record "PNP Daily - New"; LFieldNo: Integer): Decimal
    begin
        IF LPNPDaily.FIELDNO("Column 1") = LFieldNo THEN
            EXIT(LPNPDaily."Column 1")
        ELSE
            IF LPNPDaily.FIELDNO("Column 2") = LFieldNo THEN
                EXIT(LPNPDaily."Column 2")
            ELSE
                IF LPNPDaily.FIELDNO("Column 3") = LFieldNo THEN
                    EXIT(LPNPDaily."Column 3")
                ELSE
                    IF LPNPDaily.FIELDNO("Column 4") = LFieldNo THEN
                        EXIT(LPNPDaily."Column 4")
                    ELSE
                        IF LPNPDaily.FIELDNO("Column 5") = LFieldNo THEN
                            EXIT(LPNPDaily."Column 5")
                        ELSE
                            IF LPNPDaily.FIELDNO("Column 6") = LFieldNo THEN
                                EXIT(LPNPDaily."Column 6")
                            ELSE
                                IF LPNPDaily.FIELDNO("Column 7") = LFieldNo THEN
                                    EXIT(LPNPDaily."Column 7")
                                ELSE
                                    IF LPNPDaily.FIELDNO("Column 8") = LFieldNo THEN
                                        EXIT(LPNPDaily."Column 8")
                                    ELSE
                                        IF LPNPDaily.FIELDNO("Column 9") = LFieldNo THEN
                                            EXIT(LPNPDaily."Column 9")
                                        ELSE
                                            IF LPNPDaily.FIELDNO("Column 10") = LFieldNo THEN
                                                EXIT(LPNPDaily."Column 10")
                                            ELSE
                                                IF LPNPDaily.FIELDNO("Column 11") = LFieldNo THEN
                                                    EXIT(LPNPDaily."Column 11")
                                                ELSE
                                                    IF LPNPDaily.FIELDNO("Column 12") = LFieldNo THEN
                                                        EXIT(LPNPDaily."Column 12")
                                                    ELSE
                                                        IF LPNPDaily.FIELDNO("Column 13") = LFieldNo THEN
                                                            EXIT(LPNPDaily."Column 13")
                                                        ELSE
                                                            IF LPNPDaily.FIELDNO("Column 14") = LFieldNo THEN
                                                                EXIT(LPNPDaily."Column 14")
                                                            ELSE
                                                                IF LPNPDaily.FIELDNO("Column 15") = LFieldNo THEN
                                                                    EXIT(LPNPDaily."Column 15")
    end;

    procedure CalcAmount()
    var
        ColumnNo: Integer;
    begin
        ColumnNo := 1;
        DailyCaseFormula.RESET();
        IF DailyCaseFormula.FINDFIRST() THEN
            REPEAT
                IF WorkCenter.GET(DailyCaseFormula."Item Routing") THEN
                    AdjCases := WorkCenter."Adj. Cases";

                SalesHeader.RESET();
                SalesHeader.SETFILTER("Order Date", '..%1', PreStartDate);
                SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
                //CUSTOMER NO FILTER
                IF DailyCaseFormula."Customer No. Filter" <> '' THEN
                    SalesHeader.SETFILTER("Sell-to Customer No.", DailyCaseFormula."Customer No. Filter");
                // Customer category code filter (Global Dim 2 )
                IF DailyCaseFormula."Global Dimension 2 Filter" <> '' THEN
                    SalesHeader.SETFILTER(SalesHeader."Shortcut Dimension 2 Code", DailyCaseFormula."Global Dimension 2 Filter");
                IF SalesHeader.FINDSET() THEN
                    REPEAT
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        // Item No. Filter
                        IF DailyCaseFormula."Item No. Filter" <> '' THEN
                            SalesLine.SETFILTER("No.", DailyCaseFormula."Item No. Filter");

                        IF DailyCaseFormula."Global Dimension 1 Filter" <> '' THEN
                            SalesLine.SETFILTER("Shortcut Dimension 1 Code", DailyCaseFormula."Global Dimension 1 Filter");
                        IF SalesLine.FINDSET() THEN
                            REPEAT
                                IF Item.GET(SalesLine."No.") THEN
                                    IF DailyCaseFormula."Item Type Filter" <> DailyCaseFormula."Item Type Filter"::" " THEN BEGIN
                                        IF Item."Item Type" = DailyCaseFormula."Item Type Filter" THEN
                                            //IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN BEGIN
                                            //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            IF NOT DailyCaseFormula."1000 bag count" THEN
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity", 1)
                                            ELSE
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                        IF DailyCaseFormula."Projected Total" THEN
                                            ProjectedAmount += Amounts[ColumnNo];
                                        //END
                                    END
                                    ELSE BEGIN
                                        IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN
                                            //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            IF NOT DailyCaseFormula."1000 bag count" THEN
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity", 1)
                                            ELSE
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                        IF DailyCaseFormula."Projected Total" THEN
                                            ProjectedAmount += Amounts[ColumnNo];
                                    END;
                            UNTIL SalesLine.NEXT() = 0;
                    UNTIL SalesHeader.NEXT() = 0;
                ColumnNo += 1;
            UNTIL DailyCaseFormula.NEXT() = 0;
    END;

    procedure TotalUpSales()
    var
        ColumnNo: Integer;
    begin
        ColumnNo := 1;
        DailyCaseFormula.RESET();
        IF DailyCaseFormula.FINDFIRST() THEN
            REPEAT
                IF WorkCenter.GET(DailyCaseFormula."Item Routing") THEN
                    AdjCases := WorkCenter."Adj. Cases";

                SalesHeader.RESET();
                SalesHeader.SETRANGE("Order Date", Date2."Period Start");
                SalesHeader.SETFILTER("Shipment Date", '%1..%2', StartDate, EndDate);
                //CUSTOMER NO FILTER
                IF DailyCaseFormula."Customer No. Filter" <> '' THEN
                    SalesHeader.SETFILTER("Sell-to Customer No.", DailyCaseFormula."Customer No. Filter");
                // Customer category code filter (Global Dim 2 )
                IF DailyCaseFormula."Global Dimension 2 Filter" <> '' THEN
                    SalesHeader.SETFILTER(SalesHeader."Shortcut Dimension 2 Code", DailyCaseFormula."Global Dimension 2 Filter");
                IF SalesHeader.FINDSET() THEN
                    REPEAT
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        // Item No. Filter
                        IF DailyCaseFormula."Item No. Filter" <> '' THEN
                            SalesLine.SETFILTER("No.", DailyCaseFormula."Item No. Filter");
                        IF DailyCaseFormula."Global Dimension 1 Filter" <> '' THEN
                            SalesLine.SETFILTER("Shortcut Dimension 1 Code", DailyCaseFormula."Global Dimension 1 Filter");
                        IF SalesLine.FINDSET() THEN
                            REPEAT
                                IF Item.GET(SalesLine."No.") THEN
                                    IF DailyCaseFormula."Item Type Filter" <> DailyCaseFormula."Item Type Filter"::" " THEN BEGIN
                                        IF Item."Item Type" = DailyCaseFormula."Item Type Filter" THEN
                                            //IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN BEGIN
                                            //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            IF NOT DailyCaseFormula."1000 bag count" THEN
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity", 1)
                                            ELSE
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                        IF DailyCaseFormula."Projected Total" THEN
                                            ProjectedAmount += Amounts[ColumnNo];
                                        //END
                                    END
                                    ELSE BEGIN
                                        IF Item."Routing No." = DailyCaseFormula."Item Routing" THEN
                                            //IF QtyIn = QtyIn::"Qty in Actual Case" THEN
                                            IF NOT DailyCaseFormula."1000 bag count" THEN
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity", 1)
                                            ELSE
                                                Amounts[ColumnNo] += ROUND(SalesLine."Outstanding Quantity" * Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case" / AdjCases, 1);
                                        IF DailyCaseFormula."Projected Total" THEN
                                            ProjectedAmount += Amounts[ColumnNo];
                                    END;
                            UNTIL SalesLine.NEXT() = 0;
                    UNTIL SalesHeader.NEXT() = 0;
                ColumnNo += 1;
            UNTIL DailyCaseFormula.NEXT() = 0;
    end;

    procedure OrderedValue()
    var
        LItemLedgerEntry: Record "Item Ledger Entry";
        LItem: Record Item;
    begin
        LItemLedgerEntry.RESET();
        IF DailyCaseFormula."Global Dimension 1 Filter" <> '' THEN
            LItemLedgerEntry.SETFILTER("Global Dimension 1 Code", DailyCaseFormula."Global Dimension 1 Filter");
        IF DailyCaseFormula."Global Dimension 2 Filter" <> '' THEN
            LItemLedgerEntry.SETFILTER("Global Dimension 2 Code", DailyCaseFormula."Global Dimension 2 Filter");
        LItemLedgerEntry.SETFILTER("Entry Type", '%1|%2', LItemLedgerEntry."Entry Type"::Purchase, LItemLedgerEntry."Entry Type"::"Positive Adjmt.");
        LItemLedgerEntry.SETFILTER("Posting Date", '%1', Date2."Period Start");
        IF LItemLedgerEntry.FindSet() THEN
            REPEAT
                IF (LItem.GET(LItemLedgerEntry."Item No.") AND (LItem."Routing No." = DailyCaseFormula."Item Routing")) THEN
                    IF NOT DailyCaseFormula."1000 bag count" THEN
                        OrderedAmount += ROUND(-LItemLedgerEntry.Quantity, 1)
                    ELSE
                        OrderedAmount += ROUND(-LItemLedgerEntry.Quantity * LItem."Bags per Roll/Bundle" * LItem."Rolls/Bundles per Case" / AdjCases, 1);
            UNTIL LItemLedgerEntry.NEXT() = 0;
    end;
}

