table 50027 "Item Journal"
{
    Caption = 'Item Journal';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Output Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(16; Shift; Code[10])
        {
            Caption = 'Shift';
        }
        field(17; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(19; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(20; "Entry Type"; Integer)
        {
            Caption = 'Entry Type';
        }
        field(21; "Machine Center Code"; Code[20])
        {
            Caption = 'Machine Center Code';
        }
        field(22; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(23; Validated; Boolean)
        {
            Caption = 'Validated';
        }
        field(24; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(25; "Division Item Category"; Code[20])
        {
            Caption = 'Division Item Category';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

