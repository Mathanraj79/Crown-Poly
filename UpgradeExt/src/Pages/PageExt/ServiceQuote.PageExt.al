pageextension 50159 "Service Quote" extends "Service Quote"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';
    layout
    {
        modify("Bill-to County")
        {
            CaptionML = ENU = 'State / ZIP Code';
        }
    }
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
                        DocPrint: Codeunit "Document-Print";
                    begin
                        Commit();
                        CurrPage.Update(TRUE);
                        DocPrint.PrintServiceHeader(Rec);
                    end;
                }
            }

        }
    }
}
