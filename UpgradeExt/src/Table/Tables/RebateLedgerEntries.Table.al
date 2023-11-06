table 50030 "Rebate Ledger Entries"
{
    Caption = 'Rebate Ledger Entries';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
            TableRelation = "Rebate Claim";
        }
        field(3; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';
            TableRelation = "Rebate Program Header";
        }
        field(4; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = Customer,"End User";
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Customer Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Customer Type" = FILTER("End User")) "End User";
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(7; "Rebate Type"; Option)
        {
            Caption = 'Rebate Type';
            OptionCaption = 'Instant Credit,Monthly,Quarterly,Annual';
            OptionMembers = "Instant Credit",Monthly,Quarterly,Annual;
        }
        field(8; "Rebate Method"; Option)
        {
            Caption = 'Rebate Method';
            OptionCaption = 'Credit Memo,Check';
            OptionMembers = "Credit Memo",Check;
        }
        field(9; "Quantity Claimed"; Decimal)
        {
            Caption = 'Quantity Claimed';
        }
        field(10; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(11; "Rebate Amount"; Decimal)
        {
            Caption = 'Rebate Amount';
        }
        field(12; "Instant Credits"; Boolean)
        {
            Caption = 'Instant Credits';
        }
        field(13; "Date Claimed"; Date)
        {
            Caption = 'Date Claimed';
        }
        field(14; "End User Cust No."; Code[20])
        {
            Caption = 'End User Cust No.';
            TableRelation = Customer;
        }
        field(15; Exported; Boolean)
        {
            Caption = 'Exported';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Item No.", "Date Claimed", "Rebate Type")
        {
            SumIndexFields = "Quantity Claimed", "Rebate Amount";
        }
        key(Key3; "End User Cust No.", "Item No.", "Date Claimed", "Rebate Type")
        {
            SumIndexFields = "Quantity Claimed", "Rebate Amount";
        }
        key(Key4; "Customer Type", "No.", "Item No.", "Date Claimed", "Rebate Type")
        {
            SumIndexFields = "Quantity Claimed", "Rebate Amount";
        }
        key(Key5; Exported)
        {
        }
    }

    fieldgroups
    {
    }
}

