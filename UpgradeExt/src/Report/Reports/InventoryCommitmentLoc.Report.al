report 50008 "Inventory Commitment - Loc"
{
    // SCSFN
    //   - Inventory Commitment by Loction
    // ----------------------------------------------------------------------------------------------
    // ID          Date        Author           Description
    // ----------------------------------------------------------------------------------------------
    // 0001        25-06-13    HTOS-RT          Report migrated from version 5.0 to 2013
    //                                          Code is moved from Section triggers to DataItem triggers
    //                                          Added code for visibility purpose
    //             26-06-13    HTOS-RT          Layout changes in the RDLC
    // ----------------------------------------------------------------------------------------------
    // 
    // ----------------------------------------------------------------------------------------------
    // -----------------------------------------IWEB ETC.--------------------------------------------
    // ----------------------------------------------------------------------------------------------
    // CODE  DATE          DEV           COMMENt
    // ----------------------------------------------------------------------------------------------
    // 001   06.21.16      IWEB.DJ       change the formula for the Qty to Produce
    // 002   09.28.16      IWEB.DJ       2 decimal - LA column
    // 003   11.22.18      IWEB.DJ       Location changes from OW to AMAZONA ASIN Lables,Qty to Produce formula (IWEB887).
    // IWEB983 05.02.19    IWEB.DJ       Added filter on Item 2 for include only active items in Min/Max section.
    // IW1321  01.26.21    IWEB.DJ       Added new location GA.
    DefaultLayout = RDLC;

    RDLCLayout = 'src\Report\Layout\InventoryCommitmentLoc.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inventory Commitment - Loc';
    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TIME; TIME)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Page_No______FORMAT_CurrReport_PAGENO_; 'Page No. ' + FORMAT(CurrReport.PAGENO()))
            {
            }
            column(USERID; USERID)
            {
            }
            column(Qty_to_ProduceCaption; Qty_to_ProduceCaptionLbl)
            {
            }
            column(MaxCaption; MaxCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(On_Hand_Committed_AvailableCaption; On_Hand_Committed_AvailableCaptionLbl)
            {
            }
            column(Bill_to_CustomerCaption; Bill_to_CustomerCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Est__Ship_DateCaption; Est__Ship_DateCaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(MinCaption; MinCaptionLbl)
            {
            }
            column(Inventory_CommitmentCaption; Inventory_CommitmentCaptionLbl)
            {
            }
            column(AllCaption; AllCaptionLbl)
            {
            }
            column(LACaption; LACaptionLbl)
            {
            }
            column(OWCaption; OWCaptionLbl)
            {
            }
            column(CTCaption; CTCaptionLbl)
            {
            }
            column(GACaption; GACaptionLbl)
            {
            }
            column(HPCaption; HPCaptionLbl)
            {
            }
            column(Continue_to_Min_Max_Report___Items_With_No_Commitment_To_SalesCaption; Continue_to_Min_Max_Report___Items_With_No_Commitment_To_SalesCaptionLbl)
            {
            }
            column(AttachedCaption; AttachedCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Date_Filter; "Date Filter")
            {
            }
            column(Item_Location_Filter; "Location Filter")
            {
            }
            column(Item_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Item_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", Type, "No.", "Est. Shipment Date")
                                    WHERE("Document Type" = CONST(Order),
                                          Type = CONST(Item));
                RequestFilterFields = "Location Code";

                trigger OnAfterGetRecord()
                begin
                    //IF NOT CONFIRM('%1', TRUE, "Location Code") THEN ERROR('STOP');

                    IF "Location Code" <> 'ZQC' THEN
                        TotalQuantityCommitted += Quantity - "Quantity Shipped";

                    IF "Location Code" = 'LA' THEN
                        CommittedLA += Quantity - "Quantity Shipped";
                    IF "Location Code" = 'AMZASIN' THEN
                        CommittedOhm += Quantity - "Quantity Shipped";
                    IF "Location Code" = 'CT' THEN
                        CommittedCT += Quantity - "Quantity Shipped";
                    IF "Location Code" = 'GA' THEN
                        CommittedGA += Quantity - "Quantity Shipped";
                    IF "Location Code" = 'HP' THEN
                        CommittedHP += Quantity - "Quantity Shipped";

                    ItemPrinted := TRUE;
                end;
            }
            dataitem("Item 2"; Item)
            {
                DataItemLink = "No." = FIELD("No."),
                               "Date Filter" = FIELD("Date Filter"),
                               "Location Filter" = FIELD("Location Filter"),
                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("No.")
                                    WHERE("Blocked" = CONST(false));
                PrintOnlyIfDetail = true;
                column(Item_2_Description; Description)
                {
                }
                column(BulkItem; "Description 5")
                {
                }
                column(Item_2__No__; "No.")
                {
                }
                column(InventoryAll; InventoryAll)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Item_2__Item_2___Maximum_Inventory_; "Item 2"."Maximum Inventory")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(TotalQuantityCommitted; TotalQuantityCommitted)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Item_2__Inventory___TotalQuantityCommitted; "Item 2".Inventory - TotalQuantityCommitted)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Item_2__Item_2___Safety_Stock_Quantity_; "Item 2"."Safety Stock Quantity")
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Item_2___Safety_Stock_Quantity______Item_2__Inventory___TotalQuantityCommitted_; "Item 2"."Maximum Inventory" - InventoryLA + CommittedLA)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryLA; InventoryLA)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryOhm; InventoryOhm)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryCT; InventoryCT)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryGa; InventoryGA)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(InventoryHP; InventoryHP)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CommittedOhm; CommittedOhm)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(CommittedCT; CommittedCT)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(CommittedGA; CommittedGA)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CommittedHP; CommittedHP)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(CommittedLA; CommittedLA)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryLA_CommittedLA; InventoryLA - CommittedLA)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryOhm_CommittedOhm; InventoryOhm - CommittedOhm)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryCT_CommittedCT; InventoryCT - CommittedCT)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryGA_CommittedGA; InventoryGA - CommittedGA)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(InventoryHP_CommittedHP; InventoryHP - CommittedHP)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(On_Hand_Caption; On_Hand_CaptionLbl)
                {
                }
                column(Committed_Caption; Committed_CaptionLbl)
                {
                }
                column(Available_Caption; Available_CaptionLbl)
                {
                }
                column(Item_2_Date_Filter; "Date Filter")
                {
                }
                column(Item_2_Location_Filter; "Location Filter")
                {
                }
                column(Item_2_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {
                }
                column(Item_2_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                {
                }
                dataitem("Sales Line 2"; "Sales Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", Type, "No.", "Est. Shipment Date")
                                        WHERE("Document Type" = CONST(Order),
                                              Type = CONST(Item));
                    column(WeeklyCommitted; WeeklyCommitted)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(PrevWeekNumber; PrevWeekNumber)
                    {
                    }
                    column(CurrWeekNumber; CurrWeekNumber)
                    {
                    }
                    column(i_int; i)
                    {
                    }
                    column(NumberOfRecords; NumberofRecords)
                    {
                    }
                    column(Flag; Flag)
                    {
                    }
                    column(ItemPrinted; ItemPrinted)
                    {
                    }
                    column(ResetWeek; ResetWeek)
                    {
                    }
                    column(Sales_Line_2__Bill_to_Customer_No__; "Bill-to Customer No.")
                    {
                    }
                    column(Sales_Line_2__Document_No__; "Document No.")
                    {
                    }
                    column(Sales_Line_2__Est__Shipment_Date_; "Est. Shipment Date")
                    {
                    }
                    column(QuantityCommitted; QuantityCommitted)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(CrdHold; CrdHold)
                    {

                    }
                    column(sCust; sCust)
                    {
                    }
                    column(OrderDate; SalesHeader."Order Date")
                    {
                    }
                    column(Sales_Line_2__Location_Code_; "Location Code")
                    {

                    }
                    column(Finalized; Finalized)
                    {

                    }
                    column(WeeklyCommitted_Control1000000020; WeeklyCommitted)
                    {
                        DecimalPlaces = 2 : 2;
                    }
                    column(Weekly_Total_Caption; Weekly_Total_CaptionLbl)
                    {
                    }
                    column(Weekly_Total_Caption_Control1000000021; Weekly_Total_Caption_Control1000000021Lbl)
                    {
                    }
                    column(Sales_Line_2_Document_Type; "Document Type")
                    {
                    }
                    column(Sales_Line_2_Line_No_; "Line No.")
                    {
                    }
                    column(Sales_Line_2_No_; "No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        i += 1;
                        IF i = 1 THEN
                            PrevWeekNumber := DATE2DWY("Est. Shipment Date", 2);
                        CurrWeekNumber := DATE2DWY("Est. Shipment Date", 2);

                        QuantityCommitted := 0;
                        QuantityCommitted := Quantity - "Quantity Shipped";

                        IF PrevWeekNumber = CurrWeekNumber THEN
                            WeeklyCommitted += QuantityCommitted;

                        CrdHold := '';
                        Finalized := '';
                        SalesHeader.GET("Document Type"::Order, "Document No.");
                        IF SalesHeader."On Hold" <> '' THEN
                            CrdHold := 'Credit Hold';
                        IF (NOT SalesHeader.Finalized) OR (SalesHeader.Status <> SalesHeader.Status::Released) THEN
                            Finalized := 'Not Released or Final';

                        // 0001.Begin
                        recCust.INIT();
                        recCust.GET("Bill-to Customer No.");
                        sCust := recCust.Name;
                        IF PrevWeekNumber <> CurrWeekNumber THEN BEGIN
                            Flag := TRUE;
                            ResetWeek := TRUE;
                            PrevWeekNumber := DATE2DWY("Est. Shipment Date", 2);
                        END
                        ELSE
                            Flag := FALSE;
                        IF ResetWeek THEN BEGIN
                            WeeklyCommitted := Quantity - "Quantity Shipped";
                            ResetWeek := FALSE;
                        END;
                        // 0001.End
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Sales Line 2".COPYFILTERS("Sales Line");
                        //CurrReport.CREATETOTALS(QuantityCommitted);
                        NumberofRecords := 0;
                        i := 0;
                        WeeklyCommitted := 0;
                        ResetWeek := FALSE;
                        //SETFILTER("Location Code", "Sales Line"."Location Code");
                        NumberofRecords := "Sales Line 2".COUNT;
                        Flag := TRUE;  // 0001
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS(Inventory);
                    IF NOT ItemPrinted THEN BEGIN
                        TempItem := "Item 2";
                        TempItem.INSERT();
                    END;

                    InventoryAll := 0;
                    InventoryOhm := 0;
                    InventoryLA := 0;
                    InventoryCT := 0;
                    InventoryGA := 0;
                    InventoryHP := 0;

                    InventoryAll := GetInventory("Item 2", '<>ZQC');
                    InventoryOhm := GetInventory("Item 2", 'AMZASIN');
                    InventoryLA := GetInventory("Item 2", 'LA');
                    InventoryCT := GetInventory("Item 2", 'CT');
                    InventoryGA := GetInventory("Item 2", 'GA');
                    InventoryHP := GetInventory("Item 2", 'HP');
                end;

                trigger OnPostDataItem()
                begin
                    TotalQuantityCommitted := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalQuantityCommitted := 0;
                CommittedLA := 0;
                CommittedOhm := 0;
                CommittedCT := 0;
                CommittedGA := 0;
                CommittedHP := 0;

                ItemPrinted := FALSE;
            end;

            trigger OnPostDataItem()
            begin
                //IF CONFIRM('Number of records is %1', TRUE , TempItem.COUNT) THEN ERROR('stop');
            end;
        }
        dataitem("Items w/o Detail"; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(TIME_Control1000000045; TIME)
            {
            }
            column(Page_No______FORMAT_CurrReport_PAGENO__Control1000000042; 'Page No. ' + FORMAT(CurrReport.PAGENO()))
            {
            }
            column(TODAY_Control1000000044; TODAY)
            {
            }
            column(USERID_Control1000000046; USERID)
            {
            }
            column(TempItem__No__; TempItem."No.")
            {
            }
            column(TempItem_Description; TempItem.Description)
            {
            }
            column(TempItem__Maximum_Inventory_; TempItem."Maximum Inventory")
            {
                DecimalPlaces = 0 : 0;
            }
            column(TempItem__Maximum_Inventory____TempItem_Inventory; TempItem."Maximum Inventory" - TempItem.Inventory)
            {
                DecimalPlaces = 0 : 0;
            }
            column(TempItem__Safety_Stock_Quantity_; TempItem."Safety Stock Quantity")
            {
                DecimalPlaces = 0 : 0;
            }
            column(TempItem__Safety_Stock_Quantity_____TempItem_Inventory; TempItem."Safety Stock Quantity" - TempItem.Inventory)
            {
                DecimalPlaces = 0 : 0;
            }
            column(TempInventoryAll; TempInventoryAll)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InventoryLA_Control1000000065; InventoryLA)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InventoryOhm_Control1000000066; InventoryOhm)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InventoryCT_Control1000000067; InventoryCT)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InventoryGA_Control1000000071; InventoryGA)
            {
                DecimalPlaces = 0 : 0;
            }
            column(InventoryHP_Control1000000071; InventoryHP)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(MinCaption_Control1000000034; MinCaption_Control1000000034Lbl)
            {
            }
            column(MaxCaption_Control1000000035; MaxCaption_Control1000000035Lbl)
            {
            }
            column(To_MinCaption; To_MinCaptionLbl)
            {
            }
            column(To_MaxCaption; To_MaxCaptionLbl)
            {
            }
            column(MIN_MAX_REPORT___ITEMS_WITH_NO_COMMITMENT_TO_SALESCaption; MIN_MAX_REPORT___ITEMS_WITH_NO_COMMITMENT_TO_SALESCaptionLbl)
            {
            }
            column(On_HandCaption; On_HandCaptionLbl)
            {
            }
            column(AllCaption_Control1000000033; AllCaption_Control1000000033Lbl)
            {
            }
            column(LACaption_Control1000000061; LACaption_Control1000000061Lbl)
            {
            }
            column(OWCaption_Control1000000062; OWCaption_Control1000000062Lbl)
            {
            }
            column(AMZNCaption_Lbl; AMZNCaptionLbl)
            {
            }
            column(GACaption_Control1000000063; GACaption_Control1000000063Lbl)
            {
            }
            column(CTCaption_Control1000000063; CTCaption_Control1000000063Lbl)
            {
            }
            column(HPCaption_Control1000000070; HPCaption_Control1000000070Lbl)
            {
            }
            column(Items_w_o_Detail_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                OnLineNumber := OnLineNumber + 1;

                IF OnLineNumber = 1 THEN
                    TempItem.FIND('-')
                ELSE
                    TempItem.NEXT();
                TempItem.CALCFIELDS(TempItem.Inventory);

                TempInventoryAll := 0;
                InventoryOhm := 0;
                InventoryLA := 0;
                InventoryCT := 0;
                InventoryGA := 0;
                InventoryHP := 0;

                TempInventoryAll := GetInventory(TempItem, '<>ZQC');
                InventoryOhm := GetInventory(TempItem, 'AMZN');
                InventoryLA := GetInventory(TempItem, 'LA');
                InventoryCT := GetInventory(TempItem, 'CT');
                InventoryGA := GetInventory(TempItem, 'GA');
                InventoryHP := GetInventory(TempItem, 'HP');
            end;

            trigger OnPreDataItem()
            begin
                NumberOfLines := TempItem.COUNT;
                SETRANGE(Number, 1, NumberOfLines);
                OnLineNumber := 0;
                //CurrReport.NEWPAGE;
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
        PageNoCaption = 'Page No.';
    }

    var

        TempItem: Record Item temporary;
        SalesHeader: Record "Sales Header";
        recCust: Record Customer;
        QuantityCommitted: Decimal;
        TotalQuantityCommitted: Decimal;
        CurrWeekNumber: Integer;
        PrevWeekNumber: Integer;
        i: Integer;
        NumberofRecords: Integer;
        WeeklyCommitted: Decimal;
        ResetWeek: Boolean;
        ItemPrinted: Boolean;

        OnLineNumber: Integer;
        NumberOfLines: Integer;
        InventoryOhm: Decimal;
        InventoryLA: Decimal;
        InventoryCT: Decimal;
        InventoryGA: Decimal;
        InventoryHP: Decimal;
        InventoryAll: Decimal;
        TempInventoryAll: Decimal;
        CrdHold: Text[30];
        Finalized: Text[30];

        CommittedOhm: Decimal;
        CommittedLA: Decimal;
        CommittedCT: Decimal;
        CommittedGA: Decimal;
        CommittedHP: Decimal;

        sCust: Text[100];
        Qty_to_ProduceCaptionLbl: Label 'Qty to Produce';
        MaxCaptionLbl: Label 'Max';
        BalanceCaptionLbl: Label 'Balance';
        On_Hand_Committed_AvailableCaptionLbl: Label 'On-Hand/Committed/Available';
        Bill_to_CustomerCaptionLbl: Label 'Bill-to Customer';
        Order_No_CaptionLbl: Label 'Order No.';
        Est__Ship_DateCaptionLbl: Label 'Est. Ship Date';
        ItemCaptionLbl: Label 'Item';
        MinCaptionLbl: Label 'Min';
        Inventory_CommitmentCaptionLbl: Label 'Inventory Commitment';
        AllCaptionLbl: Label 'All';
        LACaptionLbl: Label 'LA';
        GACaptionLbl: Label 'GA';
        OWCaptionLbl: Label 'AMZASIN';
        CTCaptionLbl: Label 'CT';
        HPCaptionLbl: Label 'HP';
        Continue_to_Min_Max_Report___Items_With_No_Commitment_To_SalesCaptionLbl: Label 'Continue to Min/Max Report - Items With No Commitment To Sales';
        AttachedCaptionLbl: Label 'Attached';
        On_Hand_CaptionLbl: Label 'On Hand:';
        Committed_CaptionLbl: Label 'Committed:';
        Available_CaptionLbl: Label 'Available:';
        Weekly_Total_CaptionLbl: Label 'Weekly Total:';
        Weekly_Total_Caption_Control1000000021Lbl: Label 'Weekly Total:';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        MinCaption_Control1000000034Lbl: Label 'Min';
        MaxCaption_Control1000000035Lbl: Label 'Max';
        To_MinCaptionLbl: Label 'To Min';
        To_MaxCaptionLbl: Label 'To Max';
        MIN_MAX_REPORT___ITEMS_WITH_NO_COMMITMENT_TO_SALESCaptionLbl: Label 'MIN/MAX REPORT - ITEMS WITH NO COMMITMENT TO SALES';
        On_HandCaptionLbl: Label 'On-Hand';
        AllCaption_Control1000000033Lbl: Label 'All';
        LACaption_Control1000000061Lbl: Label 'LA';
        GACaption_Control1000000063Lbl: Label 'GA';
        OWCaption_Control1000000062Lbl: Label 'AMZASIN';
        CTCaption_Control1000000063Lbl: Label 'CT';
        HPCaption_Control1000000070Lbl: Label 'HP';
        Flag: Boolean;
        AMZNCaptionLbl: Label 'AMZN';

    procedure GetInventory(ItemInventory: Record Item; LocationCode: Code[20]) QtyInInventory: Decimal
    var
        itm: Record Item;
    begin
        itm.RESET();
        itm.GET(ItemInventory."No.");
        itm.SETFILTER("Location Filter", LocationCode);
        itm.CALCFIELDS(Inventory);
        QtyInInventory := itm.Inventory;
    end;
}

