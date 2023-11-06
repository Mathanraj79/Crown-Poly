table 50004 "End User"
{
    Caption = 'End User';
    DataClassification = CustomerContent;
    // DrillDownPageID = 50082;
    // LookupPageID = 50082;

    fields
    {
        field(1; "End User No."; Code[20])
        {
            Caption = 'End User No.';
            NotBlank = true;
        }
        field(2; "End User Table"; Text[50])
        {
            Caption = 'End User Table';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'SCSSM01';
            TableRelation = Vendor;
        }
    }

    keys
    {
        key(Key1; "End User No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

