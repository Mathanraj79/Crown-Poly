tableextension 50033 "Sales & Receivables SetupEx" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50002; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
            Description = 'SCSSM01';
        }
        field(50003; "Case Cost Deduction"; Decimal)
        {
            Caption = 'Case Cost Deduction';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50005; "BOL No. Series"; Code[20])
        {
            Caption = 'BOL No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50006; "No COGA"; Decimal)
        {
            Caption = 'No COGA';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50007; "HJ CCA"; Decimal)
        {
            Caption = 'HJ CCA';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50008; "TShirt CCA"; Decimal)
        {
            Caption = 'TShirt CCA';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50009; "No COGA No Broker"; Decimal)
        {
            Caption = 'No COGA No Broker';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50010; "SO Reopen Recipients"; Text[250])
        {
            Caption = 'SO Reopen Recipients';
            DataClassification = CustomerContent;
            Description = 'IWEB178';
        }
        field(50011; "Superfund Tax Enabled"; Boolean)
        {
            Caption = 'Superfund Tax Enabled';
            DataClassification = CustomerContent;
            Description = 'IW1629';
        }
        field(50012; "Superfund Tax Rate"; Decimal)
        {
            Caption = 'Superfund Tax Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'IW1629';
        }
        field(50013; "Superfund Tax Account"; Code[20])
        {
            Caption = 'Superfund Tax Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
            Description = 'IW1629';
        }
    }
}
