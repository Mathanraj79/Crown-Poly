table 50019 "Total Net Price"
{
    Caption = 'Total Net Price';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(3; "End User Cases"; Decimal)
        {
            Caption = 'End User Cases';
            Editable = false;
        }
        field(4; "End User Case Percent"; Decimal)
        {
            Caption = 'End User Case Percent';
        }
        field(5; "Base Price Case"; Decimal)
        {
            Caption = 'Base Price/Case';
        }
        field(6; Freight; Decimal)
        {
            Caption = 'Freight';
        }
        field(7; Instant; Decimal)
        {
            Caption = 'Instant';
        }
        field(8; POD; Decimal)
        {
            Caption = 'POD';
        }
        field(9; Quarterly; Decimal)
        {
            Caption = 'Quarterly';
        }
        field(10; Annually; Decimal)
        {
            Caption = 'Annually';
        }
        field(11; "Case Cost Deduction"; Decimal)
        {
            Caption = 'Case Cost Deduction';
        }
        field(12; "Broker Commission Percent"; Decimal)
        {
            Caption = 'Broker Commission Percent';
        }
        field(13; "Sales Commission Percent"; Decimal)
        {
            Caption = 'Sales Commission Percent';
        }
        field(14; "Single Net Price"; Decimal)
        {
            Caption = 'Single Net Price';
        }
        field(15; "Double Net Price"; Decimal)
        {
            Caption = 'Double Net Price';
        }
        field(16; "Triple Net Price"; Decimal)
        {
            Caption = 'Triple Net Price';
        }
        field(17; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(18; "End User No."; Code[20])
        {
            Caption = 'End User No.';
            TableRelation = "End User";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

