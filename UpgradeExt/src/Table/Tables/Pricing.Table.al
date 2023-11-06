table 50000 Pricing
{
    Caption = 'Pricing';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(7; "Min. Qty"; Decimal)
        {
            Caption = 'Min. Qty';
        }
        field(8; "Combined Minimum Qty."; Decimal)
        {
            Caption = 'Combined Minimum Qty.';
        }
        field(9; "Ship Via"; Code[20])
        {
            Caption = 'Ship Via';
            TableRelation = "Shipment Method";
        }
        field(10; Comment; Text[150])
        {
            Caption = 'Comment';
        }
        field(12; "Freight Allowance"; Decimal)
        {
            Caption = 'Freight Allowance';
        }
        field(13; Broker; Code[20])
        {
            Caption = 'Broker';
            TableRelation = "Salesperson/Purchaser";
        }
        field(14; Salesperson; Code[20])
        {
            Caption = 'Salesperson';
            TableRelation = "Salesperson/Purchaser";
        }
        field(15; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Item No.", "Start Date", "Min. Qty", "Combined Minimum Qty.", "Ship Via", "End Date", "Unit Price")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

