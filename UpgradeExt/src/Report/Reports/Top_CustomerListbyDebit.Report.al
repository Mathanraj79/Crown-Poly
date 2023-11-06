report 50001 "Top __ Customer List by Debit"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\TopCustomerListbyDebit.rdl';
    Caption = 'Top __ Customer List';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Heading; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(MainTitle; MainTitle)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(iCaption; iCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(TopNo_i_Caption; TopNo_i_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(V45__Caption; V45__CaptionLbl)
            {
            }
            column(V31_45Caption; V31_45CaptionLbl)
            {
            }
            column(V31_Caption; V31_CaptionLbl)
            {
            }
            column(Acct__TotalCaption; Acct__TotalCaptionLbl)
            {
            }
            column(V0_30Caption; V0_30CaptionLbl)
            {
            }
            column(Heading_Number; Number)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Customer Posting Group", "Salesperson Code", "Date Filter";

                trigger OnAfterGetRecord()
                begin
                    Window.UPDATE(1, "No.");
                    /*
                    IF TopType = TopType::"Balance ($)" THEN BEGIN
                      CALCFIELDS("Balance on Date (LCY)");
                      TempAmount := "Balance on Date (LCY)";
                    END ELSE BEGIN
                      CALCFIELDS("Sales (LCY)");
                      TempAmount := "Sales (LCY)";
                    END;
                    */
                    SETFILTER("Date Filter", '%1..%2', 0D, (AsofDate - 30));
                    CALCFIELDS("Balance on Date (LCY)");
                    TempAmount := Customer."Balance on Date (LCY)";

                    GrandTotal := GrandTotal + TempAmount;
                    TopNo[NextTopLineNo] := "No.";
                    TopAmount[NextTopLineNo] := TempAmount;
                    TopName[NextTopLineNo] := Name;
                    i := NextTopLineNo;
                    IF NextTopLineNo < (CustomersToRank + 1) THEN
                        NextTopLineNo := NextTopLineNo + 1;
                    WHILE (i > 1) DO BEGIN
                        i := i - 1;
                        IF (TopAmount[i + 1] > TopAmount[i]) THEN BEGIN

                            // Sort the Customers by amount, largest should be first, smallest last. Put
                            // values from position i into save variables, move values from position
                            // i+1 to position i then put save values back in array in position i+1.
                            TempNo := TopNo[i];
                            TempAmount := TopAmount[i];
                            TempName := TopName[i];
                            TopNo[i] := TopNo[i + 1];
                            TopAmount[i] := TopAmount[i + 1];
                            TopName[i] := TopName[i + 1];
                            TopNo[i + 1] := TempNo;
                            TopAmount[i + 1] := TempAmount;
                            TopName[i + 1] := TempName;
                        END;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    NextTopLineNo := 1;
                    Window.OPEN(Text000Lbl + ' #1########');
                end;
            }
            dataitem("Print Loop"; Integer)
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 99;
                column(i; i)
                {
                }
                column(TopNo_i_; TopNo[i])
                {
                }
                column(Top__; "Top%")
                {
                    DecimalPlaces = 1 : 1;
                }
                column(TopAmount_i_; TopAmount[i])
                {
                }
                column(TopName_i_; TopName[i])
                {
                }
                column(V3145Amount_; "3145Amount")
                {
                }
                column(V45Amount_; "45Amount")
                {
                }
                column(AcctTotal; AcctTotal)
                {
                }
                column(AcctTotal_TopAmount_i_; AcctTotal - TopAmount[i])
                {
                }
                column(Print_Loop_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Cust2: Record Customer;
                begin
                    i := i + 1;
                    IF i = NextTopLineNo THEN
                        CurrReport.BREAK();
                    TopTotal := TopTotal + TopAmount[i];
                    IF (TopAmount[1] > 0) AND (TopAmount[i] > 0) THEN
                        BarText :=
                          ParagraphHandling.PadStrProportional('', ROUND(TopAmount[i] / TopAmount[1] * 61, 1), 7, '|')
                    ELSE
                        BarText := '';
                    IF GrandTotal <> 0 THEN
                        "Top%" := ROUND(TopAmount[i] / GrandTotal * 100, 0.1)
                    ELSE
                        "Top%" := 0;


                    Cust2.GET(TopNo[i]);
                    Cust2.SETFILTER("Date Filter", '%1..%2', (AsofDate - 45), (AsofDate - 30));
                    Cust2.CALCFIELDS("CP Balance");
                    "3145Amount" := Cust2."CP Balance";

                    Cust2.RESET();
                    Cust2.GET(TopNo[i]);
                    Cust2.SETFILTER("Date Filter", '%1..%2', 0D, (AsofDate - 46));
                    Cust2.CALCFIELDS("CP Balance");
                    "45Amount" := Cust2."CP Balance";

                    Cust2.RESET();
                    Cust2.GET(TopNo[i]);
                    Cust2.SETFILTER("Date Filter", '%1..%2', 0D, AsofDate);
                    Cust2.CALCFIELDS("CP Balance Due");
                    AcctTotal := Cust2."CP Balance Due";

                    IF PrintToExcel THEN BEGIN
                        RowNo += 1;
                        EnterCell(RowNo, 1, FORMAT(i), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        EnterCell(RowNo, 2, FORMAT(TopNo[i]), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        EnterCell(RowNo, 3, FORMAT(TopName[i]), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                        EnterCell(RowNo, 4, FORMAT("Top%"), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                        EnterCell(RowNo, 5, FORMAT(TopAmount[i]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                        EnterCell(RowNo, 6, FORMAT(AcctTotal - TopAmount[i]), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                        EnterCell(RowNo, 7, FORMAT("3145Amount"), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                        EnterCell(RowNo, 8, FORMAT("45Amount"), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                        EnterCell(RowNo, 9, FORMAT(AcctTotal), FALSE, FALSE, FALSE, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    Window.CLOSE();
                    i := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                PrintToExcel := TRUE;
                IF PrintToExcel THEN BEGIN
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'CROWN POLY INC.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    RowNo += 1;
                    EnterCell(RowNo, 1, '5700 BICKETT Street', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    RowNo += 1;
                    EnterCell(RowNo, 1, 'HUNTINGTON PARK, CA 90255', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    RowNo += 2;

                    EnterCell(RowNo, 1, 'Rank', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 2, 'Customer No.', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 3, 'Customer Name', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 4, '%', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 5, '31+', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 6, '0-30', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 7, '31-45', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                    EnterCell(RowNo, 8, '45+', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                    EnterCell(RowNo, 9, 'Acct Total', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

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
                    field(CustomersToRank; CustomersToRank)
                    {
                        Caption = 'No. of Customers to Rank';
                        ToolTip = 'Specifies the value of the No. of Customers to Rank field.';
                        ApplicationArea = all;
                        trigger OnValidate()
                        begin
                            IF CustomersToRank > 99 THEN
                                ERROR('Number of customers must be no greater than 99');
                        end;
                    }
                    field(AsofDate; AsofDate)
                    {
                        Caption = 'As of Date';
                        ToolTip = 'Specifies the value of the As of Date field.';
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            //  TempExcelBuffer.CreateBook('Top Customer List by Debit');
            //  TempExcelBuffer.UpdateBook('Top Customer List by Debit','Top Customer List by Debit');
            TempExcelBuffer.CreateNewBook('Top Customer List by Debit');
            TempExcelBuffer.WriteSheet('Top Customer List by Debit', CompanyName, UserId);
            TempExcelBuffer.CloseBook();
            TempExcelBuffer.SetFriendlyFilename('Top Customer List by Debit');
            TempExcelBuffer.OpenExcel();
        END;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET();

        IF CustomersToRank = 0 THEN // default
            CustomersToRank := 20;
        IF TopType = TopType::"Balance ($)" THEN BEGIN
            SubTitle := Text001Lbl;
            ColHead := Text002Lbl;
        END ELSE BEGIN
            IF Customer.GETFILTER("Date Filter") = '' THEN
                SubTitle := Text003Lbl
            ELSE
                SubTitle := Text004Lbl + ' ' +
                            Customer.GETFILTER("Date Filter") + ')';
            ColHead := Text005Lbl;
        END;

        MainTitle := Text006Lbl + ' ' + FORMAT(CustomersToRank) + Text007Lbl;
        /* Temporarily remove date filter, since it will show in the header anyway */
        Customer.SETRANGE("Date Filter");
        FilterString := Customer.GETFILTERS();

    end;

    var
        CompanyInformation: Record "Company Information";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ParagraphHandling: Codeunit "Paragraph Handling";
        FilterString: Text;
        MainTitle: Text[88];
        SubTitle: Text[132];
        ColHead: Text[9];
        TempName: Text[50];
        TempNo: Text[40];
        //TopTotalText: Text[40];
        BarText: Text[250];
        TopName: array[100] of Text[50];
        "Top%": Decimal;
        TempAmount: Decimal;
        GrandTotal: Decimal;
        TopAmount: array[100] of Decimal;
        TopTotal: Decimal;
        "45Amount": Decimal;
        "3145Amount": Decimal;
        AcctTotal: Decimal;
        i: Integer;
        PrintToExcel: Boolean;
        NextTopLineNo: Integer;
        CustomersToRank: Integer;
        RowNo: Integer;
        AsofDate: Date;
        TopType: Option "Sales ($)","Balance ($)";
        TopNo: array[100] of Code[20];
        Window: Dialog;
        Text000Lbl: Label 'Going through customers ';
        Text001Lbl: Label '(by Balance Due)';
        Text002Lbl: Label 'Balances';
        Text003Lbl: Label '(by Total Sales)';
        Text004Lbl: Label '(by Sales During the Period';
        Text005Lbl: Label 'Sales';
        Text006Lbl: Label 'Top';
        Text007Lbl: Label ' Customers';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        iCaptionLbl: Label 'Rank';
        EmptyStringCaptionLbl: Label '%';
        TopNo_i_CaptionLbl: Label 'Customer';
        NameCaptionLbl: Label 'Name';
        Acct__TotalCaptionLbl: Label 'Acct. Total';
        V0_30CaptionLbl: Label '0-30';
        V31_45CaptionLbl: Label '31-45';
        V31_CaptionLbl: Label '31+';
        V45__CaptionLbl: Label '45+';

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

