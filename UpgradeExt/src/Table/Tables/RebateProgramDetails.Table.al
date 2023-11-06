table 50003 "Rebate Program Details"
{
    Caption = 'Rebate Program Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(4; "Rebate Amount"; Decimal)
        {
            Caption = 'Rebate Amount';
        }
        field(5; "Rebate Type"; Option)
        {
            Caption = 'Rebate Type';
            OptionCaption = '$,%';
            OptionMembers = "$","%";
        }
        field(6; "Header Start Date"; Date)
        {
            CalcFormula = Lookup("Rebate Program Header"."Start Date" WHERE("Rebate No." = FIELD("Rebate No.")));
            Caption = 'Header Start Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Header End Date"; Date)
        {
            CalcFormula = Lookup("Rebate Program Header"."End Date" WHERE("Rebate No." = FIELD("Rebate No.")));
            Caption = 'Header End Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Header Rebate Type"; Option)
        {
            CalcFormula = Lookup("Rebate Program Header"."Rebate Type" WHERE("Rebate No." = FIELD("Rebate No.")));
            Caption = 'Header Rebate Type';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Instant Credit,Monthly,Quarterly,Annual';
            OptionMembers = "Instant Credit",Monthly,Quarterly,Annual;
        }
        field(9; Comments; Text[250])
        {
            Caption = 'Comments';
        }
    }

    keys
    {
        key(Key1; "Rebate No.", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

