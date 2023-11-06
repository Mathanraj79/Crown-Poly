pageextension 50130 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';
    layout
    {


    }
    actions
    {
        addafter("&Navigate")
        {
            group("Easy PDF")
            {
                action("Send By E-mail")
                {
                    CaptionML = ENU = 'Send by E-Mail+Print';
                    Promoted = true;
                    Image = SendEmailPDFNoAttach;
                    PromotedCategory = Category4;
                    trigger OnAction()

                    begin
                        COMMIT();
                        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                        PurchRcptHeader.PrintRecords(TRUE);
                    end;
                }
            }
        }
    }
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";

}
