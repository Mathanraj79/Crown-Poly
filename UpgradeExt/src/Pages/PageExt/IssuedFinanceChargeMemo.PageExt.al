pageextension 50001 "Issued Finance Charge Memo" extends "Issued Finance Charge Memo"
{
    PromotedActionCategoriesML = ENU = 'New,Process,Reports';
    layout
    {

    }
    actions
    {
        addafter("&Navigate")
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
                    with IssuedFinChrgMemoHeader do begin
                        COPY(Rec);
                        SETRECFILTER();
                        PrintRecords(true, true, true);
                    end;
                end;

            }

        }

    }
    var
        IssuedFinChrgMemoHeader: Record "Issued Fin. Charge Memo Header";
}
