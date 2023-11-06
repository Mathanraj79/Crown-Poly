table 50036 "G/L Allocation"
{
    Caption = 'G/L Allocation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Division Code"; Code[20])
        {
            Caption = 'Division Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DIVISION'));
        }
        field(4; "Allocation Value"; Decimal)
        {
            Caption = 'Allocation Value';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Division Code")
        {
            Clustered = true;
            SumIndexFields = "Allocation Value";
        }
    }

    fieldgroups
    {
    }
}

