codeunit 50210 "CP EventSubscriber"
{
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeSetSourceSpec', '', false, false)]
    local procedure OnBeforeSetSourceSpec(var TrackingSpecification: Record "Tracking Specification"; var ReservationEntry: Record "Reservation Entry"; var ExcludePostedEntries: Boolean)
    var
        UserSetup: Record "User Setup";
        TransLine: Record "Transfer Line";
        ItemTrackingInvoice: codeunit "Item Tracking Invoice";
        ItemTrackingMiniForm: Page "Mini Screen - Item Track Lines";
        ItemTrackingForm: Page "Item Tracking Lines";
        Direction: Option Outbound,Inbound;
        AvalabilityDate: Date;

    begin
        //>>SSC56
        UserSetup.GET(USERID);
        IF UserSetup."Handheld User" THEN BEGIN
            ItemTrackingMiniForm.SetSource(TrackingSpecification, AvalabilityDate);
            ItemTrackingMiniForm.SetInbound(TransLine.IsInbound());
            ItemTrackingMiniForm.SetStorageBinsVisible(Direction = Direction::Inbound);
            ItemTrackingMiniForm.RUNMODAL();
        END ELSE BEGIN
            //<<SSC56
            ItemTrackingForm.SetSourceSpec(TrackingSpecification, AvalabilityDate);
            ItemTrackingForm.SetInbound(TransLine.IsInbound());
            //>>SSC56
            ItemTrackingInvoice.SetStorageBinsVisible(Direction = Direction::Inbound);
            //<<SSC56
            ItemTrackingForm.RUNMODAL();
            //>>SSC56
        END;
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Line-Reserve", 'OnCallItemTrackingOnBeforeItemTrackingLinesRunModal', '', false, false)]
    local procedure OnCallItemTrackingOnBeforeItemTrackingLinesRunModal(var TransLine: REcord "Transfer Line"; var ItemTrackingLines: Page "Item Tracking Lines")
    var
        ItemTracking: Codeunit "Item Tracking Invoice";
        Direction: Option Outbound,Inbound;

    begin
        //>>SSC56
        ItemTracking.SetStorageBinsVisible(Direction = Direction::Inbound);
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line-Reserve", 'OnBeforeCallItemTracking', '', false, false)]
    local procedure OnBeforeCallItemTracking(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        TrackingSpecification: Record "Tracking Specification";
        UserSetup: Record "User Setup";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemTrackingMiniForm: Page "Mini Screen - Item Track Lines";
        ItemTrackingForm: Page "Item Tracking Lines";
    begin
        TrackingSpecification.InitFromSalesLine(SalesLine);
        //>>SSC56
        UserSetup.GET(USERID);
        IF UserSetup."Handheld User" THEN BEGIN
            IF ((SalesLine."Document Type" = SalesLine."Document Type"::Invoice) AND
                (SalesLine."Shipment No." <> '')) OR
               ((SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") AND
                (SalesLine."Return Receipt No." <> ''))
            THEN
                ItemTrackingMiniForm.SetFormRunMode(2); // Combined shipment/receipt
            IF SalesLine."Drop Shipment" THEN BEGIN
                ItemTrackingMiniForm.SetFormRunMode(3); // Drop Shipment
                IF SalesLine."Purchase Order No." <> '' THEN
                    ItemTrackingMiniForm.SetSecondSourceRowID(ItemTrackingMgt.ComposeRowID(DATABASE::"Purchase Line",
                        1, SalesLine."Purchase Order No.", '', 0, SalesLine."Purch. Order Line No."));
            END;
            ItemTrackingMiniForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
            ItemTrackingMiniForm.SetInbound(SalesLine.IsInbound());
            ItemTrackingMiniForm.RUNMODAL();
        END ELSE BEGIN
            //<<SSC56
            IF ((SalesLine."Document Type" = SalesLine."Document Type"::Invoice) AND
                (SalesLine."Shipment No." <> '')) OR
               ((SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") AND
                (SalesLine."Return Receipt No." <> ''))
            THEN
                ItemTrackingMiniForm.SetFormRunMode(2); // Combined shipment/receipt
            IF SalesLine."Drop Shipment" THEN BEGIN
                ItemTrackingMiniForm.SetFormRunMode(3); // Drop Shipment
                IF SalesLine."Purchase Order No." <> '' THEN
                    ItemTrackingForm.SetSecondSourceRowID(ItemTrackingMgt.ComposeRowID(DATABASE::"Purchase Line",
                        1, SalesLine."Purchase Order No.", '', 0, SalesLine."Purch. Order Line No."));
            END;
            ItemTrackingForm.SetSourceSpec(TrackingSpecification, SalesLine."Shipment Date");
            ItemTrackingForm.SetInbound(SalesLine.IsInbound());
            ItemTrackingForm.RUNMODAL();
            //>>SSC56
        END;
        //<<SSC56
        IsHandled := true;
    END;

    PROCEDURE CPCallItemTracking(VAR SalesLine: Record "Sales Line");  // New Procedure in Sales Line-Reserve codeunit
    VAR
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemTrackingForm: Page "Mini Screen - Item Track Lines";

    BEGIN
        //SCSSM01 BEGIN
        TrackingSpecification.InitFromSalesLine(SalesLine);
        IF ((SalesLine."Document Type" = SalesLine."Document Type"::Invoice) AND
            (SalesLine."Shipment No." <> '')) OR
           ((SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo") AND
            (SalesLine."Return Receipt No." <> ''))
        THEN
            ItemTrackingForm.SetFormRunMode(2); // Combined shipment/receipt
        IF SalesLine."Drop Shipment" THEN BEGIN
            ItemTrackingForm.SetFormRunMode(3); // Drop Shipment
            IF SalesLine."Purchase Order No." <> '' THEN
                ItemTrackingForm.SetSecondSourceRowID(ItemTrackingMgt.ComposeRowID(DATABASE::"Purchase Line",
                    1, SalesLine."Purchase Order No.", '', 0, SalesLine."Purch. Order Line No."));
        END;
        ItemTrackingForm.SetSource(TrackingSpecification, SalesLine."Shipment Date");
        ItemTrackingForm.SetInbound(SalesLine.IsInbound());
        ItemTrackingForm.RUN();
        //SCSSM01 END
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnAfterCreateProdOrderFromSalesLine', '', false, false)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    begin
        ProdOrder."Requested Ship Date" := SalesLine."Requested Delivery Date"; //SCSSM01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shop Calendar Management", 'OnCalculateScheduleOnSetShopCalendarFilters', '', false, false)]
    local procedure OnCalculateScheduleOnSetShopCalendarFilters(var ShopCalendarWorkingDays: Record "Shop Calendar Working Days"; PeriodDate: Date)
    begin
        //SCSSM01 BEGIN
        IF (DATE2DWY(PeriodDate, 2) MOD 2) = 1 THEN
            ShopCalendarWorkingDays.SETRANGE("Week 1", TRUE)
        ELSE
            ShopCalendarWorkingDays.SETRANGE("Week 2", TRUE);
        //SCSSM01
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", 'OnCreateNewWhseActivityOnAfterAssignBinZone', '', false, false)]
    local procedure OnCreateNewWhseActivityOnAfterAssignBinZone(var WhseActivLine: Record "Warehouse Activity Line")
    var
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        ActionType: Enum "Warehouse Action Type";
    begin
        //>>SSC56
        if ActionType = ActionType::Place then
            IF PostedWhseRcptLine."Storage Bin Code" <> '' THEN BEGIN
                WhseActivLine."Bin Code" := PostedWhseRcptLine."Storage Bin Code";
                WhseActivLine."Zone Code" := PostedWhseRcptLine."Storage Zone Code";
            END;
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", 'OnBeforeWhseActivLineInsert', '', false, false)]
    local procedure OnBeforeWhseActivLineInsert(var WarehouseActivityLine: Record "Warehouse Activity Line"; WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        //>>SSC56
        WarehouseActivityLine."Suggested Serial No." := WarehouseActivityLine."Serial No.";
        WarehouseActivityLine."Suggested Lot No." := WarehouseActivityLine."Lot No.";
        WarehouseActivityLine."Suggested Bin Code" := WarehouseActivityLine."Bin Code";
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", 'OnCreateWhseDocTakeLineOnBeforeWhseActivLineInsert', '', false, false)]
    local procedure OnCreateWhseDocTakeLineOnBeforeWhseActivLineInsert(var WarehouseActivityLine: Record "Warehouse Activity Line"; WarehouseActivityHeader: Record "Warehouse Activity Header"; TempWarehouseActivityLine: Record "Warehouse Activity Line" temporary)
    begin
        //>>SSC56
        WarehouseActivityLine."Suggested Serial No." := WarehouseActivityLine."Serial No.";
        WarehouseActivityLine."Suggested Lot No." := WarehouseActivityLine."Lot No.";
        WarehouseActivityLine."Suggested Bin Code" := WarehouseActivityLine."Bin Code";
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", 'OnCreateWhseDocTakeLineOnBeforeWhseActivLine2Insert', '', false, false)]
    local procedure OnCreateWhseDocTakeLineOnBeforeWhseActivLine2Insert(var WarehouseActivityLine: Record "Warehouse Activity Line"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var TempWarehouseActivityLine: Record "Warehouse Activity Line" temporary)
    begin
        //>>SSC56
        WarehouseActivityLine."Suggested Serial No." := WarehouseActivityLine."Serial No.";
        WarehouseActivityLine."Suggested Lot No." := WarehouseActivityLine."Lot No.";
        WarehouseActivityLine."Suggested Bin Code" := WarehouseActivityLine."Bin Code";
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", 'OnCreateWhseDocPlaceLineOnBeforeWhseActivLineInsert', '', false, false)]
    local procedure OnCreateWhseDocPlaceLineOnBeforeWhseActivLineInsert(var WarehouseActivityLine: Record "Warehouse Activity Line")
    begin
        //>>SSC56
        WarehouseActivityLine."Suggested Serial No." := WarehouseActivityLine."Serial No.";
        WarehouseActivityLine."Suggested Lot No." := WarehouseActivityLine."Lot No.";
        WarehouseActivityLine."Suggested Bin Code" := WarehouseActivityLine."Bin Code";
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calc. Inventory Adjmt. - Order", 'OnBeforeCalcActualCapacityCosts', '', false, false)]
    local procedure OnBeforeCalcActualCapacityCosts(var InventoryAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)"; var IsHandled: Boolean)
    begin
        IsHandled := true;    // Codeunit 5896 Calc. Inventory Adjmt. - Order  001 - comment code of procedure CalcActualCapacityCosts
    end;

    procedure CallItemTracking1(var TransLine: Record "Transfer Line"; Direction: Enum "Transfer Direction"; DirectTransfer: Boolean)
    VAR
        UserSetup: Record "User Setup";
        TrackingSpecification: Record "Tracking Specification";
        ItemTracking: Codeunit "Item Tracking Invoice";
        ItemTrackingMiniForm: Page "Mini Screen - Item Track Lines";
        ItemTrackingLines: Page "Item Tracking Lines";
        AvalabilityDate: Date;

    BEGIN
        TrackingSpecification.InitFromTransLine(TransLine, AvalabilityDate, Direction);
        if DirectTransfer then
            ItemTrackingLines.SetDirectTransfer(true);
        //>>SSC56
        UserSetup.GET(USERID);
        IF UserSetup."Handheld User" THEN BEGIN
            ItemTrackingMiniForm.SetSource(TrackingSpecification, AvalabilityDate);
            ItemTrackingMiniForm.SetInbound(TransLine.IsInbound());
            ItemTrackingMiniForm.SetStorageBinsVisible(Direction = Direction::Inbound);
            ItemTrackingMiniForm.RUNMODAL();
        END ELSE BEGIN
            //<<SSC56
            ItemTrackingLines.SetSourceSpec(TrackingSpecification, AvalabilityDate);
            ItemTrackingLines.SetInbound(TransLine.IsInbound());
            OnCallItemTrackingOnBeforeItemTrackingLinesRunModal(TransLine, ItemTrackingLines);
            //>>SSC56
            ItemTracking.SetStorageBinsVisible(Direction = Direction::Inbound);
            //<<SSC56
            ItemTrackingLines.RUNMODAL();
            //>>SSC56
            OnAfterCallItemTracking(TransLine);
        END;
        //<<SSC56
    END;

    local procedure OnAfterCallItemTracking(var TransferLine: Record "Transfer Line")
    begin
    end;

}