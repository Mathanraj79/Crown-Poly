report 50047 "Make-To Stock"
{
    Caption = 'Make-To Stock';
    ProcessingOnly = true;
     ApplicationArea = all;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Replenishment System" = FILTER("Prod. Order"),
                                      "Manufacturing Policy" = FILTER("Make-to-Stock"),
                                      "Reordering Policy" = FILTER("Maximum Qty."));
            RequestFilterFields = "No.", "Item Category Code";

            trigger OnAfterGetRecord()
            var
                RequisitionLine: Record "Requisition Line";
                ProdOrderLine: Record "Prod. Order Line";
                ReqLine: Record "Requisition Line";
                OrderTrackingEntry: Record "Reservation Entry";
                ProdQty: Decimal;
                QtyToCreate: Decimal;
                Window: Dialog;
                Counter: Integer;
                OrderQty: Decimal;
            begin
                //SCSML02 New menu item
                Window.OPEN(Text006Lbl + Text007Lbl);

                CALCFIELDS(Inventory);
                OrderTrackingEntry.SETRANGE("Item No.", "No.");
                OrderTrackingEntry.SETRANGE("Source Type", 5406);
                OrderTrackingEntry.SETRANGE("Reservation Status", OrderTrackingEntry."Reservation Status"::Reservation);
                IF OrderTrackingEntry.FINDSET() THEN
                    REPEAT
                        OrderQty += OrderTrackingEntry."Quantity (Base)";
                    UNTIL OrderTrackingEntry.NEXT() = 0;


                ProdOrderLine.SETCURRENTKEY("Item No.");
                ProdOrderLine.SETRANGE("Item No.", "No.");
                ProdOrderLine.CALCSUMS("Remaining Quantity");
                ProdQty := ProdOrderLine."Remaining Quantity";

                CALCFIELDS(Inventory);
                IF OrderQty = ProdQty THEN
                    QtyToCreate := "Safety Stock Quantity" - Inventory
                ELSE
                    QtyToCreate := "Safety Stock Quantity" - (ProdQty - OrderQty) - Inventory;

                IF QtyToCreate > 0 THEN BEGIN
                    RequisitionLine.INIT();
                    RequisitionLine.RESET();
                    RequisitionLine.SETRANGE("Worksheet Template Name", WorksheetemplateName);
                    RequisitionLine.SETRANGE("Journal Batch Name", JournalBatchName);
                    IF RequisitionLine.FINDLAST() THEN;

                    ReqLine.INIT();
                    ReqLine."Worksheet Template Name" := WorksheetemplateName;
                    ReqLine."Journal Batch Name" := JournalBatchName;
                    ReqLine."Line No." := RequisitionLine."Line No." + 10000;
                    ReqLine.VALIDATE(Type, ReqLine.Type::Item);
                    ReqLine.VALIDATE("No.", "No.");
                    ReqLine.VALIDATE(Quantity, QtyToCreate);
                    ReqLine.VALIDATE("Direct Unit Cost", "Unit Cost");
                    ReqLine.VALIDATE("Action Message", ReqLine."Action Message"::New);
                    ReqLine.VALIDATE("Accept Action Message", TRUE);
                    ReqLine.INSERT();
                END;

                Window.UPDATE(1, "No.");
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Replenishment System", "Replenishment System"::"Prod. Order");
                SETRANGE("Manufacturing Policy", "Manufacturing Policy"::"Make-to-Stock");
                SETRANGE("Reordering Policy", "Reordering Policy"::"Maximum Qty.");
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
        IF ((WorksheetemplateName <> '') AND (JournalBatchName <> '')) THEN BEGIN
            RequisitionLine_.SETRANGE("Worksheet Template Name", WorksheetemplateName);
            RequisitionLine_.SETRANGE("Journal Batch Name", JournalBatchName);
            RequisitionLine_.DELETEALL();
        END;
    end;

    var
        RequisitionLine_: Record "Requisition Line";
        Itemrec: Record Item;
        Text006Lbl: Label 'Calculating the Production Orders  plan...\\';
        Text007Lbl: Label 'Item No.  #1##################',comment = '%1';
        Text008Lbl: Label 'Creating Production Orders for...\\';
        WorksheetemplateName: Code[10];
        JournalBatchName: Code[10];



    procedure SetJnl(WorksheetemplateName2: Code[10]; JournalBatchName2: Code[10])
    begin
        WorksheetemplateName := WorksheetemplateName2;
        JournalBatchName := JournalBatchName2;
    end;
}

