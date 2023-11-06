report 50013 "Inventory Analysis by Location"
{
    // //IWEB350 - Added ShelfNo and Round QOH and Available Quantity
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\InventoryAnalysisbyLocation.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inventory Analysis by Location';
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Location Filter";
            column(TODAY; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(ShelfNo_Item; "Shelf No.")
            {
            }
            column(MinAmount; MinAmount)
            {
                DecimalPlaces = 0 : 0;
            }
            column(MinAmount_Available; MinAmount - Available)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item_Qty_to_Ship_on_Sales_Orders; "Qty. to Ship on Sales Orders")
            {
            }
            column(Item_Inventory; Inventory)
            {
            }
            column(Itm_Inventory; Itm.Inventory)
            {
            }
            column(Available; Available)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ITEMCaption_; ITEMCaption_Lbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(ON_HANDCaption; ON_HANDCaptionLbl)
            {
            }
            column(IN_TRANSITCaption; IN_TRANSITCaptionLbl)
            {
            }
            column(Orders_to_Ship_to_CustomersCaption; Orders_to_Ship_to_CustomersCaptionLbl)
            {
            }
            column(AVAILABLECaption; AVAILABLECaptionLbl)
            {
            }
            column(MINCaption; MINCaptionLbl)
            {
            }
            column(Qty_to_Ship_to_WarehouseCaption; Qty_to_Ship_to_WarehouseCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MinAmount := 0;
                CALCFIELDS("Qty. to Ship on Sales Orders", Inventory);

                ItemLocation.RESET();
                IF ItemLocation.GET("No.", LocationCode) THEN
                    MinAmount := ItemLocation.Min
                ELSE
                    CurrReport.SKIP();

                CLEAR(Itm);
                IF Location.GET(LocationCode) THEN BEGIN
                    Itm.GET("No.");
                    Itm.SETRANGE("Location Filter", Location."In Transit Code");
                    Itm.CALCFIELDS(Inventory);
                END;

                Available := 0;
                Available := Inventory + Itm.Inventory - "Qty. to Ship on Sales Orders";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
    }

    trigger OnPreReport()
    begin
        LocationCode := Item.GETFILTER("Location Filter");

        IF LocationCode = '' THEN
            ERROR('Please Enter Location');
    end;

    var
        Itm: Record Item;
        Location: Record Location;
        ItemLocation: Record "Item Location Min/Max";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        LocationCode: Code[10];
        MinAmount: Decimal;
        Available: Decimal;

        ItemCaptionLbl: Label 'Item';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ITEMCaption_Lbl: Label 'ITEM';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        ON_HANDCaptionLbl: Label 'ON HAND';
        IN_TRANSITCaptionLbl: Label 'IN TRANSIT';
        Orders_to_Ship_to_CustomersCaptionLbl: Label 'Orders to Ship to Customers';
        AVAILABLECaptionLbl: Label 'AVAILABLE';
        MINCaptionLbl: Label 'MIN';
        Qty_to_Ship_to_WarehouseCaptionLbl: Label 'Qty to Ship to Warehouse';

}

