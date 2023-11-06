pageextension 50109 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        modify("Cost Amount (Actual)")
        {
            HideValue = ResinEnable;
        }
        modify("Cost Amount (Expected)")
        {
            HideValue = ResinEnable;
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            HideValue = true;
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            Enabled = true;
            HideValue = true;
        }
        modify("Cost Amount (Expected) (ACY)")
        {
            HideValue = true;
        }
        modify("Cost Amount (Non-Invtbl.)(ACY)")
        {
            Enabled = true;
            HideValue = true;
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetResinVisible();
    end;

    var
        ResinEnable: Boolean;

    PROCEDURE SetResinVisible();
    VAR
        UserSetup: Record 91;
        Item: Record 27;
    BEGIN
        //SCSML New function to Enable/Disable Costing fields if Item is resin
        IF UserSetup.GET(USERID) THEN BEGIN
            // IF NOT UserSetup.Resin THEN BEGIN
            //   IF Item.GET("Item No.") THEN;
            // IF Item.Resin THEN BEGIN
            ResinEnable := TRUE;
        END
        ELSE BEGIN
            ResinEnable := FALSE;
        END;
    END;
    // ELSE BEGIN
    //     ResinEnable := FALSE;
    // END;
    //END;
    //END;
}
