tableextension 50034 InventorySetupEx extends "Inventory Setup"
{
    fields
    {
        field(50000; "Scrap Jnl. Batch Name"; Code[10])
        {
            Caption = 'Scrap Jnl. Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FILTER('ITEM'));
            Description = 'SCSSM01';
        }
        field(50001; "Default Transfer-from Location"; Code[10])
        {
            Caption = 'Default Transfer-from Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
            Description = 'SSC56';
        }
        field(50002; "Default In Transit Location"; Code[10])
        {
            Caption = 'Default In Transit Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
            Description = 'SSC56';
        }
        field(50003; "Allow Neg. Invt."; Boolean)
        {
            Caption = 'Allow Neg. Invt.';
            DataClassification = CustomerContent;
            Description = 'IWEB270';
        }
    }
}
