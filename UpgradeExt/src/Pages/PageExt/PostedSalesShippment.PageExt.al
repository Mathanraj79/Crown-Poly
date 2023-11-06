pageextension 50134 "Posted Sales Shippment" extends "Posted Sales Shipments"
{

    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify("Sell-to Customer No.")
        {
            Editable = false;
        }
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Sell-to Contact")
        {
            Editable = false;
        }
        modify("Bill-to Customer No.")
        {
            Editable = false;
        }
        modify("Bill-to Name")
        {
            Editable = false;
        }
        modify("Bill-to Post Code")
        {
            Editable = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Bill-to Contact")
        {
            Editable = false;
        }
        modify("Ship-to Code")
        {
            Editable = false;
        }
        modify("Ship-to Contact")
        {
            Editable = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Ship-to Name")
        {
            Editable = false;
        }
        modify("Ship-to Post Code")
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Salesperson Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify("No. Printed")
        {
            Editable = false;
        }
        modify("Document Date")
        {
            Editable = false;
        }
        modify("Requested Delivery Date")
        {
            Editable = false;
        }
        modify("Shipment Method Code")
        {
            Editable = false;
        }
        modify("Shipping Agent Code")
        {
            Editable = false;
        }
        modify("Shipment Date")
        {
            Editable = false;
        }


    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        postedSales.onInitEvent();
    end;

    var
        postedSales: Codeunit "Posted Sales Shippment";

}
