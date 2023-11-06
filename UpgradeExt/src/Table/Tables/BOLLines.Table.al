table 50023 "BOL Lines"
{
    Caption = 'BOL Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "NMFC Item No."; Code[20])
        {
            Caption = 'NMFC Item No.';
            TableRelation = "NMFC Items"."NMFC Item No.";

            trigger OnValidate()
            begin
                IF recItem.GET("NMFC Item No.") THEN BEGIN
                    "Package Type" := recItem."Package Type";
                    Class := recItem.Class;
                    "Item No." := recItem."No.";
                    Description := recItem.Description;
                END;
            end;
        }
        field(4; Description; Text[120])
        {
            Caption = 'Description';
        }
        field(5; "Package Type"; Code[20])
        {
            Caption = 'Package Type';
        }
        field(6; "Shipping Units (Qty.)"; Decimal)
        {
            Caption = 'Shipping Units (Qty.)';
            DecimalPlaces = 0 : 0;
        }
        field(7; Class; Decimal)
        {
            Caption = 'Class';
            DecimalPlaces = 0 : 0;
        }
        field(8; Weight; Decimal)
        {
            Caption = 'Weight';
        }
        field(9; "Order No."; Code[20])
        {
            Caption = 'Order No.';


            trigger OnValidate()
            var
                BOLOrder: Record "BOL Order";
                BOLOrder2: Record "BOL Order";
            begin
                IF "Order No." <> '' THEN
                    IF CONFIRM(Text003Lbl, TRUE, "Order No.") THEN BEGIN
                        BOLOrder."Order No." := "Order No.";
                        BOLOrder."BOL No." := "No.";
                        BOLOrder.INSERT();
                    END;

                IF xRec."Order No." <> '' THEN
                    IF "Order No." = '' THEN
                        IF CONFIRM(Text004Lbl, TRUE, xRec."Order No.") THEN BEGIN
                            BOLOrder2.RESET();
                            IF BOLOrder2.GET("No.", xRec."Order No.") THEN
                                BOLOrder2.DELETE();
                            DELETE(FALSE);
                        END ELSE
                            ERROR(Text005Lbl);
            end;
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "NMFC Items"."No.";

            trigger OnValidate()
            begin
                recItem.SETRANGE("No.", "Item No.");
                IF recItem.FINDFIRST() THEN BEGIN
                    "Package Type" := recItem."Package Type";
                    Class := recItem.Class;
                    "NMFC Item No." := recItem."NMFC Item No.";
                    Description := recItem.Description;
                END;
            end;
        }
        field(11; "No. Of Pallets Per Line"; Decimal)
        {
            Caption = 'No. Of Pallets Per Line';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Shipping Units (Qty.)", "No. Of Pallets Per Line";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "Order No." <> '' THEN
            IF CONFIRM(Text001Lbl, TRUE, "Order No.") THEN BEGIN
                recSalesHeader.RESET();
                recSalesHeader.SETRANGE("Document Type", recSalesHeader."Document Type"::Order);
                recSalesHeader.SETRANGE("No.", "Order No.");
                recSalesHeader."BOL No." := '';
                recSalesHeader.Modify();
            END ELSE
                ERROR(Text002Lbl);
    END;

    trigger OnInsert()
    begin
        IF ("NMFC Item No." <> '') OR ("Order No." <> '') THEN BEGIN
            recBOLLine.SETRANGE("No.", Rec."No.");
            IF recBOLLine.FIND('+') THEN
                "Line No." := recBOLLine."Line No." + 1000
            ELSE
                "Line No." := 1000;
        END ELSE
            INSERT(FALSE);
    end;

    var
        recItem: Record "NMFC Items";
        recSalesHeader: Record "Sales Header";
        recBOLLine: Record "BOL Lines";
        Text001Lbl: Label 'Do you want to delete Order No. %1 from this Bill of Lading?', Comment = '%1 Order No.';
        Text002Lbl: Label 'Operation Stopped.';
        Text003Lbl: Label 'Would you like to add Order No. %1?', Comment = '%1 Order No.';
        Text004Lbl: Label 'Do you want to remove Order No. %1 from Bill of Lading?', Comment = '%1 No.';
        Text005Lbl: Label 'Process Canceled.';
}

