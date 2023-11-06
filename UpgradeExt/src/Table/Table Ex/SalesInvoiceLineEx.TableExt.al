tableextension 50022 SalesInvoiceLineEx extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Header Posting Date"; Date)
        {
            Caption = 'Header Posting Date';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(50001; "Header Broker 1"; Code[20])
        {
            Caption = 'Header Broker 1';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Broker 1" WHERE("No." = FIELD("Document No.")));
            Editable = false;

        }
        field(50002; "Header Broker 2"; Code[20])
        {
            Caption = 'Header Broker 2';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Broker 2" WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(50003; "Header Salesperson Code"; Code[20])
        {
            Caption = 'Header Salesperson Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Invoice Header"."Salesperson Code" WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(50004; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            OptionMembers = "","Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
            Description = 'SCSEL 07-17-07';
            Editable = false;
        }
        field(50005; "Zero Price"; Boolean)
        {
            Caption = 'Zero Price';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
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
        key(key10; "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code") { }
        key(key11; "Sell-to Customer No.", Type, "No.") { }
        key(key12; "Sell-to Customer No.", "Shipment Date", "Shortcut Dimension 1 Code") { }
        key(key13; "Sell-to Customer No.", "Posting Date", "Shortcut Dimension 1 Code") { }
        key(key14; Type, "No.", "Sell-to Customer No.") { }

    }
}
