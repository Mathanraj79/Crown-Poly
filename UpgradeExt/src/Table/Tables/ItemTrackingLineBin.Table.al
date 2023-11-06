table 50043 "Item Tracking Line Bin"
{
    Caption = 'Item Tracking Line Bin';
    DataClassification = CustomerContent;
    DrillDownPageID = 50049;
    LookupPageID = 50049;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(4; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(10; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(11; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(12; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
        }
        field(13; "Source Batch Name"; Code[10])
        {
            Caption = 'Source Batch Name';
        }
        field(14; "Source Prod. Order Line"; Integer)
        {
            Caption = 'Source Prod. Order Line';
        }
        field(15; "Source Ref. No."; Integer)
        {
            Caption = 'Source Ref. No.';
        }
        field(24; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(28; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(29; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(40; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(41; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(50; "Qty. to Handle (Base)"; Decimal)
        {
            Caption = 'Qty. to Handle (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TESTFIELD("Bin Code");
            end;
        }
        field(52; "Quantity Handled (Base)"; Decimal)
        {
            Caption = 'Quantity Handled (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(60; "Qty. to Handle"; Decimal)
        {
            Caption = 'Qty. to Handle';
            DecimalPlaces = 0 : 5;
        }
        field(5400; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(5401; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5402; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = "Item Storage Bin"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                 "Zone Code" = FIELD("Zone Code"),
                                                                 "Item No." = FIELD("Item No."));
        }
        field(50002; "Zone Code"; Code[20])
        {
            Caption = 'Zone Code';
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"),
                                             "Storage Zone" = CONST(true));

            trigger OnValidate()
            begin
                "Bin Code" := '';
            end;
        }
        field(50003; "Line No."; Integer)
        {
        }
        field(50004; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionMembers = "Tracking Specification","Reservation Entry";
        }
        field(50005; "Source Entry No."; Integer)
        {
            Caption = 'Source Entry No.';
        }
        field(50006; "Source Entry Type"; Option)
        {
            Caption = 'Source Entry Type';
            OptionMembers = "Tracking Specification","Reservation Entry";
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Entry No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Qty. to Handle (Base)", "Quantity Handled (Base)";
        }
        key(Key3; "Lot No.", "Serial No.")
        {
        }
        key(Key4; "Source Entry Type", "Source Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

