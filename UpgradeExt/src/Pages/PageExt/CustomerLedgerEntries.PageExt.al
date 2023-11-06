pageextension 50103 "Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
        }

    }
    actions
    {
        addafter("&Navigate")
        {
            group("Easy PDF")
            {
                Image = Report;
                action("Send By E-Mail")
                {
                    CaptionML = ENU = 'Send by E-Mail';
                    Promoted = true;
                    Image = SendEmailPDF;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        IF GetDocType(Rec) = '' THEN BEGIN
                            MESSAGE('%1 %2 not found', FORMAT(Rec."Document Type"), Rec."Document No.");
                            EXIT;
                        END;
                    end;
                }
                action("Send By FAX")
                {
                    CaptionML = ENU = 'Send by FAX';
                    Promoted = true;
                    Image = SendElectronicDocument;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        IF GetDocType(Rec) = '' THEN BEGIN
                            MESSAGE('%1 %2 not found', FORMAT(Rec."Document Type"), Rec."Document No.");
                            EXIT;
                        END;
                    end;

                }
                action("Send by Preferred Method")
                {
                    CaptionML = ENU = 'Send by Preferred Method';
                    Promoted = true;
                    Image = SendTo;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        IF GetDocType(Rec) = '' THEN BEGIN
                            MESSAGE('%1 %2 not found', FORMAT(Rec."Document Type"), Rec."Document No.");
                            EXIT;
                        END;
                    end;
                }
                action("Send Selection To batch")
                {
                    CaptionML = ENU = 'Send Selected to Batch';
                    Promoted = true;
                    Image = SelectEntries;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        LedgerEntry: Record 21;
                        BatchId: Text[80];
                        Count: Integer;
                    begin
                        Count := 0;
                        CurrPage.SETSELECTIONFILTER(LedgerEntry);
                        IF LedgerEntry.FIND('-') THEN BEGIN

                            // BatchId := EasyPDFCustomization.GenerateBatchId('CUSTOMER LEDGER ENTRIES');
                            REPEAT
                                IF GetDocType(LedgerEntry) <> '' THEN BEGIN
                                    //   EasyPDF.SendByPreferredMethodBatch(GetDocType(LedgerEntry), LedgerEntry."Document No.", BatchId);
                                    Count += 1;
                                END;
                            UNTIL LedgerEntry.NEXT() = 0;

                            IF Count > 0 THEN BEGIN
                                //  EasyPDFQueue.RESET;
                                //  EasyPDFQueue.SETRANGE(BatchId, BatchId);
                                //  PAGE.RUN(PAGE::"EasyPDF Batch Queues", EasyPDFQueue);
                            END;

                        END;
                    end;
                }
            }
        }
    }
    var
        PostedSalesInvoice: Record 112;
        PostedSalesCreditMemo: Record 114;
        IssuedFinanceChargeMemo: Record 304;
        IssuedReminder: Record 297;


    PROCEDURE GetDocType(LedgerEntry: Record 21): Text[50];
    BEGIN

        // EASYPDF.begin
        CASE LedgerEntry."Document Type" OF

            LedgerEntry."Document Type"::Invoice:
                IF PostedSalesInvoice.GET(LedgerEntry."Document No.") THEN
                    EXIT('POSTED SALES INVOICE');

            LedgerEntry."Document Type"::"Credit Memo":
                IF PostedSalesCreditMemo.GET(LedgerEntry."Document No.") THEN
                    EXIT('POSTED SALES CREDIT MEMO');

            LedgerEntry."Document Type"::"Finance Charge Memo":
                IF IssuedFinanceChargeMemo.GET(LedgerEntry."Document No.") THEN
                    EXIT('FINANCE CHARGE MEMO');

            LedgerEntry."Document Type"::Reminder:
                IF PostedSalesInvoice.GET(LedgerEntry."Document No.") THEN
                    EXIT('ISSUED REMINDER');

        END;

        EXIT('');

    END;
}
