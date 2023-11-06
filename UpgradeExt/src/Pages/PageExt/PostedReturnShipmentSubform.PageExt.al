pageextension 50166 "Posted Return Shipment Subform" extends "Posted Return Shipment Subform"
{
    // layout
    // {
    //     modify("Direct Unit Cost")
    //     {
    //         CaptionML = ENU = 'Direct Unit Cost';
    //     }
    // }

    var
        PostedShipment: Codeunit "Posted Return Shipment Subform";

    trigger OnAfterGetRecord()

    begin
        PostedShipment.CheckResin(Rec);
    end;

}
