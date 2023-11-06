tableextension 50037 DefaultDimensionEx extends "Default Dimension"
{
    trigger OnAfterInsert()
    begin
        //SCSFN
        IF "Table ID" = 27 THEN BEGIN
            IF "Dimension Code" = 'ITEM CATEGORY' THEN
                IF Item.GET("No.") THEN
                    Item."Shortcut Dimension 3" := "Dimension Value Code";
            Item.MODIFY();
        END;
        //SCSFN
    end;

    trigger OnAfterModify()
    begin
        //SCSFN
        IF "Table ID" = 27 THEN BEGIN
            IF "Dimension Code" = 'ITEM CATEGORY' THEN
                IF Item.GET("No.") THEN
                    Item."Shortcut Dimension 3" := "Dimension Value Code";
            Item.MODIFY();
        END;
        //SCSFN
    end;

    trigger OnAfterDelete()
    begin
        //SCSFN
        IF "Table ID" = 27 THEN BEGIN
            IF "Dimension Code" = 'ITEM CATEGORY' THEN
                IF Item.GET("No.") THEN
                    Item."Shortcut Dimension 3" := '';
            Item.MODIFY();
        END;
        //SCSFN
    end;

    var
        Item: Record Item;
}
