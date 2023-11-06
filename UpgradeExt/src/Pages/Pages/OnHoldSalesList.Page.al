page 50068 "On Hold Sales List"
{
    Caption = 'Sales List';
    DataCaptionFields = "Document Type";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = FILTER(Order),
                            "On Hold" = FILTER(<> ''));
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the number of the estimate.';
                    ApplicationArea = all;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies if the document was put on hold when it was posted, for example because payment of the resulting customer ledger entries is overdue.';
                    Caption = 'On Hold';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //SCSFN 011408
                        IF rec.Status = rec.Status::Open THEN
                            IF xRec."On Hold" <> '' THEN
                                IF rec."On Hold" = '' THEN
                                    IF rec.Finalized THEN
                                        ReleaseSalesDoc.RUN(Rec);
                        //SCSFN 011408
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that you invoiced the items to.';
                    Caption = 'Sell-to Customer No.';
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ToolTip = 'Specifies the customer''s name.';
                    Caption = 'Sell-to Customer Name';
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document. You can fill this field to use it later to search for sales lines using the customer''s order number.';
                    Caption = 'External Document No.';
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the postal code.';
                    Caption = 'Sell-to Post Code';
                    ApplicationArea = all;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country or region of the address.';
                    Caption = 'Sell-to Country/Region Code';
                    ApplicationArea = all;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the contact person at the customer.';
                    Caption = 'Sell-to Contact';
                    ApplicationArea = all;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the number of the customer that the invoice is sent to.';
                    Caption = 'Bill-to Customer No.';
                    ApplicationArea = all;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the customer that the items are shipped to.';
                    Caption = 'Bill-to Name';
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ToolTip = 'Specifies the requested delivery date for the customer order.';
                    Caption = 'Requested Delivery Date';
                    ApplicationArea = all;
                }
                field(Finalized; Rec.Finalized)
                {
                    ToolTip = 'Specifies the value of the Finalized field.';
                    Caption = 'Finalized';
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the status of the document.';
                    Caption = 'Status';
                    ApplicationArea = all;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Caption = 'Estimated Shipment Date';
                    ToolTip = 'Specifies the next data a shipment is planned for the order.';
                    ApplicationArea = all;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the post code of the of the customer that the invoice is sent to.';
                    Caption = 'Bill-to Post Code';
                    ApplicationArea = all;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country or region of the address.';
                    Caption = 'Bill-to Country/Region Code';
                    ApplicationArea = all;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the contact at the customer that the invoice is sent to.';
                    Caption = 'Bill-to Contact';
                    ApplicationArea = all;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the address that items were shipped to. This field is used when multiple the customer has multiple ship-to addresses.';
                    Caption = 'Ship-to Code';
                    ApplicationArea = all;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                    ToolTip = 'Specifies the name of the customer at the address that the items were shipped to.';
                    Caption = 'Ship-to Name';
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the post code at the address that the items were shipped to.';
                    Caption = 'Ship-to Post Code';
                    ApplicationArea = all;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the country or region of the address.';
                    Caption = 'Ship-to Country/Region Code';
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                    ToolTip = 'Specifies the contact person at the address that the items were shipped to.';
                    Caption = 'Ship-to Contact';
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the date when the sales order was invoiced.';
                    Caption = 'Posting Date';
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the dimension value code that the sales line is associated with.';
                    Caption = 'Shortcut Dimension 1 Code';
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the dimension value code that the sales line is associated with.';
                    Caption = 'Shortcut Dimension 2 Code';
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                    Caption = 'Location Code';
                    ApplicationArea = all;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the salesperson that is assigned to the order.';
                    Caption = 'Salesperson Code';
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the currency of amounts on the sales document. By default, the field is filled with the value in the Currency Code field on the customer card.';
                    Caption = 'Currency Code';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Quote:
                                PAGE.RUN(PAGE::"Sales Quote", Rec);
                            Rec."Document Type"::Order:
                                PAGE.RUN(PAGE::"Sales Order", Rec);
                            Rec."Document Type"::Invoice:
                                PAGE.RUN(PAGE::"Sales Invoice", Rec);
                            Rec."Document Type"::"Return Order":
                                PAGE.RUN(PAGE::"Sales Return Order", Rec);
                            Rec."Document Type"::"Credit Memo":
                                PAGE.RUN(PAGE::"Sales Credit Memo", Rec);
                            Rec."Document Type"::"Blanket Order":
                                PAGE.RUN(PAGE::"Blanket Sales Order", Rec);
                        END;
                    end;
                }
            }
        }
    }

    var
        ReleaseSalesDoc: Codeunit "Release Sales Document";
}

