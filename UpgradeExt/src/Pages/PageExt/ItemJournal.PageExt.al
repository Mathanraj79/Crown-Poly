pageextension 50110 "Item Journal" extends "Item Journal"
{
    layout
    {
        modify("Unit Amount")
        {
            Caption = 'Resin Unit Amount';
            Editable = ResinEditable;
        }
        modify(Amount)
        {
            Caption = 'Resin Amount';
            Editable = ResinEditable;
        }
        modify("Unit Cost")
        {
            Caption = 'Resin Unit Cost';
            Editable = ResinEditable;
        }

    }
    var
        ResinEditable: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CheckResin();
    end;

    PROCEDURE CheckResin();
    VAR
        UserSetup: Record 91;
        Item: Record 27;
    BEGIN
        //SCSML new function for Resin items
        IF UserSetup.GET(USERID) THEN BEGIN
            // IF NOT UserSetup.Resin THEN BEGIN
            //     IF Item.GET("Item No.") THEN BEGIN
            //         IF Item.Resin THEN BEGIN
            //             "Resin Unit Cost" := 0;
            //             "Resin Unit Amount" := 0;
            //             "Resin Amount" := 0;
            ResinEditable := FALSE;
        END
        ELSE BEGIN
            // IF "Resin Unit Cost" <> "Unit Cost" THEN
            //     "Resin Unit Cost" := "Unit Cost";
            // IF "Resin Unit Amount" <> "Unit Amount" THEN
            //     "Resin Unit Amount" := "Unit Amount";
            // IF "Resin Amount" <> Amount THEN
            //     "Resin Amount" := Amount;
            ResinEditable := TRUE;
        END;
    END;
    //  END
    // ELSE BEGIN
    //     IF "Resin Unit Cost" <> "Unit Cost" THEN
    //         "Resin Unit Cost" := "Unit Cost";
    //     IF "Resin Unit Amount" <> "Unit Amount" THEN
    //         "Resin Unit Amount" := "Unit Amount";
    //     IF "Resin Amount" <> Amount THEN
    //         "Resin Amount" := Amount;
    //     ResinEditable := TRUE;
    // END;
    //END;
    //END;
}
