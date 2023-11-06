tableextension 50046 "Warehouse SetupEx" extends "Warehouse Setup"
{
    fields
    {
        field(50000; "Mandatory Pick Ticket"; Boolean)
        {
            Caption = 'Mandatory Pick Ticket';
            DataClassification = CustomerContent;
            Description = 'SSC56';
        }
        field(50001; "Pallet Weight"; Decimal)
        {
            Caption = 'Pallet Weight';
            DataClassification = CustomerContent;
            Description = 'IWEB.001';
        }
    }
}
