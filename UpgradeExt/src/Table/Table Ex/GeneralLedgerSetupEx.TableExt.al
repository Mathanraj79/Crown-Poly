tableextension 50018 GeneralLedgerSetupEx extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Rebate Account"; Code[20])
        {
            Caption = 'Rebate Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Description = 'SCSSM01';
        }
        field(50001; "Rebate Processing Batch"; Code[10])
        {
            Caption = 'Rebate Processing Batch';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FILTER('PAYMENT'));
            Description = 'SCSSM01';
        }
        field(50004; "Rebate Nos."; Code[20])
        {
            Caption = 'Rebate Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50005; "Lock Net Pricing"; Boolean)
        {
            Caption = 'Lock Net Pricing';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50006; "Terms Grace Period"; DateFormula)
        {
            Caption = 'Terms Grace Period';
            DataClassification = CustomerContent;
            Description = 'SCSFN 011608';
        }
        field(50007; "OverDue Limit"; Decimal)
        {
            Caption = 'OverDue Limit';
            DataClassification = CustomerContent;
            Description = 'DJSIM 20080828';
        }
    }
}
