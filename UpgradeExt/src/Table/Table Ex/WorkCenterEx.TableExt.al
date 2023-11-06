tableextension 50052 "Work CenterEx" extends "Work Center"
{
    fields
    {
        field(50000; "Adj. Cases"; Decimal)
        {
            Caption = 'Adj. Cases';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50001; "Distribution Email ID"; Text[250])
        {
            Caption = 'Distribution Email ID';
            DataClassification = CustomerContent;
            Description = 'IWEB364';
        }
    }
}
