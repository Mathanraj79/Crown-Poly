table 50042 "Whse. Mgmt Setup"
{
    // SSC56 - new object

    Caption = 'Warehouse Management Setup';
    DataClassification = CustomerContent;
    // DrillDownPageID = 50019;
    // LookupPageID = 50019;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(2; SubType; Option)
        {
            Caption = 'SubType';
            OptionCaption = ' ,Domestic,Export';
            OptionMembers = " ",Domestic,Export;
        }
        field(3; "Default Location Code"; Code[10])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; Type, SubType)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

