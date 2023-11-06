table 50031 "Rebate Information"
{
    Caption = 'Rebate Information';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';
            TableRelation = "Rebate Program Header";
        }
        field(2; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionCaption = 'Customer,End User';
            OptionMembers = Customer,"End User";
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Customer Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Customer Type" = FILTER("End User")) "End User";
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(5; "Quantity Claimed"; Decimal)
        {
            Caption = 'Quantity Claimed';
        }
        field(6; "Instant Amount"; Decimal)
        {
            Caption = 'Instant Amount';
        }
        field(7; "Monthly Amount"; Decimal)
        {
            Caption = 'Monthly Amount';
        }
        field(8; "POD Amount"; Decimal)
        {
            Caption = 'POD Amount';
        }
        field(9; "Annual Amount"; Decimal)
        {
            Caption = 'Annual Amount';
        }
        field(10; "Date Claimed"; Date)
        {
            Caption = 'Date Claimed';
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Customer Type", "No.", "Item No.", "Date Claimed")
        {
            Clustered = true;
            SumIndexFields = "Quantity Claimed";
        }
        key(Key2; "Customer Type", "Customer No.", "Item No.", "Date Claimed")
        {
            SumIndexFields = "Quantity Claimed";
        }
    }

    fieldgroups
    {
    }
}

