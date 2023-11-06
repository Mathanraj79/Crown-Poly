tableextension 50000 "Salesperson/PurchaserTableEx" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; Broker; Boolean)
        {
            Caption = 'Broker';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
    }
}
