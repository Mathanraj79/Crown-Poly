tableextension 50015 GenJnlLineEx extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Rebate Claim"; Boolean)
        {
            Caption = 'Rebate Claim';
            DataClassification = CustomerContent;
            Description = 'SCSMS01';
        }
        field(50001; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
            DataClassification = CustomerContent;
            Description = 'SCSMS01';
        }
        field(50002; "New Payment Discount %"; Decimal)
        {
            Caption = 'New Payment Discount %';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50003; "New Discount Amount"; Decimal)
        {
            Caption = 'New Discount Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
    }
}
