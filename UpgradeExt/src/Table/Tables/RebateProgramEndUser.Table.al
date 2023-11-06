table 50007 "Rebate Program - End User"
{
    Caption = 'Rebate Program - End User';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';
            TableRelation = "Rebate Program Header"."Rebate No.";
        }
        field(2; "End User No."; Code[20])
        {
            Caption = 'End User No.';
            TableRelation = "End User";
        }
        field(3; "Customer No."; Code[20])
        {
            CalcFormula = Lookup("End User"."Customer No." WHERE("End User No." = FIELD("End User No.")));
            Caption = 'Customer No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Vendor No."; Code[20])
        {
            CalcFormula = Lookup("End User"."Vendor No." WHERE("End User No." = FIELD("End User No.")));
            Caption = 'Vendor No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Total Claimed Qty"; Decimal)
        {
            CalcFormula = Sum("Rebate Claim"."Quantity Claimed" WHERE("End User No." = FIELD("End User No.")));
            Caption = 'Total Claimed Qty';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Rebate No.", "End User No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

