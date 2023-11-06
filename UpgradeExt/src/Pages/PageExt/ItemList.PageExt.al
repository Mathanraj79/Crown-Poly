pageextension 50108 "Item List" extends "Item List"
{

    layout
    {

        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        addafter("Stockkeeping Unit Exists")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
        }
        modify("Unit Cost")
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
        }
        addafter("Replenishment System")
        {
            // field()
        }

        addafter(PowerBIEmbeddedReportPart)
        {
            // part()
            // {
            //      SubPageLink=No.=FIELD(No.),
            //                 Date Filter=FIELD(Date Filter),
            //                 Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
            //                 Global Dimension 2 Filter=FIELD(Global Dimension 1 Filter),
            //                 Location Filter=FIELD(Location Filter),
            //                 Drop Shipment Filter=FIELD(Drop Shipment Filter),
            //                 Bin Filter=FIELD(Bin Filter),
            //                 Variant Filter=FIELD(Variant Filter),
            //                 Lot No. Filter=FIELD(Lot No. Filter),
            //                 Serial No. Filter=FIELD(Serial No. Filter);
            //     PagePartID=Page50050;
            // }

        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Blocked, '%1', false);
    end;

}
