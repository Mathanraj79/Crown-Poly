pageextension 50143 "Req. Worksheet" extends "Req. Worksheet"
{

    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = all;
            }
            field("Maximum Inventory"; Rec."Maximum Inventory")
            {
                ApplicationArea = all;
            }

        }
        modify("Direct Unit Cost")
        {
            Editable = ResinEditable;

        }
    }
    actions
    {
        addafter(CarryOutActionMessage)
        {
            action("Calculate Production Order")
            {
                CaptionML = ENU = 'Calculate Production Orders';
                Promoted = true;
                Image = Calculate;
                PromotedCategory = Process;
                trigger OnAction()
                var
                //MaketoStock : Report 50047;
                begin

                end;

            }
            action("Create Production Order")
            {
                CaptionML = ENU = 'Create Production Orders';
                Promoted = true;
                Image = CreateDocument;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TempReqLine: Record 246;
                    ProductionOrder: Record 5405;
                    ProdOrderLine: Record 5406;
                begin
                    Window.OPEN(Text008 + Text007);

                    TempReqLine.INIT();
                    TempReqLine.RESET();
                    TempReqLine.COPYFILTERS(Rec);
                    TempReqLine.SETRANGE("Worksheet Template Name", rec."Worksheet Template Name");
                    TempReqLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    TempReqLine.SETRANGE("Accept Action Message", TRUE);
                    IF TempReqLine.FINDSET() THEN BEGIN
                        REPEAT
                            ProductionOrder.INIT();
                            ProductionOrder.VALIDATE(Status, ProductionOrder.Status::"Firm Planned");
                            ProductionOrder."No." := '';
                            ProductionOrder.INSERT(TRUE);
                            ProductionOrder.VALIDATE("Source Type", ProductionOrder."Source Type"::Item);
                            ProductionOrder.VALIDATE("Source No.", TempReqLine."No.");
                            ProductionOrder.VALIDATE(Quantity, TempReqLine.Quantity);
                            ProductionOrder.VALIDATE("Unit Cost", TempReqLine."Direct Unit Cost");
                            ProductionOrder.MODIFY();

                            ProdOrderLine.INIT();
                            ProdOrderLine.VALIDATE(Status, ProdOrderLine.Status::"Firm Planned");
                            ProdOrderLine.VALIDATE("Prod. Order No.", ProductionOrder."No.");
                            ProdOrderLine.VALIDATE("Line No.", 10000);
                            ProdOrderLine.VALIDATE("Item No.", TempReqLine."No.");
                            ProdOrderLine.VALIDATE(Quantity, TempReqLine.Quantity);
                            ProdOrderLine.VALIDATE("Unit Cost", TempReqLine."Direct Unit Cost");
                            ProdOrderLine.VALIDATE("Starting Date", ProductionOrder."Starting Date");
                            ProdOrderLine.VALIDATE("Due Date", ProductionOrder."Due Date");
                            ProdOrderLine.INSERT(TRUE);

                            Window.UPDATE(1, TempReqLine."No.");

                        UNTIL TempReqLine.NEXT() = 0;
                    END;
                    Window.CLOSE();

                    TempReqLine.DELETEALL();

                    CurrPage.UPDATE(FALSE);
                    MESSAGE(CPText001)

                end;
            }
        }
    }
    var
        ResinEditable: Boolean;
        Text006: TextConst ENU = 'Calculating the Production Orders  plan...\\';
        Text007: TextConst ENU = 'Item No.  #1##################';
        Text008: TextConst ENU = 'Creating Production Orders for...\\';
        CPText001: TextConst ENU = 'Production Orders have now been succesfully created.';
        Window: Dialog;



}
