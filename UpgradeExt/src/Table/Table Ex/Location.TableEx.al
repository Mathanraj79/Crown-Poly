tableextension 50001 LocationEx extends Location
{
    fields
    {
        field(50000; "In Transit Code"; Code[10])
        {
            Caption = 'In Transit Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
    }
}
