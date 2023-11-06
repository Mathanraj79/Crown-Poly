report 50046 "Total Net Pricing"
{
    Caption = 'Total Net Pricing';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem(Item; Item)
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.";

                trigger OnAfterGetRecord()
                var
                    // SalespersonCommision: Record "Sales Commision Setup";
                    // SalesSetup: Record "Sales & Receivables Setup";
                    NetPrice: Record "Net Price";
                    TotalNetPrice: Record "Total Net Price";
                    LineNo: Integer;
                    BCP: Decimal;
                    SCP: Decimal;
                    Freight2: Decimal;
                    POD2: Decimal;
                    Instant2: Decimal;
                    Quarterly2: Decimal;
                    Annually2: Decimal;
                    EndUserPercent: Decimal;
                    BasePrice: Decimal;
                    // salesCommiSionAmt: Decimal;
                    // BrokerCommiSionAmt: Decimal;
                    EndUserCases: Decimal;
                    CCD: Decimal;
                    Singlenetprice: Decimal;
                    Doublenetprice: Decimal;
                    TriplenetPrice: Decimal;
                begin
                    LineNo := 0;

                    NetPrice.SETRANGE("Customer No.", Customer."No.");
                    NetPrice.SETRANGE("Item No.", Item."No.");
                    IF NetPrice.FINDSET() THEN BEGIN
                        REPEAT
                            LineNo += 1;
                            EndUserPercent += NetPrice."End User Case Percent";
                            EndUserCases += NetPrice."End User Cases";
                            Freight2 += NetPrice.Freight * NetPrice."End User Case Percent";
                            Instant2 += NetPrice.Instant * NetPrice."End User Case Percent";
                            POD2 += NetPrice.POD * NetPrice."End User Case Percent";
                            Quarterly2 += NetPrice.Quarterly * NetPrice."End User Case Percent";
                            Annually2 += NetPrice.Annually * NetPrice."End User Case Percent";
                            BCP += NetPrice."Broker Commission Percent" * NetPrice."End User Case Percent";
                            SCP += NetPrice."Sales Commission Percent" * NetPrice."End User Case Percent";
                            BasePrice += NetPrice."Base Price Case" * NetPrice."End User Case Percent";
                            CCD += NetPrice."Case Cost Deduction" * NetPrice."End User Case Percent";
                            Singlenetprice += NetPrice."Single Net Price" * NetPrice."End User Case Percent";
                            Doublenetprice += NetPrice."Double Net Price" * NetPrice."End User Case Percent";
                            TriplenetPrice += NetPrice."Triple Net Price" * NetPrice."End User Case Percent";
                        UNTIL NetPrice.NEXT() = 0;

                        TotalNetPrice.INIT();
                        TotalNetPrice."Entry No." := TotallastEntryNo;
                        TotalNetPrice."Customer No." := Customer."No.";
                        TotalNetPrice."Item No." := Item."No.";
                        TotalNetPrice."End User Case Percent" := EndUserPercent;
                        TotalNetPrice."End User Cases" := EndUserCases;
                        TotalNetPrice."Base Price Case" := BasePrice / 100;
                        TotalNetPrice.Freight := Freight2 / 100;
                        TotalNetPrice.Instant := Instant2 / 100;
                        TotalNetPrice.POD := POD2 / 100;
                        TotalNetPrice.Quarterly := Quarterly2 / 100;
                        TotalNetPrice.Annually := Annually2 / 100;
                        TotalNetPrice."Broker Commission Percent" := BCP / 100;
                        TotalNetPrice."Sales Commission Percent" := SCP / 100;
                        TotalNetPrice."Case Cost Deduction" := CCD / 100;
                        TotalNetPrice."Single Net Price" := Singlenetprice / 100;
                        TotalNetPrice."Double Net Price" := Doublenetprice / 100;
                        TotalNetPrice."Triple Net Price" := TriplenetPrice / 100;
                        TotalNetPrice.INSERT();

                        TotallastEntryNo += 1;
                    END;
                end;
            }

            trigger OnPreDataItem()
            var
                TotalNetPrice: Record "Total Net Price";
            begin
                TotalNetPrice.DELETEALL();
                TotallastEntryNo := 1;

                window.OPEN(text50000Lbl);
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
        TotallastEntryNo: Integer;
        window: Dialog;
        text50000Lbl: Label 'Total net pricing calculation is in progress...';
}

