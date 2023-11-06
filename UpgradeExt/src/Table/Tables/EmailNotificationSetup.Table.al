table 50033 "Email Notification Setup"
{
    Caption = 'Email Notification Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Shipping Email Address"; Text[250])
        {
            Caption = 'Shipping Email Address';
        }
        field(3; "Customer Service Email Address"; Text[250])
        {
            Caption = 'Customer Service Email Address';
        }
        field(4; "Credit Manager Email Address"; Text[250])
        {
            Caption = 'Credit Manager Email Address';
        }
        field(5; "Cost Manager Email Address"; Text[250])
        {
            Caption = 'Cost Manager Email Address';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

