pageextension 50161 "Posted Service Shipment" extends "Posted Service Shipment"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';

    actions
    {
        addafter("&Navigate")
        {
            group("Easy PDF")
            {
                action("Send by E-Mail")
                {
                    CaptionML = ENU = 'Send by E-Mail';
                    Promoted = true;
                    PromotedIsBig = true;
                    Image = SendEmailPDF;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        COMMIT();
                        CurrPage.SETSELECTIONFILTER(ServShptHeader);
                        ServShptHeader.PrintRecords(TRUE);
                    end;
                }
            }
        }
    }
    var
        ServShptHeader: Record "Service Shipment Header";
}
