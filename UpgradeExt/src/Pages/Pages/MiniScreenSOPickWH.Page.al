page 50044 "Mini Screen - SO Pick WH"
{
    // SSC56 - new object

    Caption = 'Sales Order Pick - WH';
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
                    field(SalesOrderNo; SalesOrderNo)
                    {
                        Caption = 'Enter Sales Order No.';
                        ColumnSpan = 2;
                        ToolTip = 'Specifies the value of the Enter Sales Order No. field.';
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesHeader: Record "Sales Header";
                            SalesOrderPage: Page "Sales List";
                        begin
                            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                            SalesOrderPage.SETTABLEVIEW(SalesHeader);
                            SalesOrderPage.LOOKUPMODE(TRUE);
                            IF SalesOrderPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                SalesOrderPage.GETRECORD(SalesHeader);
                                SalesOrderNo := SalesHeader."No.";
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
            action("Find Sales Order")
            {
                Caption = 'Find Sales Order';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Find Sales Order action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                begin
                    IF SalesOrderNo = '' THEN
                        ERROR(Text001Lbl);

                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", SalesOrderNo);
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    PAGE.RUN(Page::"Mini Screen - Sales Lines 2", SalesLine);
                end;
            }
        }
    }

    var
        SalesOrderNo: Code[20];
        Text001Lbl: Label 'Please enter Sales Order No.';

}

