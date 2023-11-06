report 50015 "Deposit Test Report II"
{
    // <changelog>
    //   <add id="NA0000" dev="JNOZZI" date="2006-05-09" area="BANK DEP." feature="605"
    //     releaseversion="NAVNA4.00.03">New local Bank Deposits object</add>
    //   <change id="NA0001" dev="JNOZZI" date="2006-12-07" area="BUG FIX"  request="20779"
    //     baseversion="NAVNA4.00.03" releaseversion="NAVNA5.00">Use the Remaining Payment Discount Amount, rather than
    //     the Original.</change>
    //   <change id="NA0002" dev="JNOZZI" date="2006-12-08" area="BANK DEP." feature="605"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00">Move code from Section to OnAfterGetRecord (Gen Jnl Line).
    //     </change>
    //   <change id="NA0003" dev="MBAHADUR" date="2007-10-17" area="BANK DEP." feature="31657"
    //     baseversion="NAVNA5.00" releaseversion="NAVNA5.00.01">1). add to show total applied amount 2). add to show
    //     total unapplied amount 3). add to show total amount 4). Change report totals to be consistent with form fields 5).
    //     realign all fields for columnar consistency</change>
    //   <change id="NA0004" dev="ELYNCH" date="2008-01-15" area="BANK DEP." feature="33264"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA5.00.01">Lengthened AccountName Variable to 50.</change>
    //   <change id="NA0005" dev="JNOZZI" date="2008-04-21" area="BANK DEP." feature="36496"
    //     baseversion="NAVNA5.00.01" releaseversion="NAVNA6.00">Add ability to take Payment Tolerance and Payment
    //     Discount Tolerance into account. Had to make a Landscape report so that everything would fit.</change>
    //   <change id="NA0006" dev="V-GEXION" date="2008-05-16" area="BANK DEP." feature="NC14261"
    //     baseversion="NAVNA6.00" releaseversion="NAVNA6.00">Report Transformation - local Report Layout</change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\DepositTestReportII.rdl';

    Caption = 'Deposit Test Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Deposit Header"; "Deposit Header")
        {
            CalcFields = "Total Deposit Lines";
            RequestFilterFields = "No.", "Bank Account No.";
            column(Deposit_Header_No_; "No.")
            {
            }
            column(Deposit_Header_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Deposit_Header_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            dataitem(PageHeader; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(USERID; USERID)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO())
                {
                }
                column(TIME; TIME)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(STRSUBSTNO_Text000__Deposit_Header___No___; STRSUBSTNO(Text000Lbl, "Deposit Header"."No."))
                {
                }
                column(CompanyInformation_Name; CompanyInformation.Name)
                {
                }
                column(Deposit_Header___Bank_Account_No__; "Deposit Header"."Bank Account No.")
                {
                }
                column(BankAccount_Name; BankAccount.Name)
                {
                }
                column(Deposit_Header___Document_Date_; "Deposit Header"."Document Date")
                {
                }
                column(Deposit_Header___Posting_Date_; "Deposit Header"."Posting Date")
                {
                }
                column(Deposit_Header___Posting_Description_; "Deposit Header"."Posting Description")
                {
                }
                column(Deposit_Header___Total_Deposit_Amount_; "Deposit Header"."Total Deposit Amount")
                {
                }
                column(ShowDim; ShowDim)
                {
                }
                column(PrintApplications; PrintApplications)
                {
                }
                column(ShowApplyToOutput; ShowApplyToOutput)
                {
                }
                column(Dim1Number; Dim1Number)
                {
                }
                column(Dim2Number; Dim2Number)
                {
                }
                column(PageHeader_Number; Number)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(To_Be_Deposited_InCaption; To_Be_Deposited_InCaptionLbl)
                {
                }
                column(Deposit_Header___Bank_Account_No__Caption; Deposit_Header___Bank_Account_No__CaptionLbl)
                {
                }
                column(Currency_CodeCaption; Currency_CodeCaptionLbl)
                {
                }
                column(Deposit_Header___Document_Date_Caption; Deposit_Header___Document_Date_CaptionLbl)
                {
                }
                column(Deposit_Header___Posting_Date_Caption; Deposit_Header___Posting_Date_CaptionLbl)
                {
                }
                column(Deposit_Header___Posting_Description_Caption; Deposit_Header___Posting_Description_CaptionLbl)
                {
                }
                column(Control1020023Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionCode("Deposit Header"."Currency Code")))
                {
                }
                column(Control1020024Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionDesc("Deposit Header"."Currency Code")))
                {
                }
                column(Deposit_Header___Total_Deposit_Amount_Caption; Deposit_Header___Total_Deposit_Amount_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Account_Type_Caption; "Gen. Journal Line".FIELDCAPTION("Account Type"))
                {
                }
                column(Gen__Journal_Line__Document_Type_Caption; "Gen. Journal Line".FIELDCAPTION("Document Type"))
                {
                }
                column(Gen__Journal_Line__Document_No__Caption; "Gen. Journal Line".FIELDCAPTION("Document No."))
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Gen__Journal_Line_DescriptionCaption; "Gen. Journal Line".FIELDCAPTION(Description))
                {
                }
                column(Account_No_____________AccountNameCaption; Account_No_____________AccountNameCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry__Due_Date_Caption; "Cust. Ledger Entry".FIELDCAPTION("Due Date"))
                {
                }
                column(Gen__Journal_Line__Document_Date_Caption; Gen__Journal_Line__Document_Date_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Applies_to_Doc__Type_Caption; Gen__Journal_Line__Applies_to_Doc__Type_CaptionLbl)
                {
                }
                column(Gen__Journal_Line__Applies_to_Doc__No__Caption; Gen__Journal_Line__Applies_to_Doc__No__CaptionLbl)
                {
                }
                column(AmountDueCaption; AmountDueCaptionLbl)
                {
                }
                column(AmountDiscountedCaption; AmountDiscountedCaptionLbl)
                {
                }
                column(AmountPaidCaption; AmountPaidCaptionLbl)
                {
                }
                column(AmountAppliedCaption; AmountAppliedCaptionLbl)
                {
                }
                column(AmountPmtDiscToleranceCaption; AmountPmtDiscToleranceCaptionLbl)
                {
                }
                column(AmountPmtToleranceCaption; AmountPmtToleranceCaptionLbl)
                {
                }
                dataitem(DimensionLoop1; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(DimSetEntry__Dimension_Code_; DimSetEntry."Dimension Code")
                    {
                    }
                    column(DimSetEntry__Dimension_Value_Code_; DimSetEntry."Dimension Value Code")
                    {
                    }
                    column(DimSetEntry__Dimension_Value_Code__Control1020068; DimSetEntry."Dimension Value Code")
                    {
                    }
                    column(DimSetEntry__Dimension_Code__Control1020069; DimSetEntry."Dimension Code")
                    {
                    }
                    column(DimensionLoop1_Number; Number)
                    {
                    }
                    column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            DimSetEntry.FIND('-')
                        ELSE
                            DimSetEntry.NEXT();

                        // NA0006.Begin
                        Dim1Number := Number;
                        // NA0006.End
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF ShowDim THEN
                            SETRANGE(Number, 1, DimSetEntry.COUNT)
                        ELSE
                            CurrReport.BREAK();
                    end;
                }
                dataitem(HeaderErrorLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(HeaderErrorLoop_Number; Number)
                    {
                    }
                    column(Warning_Caption; Warning_CaptionLbl)
                    {
                    }

                    trigger OnPostDataItem()
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }
                dataitem("Gen. Journal Line"; "Gen. Journal Line")
                {
                    DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"),
                                   "Journal Batch Name" = FIELD("Journal Batch Name");
                    DataItemLinkReference = "Deposit Header";
                    DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
                    column(Gen__Journal_Line__Account_Type_; "Account Type")
                    {
                    }
                    column(Account_No_____________AccountName; "Account No." + ' - ' + AccountName)
                    {
                    }
                    column(Gen__Journal_Line__Document_Date_; "Document Date")
                    {
                    }
                    column(Gen__Journal_Line__Document_Type_; "Document Type")
                    {
                    }
                    column(Gen__Journal_Line__Document_No__; "Document No.")
                    {
                    }
                    column(Gen__Journal_Line_Description; Description)
                    {
                    }
                    column(Amount; -Amount)
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__Type_; "Applies-to Doc. Type")
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__No__; "Applies-to Doc. No.")
                    {
                    }
                    column(Gen__Journal_Line__Due_Date_; "Due Date")
                    {
                    }
                    column(AmountDue; AmountDue)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountApplied; AmountApplied)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountDiscounted; AmountDiscounted)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountPaid; AmountPaid)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountPmtDiscTolerance; AmountPmtDiscTolerance)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountPmtTolerance; AmountPmtTolerance)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(ApplicationText; ApplicationText)
                    {
                    }
                    column(Gen__Journal_Line_Amount; Amount)
                    {
                    }
                    column(Deposit_Header___Total_Deposit_Amount__Control1000000000; "Deposit Header"."Total Deposit Amount")
                    {
                    }
                    column(Deposit_Header___Total_Deposit_Amount____Amount; "Deposit Header"."Total Deposit Amount" + Amount)
                    {
                    }
                    column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
                    {
                    }
                    column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
                    {
                    }
                    column(Gen__Journal_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Gen__Journal_Line_Account_No_; "Account No.")
                    {
                    }
                    column(Gen__Journal_Line_Applies_to_ID; "Applies-to ID")
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__No__Caption_Control2; Gen__Journal_Line__Applies_to_Doc__No__Caption_Control2Lbl)
                    {
                    }
                    column(AmountDueCaption_Control7; AmountDueCaption_Control7Lbl)
                    {
                    }
                    column(AmountDiscountedCaption_Control10; AmountDiscountedCaption_Control10Lbl)
                    {
                    }
                    column(AmountAppliedCaption_Control12; AmountAppliedCaption_Control12Lbl)
                    {
                    }
                    column(Gen__Journal_Line__Applies_to_Doc__Type_Caption_Control13; Gen__Journal_Line__Applies_to_Doc__Type_Caption_Control13Lbl)
                    {
                    }
                    column(Cust__Ledger_Entry__Due_Date_Caption_Control14; "Cust. Ledger Entry".FIELDCAPTION("Due Date"))
                    {
                    }
                    column(Gen__Journal_Line_DescriptionCaption_Control15; FIELDCAPTION(Description))
                    {
                    }
                    column(Account_TypeCaption; Account_TypeCaptionLbl)
                    {
                    }
                    column(Gen__Journal_Line__Document_Type_Caption_Control17; FIELDCAPTION("Document Type"))
                    {
                    }
                    column(Gen__Journal_Line__Document_No__Caption_Control18; FIELDCAPTION("Document No."))
                    {
                    }
                    column(Account_No_____________AccountNameCaption_Control20; Account_No_____________AccountNameCaption_Control20Lbl)
                    {
                    }
                    column(Gen__Journal_Line__Document_Date_Caption_Control21; Gen__Journal_Line__Document_Date_Caption_Control21Lbl)
                    {
                    }
                    column(AmountPaidCaption_Control11; AmountPaidCaption_Control11Lbl)
                    {
                    }
                    column(AmountCaption_Control19; AmountCaption_Control19Lbl)
                    {
                    }
                    column(AmountPmtDiscToleranceCaption_Control1020031; AmountPmtDiscToleranceCaption_Control1020031Lbl)
                    {
                    }
                    column(AmountPmtToleranceCaption_Control1020033; AmountPmtToleranceCaption_Control1020033Lbl)
                    {
                    }
                    column(Total_Deposit_AmountCaption; Total_Deposit_AmountCaptionLbl)
                    {
                    }
                    column(Total_Deposit_LinesCaption; Total_Deposit_LinesCaptionLbl)
                    {
                    }
                    column(DifferenceCaption; DifferenceCaptionLbl)
                    {
                    }
                    dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Customer No." = FIELD("Account No."),
                                       "Applies-to ID" = FIELD("Applies-to ID");
                        DataItemTableView = SORTING("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                        column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                        {
                        }
                        column(Cust__Ledger_Entry__Document_No__; "Document No.")
                        {
                        }
                        column(Cust__Ledger_Entry__Due_Date_; "Due Date")
                        {
                        }
                        column(Cust__Ledger_Entry_Description; Description)
                        {
                        }
                        column(AmountDue_Control1480024; AmountDue)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountPaid_Control1480025; AmountPaid)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountDiscounted_Control1480026; AmountDiscounted)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountApplied_Control1480027; AmountApplied)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ApplicationText_Control24; ApplicationText)
                        {
                        }
                        column(AmountPmtDiscTolerance_Control1020035; AmountPmtDiscTolerance)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountPmtTolerance_Control1020036; AmountPmtTolerance)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                        {
                        }
                        column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                        {
                        }
                        column(Cust__Ledger_Entry_Applies_to_ID; "Applies-to ID")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            // NA0005.begin
                            // //NA0003.begin
                            // IF (isShow) THEN BEGIN
                            // ApplicationText := 'Application';
                            // isShow := FALSE;
                            // END ELSE
                            // ApplicationText := '';
                            // //NA0003.end
                            // NA0005.end
                            // NA0005.begin
                            IF isShow THEN
                                isShow := FALSE
                            ELSE
                                ApplicationText := '';
                            // NA0005.end

                            CALCFIELDS("Remaining Amount");
                            IF "Currency Code" <> Currency.Code THEN BEGIN
                                "Remaining Amount" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Remaining Amount"),
                                    Currency."Amount Rounding Precision");
                                "Amount to Apply" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Amount to Apply"),
                                    Currency."Amount Rounding Precision");
                                // NA0005.begin
                                "Accepted Payment Tolerance" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Accepted Payment Tolerance"),
                                    Currency."Amount Rounding Precision");
                                // NA0005.end
                                // NA0001.begin
                                // "Original Pmt. Disc. Possible" :=
                                // ROUND(
                                //   CurrExchRate.ExchangeAmtFCYToFCY(
                                //     "Gen. Journal Line"."Posting Date",
                                //     "Currency Code",
                                //     Currency.Code,
                                //     "Original Pmt. Disc. Possible"),
                                // NA0001.end
                                // NA0001.begin
                                "Remaining Pmt. Disc. Possible" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Remaining Pmt. Disc. Possible"),
                                    // NA0001.end
                                    Currency."Amount Rounding Precision");
                            END;
                            AmountDue := "Remaining Amount";
                            // NA0001.begin
                            // IF ("Original Pmt. Disc. Possible" <> 0) AND
                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                            // (RemainingAmountToApply + "Original Pmt. Disc. Possible" >= AmountDue)
                            // THEN
                            // AmountDiscounted := "Original Pmt. Disc. Possible"
                            // NA0001.end
                            // NA0001.begin
                            // NA0005.begin
                            // IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                            // (RemainingAmountToApply + "Remaining Pmt. Disc. Possible" >= AmountDue)
                            // THEN
                            // AmountDiscounted := "Remaining Pmt. Disc. Possible"
                            // // NA0001.end
                            // ELSE
                            // AmountDiscounted := 0;
                            // IF (RemainingAmountToApply + AmountDiscounted) > "Amount to Apply" THEN
                            // AmountApplied := "Amount to Apply"
                            // ELSE
                            // AmountApplied := RemainingAmountToApply + AmountDiscounted;
                            // AmountPaid := AmountApplied - AmountDiscounted;
                            // NA0005.end
                            // NA0005.begin
                            AmountPmtTolerance := "Accepted Payment Tolerance";
                            AmountDiscounted := 0;
                            AmountPmtDiscTolerance := 0;
                            IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                               (("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") OR "Accepted Pmt. Disc. Tolerance") AND
                               (RemainingAmountToApply + AmountPmtTolerance + "Remaining Pmt. Disc. Possible" >= AmountDue)
                            THEN
                                IF "Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date" THEN
                                    AmountDiscounted := "Remaining Pmt. Disc. Possible"
                                ELSE
                                    AmountPmtDiscTolerance := "Remaining Pmt. Disc. Possible";

                            AmountApplied := RemainingAmountToApply + AmountPmtTolerance + AmountDiscounted + AmountPmtDiscTolerance;
                            IF AmountApplied > "Amount to Apply" THEN
                                AmountApplied := "Amount to Apply";
                            AmountPaid := AmountApplied - AmountPmtTolerance - AmountDiscounted - AmountPmtDiscTolerance;
                            // NA0005.end
                            IF AmountApplied > AmountDue THEN
                                AmountApplied := AmountDue;
                            //NA0003.begin
                            RemainingAmountToApply := RemainingAmountToApply - AmountPaid;
                            // NA0005.begin
                            // TotalAmountApplied := -"Gen. Journal Line".Amount - RemainingAmountToApply;
                            // NA0005.end
                            // NA0005.begin
                            TotalAmountApplied := TotalAmountApplied + AmountApplied;
                            // NA0005.end
                            //NA0003.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrintApplications OR
                               ("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."Account Type"::Customer) OR
                               ("Gen. Journal Line"."Applies-to ID" = '')
                            THEN
                                CurrReport.BREAK();
                            // NA0005.begin
                            // //NA0003.begin
                            // isShow := TRUE;
                            // RemainingAmountToApply := -"Gen. Journal Line".Amount;
                            // //NA0003.end
                            // NA0005.end
                            RemainingAmountToApply := 72500;
                            GetCurrencyRecord(Currency, "Deposit Header"."Currency Code");
                        end;
                    }
                    dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Vendor No." = FIELD("Account No."),
                                       "Applies-to ID" = FIELD("Applies-to ID");
                        DataItemTableView = SORTING("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
                        column(AmountDue_Control1480028; AmountDue)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Vendor_Ledger_Entry__Document_Type_; "Document Type")
                        {
                        }
                        column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                        {
                        }
                        column(Vendor_Ledger_Entry__Due_Date_; "Due Date")
                        {
                        }
                        column(Vendor_Ledger_Entry_Description; Description)
                        {
                        }
                        column(AmountPaid_Control1480033; AmountPaid)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountDiscounted_Control1480034; AmountDiscounted)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountApplied_Control1480035; AmountApplied)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ApplicationText_Control1020040; ApplicationText)
                        {
                        }
                        column(AmountPmtTolerance_Control1020041; AmountPmtTolerance)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmountPmtDiscTolerance_Control1020042; AmountPmtDiscTolerance)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                        {
                        }
                        column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                        {
                        }
                        column(Vendor_Ledger_Entry_Applies_to_ID; "Applies-to ID")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            CALCFIELDS("Remaining Amount");
                            IF "Currency Code" <> Currency.Code THEN BEGIN
                                "Remaining Amount" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Remaining Amount"),
                                    Currency."Amount Rounding Precision");
                                "Amount to Apply" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Amount to Apply"),
                                    Currency."Amount Rounding Precision");
                                // NA0005.begin
                                "Accepted Payment Tolerance" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Accepted Payment Tolerance"),
                                    Currency."Amount Rounding Precision");
                                // NA0005.end
                                // NA0001.begin
                                // "Original Pmt. Disc. Possible" :=
                                // ROUND(
                                //   CurrExchRate.ExchangeAmtFCYToFCY(
                                //     "Gen. Journal Line"."Posting Date",
                                //     "Currency Code",
                                //     Currency.Code,
                                //     "Original Pmt. Disc. Possible"),
                                // NA0001.end
                                // NA0001.begin
                                "Remaining Pmt. Disc. Possible" :=
                                  ROUND(
                                    CurrExchRate.ExchangeAmtFCYToFCY(
                                      "Gen. Journal Line"."Posting Date",
                                      "Currency Code",
                                      Currency.Code,
                                      "Remaining Pmt. Disc. Possible"),
                                    // NA0001.end
                                    Currency."Amount Rounding Precision");
                            END;
                            AmountDue := "Remaining Amount";
                            // NA0001.begin
                            // IF ("Original Pmt. Disc. Possible" <> 0) AND
                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                            // (RemainingAmountToApply + "Original Pmt. Disc. Possible" >= AmountDue)
                            // THEN
                            // AmountDiscounted := "Original Pmt. Disc. Possible"
                            // NA0001.end
                            // NA0001.begin
                            // NA0005.begin
                            // IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                            // (RemainingAmountToApply + "Remaining Pmt. Disc. Possible" >= AmountDue)
                            // THEN
                            // AmountDiscounted := "Remaining Pmt. Disc. Possible"
                            // // NA0001.end
                            // ELSE
                            // AmountDiscounted := 0;
                            // IF (RemainingAmountToApply + AmountDiscounted) > "Amount to Apply" THEN
                            // AmountApplied := "Amount to Apply"
                            // ELSE
                            // AmountApplied := RemainingAmountToApply + AmountDiscounted;
                            // AmountPaid := AmountApplied - AmountDiscounted;
                            // NA0005.end
                            // NA0005.begin
                            AmountPmtTolerance := "Accepted Payment Tolerance";
                            AmountDiscounted := 0;
                            AmountPmtDiscTolerance := 0;
                            IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                               (("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") OR "Accepted Pmt. Disc. Tolerance") AND
                               (RemainingAmountToApply + AmountPmtTolerance + "Remaining Pmt. Disc. Possible" >= AmountDue)
                            THEN
                                IF "Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date" THEN
                                    AmountDiscounted := "Remaining Pmt. Disc. Possible"
                                ELSE
                                    AmountPmtDiscTolerance := "Remaining Pmt. Disc. Possible";

                            AmountApplied := RemainingAmountToApply + AmountPmtTolerance + AmountDiscounted + AmountPmtDiscTolerance;
                            IF AmountApplied > "Amount to Apply" THEN
                                AmountApplied := "Amount to Apply";
                            AmountPaid := AmountApplied - AmountPmtTolerance - AmountDiscounted - AmountPmtDiscTolerance;
                            // NA0005.end
                            IF AmountApplied > AmountDue THEN
                                AmountApplied := AmountDue;
                            //NA0003.begin
                            RemainingAmountToApply := RemainingAmountToApply - AmountPaid;
                            // NA0005.begin
                            // TotalAmountApplied := -"Gen. Journal Line".Amount - RemainingAmountToApply;
                            // NA0005.end
                            // NA0005.begin
                            TotalAmountApplied := TotalAmountApplied + AmountApplied;
                            // NA0005.end
                            //NA0003.end
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrintApplications OR
                               ("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."Account Type"::Vendor) OR
                               ("Gen. Journal Line"."Applies-to ID" = '')
                            THEN
                                CurrReport.BREAK();
                            RemainingAmountToApply := -"Gen. Journal Line".Amount;
                            GetCurrencyRecord(Currency, "Deposit Header"."Currency Code");
                        end;
                    }
                    dataitem(TotalApplicationLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(TotalAmountApplied; TotalAmountApplied)
                        {
                            AutoFormatExpression = "Gen. Journal Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RemainingAmountToApply; RemainingAmountToApply)
                        {
                            AutoFormatExpression = "Gen. Journal Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalApplicationLoop_Number; Number)
                        {
                        }
                        column(Total_AppliedCaption; Total_AppliedCaptionLbl)
                        {
                        }
                        column(Remaining_UnappliedCaption; Remaining_UnappliedCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            // NA0005.begin
                            IF isShow THEN
                                CurrReport.BREAK();
                            // NA0005.end
                        end;
                    }
                    dataitem(DimensionLoop2; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(DimSetEntry2__Dimension_Value_Code_; DimSetEntry2."Dimension Value Code")
                        {
                        }
                        column(DimSetEntry2__Dimension_Code_; DimSetEntry2."Dimension Code")
                        {
                        }
                        column(DimSetEntry2__Dimension_Value_Code__Control1020075; DimSetEntry2."Dimension Value Code")
                        {
                        }
                        column(DimSetEntry2__Dimension_Code__Control1020076; DimSetEntry2."Dimension Code")
                        {
                        }
                        column(DimensionLoop2_Number; Number)
                        {
                        }
                        column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                DimSetEntry2.FIND('-')
                            ELSE
                                DimSetEntry2.NEXT();

                            // NA0006.Begin
                            Dim2Number := Number;
                            // AG001.End
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF ShowDim THEN
                                SETRANGE(Number, 1, DimSetEntry2.COUNT)
                            ELSE
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(LineErrorCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(ErrorText_Number__Control1020070; ErrorText[Number])
                        {
                        }
                        column(LineErrorCounter_Number; Number)
                        {
                        }
                        column(Warning_Caption_Control1020071; Warning_Caption_Control1020071Lbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, ErrorCounter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        ErrorCounter := 0;

                        IF "Account No." = '' THEN
                            AddError(
                              STRSUBSTNO(Text005Lbl, FIELDCAPTION("Account No.")));

                        // NA0005.begin
                        isShow := TRUE;
                        ApplicationText := Text016Lbl;
                        RemainingAmountToApply := -Amount;
                        TotalAmountApplied := 0;
                        // NA0005.end

                        CASE "Account Type" OF
                            "Account Type"::"G/L Account":
                                BEGIN
                                    IF GLAccount.GET("Account No.") THEN BEGIN
                                        AccountName := GLAccount.Name;
                                        IF GLAccount.Blocked THEN
                                            AddError(
                                              STRSUBSTNO(Text007Lbl, GLAccount.TABLECAPTION, "Account No.", AccountName));
                                        IF GLAccount."Account Type" <> GLAccount."Account Type"::Posting THEN
                                            AddError(
                                              STRSUBSTNO(Text013Lbl, GLAccount.TABLECAPTION, "Account No."))
                                        ELSE
                                            IF NOT GLAccount."Direct Posting" THEN
                                                AddError(
                                                  STRSUBSTNO(Text012Lbl, GLAccount.TABLECAPTION, "Account No."));
                                    END ELSE BEGIN
                                        AddError(
                                          STRSUBSTNO(Text006Lbl, "Account No.", "Account Type"));
                                        AccountName := STRSUBSTNO(Text001Lbl, GLAccount.TABLECAPTION);
                                    END;
                                    IF Description = AccountName THEN
                                        Description := '';
                                END;
                            "Account Type"::Customer:
                                BEGIN
                                    IF Customer.GET("Account No.") THEN BEGIN
                                        IF Customer.Blocked <> Customer.Blocked::" " THEN
                                            AddError(
                                              STRSUBSTNO(Text007Lbl, Customer.TABLECAPTION, "Account No.", Customer.TABLECAPTION, Customer.Blocked));
                                        AccountName := Customer.Name;
                                    END ELSE BEGIN
                                        AddError(
                                          STRSUBSTNO(Text006Lbl, "Account No.", "Account Type"));
                                        AccountName := STRSUBSTNO(Text001Lbl, Customer.TABLECAPTION);
                                    END;
                                    IF Description = AccountName THEN
                                        Description := '';
                                END;
                            "Account Type"::Vendor:
                                BEGIN
                                    IF Vendor.GET("Account No.") THEN BEGIN
                                        AccountName := Vendor.Name;
                                        IF Vendor.Blocked <> Vendor.Blocked::" " THEN
                                            AddError(
                                              STRSUBSTNO(Text007Lbl, Vendor.TABLECAPTION, "Account No.", Vendor.Blocked));
                                    END ELSE BEGIN
                                        AddError(
                                          STRSUBSTNO(Text006Lbl, "Account No.", "Account Type"));
                                        AccountName := STRSUBSTNO(Text001Lbl, Vendor.TABLECAPTION);
                                    END;
                                    IF Description = AccountName THEN
                                        Description := '';
                                END;
                            "Account Type"::"Bank Account":
                                BEGIN
                                    IF BankAccount2.GET("Account No.") THEN BEGIN
                                        AccountName := BankAccount2.Name;
                                        IF BankAccount2.Blocked THEN
                                            AddError(
                                              STRSUBSTNO(Text007Lbl, BankAccount2.TABLECAPTION, "Account No.", AccountName));
                                    END ELSE BEGIN
                                        AddError(
                                          STRSUBSTNO(Text006Lbl, "Account No.", "Account Type"));
                                        AccountName := STRSUBSTNO(Text001Lbl, BankAccount2.TABLECAPTION);
                                    END;
                                    IF Description = AccountName THEN
                                        Description := '';
                                END;
                            "Account Type"::"IC Partner":
                                BEGIN
                                    IF NOT ICPartner.GET("Account No.") THEN
                                        AddError(
                                          STRSUBSTNO(Text006Lbl, "Account No.", "Account Type"))
                                    ELSE
                                        AccountName := ICPartner.Name;
                                    IF ICPartner.Blocked THEN
                                        AddError(
                                          STRSUBSTNO(Text007Lbl, ICPartner.TABLECAPTION, "Account No.", ''));
                                END;
                            ELSE
                                AddError(
                                  STRSUBSTNO(Text006Lbl, "Account Type", FIELDCAPTION("Account Type")));
                        END;

                        IF "Document Date" = 0D THEN
                            AddError(
                              STRSUBSTNO(Text005Lbl, FIELDCAPTION("Document Date")))
                        ELSE
                            IF "Document Date" <> NORMALDATE("Document Date") THEN
                                AddError(
                                  STRSUBSTNO(Text010Lbl, FIELDCAPTION("Document Date")));

                        IF "Document No." = '' THEN
                            AddError(
                              STRSUBSTNO(Text005Lbl, FIELDCAPTION("Document No.")));

                        IF Amount = 0 THEN
                            AddError(
                              STRSUBSTNO(Text005Lbl, FIELDCAPTION(Amount)))
                        ELSE
                            IF Amount > 0 THEN
                                AddError(
                                  STRSUBSTNO(Text014Lbl, FIELDCAPTION("Credit Amount")));
                        /*
                        IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                          AddError(DimMgt.GetDimCombErr);
                        */
                        TableID[1] := DimMgt.TypeToTableID1("Account Type");
                        No[1] := "Account No.";
                        /*
                        IF NOT DimMgt.CheckDocDimComb(TableID,No,"Dimension Set ID") THEN
                          AddError(DimMgt.GetDimValuePostingErr);
                        */
                        // NA0002.begin
                        ShowApplyToOutput := FALSE;
                        IF PrintApplications AND ("Applies-to Doc. No." <> '') THEN BEGIN
                            ShowApplyToOutput := TRUE;
                            CASE "Account Type" OF
                                "Account Type"::Customer:
                                    BEGIN
                                        CustLedgEntry.RESET();
                                        CustLedgEntry.SETCURRENTKEY(CustLedgEntry."Document No.", CustLedgEntry."Document Type");
                                        CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", "Gen. Journal Line"."Applies-to Doc. Type");
                                        CustLedgEntry.SETRANGE(CustLedgEntry."Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
                                        CustLedgEntry.SETRANGE(CustLedgEntry."Customer No.", "Gen. Journal Line"."Account No.");
                                        IF CustLedgEntry.FINDFIRST() THEN BEGIN
                                            CustLedgEntry.CALCFIELDS(CustLedgEntry."Remaining Amount");
                                            "Gen. Journal Line"."Due Date" := CustLedgEntry."Due Date";
                                            "Gen. Journal Line".Description := CustLedgEntry.Description;
                                            AmountDue := CustLedgEntry."Remaining Amount";
                                            AmountPaid := -"Gen. Journal Line".Amount;
                                            // NA0001.begin
                                            // IF ("Original Pmt. Disc. Possible" <> 0) AND
                                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                                            // (AmountPaid + "Original Pmt. Disc. Possible" >= AmountDue)
                                            // THEN BEGIN
                                            // AmountDiscounted := "Original Pmt. Disc. Possible";
                                            // NA0001.end
                                            // NA0001.begin
                                            // NA0005.begin
                                            // IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                                            // (AmountPaid + "Remaining Pmt. Disc. Possible" >= AmountDue)
                                            // THEN BEGIN
                                            // AmountDiscounted := "Remaining Pmt. Disc. Possible";
                                            // // NA0001.end
                                            // AmountApplied := AmountPaid + AmountDiscounted;
                                            // END ELSE BEGIN
                                            // AmountDiscounted := 0;
                                            // AmountApplied := AmountPaid;
                                            // END;
                                            // NA0005.end
                                            // NA0005.begin
                                            AmountPmtTolerance := CustLedgEntry."Accepted Payment Tolerance";
                                            AmountDiscounted := 0;
                                            AmountPmtDiscTolerance := 0;
                                            IF (CustLedgEntry."Remaining Pmt. Disc. Possible" <> 0) AND
                                               ((CustLedgEntry."Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") OR CustLedgEntry."Accepted Pmt. Disc. Tolerance") AND
                                               (AmountPaid + AmountPmtTolerance + CustLedgEntry."Remaining Pmt. Disc. Possible" >= AmountDue)
                                            THEN
                                                IF CustLedgEntry."Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date" THEN
                                                    AmountDiscounted := CustLedgEntry."Remaining Pmt. Disc. Possible"
                                                ELSE
                                                    AmountPmtDiscTolerance := CustLedgEntry."Remaining Pmt. Disc. Possible";

                                            AmountApplied := AmountPaid + AmountPmtTolerance + AmountDiscounted + AmountPmtDiscTolerance;
                                            // NA0005.end
                                            IF AmountApplied > AmountDue THEN
                                                AmountApplied := AmountDue;
                                            // NA0005.begin
                                            RemainingAmountToApply := RemainingAmountToApply - AmountPaid;
                                            TotalAmountApplied := TotalAmountApplied + AmountApplied;
                                            IF isShow THEN
                                                isShow := FALSE
                                            ELSE
                                                ApplicationText := '';
                                            // NA0005.end
                                        END ELSE
                                            ShowApplyToOutput := FALSE;
                                    END;
                                "Account Type"::Vendor:
                                    BEGIN
                                        VendLedgEntry.RESET();
                                        VendLedgEntry.SETCURRENTKEY(VendLedgEntry."Document No.", VendLedgEntry."Document Type");
                                        VendLedgEntry.SETRANGE(VendLedgEntry."Document Type", "Gen. Journal Line"."Applies-to Doc. Type");
                                        VendLedgEntry.SETRANGE(VendLedgEntry."Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
                                        VendLedgEntry.SETRANGE(VendLedgEntry."Vendor No.", "Gen. Journal Line"."Account No.");
                                        IF VendLedgEntry.FINDFIRST() THEN BEGIN
                                            VendLedgEntry.CALCFIELDS(VendLedgEntry."Remaining Amount");
                                            "Gen. Journal Line"."Due Date" := VendLedgEntry."Due Date";
                                            "Gen. Journal Line".Description := VendLedgEntry.Description;
                                            AmountDue := VendLedgEntry."Remaining Amount";
                                            AmountPaid := -"Gen. Journal Line".Amount;
                                            // NA0001.begin
                                            // IF ("Original Pmt. Disc. Possible" <> 0) AND
                                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                                            // (AmountPaid + "Original Pmt. Disc. Possible" >= AmountDue)
                                            // THEN BEGIN
                                            // AmountDiscounted := "Original Pmt. Disc. Possible";
                                            // NA0001.end
                                            // NA0001.begin
                                            // NA0005.begin
                                            // IF ("Remaining Pmt. Disc. Possible" <> 0) AND
                                            // ("Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") AND
                                            // (AmountPaid + "Remaining Pmt. Disc. Possible" >= AmountDue)
                                            // THEN BEGIN
                                            // AmountDiscounted := "Remaining Pmt. Disc. Possible";
                                            // // NA0001.end
                                            // AmountApplied := AmountPaid + AmountDiscounted;
                                            // END ELSE BEGIN
                                            // AmountDiscounted := 0;
                                            // AmountApplied := AmountPaid;
                                            // END;
                                            // NA0005.end
                                            // NA0005.begin
                                            AmountPmtTolerance := VendLedgEntry."Accepted Payment Tolerance";
                                            AmountDiscounted := 0;
                                            AmountPmtDiscTolerance := 0;
                                            IF (VendLedgEntry."Remaining Pmt. Disc. Possible" <> 0) AND
                                               ((VendLedgEntry."Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date") OR VendLedgEntry."Accepted Pmt. Disc. Tolerance") AND
                                               (AmountPaid + AmountPmtTolerance + VendLedgEntry."Remaining Pmt. Disc. Possible" >= AmountDue)
                                            THEN
                                                IF VendLedgEntry."Pmt. Discount Date" >= "Gen. Journal Line"."Posting Date" THEN
                                                    AmountDiscounted := VendLedgEntry."Remaining Pmt. Disc. Possible"
                                                ELSE
                                                    AmountPmtDiscTolerance := VendLedgEntry."Remaining Pmt. Disc. Possible";

                                            AmountApplied := AmountPaid + AmountPmtTolerance + AmountDiscounted + AmountPmtDiscTolerance;
                                            // NA0005.end
                                            IF AmountApplied > AmountDue THEN
                                                AmountApplied := AmountDue;
                                            // NA0005.begin
                                            RemainingAmountToApply := RemainingAmountToApply - AmountPaid;
                                            TotalAmountApplied := TotalAmountApplied + AmountApplied;
                                            IF isShow THEN
                                                isShow := FALSE
                                            ELSE
                                                ApplicationText := '';
                                            // NA0005.end
                                        END ELSE
                                            ShowApplyToOutput := FALSE;
                                    END;
                                ELSE
                                    ShowApplyToOutput := FALSE;
                            END;
                        END;
                        // NA0002.end

                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(TableID);
                        CLEAR(No);
                        DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                ErrorCounter := 0;

                IF "Bank Account No." = '' THEN
                    AddError(
                      STRSUBSTNO(Text005Lbl, FIELDCAPTION("Bank Account No.")))
                ELSE
                    IF NOT BankAccount.GET("Bank Account No.") THEN BEGIN
                        AddError(
                          STRSUBSTNO(Text006Lbl, "Bank Account No.", FIELDCAPTION("Bank Account No.")));
                        BankAccount.Name := STRSUBSTNO(Text001Lbl, BankAccount.TABLECAPTION);
                    END ELSE
                        IF BankAccount.Blocked THEN
                            AddError(
                              STRSUBSTNO(Text007Lbl, FIELDCAPTION("Bank Account No."), "Bank Account No.", ''));

                IF "Posting Date" = 0D THEN
                    AddError(
                      STRSUBSTNO(Text005Lbl, FIELDCAPTION("Posting Date")))
                ELSE
                    IF "Posting Date" <> NORMALDATE("Posting Date") THEN
                        AddError(
                          STRSUBSTNO(Text010Lbl, FIELDCAPTION("Posting Date")))
                    ELSE BEGIN
                        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                            IF USERID <> '' THEN
                                IF UserSetup.GET(USERID) THEN BEGIN
                                    AllowPostingFrom := UserSetup."Allow Posting From";
                                    AllowPostingTo := UserSetup."Allow Posting To";
                                END;
                            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                                AllowPostingFrom := GLSetup."Allow Posting From";
                                AllowPostingTo := GLSetup."Allow Posting To";
                            END;
                            IF AllowPostingTo = 0D THEN
                                AllowPostingTo := 19991231D;
                            //12319999D;
                        END;
                        IF ("Posting Date" < AllowPostingFrom) OR ("Posting Date" > AllowPostingTo) THEN
                            AddError(
                              STRSUBSTNO(Text011Lbl, FIELDCAPTION("Posting Date")));
                    END;

                IF "Document Date" = 0D THEN
                    AddError(
                      STRSUBSTNO(Text005Lbl, FIELDCAPTION("Document Date")))
                ELSE
                    IF "Document Date" <> NORMALDATE("Document Date") THEN
                        AddError(
                          STRSUBSTNO(Text010Lbl, FIELDCAPTION("Document Date")));

                IF "Total Deposit Amount" = 0 THEN
                    AddError(
                      STRSUBSTNO(Text005Lbl, FIELDCAPTION("Total Deposit Amount")));

                IF "Total Deposit Amount" <> "Total Deposit Lines" THEN
                    AddError(
                      STRSUBSTNO(Text009Lbl, FIELDCAPTION("Total Deposit Amount"), FIELDCAPTION("Total Deposit Lines")));

                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                /*
                IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                  AddError(DimMgt.GetDimCombErr);
                
                TableID[1] := DATABASE::"Bank Account";
                No[1] := "Bank Account No.";
                IF NOT DimMgt.CheckDocDimComb(TableID,No,"Dimension Set ID") THEN
                  AddError(DimMgt.GetDimValuePostingErr);
                */
                //CurrReport.PAGENO := 1;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintApplications; PrintApplications)
                    {
                        Caption = 'Show Applications';
                        ToolTip = 'Specifies the value of the Show Applications field.';
                        ApplicationArea = all;
                    }
                    field(ShowDim; ShowDim)
                    {
                        Caption = 'Show Dimensions';
                        ToolTip = 'Specifies the value of the Show Dimensions field.';
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

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        GLSetup.GET();
    end;

    var
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        BankAccount: Record "Bank Account";
        Currency: Record Currency;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ICPartner: Record "IC Partner";
        GLAccount: Record "G/L Account";
        DimSetEntry: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        BankAccount2: Record "Bank Account";
        UserSetup: Record "User Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        DimMgt: Codeunit DimensionManagement;
        AccountName: Text[100];
        ErrorText: array[100] of Text[250];
        ErrorCounter: Integer;
        PrintApplications: Boolean;
        ShowDim: Boolean;
        Text005Lbl: Label 'You must enter the %1.', Comment = '%1 Posting Date';
        Text006Lbl: Label '%1 is not a valid %2.', Comment = '%1 Account No., %2 Account Type';
        Text007Lbl: Label '%1 %2 is blocked for %3 processing.', Comment = '%1 No , %2 Account No., %3 Blocked';
        Text009Lbl: Label 'The %1 must be equal to the %2.', Comment = '%1 TotalAmount, %2 TotalDepositLine';
        Text000Lbl: Label 'Deposit %1 - Test Report', Comment = '%1 No.';
        Text001Lbl: Label '<Invalid %1>', Comment = '%1 No.';

        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        Text010Lbl: Label '%1 must not be a closing date.', Comment = '%1 Date';
        Text011Lbl: Label '%1 is not within your allowed range of posting dates.', Comment = '%1 posting dates.';
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        Text012Lbl: Label '%1 %2 is not a direct posting account.', Comment = '%1 - No., %2 - posting account.';
        Text013Lbl: Label '%1 %2 is not a posting account.', Comment = '%1 - No., %2 -  Account';
        Text014Lbl: Label '%1 must be a positive number.', Comment = '%1 Positive No.';
        AmountPaid: Decimal;
        AmountDue: Decimal;
        AmountDiscounted: Decimal;
        AmountPmtTolerance: Decimal;
        AmountPmtDiscTolerance: Decimal;
        AmountApplied: Decimal;
        RemainingAmountToApply: Decimal;
        TotalAmountApplied: Decimal;
        ShowApplyToOutput: Boolean;
        ApplicationText: Text[30];
        isShow: Boolean;
        Text016Lbl: Label 'Application';
        Dim1Number: Integer;
        Dim2Number: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        To_Be_Deposited_InCaptionLbl: Label 'To Be Deposited In';
        Deposit_Header___Bank_Account_No__CaptionLbl: Label 'Bank Account No.';
        Currency_CodeCaptionLbl: Label 'Currency Code';
        Deposit_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Deposit_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        Deposit_Header___Posting_Description_CaptionLbl: Label 'Posting Description';
        Deposit_Header___Total_Deposit_Amount_CaptionLbl: Label 'Total Deposit Amount';
        AmountCaptionLbl: Label 'Credit Amount';
        Account_No_____________AccountNameCaptionLbl: Label 'Account No. / Name';
        Gen__Journal_Line__Document_Date_CaptionLbl: Label 'Doc. Date';
        Gen__Journal_Line__Applies_to_Doc__Type_CaptionLbl: Label 'Applies-to';
        Gen__Journal_Line__Applies_to_Doc__No__CaptionLbl: Label 'Applies-to';
        AmountDueCaptionLbl: Label 'Amount Due';
        AmountDiscountedCaptionLbl: Label 'Payment Discount';
        AmountPaidCaptionLbl: Label 'Amount Paid';
        AmountAppliedCaptionLbl: Label 'Total Amount Applied';
        AmountPmtDiscToleranceCaptionLbl: Label 'Pmt. Discount Tolerance';
        AmountPmtToleranceCaptionLbl: Label 'Payment Tolerance';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Warning_CaptionLbl: Label 'Warning:';
        Gen__Journal_Line__Applies_to_Doc__No__Caption_Control2Lbl: Label 'Applies-to';
        AmountDueCaption_Control7Lbl: Label 'Amount Due';
        AmountDiscountedCaption_Control10Lbl: Label 'Payment Discount';
        AmountAppliedCaption_Control12Lbl: Label 'Total Amount Applied';
        Gen__Journal_Line__Applies_to_Doc__Type_Caption_Control13Lbl: Label 'Applies-to';
        Account_TypeCaptionLbl: Label 'Account Type';
        Account_No_____________AccountNameCaption_Control20Lbl: Label 'Account No. / Name';
        Gen__Journal_Line__Document_Date_Caption_Control21Lbl: Label 'Doc. Date';
        AmountPaidCaption_Control11Lbl: Label 'Amount Paid';
        AmountCaption_Control19Lbl: Label 'Credit Amount';
        AmountPmtDiscToleranceCaption_Control1020031Lbl: Label 'Pmt. Discount Tolerance';
        AmountPmtToleranceCaption_Control1020033Lbl: Label 'Payment Tolerance';
        Total_Deposit_AmountCaptionLbl: Label 'Total Deposit Amount';
        Total_Deposit_LinesCaptionLbl: Label 'Total Deposit Lines';
        DifferenceCaptionLbl: Label 'Difference';
        Total_AppliedCaptionLbl: Label 'Total Applied';
        Remaining_UnappliedCaptionLbl: Label 'Remaining Unapplied';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        Warning_Caption_Control1020071Lbl: Label 'Warning:';

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure GetCurrencyRecord(var CurrencyRec: Record Currency; CurrencyCode: Code[10])
    begin
        IF CurrencyCode = '' THEN BEGIN
            CLEAR(CurrencyRec);
            CurrencyRec.Description := GLSetup."LCY Code";
            CurrencyRec."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        END ELSE
            IF CurrencyRec.Code <> CurrencyCode THEN
                IF NOT CurrencyRec.GET(CurrencyCode) THEN
                    AddError(
                      STRSUBSTNO(Text006Lbl, CurrencyCode, "Deposit Header".FIELDCAPTION("Currency Code")));
    end;

    local procedure GetCurrencyCaptionCode(CurrencyCode: Code[10]): Text[80]
    begin
        IF CurrencyCode = '' THEN
            EXIT('101,0,%1');

        GetCurrencyRecord(Currency, CurrencyCode);
        EXIT('101,4,' + Currency.Code);
    end;

    local procedure GetCurrencyCaptionDesc(CurrencyCode: Code[10]): Text[80]
    begin
        IF CurrencyCode = '' THEN
            EXIT('101,1,%1');

        GetCurrencyRecord(Currency, CurrencyCode);
        EXIT('101,4,' + Currency.Description);
    end;
}

