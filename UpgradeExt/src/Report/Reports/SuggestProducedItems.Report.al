report 50040 "Suggest Produced Items"
{
    // SSC56 - new object

    Caption = 'Suggest Produced Items To Transfer';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Location Code" = FIELD("Transfer-from Code");
                DataItemTableView = SORTING("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date")
                                    WHERE("Entry Type" = CONST(Output),
                                          "Remaining Quantity" = FILTER(> 0),
                                          "Open" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    Item.GET("Item No.");
                    IF Item."Type of Item" <> TypeOfItem THEN
                        CurrReport.SKIP();

                    IF GUIALLOWED THEN
                        Window.UPDATE(1, "Item No.");

                    TransferLine.RESET();
                    TransferLine.SETRANGE("Document No.", "Transfer Header"."No.");
                    TransferLine.SETRANGE("Item No.", "Item No.");
                    IF NOT TransferLine.FINDLAST() THEN BEGIN
                        TransferLine2.INIT();
                        TransferLine2.VALIDATE("Document No.", "Transfer Header"."No.");
                        TransferLine2.VALIDATE("Line No.", NextLineNo);
                        NextLineNo := NextLineNo + 10000;
                        TransferLine2.VALIDATE("Item No.", "Item No.");
                        TransferLine2.INSERT(TRUE);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", PostingDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TransferLine.RESET();
                TransferLine.SETRANGE("Document No.", "No.");
                IF TransferLine.FINDLAST() THEN
                    NextLineNo := TransferLine."Line No." + 10000
                ELSE
                    NextLineNo := 10000;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Posting Date"; PostingDate)
                {
                    ToolTip = 'Specifies the value of the PostingDate field.';
                    caption = 'Posting Date';
                    ApplicationArea = all;
                }
                field("Type Of Item"; TypeOfItem)
                {
                    OptionCaption = ' ,Domestic,Export';
                    ToolTip = 'Specifies the value of the TypeOfItem field.';
                    caption = 'Type Of Item';
                    ApplicationArea = all;
                }
            }
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
        IF PostingDate = 0D THEN
            PostingDate := WORKDATE();

        IF GUIALLOWED THEN
            Window.OPEN(Text001Lbl);
    end;

    var
        Item: Record Item;
        TransferLine: Record "Transfer Line";
        TransferLine2: Record "Transfer Line";
        NextLineNo: Integer;
        PostingDate: Date;
        TypeOfItem: Option " ",Domestic,Export;
        Window: Dialog;
        Text001Lbl: Label 'Processing Item No. #1##########', comment = '%1';

    procedure SetPostingDate(UseDate: Date)
    begin
        PostingDate := UseDate;
    end;

    procedure SetTypeOfItem(TypeItem: Option)
    begin
        TypeOfItem := TypeItem;
    end;
}

