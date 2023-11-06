tableextension 50050 "Posted Whse. Receipt LineEx" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(50000; "Storage Zone Code"; Code[10])
        {
            Caption = 'Storage Zone Code';
            DataClassification = CustomerContent;
            TableRelation = Zone.Code WHERE("Location Code" = FIELD("Location Code"));
            Description = 'SSC56';
        }
        field(50001; "Storage Bin Code"; Code[20])
        {
            Caption = 'Storage Bin Code';
            DataClassification = CustomerContent;
            Description = 'SSC56';
            TableRelation = IF ("Zone Code" = FILTER('')) Bin.Code WHERE("Location Code" = FIELD("Location Code"))
            ELSE
            IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                "Zone Code" = FIELD("Storage Zone Code"));
        }
    }
}
