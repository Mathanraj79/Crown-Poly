table 50028 "Consumption Journal"
{
    Caption = 'Consumption Journal';
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
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Production Order No."; Code[20])
        {
            Caption = 'Production Order No.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(7; "Lot No."; Code[10])
        {
            Caption = 'Lot No.';
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(10; "Machine Center Code"; Code[20])
        {
            Caption = 'Machine Center Code';
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(12; Completed; Boolean)
        {
            Caption = 'Completed';
        }
        field(13; Shift; Code[10])
        {
            Caption = 'Shift';
        }
        field(14; Validated; Boolean)
        {
            Caption = 'Validated';
        }
        field(15; "Division Item Category"; Code[20])
        {
            Caption = 'Division Item Category';
        }
        field(16; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
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

