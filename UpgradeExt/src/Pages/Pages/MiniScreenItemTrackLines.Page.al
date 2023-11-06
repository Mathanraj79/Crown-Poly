page 50037 "Mini Screen - Item Track Lines"
{
    // In order to provide F6 invoked lookup from availability bitmap columns, a menu button has been hidden behind control 1.
    // Function buttons Line and Function both exist in two overlayed versions to make dynamic show/hide/enable of
    // individual menu items possible.
    // 
    // SCS1.00  MSL 04/05/07
    //   - Removed Serial and New Serial No. fields from form
    // 
    // SSC56 - added Storage Bins
    // 
    // -------------------------------------------------------------------------
    // ----------------------------------IWEB ETC.------------------------------
    // -------------------------------------------------------------------------
    // CODE    DATE          DEV         COMMENT
    // -------------------------------------------------------------------------
    // 001     03.11.16      IWEB.DJ     Disable lot duplication confirmation dialog

    Caption = 'Item Tracking Lines';
    DataCaptionFields = "Item No.", "Variant Code", Description;
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "Tracking Specification";
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = "Lot No.Editable";
                    Caption = 'Lot No.';
                    ToolTip = 'Specifies the value of the Lot No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        MaxQuantity: Decimal;
                    begin
                        MaxQuantity := UndefinedQtyArray[1];

                        Rec."Bin Code" := ForBinCode;
                        ItemTrackingDataCollection.AssistEditTrackingNo(Rec,
                          (CurrentSignFactor * SourceQuantityArray[1] < 0) AND NOT
                          InsertIsBlocked, CurrentSignFactor, 1, MaxQuantity);
                        Rec."Bin Code" := '';
                        CurrPage.UPDATE();
                    end;

                    trigger OnValidate()
                    begin
                        LotNoOnAfterValidate();
                    end;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    Editable = "Quantity (Base)Editable";
                    Caption = 'Quantity (Base)';
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        QuantityBaseOnValidate();
                        QuantityBaseOnAfterValidate();
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ButtonLine)
            {
                Caption = '&Line';
                Image = Line;
                Visible = ButtonLineVisible;
                action("Storage Bins")
                {
                    Caption = 'Storage Bins';
                    Image = BinContent;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = StorageBinsVisible;
                    ToolTip = 'Executes the Storage Bins action.';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        StorageBinsPage: Page "Item Tracking Line Bins";
                    begin
                        //>>SSC56
                        StorageBinsPage.SetSource(Rec, TempTrackingSpecificationBin);
                        StorageBinsPage.RUNMODAL();
                        StorageBinsPage.GetStorageBins(TempTrackingSpecificationBin);
                        //<<SSC56
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateExpDateEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        ExpirationDateOnFormat();
        //SCS1.00 START
        IF (Rec."Source ID" = 'OUTPUT') AND (Rec."Source Batch Name" = 'DEFAULT') THEN BEGIN
            ItemRec.GET(Rec."Item No.");
            IF ItemRec."Item Type" = ItemRec."Item Type"::"Strip Rolls" THEN
                MasterLotVisible := FALSE
            ELSE
                MasterLotVisible := FALSE;
        END ELSE
            MasterLotVisible := FALSE;

        //SCS1.00 END
    end;

    trigger OnClosePage()
    begin
        IF UpdateUndefinedQty() THEN
            WriteToDatabase();
        IF FormRunMode = FormRunMode::"Drop Shipment" THEN
            CASE CurrentSourceType OF
                DATABASE::"Sales Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015Lbl, Text016Lbl));
                DATABASE::"Purchase Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015Lbl, Text017Lbl));
            END;
        IF FormRunMode = FormRunMode::Transfer THEN
            SynchronizeLinkedSources('');
    end;

    trigger OnDeleteRecord(): Boolean
    var
        TrackingSpec: Record "Tracking Specification";
        WMSManagement: Codeunit "WMS Management";
        AlreadyDeleted: Boolean;
    begin
        TrackingSpec."Item No." := Rec."Item No.";
        TrackingSpec."Location Code" := Rec."Location Code";
        TrackingSpec."Source Type" := Rec."Source Type";
        TrackingSpec."Source Subtype" := Rec."Source Subtype";
        WMSManagement.CheckItemTrackingChange(TrackingSpec, Rec);

        IF NOT DeleteIsBlocked THEN BEGIN
            AlreadyDeleted := TempItemTrackLineDelete.GET(Rec."Entry No.");
            TempItemTrackLineDelete.TRANSFERFIELDS(Rec);
            Rec.DELETE(TRUE);

            IF NOT AlreadyDeleted THEN
                TempItemTrackLineDelete.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineDelete, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
            IF TempItemTrackLineInsert.GET(Rec."Entry No.") THEN
                TempItemTrackLineInsert.DELETE();
            IF TempItemTrackLineModify.GET(Rec."Entry No.") THEN
                TempItemTrackLineModify.DELETE();
        END;
        CalculateSums();

        EXIT(FALSE);
    end;

    trigger OnInit()
    begin
        "Warranty DateEditable" := TRUE;
        "Expiration DateEditable" := TRUE;
        "New Expiration DateEditable" := TRUE;
        "New Lot No.Editable" := TRUE;
        "New Serial No.Editable" := TRUE;
        DescriptionEditable := TRUE;
        "Lot No.Editable" := TRUE;
        "Serial No.Editable" := TRUE;
        "Quantity (Base)Editable" := TRUE;
        "Qty. to Invoice (Base)Editable" := TRUE;
        "Qty. to Handle (Base)Editable" := TRUE;
        FunctionsDemandVisible := TRUE;
        FunctionsSupplyVisible := TRUE;
        ButtonLineVisible := TRUE;
        "Qty. to Invoice (Base)Visible" := TRUE;
        Invoice3Visible := TRUE;
        Invoice2Visible := TRUE;
        Invoice1Visible := TRUE;
        "Qty. to Handle (Base)Visible" := TRUE;
        Handle3Visible := TRUE;
        Handle2Visible := TRUE;
        Handle1Visible := TRUE;
        "Location CodeEditable" := TRUE;
        "Variant CodeEditable" := TRUE;
        "Item No.Editable" := TRUE;
        InboundIsSet := FALSE;
        ApplFromItemEntryVisible := FALSE;
        ApplToItemEntryVisible := FALSE;

        MasterLotVisible := FALSE;

        //>>SSC56
        StorageBinsVisible := FALSE;
        //<<SSC56
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF Rec."Entry No." <> 0 THEN
            EXIT(FALSE);
        Rec."Entry No." := NextEntryNo();
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists()) THEN
            //IWEB.001
            //IF NOT TestTempSpecificationExists THEN BEGIN
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        TempItemTrackLineInsert.INSERT();
        Rec.INSERT();
        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
        //IWEB.001
        //END;
        CalculateSums();

        EXIT(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    var
        TempTrackingSpec: Record "Tracking Specification" temporary;
    begin
        IF InsertIsBlocked THEN
            IF (xRec."Lot No." <> Rec."Lot No.") OR
               (xRec."Serial No." <> Rec."Serial No.") OR
               (xRec."Quantity (Base)" <> Rec."Quantity (Base)")
            THEN
                EXIT(FALSE);

        IF NOT TestTempSpecificationExists() THEN BEGIN
            Rec.MODIFY();

            IF (xRec."Lot No." <> Rec."Lot No.") OR (xRec."Serial No." <> Rec."Serial No.") THEN BEGIN
                TempTrackingSpec := xRec;
                ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
                  TempTrackingSpec, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
            END;

            IF TempItemTrackLineModify.GET(Rec."Entry No.") THEN
                TempItemTrackLineModify.DELETE();
            IF TempItemTrackLineInsert.GET(Rec."Entry No.") THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                TempItemTrackLineInsert.MODIFY();
                ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
                  TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
            END ELSE BEGIN
                TempItemTrackLineModify.TRANSFERFIELDS(Rec);
                TempItemTrackLineModify.INSERT();
                ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
                  TempItemTrackLineModify, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
            END;
        END;
        CalculateSums();

        EXIT(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Qty. per Unit of Measure" := QtyPerUOM;
    end;

    trigger OnOpenPage()
    begin
        "Item No.Editable" := FALSE;
        "Variant CodeEditable" := FALSE;
        "Location CodeEditable" := FALSE;
        IF InboundIsSet THEN BEGIN
            ApplFromItemEntryVisible := Inbound;
            ApplToItemEntryVisible := NOT Inbound;
        END;

        UpdateUndefinedQty();

        CurrentFormIsOpen := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF NOT UpdateUndefinedQty() THEN
            EXIT(CONFIRM(Text006Lbl));

        IF NOT ItemTrackingDataCollection.RefreshTrackingAvailability(Rec, FALSE) THEN BEGIN
            CurrPage.UPDATE();
            EXIT(CONFIRM(Text019Lbl, TRUE));
        END;
    end;

    var
        xTempItemTrackingLine: Record "Tracking Specification" temporary;
        TotalItemTrackingLine: Record "Tracking Specification";
        TempItemTrackLineInsert: Record "Tracking Specification" temporary;
        TempItemTrackLineModify: Record "Tracking Specification" temporary;
        TempItemTrackLineDelete: Record "Tracking Specification" temporary;
        TempItemTrackLineReserv: Record "Tracking Specification" temporary;
        TempTrackingSpecificationBin: Record "Item Tracking Line Bin" temporary;
        TempTrackingSpecificationBinReserv: Record "Item Tracking Line Bin" temporary;
        TrackingSpecificationBin: Record "Item Tracking Line Bin";
        Item: Record Item;
        ItemRec: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        TempReservEntry: Record "Reservation Entry" temporary;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
        CreateReservEntry: Codeunit "Create Reserv. Entry";

        StorageBinsVisible: Boolean;
        UndefinedQtyArray: array[3] of Decimal;
        SourceQuantityArray: array[5] of Decimal;
        BlockCommit: Boolean;
        IsCorrection: Boolean;
        CurrentFormIsOpen: Boolean;
        CalledFromSynchWhseItemTrkg: Boolean;
        SNAvailabilityActive: Boolean;
        LotAvailabilityActive: Boolean;
        Inbound: Boolean;
        CurrentSourceCaption: Text[255];
        CurrentSourceRowID: Text[250];
        SecondSourceRowID: Text[100];
        QtyPerUOM: Decimal;
        QtyToAddAsBlank: Decimal;
        CurrentSignFactor: Integer;
        LastEntryNo: Integer;
        CurrentSourceType: Integer;
        ExpectedReceiptDate: Date;
        ShipmentDate: Date;
        InsertIsBlocked: Boolean;
        DeleteIsBlocked: Boolean;
        IsPick: Boolean;
        ApplFromItemEntryVisible: Boolean;
        ApplToItemEntryVisible: Boolean;
        "Item No.Editable": Boolean;
        "Variant CodeEditable": Boolean;
        "Location CodeEditable": Boolean;
        Handle1Visible: Boolean;
        Handle2Visible: Boolean;
        Handle3Visible: Boolean;
        "Qty. to Handle (Base)Visible": Boolean;
        Invoice1Visible: Boolean;
        Invoice2Visible: Boolean;
        Invoice3Visible: Boolean;
        "Qty. to Invoice (Base)Visible": Boolean;
        "New Serial No.Visible": Boolean;
        "New Lot No.Visible": Boolean;
        "New Expiration DateVisible": Boolean;
        ButtonLineReclassVisible: Boolean;
        ButtonLineVisible: Boolean;
        FunctionsSupplyVisible: Boolean;
        FunctionsDemandVisible: Boolean;
        InboundIsSet: Boolean;
        "Qty. to Handle (Base)Editable": Boolean;
        "Qty. to Invoice (Base)Editable": Boolean;
        "Quantity (Base)Editable": Boolean;
        "Serial No.Editable": Boolean;
        "Lot No.Editable": Boolean;
        DescriptionEditable: Boolean;
        "New Serial No.Editable": Boolean;
        "New Lot No.Editable": Boolean;
        "New Expiration DateEditable": Boolean;
        "Expiration DateEditable": Boolean;
        "Warranty DateEditable": Boolean;
        ExcludePostedEntries: Boolean;
        MasterLotVisible: Boolean;
        "<SSC56 Var>": Integer;
        ForBinCode: Code[20];
        i: Integer;
        SlitNo: Code[20];
        Text002Lbl: Label 'Quantity must be %1.', Comment = '%1 Quantity';
        Text003Lbl: Label 'negative';
        Text004Lbl: Label 'positive';
        Text005Lbl: Label 'Error when writing to database.';
        Text006Lbl: Label 'The corrections cannot be saved as excess quantity has been defined.\Close the form anyway?';
        Text007Lbl: Label 'Another user has modified the item tracking data since it was retrieved from the database.\Start again.';
        CurrentEntryStatus: Option Reservation,Tracking,Surplus,Prospect;
        FormRunMode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment",Transfer;
        Text008Lbl: Label 'The quantity to create must be an integer.';
        Text009Lbl: Label 'The quantity to create must be positive.';
        Text011Lbl: Label 'Tracking specification with Serial No. %1 and Lot No. %2 already exists.', Comment = '%1 Serial no.,%2 lot No.';
        Text012Lbl: Label 'Tracking specification with Serial No. %1 already exists.', Comment = '%1 Serial No.';
        Text013Lbl: Label 'The string %1 contains no number and cannot be incremented.', Comment = '%1 String';
        Text014Lbl: Label 'The total item tracking quantity %1 exceeds the %2 quantity %3.\The changes cannot be saved to the database.', Comment = '%1 Quantity,%2 Quantity,%3 Quantity';
        Text015Lbl: Label 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?', Comment = '%1 No.';
        Text016Lbl: Label 'purchase order line';
        Text017Lbl: Label 'sales order line';
        Text018Lbl: Label 'Saving item tracking line changes';
        Text019Lbl: Label 'There are availability warnings on one or more lines.\Close the form anyway?';
        Text020Lbl: Label 'Placeholder';
        Text50000Lbl: Label 'Lot No. already exists for Item No.: %1 and Lot No.: %2. Do you want to continue entering the Quantity?', Comment = '%1 Item No.,%2 Lot no.';
        Text50001Lbl: Label 'Quantity: #1###########', Comment = '%1 Quantity';


    procedure SetFormRunMode(Mode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment")
    begin
        FormRunMode := Mode;
    end;

    procedure SetSource(TrackingSpecification: Record "Tracking Specification"; AvailabilityDate: Date)
    var
        ReservEntry: Record "Reservation Entry";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        TempTrackingSpecification2: Record "Tracking Specification" temporary;

        Controls: Option Handle,Invoice,Quantity,Reclass,LotSN;
    begin
        GetItem(TrackingSpecification."Item No.");
        ForBinCode := TrackingSpecification."Bin Code";
        SetFilters(TrackingSpecification);
        TempTrackingSpecification.DELETEALL();
        TempItemTrackLineInsert.DELETEALL();
        TempItemTrackLineModify.DELETEALL();
        TempItemTrackLineDelete.DELETEALL();
        //>>SSC56
        TempTrackingSpecificationBin.DELETEALL();
        //<<SSC56
        TempReservEntry.DELETEALL();
        LastEntryNo := 0;
        IF ItemTrackingMgt.IsOrderNetworkEntity(TrackingSpecification."Source Type",
             TrackingSpecification."Source Subtype") AND NOT (FormRunMode = FormRunMode::"Drop Shipment")
        THEN
            CurrentEntryStatus := CurrentEntryStatus::Surplus
        ELSE
            CurrentEntryStatus := CurrentEntryStatus::Prospect;

        IF (TrackingSpecification."Source Type" IN
            [DATABASE::"Item Ledger Entry",
             DATABASE::"Item Journal Line",
             DATABASE::"Job Journal Line",
             DATABASE::"Requisition Line"]) OR
           ((TrackingSpecification."Source Type" IN [DATABASE::"Sales Line", DATABASE::"Purchase Line", DATABASE::"Service Line"]) AND
            (TrackingSpecification."Source Subtype" IN [0, 2, 3])) OR
           ((TrackingSpecification."Source Type" = DATABASE::"Assembly Line") AND (TrackingSpecification."Source Subtype" = 0))
        THEN
            SetControls(Controls::Handle, FALSE)
        ELSE
            SetControls(Controls::Handle, TRUE);

        IF (TrackingSpecification."Source Type" IN
            [DATABASE::"Item Ledger Entry",
             DATABASE::"Item Journal Line",
             DATABASE::"Job Journal Line",
             DATABASE::"Requisition Line",
             DATABASE::"Transfer Line",
             DATABASE::"Assembly Line",
             DATABASE::"Assembly Header",
             DATABASE::"Prod. Order Line",
             DATABASE::"Prod. Order Component"]) OR
           ((TrackingSpecification."Source Type" IN [DATABASE::"Sales Line", DATABASE::"Purchase Line", DATABASE::"Service Line"]) AND
            (TrackingSpecification."Source Subtype" IN [0, 2, 3, 4]))
        THEN
            SetControls(Controls::Invoice, FALSE)
        ELSE
            SetControls(Controls::Invoice, TRUE);

        SetControls(Controls::Reclass, FormRunMode = FormRunMode::Reclass);
        IF FormRunMode = FormRunMode::"Combined Ship/Rcpt" THEN
            SetControls(Controls::LotSN, FALSE);
        IF ItemTrackingMgt.ItemTrkgIsManagedByWhse(
             TrackingSpecification."Source Type",
             TrackingSpecification."Source Subtype",
             TrackingSpecification."Source ID",
             TrackingSpecification."Source Prod. Order Line",
             TrackingSpecification."Source Ref. No.",
             TrackingSpecification."Location Code",
             TrackingSpecification."Item No.")
        THEN BEGIN
            SetControls(Controls::Quantity, FALSE);
            "Qty. to Handle (Base)Editable" := TRUE;
            DeleteIsBlocked := TRUE;
        END;
        ReservEntry."Source Type" := TrackingSpecification."Source Type";
        ReservEntry."Source Subtype" := TrackingSpecification."Source Subtype";
        CurrentSignFactor := CreateReservEntry.SignFactor(ReservEntry);
        CurrentSourceCaption := ReservEntry.TextCaption();
        CurrentSourceType := ReservEntry."Source Type";

        IF CurrentSignFactor < 0 THEN BEGIN
            ExpectedReceiptDate := 0D;
            ShipmentDate := AvailabilityDate;
        END ELSE BEGIN
            ExpectedReceiptDate := AvailabilityDate;
            ShipmentDate := 0D;
        END;
        SourceQuantityArray[1] := TrackingSpecification."Quantity (Base)";
        SourceQuantityArray[2] := TrackingSpecification."Qty. to Handle (Base)";
        SourceQuantityArray[3] := TrackingSpecification."Qty. to Invoice (Base)";
        SourceQuantityArray[4] := TrackingSpecification."Quantity Handled (Base)";
        SourceQuantityArray[5] := TrackingSpecification."Quantity Invoiced (Base)";
        QtyPerUOM := TrackingSpecification."Qty. per Unit of Measure";

        ReservEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Reservation Status");

        ReservEntry.SETRANGE("Source ID", TrackingSpecification."Source ID");
        ReservEntry.SETRANGE("Source Ref. No.", TrackingSpecification."Source Ref. No.");
        ReservEntry.SETRANGE("Source Type", TrackingSpecification."Source Type");
        ReservEntry.SETRANGE("Source Subtype", TrackingSpecification."Source Subtype");
        ReservEntry.SETRANGE("Source Batch Name", TrackingSpecification."Source Batch Name");
        ReservEntry.SETRANGE("Source Prod. Order Line", TrackingSpecification."Source Prod. Order Line");

        // Transfer Receipt gets special treatment:
        IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
           (FormRunMode <> FormRunMode::Transfer) AND
           (TrackingSpecification."Source Subtype" = 1)
        THEN BEGIN
            ReservEntry.SETRANGE("Source Subtype", 0);
            AddReservEntriesToTempRecSet(ReservEntry, TempTrackingSpecification2, TRUE, 8421504);
            ReservEntry.SETRANGE("Source Subtype", 1);
            ReservEntry.SETRANGE("Source Prod. Order Line", TrackingSpecification."Source Ref. No.");
            ReservEntry.SETRANGE("Source Ref. No.");
            DeleteIsBlocked := TRUE;
            SetControls(Controls::Quantity, FALSE);
        END;

        AddReservEntriesToTempRecSet(ReservEntry, TempTrackingSpecification, FALSE, 0);

        TempReservEntry.COPYFILTERS(ReservEntry);
        TrackingSpecification.SETCURRENTKEY(
          "Source ID", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

        TrackingSpecification.SETRANGE("Source ID", TrackingSpecification."Source ID");
        TrackingSpecification.SETRANGE("Source Type", TrackingSpecification."Source Type");
        TrackingSpecification.SETRANGE("Source Subtype", TrackingSpecification."Source Subtype");
        TrackingSpecification.SETRANGE("Source Batch Name", TrackingSpecification."Source Batch Name");
        TrackingSpecification.SETRANGE("Source Prod. Order Line", TrackingSpecification."Source Prod. Order Line");
        TrackingSpecification.SETRANGE("Source Ref. No.", TrackingSpecification."Source Ref. No.");

        IF TrackingSpecification.FINDSET() THEN
            REPEAT
                TempTrackingSpecification := TrackingSpecification;
                TempTrackingSpecification.INSERT();
                //>>SSC56
                TrackingSpecificationBin.RESET();
                TrackingSpecificationBin.SETRANGE("Entry Type", TrackingSpecificationBin."Entry Type"::"Tracking Specification");
                TrackingSpecificationBin.SETRANGE("Entry No.", TrackingSpecification."Entry No.");
                IF TrackingSpecificationBin.FINDSET() THEN
                    REPEAT
                        TempTrackingSpecificationBin.TRANSFERFIELDS(TrackingSpecificationBin);
                        TempTrackingSpecificationBin."Entry Type" := TempTrackingSpecificationBin."Entry Type"::"Tracking Specification";
                        TempTrackingSpecificationBin."Entry No." := TrackingSpecification."Entry No.";
                        TempTrackingSpecificationBin."Source Entry Type" := TrackingSpecificationBin."Entry Type";
                        TempTrackingSpecificationBin."Source Entry No." := TrackingSpecificationBin."Entry No.";
                        TempTrackingSpecificationBin.INSERT();
                    UNTIL TrackingSpecificationBin.NEXT() = 0;
                TrackingSpecificationBin.RESET();
            //<<SSC56
            UNTIL TrackingSpecification.NEXT() = 0;

        // Data regarding posted quantities on transfers is collected from Item Ledger Entries:
        IF TrackingSpecification."Source Type" = DATABASE::"Transfer Line" THEN
            CollectPostedTransferEntries(TrackingSpecification, TempTrackingSpecification);

        // Data regarding posted quantities on assembly orders is collected from Item Ledger Entries:
        IF NOT ExcludePostedEntries THEN
            IF (TrackingSpecification."Source Type" = DATABASE::"Assembly Line") OR
               (TrackingSpecification."Source Type" = DATABASE::"Assembly Header")
            THEN
                CollectPostedAssemblyEntries(TrackingSpecification, TempTrackingSpecification);

        // Data regarding posted output quantities on prod.orders is collected from Item Ledger Entries:
        IF TrackingSpecification."Source Type" = DATABASE::"Prod. Order Line" THEN
            IF TrackingSpecification."Source Subtype" = 3 THEN
                CollectPostedOutputEntries(TrackingSpecification, TempTrackingSpecification);

        // If run for Drop Shipment a RowID is prepared for synchronisation:
        IF FormRunMode = FormRunMode::"Drop Shipment" THEN
            CurrentSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
                TrackingSpecification."Source Subtype", TrackingSpecification."Source ID",
                TrackingSpecification."Source Batch Name", TrackingSpecification."Source Prod. Order Line",
                TrackingSpecification."Source Ref. No.");

        // Synchronization of outbound transfer order:
        IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
           (TrackingSpecification."Source Subtype" = 0)
        THEN BEGIN
            BlockCommit := TRUE;
            CurrentSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
                TrackingSpecification."Source Subtype", TrackingSpecification."Source ID",
                TrackingSpecification."Source Batch Name", TrackingSpecification."Source Prod. Order Line",
                TrackingSpecification."Source Ref. No.");
            SecondSourceRowID := ItemTrackingMgt.ComposeRowID(TrackingSpecification."Source Type",
                1, TrackingSpecification."Source ID",
                TrackingSpecification."Source Batch Name", TrackingSpecification."Source Prod. Order Line",
                TrackingSpecification."Source Ref. No.");
            FormRunMode := FormRunMode::Transfer;
        END;

        AddToGlobalRecordSet(TempTrackingSpecification);
        AddToGlobalRecordSet(TempTrackingSpecification2);
        CalculateSums();

        ItemTrackingDataCollection.SetCurrentBinAndItemTrkgCode(ForBinCode, ItemTrackingCode);
        ItemTrackingDataCollection.RetrieveLookupData(Rec, FALSE);

        FunctionsDemandVisible := CurrentSignFactor * SourceQuantityArray[1] < 0;
        FunctionsSupplyVisible := NOT FunctionsDemandVisible;
    end;


    procedure SetSecondSourceQuantity(SecondSourceQuantityArray: array[3] of Decimal)
    var
        Controls: Option Handle,Invoice;
    begin
        CASE SecondSourceQuantityArray[1] OF
            DATABASE::"Warehouse Receipt Line", DATABASE::"Warehouse Shipment Line":
                BEGIN
                    SourceQuantityArray[2] := SecondSourceQuantityArray[2]; // "Qty. to Handle (Base)"
                    SourceQuantityArray[3] := SecondSourceQuantityArray[3]; // "Qty. to Invoice (Base)"
                    SetControls(Controls::Invoice, FALSE);
                END;
            ELSE
                EXIT;
        END;
        CalculateSums();
    end;


    procedure SetSecondSourceRowID(RowID: Text[100])
    begin
        SecondSourceRowID := RowID;
    end;

    local procedure AddReservEntriesToTempRecSet(var ReservEntry: Record "Reservation Entry"; var TempTrackingSpecification: Record "Tracking Specification" temporary; SwapSign: Boolean; Color: Integer)
    begin
        IF ReservEntry.FINDSET() THEN
            REPEAT
                IF Color = 0 THEN BEGIN
                    TempReservEntry := ReservEntry;
                    TempReservEntry.INSERT();
                END;
                IF (ReservEntry."Lot No." <> '') OR (ReservEntry."Serial No." <> '') THEN BEGIN
                    TempTrackingSpecification.TRANSFERFIELDS(ReservEntry);
                    // Ensure uniqueness of Entry No. by making it negative:
                    TempTrackingSpecification."Entry No." *= -1;
                    IF SwapSign THEN
                        TempTrackingSpecification."Quantity (Base)" *= -1;
                    IF Color <> 0 THEN BEGIN
                        TempTrackingSpecification."Quantity Handled (Base)" :=
                          TempTrackingSpecification."Quantity (Base)";
                        TempTrackingSpecification."Quantity Invoiced (Base)" :=
                          TempTrackingSpecification."Quantity (Base)";
                        TempTrackingSpecification."Qty. to Handle (Base)" := 0;
                        TempTrackingSpecification."Qty. to Invoice (Base)" := 0;
                    END;
                    TempTrackingSpecification."Buffer Status" := Color;
                    //>>SSC56
                    TempTrackingSpecification."Source Entry Type" := TempTrackingSpecification."Source Entry Type"::"Reservation Entry";
                    TempTrackingSpecification."Source Entry No." := ReservEntry."Entry No.";
                    //<<SSC56
                    TempTrackingSpecification.INSERT();
                END;

                //>>SSC56
                TrackingSpecificationBin.RESET();
                TrackingSpecificationBin.SETRANGE("Entry Type", TrackingSpecificationBin."Entry Type"::"Reservation Entry");
                TrackingSpecificationBin.SETRANGE("Entry No.", ReservEntry."Entry No.");
                IF TrackingSpecificationBin.FINDSET() THEN
                    REPEAT
                        TempTrackingSpecificationBinReserv.TRANSFERFIELDS(TrackingSpecificationBin);
                        TempTrackingSpecificationBinReserv."Entry No." := TempTrackingSpecification."Entry No.";
                        TempTrackingSpecificationBinReserv."Source Entry Type" := TempTrackingSpecificationBinReserv."Entry Type"::"Reservation Entry";
                        TempTrackingSpecificationBinReserv."Source Entry No." := ReservEntry."Entry No.";
                        TempTrackingSpecificationBinReserv.INSERT();
                    UNTIL TrackingSpecificationBin.NEXT() = 0;
                TrackingSpecificationBin.RESET();
            //<<SSC56
            UNTIL ReservEntry.NEXT() = 0;
    end;

    local procedure AddToGlobalRecordSet(var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var

        TempItemTrackingSetup: record "Item Tracking Setup" temporary;
        ExpDate: Date;
        EntriesExist: Boolean;
    begin
        TempTrackingSpecification.SETCURRENTKEY("Lot No.", "Serial No.");
        IF TempTrackingSpecification.FIND('-') THEN
            REPEAT
                TempTrackingSpecification.SETRANGE("Lot No.", TempTrackingSpecification."Lot No.");
                TempTrackingSpecification.SETRANGE("Serial No.", TempTrackingSpecification."Serial No.");
                TempTrackingSpecification.CALCSUMS("Quantity (Base)", "Qty. to Handle (Base)",
                  "Qty. to Invoice (Base)", "Quantity Handled (Base)", "Quantity Invoiced (Base)");
                IF TempTrackingSpecification."Quantity (Base)" <> 0 THEN BEGIN
                    Rec := TempTrackingSpecification;
                    Rec."Quantity (Base)" *= CurrentSignFactor;
                    Rec."Qty. to Handle (Base)" *= CurrentSignFactor;
                    Rec."Qty. to Invoice (Base)" *= CurrentSignFactor;
                    Rec."Quantity Handled (Base)" *= CurrentSignFactor;
                    Rec."Quantity Invoiced (Base)" *= CurrentSignFactor;
                    Rec."Qty. to Handle" :=
                      Rec.CalcQty(Rec."Qty. to Handle (Base)");
                    Rec."Qty. to Invoice" :=
                      Rec.CalcQty(Rec."Qty. to Invoice (Base)");
                    Rec."Entry No." := NextEntryNo();

                    ExpDate := ItemTrackingMgt.ExistingExpirationDate(
                        Rec."Item No.", Rec."Variant Code",
                        TempItemTrackingSetup, FALSE, EntriesExist);

                    IF ExpDate <> 0D THEN BEGIN
                        Rec."Expiration Date" := ExpDate;
                        Rec."Buffer Status2" := Rec."Buffer Status2"::"ExpDate blocked";
                    END;

                    Rec.INSERT();

                    //>>SSC56
                    TempTrackingSpecificationBinReserv.RESET();
                    TempTrackingSpecificationBinReserv.SETRANGE("Entry Type", TempTrackingSpecificationBinReserv."Entry Type"::"Reservation Entry");
                    TempTrackingSpecificationBinReserv.SETRANGE("Entry No.", TempTrackingSpecification."Entry No.");
                    IF TempTrackingSpecificationBinReserv.FINDSET() THEN
                        REPEAT
                            TempTrackingSpecificationBin.TRANSFERFIELDS(TempTrackingSpecificationBinReserv);
                            TempTrackingSpecificationBin."Entry No." := Rec."Entry No.";
                            TempTrackingSpecificationBin.INSERT();
                        UNTIL TempTrackingSpecificationBinReserv.NEXT() = 0;
                    TempTrackingSpecificationBinReserv.RESET();
                    //<<SSC56

                    IF Rec."Buffer Status" = 0 THEN BEGIN
                        xTempItemTrackingLine := Rec;
                        xTempItemTrackingLine.INSERT();
                    END;
                END;

                TempTrackingSpecification.FIND('+');
                TempTrackingSpecification.SETRANGE("Lot No.");
                TempTrackingSpecification.SETRANGE("Serial No.");
            UNTIL TempTrackingSpecification.NEXT() = 0;
    end;

    local procedure SetControls(Controls: Option Handle,Invoice,Quantity,Reclass,LotSN; SetAccess: Boolean)
    begin
        CASE Controls OF
            Controls::Handle:
                BEGIN
                    Handle1Visible := SetAccess;
                    Handle2Visible := SetAccess;
                    Handle3Visible := SetAccess;
                    "Qty. to Handle (Base)Visible" := SetAccess;
                    "Qty. to Handle (Base)Editable" := SetAccess;
                END;
            Controls::Invoice:
                BEGIN
                    Invoice1Visible := SetAccess;
                    Invoice2Visible := SetAccess;
                    Invoice3Visible := SetAccess;
                    "Qty. to Invoice (Base)Visible" := SetAccess;
                    "Qty. to Invoice (Base)Editable" := SetAccess;
                END;
            Controls::Quantity:
                BEGIN
                    "Quantity (Base)Editable" := SetAccess;
                    //"Serial No.Editable" := SetAccess;
                    "Lot No.Editable" := SetAccess;
                    DescriptionEditable := SetAccess;
                    InsertIsBlocked := TRUE;
                END;
            Controls::Reclass:
                BEGIN
                    //"New Serial No.Visible" := SetAccess;
                    //"New Serial No.Editable" := SetAccess;
                    "New Lot No.Visible" := SetAccess;
                    "New Lot No.Editable" := SetAccess;
                    "New Expiration DateVisible" := SetAccess;
                    "New Expiration DateEditable" := SetAccess;
                    ButtonLineReclassVisible := SetAccess;
                    ButtonLineVisible := NOT SetAccess;
                END;
            Controls::LotSN:
                BEGIN
                    //"Serial No.Editable" := SetAccess;
                    "Lot No.Editable" := SetAccess;
                    "Expiration DateEditable" := SetAccess;
                    "Warranty DateEditable" := SetAccess;
                    InsertIsBlocked := SetAccess;
                END;
        END;
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        IF Item."No." <> ItemNo THEN BEGIN
            Item.GET(ItemNo);
            Item.TESTFIELD("Item Tracking Code");
            IF ItemTrackingCode.Code <> Item."Item Tracking Code" THEN
                ItemTrackingCode.GET(Item."Item Tracking Code");
        END;
    end;

    local procedure SetFilters(TrackingSpecification: Record "Tracking Specification")
    begin
        Rec.FILTERGROUP(2);
        Rec.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        Rec.SETRANGE(Rec."Source ID", TrackingSpecification."Source ID");
        Rec.SETRANGE(Rec."Source Type", TrackingSpecification."Source Type");
        Rec.SETRANGE(Rec."Source Subtype", TrackingSpecification."Source Subtype");
        Rec.SETRANGE(Rec."Source Batch Name", TrackingSpecification."Source Batch Name");
        IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
           (TrackingSpecification."Source Subtype" = 1)
        THEN BEGIN
            Rec.SETFILTER("Source Prod. Order Line", '0 | ' + FORMAT(TrackingSpecification."Source Ref. No."));
            Rec.SETRANGE("Source Ref. No.");
        END ELSE BEGIN
            Rec.SETRANGE("Source Prod. Order Line", TrackingSpecification."Source Prod. Order Line");
            Rec.SETRANGE("Source Ref. No.", TrackingSpecification."Source Ref. No.");
        END;
        Rec.SETRANGE("Item No.", TrackingSpecification."Item No.");
        Rec.SETRANGE("Location Code", TrackingSpecification."Location Code");
        Rec.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        Rec.FILTERGROUP(0);
    end;

    local procedure CheckLine(TrackingLine: Record "Tracking Specification"): Boolean
    begin
        IF TrackingLine."Quantity (Base)" * SourceQuantityArray[1] < 0 THEN
            IF SourceQuantityArray[1] < 0 THEN
                ERROR(Text002Lbl, Text003Lbl)
            ELSE
                ERROR(Text002Lbl, Text004Lbl);
    end;

    local procedure CalculateSums()
    var
        xTrackingSpec: Record "Tracking Specification";
    begin
        xTrackingSpec.COPY(Rec);
        Rec.RESET();
        Rec.CALCSUMS("Quantity (Base)",
          Rec."Qty. to Handle (Base)",
          Rec."Qty. to Invoice (Base)");
        TotalItemTrackingLine := Rec;
        Rec.COPY(xTrackingSpec);

        UpdateUndefinedQty();
    end;

    local procedure UpdateUndefinedQty() QtyIsValid: Boolean
    begin
        UndefinedQtyArray[1] := SourceQuantityArray[1] - TotalItemTrackingLine."Quantity (Base)";
        UndefinedQtyArray[2] := SourceQuantityArray[2] - TotalItemTrackingLine."Qty. to Handle (Base)";
        UndefinedQtyArray[3] := SourceQuantityArray[3] - TotalItemTrackingLine."Qty. to Invoice (Base)";

        IF ABS(SourceQuantityArray[1]) < ABS(TotalItemTrackingLine."Quantity (Base)") THEN
            QtyIsValid := FALSE
        ELSE
            QtyIsValid := TRUE;
    end;

    local procedure TempRecIsValid() OK: Boolean
    var
        ReservEntry: Record "Reservation Entry";
        RecordCount: Integer;
        IdenticalArray: array[2] of Boolean;
    begin
        OK := FALSE;
        TempReservEntry.SETCURRENTKEY("Entry No.", Positive);
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type",
          "Source Subtype", "Source Batch Name", "Source Prod. Order Line");

        ReservEntry.COPYFILTERS(TempReservEntry);

        IF ReservEntry.FINDSET() THEN
            REPEAT
                IF NOT TempReservEntry.GET(ReservEntry."Entry No.", ReservEntry.Positive) THEN
                    EXIT(FALSE);
                IF NOT EntriesAreIdentical(ReservEntry, TempReservEntry, IdenticalArray) THEN
                    EXIT(FALSE);
                RecordCount += 1;
            UNTIL ReservEntry.NEXT() = 0;

        OK := RecordCount = TempReservEntry.COUNT();
    end;

    local procedure EntriesAreIdentical(var ReservEntry1: Record 337; var ReservEntry2: Record 337; var IdenticalArray: array[2] of Boolean): Boolean
    begin
        IdenticalArray[1] := (
                              (ReservEntry1."Entry No." = ReservEntry2."Entry No.") AND
                              (ReservEntry1."Item No." = ReservEntry2."Item No.") AND
                              (ReservEntry1."Location Code" = ReservEntry2."Location Code") AND
                              (ReservEntry1."Quantity (Base)" = ReservEntry2."Quantity (Base)") AND
                              (ReservEntry1."Reservation Status" = ReservEntry2."Reservation Status") AND
                              (ReservEntry1."Creation Date" = ReservEntry2."Creation Date") AND
                              (ReservEntry1."Transferred from Entry No." = ReservEntry2."Transferred from Entry No.") AND
                              (ReservEntry1."Source Type" = ReservEntry2."Source Type") AND
                              (ReservEntry1."Source Subtype" = ReservEntry2."Source Subtype") AND
                              (ReservEntry1."Source ID" = ReservEntry2."Source ID") AND
                              (ReservEntry1."Source Batch Name" = ReservEntry2."Source Batch Name") AND
                              (ReservEntry1."Source Prod. Order Line" = ReservEntry2."Source Prod. Order Line") AND
                              (ReservEntry1."Source Ref. No." = ReservEntry2."Source Ref. No.") AND
                              (ReservEntry1."Expected Receipt Date" = ReservEntry2."Expected Receipt Date") AND
                              (ReservEntry1."Shipment Date" = ReservEntry2."Shipment Date") AND
                              (ReservEntry1."Serial No." = ReservEntry2."Serial No.") AND
                              (ReservEntry1."Created By" = ReservEntry2."Created By") AND
                              (ReservEntry1."Changed By" = ReservEntry2."Changed By") AND
                              (ReservEntry1.Positive = ReservEntry2.Positive) AND
                              (ReservEntry1."Qty. per Unit of Measure" = ReservEntry2."Qty. per Unit of Measure") AND
                              (ReservEntry1.Quantity = ReservEntry2.Quantity) AND
                              (ReservEntry1."Action Message Adjustment" = ReservEntry2."Action Message Adjustment") AND
                              (ReservEntry1.Binding = ReservEntry2.Binding) AND
                              (ReservEntry1."Suppressed Action Msg." = ReservEntry2."Suppressed Action Msg.") AND
                              (ReservEntry1."Planning Flexibility" = ReservEntry2."Planning Flexibility") AND
                              (ReservEntry1."Lot No." = ReservEntry2."Lot No.") AND
                              (ReservEntry1."Variant Code" = ReservEntry2."Variant Code") AND
                              (ReservEntry1."Quantity Invoiced (Base)" = ReservEntry2."Quantity Invoiced (Base)"));

        IdenticalArray[2] := (
                              (ReservEntry1.Description = ReservEntry2.Description) AND
                              (ReservEntry1."New Serial No." = ReservEntry2."New Serial No.") AND
                              (ReservEntry1."New Lot No." = ReservEntry2."New Lot No.") AND
                              (ReservEntry1."Expiration Date" = ReservEntry2."Expiration Date") AND
                              (ReservEntry1."Warranty Date" = ReservEntry2."Warranty Date") AND
                              (ReservEntry1."New Expiration Date" = ReservEntry2."New Expiration Date"));

        EXIT(IdenticalArray[1] AND IdenticalArray[2]);
    end;

    local procedure QtyToHandleAndInvoiceChanged(var ReservEntry1: Record 337; var ReservEntry2: Record 337): Boolean
    begin
        EXIT(
          (ReservEntry1."Qty. to Handle (Base)" <> ReservEntry2."Qty. to Handle (Base)") OR
          (ReservEntry1."Qty. to Invoice (Base)" <> ReservEntry2."Qty. to Invoice (Base)"));
    end;

    local procedure NextEntryNo(): Integer
    begin
        LastEntryNo += 1;
        EXIT(LastEntryNo);
    end;

    local procedure WriteToDatabase()
    var
        Window: Dialog;
        ChangeType: Option Insert,Modify,Delete;
        EntryNo: Integer;
        NoOfLines: Integer;
        i: Integer;
        ModifyLoop: Integer;
        Decrease: Boolean;
    begin
        //>>SSC56
        IF TempReservEntry.FINDSET() THEN
            REPEAT
                TrackingSpecificationBin.RESET();
                TrackingSpecificationBin.SETRANGE("Entry Type", TrackingSpecificationBin."Entry Type"::"Reservation Entry");
                TrackingSpecificationBin.SETRANGE("Entry No.", TempReservEntry."Entry No.");
                TrackingSpecificationBin.DELETEALL();
                TrackingSpecificationBin.RESET();

                TempTrackingSpecificationBin.RESET();
                TempTrackingSpecificationBin.SETRANGE("Source Entry Type", TempTrackingSpecificationBin."Source Entry Type"::"Reservation Entry");
                TempTrackingSpecificationBin.SETRANGE("Source Entry No.", TempReservEntry."Entry No.");
                IF TempTrackingSpecificationBin.FINDSET() THEN
                    REPEAT
                        TrackingSpecificationBin.TRANSFERFIELDS(TempTrackingSpecificationBin);
                        TrackingSpecificationBin."Entry Type" := TempTrackingSpecificationBin."Source Entry Type";
                        TrackingSpecificationBin."Entry No." := TempTrackingSpecificationBin."Source Entry No.";
                        TrackingSpecificationBin.INSERT();
                    UNTIL TempTrackingSpecificationBin.NEXT() = 0;
                TempTrackingSpecificationBin.RESET();
            UNTIL TempReservEntry.NEXT() = 0;
        //<<SSC56

        IF CurrentFormIsOpen THEN BEGIN
            TempReservEntry.LOCKTABLE();
            TempRecValid();

            IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::None THEN
                QtyToAddAsBlank := 0
            ELSE
                QtyToAddAsBlank := UndefinedQtyArray[1] * CurrentSignFactor;

            Rec.RESET();
            Rec.DELETEALL();

            Window.OPEN('#1############# @2@@@@@@@@@@@@@@@@@@@@@');
            Window.UPDATE(1, Text018Lbl);
            NoOfLines := TempItemTrackLineInsert.COUNT + TempItemTrackLineModify.COUNT() + TempItemTrackLineDelete.COUNT();
            IF TempItemTrackLineDelete.FIND('-') THEN BEGIN
                REPEAT
                    i := i + 1;
                    IF i MOD 100 = 0 THEN
                        Window.UPDATE(2, ROUND(i / NoOfLines * 10000, 1));
                    RegisterChange(TempItemTrackLineDelete, TempItemTrackLineDelete, ChangeType::Delete, FALSE);
                    IF TempItemTrackLineModify.GET(TempItemTrackLineDelete."Entry No.") THEN
                        TempItemTrackLineModify.DELETE();
                UNTIL TempItemTrackLineDelete.NEXT() = 0;
                TempItemTrackLineDelete.DELETEALL();
            END;

            FOR ModifyLoop := 1 TO 2 DO BEGIN
                IF TempItemTrackLineModify.FIND('-') THEN
                    REPEAT
                        IF xTempItemTrackingLine.GET(TempItemTrackLineModify."Entry No.") THEN BEGIN
                            // Process decreases before increases
                            Decrease := (xTempItemTrackingLine."Quantity (Base)" > TempItemTrackLineModify."Quantity (Base)");
                            IF ((ModifyLoop = 1) AND Decrease) OR ((ModifyLoop = 2) AND NOT Decrease) THEN
                                i := i + 1;
                            IF (xTempItemTrackingLine."Serial No." <> TempItemTrackLineModify."Serial No.") OR
                               (xTempItemTrackingLine."Lot No." <> TempItemTrackLineModify."Lot No.") OR
                               (xTempItemTrackingLine."Appl.-from Item Entry" <> TempItemTrackLineModify."Appl.-from Item Entry") OR
                               (xTempItemTrackingLine."Appl.-to Item Entry" <> TempItemTrackLineModify."Appl.-to Item Entry")
                            THEN BEGIN
                                RegisterChange(xTempItemTrackingLine, xTempItemTrackingLine, ChangeType::Delete, FALSE);
                                RegisterChange(TempItemTrackLineModify, TempItemTrackLineModify, ChangeType::Insert, FALSE);
                                IF (TempItemTrackLineInsert."Quantity (Base)" <> TempItemTrackLineInsert."Qty. to Handle (Base)") OR
                                   (TempItemTrackLineInsert."Quantity (Base)" <> TempItemTrackLineInsert."Qty. to Invoice (Base)")
                                THEN
                                    SetQtyToHandleAndInvoice(TempItemTrackLineInsert);
                            END ELSE
                                IF NOT ChangeAlreadyNonSpecificReservations(
                                     TempItemTrackLineModify, TempItemTrackLineModify."Quantity (Base)" - xTempItemTrackingLine."Quantity (Base)")
                                THEN BEGIN
                                    RegisterChange(xTempItemTrackingLine, TempItemTrackLineModify, ChangeType::Modify, FALSE);
                                    SetQtyToHandleAndInvoice(TempItemTrackLineModify);
                                    TempItemTrackLineModify.DELETE();
                                END;
                        END ELSE BEGIN
                            i := i + 1;
                            TempItemTrackLineModify.DELETE();
                        END;
                        IF i MOD 100 = 0 THEN
                            Window.UPDATE(2, ROUND(i / NoOfLines * 10000, 1));
                    UNTIL TempItemTrackLineModify.NEXT() = 0;
            END;

            IF TempItemTrackLineInsert.FIND('-') THEN BEGIN
                REPEAT
                    i := i + 1;
                    IF i MOD 100 = 0 THEN
                        Window.UPDATE(2, ROUND(i / NoOfLines * 10000, 1));
                    IF TempItemTrackLineModify.GET(TempItemTrackLineInsert."Entry No.") THEN
                        TempItemTrackLineInsert.TRANSFERFIELDS(TempItemTrackLineModify);
                    IF NOT ChangeAlreadyNonSpecificReservations(TempItemTrackLineInsert, TempItemTrackLineInsert."Quantity (Base)") THEN BEGIN
                        IF NOT RegisterChange(TempItemTrackLineInsert, TempItemTrackLineInsert, ChangeType::Insert, FALSE) THEN
                            ERROR(Text005Lbl);
                        IF (TempItemTrackLineInsert."Quantity (Base)" <> TempItemTrackLineInsert."Qty. to Handle (Base)") OR
                           (TempItemTrackLineInsert."Quantity (Base)" <> TempItemTrackLineInsert."Qty. to Invoice (Base)")
                        THEN
                            SetQtyToHandleAndInvoice(TempItemTrackLineInsert);
                    END;
                UNTIL TempItemTrackLineInsert.NEXT() = 0;
                TempItemTrackLineInsert.DELETEALL();
            END;
            Window.CLOSE();
        END ELSE BEGIN
            TempReservEntry.LOCKTABLE();
            TempRecValid();

            IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::None THEN
                QtyToAddAsBlank := 0
            ELSE
                QtyToAddAsBlank := UndefinedQtyArray[1] * CurrentSignFactor;

            Rec.RESET();
            Rec.SETFILTER("Buffer Status", '<>%1', 0);
            Rec.DELETEALL();
            Rec.RESET();

            xTempItemTrackingLine.RESET();
            Rec.SETCURRENTKEY("Entry No.");
            xTempItemTrackingLine.SETCURRENTKEY("Entry No.");
            IF xTempItemTrackingLine.FIND('-') THEN
                REPEAT
                    Rec.SETRANGE("Lot No.", xTempItemTrackingLine."Lot No.");
                    Rec.SETRANGE("Serial No.", xTempItemTrackingLine."Serial No.");
                    IF Rec.FIND('-') THEN BEGIN
                        IF RegisterChange(xTempItemTrackingLine, Rec, ChangeType::Modify, FALSE) THEN BEGIN
                            EntryNo := xTempItemTrackingLine."Entry No.";
                            xTempItemTrackingLine := Rec;
                            xTempItemTrackingLine."Entry No." := EntryNo;
                            xTempItemTrackingLine.MODIFY();
                        END;
                        SetQtyToHandleAndInvoice(Rec);
                        Rec.DELETE()
                    END ELSE BEGIN
                        RegisterChange(xTempItemTrackingLine, xTempItemTrackingLine, ChangeType::Delete, FALSE);
                        xTempItemTrackingLine.DELETE();
                    END;
                UNTIL xTempItemTrackingLine.NEXT() = 0;

            Rec.RESET();

            IF Rec.FIND('-') THEN
                REPEAT
                    IF RegisterChange(Rec, Rec, ChangeType::Insert, FALSE) THEN BEGIN
                        xTempItemTrackingLine := Rec;
                        xTempItemTrackingLine.INSERT();
                    END ELSE
                        ERROR(Text005Lbl);
                    SetQtyToHandleAndInvoice(Rec);
                    Rec.DELETE();
                UNTIL Rec.NEXT() = 0;
        END;

        UpdateOrderTracking();
        ReestablishReservations(); // Late Binding

        IF NOT BlockCommit THEN
            COMMIT();
    end;

    local procedure RegisterChange(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "336"; ChangeType: Option Insert,Modify,FullDelete,PartDelete,ModifyAll; ModifySharedFields: Boolean) OK: Boolean
    var
        ReservEntry1: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        //CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservationMgt: Codeunit "Reservation Management";
        QtyToAdd: Decimal;
        LostReservQty: Decimal;
        IdenticalArray: array[2] of Boolean;
    begin
        OK := FALSE;
        SetPick(IsPick);
        IF (CurrentSignFactor * NewTrackingSpecification."Qty. to Handle") < 0 THEN BEGIN
            NewTrackingSpecification."Expiration Date" := 0D;
            OldTrackingSpecification."Expiration Date" := 0D;
        END;

        CASE ChangeType OF
            ChangeType::Insert:
                BEGIN
                    IF (OldTrackingSpecification."Quantity (Base)" = 0) OR
                       ((OldTrackingSpecification."Lot No." = '') AND
                        (OldTrackingSpecification."Serial No." = ''))
                    THEN
                        EXIT(TRUE);
                    TempReservEntry.SETRANGE("Serial No.", '');
                    TempReservEntry.SETRANGE("Lot No.", '');
                    OldTrackingSpecification."Quantity (Base)" :=
                      CurrentSignFactor *
                      ReservEngineMgt.AddItemTrackingToTempRecSet(
                        TempReservEntry, NewTrackingSpecification,
                        CurrentSignFactor * OldTrackingSpecification."Quantity (Base)", QtyToAddAsBlank,
                        ItemTrackingCode);
                    TempReservEntry.SETRANGE("Serial No.");
                    TempReservEntry.SETRANGE("Lot No.");

                    // Late Binding
                    IF ReservEngineMgt.RetrieveLostReservQty(LostReservQty) THEN BEGIN
                        TempItemTrackLineReserv := NewTrackingSpecification;
                        TempItemTrackLineReserv."Quantity (Base)" := LostReservQty * CurrentSignFactor;
                        TempItemTrackLineReserv.INSERT();
                    END;

                    IF OldTrackingSpecification."Quantity (Base)" = 0 THEN
                        EXIT(TRUE);

                    IF FormRunMode = FormRunMode::Reclass THEN BEGIN
                        CreateReservEntry.SetNewTrackingFromNewTrackingSpecification(                                                       //SetNewSerialLotNo used SetNewTrackingFromNewTrackingSpecification
                          OldTrackingSpecification);
                        CreateReservEntry.SetNewExpirationDate(OldTrackingSpecification."New Expiration Date");
                    END;
                    CreateReservEntry.SetDates(
                      NewTrackingSpecification."Warranty Date", NewTrackingSpecification."Expiration Date");
                    CreateReservEntry.SetApplyFromEntryNo(NewTrackingSpecification."Appl.-from Item Entry");
                    CreateReservEntry.SetApplyToEntryNo(NewTrackingSpecification."Appl.-to Item Entry");
                    CreateReservEntry.CreateReservEntryFor(
                       OldTrackingSpecification."Source Subtype",
                      OldTrackingSpecification."Source Type",
                      OldTrackingSpecification."Source ID",
                      OldTrackingSpecification."Source Batch Name",
                      OldTrackingSpecification."Source Prod. Order Line",
                      OldTrackingSpecification."Source Ref. No.",
                      OldTrackingSpecification."Qty. per Unit of Measure",
                      0,
                      OldTrackingSpecification."Quantity (Base)",
                     ReservEntry1);
                    CreateReservEntry.CreateEntry(OldTrackingSpecification."Item No.",
                      OldTrackingSpecification."Variant Code",
                      OldTrackingSpecification."Location Code",
                      OldTrackingSpecification.Description,
                      ExpectedReceiptDate,
                      ShipmentDate, 0, CurrentEntryStatus);
                    CreateReservEntry.GetLastEntry(ReservEntry1);
                    IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::"Tracking & Action Msg." THEN
                        ReservEngineMgt.UpdateActionMessages(ReservEntry1);

                    IF ModifySharedFields THEN BEGIN
                        ReservEntry1.SetPointerFilter();
                        ReservEntry1.SETRANGE("Lot No.", ReservEntry1."Lot No.");
                        ReservEntry1.SETRANGE("Serial No.", ReservEntry1."Serial No.");
                        ReservEntry1.SETFILTER("Entry No.", '<>%1', ReservEntry1."Entry No.");
                        ModifyFieldsWithinFilter(ReservEntry1, NewTrackingSpecification);
                    END;

                    OK := TRUE;
                END;
            ChangeType::Modify:
                BEGIN
                    ReservEntry1.TRANSFERFIELDS(OldTrackingSpecification);
                    ReservEntry2.TRANSFERFIELDS(NewTrackingSpecification);

                    ReservEntry1."Entry No." := ReservEntry2."Entry No."; // If only entry no. has changed it should not trigger
                    IF EntriesAreIdentical(ReservEntry1, ReservEntry2, IdenticalArray) THEN
                        EXIT(QtyToHandleAndInvoiceChanged(ReservEntry1, ReservEntry2));

                    IF ABS(OldTrackingSpecification."Quantity (Base)") < ABS(NewTrackingSpecification."Quantity (Base)") THEN BEGIN
                        // Item Tracking is added to any blank reservation entries:
                        TempReservEntry.SETRANGE("Serial No.", '');
                        TempReservEntry.SETRANGE("Lot No.", '');
                        QtyToAdd :=
                          CurrentSignFactor *
                          ReservEngineMgt.AddItemTrackingToTempRecSet(
                            TempReservEntry, NewTrackingSpecification,
                            CurrentSignFactor * (NewTrackingSpecification."Quantity (Base)" -
                                                 OldTrackingSpecification."Quantity (Base)"), QtyToAddAsBlank,
                            ItemTrackingCode);
                        TempReservEntry.SETRANGE("Serial No.");
                        TempReservEntry.SETRANGE("Lot No.");

                        // Late Binding
                        IF ReservEngineMgt.RetrieveLostReservQty(LostReservQty) THEN BEGIN
                            TempItemTrackLineReserv := NewTrackingSpecification;
                            TempItemTrackLineReserv."Quantity (Base)" := LostReservQty * CurrentSignFactor;
                            TempItemTrackLineReserv.INSERT();
                        END;

                        OldTrackingSpecification."Quantity (Base)" := QtyToAdd;
                        OldTrackingSpecification."Warranty Date" := NewTrackingSpecification."Warranty Date";
                        OldTrackingSpecification."Expiration Date" := NewTrackingSpecification."Expiration Date";
                        OldTrackingSpecification.Description := NewTrackingSpecification.Description;
                        RegisterChange(OldTrackingSpecification, OldTrackingSpecification,
                          ChangeType::Insert, NOT IdenticalArray[2]);
                    END ELSE BEGIN
                        TempReservEntry.SETRANGE("Serial No.", OldTrackingSpecification."Serial No.");
                        TempReservEntry.SETRANGE("Lot No.", OldTrackingSpecification."Lot No.");
                        OldTrackingSpecification."Serial No." := '';
                        OldTrackingSpecification."Lot No." := '';
                        OldTrackingSpecification."Warranty Date" := 0D;
                        OldTrackingSpecification."Expiration Date" := 0D;
                        QtyToAdd :=

                          CurrentSignFactor *
                          ReservEngineMgt.AddItemTrackingToTempRecSet(
                            TempReservEntry, OldTrackingSpecification,
                            CurrentSignFactor * (OldTrackingSpecification."Quantity (Base)" -
                                                 NewTrackingSpecification."Quantity (Base)"), QtyToAddAsBlank,
                            ItemTrackingCode);
                        TempReservEntry.SETRANGE("Serial No.");
                        TempReservEntry.SETRANGE("Lot No.");
                        RegisterChange(NewTrackingSpecification, NewTrackingSpecification,
                          ChangeType::PartDelete, NOT IdenticalArray[2]);
                    END;
                    OK := TRUE;
                END;
            ChangeType::FullDelete, ChangeType::PartDelete:
                BEGIN
                    ReservationMgt.SetItemTrackingHandling(1); // Allow deletion of Item Tracking
                    ReservEntry1.TRANSFERFIELDS(OldTrackingSpecification);
                    ReservEntry1.SetPointerFilter();
                    ReservEntry1.SETRANGE("Lot No.", ReservEntry1."Lot No.");
                    ReservEntry1.SETRANGE("Serial No.", ReservEntry1."Serial No.");
                    IF ChangeType = ChangeType::FullDelete THEN BEGIN
                        TempReservEntry.SETRANGE("Serial No.", OldTrackingSpecification."Serial No.");
                        TempReservEntry.SETRANGE("Lot No.", OldTrackingSpecification."Lot No.");
                        OldTrackingSpecification."Serial No." := '';
                        OldTrackingSpecification."Lot No." := '';
                        OldTrackingSpecification."Warranty Date" := 0D;
                        OldTrackingSpecification."Expiration Date" := 0D;
                        QtyToAdd :=
                          CurrentSignFactor *
                          ReservEngineMgt.AddItemTrackingToTempRecSet(
                            TempReservEntry, OldTrackingSpecification,
                            CurrentSignFactor * OldTrackingSpecification."Quantity (Base)", QtyToAddAsBlank,
                            ItemTrackingCode);
                        TempReservEntry.SETRANGE("Serial No.");
                        TempReservEntry.SETRANGE("Lot No.");
                        ReservationMgt.DeleteReservEntries(TRUE, 0, ReservEntry1)
                    END ELSE BEGIN
                        ReservationMgt.DeleteReservEntries(FALSE, ReservEntry1."Quantity (Base)" -
                          OldTrackingSpecification."Quantity Handled (Base)", ReservEntry1);
                        IF ModifySharedFields THEN BEGIN
                            ReservEntry1.SETRANGE("Reservation Status");
                            ModifyFieldsWithinFilter(ReservEntry1, OldTrackingSpecification);
                        END;
                    END;

                    OK := TRUE;
                END;
        END;

        SetQtyToHandleAndInvoice(NewTrackingSpecification);
    end;

    local procedure UpdateOrderTracking()
    var
        TempReserEntry: Record "Reservation Entry" temporary;
    begin
        IF NOT ReservEngineMgt.CollectAffectedSurplusEntries(TempReserEntry) THEN
            EXIT;
        IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::None THEN
            EXIT;
        ReservEngineMgt.UpdateOrderTracking(TempReserEntry);
    end;


    procedure ModifyFieldsWithinFilter(var ReservEntry1: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin
        // Used to ensure that field values that are common to a SN/Lot are copied to all entries.
        IF ReservEntry1.FIND('-') THEN
            REPEAT
                ReservEntry1.Description := TrackingSpecification.Description;
                ReservEntry1."Warranty Date" := TrackingSpecification."Warranty Date";
                ReservEntry1."Expiration Date" := TrackingSpecification."Expiration Date";
                ReservEntry1."New Serial No." := TrackingSpecification."New Serial No.";
                ReservEntry1."New Lot No." := TrackingSpecification."New Lot No.";
                ReservEntry1."New Expiration Date" := TrackingSpecification."New Expiration Date";
                ReservEntry1.MODIFY();
            UNTIL ReservEntry1.NEXT() = 0;
    end;

    local procedure SetQtyToHandleAndInvoice(TrackingSpecification: Record "Tracking Specification") OK: Boolean
    var
        ReservEntry1: Record "Reservation Entry";
        ReservationMgt: Codeunit "Reservation Management";
        TotalQtyToHandle: Decimal;
        TotalQtyToInvoice: Decimal;
        QtyAlreadyHandledToInvoice: Decimal;
        QtyToHandleThisLine: Decimal;
        QtyToInvoiceThisLine: Decimal;
    begin
        IF IsCorrection THEN
            EXIT;
        OK := FALSE;

        TotalQtyToHandle := TrackingSpecification."Qty. to Handle (Base)" * CurrentSignFactor;
        TotalQtyToInvoice := TrackingSpecification."Qty. to Invoice (Base)" * CurrentSignFactor;

        IF ABS(TotalQtyToHandle) > ABS(TotalQtyToInvoice) THEN
            QtyAlreadyHandledToInvoice := 0
        ELSE
            QtyAlreadyHandledToInvoice := TotalQtyToInvoice - TotalQtyToHandle;

        ReservEntry1.TRANSFERFIELDS(TrackingSpecification);
        ReservEntry1.SetPointerFilter();
        ReservEntry1.SETRANGE("Lot No.", ReservEntry1."Lot No.");
        ReservEntry1.SETRANGE("Serial No.", ReservEntry1."Serial No.");
        IF (TrackingSpecification."Lot No." <> '') OR
           (TrackingSpecification."Serial No." <> '')
        THEN BEGIN
            ItemTrackingMgt.SetPointerFilter(TrackingSpecification);
            TrackingSpecification.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
            TrackingSpecification.SETRANGE("Serial No.", TrackingSpecification."Serial No.");

            IF TrackingSpecification.FIND('-') THEN
                REPEAT
                    IF NOT TrackingSpecification.Correction THEN BEGIN
                        QtyToInvoiceThisLine :=
                          TrackingSpecification."Quantity Handled (Base)" - TrackingSpecification."Quantity Invoiced (Base)";
                        //IWEB.001 START
                        //IF ABS(QtyToInvoiceThisLine) > ABS(TotalQtyToInvoice) THEN
                        //  QtyToInvoiceThisLine := TotalQtyToInvoice;
                        ////IWEB.001 END
                        IF ABS(QtyToInvoiceThisLine) > ABS(QtyAlreadyHandledToInvoice) THEN BEGIN
                            QtyToInvoiceThisLine := QtyAlreadyHandledToInvoice;
                            QtyAlreadyHandledToInvoice := 0;
                        END ELSE
                            QtyAlreadyHandledToInvoice -= QtyToInvoiceThisLine;

                        IF TrackingSpecification."Qty. to Invoice (Base)" <> QtyToInvoiceThisLine THEN BEGIN
                            TrackingSpecification."Qty. to Invoice (Base)" := QtyToInvoiceThisLine;
                            TrackingSpecification.MODIFY();
                        END;

                        TotalQtyToInvoice -= QtyToInvoiceThisLine;
                    END;
                UNTIL (TrackingSpecification.NEXT() = 0);

            OK := ((TotalQtyToHandle = 0) AND (TotalQtyToInvoice = 0));
        END;

        IF TrackingSpecification."Lot No." <> '' THEN BEGIN
            FOR ReservEntry1."Reservation Status" := ReservEntry1."Reservation Status"::Reservation TO
                ReservEntry1."Reservation Status"::Prospect
            DO BEGIN
                ReservEntry1.SETRANGE("Reservation Status", ReservEntry1."Reservation Status");
                IF ReservEntry1.FIND('-') THEN
                    REPEAT
                        QtyToHandleThisLine := ReservEntry1."Quantity (Base)";
                        QtyToInvoiceThisLine := QtyToHandleThisLine;

                        //IWEB.001 START
                        //IF ABS(QtyToHandleThisLine) > ABS(TotalQtyToHandle) THEN
                        //  QtyToHandleThisLine := TotalQtyToHandle;
                        //IF ABS(QtyToInvoiceThisLine) > ABS(TotalQtyToInvoice) THEN
                        //  QtyToInvoiceThisLine := TotalQtyToInvoice;
                        //IWEB.001 END

                        IF (ReservEntry1."Qty. to Handle (Base)" <> QtyToHandleThisLine) OR
                           (ReservEntry1."Qty. to Invoice (Base)" <> QtyToInvoiceThisLine) AND NOT ReservEntry1.Correction
                        THEN BEGIN
                            ReservEntry1."Qty. to Handle (Base)" := QtyToHandleThisLine;
                            ReservEntry1."Qty. to Invoice (Base)" := QtyToInvoiceThisLine;
                            ReservEntry1.MODIFY();
                        END;

                        TotalQtyToHandle -= QtyToHandleThisLine;
                        TotalQtyToInvoice -= QtyToInvoiceThisLine;

                    UNTIL (ReservEntry1.NEXT() = 0);
            END;

            OK := ((TotalQtyToHandle = 0) AND (TotalQtyToInvoice = 0));
        END ELSE
            IF ReservEntry1.FIND('-') THEN
                IF (ReservEntry1."Qty. to Handle (Base)" <> TotalQtyToHandle) OR
                   (ReservEntry1."Qty. to Invoice (Base)" <> TotalQtyToInvoice) AND NOT ReservEntry1.Correction
                THEN BEGIN
                    ReservEntry1."Qty. to Handle (Base)" := TotalQtyToHandle;
                    ReservEntry1."Qty. to Invoice (Base)" := TotalQtyToInvoice;
                    ReservEntry1.MODIFY();
                END;
    end;

    local procedure CollectPostedTransferEntries(TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Used for collecting information about posted Transfer Shipments from the created Item Ledger Entries.
        IF TrackingSpecification."Source Type" <> DATABASE::"Transfer Line" THEN
            EXIT;

        ItemEntryRelation.SETCURRENTKEY("Order No.", "Order Line No.");
        ItemEntryRelation.SETRANGE("Order No.", TrackingSpecification."Source ID");
        ItemEntryRelation.SETRANGE("Order Line No.", TrackingSpecification."Source Ref. No.");

        CASE TrackingSpecification."Source Subtype" OF
            0: // Outbound
                ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Transfer Shipment Line");
            1: // Inbound
                ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Transfer Receipt Line");
        END;

        IF ItemEntryRelation.FIND('-') THEN
            REPEAT
                ItemLedgerEntry.GET(ItemEntryRelation."Item Entry No.");
                TempTrackingSpecification := TrackingSpecification;
                TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
                TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
                TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
                TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
                TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
                TempTrackingSpecification.InitQtyToShip();
                TempTrackingSpecification.INSERT();
            UNTIL ItemEntryRelation.NEXT() = 0;
    end;

    local procedure CollectPostedAssemblyEntries(TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        // Used for collecting information about posted Assembly Lines from the created Item Ledger Entries.
        IF (TrackingSpecification."Source Type" <> DATABASE::"Assembly Line") AND
           (TrackingSpecification."Source Type" <> DATABASE::"Assembly Header")
        THEN
            EXIT;

        ItemEntryRelation.SETCURRENTKEY("Order No.", "Order Line No.");
        ItemEntryRelation.SETRANGE("Order No.", TrackingSpecification."Source ID");
        ItemEntryRelation.SETRANGE("Order Line No.", TrackingSpecification."Source Ref. No.");
        IF TrackingSpecification."Source Type" = DATABASE::"Assembly Line" THEN
            ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Posted Assembly Line")
        ELSE
            ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Posted Assembly Header");

        IF ItemEntryRelation.FIND('-') THEN
            REPEAT
                ItemLedgerEntry.GET(ItemEntryRelation."Item Entry No.");
                TempTrackingSpecification := TrackingSpecification;
                TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
                TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
                TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
                TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
                TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
                TempTrackingSpecification.InitQtyToShip();
                TempTrackingSpecification.INSERT();
            UNTIL ItemEntryRelation.NEXT() = 0;
    end;

    local procedure CollectPostedOutputEntries(TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        BackwardFlushing: Boolean;
    begin
        // Used for collecting information about posted prod. order output from the created Item Ledger Entries.
        IF TrackingSpecification."Source Type" <> DATABASE::"Prod. Order Line" THEN
            EXIT;

        IF (TrackingSpecification."Source Type" = DATABASE::"Prod. Order Line") AND
           (TrackingSpecification."Source Subtype" = 3)
        THEN BEGIN
            ProdOrderRoutingLine.SETRANGE(Status, TrackingSpecification."Source Subtype");
            ProdOrderRoutingLine.SETRANGE("Prod. Order No.", TrackingSpecification."Source ID");
            ProdOrderRoutingLine.SETRANGE("Routing Reference No.", TrackingSpecification."Source Prod. Order Line");
            IF ProdOrderRoutingLine.FINDLAST() THEN
                BackwardFlushing :=
                  ProdOrderRoutingLine."Flushing Method" = ProdOrderRoutingLine."Flushing Method"::Backward;
        END;

        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Order No.", TrackingSpecification."Source ID");
        ItemLedgerEntry.SETRANGE("Order Line No.", TrackingSpecification."Source Prod. Order Line");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);

        IF ItemLedgerEntry.FIND('-') THEN
            REPEAT
                TempTrackingSpecification := TrackingSpecification;
                TempTrackingSpecification."Entry No." := ItemLedgerEntry."Entry No.";
                TempTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
                TempTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
                TempTrackingSpecification."Lot No." := ItemLedgerEntry."Lot No.";
                TempTrackingSpecification."Quantity (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Handled (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Quantity Invoiced (Base)" := ItemLedgerEntry.Quantity;
                TempTrackingSpecification."Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
                TempTrackingSpecification.InitQtyToShip();
                TempTrackingSpecification.INSERT();

                IF BackwardFlushing THEN BEGIN
                    SourceQuantityArray[1] += ItemLedgerEntry.Quantity;
                    SourceQuantityArray[2] += ItemLedgerEntry.Quantity;
                    SourceQuantityArray[3] += ItemLedgerEntry.Quantity;
                END;

            UNTIL ItemLedgerEntry.NEXT() = 0;
    end;

    local procedure ZeroLineExists() OK: Boolean
    var
        xTrackingSpec: Record "Tracking Specification";
    begin
        IF (Rec."Quantity (Base)" <> 0) OR (Rec."Serial No." <> '') OR (Rec."Lot No." <> '') THEN
            EXIT(FALSE);
        xTrackingSpec.COPY(Rec);
        Rec.RESET();
        Rec.SETRANGE("Quantity (Base)", 0);
        Rec.SETRANGE("Serial No.", '');
        Rec.SETRANGE("Lot No.", '');
        OK := NOT Rec.ISEMPTY;
        Rec.COPY(xTrackingSpec);
    end;

    local procedure AssignSerialNo()
    var
        EnterQuantityToCreate: Page "Enter Quantity to Create";
        QtyToCreate: Decimal;
        QtyToCreateInt: Integer;
        CreateLotNo: Boolean;
    begin
        IF ZeroLineExists() THEN
            Rec.DELETE();

        QtyToCreate := UndefinedQtyArray[1] * QtySignFactor();
        IF QtyToCreate < 0 THEN
            QtyToCreate := 0;

        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008Lbl);

        QtyToCreateInt := QtyToCreate;

        CLEAR(EnterQuantityToCreate);
        EnterQuantityToCreate.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, FALSE);
        IF EnterQuantityToCreate.RUNMODAL() = ACTION::OK THEN BEGIN
            EnterQuantityToCreate.GetFields(QtyToCreateInt, CreateLotNo);
            AssignSerialNoBatch(QtyToCreateInt, CreateLotNo);
        END;
    end;

    local procedure AssignSerialNoBatch(QtyToCreate: Integer; CreateLotNo: Boolean)
    var
        i: Integer;
    begin
        IF QtyToCreate <= 0 THEN
            ERROR(Text009Lbl);
        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008Lbl);

        GetItem(Rec."Item No.");

        IF CreateLotNo THEN BEGIN
            Rec.TESTFIELD("Lot No.", '');
            Item.TESTFIELD("Lot Nos.");
            Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE(), TRUE));
        END;

        Item.TESTFIELD("Serial Nos.");
        ItemTrackingDataCollection.SetSkipLot(TRUE);
        FOR i := 1 TO QtyToCreate DO BEGIN
            Rec.VALIDATE("Quantity Handled (Base)", 0);
            Rec.VALIDATE("Quantity Invoiced (Base)", 0);
            Rec.VALIDATE("Serial No.", NoSeriesMgt.GetNextNo(Item."Serial Nos.", WORKDATE(), TRUE));
            Rec.VALIDATE("Quantity (Base)", QtySignFactor());
            Rec."Entry No." := NextEntryNo();
            IF TestTempSpecificationExists() THEN
                ERROR('');
            Rec.INSERT();
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.INSERT();
            IF i = QtyToCreate THEN
                ItemTrackingDataCollection.SetSkipLot(FALSE);
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
        END;
        CalculateSums();
    end;

    local procedure AssignLotNo()
    var
        QtyToCreate: Decimal;
    begin
        IF ZeroLineExists() THEN
            Rec.DELETE();

        ItemRec.GET(Rec."Item No.");
        IF ItemRec."Item Type" <> ItemRec."Item Type"::"Strip Rolls" THEN BEGIN

            IF (SourceQuantityArray[1] * UndefinedQtyArray[1] <= 0) OR
               (ABS(SourceQuantityArray[1]) < ABS(UndefinedQtyArray[1]))
            THEN
                QtyToCreate := 0
            ELSE
                QtyToCreate := UndefinedQtyArray[1];

            GetItem(Rec."Item No.");

            Item.TESTFIELD("Lot Nos.");
            Rec.VALIDATE("Quantity Handled (Base)", 0);
            Rec.VALIDATE("Quantity Invoiced (Base)", 0);

            //SCS1.00 START
            IF (Rec."Source ID" = 'OUTPUT') AND (Rec."Source Batch Name" = 'DEFAULT') THEN
                Rec."Lot No." := CustomAssignLotNo()
            ELSE
                //SCS1.00 END
                Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE(), TRUE));
            Rec."Qty. per Unit of Measure" := QtyPerUOM;
            Rec.VALIDATE("Quantity (Base)", QtyToCreate);
            Rec."Entry No." := NextEntryNo();
            TestTempSpecificationExists();
            Rec.INSERT();
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
            CalculateSums();

        END ELSE
            IF (Rec."Source ID" = 'OUTPUT') AND (Rec."Source Batch Name" = 'DEFAULT') THEN
                CustomAssignSlit()
            ELSE
                Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE(), TRUE));
    end;

    local procedure CreateCustomizedSN()
    var
        EnterCustomizedSN: Page "Enter Customized SN";
        QtyToCreate: Decimal;
        QtyToCreateInt: Integer;
        Increment: Integer;
        CreateLotNo: Boolean;
        CustomizedSN: Code[20];
    begin
        IF ZeroLineExists() THEN
            Rec.DELETE();

        QtyToCreate := UndefinedQtyArray[1] * QtySignFactor();
        IF QtyToCreate < 0 THEN
            QtyToCreate := 0;

        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008Lbl);

        QtyToCreateInt := QtyToCreate;

        CLEAR(EnterCustomizedSN);
        EnterCustomizedSN.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, FALSE);
        IF EnterCustomizedSN.RUNMODAL() = ACTION::OK THEN BEGIN
            EnterCustomizedSN.GetFields(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment);
            CreateCustomizedSNBatch(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment);
        END;
        CalculateSums();
    end;

    local procedure CreateCustomizedSNBatch(QtyToCreate: Decimal; CreateLotNo: Boolean; CustomizedSN: Code[20]; Increment: Integer)
    var
        i: Integer;
        Counter: Integer;
    begin
        IF INCSTR(CustomizedSN) = '' THEN
            ERROR(Text013Lbl, CustomizedSN);
        NoSeriesMgt.TestManual(Item."Serial Nos.");

        IF QtyToCreate <= 0 THEN
            ERROR(Text009Lbl);
        IF QtyToCreate MOD 1 <> 0 THEN
            ERROR(Text008Lbl);

        IF CreateLotNo THEN BEGIN
            Rec.TESTFIELD("Lot No.", '');
            Item.TESTFIELD("Lot Nos.");
            Rec.VALIDATE("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE(), TRUE));
        END;

        FOR i := 1 TO QtyToCreate DO BEGIN
            Rec.VALIDATE("Quantity Handled (Base)", 0);
            Rec.VALIDATE("Quantity Invoiced (Base)", 0);
            Rec.VALIDATE("Serial No.", CustomizedSN);
            Rec.VALIDATE("Quantity (Base)", QtySignFactor());
            Rec."Entry No." := NextEntryNo();
            IF TestTempSpecificationExists() THEN
                ERROR('');
            Rec.INSERT();
            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.INSERT();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
            IF i < QtyToCreate THEN BEGIN
                Counter := Increment;
                REPEAT
                    CustomizedSN := INCSTR(CustomizedSN);
                    Counter := Counter - 1;
                UNTIL Counter <= 0;
            END;
        END;
        CalculateSums();
    end;

    local procedure TestTempSpecificationExists() Exists: Boolean
    var
        TempSpecification: Record "Tracking Specification" temporary;
        // InputDialog: DotNet;
        InputQty: Decimal;
        InputQtytxt: Text[30];
        InputDialogBox: Page "Input Dialogbox";
    begin
        TempSpecification.COPY(Rec);
        Rec.SETCURRENTKEY("Lot No.", "Serial No.");
        Rec.SETRANGE("Serial No.", Rec."Serial No.");
        IF Rec."Serial No." = '' THEN
            Rec.SETRANGE("Lot No.", Rec."Lot No.");
        Rec.SETFILTER("Entry No.", '<>%1', Rec."Entry No.");
        Rec.SETRANGE("Buffer Status", 0);
        //IWEB.001 START
        Exists := FALSE;
        //IF Exists AND CurrentFormIsOpen THEN
        //IF "Serial No." = '' THEN
        //scssm01
        //IWEB.001 START
        //IF CONFIRM(STRSUBSTNO(Text50000,"Item No.","Lot No."))THEN BEGIN
        //SETCURRENTKEY("Lot No.","Serial No.");
        //SETRANGE("Item No.","Item No.");
        //SETRANGE("Lot No.","Lot No.");
        //IF FINDFIRST THEN BEGIN
        //Window.OPEN(Text50001);
        //Window.INPUT(1,InputQty);
        //InputQtytxt := InputDialog.InputBox('Get Quantity','Quantity:','',100,100);
        //IF EVALUATE(InputQty,InputQtytxt) THEN;
        //IF InputDialogBox.RUNMODAL = ACTION::OK THEN BEGIN
        //InputQty := InputDialogBox.GetQuantity;
        //END;
        //VALIDATE("Quantity (Base)", "Quantity (Base)" + InputQty);
        //MODIFY;
        //RESET;
        //END;
        //END
        //scssm01
        //ELSE
        //MESSAGE(
        //Text012,
        //"Serial No.");
        //IWEB.001 END
        Rec.COPY(TempSpecification);
    end;

    local procedure QtySignFactor(): Integer
    begin
        IF SourceQuantityArray[1] < 0 THEN
            EXIT(-1);

        EXIT(1)
    end;

    procedure RegisterItemTrackingLines(SourceSpecification: Record "Tracking Specification"; AvailabilityDate: Date; var TempSpecification: Record "Tracking Specification" temporary)
    begin
        SourceSpecification.TESTFIELD("Source Type"); // Check if source has been set.
        IF NOT CalledFromSynchWhseItemTrkg THEN
            TempSpecification.RESET();
        IF NOT TempSpecification.FIND('-') THEN
            EXIT;

        IsCorrection := SourceSpecification.Correction;
        ExcludePostedEntries := TRUE;
        SetSource(SourceSpecification, AvailabilityDate);
        Rec.RESET();
        Rec.SETCURRENTKEY("Lot No.", "Serial No.");

        REPEAT
            Rec.SETRANGE("Lot No.", TempSpecification."Lot No.");
            Rec.SETRANGE("Serial No.", TempSpecification."Serial No.");
            IF Rec.FIND('-') THEN BEGIN
                IF IsCorrection THEN BEGIN
                    Rec."Quantity (Base)" :=
                      Rec."Quantity (Base)" + TempSpecification."Quantity (Base)";
                    Rec."Qty. to Handle (Base)" :=
                      Rec."Qty. to Handle (Base)" + TempSpecification."Qty. to Handle (Base)";
                    Rec."Qty. to Invoice (Base)" :=
                      Rec."Qty. to Invoice (Base)" + TempSpecification."Qty. to Invoice (Base)";
                END ELSE
                    Rec.VALIDATE("Quantity (Base)",
                      Rec."Quantity (Base)" + TempSpecification."Quantity (Base)");
                Rec.MODIFY();
            END ELSE BEGIN
                Rec.TRANSFERFIELDS(SourceSpecification);
                Rec."Serial No." := TempSpecification."Serial No.";
                Rec."Lot No." := TempSpecification."Lot No.";
                Rec."Warranty Date" := TempSpecification."Warranty Date";
                Rec."Expiration Date" := TempSpecification."Expiration Date";
                IF FormRunMode = FormRunMode::Reclass THEN BEGIN
                    Rec."New Serial No." := TempSpecification."New Serial No.";
                    Rec."New Lot No." := TempSpecification."New Lot No.";
                    Rec."New Expiration Date" := TempSpecification."New Expiration Date"
                END;
                Rec.VALIDATE("Quantity (Base)", TempSpecification."Quantity (Base)");
                Rec."Entry No." := NextEntryNo();
                Rec.INSERT();
            END;
        UNTIL TempSpecification.NEXT() = 0;
        Rec.RESET();
        IF Rec.FIND('-') THEN
            REPEAT
                CheckLine(Rec);
            UNTIL Rec.NEXT() = 0;

        Rec.SETRANGE("Lot No.", SourceSpecification."Lot No.");
        Rec.SETRANGE("Serial No.", SourceSpecification."Serial No.");

        CalculateSums();
        IF UpdateUndefinedQty() THEN
            WriteToDatabase
        ELSE
            ERROR(Text014Lbl, TotalItemTrackingLine."Quantity (Base)",
              LOWERCASE(TempReservEntry.TextCaption()), SourceQuantityArray[1]);

        // Copy to inbound part of transfer
        IF FormRunMode = FormRunMode::Transfer THEN
            SynchronizeLinkedSources('');
    end;


    procedure SynchronizeLinkedSources(DialogText: Text[250]): Boolean
    begin
        IF CurrentSourceRowID = '' THEN
            EXIT(FALSE);
        IF SecondSourceRowID = '' THEN
            EXIT(FALSE);

        ItemTrackingMgt.SynchronizeItemTracking(CurrentSourceRowID, SecondSourceRowID, DialogText);
        EXIT(TRUE);
    end;


    procedure SetBlockCommit(NewBlockCommit: Boolean)
    begin
        BlockCommit := NewBlockCommit;
    end;


    procedure TempItemTrackingDef(NewTrackingSpecification: Record "Tracking Specification")
    begin
        Rec := NewTrackingSpecification;
        Rec."Entry No." := NextEntryNo();
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists()) THEN
            IF NOT TestTempSpecificationExists() THEN
                Rec.INSERT()
            ELSE
                ModifyTrackingSpecification(NewTrackingSpecification);
        WriteToDatabase();
    end;


    procedure SetCalledFromSynchWhseItemTrkg(CalledFromSynchWhseItemTrkg2: Boolean)
    begin
        CalledFromSynchWhseItemTrkg := CalledFromSynchWhseItemTrkg2;
    end;


    procedure ModifyTrackingSpecification(NewTrackingSpecification: Record "Tracking Specification")
    var
        CrntTempTrackingSpec: Record "Tracking Specification" temporary;
    begin
        CrntTempTrackingSpec.COPY(Rec);
        Rec.SETCURRENTKEY("Lot No.", "Serial No.");
        Rec.SETRANGE("Lot No.", NewTrackingSpecification."Lot No.");
        Rec.SETRANGE("Serial No.", NewTrackingSpecification."Serial No.");
        Rec.SETFILTER("Entry No.", '<>%1', NewTrackingSpecification."Entry No.");
        Rec.SETRANGE("Buffer Status", 0);
        IF Rec.FIND('-') THEN BEGIN
            Rec.VALIDATE("Quantity (Base)",
              Rec."Quantity (Base)" + NewTrackingSpecification."Quantity (Base)");
            Rec.MODIFY();
        END;
        Rec.COPY(CrntTempTrackingSpec);
    end;

    local procedure UpdateExpDateColor()
    begin
        //IF ("Buffer Status2" = "Buffer Status2"::"ExpDate blocked") OR (CurrentSignFactor < 0) THEN;
    end;

    local procedure UpdateExpDateEditable()
    begin
        "Expiration DateEditable" :=
          NOT ((Rec."Buffer Status2" = Rec."Buffer Status2"::"ExpDate blocked") OR (CurrentSignFactor < 0));
    end;


    procedure LookupAvailable(LookupMode: Option "Serial No.","Lot No.")
    begin
        Rec."Bin Code" := ForBinCode;
        ItemTrackingDataCollection.LookupTrackingAvailability(Rec, LookupMode);
        Rec."Bin Code" := '';
        CurrPage.UPDATE();
    end;

    procedure F6LookupAvailable()
    begin
        IF SNAvailabilityActive THEN
            LookupAvailable(0);
        IF LotAvailabilityActive THEN
            LookupAvailable(1);
    end;

    procedure LotSnAvailable(var TrackingSpecification: Record 336; LookupMode: Option "Serial No.","Lot No."): Boolean
    begin
        EXIT(ItemTrackingDataCollection.TrackingAvailable(TrackingSpecification, LookupMode));
    end;

    procedure SelectEntries()
    var
        xTrackingSpec: Record "Tracking Specification";
        MaxQuantity: Decimal;
    begin
        xTrackingSpec.COPYFILTERS(Rec);
        MaxQuantity := UndefinedQtyArray[1];
        IF MaxQuantity * CurrentSignFactor > 0 THEN
            MaxQuantity := 0;
        Rec."Bin Code" := ForBinCode;
        ItemTrackingDataCollection.SelectMultipleTrackingNo(Rec, MaxQuantity, CurrentSignFactor);
        Rec."Bin Code" := '';
        IF Rec.FINDSET() THEN
            REPEAT
                CASE Rec."Buffer Status" OF
                    Rec."Buffer Status"::MODIFY:
                        BEGIN
                            IF TempItemTrackLineModify.GET(Rec."Entry No.") THEN
                                TempItemTrackLineModify.DELETE();
                            IF TempItemTrackLineInsert.GET(Rec."Entry No.") THEN BEGIN
                                TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                                TempItemTrackLineInsert.MODIFY();
                            END ELSE BEGIN
                                TempItemTrackLineModify.TRANSFERFIELDS(Rec);
                                TempItemTrackLineModify.INSERT();
                            END;
                        END;
                    Rec."Buffer Status"::INSERT:
                        BEGIN
                            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
                            TempItemTrackLineInsert.INSERT();
                        END;
                END;
                Rec."Buffer Status" := 0;
                Rec.MODIFY();
            UNTIL Rec.NEXT() = 0;
        LastEntryNo := Rec."Entry No.";
        CalculateSums();
        UpdateUndefinedQty();
        Rec.COPYFILTERS(xTrackingSpec);
        CurrPage.UPDATE(FALSE);
    end;

    procedure ReserveItemTrackingLine()
    var
        LateBindingMgt: Codeunit "Late Binding Management";
    begin
        LateBindingMgt.ReserveItemTrackingLine(Rec);
    end;


    procedure ReestablishReservations()
    var
        LateBindingMgt: Codeunit "Late Binding Management";
    begin
        IF TempItemTrackLineReserv.FINDSET() THEN
            REPEAT
                LateBindingMgt.ReserveItemTrackingLine(TempItemTrackLineReserv, 0, TempItemTrackLineReserv."Quantity (Base)");
                SetQtyToHandleAndInvoice(TempItemTrackLineReserv);
            UNTIL TempItemTrackLineReserv.NEXT() = 0;
        TempItemTrackLineReserv.DELETEALL();
    end;

    procedure SetInbound(NewInbound: Boolean)
    begin
        InboundIsSet := TRUE;
        Inbound := NewInbound;
    end;

    procedure SetPick(IsPick2: Boolean)
    begin
        IsPick := IsPick2;
    end;

    local procedure SerialNoOnAfterValidate()
    begin
        UpdateExpDateEditable();
        CurrPage.UPDATE();
    end;

    procedure LotNoOnAfterValidate()
    begin
        UpdateExpDateEditable();
        CurrPage.UPDATE();
    end;

    local procedure QuantityBaseOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure QuantityBaseOnValidate()
    begin
        IF NOT CheckLine(Rec) THEN
            EXIT;
    end;

    local procedure QtytoHandleBaseOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure QtytoInvoiceBaseOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ExpirationDateOnFormat()
    begin
        UpdateExpDateColor();
    end;

    local procedure ChangeAlreadyNonSpecificReservations(var TempTrackingSpecification: Record "Tracking Specification" temporary; QuantityBase: Decimal): Boolean
    var
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        RemainingQtyBase: Decimal;
        EntryNo: Integer;
    begin
        // Checks if there is already a non specific reservation pointing on the chosen SN/LN,
        // and makes the reservation specific in that case
        TempTrackingSpecification.reset();
        IF ReservEntry.Positive THEN
            EXIT(FALSE);

        IF QuantityBase <= 0 THEN
            EXIT(FALSE);

        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Reservation);
        ReservEntry.SETRANGE("Source Type", DATABASE::"Item Ledger Entry");
        ReservEntry.SETRANGE("Item No.", TempTrackingSpecification."Item No.");
        ReservEntry.SETRANGE("Serial No.", TempTrackingSpecification."Serial No.");
        ReservEntry.SETRANGE("Lot No.", TempTrackingSpecification."Lot No.");
        ReservEntry.SETRANGE(Positive, False);

        IF ReservEntry.FINDSET() THEN BEGIN
            IF Rec."Serial No." <> '' THEN BEGIN
                IF CompareToReservationEntry(TempTrackingSpecification, ReservEntry2, ReservEntry."Entry No.", ReservEntry.Positive) THEN BEGIN
                    ModifyReservationEntry(ReservEntry2, Rec."Serial No.", Rec."Lot No.", 0);
                    EXIT(TRUE);
                END;
                EXIT(FALSE);
            END;

            IF ReservEntry."Lot No." <> '' THEN BEGIN
                RemainingQtyBase := QuantityBase;

                REPEAT
                    IF CompareToReservationEntry(TempTrackingSpecification, ReservEntry2, ReservEntry."Entry No.", ReservEntry.Positive) THEN BEGIN
                        IF ReservEntry."Quantity (Base)" = RemainingQtyBase THEN BEGIN
                            ModifyReservationEntry(ReservEntry2, '', Rec."Lot No.", 0);
                            EXIT(TRUE);
                        END;

                        IF ReservEntry."Quantity (Base)" > RemainingQtyBase THEN BEGIN
                            // Modify existing reservation pair, and create new reservation pair for the quantity exceeding the needed quantity
                            EntryNo := TransferToNewReservation(ReservEntry, ReservEntry."Quantity (Base)" - RemainingQtyBase, 0);
                            TransferToNewReservation(ReservEntry2, ReservEntry."Quantity (Base)" - RemainingQtyBase, EntryNo);

                            ReservEntry.VALIDATE("Quantity (Base)", RemainingQtyBase);
                            ReservEntry.MODIFY();

                            ModifyReservationEntry(ReservEntry2, '', Rec."Lot No.", -RemainingQtyBase);
                            EXIT(TRUE);
                        END;

                        IF ReservEntry."Quantity (Base)" < RemainingQtyBase THEN BEGIN
                            ModifyReservationEntry(ReservEntry2, '', Rec."Lot No.", 0);
                            RemainingQtyBase -= ReservEntry."Quantity (Base)";
                        END;
                    END;
                UNTIL (ReservEntry.NEXT() = 0) OR (RemainingQtyBase = 0);

                IF RemainingQtyBase > 0 THEN BEGIN
                    Rec.VALIDATE(Rec."Quantity (Base)", RemainingQtyBase);
                    Rec.MODIFY();
                END;

                EXIT(FALSE);
            END;
        END;
    END;


    local procedure TransferToNewReservation(ReservEntry: Record "Reservation Entry"; QtyBase: Decimal; EntryNo: Integer): Integer
    var
        ReservEntry2: Record "Reservation Entry";
        SignFactor: Integer;
    begin
        IF ReservEntry.Positive THEN
            SignFactor := 1
        ELSE
            SignFactor := -1;

        ReservEntry2.INIT();
        ReservEntry2.TRANSFERFIELDS(ReservEntry, FALSE);
        ReservEntry2.VALIDATE("Quantity (Base)", SignFactor * QtyBase);
        IF EntryNo <> 0 THEN
            ReservEntry2."Entry No." := EntryNo;
        ReservEntry2.Positive := ReservEntry.Positive;
        ReservEntry2.INSERT();

        EXIT(ReservEntry2."Entry No.");
    end;

    procedure CompareToReservationEntry(TempTrackingSpecification: Record "Tracking Specification" temporary; var ReservEntry: Record "Reservation Entry"; EntryNo: Integer; Pos: Boolean): Boolean
    begin
        TempTrackingSpecification.reset();
        ReservEntry.GET(EntryNo, NOT Pos);
        IF (ReservEntry."Source ID" = TempTrackingSpecification."Source ID") AND
           (ReservEntry."Source Ref. No." = TempTrackingSpecification."Source Ref. No.") AND
           (ReservEntry."Source Type" = TempTrackingSpecification."Source Type") AND
           (ReservEntry."Source Subtype" = TempTrackingSpecification."Source Subtype") AND
           (ReservEntry."Source Prod. Order Line" = TempTrackingSpecification."Source Prod. Order Line") AND
           (ReservEntry."Serial No." = '') AND
           (ReservEntry."Lot No." = '')
        THEN
            EXIT(TRUE);

        EXIT(FALSE);
    END;


    procedure ModifyReservationEntry(var ReservEntry: Record "Reservation Entry"; SerialNo: Code[20]; LotNo: Code[20]; QuantityBase: Decimal)
    begin
        ReservEntry.VALIDATE("Serial No.", SerialNo);
        ReservEntry.VALIDATE("Lot No.", LotNo);
        ReservEntry.UpdateItemTracking();
        IF QuantityBase <> 0 THEN
            ReservEntry.VALIDATE("Quantity (Base)", QuantityBase);
        ReservEntry.MODIFY();
    end;

    local procedure TempRecValid()
    begin
        IF NOT TempRecIsValid() THEN
            ERROR(Text007Lbl);
    end;

    procedure CustomAssignLotNo(): Code[20]
    var
        TempItem: Record Item;
        JulianDate: Integer;
        CurrentYear: Code[4];
        CustomLotNo: Code[20];
        ItemJnlLine: Record "Item Journal Line";
        txtBeginningDate: Text[30];
        BeginningDate: Date;
        Length: Integer;
        txtJulianDate: Text[30];
    begin
        //SCS1.00 New function to Customly assign Lot No to certain types of items
        TempItem.GET(Rec."Item No.");

        CustomLotNo := '';

        ItemJnlLine.RESET();
        ItemJnlLine.SETRANGE("Journal Template Name", 'OUTPUT');
        ItemJnlLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        ItemJnlLine.SETRANGE("Line No.", Rec."Source Ref. No.");
        IF ItemJnlLine.FINDFIRST() THEN BEGIN
            IF (TempItem."Item Type" = TempItem."Item Type"::"Pull n Pak") OR (TempItem."Item Type" = TempItem."Item Type"::"Hippo Sak") THEN BEGIN
                IF ItemJnlLine."Posting Date" = 0D THEN
                    ERROR('Posting Date needs to be setup on Output Journal before assigning the Lot No.');
                IF ItemJnlLine."Machine Center Code" = '' THEN
                    ERROR('Machine Center Code needs to be setup on Output Journal before assigning the Lot No.');
                IF ItemJnlLine.Shift = '' THEN
                    ERROR('Shift needs to be setup on Output Journal before assigning the Lot No.');

                CurrentYear := FORMAT(DATE2DMY(ItemJnlLine."Posting Date", 3));
                CurrentYear := COPYSTR(CurrentYear, 3, 2);
                txtBeginningDate := '0101' + CurrentYear;
                IF EVALUATE(BeginningDate, txtBeginningDate) THEN;
                JulianDate := 1 + (ItemJnlLine."Posting Date" - BeginningDate);
                txtJulianDate := FORMAT(JulianDate);
                Length := STRLEN(txtJulianDate);
                IF Length = 1 THEN
                    txtJulianDate := '00' + txtJulianDate
                ELSE
                    IF Length = 2 THEN
                        txtJulianDate := '0' + txtJulianDate
                    ELSE
                        IF Length = 3 THEN
                            txtJulianDate := txtJulianDate;
                CustomLotNo := txtJulianDate + CurrentYear + ItemJnlLine."Machine Center Code" + ItemJnlLine.Shift;
            END ELSE BEGIN
                CustomLotNo := NoSeriesMgt.GetNextNo(Item."Lot Nos.", WORKDATE(), TRUE);
                CustomLotNo := ItemJnlLine."Machine Center Code" + CustomLotNo;
            END;
        END;

        EXIT(CustomLotNo);
    end;

    procedure CustomAssignSlit()
    begin
        //SCS1.00 START of new function
        Rec.TESTFIELD("Master Lot No.");
        IF Rec."No. Of Slits" = 0 THEN
            ERROR('No. of Slits cannot be 0.');

        FOR i := 1 TO Rec."No. Of Slits" DO BEGIN

            IF ZeroLineExists() THEN
                Rec.DELETE();

            GetItem(Rec."Item No.");
            Item.TESTFIELD("Lot Nos.");

            IF i = 1 THEN
                SlitNo := Rec."Master Lot No." + 'A'
            ELSE
                IF i = 2 THEN
                    SlitNo := Rec."Master Lot No." + 'B'
                ELSE
                    IF i = 3 THEN
                        SlitNo := Rec."Master Lot No." + 'C'
                    ELSE
                        IF i = 4 THEN
                            SlitNo := Rec."Master Lot No." + 'D'
                        ELSE
                            IF i = 5 THEN
                                SlitNo := Rec."Master Lot No." + 'E'
                            ELSE
                                IF i = 6 THEN
                                    SlitNo := Rec."Master Lot No." + 'F'
                                ELSE
                                    IF i = 7 THEN
                                        SlitNo := Rec."Master Lot No." + 'G'
                                    ELSE
                                        IF i = 8 THEN
                                            SlitNo := Rec."Master Lot No." + 'H'
                                        ELSE
                                            IF i = 9 THEN
                                                SlitNo := Rec."Master Lot No." + 'I'
                                            ELSE
                                                IF i = 10 THEN
                                                    SlitNo := Rec."Master Lot No." + 'J'
                                                ELSE
                                                    IF i = 11 THEN
                                                        SlitNo := Rec."Master Lot No." + 'K'
                                                    ELSE
                                                        IF i = 12 THEN
                                                            SlitNo := Rec."Master Lot No." + 'L'
                                                        ELSE
                                                            IF i = 13 THEN
                                                                SlitNo := Rec."Master Lot No." + 'M'
                                                            ELSE
                                                                IF i = 14 THEN
                                                                    SlitNo := Rec."Master Lot No." + 'N'
                                                                ELSE
                                                                    IF i = 15 THEN
                                                                        SlitNo := Rec."Master Lot No." + 'O'
                                                                    ELSE
                                                                        IF i = 16 THEN
                                                                            SlitNo := Rec."Master Lot No." + 'P'
                                                                        ELSE
                                                                            IF i = 17 THEN
                                                                                SlitNo := Rec."Master Lot No." + 'Q'
                                                                            ELSE
                                                                                IF i = 18 THEN
                                                                                    SlitNo := Rec."Master Lot No." + 'R'
                                                                                ELSE
                                                                                    IF i = 19 THEN
                                                                                        SlitNo := Rec."Master Lot No." + 'S'
                                                                                    ELSE
                                                                                        IF i = 20 THEN
                                                                                            SlitNo := Rec."Master Lot No." + 'T'
                                                                                        ELSE
                                                                                            IF i = 21 THEN
                                                                                                SlitNo := Rec."Master Lot No." + 'U'
                                                                                            ELSE
                                                                                                IF i = 22 THEN
                                                                                                    SlitNo := Rec."Master Lot No." + 'V'
                                                                                                ELSE
                                                                                                    IF i = 23 THEN
                                                                                                        SlitNo := Rec."Master Lot No." + 'W'
                                                                                                    ELSE
                                                                                                        IF i = 24 THEN
                                                                                                            SlitNo := Rec."Master Lot No." + 'X'
                                                                                                        ELSE
                                                                                                            IF i = 25 THEN
                                                                                                                SlitNo := Rec."Master Lot No." + 'Y'
                                                                                                            ELSE
                                                                                                                IF i = 26 THEN
                                                                                                                    SlitNo := Rec."Master Lot No." + 'Z';

            Rec."Lot No." := SlitNo;
            Rec."Qty. per Unit of Measure" := QtyPerUOM;
            Rec."Entry No." := NextEntryNo();
            TestTempSpecificationExists();
            Rec.INSERT();

            TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
            TempItemTrackLineInsert.INSERT();

            CalculateSums();
        END;
    end;

    procedure "<SSC56 Functions>"()
    begin
    end;

    procedure SetStorageBinsVisible(IsVisible: Boolean)
    begin
        StorageBinsVisible := IsVisible;
    end;
}

