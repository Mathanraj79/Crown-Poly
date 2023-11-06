codeunit 50002 "Validate Output Journal"
{
    SingleInstance = true;

    trigger OnRun()
    begin
        SELECTLATESTVERSION();
        ValidateRecord();
    end;

    var
        OutputJournal: Record "Output Journal";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Line";


    procedure ValidateRecord()
    var
        lOutputJournal: Record "Item Journal Line";
        ManufSetup: Record "Manufacturing Setup";
        lOutputJournal2: Record "Item Journal Line";
        i: Integer;
    begin
        ManufSetup.GET();
        ManufSetup.TESTFIELD("No. of Records to Process");
        i := 0;
        IF OutputJournal.FINDFIRST() THEN;

        lOutputJournal2.RESET();
        lOutputJournal2.SETRANGE("Journal Template Name", OutputJournal."Journal Template Name");
        lOutputJournal2.SETRANGE("Journal Batch Name", OutputJournal."Journal Batch Name");
        IF lOutputJournal2.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", lOutputJournal2);

        CLEAR(OutputJournal);
        OutputJournal.RESET();
        OutputJournal.SETRANGE(Validated, FALSE);
        OutputJournal.SETRANGE(Completed, TRUE);
        IF OutputJournal.FINDFIRST() THEN BEGIN
            REPEAT
                //IF OutputJournal.Completed THEN BEGIN
                //OutputJournal.Validated := TRUE;
                //OutputJournal.MODIFY;

                lOutputJournal.RESET();
                lOutputJournal.INIT();
                lOutputJournal."Journal Template Name" := OutputJournal."Journal Template Name";
                lOutputJournal."Journal Batch Name" := OutputJournal."Journal Batch Name";
                lOutputJournal."Line No." := OutputJournal."Line No.";
                lOutputJournal.VALIDATE("Entry Type", lOutputJournal."Entry Type"::Output);
                lOutputJournal.VALIDATE("Posting Date", OutputJournal."Posting Date");
                lOutputJournal.VALIDATE("Order No.", OutputJournal."Prod. Order No.");
                lOutputJournal.VALIDATE("Document No.", OutputJournal."Document No.");
                lOutputJournal.VALIDATE("Item No.", OutputJournal."Item No.");
                lOutputJournal.VALIDATE("Operation No.", OutputJournal."Operation No.");
                lOutputJournal.VALIDATE(Type, OutputJournal.Type);
                lOutputJournal.VALIDATE("No.", OutputJournal."No.");
                IF OutputJournal.Type = 1 THEN
                    lOutputJournal.VALIDATE("Machine Center Code", OutputJournal."No.");
                lOutputJournal.VALIDATE(Shift, OutputJournal.Shift);
                lOutputJournal.VALIDATE("Output Quantity", OutputJournal."Output Quantity");
                lOutputJournal.INSERT();
                IF OutputJournal."Lot No." <> '' THEN
                    CreateReservEntry(lOutputJournal, OutputJournal."Lot No.");

                OutputJournal.DELETE();
                //END;
                i += 1;
            UNTIL (i = ManufSetup."No. of Records to Process") OR (OutputJournal.NEXT() = 0);

            lOutputJournal2.RESET();
            lOutputJournal2.SETRANGE("Journal Template Name", lOutputJournal."Journal Template Name");
            lOutputJournal2.SETRANGE("Journal Batch Name", lOutputJournal."Journal Batch Name");
            IF lOutputJournal2.FINDFIRST() THEN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", lOutputJournal2);
        END;
    end;


    procedure CreateReservEntry(OurtputJournalRec: Record "Item Journal Line"; LotNo: Code[20])
    var
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        LineNo: Integer;
    begin
        IF ReservEntry2.FINDLAST() THEN
            LineNo := ReservEntry2."Entry No." + 10
        ELSE
            LineNo := 10;

        ReservEntry.RESET();
        ReservEntry.INIT();
        ReservEntry."Entry No." := LineNo;
        ReservEntry.Positive := TRUE;
        ReservEntry."Item No." := OurtputJournalRec."Item No.";
        ReservEntry."Location Code" := OurtputJournalRec."Location Code";
        ReservEntry.VALIDATE(ReservEntry."Quantity (Base)", OurtputJournalRec.Quantity);
        ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
        ReservEntry."Creation Date" := WORKDATE();
        ReservEntry."Transferred from Entry No." := 0;
        ReservEntry."Source Type" := 83;
        ReservEntry."Source Subtype" := 6;
        ReservEntry."Source ID" := OurtputJournalRec."Journal Template Name";
        ReservEntry."Source Batch Name" := OurtputJournalRec."Journal Batch Name";
        ReservEntry."Source Prod. Order Line" := 0;
        ReservEntry."Source Ref. No." := OurtputJournalRec."Line No.";
        ReservEntry."Expected Receipt Date" := WORKDATE();
        ReservEntry."Created By" := USERID();
        ReservEntry."Qty. per Unit of Measure" := OurtputJournalRec."Qty. per Unit of Measure";
        ReservEntry."Planning Flexibility" := ReservEntry."Planning Flexibility"::Unlimited;
        ReservEntry."Lot No." := LotNo;
        ReservEntry.INSERT();
    end;
}

