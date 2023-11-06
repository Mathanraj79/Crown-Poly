table 50017 "Customer Items Combinations"
{
    Caption = 'Customer Items Combinations';
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

