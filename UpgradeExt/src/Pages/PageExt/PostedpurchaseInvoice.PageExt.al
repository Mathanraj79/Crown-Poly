pageextension 50131 "Posted purchase Invoice" extends "Posted Purchase Invoice"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';

    layout
    {


    }
    actions
    {
        addafter("&Navigate")
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
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(TRUE);
                end;
            }

        }
    }
    var
        PurchInvHeader: Record "Purch. Inv. Header";
}
