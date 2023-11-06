page 50038 "Production Order Rounting"
{
    Caption = 'Production Order Rounting';
    PageType = ListPart;
    SourceTable = "Prod. Order Routing Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
                    ToolTip = 'Specifies the value of the Prod. Order No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = all;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    Caption = 'Starting Time';
                    ToolTip = 'Specifies the value of the Starting Time field.';
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the value of the Ending Date field.';
                    ApplicationArea = all;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    Caption = 'Ending Time';
                    ToolTip = 'Specifies the value of the Ending Time field.';
                    ApplicationArea = all;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    Caption = 'Qty. on Prod. Order';
                    ToolTip = 'Specifies the value of the Qty. on Prod. Order field.';
                    ApplicationArea = all;
                }
                field("Qty. Finished"; Rec."Qty. Finished")
                {
                    Caption = 'Qty. Finished';
                    ToolTip = 'Specifies the value of the Qty. Finished field.';
                    ApplicationArea = all;
                }
                field("Qty. on Output Jnl."; Rec."Qty. on Output Jnl.")
                {
                    Caption = 'Qty. on Output Jnl.';
                    ToolTip = 'Specifies the value of the Qty. on Output Jnl. field.';
                    ApplicationArea = all;
                }
                field(PF; PF)
                {
                    Caption = '% Finished in Navision';
                    Editable = false;
                    ToolTip = 'Specifies the value of the % Finished in Navision field.';
                    ApplicationArea = all;
                }
                field(PO; PO)
                {
                    Caption = '% Finished in MFG. System';
                    Editable = false;
                    ToolTip = 'Specifies the value of the % Finished in MFG. System field.';
                    ApplicationArea = all;
                }
                field(QtyonProdOrder; Rec."Qty. on Prod. Order" - (Rec."Qty. Finished" + Rec."Qty. on Output Jnl."))
                {
                    Caption = 'Qty. Remaining';
                    ToolTip = 'Specifies the value of the -(Qty. Finished + Qty. on Output Jnl.) field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Qty. on Prod. Order", "Qty. Finished");

        IF rec."Qty. on Prod. Order" > 0 THEN BEGIN
            PF := (Rec."Qty. Finished" / Rec."Qty. on Prod. Order") * 100;
            PO := (Rec."Qty. on Output Jnl." / Rec."Qty. on Prod. Order") * 100;
        END ELSE BEGIN
            PF := 0;
            PO := 0;
        END;

        ProdOrderNoOnFormat();
        StartingDateOnFormat();
        StartingTimeOnFormat();
        EndingDateOnFormat();
        EndingTimeOnFormat();
        QtyonProdOrderOnFormat();
        QtyFinishedOnFormat();
        QtyonOutputJnlOnFormat();
    end;

    var
        PF: Decimal;
        PO: Decimal;
        "Prod. Order No.Emphasize": Boolean;
        "Starting DateEmphasize": Boolean;
        "Starting TimeEmphasize": Boolean;
        "Ending DateEmphasize": Boolean;
        "Ending TimeEmphasize": Boolean;
        "Qty. on Prod. OrderEmphasize": Boolean;
        "Qty. FinishedEmphasize": Boolean;
        "Qty. on Output Jnl.Emphasize": Boolean;

    procedure FilterforDate(StartingDate: Date; EndingDate: Date)
    begin
        Rec.SETFILTER("Starting Date", '>=%1', StartingDate);
        Rec.SETFILTER("Ending Date", '<=%1', EndingDate);
    end;

    procedure PostOutput()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF NOT (Rec."Qty. on Output Jnl." >= (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) THEN
            ERROR('You can not post output if Qty. on Output Jnl. is less than the total quantity of the Production Order.')
        ELSE
            ValidateRecord(Rec."Qty. on Output Jnl.");
    end;

    procedure ValidateRecord(QtytoPost: Decimal)
    var
        lOutputJournal: Record "Item Journal Line";
        ManufSetup: Record "Manufacturing Setup";
        i: Integer;
        lOutputJournal2: Record "Item Journal Line";
        OutputJournal: Record "Output Journal";
        LineNo: Integer;
    begin
        OutputJournal.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
        IF OutputJournal.FINDFIRST() THEN BEGIN
            lOutputJournal2.SETRANGE("Journal Template Name", OutputJournal."Journal Template Name");
            lOutputJournal2.SETRANGE("Journal Batch Name", OutputJournal."Journal Batch Name");
            IF lOutputJournal2.FINDFIRST() THEN
                LineNo := lOutputJournal2."Line No.";

            lOutputJournal."Journal Template Name" := OutputJournal."Journal Template Name";
            lOutputJournal."Journal Batch Name" := OutputJournal."Journal Batch Name";
            lOutputJournal."Line No." := LineNo + 10;
            lOutputJournal.VALIDATE("Entry Type", lOutputJournal."Entry Type"::Output);
            lOutputJournal.VALIDATE("Posting Date", OutputJournal."Posting Date");
            lOutputJournal.VALIDATE("Order Type", lOutputJournal."Order Type"::Production);
            lOutputJournal.VALIDATE("Order No.", OutputJournal."Prod. Order No.");
            lOutputJournal.VALIDATE("Document No.", OutputJournal."Document No.");
            lOutputJournal.VALIDATE("Item No.", OutputJournal."Item No.");
            lOutputJournal.VALIDATE("Operation No.", OutputJournal."Operation No.");
            lOutputJournal.VALIDATE(Type, OutputJournal.Type);
            lOutputJournal.VALIDATE("No.", OutputJournal."No.");
            IF OutputJournal.Type = 1 THEN
                lOutputJournal.VALIDATE("Machine Center Code", OutputJournal."No.");
            lOutputJournal.VALIDATE(Shift, OutputJournal.Shift);
            lOutputJournal.VALIDATE("Output Quantity", QtytoPost);
            lOutputJournal.INSERT();

            IF OutputJournal."Lot No." <> '' THEN
                CreateReservEntry(lOutputJournal, OutputJournal."Lot No.");
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", lOutputJournal);
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

        ReservEntry."Entry No." := LineNo;
        ReservEntry.Positive := TRUE;
        ReservEntry."Item No." := OurtputJournalRec."Item No.";
        ReservEntry."Location Code" := OurtputJournalRec."Location Code";
        ReservEntry.VALIDATE("Quantity (Base)", OurtputJournalRec.Quantity);
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

    procedure FinishProdorder()
    var
        NewStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        ProdOrder: Record "Production Order";
        Item2: Record Item;
        ProdbOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        lConsumptionJournal: Record "Item Journal Line";
        ConsumptionJournal: Record "Item Journal Line";
        ProdOrder2: Record "Production Order";
        LineNo: Integer;
    begin
        IF Rec."Qty. Finished" >= Rec."Qty. on Prod. Order" THEN BEGIN
            ProdOrder.GET(Rec.Status, Rec."Prod. Order No.");
            ProdOrderStatusMgt.ChangeProdOrderStatus(ProdOrder, NewStatus::Finished, WORKDATE(), TRUE);
            //ProdOrderStatusMgt.ChangeStatusOnProdOrder(ProdOrder, NewStatus::Finished, WORKDATE, TRUE);
            COMMIT();
        END;
    end;

    local procedure ProdOrderNoOnFormat()
    begin
        IF Rec."Prod. Order No." <> '' THEN BEGIN
            Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
            IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
                "Prod. Order No.Emphasize" := TRUE;
        END;
    end;

    local procedure StartingDateOnFormat()
    begin
        IF Rec."Starting Date" <> 0D THEN BEGIN
            Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
            IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
                "Starting DateEmphasize" := TRUE;
        END;
    end;

    local procedure StartingTimeOnFormat()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
            "Starting TimeEmphasize" := TRUE;
    end;

    local procedure EndingDateOnFormat()
    begin
        IF Rec."Ending Date" <> 0D THEN BEGIN
            Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
            IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
                "Ending DateEmphasize" := TRUE;
        END;
    end;

    local procedure EndingTimeOnFormat()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
            "Ending TimeEmphasize" := TRUE;
    end;

    local procedure QtyonProdOrderOnFormat()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
            "Qty. on Prod. OrderEmphasize" := TRUE;
    end;

    local procedure QtyFinishedOnFormat()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
            "Qty. FinishedEmphasize" := TRUE;
    end;

    local procedure QtyonOutputJnlOnFormat()
    begin
        Rec.CALCFIELDS("Qty. on Output Jnl.", "Qty. on Prod. Order", "Qty. Finished");
        IF (Rec."Qty. on Output Jnl." = (Rec."Qty. on Prod. Order" - Rec."Qty. Finished")) OR (Rec."Qty. on Prod. Order" < Rec."Qty. Finished") THEN
            "Qty. on Output Jnl.Emphasize" := TRUE;

    end;
}

