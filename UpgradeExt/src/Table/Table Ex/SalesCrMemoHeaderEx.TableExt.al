tableextension 50023 SalesCrMemoHeaderEx extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50018; "Rebate Claim"; Boolean)
        {
            Caption = 'Rebate Claim';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50019; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50020; Finalized; Boolean)
        {
            Caption = 'Finalized';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50021; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50022; "Instant Rebates"; Boolean)
        {
            Caption = 'Instant Rebates';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50023; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
    }
}
