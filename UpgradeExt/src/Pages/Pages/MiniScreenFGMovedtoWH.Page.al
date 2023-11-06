page 50042 "Mini Screen - FG Moved to WH"
{
    // SSC56 - new object

    Caption = 'FG Moved to WH';
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Main Menu")
            {
                Caption = 'Main Menu';
                group(WELCOME)
                {
                    Caption = 'WELCOME';
                    field(USERID; USERID)
                    {
                        Caption = 'User ID';
                        ColumnSpan = 2;
                        Editable = false;
                        Enabled = false;
                        ToolTip = 'Specifies the value of the User ID field.';
                        ApplicationArea = All;
                    }
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Enter Posting Date';
                        ToolTip = 'Specifies the value of the Enter Posting Date field.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Transfer Order")
            {
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Create Transfer Order';
                ToolTip = 'Executes the Create Transfer Order action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    InvtSetup: Record "Inventory Setup";
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferLinePage: Page "Mini Screen - Transfer Lines 1";
                begin
                    IF PostingDate = 0D THEN
                        ERROR(Text001Lbl);

                    InvtSetup.GET();
                    InvtSetup.TESTFIELD("Default Transfer-from Location");
                    InvtSetup.TESTFIELD("Default In Transit Location");

                    TransferHeader.INIT();
                    TransferHeader.VALIDATE("Posting Date", PostingDate);
                    TransferHeader.INSERT(TRUE);
                    TransferHeader.VALIDATE("Transfer-from Code", InvtSetup."Default Transfer-from Location");
                    TransferHeader.VALIDATE("In-Transit Code", InvtSetup."Default In Transit Location");
                    TransferHeader.MODIFY();

                    COMMIT();

                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    TransferLinePage.SETTABLEVIEW(TransferLine);
                    TransferLinePage.SetTransferHeader(TransferHeader."No.");
                    TransferLinePage.RUNMODAL();
                end;
            }
        }
    }

    var
        Text001Lbl: Label 'Please enter Posting Date.';
        PostingDate: Date;
}

