table 50044 "Daily Case Report Formula"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "PNP Daily Field ID"; Integer)
        {
            TableRelation = Field."No." WHERE("TableNo" = FILTER(50045),
                                             "No." = FILTER(<> 1));
        }
        field(2; "PNP Daily Field Name"; Text[90])
        {
        }
        field(3; "Item Routing"; Code[20])
        {
            TableRelation = "Routing Header";
        }
        field(10; "Customer No. Filter"; Text[250])
        {
        }
        field(12; "Item No. Filter"; Text[250])
        {
        }
        field(13; "Item Type Filter"; Option)
        {
            Caption = 'Item Type';
            OptionCaption = ' ,Hippo Sak,Pull n Pak,Strip Rolls,Master Rolls,Trash Bag,Reusable Bag';
            OptionMembers = " ","Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
        }
        field(15; "Global Dimension 1 Filter"; Code[50])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
        }
        field(16; "Global Dimension 2 Filter"; Code[50])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
        }
        field(50000; "1000 bag count"; Boolean)
        {
        }
        field(50001; "Projected Total"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "PNP Daily Field ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

