pageextension 50160 " Posted Service Credit Memo" extends "Posted Service Credit Memo"
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
                    ToolTip = 'Send by E-Mail+Print';
                    PromotedCategory = Category4;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        COMMIT();
                        CurrPage.SETSELECTIONFILTER(ServCrMemoHeader);
                        ServCrMemoHeader.PrintRecords(TRUE);
                    end;
                }
            }
        }
    }
    var
        ServCrMemoHeader: Record "Service Cr.Memo Header";
}
