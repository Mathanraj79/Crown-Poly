tableextension 50048 "Lot No. InformationEx" extends "Lot No. Information"
{
    fields
    {
        field(50000; "HD Rail Car"; Text[30])
        {
            Caption = 'HD Rail Car';
            DataClassification = CustomerContent;
            Description = 'SCS1.00';
        }
        field(50001; "LLD Rail Car"; Text[30])
        {
            Caption = 'LLD Rail Car';
            DataClassification = CustomerContent;
            Description = 'SCS1.00';
        }
    }
}
