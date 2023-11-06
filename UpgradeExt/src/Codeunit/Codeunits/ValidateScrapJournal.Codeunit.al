codeunit 50004 "Validate Scrap Journal"
{
    // ------------------------------------------------------------------------------------------
    // --------------------------------IWEB ETC.-------------------------------------------------
    // ------------------------------------------------------------------------------------------
    // CODE    DATE      DEV         COMMENT
    // ------------------------------------------------------------------------------------------
    // 001     02.10.17  IWEB.DJ     410 - Post Scrap Entry along with its BOm consumption in single call

    SingleInstance = true;

    trigger OnRun()
    begin
        SELECTLATESTVERSION();
        ValidateRecord();
    end;

    var
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Line";

    procedure ValidateRecord()
    var
        lScrapJournal: Record "Item Journal Line";
        Item: Record Item;
        ScrapJournal: Record "Item Journal";
        GLSetup: Record "General Ledger Setup";
        ManufSetup: Record "Manufacturing Setup";
        DefaultDim: Record "Default Dimension";
        ScrapBOM: Record "Production BOM Header";
        ScrapBOMLines: Record "Production BOM Line";
        lScrapJournal2: Record "Item Journal Line";
        lScrapJournal3: Record "Item Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        i: Integer;
        DocNo: Code[20];
        LineNo: Integer;
    begin
        ManufSetup.GET();
        ManufSetup.TESTFIELD("No. of Records to Process");
        i := 0;
        IF ScrapJournal.FINDFIRST() THEN;


        lScrapJournal3.RESET();
        lScrapJournal3.SETRANGE("Journal Template Name", ScrapJournal."Journal Template Name");
        lScrapJournal3.SETRANGE("Journal Batch Name", ScrapJournal."Journal Batch Name");
        IF lScrapJournal3.FINDFIRST() THEN
            //001 START
            //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",lScrapJournal3);
            //Instead of posting delete the entries which are available in the "ITEM JOURNAL LINE"
            lScrapJournal3.DELETEALL();
        //001 END

        CLEAR(ScrapJournal);
        ScrapJournal.RESET();
        ScrapJournal.SETRANGE(Validated, FALSE);
        ScrapJournal.SETRANGE(Completed, TRUE);
        IF ScrapJournal.FINDFIRST() THEN
            REPEAT
                //IF ScrapJournal.Completed THEN BEGIN
                //ScrapJournal.Validated := TRUE;
                //ScrapJournal.MODIFY;

                lScrapJournal.RESET();
                lScrapJournal.INIT();
                lScrapJournal."Journal Template Name" := ScrapJournal."Journal Template Name";
                lScrapJournal."Journal Batch Name" := ScrapJournal."Journal Batch Name";
                lScrapJournal."Line No." := ScrapJournal."Line No.";
                lScrapJournal.VALIDATE("Posting Date", ScrapJournal."Posting Date");
                lScrapJournal.VALIDATE("Entry Type", ScrapJournal."Entry Type");
                DocNo := NoSeriesMgt.GetNextNo('IJNL-GEN', TODAY, TRUE);
                lScrapJournal.VALIDATE("Document No.", DocNo);
                lScrapJournal.VALIDATE("Item No.", ScrapJournal."Item No.");
                lScrapJournal.VALIDATE("Location Code", ScrapJournal."Location Code");
                lScrapJournal.VALIDATE(Quantity, ScrapJournal.Quantity);
                Item.GET(ScrapJournal."Item No.");
                lScrapJournal.VALIDATE("Unit Amount", Item."Standard Cost");
                lScrapJournal.VALIDATE(Amount, Item."Standard Cost" * ScrapJournal.Quantity);
                lScrapJournal.VALIDATE("Unit Cost", Item."Standard Cost");
                lScrapJournal.VALIDATE("Machine Center Code", ScrapJournal."Machine Center Code");
                lScrapJournal.VALIDATE(Shift, ScrapJournal.Shift);
                GLSetup.GET();
                lScrapJournal.INSERT();
                IF ScrapJournal."Lot No." <> '' THEN
                    CreateReservEntry(lScrapJournal, ScrapJournal."Lot No.");
                //001 START
                //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",lScrapJournal);
                //001 END

                IF NOT Item."Do not Allow Two Sided Entry" THEN
                    IF ScrapBOM.GET(Item."Production BOM No.") THEN BEGIN
                        ScrapBOMLines.RESET();
                        ScrapBOMLines.SETRANGE("Production BOM No.", ScrapBOM."No.");
                        ScrapBOMLines.SETRANGE(Type, ScrapBOMLines.Type::Item);
                        IF ScrapBOMLines.FINDFIRST() THEN BEGIN
                            lScrapJournal3.RESET();
                            lScrapJournal3.SETRANGE("Journal Template Name", ScrapJournal."Journal Template Name");
                            lScrapJournal3.SETRANGE("Journal Batch Name", ScrapJournal."Journal Batch Name");
                            IF lScrapJournal3.FINDLAST() THEN
                                LineNo := lScrapJournal3."Line No." + 10000
                            ELSE
                                LineNo := 10000;
                            REPEAT
                                //001 START
                                // Replaced lScrapJournal2 with lScrapJournal
                                lScrapJournal.RESET();
                                lScrapJournal.INIT();
                                lScrapJournal."Journal Template Name" := ScrapJournal."Journal Template Name";
                                lScrapJournal."Journal Batch Name" := ScrapJournal."Journal Batch Name";
                                lScrapJournal."Line No." := LineNo;
                                lScrapJournal.VALIDATE("Posting Date", ScrapJournal."Posting Date");
                                lScrapJournal.VALIDATE("Entry Type", lScrapJournal2."Entry Type"::"Negative Adjmt.");
                                lScrapJournal.VALIDATE("Document No.", DocNo);
                                lScrapJournal.VALIDATE("Item No.", ScrapBOMLines."No.");
                                lScrapJournal.VALIDATE("Location Code", ScrapJournal."Location Code");
                                lScrapJournal.VALIDATE(Quantity, ScrapJournal.Quantity * ScrapBOMLines.Quantity);
                                Item.GET(ScrapBOMLines."No.");
                                lScrapJournal.VALIDATE("Unit Amount", Item."Unit Cost");
                                lScrapJournal.VALIDATE(Amount, Item."Standard Cost" * ScrapJournal.Quantity);
                                lScrapJournal.VALIDATE("Unit Cost", Item."Standard Cost");
                                lScrapJournal.VALIDATE("Machine Center Code", ScrapJournal."Machine Center Code");
                                lScrapJournal.VALIDATE(Shift, ScrapJournal.Shift);
                                IF lScrapJournal.Quantity > 0 THEN
                                    lScrapJournal.INSERT();
                                LineNo += 10000;
                            UNTIL ScrapBOMLines.NEXT() = 0;
                            //001 END
                        END;
                    END;

                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", lScrapJournal);
                ScrapJournal.DELETE();
                COMMIT();
                //END;
                i += 1;
            UNTIL (i = ManufSetup."No. of Records to Process") OR (ScrapJournal.NEXT() = 0)
    end;

    procedure CreateReservEntry(ScrapJournalRec: Record "Item Journal Line"; LotNo: Code[20])
    var
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        LineNo: Integer;
    begin
        IF ReservEntry2.FINDLAST() THEN
            LineNo := ReservEntry2."Entry No." + 10000
        ELSE
            LineNo := 10000;
        ReservEntry.RESET();
        ReservEntry.INIT();
        ReservEntry."Entry No." := LineNo;
        ReservEntry."Item No." := ScrapJournalRec."Item No.";
        ReservEntry."Location Code" := ScrapJournalRec."Location Code";
        ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
        ReservEntry."Creation Date" := WORKDATE();
        ReservEntry."Transferred from Entry No." := 0;
        ReservEntry."Source Type" := 83;
        ReservEntry."Source ID" := ScrapJournalRec."Journal Template Name";
        ReservEntry."Source Batch Name" := ScrapJournalRec."Journal Batch Name";
        ReservEntry."Source Prod. Order Line" := 0;
        ReservEntry."Source Ref. No." := ScrapJournalRec."Line No.";
        ReservEntry."Qty. per Unit of Measure" := ScrapJournalRec."Qty. per Unit of Measure";
        IF ScrapJournalRec."Entry Type" = ScrapJournalRec."Entry Type"::"Negative Adjmt." THEN BEGIN
            ReservEntry.Positive := FALSE;
            ReservEntry.VALIDATE(ReservEntry."Quantity (Base)", -ScrapJournalRec.Quantity);
            ReservEntry."Source Subtype" := 3;
        END
        ELSE
            IF ScrapJournalRec."Entry Type" = ScrapJournalRec."Entry Type"::"Positive Adjmt." THEN BEGIN
                ReservEntry.Positive := TRUE;
                ReservEntry.VALIDATE(ReservEntry."Quantity (Base)", ScrapJournalRec.Quantity);
                ReservEntry."Source Subtype" := 3;
            END;
        ReservEntry."Expected Receipt Date" := WORKDATE();
        ReservEntry."Created By" := USERID();
        ReservEntry."Planning Flexibility" := ReservEntry."Planning Flexibility"::Unlimited;
        ReservEntry."Lot No." := LotNo;
        ReservEntry.INSERT();
    end;
}

