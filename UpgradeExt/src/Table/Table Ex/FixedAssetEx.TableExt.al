tableextension 50044 "Fixed AssetEx" extends "Fixed Asset"
{
    fields
    {
        field(50000; "Operating Lease Acq. Cost"; Decimal)
        {
            Caption = 'Operating Lease Acq. Cost';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50001; "Machine Center Code"; Code[20])
        {
            Caption = 'Machine Center Code';
            DataClassification = CustomerContent;
            TableRelation = "Machine Center"."No.";
            Description = 'SCSFN';
        }
    }
}
