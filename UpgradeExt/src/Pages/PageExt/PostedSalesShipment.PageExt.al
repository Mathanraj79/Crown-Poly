pageextension 50126 "Posted Sales Shipment" extends "Posted Sales Shipment"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';

    layout
    {
        addafter("Shipment Date")
        {

        }
    }
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

                    begin
                        Commit();
                        CurrPage.SetSelectionFilter(SalesShptHeader);
                        SalesShptHeader.PrintRecords(true);
                    end;
                }
            }
        }
    }
    var
        SalesShptHeader: Record "Sales Shipment Header";
}
