table 50008 "Rebate Claim"
{
    Caption = 'Rebate Claim';
    DataClassification = CustomerContent;
    DrillDownPageID = "Rebate Claim List";
    LookupPageID = "Rebate Claim List";

    fields
    {
        field(1; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
        }
        field(2; "End User No."; Code[20])
        {
            Caption = 'End User No.';
            TableRelation = "End User";
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(4; "Quantity Claimed"; Decimal)
        {
            Caption = 'Quantity Claimed';
        }
        field(5; "Date Claimed"; Date)
        {
            Caption = 'Date Claimed';
        }
        field(6; Exported; Boolean)
        {
            Caption = 'Exported';
        }
    }

    keys
    {
        key(Key1; "Rebate Claim No.")
        {
            Clustered = true;
        }
        key(Key2; Exported)
        {
        }
        key(Key3; "End User No.")
        {
            SumIndexFields = "Quantity Claimed";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        RebateLedgerEntries: Record "Rebate Ledger Entries";
        RebateInfo: Record "Rebate Information";
    begin
        IF CONFIRM(Text001Lbl) THEN BEGIN
            RebateLedgerEntries.SETRANGE("Rebate Claim No.", "Rebate Claim No.");
            RebateLedgerEntries.DELETEALL();

            RebateInfo.SETRANGE("Customer Type", RebateInfo."Customer Type"::"End User");
            RebateInfo.SETRANGE("No.", "End User No.");
            RebateInfo.SETRANGE("Item No.", "Item No.");
            RebateInfo.SETRANGE("Date Claimed", "Date Claimed");
            IF RebateInfo.FINDSET() THEN
                REPEAT
                    RebateInfo."Quantity Claimed" -= "Quantity Claimed";
                    RebateInfo.MODIFY();
                    IF RebateInfo."Quantity Claimed" = 0 THEN
                        RebateInfo.DELETE();
                UNTIL RebateInfo.NEXT() = 0;
        END;
    end;

    trigger OnInsert()
    var
        GenLedgSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        IF "Rebate Claim No." = '' THEN BEGIN
            SalesSetup.GET();
            GenLedgSetup.GET();
            SalesSetup.TESTFIELD("Customer Nos.");
            NoSeriesMgt.InitSeries(GenLedgSetup."Rebate Nos.", '', 0D, "Rebate Claim No.", GenLedgSetup."Rebate Nos.");
        END;
    end;

    var
        Text001Lbl: Label 'Do you want to delete the rebate claim and the associated entries?';
        Text002Lbl: Label 'Rebate Claim %1 has already been registered.', Comment = '%1 No.';

    procedure FindRebateID()
    var
        RebateProgEndUser: Record "Rebate Program - End User";
        rebateInformation: Record "Rebate Information";
        EndUser: Record "End User";
    begin
        IF Exported THEN
            ERROR(Text002Lbl, "Rebate Claim No.");

        RebateProgEndUser.SETRANGE("End User No.", "End User No.");
        IF RebateProgEndUser.FINDSET() THEN BEGIN
            REPEAT
                CreateWorksheetLines(RebateProgEndUser)
            UNTIL RebateProgEndUser.NEXT() = 0;

            IF NOT rebateInformation.GET(rebateInformation."Customer Type"::"End User", "End User No.", "Item No.", "Date Claimed") THEN BEGIN
                rebateInformation."Customer Type" := rebateInformation."Customer Type"::"End User";
                rebateInformation."No." := "End User No.";
                rebateInformation."Item No." := "Item No.";
                rebateInformation."Date Claimed" := "Date Claimed";
                IF EndUser.GET("End User No.") THEN
                    rebateInformation."Customer No." := EndUser."Customer No.";
                rebateInformation.INSERT();
            END;

            rebateInformation."Quantity Claimed" += "Quantity Claimed";
            rebateInformation.MODIFY();

            Exported := TRUE;
            MODIFY();
        END;
    end;


    procedure CreateWorksheetLines(var RecRebateProgEndUser: Record "Rebate Program - End User")
    var
        RebateProgram: Record "Rebate Program Header";
        RebateDetails: Record "Rebate Program Details";
    begin
        RebateProgram.SETRANGE("Rebate No.", RecRebateProgEndUser."Rebate No.");
        RebateProgram.SETFILTER("Start Date", '<=%1', "Date Claimed");
        RebateProgram.SETFILTER("End Date", '>=%1|%2', "Date Claimed", 0D);
        IF RebateProgram.FINDSET() THEN
            REPEAT
                IF RebateDetails.GET(RebateProgram."Rebate No.", "Item No.") THEN
                    CreateWorksheetLines2(RebateDetails, RebateProgram, RecRebateProgEndUser)
                ELSE BEGIN
                    RebateDetails.SETRANGE("Rebate No.", RebateProgram."Rebate No.");
                    RebateDetails.SETRANGE("Item No.", '');
                    IF RebateDetails.FINDFIRST() THEN
                        CreateWorksheetLines2(RebateDetails, RebateProgram, RecRebateProgEndUser);

                END;
            UNTIL RebateProgram.NEXT() = 0;
    end;


    procedure CreateWorksheetLines2(RebateDetails2: Record "Rebate Program Details"; var RebateProgram2: Record "Rebate Program Header"; var RecRebateProgEndUser2: Record "Rebate Program - End User")
    var
        RebateLedgerEntry: Record "Rebate Ledger Entries";
        EndUser: Record "End User";
        RebateLedgerEntry2: Record "Rebate Ledger Entries";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesHistory: Record "Sales Info.";
        LastYearDate: Date;
        TotalCases: Decimal;
        SalesPrice1: Decimal;
        SalesPrice2: Decimal;
        SalesPricedec: Decimal;
        LineNo: Integer;
    begin
        IF RebateLedgerEntry2.FINDLAST() THEN
            LineNo := RebateLedgerEntry2."Entry No." + 10
        ELSE
            LineNo := 10;

        RebateLedgerEntry."Entry No." := LineNo;
        RebateLedgerEntry."Rebate Claim No." := "Rebate Claim No.";
        RebateLedgerEntry."Rebate No." := RebateProgram2."Rebate No.";
        RebateLedgerEntry."Customer Type" := RebateProgram2."Customer Type";
        IF RebateProgram2."Customer Type" = RebateProgram2."Customer Type"::Customer THEN
            RebateLedgerEntry."No." := RebateProgram2."No."
        ELSE
            RebateLedgerEntry."No." := "End User No.";
        RebateLedgerEntry."Item No." := "Item No.";
        RebateLedgerEntry."Rebate Type" := RebateProgram2."Rebate Type";
        RebateLedgerEntry."Rebate Method" := RebateProgram2."Rebate Method";
        RebateLedgerEntry."Quantity Claimed" := "Quantity Claimed";
        RebateLedgerEntry."Vendor No." := RecRebateProgEndUser2."Vendor No.";

        EndUser.GET("End User No.");

        IF RebateProgram2."Rebate Type" = RebateProgram2."Rebate Type"::Quarterly THEN
            LastYearDate := CALCDATE('<-1Q>', "Date Claimed")
        ELSE
            IF RebateProgram2."Rebate Type" = RebateProgram2."Rebate Type"::Annual THEN
                LastYearDate := CALCDATE('<-1Y>', "Date Claimed");

        SalesInvoiceLine.INIT();
        SalesInvoiceLine.RESET();
        SalesInvoiceLine.SETCURRENTKEY("Sell-to Customer No.", Type, "No.", "Posting Date");
        SalesInvoiceLine.SETRANGE("Sell-to Customer No.", EndUser."Customer No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SETRANGE("No.", "Item No.");
        SalesInvoiceLine.SETRANGE("Posting Date", LastYearDate, "Date Claimed");
        SalesInvoiceLine.CALCSUMS(Quantity, Amount);
        TotalCases := SalesInvoiceLine.Quantity;
        IF TotalCases > 0 THEN
            SalesPrice1 := SalesInvoiceLine.Amount / TotalCases;

        SalesHistory.SETCURRENTKEY("Sell-To Customer No.", "Item No.", "Invoice Date");
        SalesHistory.SETRANGE("Sell-To Customer No.", EndUser."Customer No.");
        SalesHistory.SETRANGE("Item No.", "Item No.");
        SalesHistory.SETRANGE("Invoice Date", LastYearDate, "Date Claimed");
        SalesHistory.CALCSUMS(Quantity, Amount);
        TotalCases += SalesHistory.Quantity;

        IF SalesHistory.Quantity > 0 THEN
            SalesPrice2 := SalesHistory.Amount / SalesHistory.Quantity;

        IF (SalesPrice1 <> 0) AND (SalesPrice2 <> 0) THEN
            SalesPricedec := (SalesPrice1 + SalesPrice2) / 2
        ELSE
            IF (SalesPrice1 = 0) THEN
                SalesPricedec := SalesPrice2
            ELSE
                SalesPricedec := SalesPrice1;

        RebateLedgerEntry."End User Cust No." := EndUser."Customer No.";
        IF RebateDetails2."Rebate Type" = RebateDetails2."Rebate Type"::"%" THEN
            RebateLedgerEntry."Rebate Amount" := (SalesPricedec * (RebateDetails2."Rebate Amount" / 100)) * RebateLedgerEntry."Quantity Claimed"
        ELSE
            RebateLedgerEntry."Rebate Amount" := RebateDetails2."Rebate Amount" * RebateLedgerEntry."Quantity Claimed";
        RebateLedgerEntry."Date Claimed" := "Date Claimed";
        RebateLedgerEntry.INSERT();

        LineNo += 10;
    end;

    procedure CustomPricing(CustNo: Code[20]; ItemNo: Code[20]; Dateclaimed: Date; qty: Decimal): Decimal
    var

        Pricing: Record Pricing;
        UnitPrice: Decimal;
    begin
        Pricing.INIT();
        Pricing.RESET();
        Pricing.SETRANGE("Customer No.", CustNo);
        Pricing.SETRANGE("Item No.", ItemNo);
        Pricing.SETFILTER("Start Date", '<=%1', Dateclaimed);
        Pricing.SETFILTER("End Date", '>%1|=%2', Dateclaimed, 0D);
        Pricing.SETFILTER("Min. Qty", '<=%1', qty);
        IF Pricing.FINDFIRST() THEN
            UnitPrice := Pricing."Unit Price";
        EXIT(UnitPrice);
    end;
}

