page 50016 "CP Rebate Worksheet"
{
    Caption = 'Rebate Worksheet';
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Rebate Worksheet";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = all;
                }
                field("Rebate ID"; Rec."Rebate ID")
                {
                    Caption = 'Rebate ID';
                    ToolTip = 'Specifies the value of the Rebate ID field.';
                    ApplicationArea = all;
                }
                field("Enduser ID"; Rec."Enduser ID")
                {
                    Caption = 'Enduser ID';
                    ToolTip = 'Specifies the value of the Enduser ID field.';
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field(Consolidate; Rec.Consolidate)
                {
                    Caption = 'Consolidate';
                    ToolTip = 'Specifies the value of the Consolidate field.';
                    ApplicationArea = all;
                }
                field("Do Not Consolidate"; Rec."Do Not Consolidate")
                {
                    Caption = 'Do Not Consolidate';
                    ToolTip = 'Specifies the value of the Do Not Consolidate field.';
                    ApplicationArea = all;
                }
                field("Quantity Claimed"; Rec."Quantity Claimed")
                {
                    Caption = 'Quantity Claimed';
                    ToolTip = 'Specifies the value of the Quantity Claimed field.';
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    ApplicationArea = all;
                }
                field("Total Rebate Amount"; Rec."Total Rebate Amount")
                {
                    Caption = 'Total Rebate Amount';
                    ToolTip = 'Specifies the value of the Total Rebate Amount field.';
                    ApplicationArea = all;
                }
                field("Rebate Method"; Rec."Rebate Method")
                {
                    Caption = 'Rebate Method';
                    ToolTip = 'Specifies the value of the Rebate Method field.';
                    ApplicationArea = all;
                }
                field("Date Claimed"; Rec."Date Claimed")
                {
                    Caption = 'Date Claimed';
                    ToolTip = 'Specifies the value of the Date Claimed field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculate Rebates")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Calculate Rebates';
                ToolTip = 'Executes the Calculate Rebates action.';
                ApplicationArea = all;
                trigger OnAction()
                var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    RebateLedgerEntry: Record "Rebate Ledger Entries";
                    SalesRebates: Report 50050;
                    CreateWorkSheetLines: Report "Create Rebate Worksheet";
                begin
                    REPORT.RUNMODAL(Report::"Create Rebate Worksheet");
                    CurrPage.UPDATE();
                end;
            }
            action("Create Rebates")
            {
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Create Rebates';
                ToolTip = 'Executes the Create Rebates action.';
                ApplicationArea = all;
                trigger OnAction()
                var
                    RebateWorkSheet: Record "Rebate Worksheet";
                    genledgsetup: Record "General Ledger Setup";
                    GenJnlLine2: Record "Gen. Journal Line";
                    Item2: Record Item;
                    Cust: Record Customer;
                    QtyClaimed2: Decimal;
                    TotalAmount2: Decimal;
                begin
                    genledgsetup.GET();
                    SalesrecSetup.GET();

                    GenJnlLine2.SETRANGE("Journal Template Name", 'PAYMENT');
                    GenJnlLine2.SETRANGE("Journal Batch Name", genledgsetup."Rebate Processing Batch");
                    IF GenJnlLine2.FINDLAST() THEN
                        LineNo := GenJnlLine2."Line No." + 10
                    ELSE
                        LineNo := 10;

                    RebateWorkSheet.COPY(Rec);
                    IF RebateWorkSheet.FINDSET() THEN
                        REPEAT
                            TempCust2."No." := RebateWorkSheet."Customer No.";
                            IF NOT TempCust2.INSERT() THEN;
                            TempItem2."No." := RebateWorkSheet."Item No.";
                            IF NOT TempItem2.INSERT() THEN;
                        UNTIL RebateWorkSheet.NEXT() = 0;

                    Window.OPEN(Text50000Lbl);

                    IF TempCust2.FINDSET() THEN
                        REPEAT
                            Window.UPDATE(1, TempCust2."No.");

                            IF TempItem2.FINDSET() THEN BEGIN
                                TempItem.DELETEALL();
                                REPEAT
                                    Window.UPDATE(2, TempItem2."No.");

                                    RebateWorkSheet.RESET();
                                    RebateWorkSheet.COPY(Rec);
                                    RebateWorkSheet.SETCURRENTKEY("Rebate Method", Consolidate, "Customer No.", "Item No.");
                                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Credit Memo");
                                    RebateWorkSheet.SETRANGE(Consolidate, TRUE);
                                    RebateWorkSheet.SETRANGE("Customer No.", TempCust2."No.");
                                    RebateWorkSheet.SETRANGE("Item No.", TempItem2."No.");
                                    RebateWorkSheet.CALCSUMS("Quantity Claimed", "Total Rebate Amount");

                                    TempItem.INIT();
                                    TempItem."No." := TempItem2."No.";
                                    TempItem."Unit Cost" := RebateWorkSheet."Quantity Claimed";
                                    TempItem."Standard Cost" := RebateWorkSheet."Total Rebate Amount";
                                    IF RebateWorkSheet."Quantity Claimed" <> 0 THEN
                                        TempItem.INSERT();
                                UNTIL TempItem2.NEXT() = 0;
                            END;

                            IF TempItem.FINDFIRST() THEN
                                CreateSalesCreditmemoConsol(TempCust2."No.");
                        UNTIL TempCust2.NEXT() = 0;

                    Window.CLOSE();

                    RebateWorkSheet.RESET();
                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Credit Memo");
                    RebateWorkSheet.SETRANGE(Consolidate, TRUE);
                    RebateWorkSheet.DELETEALL();

                    RebateWorkSheet.RESET();
                    RebateWorkSheet.COPY(Rec);
                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Credit Memo");
                    RebateWorkSheet.SETRANGE("Do Not Consolidate", TRUE);
                    IF RebateWorkSheet.FINDSET() THEN
                        REPEAT
                            CreateSalesCreditmemo(RebateWorkSheet);
                        UNTIL RebateWorkSheet.NEXT() = 0;

                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Credit Memo");
                    RebateWorkSheet.SETRANGE("Do Not Consolidate", TRUE);
                    RebateWorkSheet.DELETEALL();

                    RebateWorkSheet.RESET();
                    RebateWorkSheet.COPY(Rec);
                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Check To End User");
                    IF RebateWorkSheet.FINDSET() THEN
                        REPEAT
                            CreatePaymentLine(RebateWorkSheet);
                            LineNo += 10;
                        UNTIL RebateWorkSheet.NEXT() = 0;

                    RebateWorkSheet.RESET();
                    RebateWorkSheet.COPY(Rec);
                    RebateWorkSheet.SETRANGE("Rebate Method", RebateWorkSheet."Rebate Method"::"Check To End User");
                    RebateWorkSheet.DELETEALL();

                    CurrPage.UPDATE();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.UPDATE();
    end;

    var
        genledgsetup: Record "General Ledger Setup";
        SalesrecSetup: Record "Sales & Receivables Setup";
        TempItem: Record Item temporary;
        TempItem2: Record Item temporary;
        TempCust2: Record Customer temporary;
        LineNo: Integer;
        DateClaimed: Text[250];
        StartingDate: Date;
        EndingDate: Date;
        Window: Dialog;
        Text50000Lbl: Label 'Customer No.: ###1########\  Item No.: #####2########', Comment = '%1 Customer No.,%2 Item No.';
        TextLbl: label 'REBATE CLAIM NO.: %1', Comment = '%1 Claim No.';

    procedure CreateSalesCreditmemo(var RecRebateWorkSheet: Record "Rebate Worksheet")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        SalesrecSetup.GET();
        genledgsetup.GET();

        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        SalesHeader.VALIDATE("No.", NoSeriesMgmt.GetNextNo(SalesrecSetup."Credit Memo Nos.", TODAY, TRUE));
        SalesHeader.VALIDATE("Sell-to Customer No.", RecRebateWorkSheet."Customer No.");
        SalesHeader."Rebate Claim" := TRUE;
        SalesHeader."Rebate Claim No." := RecRebateWorkSheet."Document No.";
        SalesHeader."External Document No." := RecRebateWorkSheet."Document No.";
        SalesHeader.INSERT(TRUE);

        SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
        SalesLine.VALIDATE("Document No.", SalesHeader."No.");
        SalesLine."Line No." := LineNo;
        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
        SalesLine.VALIDATE("No.", genledgsetup."Rebate Account");
        SalesLine.VALIDATE(Description, STRSUBSTNO(TextLbl, RecRebateWorkSheet."Item No."));
        SalesLine.VALIDATE("Sell-to Customer No.", RecRebateWorkSheet."Customer No.");
        IF RecRebateWorkSheet."Quantity Claimed" <> 0 THEN
            SalesLine.VALIDATE("Unit Price", RecRebateWorkSheet."Total Rebate Amount" / RecRebateWorkSheet."Quantity Claimed");
        SalesLine.VALIDATE(Quantity, RecRebateWorkSheet."Quantity Claimed");
        SalesLine.INSERT(TRUE);
    end;


    procedure CreatePaymentLine(var RecRebateWorkSheet2: Record "Rebate Worksheet")
    var
        GenJnlLine: Record "Gen. Journal Line";
        Vend2: Record Vendor;
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        genledgsetup.GET();
        GenJnlLine."Journal Template Name" := 'PAYMENT';
        GenJnlLine."Journal Batch Name" := genledgsetup."Rebate Processing Batch";
        GenJnlLine."Line No." := LineNo;
        GenJnlLine.VALIDATE(GenJnlLine."Posting Date", TODAY);
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine.VALIDATE(GenJnlLine."Document No.", RecRebateWorkSheet2."Rebate ID");
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.", RecRebateWorkSheet2."Vendor No.");
        GenJnlLine."External Document No." := RecRebateWorkSheet2."Document No.";
        Vend2.GET(RecRebateWorkSheet2."Vendor No.");
        Vend2.CheckBlockedVendOnJnls(Vend2, GenJnlLine."Document Type", FALSE);
        GenJnlLine.Description := Vend2.Name;
        GenJnlLine."Posting Group" := Vend2."Vendor Posting Group";
        GenJnlLine."Salespers./Purch. Code" := Vend2."Purchaser Code";
        GenJnlLine."Payment Terms Code" := Vend2."Payment Terms Code";
        GenJnlLine.VALIDATE(GenJnlLine."Bill-to/Pay-to No.", GenJnlLine."Account No.");
        GenJnlLine.VALIDATE(GenJnlLine."Sell-to/Buy-from No.", GenJnlLine."Account No.");
        GenJnlLine."Gen. Posting Type" := 0;
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.VALIDATE(GenJnlLine."Payment Terms Code");
        GenJnlLine.VALIDATE(GenJnlLine.Amount, RecRebateWorkSheet2."Total Rebate Amount");
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := SalesrecSetup."Bank Account";
        GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
        GenJnlLine."Rebate Claim" := TRUE;
        GenJnlLine."Rebate Claim No." := RecRebateWorkSheet2."Rebate ID";
        GenJnlLine.INSERT(TRUE);
    end;


    procedure CreateRebateLines()
    var
        RebateLedgerEntryRec: Record "Rebate Ledger Entries";
        EndUser: Record "End User";
    begin
        LineNo := 10;

        RebateLedgerEntryRec.SETRANGE("Instant Credits", FALSE);
        RebateLedgerEntryRec.SETRANGE("Date Claimed", StartingDate, EndingDate);
        IF RebateLedgerEntryRec.FINDSET() THEN
            REPEAT
                Rec."Entry No." := LineNo;
                Rec."Rebate ID" := RebateLedgerEntryRec."Rebate No.";
                IF RebateLedgerEntryRec."Customer Type" = RebateLedgerEntryRec."Customer Type"::Customer THEN
                    Rec."Customer No." := RebateLedgerEntryRec."No."
                ELSE BEGIN
                    Rec."Enduser ID" := RebateLedgerEntryRec."No.";
                    IF EndUser.GET(RebateLedgerEntryRec."No.") THEN BEGIN
                        Rec."Customer No." := EndUser."Customer No.";
                        Rec."Vendor No." := EndUser."Vendor No.";
                    END;
                END;
                Rec."Item No." := RebateLedgerEntryRec."Item No.";
                Rec."Quantity Claimed" := RebateLedgerEntryRec."Quantity Claimed";
                Rec."Total Rebate Amount" := RebateLedgerEntryRec."Rebate Amount";
                Rec."Rebate Method" := RebateLedgerEntryRec."Rebate Method";
                Rec."Date Claimed" := RebateLedgerEntryRec."Date Claimed";
                Rec.INSERT();

                LineNo += 10;
            UNTIL RebateLedgerEntryRec.NEXT() = 0;
    end;


    procedure CreateSalesCreditmemoConsol(CustNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        SalesrecSetup.GET();
        genledgsetup.GET();

        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        SalesHeader.VALIDATE("No.", NoSeriesMgmt.GetNextNo(SalesrecSetup."Credit Memo Nos.", TODAY, TRUE));
        SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
        SalesHeader."Rebate Claim" := TRUE;
        SalesHeader.INSERT(TRUE);

        LineNo := 10;

        IF TempItem.FINDSET() THEN
            REPEAT
                SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                SalesLine."Line No." := LineNo;
                SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                SalesLine.VALIDATE("No.", genledgsetup."Rebate Account");
                SalesLine.VALIDATE(Description, STRSUBSTNO(TextLbl, TempItem."No."));
                SalesLine.VALIDATE("Sell-to Customer No.", CustNo);
                SalesLine.VALIDATE(Quantity, TempItem."Unit Cost");
                IF TempItem."Unit Cost" <> 0 THEN
                    SalesLine.VALIDATE("Unit Price", TempItem."Standard Cost" / TempItem."Unit Cost");
                SalesLine.INSERT(TRUE);

                LineNo += 10;
            UNTIL TempItem.NEXT() = 0;
    end;
}

