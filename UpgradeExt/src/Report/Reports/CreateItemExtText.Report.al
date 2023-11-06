report 50016 "Create Item Ext. Text"
{
    Caption = 'Create Item Ext. Text';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                IF GUIALLOWED THEN
                    Window.UPDATE(1, "No.");

                CLEAR(ExtendTextHeader);
                CLEAR(ExtendTextLine);
                TextNo := 0;
                LineNo := 0;
                LineNo += 1000;
                Text := '';
                Text2 := '';

                //Insert Header
                ExtendTextHeader2.RESET();
                ExtendTextHeader2.SETRANGE("Table Name", ExtendTextHeader2."Table Name"::Item);
                ExtendTextHeader2.SETRANGE("No.", "No.");
                IF NOT ExtendTextHeader2.FINDLAST() THEN BEGIN
                    ExtendTextHeader."Table Name" := ExtendTextHeader."Table Name"::Item;
                    ExtendTextHeader."No." := "No.";
                    ExtendTextHeader."Text No." := 1;
                    ExtendTextHeader.INSERT();
                    TextNo := 1;
                END ELSE BEGIN
                    ExtendTextHeader."Table Name" := ExtendTextHeader."Table Name"::Item;
                    ExtendTextHeader."No." := "No.";
                    ExtendTextHeader."Text No." := ExtendTextHeader2."Text No." + 1;
                    ExtendTextHeader.INSERT();
                    TextNo := ExtendTextHeader2."Text No." + 1;
                END;

                //Insert Lines
                ExtendTextLine."Table Name" := ExtendTextLine."Table Name"::Item;
                ExtendTextLine."No." := "No.";
                ExtendTextLine."Text No." := TextNo;
                ExtendTextLine."Line No." := LineNo;
                //Create Text
                Text := '';

                //IF Print <> '' THEN
                //  Text := Print;

                IF "Ink Color No. 1" <> '' THEN
                    Text := "Ink Color No. 1";

                IF "Ink Color No. 2" <> '' THEN
                    Text += '-' + "Ink Color No. 2";

                IF "Ink Color No. 3" <> '' THEN
                    Text += '-' + "Ink Color No. 3";

                CheckandInsert(ExtendTextLine, Text);
                IF "Bag Dimensions" <> '' THEN
                    Text += '-' + "Bag Dimensions";


                CheckandInsert(ExtendTextLine, Text);
                IF "Film Gauge" <> 0 THEN
                    Text += '-' + FORMAT("Film Gauge");

                CheckandInsert(ExtendTextLine, Text);
                IF "Film Titan" <> '' THEN
                    Text += '-' + FORMAT("Film Titan");

                CheckandInsert(ExtendTextLine, Text);
                IF "Film Type" <> '' THEN
                    Text += '-' + "Film Type";

                CheckandInsert(ExtendTextLine, Text);
                IF "Bags per Roll/Bundle" <> 0 THEN
                    Text += '-' + FORMAT("Bags per Roll/Bundle");

                CheckandInsert(ExtendTextLine, Text);
                IF "Rolls/Bundles per Case" <> 0 THEN
                    Text += '-' + FORMAT("Rolls/Bundles per Case");

                /*CheckandInsert(ExtendTextLine, Text);
                IF "Rolls/Bundles per Case" <> 0 THEN
                  Text += '-' + FORMAT("Rolls/Bundles per Case");   */

                CheckandInsert(ExtendTextLine, Text);
                IF "Film Color" <> '' THEN
                    Text += '-' + "Film Color";

                CheckandInsert(ExtendTextLine, Text);
                IF Glue THEN
                    Text += '-' + 'Glue'
                ELSE
                    Text += '-' + 'No Glue';

                CheckandInsert(ExtendTextLine, Text);
                IF "UPC Code" <> '' THEN
                    Text += '-' + "UPC Code";

                CheckandInsert(ExtendTextLine, Text);

                /*
                i := 1;
                IF STRLEN(Text) > 50 THEN BEGIN
                  REPEAT
                    Text2 := COPYSTR(Text, 1, 50);
                    CharCount := 0;
                    IF STRPOS(Text2, ' ') > 0 THEN BEGIN
                      REPEAT
                        CharCount += STRPOS(Text2, ' ');
                        Text2 := COPYSTR(Text2, STRPOS(Text2, ' ') + 1, (50 - CharCount));
                      UNTIL STRPOS(Text2, ' ') = 0;
                      Text2 := COPYSTR(Text, 1, CharCount);
                      Text := COPYSTR(Text, CharCount + 1, STRLEN(Text));
                      ExtendTextLine.Text := Text2;
                      ExtendTextLine.INSERT(TRUE);
                      LineNo += 1000;
                      Text2 := COPYSTR(Text, 1, 50);
                    END;
                  UNTIL STRLEN(Text) <= 50;
                  ExtendTextLine.INSERT(TRUE);
                END ELSE BEGIN   */

                IF (Text <> '') THEN BEGIN
                    IF STRPOS(Text, '-') = 1 THEN
                        Text := COPYSTR(Text, 2, 240);
                    ExtendTextLine.Text := Text;
                    ExtendTextLine.INSERT(TRUE);
                END;

            end;

            trigger OnPreDataItem()
            begin
                TextNo := 0;
                LineNo := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN
            Window.CLOSE();
    end;

    trigger OnPreReport()
    begin
        IF GUIALLOWED THEN
            Window.OPEN(Text001Lbl);
    end;

    var
        ExtendTextHeader: Record "Extended Text Header";
        ExtendTextLine: Record "Extended Text Line";
        ExtendTextHeader2: Record "Extended Text Header";
        LineNo: Integer;
        Text: Text[250];
        Window: Dialog;
        Text001Lbl: Label 'Processing...\ Item No. #1##########', Comment = '%1 Item No.';
        TextNo: Integer;
        Text2: Text[50];


    procedure CheckandInsert(var ExtendedTextLine: Record "Extended Text Line"; var LocalText: Text[250])
    begin
        IF STRLEN(LocalText) > 31 THEN BEGIN
            IF STRPOS(LocalText, '-') = 1 THEN
                LocalText := COPYSTR(Text, 2, 240);

            ExtendTextLine.Text := LocalText;
            ExtendTextLine.INSERT(TRUE);
            LineNo += 1000;
            ExtendedTextLine."Line No." := LineNo;
            LocalText := '';
        END;
    end;
}

