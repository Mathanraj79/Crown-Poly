pageextension 50167 "Posted Return Receipt" extends "Posted Return Receipt"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Easy PDF';

    actions
    {
        addafter("&Navigate")
        {
            group("Easy PDF")
            {
                action("Send By E-Mail")
                {
                    CaptionML = ENU = 'Send by E-Mail+Print';
                    Promoted = true;
                    Image = SendEmailPDFNoAttach;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        Commit();
                        CurrPage.SetSelectionFilter(ReturnRcptHeader);
                        ReturnRcptHeader.PrintRecords(TRUE);

                    end;
                }
            }
        }
    }
    var
        ReturnRcptHeader: Record "Return Receipt Header";
}
