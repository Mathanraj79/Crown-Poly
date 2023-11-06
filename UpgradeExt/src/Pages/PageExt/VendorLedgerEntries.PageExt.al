pageextension 50106 "Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {

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
                        LedgerEntry: Record 25;
                        BatchId: Text[80];
                        Count: Integer;
                    begin
                        Count := 0;
                        CurrPage.SETSELECTIONFILTER(LedgerEntry);
                        IF LedgerEntry.FIND('-') THEN BEGIN

                            // BatchId := EasyPDFCustomization.GenerateBatchId('VENDOR LEDGER ENTRIES');
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
                        // EASYPDF.end
                    end;
                }
            }
        }
    }
    var
        PostedPurchaseInvoice: Record 122;
        PostedPurchaseCreditMemo: Record 124;

    PROCEDURE GetDocType(LedgerEntry: Record 25): Text[50];
    BEGIN

        // EASYPDF.begin
        CASE LedgerEntry."Document Type" OF

            LedgerEntry."Document Type"::Invoice:
                IF PostedPurchaseInvoice.GET(LedgerEntry."Document No.") THEN
                    EXIT('POSTED PURCHASE INVOICE');

        END;

        EXIT('');
        // EASYPDF.end
    END;



}
