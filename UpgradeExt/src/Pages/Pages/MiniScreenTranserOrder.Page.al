page 50043 "Mini Screen - Transer Order"
{
    // SSC56 - new object

    Caption = 'Transfer Order Receive';
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
                    field(TransferOrderNo; TransferOrderNo)
                    {
                        Caption = 'Enter Transfer Order';
                        ToolTip = 'Specifies the value of the Enter Transfer Order field.';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            TransferHeader: Record "Transfer Header";
                            TransferOrderPage: Page "Transfer Orders";
                        begin
                            TransferOrderPage.LOOKUPMODE(TRUE);
                            IF TransferOrderPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                TransferOrderPage.GETRECORD(TransferHeader);
                                TransferOrderNo := TransferHeader."No.";
                            END;
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Find Transfer Order ")
            {
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Find Transfer Order ';
                ToolTip = 'Executes the Find Transfer Order  action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    TransferLine: Record "Transfer Line";
                begin
                    IF TransferOrderNo = '' THEN
                        ERROR(Text001Lbl);

                    TransferLine.SETRANGE("Document No.", TransferOrderNo);
                    PAGE.RUNMODAL(Page::"Mini Screen - Transfer Lines 2", TransferLine);
                end;
            }
        }
    }

    var
        Text001Lbl: Label 'Please enter Transfer Order No.';
        TransferOrderNo: Code[20];
}

