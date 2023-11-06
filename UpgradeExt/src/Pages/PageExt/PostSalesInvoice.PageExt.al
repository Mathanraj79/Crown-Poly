pageextension 50127 "Post Sales Invoice " extends "Posted Sales Invoice"

{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';

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
                action("Send By E-Mail")
                {
                    CaptionML = ENU = 'Send by E-Mail+Print';
                    Promoted = true;
                    Image = SendEmailPDFNoAttach;
                    PromotedCategory = Category4;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        COMMIT();
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        SalesInvHeader.PrintRecords(TRUE);
                    end;
                }
            }
        }
        addbefore("&Electronic Document")
        {
            action("Create EDI Report")
            {
                CaptionML = ENU = 'Create &EDI Report';
                Image = ExportElectronicDocument;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    SalesInvHeader.INIT();
                    SalesInvHeader.SETRANGE("No.", rec."No.");
                    REPORT.RUNMODAL(50017, TRUE, FALSE, SalesInvHeader);

                end;

            }

        }
    }

}
