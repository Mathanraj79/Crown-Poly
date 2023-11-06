tableextension 50024 SalesCrMemoLineEx extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50004; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            OptionMembers = "","Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
            Description = 'SCSEL 07-17-07';
            Editable = false;
        }
        field(50015; "Bags per Case"; Integer)
        {
            Caption = 'Bags per Case';
            DataClassification = CustomerContent;
            Description = 'SCSEL 121907';
        }
        field(50016; "Bags Count"; Decimal)
        {
            Caption = 'Bags Count';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'SCSEL 121907';
        }
        field(50017; "Film Color"; Code[20])
        {
            Caption = 'Film Color';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Film Color" WHERE("No." = FIELD("No.")));
            Description = '002';
        }
    }
    keys
    {
        key(key9; "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code") { }
        key(key10; "Sell-to Customer No.", Type, "No.") { }
        key(key11; "Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code") { }
        key(key12; Type, "No.", "Sell-to Customer No.") { }

    }
}
