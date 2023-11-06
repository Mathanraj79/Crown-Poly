tableextension 50036 ReservationEntryEx extends "Reservation Entry"
{
    trigger OnAfterDelete()
    var
        ItemTrackingLineBin: Record "Item Tracking Line Bin";
    begin
        //>>SSC56
        ItemTrackingLineBin.SETRANGE("Entry Type", ItemTrackingLineBin."Entry Type"::"Reservation Entry");
        ItemTrackingLineBin.SETRANGE("Entry No.", "Entry No.");
        ItemTrackingLineBin.DELETEALL();
        //<<SSC56
    end;
}
