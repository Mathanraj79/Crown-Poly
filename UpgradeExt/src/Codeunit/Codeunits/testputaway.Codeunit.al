codeunit 50050 "test put away"
{

    trigger OnRun()
    begin
        PostedWhseRcptLine.SETRANGE("No.", 'R_000006');
        IF NOT PostedWhseRcptLine.FIND('-') THEN
            EXIT;

        IF PostedWhseRcptLine.FIND('-') THEN
            REPEAT
                CreatePutAway.SetCrossDockValues(TRUE);
                ItemTrackingMgt.SplitPostedWhseRcptLine(PostedWhseRcptLine, TempPostedWhseRcptLine);
                IF TempPostedWhseRcptLine.FIND('-') THEN
                    REPEAT
                        TempPostedWhseRcptLine2 := TempPostedWhseRcptLine;
                        TempPostedWhseRcptLine2."Line No." := PostedWhseRcptLine."Line No.";
                        CreatePutAway.RUN(TempPostedWhseRcptLine2);
                    UNTIL TempPostedWhseRcptLine.NEXT() = 0;
            UNTIL PostedWhseRcptLine.NEXT() = 0;
    end;

    var
        //WhseActivHeader: Record "Warehouse Activity Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        TempPostedWhseRcptLine: Record "Posted Whse. Receipt Line" temporary;
        TempPostedWhseRcptLine2: Record "Posted Whse. Receipt Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        CreatePutAway: Codeunit "Create Put-away";
}

