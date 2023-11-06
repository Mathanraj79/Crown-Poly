tableextension 50056 TransferLineEx extends "Transfer Line"
{
    procedure OpenItemTrackingLinesWithReclass1(Direction: Enum "Transfer Direction")
    begin
        TestField("Item No.");
        TestField("Quantity (Base)");

        TransferLineReserve.CallItemTracking1(Rec, Direction, true);
    end;

    var
        TransferLineReserve: Codeunit EventSubscriber;


}
