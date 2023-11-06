pageextension 50165 "Sales Return Order" extends "Sales Return Order"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';

    actions
    {
        addafter("&Print")
        {
            group("Easy PDF")
            {
                action("Send by E-Mail+Print")
                {
                    CaptionML = ENU = 'Send by E-Mail+Print';
                    Promoted = true;
                    Image = SendEmailPDFNoAttach;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        COMMIT();
                        DocPrint.PrintSalesHeader(Rec);

                    end;
                }
            }
        }

    }
    var
        DocPrint: Codeunit "Document-Print";
}
