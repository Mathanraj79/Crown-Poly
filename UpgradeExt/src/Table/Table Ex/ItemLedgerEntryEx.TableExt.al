tableextension 50009 ItemLedgerEntryEx extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Machine Center Code"; Code[20])
        {
            Caption = 'Machine Center Code';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50005; Shift; Code[10])
        {
            Caption = 'Shift';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50006; "Scarp Item"; Boolean)
        {
            Caption = 'Scarp Item';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Scrap WHERE("No." = FIELD("Item No.")));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(50007; "Total Resin Pounds"; Decimal)
        {
            Caption = 'Total Resin Pounds';
            FieldClass = FlowField;
            CalcFormula = Sum("Production BOM Line".Quantity WHERE("Production BOM No." = FIELD("Production BOM No."),
                     "Resin Item" = FILTER(true)));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(50008; "Total Srcap %"; Decimal)
        {
            Caption = 'Total Srcap %';
            FieldClass = FlowField;
            CalcFormula = Sum("Production BOM Line"."Scrap Qty" WHERE("Production BOM No." = FIELD("Production BOM No."),
                       "Resin Item" = FILTER(true)));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(50009; "Item Desciption"; Text[100])
        {
            Caption = 'Item Desciption';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(50010; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50011; "Work Center Code"; Code[20])
        {
            Caption = 'Work Center Code';
            DataClassification = CustomerContent;
            TableRelation = "Work Center";
            Description = 'SCSSM01';
        }
        field(50012; "Total Scrap"; Decimal)
        {
            Caption = 'Total Scrap';
            FieldClass = FlowField;
            CalcFormula = Sum("Production BOM Line".Quantity WHERE(Type = FILTER(Item),
                       "No." = FIELD("Item No."),
                              "Production BOM No." = FIELD("Production BOM No."),
                               "Scrap Item" = FILTER(true)));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(71000; "Rolls/Bundles per Case"; Integer)
        {
            Caption = 'Rolls/Bundles per Case';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Rolls/Bundles per Case" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(71001; "Bags per Roll/Bundle"; Integer)
        {
            Caption = 'Bags per Roll/Bundle';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Bags per Roll/Bundle" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
        field(71002; "Die Cut Scrap"; Boolean)
        {
            Caption = 'Die Cut Scrap';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Die Cut Scrap" WHERE("No." = FIELD("Item No.")));
            Editable = false;
        }
    }
    keys
    {

        key(key24; "Document No.", "Entry Type", "Item No.") { }
        key(key25; "Item No.", "Variant Code", "Variant Code", "Posting Date") { }
        key(key26; "Posting Date") { }
        key(key28; "Item No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Drop Shipment", "Variant Code", "Lot No.", "Serial No.", "Posting Date") { }
    }
}