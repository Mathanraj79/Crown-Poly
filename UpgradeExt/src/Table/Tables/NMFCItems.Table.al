table 50032 "NMFC Items"
{
    Caption = 'NMFC Items';
    DataClassification = CustomerContent;
    //LookupPageID = 50001;

    fields
    {
        field(1; "NMFC Item No."; Code[20])
        {
            Caption = 'NMFC Item No.';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Class; Decimal)
        {
            Caption = 'Class';
        }
        field(5; "Package Type"; Code[20])
        {
            Caption = 'Package Type';
        }
    }

    keys
    {
        key(Key1; "NMFC Item No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

