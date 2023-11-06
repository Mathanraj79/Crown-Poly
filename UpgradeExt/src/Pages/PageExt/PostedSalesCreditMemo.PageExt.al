pageextension 50129 "Posted Sales Credit Memo" extends "Posted Sales Credit Memo"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports,Easy PDF';
    layout
    {
        addafter("No. Printed")
        {

        }

    }
    actions
    {
        addafter("&Navigate")
        {
            group("Easy PDF")
            {
                action("Send by E-Mail")
                {
                    Promoted = true;
                    Image = SendEmailPDFNoAttach;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        COMMIT();
                        CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                        SalesCrMemoHeader.PrintRecords(TRUE);
                    end;
                }
            }
        }
    }
    VAR
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
}
