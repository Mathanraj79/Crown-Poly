tableextension 50003 GLEntrytableExt extends "G/L Entry"
{
    fields
    {
        field(50000; "G/L Name"; Text[100])
        {
            Caption = 'G/L Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("G/L Account"."Name" WHERE("No." = FIELD("G/L Account No.")));

        }
        field(50001; "Rebate Claim"; Boolean)
        {
            Caption = 'Rebate Claim';
            DataClassification = CustomerContent;
            Description = 'SCSMS01';
        }
        field(50002; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
            DataClassification = CustomerContent;
            Description = 'SCSMS01';
        }
        field(50003; "Vendor Description"; Text[100])
        {
            Caption = 'Vendor Description';
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor."Name" WHERE("No." = FIELD("Source No.")));
        }

    }
    keys
    {
        key(Key15; "Close Income Statement Dim. ID") { }
    }
}
