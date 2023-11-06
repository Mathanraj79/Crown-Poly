table 50034 "BOL Order"
{
    Caption = 'BOL Order';
    DataClassification = CustomerContent;
    //DrillDownPageID = 50021;

    fields
    {
        field(1; "BOL No."; Code[20])
        {
            Caption = 'BOL No.';
        }
        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(3; Posted; Boolean)
        {
            Caption = 'Posted';
        }
    }

    keys
    {
        key(Key1; "BOL No.", "Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

