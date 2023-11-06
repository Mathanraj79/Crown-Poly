tableextension 50053 "Machine CenterEx" extends "Machine Center"
{
    fields
    {
        field(50000; "Expected Cases"; Decimal)
        {
            Caption = 'Expected Cases';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
    }
}
