pageextension 50145 "Issued Reminder" extends "Issued Reminder"
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
                    with IssuedReminderHeader do begin
                        Copy(Rec);
                        SetRecFilter();
                        PrintRecords(true, true, true);
                    end;

                end;
            }
        }
    }
    var
        IssuedReminderHeader: Record "Issued Reminder Header";
}
