table 50026 "Output Journal"
{
    Caption = 'Output Journal';
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
        field(10; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
        }
        field(11; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Work Center,Machine Center, ';
            OptionMembers = "Work Center","Machine Center"," ";
        }
        field(12; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST("Work Center")) "Work Center";
        }
        field(13; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
        }
        field(15; "Output Quantity"; Decimal)
        {
            Caption = 'Output Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(16; Shift; Code[10])
        {
            Caption = 'Shift';
        }
        field(17; "Lot No."; Code[10])
        {
            Caption = 'Lot No.';
        }
        field(18; "Division Item Category"; Code[20])
        {
            Caption = 'Division Item Category';
        }
        field(19; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(20; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(21; Validated; Boolean)
        {
            Caption = 'Validated';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Prod. Order No.")
        {
            SumIndexFields = "Output Quantity";
        }
    }

    fieldgroups
    {
    }
}

