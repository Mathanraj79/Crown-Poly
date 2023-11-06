pageextension 50163 "Posted Service Invoice" extends "Posted Service Invoice"
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
        addafter("&Navigate")
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
                        Commit();
                        CurrPage.SetSelectionFilter(ServiceInvHeader);
                        ServiceInvHeader.PrintRecords(TRUE);
                    end;

                }

            }

        }
    }
    var
        ServiceInvHeader: Record "Service Invoice Header";
}
