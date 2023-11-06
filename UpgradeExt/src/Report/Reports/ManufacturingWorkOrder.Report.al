report 50010 "Manufacturing Work Order"
{
    // //IWEB269 - New fields added "Min / MAX inventory value and "Description 2"
    // IWEB    01102018  Repleaced Item."Film Gauge" to Item."Actual Film Gauge".
    // 1402 Dj 07-20-2021 report printing issue
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ManufacturingWorkOrder.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Manufacturing Work Order';
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = WHERE(Status = CONST(Released));
            RequestFilterFields = "No.";
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status = FIELD(Status),
                               "Prod. Order No." = FIELD("No.");
                column(Prod_Order_Line_Item_No_; "Prod. Order Line"."Item No.")
                {
                }
                column(Prod_Order_Line_Quantity; Quantity)
                {
                }
                column(Item_Desc2; Item."Description 2")
                {
                }
                column(Item_Film_Gauge; Item."Actual Film Gauge")
                {
                }
                column(Item_Film_Color; Item."Film Color")
                {
                }
                column(Item_Film_Type; Item."Film Type")
                {
                }
                column(Item_Print; Item."Print Text")
                {
                }
                column(Item_Ink_Color_No_1_; Item."Ink Color No. 1")
                {
                }
                column(Item_Rolls_Bundles_per_Case; Item."Rolls/Bundles per Case")
                {
                }
                column(Item_Bags_per_Roll_Bundle; Item."Bags per Roll/Bundle")
                {
                }
                column(Item_Net_Weight; Item."Net Weight")
                {
                }
                column(Item_Gross_Weight; Item."Gross Weight")
                {
                }
                column(Item_Max_Invt; Item."Maximum Inventory")
                {
                }
                column(Item_SafetyStock; Item."Safety Stock Quantity")
                {
                }
                column(Item_TieLen; Item."Tie Length")
                {
                }
                column(Prod_Order_Line_Prod_Order_No_; "Prod. Order Line"."Prod. Order No.")
                {
                }
                column(Prod_Order_Line_Due_Date; FORMAT("Prod. Order Line"."Due Date", 0, 4))
                {
                }
                column(ProductionBOMLine_Description; ProductionBOMLine.Description)
                {
                }
                column(TempProductionBOMLine_Description; ProductionBOMLine_.Description)
                {
                }
                column(Item_Rolls_Bundles_per_Case__Item_Bags_per_Roll_Bundle; Item."Rolls/Bundles per Case" * Item."Bags per Roll/Bundle")
                {
                }
                column(Width; Width)
                {
                }
                column(Length; Length)
                {
                }
                column(Plts; Plts)
                {
                }
                column(Item_Case_Count; Item."Case Count")
                {
                }
                column(BagGrWt; BagGrWt)
                {
                }
                column(RollWt; RollWt)
                {
                }
                column(Mil; Mil)
                {
                }
                column(Line_Counter1; 'Line #' + FORMAT(Counter1))
                {
                }
                column(Item_Ink_Color_No_2; Item."Ink Color No. 2")
                {
                }
                column(Item_Scrap_Item; Item."Scrap Item")
                {
                }
                column(Item_Die_Cut_Item; Item."Die Cut Item")
                {
                }
                column(Item_Description_3; Item."Description 3")
                {
                }
                column(Item_Die_Cut; Item."Die Cut")
                {
                }
                column(Item_Palletization; Item.Palletization)
                {
                }
                column(Item_Ink_Color_No_3; Item."Ink Color No. 3")
                {
                }
                column(Item_RPO_Notes; Item."RPO Notes")
                {
                }
                column(MANUFACTURING_WORK_ORDERCaption; MANUFACTURING_WORK_ORDERCaptionLbl)
                {
                }
                column(Item_KeyCaption; Item_KeyCaptionLbl)
                {
                }
                column(of_CasesCaption; of_CasesCaptionLbl)
                {
                }
                column(of_PLTSCaption; of_PLTSCaptionLbl)
                {
                }
                column(CS_PER_PLTCaption; CS_PER_PLTCaptionLbl)
                {
                }
                column(LENGTHCaption; LENGTHCaptionLbl)
                {
                }
                column(WIDTHCaption; WIDTHCaptionLbl)
                {
                }
                column(MICRONCaption; MICRONCaptionLbl)
                {
                }
                column(MILCaption; MILCaptionLbl)
                {
                }
                column(FILM_COLORCaption; FILM_COLORCaptionLbl)
                {
                }
                column(OF_BAGS_ROLLSCaption; OF_BAGS_ROLLSCaptionLbl)
                {
                }
                column(OF_ROLLS_PER_CASECaption; OF_ROLLS_PER_CASECaptionLbl)
                {
                }
                column(INK_1Caption; INK_1CaptionLbl)
                {
                }
                column(PRINT_Caption; PRINT_CaptionLbl)
                {
                }
                column(MATERIALCaption; MATERIALCaptionLbl)
                {
                }
                column(BAG_GRAM_WTCaption; BAG_GRAM_WTCaptionLbl)
                {
                }
                column(CASE_GROSS_WTCaption; CASE_GROSS_WTCaptionLbl)
                {
                }
                column(CASE_NET_WTCaption; CASE_NET_WTCaptionLbl)
                {
                }
                column(ROLL_GROSS_WTCaption; ROLL_GROSS_WTCaptionLbl)
                {
                }
                column(Due_DateCaption; Due_DateCaptionLbl)
                {
                }
                column(MFG_WO__Caption; MFG_WO__CaptionLbl)
                {
                }
                column(CoreCaption; CoreCaptionLbl)
                {
                }
                column(BoxCaption; BoxCaptionLbl)
                {
                }
                column(TOTAL_PACKCaption; TOTAL_PACKCaptionLbl)
                {
                }
                column(COMMENTSCaption; COMMENTSCaptionLbl)
                {
                }
                column(lbs_Caption; lbs_CaptionLbl)
                {
                }
                column(gr_Caption; gr_CaptionLbl)
                {
                }
                column(INK_2Caption; INK_2CaptionLbl)
                {
                }
                column(SCRAP_ITEM_KEYCaption; SCRAP_ITEM_KEYCaptionLbl)
                {
                }
                column(DIE_CUT_ITEM_KEYCaption; DIE_CUT_ITEM_KEYCaptionLbl)
                {
                }
                column(INK_3Caption; INK_3CaptionLbl)
                {
                }
                column(QtyLbl; QtyLbl)
                {
                }
                column(Prod__Order_Line_Status; Status)
                {
                }
                column(Prod__Order_Line_Line_No_; "Line No.")
                {
                }
                dataitem("Prod. Order Comment Line"; "Prod. Order Comment Line")
                {
                    DataItemLink = Status = FIELD(Status),
                                   "Prod. Order No." = FIELD("Prod. Order No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.");
                    PrintOnlyIfDetail = true;
                    column(Prod_Order_Comment_Line_Comment; "Prod. Order Comment Line".Comment)
                    {
                    }
                    column(Prod_Order_Comment_Line_Date; "Prod. Order Comment Line".Date)
                    {
                    }
                    column(Prod_Order_Comment_Line_Status; Status)
                    {
                    }
                    column(Prod_Order_Comment_Line_Prod__Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod_Order_Comment_Line_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        NoCommentLines += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        NoCommentLines := 0;
                    end;
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = "Prod. Order No." = FIELD("Prod. Order No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(Prod_Order_Component_Item_No_; "Item No.")
                    {
                    }
                    column(Prod_Order_Component_Status; Status)
                    {
                    }
                    column(Prod_Order_Component_Prod_Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod_Order_Component_Prod_Order_Line_No_; "Prod. Order Line No.")
                    {
                    }
                    column(Prod_Order_Component_Line_No_; "Line No.")
                    {
                    }
                    column(Quantity_ProdOrderComponent; "Prod. Order Component".Quantity)
                    {
                    }
                    column(ExpectedQuantity_ProdOrderComponent; "Prod. Order Component"."Expected Quantity")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ProdOrderRoutingLine.INIT();
                    ProdOrderRoutingLine.RESET();
                    ProdOrderRoutingLine.SETRANGE(Status, Status);
                    ProdOrderRoutingLine.SETRANGE("Prod. Order No.", "Prod. Order No.");
                    ProdOrderRoutingLine.SETRANGE("Routing Reference No.", "Prod. Order Line"."Routing Reference No.");
                    ProdOrderRoutingLine.SETRANGE("Routing No.", "Prod. Order Line"."Routing No.");
                    IF ProdOrderRoutingLine.FIND('-') THEN;
                    Counter1 := ProdOrderRoutingLine."No.";
                    RollWt := 0;
                    BagGrWt := 0;
                    Mil := 0;

                    IF Counter > 1 THEN BEGIN
                        CurrReport.NEWPAGE();
                        Counter += 1;
                    END
                    ELSE
                        Counter += 1;

                    Item.INIT();
                    Item.GET("Item No.");

                    IF Item."Production BOM No." <> '' THEN BEGIN
                        ProductionBOMLine.INIT();
                        ProductionBOMLine.RESET();
                        ProductionBOMLine.SETRANGE("Production BOM No.", Item."Production BOM No.");
                        ProductionBOMLine.SETRANGE("No.", 'ZCORE');
                        IF ProductionBOMLine.FIND('-') THEN;

                        ProductionBOMLine_.INIT();
                        ProductionBOMLine_.RESET();
                        ProductionBOMLine_.SETRANGE("Production BOM No.", Item."Production BOM No.");
                        ProductionBOMLine_.SETFILTER("No.", '=%1', 'ZBOX' + '*');
                        IF ProductionBOMLine_.FIND('-') THEN;

                    END;

                    Length := '';
                    Width := '';
                    Position := 0;
                    Position := STRPOS(Item."Bag Dimensions", 'X');
                    IF Position <> 0 THEN BEGIN
                        Width := COPYSTR(Item."Bag Dimensions", 1, Position - 1);
                        BagDimension := COPYSTR(Item."Bag Dimensions", Position + 1, 20);
                        Position := 0;
                        Position := STRPOS(BagDimension, 'X');
                        IF Position = 0 THEN
                            Length := BagDimension
                        ELSE
                            Length := COPYSTR(BagDimension, 1, Position + 6);


                    END;
                    decPlts := 0;
                    Plts := '';
                    rem := 0;
                    IF Item."Case Count" <> 0 THEN BEGIN
                        decPlts := Quantity / Item."Case Count";
                        rem := Quantity MOD Item."Case Count";

                        Plts := FORMAT(ROUND(decPlts, 1, '<')) + ' + ' + FORMAT(rem) + ' cs';
                    END;

                    Mil := Item."Film Gauge" / 25.4;

                    IF (Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case") <> 0 THEN
                        BagGrWt := (453 * Item."Net Weight") / (Item."Bags per Roll/Bundle" * Item."Rolls/Bundles per Case");

                    IF Item."Rolls/Bundles per Case" <> 0 THEN
                        RollWt := Item."Net Weight" / Item."Rolls/Bundles per Case";
                end;

                trigger OnPreDataItem()
                begin
                    Counter := 1;
                end;
            }
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

    trigger OnInitReport()
    begin
        TotCommentLines := 10;
    end;

    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        Item: Record Item;
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMLine_: Record "Production BOM Line";
        Width: Text;
        Length: Text;
        BagDimension: Code[20];
        Plts: Code[20];
        Counter1: Code[20];
        NoCommentLines: Integer;
        Position: Integer;
        TotCommentLines: Integer;
        //i: Integer;
        Counter: Integer;
        // j: Integer;
        // k: Integer;
        MANUFACTURING_WORK_ORDERCaptionLbl: Label 'MANUFACTURING WORK ORDER';
        //MATERIALSCaptionLbl: Label 'MATERIALS';
        MICRONCaptionLbl: Label 'MICRON';
        MILCaptionLbl: Label 'MIL';
        MATERIALCaptionLbl: Label 'MATERIAL';
        MFG_WO__CaptionLbl: Label 'MFG WO #';
        LENGTHCaptionLbl: Label 'LENGTH';
        WIDTHCaptionLbl: Label 'WIDTH';
        FILM_COLORCaptionLbl: Label 'FILM COLOR';
        OF_BAGS_ROLLSCaptionLbl: Label '# OF BAGS/ROLLS';
        OF_ROLLS_PER_CASECaptionLbl: Label '# OF ROLLS/PER CASE';
        of_CasesCaptionLbl: Label '# of Cases';
        of_PLTSCaptionLbl: Label '# of PLTS';
        PRINT_CaptionLbl: Label 'PRINT:';
        ROLL_GROSS_WTCaptionLbl: Label 'ROLL GROSS WT';
        TOTAL_PACKCaptionLbl: Label 'TOTAL PACK';
        lbs_CaptionLbl: Label 'lbs.';
        gr_CaptionLbl: Label 'gr.';
        SCRAP_ITEM_KEYCaptionLbl: Label 'SCRAP ITEM KEY';
        INK_3CaptionLbl: Label 'INK 3';
        decPlts: Decimal;
        rem: Decimal;
        Mil: Decimal;
        BagGrWt: Decimal;
        RollWt: Decimal;
        // BOMItems: array[100] of Text[250];
        INK_2CaptionLbl: Label 'INK 2';
        INK_1CaptionLbl: Label 'INK 1';
        Item_KeyCaptionLbl: Label 'Item Key';
        Due_DateCaptionLbl: Label 'Due Date';
        DIE_CUT_ITEM_KEYCaptionLbl: Label 'DIE CUT ITEM KEY';
        CS_PER_PLTCaptionLbl: Label 'CS PER PLT';
        CASE_GROSS_WTCaptionLbl: Label 'CASE GROSS WT';
        CASE_NET_WTCaptionLbl: Label 'CASE NET WT';
        CoreCaptionLbl: Label 'Core';
        COMMENTSCaptionLbl: Label 'COMMENTS';
        BAG_GRAM_WTCaptionLbl: Label 'BAG GRAM WT';
        BoxCaptionLbl: Label 'Box';
        QtyLbl: Label 'Qty.';
    // "----": Integer;
    // Docno_g: Code[20];
    // Status_g: Option;
    // LineNo_g: Integer;
}

