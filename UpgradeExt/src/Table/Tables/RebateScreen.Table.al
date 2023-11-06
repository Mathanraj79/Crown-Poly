table 50001 "Rebate Screen"
{
    Caption = 'Rebate Screen';
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
        field(3; Description; Text[30])
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
        field(6; "Instant Credit"; Decimal)
        {
            Caption = 'Instant Credit';
        }
        field(7; "Proof of Delivery Rebate"; Decimal)
        {
            Caption = 'Proof of Delivery Rebate';
        }
        field(8; "Quarterly Rebate"; Decimal)
        {
            Caption = 'Quarterly Rebate';
        }
        field(9; "Quarterly Rebate %"; Decimal)
        {
            Caption = 'Quarterly Rebate %';
        }
        field(10; "Annual Rebate"; Decimal)
        {
            Caption = 'Annual Rebate';
        }
        field(11; "Annual Rebate %"; Decimal)
        {
            Caption = 'Annual Rebate %';
        }
        field(12; "End User Annual Rebate"; Decimal)
        {
            Caption = 'End User Annual Rebate';
        }
        field(13; "End User Annual Rebate %"; Decimal)
        {
            Caption = 'End User Annual Rebate %';
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

