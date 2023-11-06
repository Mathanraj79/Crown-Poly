tableextension 50007 VendorLedgerEntryEx extends "Vendor Ledger Entry"
{
    fields
    {
        field(50005; "New Payment Discount %"; Decimal)
        {
            Caption = 'New Payment Discount %';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            Editable = false;
        }
        field(50010; "New Payment Discount Amount"; Decimal)
        {
            Caption = 'New Payment Discount Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            Editable = false;
        }
    }
}
