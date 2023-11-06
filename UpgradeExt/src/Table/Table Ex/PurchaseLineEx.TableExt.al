tableextension 50013 PurchaseLineEx extends "Purchase Line"
{
    fields
    {
        field(50000; "Resin Unit Cost"; Decimal)
        {
            Caption = 'Resin Unit Cost';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Unit Cost (LCY)" := "Resin Unit Cost";
                VALIDATE("Unit Cost (LCY)");
                //SCSML END

            end;
        }
        field(50001; "Resin Direct Unit Cost"; Decimal)
        {
            Caption = 'Resin Direct Unit Cost';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            AutoFormatExpression = "Currency Code";
            CaptionClass = GetCaptionClass(FIELDNO("Resin Direct Unit Cost"));
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Direct Unit Cost" := "Resin Direct Unit Cost";
                VALIDATE("Direct Unit Cost");

                IF UserSetup.GET() THEN
                    IF UserSetup.Resin THEN
                        "Resin Line Amount" := "Resin Direct Unit Cost" * Quantity
                    ELSE
                        "Resin Line Amount" := 0;
                //SCSML END
            end;
        }
        field(50002; "Resin Line Amount"; Decimal)
        {
            Caption = 'Resin Line Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(70000; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                //SSC70 - 20101216 Start
                TestStatusOpen();
                //SSC70 - 20101216 End
            end;
        }
        modify("Description 2")
        {
            trigger OnAfterValidate()
            begin
                //SSC70 - 20101216 Start
                TestStatusOpen();
                //SSC70 - 20101216 End
            end;
        }
        modify("Unit of Measure")
        {
            trigger OnAfterValidate()
            begin
                //SSC70 - 20101216 Start
                TestStatusOpen();
                //SSC70 - 20101216 End
            end;
        }

    }
    keys
    {
        key(key25; "Document Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Expected Receipt Date") { }
    }

    var
        PurchHeader: Record "Purchase Header";
        UserSetup: record "User Setup";

    trigger OnAfterInsert()
    begin
        //BusSnapShot
        GetPurchHeader();
        "Posting Date" := PurchHeader."Posting Date";
        //end Buss
    end;

}
