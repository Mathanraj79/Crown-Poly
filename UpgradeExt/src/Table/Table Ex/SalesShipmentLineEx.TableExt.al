tableextension 50020 SalesShipmentLineEx extends "Sales Shipment Line"
{
    fields
    {
        field(50004; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            OptionMembers = "","Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
            Description = 'SCSEL 07-17-07';
            Editable = false;
        }
        field(50015; "Bags per Case"; Integer)
        {
            Caption = 'Bags per Case';
            DataClassification = CustomerContent;
            Description = 'SCSEL 121907';
        }
        field(50016; "Bags Count"; Decimal)
        {
            Caption = 'Bags Count';
            DataClassification = CustomerContent;
            Description = 'SCSEL 121907';
        }
    }
}
