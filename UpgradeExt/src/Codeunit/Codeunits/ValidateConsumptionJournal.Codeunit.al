codeunit 50005 "Validate Consumption Journal"
{
    SingleInstance = true;

    trigger OnRun()
    var
    // OutputJournal: Record "Item Journal Line";
    begin
        SELECTLATESTVERSION();
        ValidateRecord();
    end;

    var
    //ItemJnlPostBatch: Codeunit "Item Jnl.-Post Line";


    procedure ValidateRecord()
    var
        lConsumptionJournal: Record "Item Journal Line";
        ConsumptionJournal: Record "Consumption Journal";
        ManufSetup: Record "Manufacturing Setup";
        i: Integer;
    begin
        ManufSetup.GET();
        ManufSetup.TESTFIELD("No. of Records to Process");
        i := 0;

        CLEAR(ConsumptionJournal);
        ConsumptionJournal.RESET();
        ConsumptionJournal.SETRANGE(Completed, TRUE);
        ConsumptionJournal.SETRANGE(Validated, FALSE);
        IF ConsumptionJournal.FINDFIRST() THEN
            REPEAT
                //IF ConsumptionJournal.Completed THEN BEGIN
                //ConsumptionJournal.Validated := TRUE;
                //ConsumptionJournal.MODIFY;
                lConsumptionJournal.RESET();
                lConsumptionJournal.INIT();
                lConsumptionJournal."Journal Template Name" := ConsumptionJournal."Journal Template Name";
                lConsumptionJournal."Journal Batch Name" := ConsumptionJournal."Journal Batch Name";
                lConsumptionJournal."Line No." := ConsumptionJournal."Line No.";
                lConsumptionJournal.VALIDATE("Entry Type", lConsumptionJournal."Entry Type"::Consumption);
                lConsumptionJournal.VALIDATE("Posting Date", ConsumptionJournal."Posting Date");
                lConsumptionJournal.VALIDATE("Order No.", ConsumptionJournal."Production Order No.");
                lConsumptionJournal.VALIDATE("Document No.", ConsumptionJournal."Document No.");
                lConsumptionJournal.VALIDATE("Machine Center Code", ConsumptionJournal."Machine Center Code");
                lConsumptionJournal.VALIDATE("Item No.", ConsumptionJournal."Item No.");
                lConsumptionJournal.VALIDATE("Location Code", ConsumptionJournal."Location Code");
                lConsumptionJournal.VALIDATE(Quantity, ConsumptionJournal.Quantity);
                lConsumptionJournal.VALIDATE(Shift, ConsumptionJournal.Shift);
                lConsumptionJournal.INSERT();

                IF ConsumptionJournal."Lot No." <> '' THEN
                    CreateReservEntry(lConsumptionJournal, ConsumptionJournal."Lot No.");
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", lConsumptionJournal);
                ConsumptionJournal.DELETE();
                //END;
                i += 1;
            UNTIL (i = ManufSetup."No. of Records to Process") OR (ConsumptionJournal.NEXT() = 0);
    end;


    procedure CreateReservEntry(ConsumptionJournalRec: Record "Item Journal Line"; LotNo: Code[20])
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
        ReservEntry.Positive := FALSE;
        ReservEntry."Item No." := ConsumptionJournalRec."Item No.";
        ReservEntry."Location Code" := ConsumptionJournalRec."Location Code";
        ReservEntry.VALIDATE(ReservEntry."Quantity (Base)", -ConsumptionJournalRec.Quantity);
        ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
        ReservEntry."Creation Date" := WORKDATE();
        ReservEntry."Transferred from Entry No." := 0;
        ReservEntry."Source Type" := 83;
        ReservEntry."Source Subtype" := 5;
        ReservEntry."Source ID" := ConsumptionJournalRec."Journal Template Name";
        ReservEntry."Source Batch Name" := ConsumptionJournalRec."Journal Batch Name";
        ReservEntry."Source Prod. Order Line" := 0;
        ReservEntry."Source Ref. No." := ConsumptionJournalRec."Line No.";
        ReservEntry."Expected Receipt Date" := WORKDATE();
        ReservEntry."Created By" := USERID();
        ReservEntry."Qty. per Unit of Measure" := ConsumptionJournalRec."Qty. per Unit of Measure";
        ReservEntry."Planning Flexibility" := ReservEntry."Planning Flexibility"::Unlimited;
        ReservEntry."Lot No." := LotNo;
        ReservEntry.INSERT();
    end;
}

