codeunit 50106 TableEventSubscriber
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter', '', false, false)]
    local procedure OnCopySelltoCustomerAddressFieldsFromCustomerOnBeforeAssignRespCenter(var SalesHeader: Record "Sales Header"; var SellToCustomer: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader."F.O.B." := SellToCustomer."F.O.B.";  //SCSML
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnAfterCalcShouldSkipConfirmSellToCustomerDialog', '', false, false)]
    local procedure OnValidateSellToCustomerNoOnAfterCalcShouldSkipConfirmSellToCustomerDialog(var SalesHeader: Record "Sales Header"; var ShouldSkipConfirmSellToCustomerDialog: Boolean)
    begin
        //SCSNP BEGIN
        SalesHeader."Last Updated By" := USERID();
        SalesHeader."Updated Date/Time" := CURRENTDATETIME;
        //SCSNP END
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure OnAfterSetFieldsBilltoCustomer(var SalesHeader: Record "Sales Header"; Customer: Record Customer; xSalesHeader: Record "Sales Header"; SkipBillToContact: Boolean; CUrrentFieldNo: Integer)
    begin
        //SCSFN .01
        SalesHeader."Salesperson 2" := Customer."Salesperson 2";
        SalesHeader."Broker 1" := Customer.Broker;
        SalesHeader."Broker 2" := Customer."Broker 2";
        //SCSFN .01 END
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr', '', false, false)]

    local procedure OnAfterCopyShipToCustomerAddressFieldsFromShipToAddr(var SalesHeader: Record "Sales Header"; ShipToAddress: Record "Ship-to Address"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.Notes := ShipToAddress.Notes; //SCSFN 110507
        SalesHeader."F.O.B." := ShipToAddress."F.O.B.";  //SCSML
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateShippingAgentCode', '', false, false)]
    local procedure OnBeforeValidateShippingAgentCode(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer)
    var
        ReleaseDoc: Codeunit "Release Sales Document";
        lCurrentStatus: Option "Open","Released";

    begin
        //SCSFN .01
        lCurrentStatus := SalesHeader.Status;
        IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
            ReleaseDoc.SetIgnoreReviseOrderMail(TRUE);
            ReleaseDoc.Reopen(SalesHeader);
        END;
        //SCSFN
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCopyFromItem', '', false, false)]
    local procedure OnBeforeCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; var IsHandled: Boolean)
    begin
        // SCS1.1
        IF (Item."Sales G/L Account" <> '') THEN BEGIN
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine.VALIDATE("No.", Item."Sales G/L Account");
        END;
        //SCS1.1
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var SalesLine: Record "Sales Line"; Item: Record Item; SalesHeader: Record "Sales Header"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        IF SalesHeader."Language Code" <> '' THEN
            //SCSNP BEGIN
            IF (SalesLine."No." <> xSalesLine."No.") AND (xSalesLine."No." <> '') THEN BEGIN
                SalesHeader."Last Updated By" := USERID();
                SalesHeader."Updated Date/Time" := CURRENTDATETIME;
                SalesHeader.MODIFY();
            END;
        //SCSNP END
        IF Item.Reserve = Item.Reserve::Optional THEN
            SalesLine."Item Type" := Item."Item Type"; //SCSEL 07-17-07
        SalesLine."Bags per Case" := Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."F.O.B." := Vendor."F.O.B.";//SCSML
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateShipToAddress', '', false, false)]

    local procedure OnAfterUpdateShipToAddress(var PurchHeader: Record "Purchase Header")
    var
        Location: Record Location;
    begin
        IF (PurchHeader."Location Code" = 'LA')
              THEN BEGIN
            Location.GET('HP');
            PurchHeader."Ship-to Name" := Location.Name;
            PurchHeader."Ship-to Name 2" := Location."Name 2";
            PurchHeader."Ship-to Address" := Location.Address;
            PurchHeader."Ship-to Address 2" := Location."Address 2";
            PurchHeader."Ship-to City" := Location.City;
            PurchHeader."Ship-to Post Code" := Location."Post Code";
            PurchHeader."Ship-to County" := Location.County;
            PurchHeader."Ship-to Country/Region Code" := Location."Country/Region Code";
            PurchHeader."Ship-to Contact" := Location.Contact;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckAssosiatedSalesOrder', '', false, false)]
    local procedure OnBeforeCheckAssosiatedSalesOrder(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        //SCSFN 110807
        IF (PurchaseLine.Type = PurchaseLine.Type::"G/L Account") AND (xPurchaseLine."No." <> '') THEN
            EXIT;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck(var PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin

        //SCS1.1
        IF (Item."Purch. G/L Account" <> '') THEN BEGIN
            PurchaseLine.Type := PurchaseLine.Type::"G/L Account";
            PurchaseLine.VALIDATE(PurchaseLine."No.", Item."Purch. G/L Account");
        END;
        //SCS
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterTestStatusOpen', '', false, false)]
    local procedure OnAfterTestStatusOpen(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header")
    begin
        //SSC70 - 20101216 Start
        PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);
        //SSC70 - 20101216 End
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnAfterInitDefaultDimensionSources', '', false, false)]

    local procedure OnAfterInitDefaultDimensionSources(var ProductionOrder: Record "Production Order"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; CallingFieldNo: Integer)
    var
        MfgSetup: Record "Manufacturing Setup";
        Item: record item;
    begin
        ProductionOrder."Ink Color No. 1" := Item."Ink Color No. 1"; //SCSSM01
                                                                     //"Net Weight" := Item."Net Weight";
        MfgSetup.GET(); //scssm01
        ProductionOrder.VALIDATE(ProductionOrder."Location Code", MfgSetup."Default Location for PO"); //scssm01
        IF STRLEN(COPYSTR(ProductionOrder."No.", 5, STRLEN(ProductionOrder."No.")) + ' ' + ProductionOrder."Source No." + ' ') > 20 THEN
            ProductionOrder."Desc for Gannt Chart" := (COPYSTR(ProductionOrder."No.", 8, STRLEN(ProductionOrder."No.")) + ' ' + ProductionOrder."Source No." + ' ')   //SCSSM01
        ELSE
            ProductionOrder."Desc for Gannt Chart" := (COPYSTR(ProductionOrder."No.", 5, STRLEN(ProductionOrder."No.")) + ' ' + ProductionOrder."Source No." + ' ');
        ProductionOrder.MODIFY();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Header", 'OnAfterDeleteWhseActivHeader', '', false, false)]

    local procedure OnAfterDeleteWhseActivHeader(var WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        ItemTrackingLineBin: Record "Item Tracking Line Bin";
        RegisteredWhseActivityHdr: Record "Registered Whse. Activity Hdr.";
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        WhseActivLine2: Record "Warehouse Activity Line";
    begin
        //>>SSC56
        IF WarehouseActivityHeader.Type = WarehouseActivityHeader.Type::"Put-away" THEN BEGIN
            WhseActivLine2.SETRANGE("Activity Type", WarehouseActivityHeader.Type);
            WhseActivLine2.SETRANGE("No.", WarehouseActivityHeader."No.");
            IF WhseActivLine2.FINDFIRST() THEN BEGIN
                ItemTrackingLineBin.RESET();
                ItemTrackingLineBin.SETRANGE("Source Type", WhseActivLine2."Source Type");
                ItemTrackingLineBin.SETRANGE("Source Subtype", WhseActivLine2."Source Subtype");
                ItemTrackingLineBin.SETRANGE("Source ID", WhseActivLine2."Source No.");
                ItemTrackingLineBin.SETRANGE("Source Prod. Order Line", WhseActivLine2."Source Line No.");
                ItemTrackingLineBin.DELETEALL();
            END ELSE BEGIN
                RegisteredWhseActivityHdr.RESET();
                RegisteredWhseActivityHdr.SETRANGE(Type, WarehouseActivityHeader.Type);
                RegisteredWhseActivityHdr.SETRANGE("Whse. Activity No.", WarehouseActivityHeader."No.");
                IF RegisteredWhseActivityHdr.FINDLAST() THEN BEGIN
                    RegisteredWhseActivityLine.RESET();
                    RegisteredWhseActivityLine.SETRANGE("Activity Type", RegisteredWhseActivityHdr.Type);
                    RegisteredWhseActivityLine.SETRANGE("No.", RegisteredWhseActivityHdr."No.");
                    IF RegisteredWhseActivityLine.FINDFIRST() THEN BEGIN
                        ItemTrackingLineBin.RESET();
                        ItemTrackingLineBin.SETRANGE("Source Type", RegisteredWhseActivityLine."Source Type");
                        ItemTrackingLineBin.SETRANGE("Source Subtype", RegisteredWhseActivityLine."Source Subtype");
                        ItemTrackingLineBin.SETRANGE("Source ID", RegisteredWhseActivityLine."Source No.");
                        ItemTrackingLineBin.SETRANGE("Source Prod. Order Line", RegisteredWhseActivityLine."Source Line No.");
                        ItemTrackingLineBin.DELETEALL();
                    END;
                END;
            END;
        END;
        //<<SSC56
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnValidateNoOnAfterAssignItemFields', '', false, false)]

    local procedure OnValidateNoOnAfterAssignItemFields(var ProductionBOMLine: Record "Production BOM Line"; Item: Record Item; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    begin
        //SCSSM01 BEGIN
        IF Item.Resin THEN
            ProductionBOMLine."Resin Item" := TRUE;
        IF Item.Scrap THEN
            ProductionBOMLine."Scrap Item" := TRUE;
        ProductionBOMLine."Scrap Qty" := ProductionBOMLine."CP Scrap %" * ProductionBOMLine.Quantity;
        //SCSSM01 END
    end;

}
