table 50021 "Sales Commision Setup"
{
    Caption = 'Sales Commision Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            NotBlank = true;
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            var
                SalespersonPurch: Record "Salesperson/Purchaser";
            begin
                SalespersonPurch.GET("Salesperson Code");
                Broker := SalespersonPurch.Broker;
            end;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(4; "Commision %"; Decimal)
        {
            Caption = 'Commision %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(5; "Commision Type"; Option)
        {
            Caption = 'Commision Type';
            OptionCaption = '$,%';
            OptionMembers = "$","%";
        }
        field(6; Broker; Boolean)
        {
            Caption = 'Broker';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Salesperson Code", "Item No.", "Customer No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Customer No.")
        {
        }
        key(Key3; "Item No.", "Customer No.", Broker)
        {
            SumIndexFields = "Commision %";
        }
    }

    fieldgroups
    {
    }
}

