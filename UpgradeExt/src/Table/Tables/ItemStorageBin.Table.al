table 50041 "Item Storage Bin"
{
    // SSC56 - new object

    Caption = 'Item Storage Bin';
    DataClassification = CustomerContent;
    // DrillDownPageID = 50017;
    // LookupPageID = 50017;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = Location;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Location Code" <> xRec."Location Code") THEN BEGIN
                    "Bin Code" := '';
                END;
            end;
        }
        field(2; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            NotBlank = true;
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"),
                                             "Storage Zone" = CONST(true));
        }
        field(3; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            NotBlank = true;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Zone Code" = FIELD("Zone Code"));
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF (CurrFieldNo <> 0) AND ("Item No." <> xRec."Item No.") THEN BEGIN
                    "Variant Code" := '';
                END;

                IF ("Item No." <> xRec."Item No.") AND ("Item No." <> '') THEN BEGIN
                    GetItem("Item No.");
                    VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                END;
            end;
        }
        field(41; Default; Boolean)
        {
            Caption = 'Default';

            trigger OnValidate()
            begin
                IF (xRec.Default <> Default) AND Default THEN
                    IF WMSManagement.CheckDefaultBin(
                         "Item No.", "Variant Code", "Location Code", "Bin Code")
                    THEN
                        ERROR(Text010, "Location Code", "Item No.", "Variant Code");
            end;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
    }

    keys
    {
        key(Key1; "Location Code", "Zone Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; Default, "Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        BinContent: Record "Bin Content";
    begin
    end;

    trigger OnInsert()
    begin
        IF Default THEN
            IF WMSManagement.CheckDefaultBin(
                 "Item No.", "Variant Code", "Location Code", "Bin Code")
            THEN
                ERROR(Text010, "Location Code", "Item No.", "Variant Code");

        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
            TESTFIELD("Zone Code")
        ELSE
            TESTFIELD("Zone Code", '');
    end;

    trigger OnModify()
    begin
        IF Default THEN
            IF WMSManagement.CheckDefaultBin(
                 "Item No.", "Variant Code", "Location Code", "Bin Code")
            THEN
                ERROR(Text010, "Location Code", "Item No.", "Variant Code");

        GetLocation("Location Code");
        IF Location."Directed Put-away and Pick" THEN
            TESTFIELD("Zone Code")
        ELSE
            TESTFIELD("Zone Code", '');
    end;

    var
        Item: Record Item;
        Location: Record Location;
        Bin: Record Bin;
        Text000: Label 'You cannot delete this %1, because the %1 contains items.';
        Text001: Label 'You cannot delete this %1, because warehouse document lines have items allocated to this %1.';
        Text002: Label 'The total cubage %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?';
        Text003: Label 'The total weight %1 of the %2 for the %5 exceeds the %3 %4 of the %5.\Do you still want enter this %2?';
        Text004: Label 'Cancelled.';
        Text005: Label 'The %1 %2 must not be less than the %3 %4.';
        Text006: Label 'available must not be less than %1';
        UOMMgt: Codeunit "Unit of Measure Management";
        Text007: Label 'You cannot modify the %1, because the %2 contains items.';
        Text008: Label 'You cannot modify the %1, because warehouse document lines have items allocated to this %2.';
        Text009: Label 'You must first set up user %1 as a warehouse employee.';
        Text010: Label 'There is already a default bin content for location code %1, item no. %2 and variant code %3.';
        WMSManagement: Codeunit "WMS Management";
        StockProposal: Boolean;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF Location.Code <> LocationCode THEN
            Location.GET(LocationCode);
    end;

    procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
        IF (LocationCode = '') OR (BinCode = '') THEN
            Bin.INIT
        ELSE
            IF (Bin."Location Code" <> LocationCode) OR
               (Bin.Code <> BinCode)
            THEN
                Bin.GET(LocationCode, BinCode);
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        IF Item."No." = ItemNo THEN
            EXIT;

        IF ItemNo = '' THEN
            Item.INIT
        ELSE
            Item.GET(ItemNo);
    end;

    procedure GetItemDescr(ItemNo: Code[20]; VariantCode: Code[10]; var ItemDescription: Text[50])
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        OldItemNo: Code[20];
    begin
        ItemDescription := '';
        IF ItemNo <> OldItemNo THEN BEGIN
            ItemDescription := '';
            IF ItemNo <> '' THEN BEGIN
                IF Item.GET(ItemNo) THEN
                    ItemDescription := Item.Description;
                IF VariantCode <> '' THEN
                    IF ItemVariant.GET(ItemNo, VariantCode) THEN
                        ItemDescription := ItemVariant.Description;
            END;
            OldItemNo := ItemNo;
        END;
    end;

    procedure GetWhseLocation(var CurrentLocationCode: Code[10]; var CurrentZoneCode: Code[10])
    var
        Location: Record Location;
        WhseEmployee: Record "Warehouse Employee";
        WMSMgt: Codeunit "WMS Management";
    begin
        IF USERID <> '' THEN BEGIN
            WhseEmployee.SETRANGE("User ID", USERID);
            IF NOT WhseEmployee.FINDFIRST() THEN
                ERROR(Text009, USERID);
            IF CurrentLocationCode <> '' THEN BEGIN
                IF NOT Location.GET(CurrentLocationCode) THEN BEGIN
                    CurrentLocationCode := '';
                    CurrentZoneCode := '';
                END ELSE
                    IF NOT Location."Bin Mandatory" THEN BEGIN
                        CurrentLocationCode := '';
                        CurrentZoneCode := '';
                    END ELSE BEGIN
                        WhseEmployee.SETRANGE("Location Code", CurrentLocationCode);
                        IF NOT WhseEmployee.FINDFIRST() THEN BEGIN
                            CurrentLocationCode := '';
                            CurrentZoneCode := '';
                        END;
                    END
                    ;
                IF CurrentLocationCode = '' THEN BEGIN
                    CurrentLocationCode := WMSMgt.GetDefaultLocation();
                    IF CurrentLocationCode <> '' THEN BEGIN
                        Location.GET(CurrentLocationCode);
                        IF NOT Location."Bin Mandatory" THEN
                            CurrentLocationCode := '';
                    END;
                END;
            END;
        END;
        FILTERGROUP := 2;
        IF CurrentLocationCode <> '' THEN
            SETRANGE("Location Code", CurrentLocationCode)
        ELSE
            SETRANGE("Location Code");
        IF CurrentZoneCode <> '' THEN
            SETRANGE("Zone Code", CurrentZoneCode)
        ELSE
            SETRANGE("Zone Code");
        FILTERGROUP := 0;
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        ReservEntry: Record "Reservation Entry";
        ItemNo: Code[20];
        VariantCode: Code[10];
        BinCode: Code[20];
        LotNo: Code[20];
        SerialNo: Code[20];
        FormCaption: Text[250];
        SourceTableName: Text[30];
    begin
        SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 14);
        FormCaption := STRSUBSTNO('%1 %2', SourceTableName, "Location Code");
        IF GETFILTER("Item No.") <> '' THEN
            IF GETRANGEMIN("Item No.") = GETRANGEMAX("Item No.") THEN BEGIN
                ItemNo := GETRANGEMIN("Item No.");
                IF ItemNo <> '' THEN BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    FormCaption := STRSUBSTNO('%1 %2 %3', FormCaption, SourceTableName, ItemNo)
                END;
            END;

        IF GETFILTER("Bin Code") <> '' THEN
            IF GETRANGEMIN("Bin Code") = GETRANGEMAX("Bin Code") THEN BEGIN
                BinCode := GETRANGEMIN("Bin Code");
                IF BinCode <> '' THEN BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 7354);
                    FormCaption := STRSUBSTNO('%1 %2 %3', FormCaption, SourceTableName, BinCode);
                END;
            END;

        EXIT(FormCaption);
    end;
}

