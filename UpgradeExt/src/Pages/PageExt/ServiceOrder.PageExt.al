pageextension 50158 "Service Order" extends "Service Order"
{
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
            action("Send By E-Mail")
            {
                CaptionML = ENU = 'Send by E-Mail+Print';
                Promoted = true;
                Image = SendEmailPDFNoAttach;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    COMMIT();
                    CurrPage.UPDATE(TRUE);
                    DocPrint.PrintServiceHeader(Rec);
                end;
            }
        }
    }
}
