pageextension 50119 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Method Code1';
        }
        modify("Purchaser Code")
        {
            Caption = 'Purchaser Code';
            Importance = Promoted;
        }
        modify("Expected Receipt Date")
        {
            Caption = 'Expected Receipt Date 1';
            // trigger on()
            // var
            //     myInt: Integer;
            // begin

            // end;
        }


    }
    actions
    {
        modify("&Print")
        {
            Promoted = true;

            PromotedCategory = Process;
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                IF Rec.Status <> rec.Status::Released THEN
                    Error(CPText002);
                PurchSetup.GET();
                begin
                    //     MaxAmount := PurchSetup."Max Purch. W/O Approval";
                    //     IF UserSetup.GET("Dept Approval") THEN
                    //         MaxAmount := UserSetup."PO Approval Limit";
                    //     IF UserSetup.GET("Executive Approval") THEN
                    //         IF UserSetup."PO Approval Limit" > MaxAmount THEN
                    //             MaxAmount := UserSetup."PO Approval Limit";

                    //     CALCFIELDS("Amount Including VAT");
                    //     IF "Amount Including VAT" > MaxAmount THEN
                    //         ERROR(CPText003);
                end;
                // DocPrint.PrintPurchHeader(Rec);
            end;
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CheckResin();
    end;

    var
        MaxAmount: Decimal;
        PurchSetup: Record 312;
        UserSetup: Record 91;
        PurchaseLine: Record 39;
        FoundResin: Boolean;
        Item: Record 27;
        CPText001: TextConst ENU = 'You cannot view the Order Statistics screen because there are Resin items and you are not setup for Resin.';
        CPText002: TextConst ENU = 'Please release PO before printing.';
        CPText003: TextConst ENU = 'Please get appropriate approvals.';

    PROCEDURE CheckResin();
    BEGIN
        //SCSML new function for Resin items
        FoundResin := FALSE;
        IF UserSetup.GET(USERID) THEN BEGIN
            //   IF NOT UserSetup.Resin THEN BEGIN
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", rec."Document Type");
            PurchaseLine.SETRANGE("Document No.", rec."No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            IF PurchaseLine.FINDSET() THEN BEGIN
                REPEAT
                    IF PurchaseLine."No." <> '' THEN BEGIN
                        Item.GET(PurchaseLine."No.");
                        //IF Item.Resin THEN
                        FoundResin := TRUE;
                    END;
                UNTIL PurchaseLine.NEXT() = 0;
            END;
            IF NOT FoundResin THEN BEGIN
                //      "Resin Total Amount" := "Total PO Amount";
                //      "Resin Amount Approved" := "Amount Approved";
            END ELSE BEGIN
                //         "Resin Total Amount" := 0;
                //   //      "Resin Amount Approved" := 0;
            END;
        END ELSE BEGIN
            //       "Resin Total Amount" := "Total PO Amount";
            //   //    "Resin Amount Approved" := "Amount Approved";
        END;
    END;
    //END;

}
