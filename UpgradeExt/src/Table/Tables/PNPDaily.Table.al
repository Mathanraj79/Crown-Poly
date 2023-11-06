table 50039 "PNP Daily"
{
    Caption = 'PNP Daily';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
        }
        field(50; Safeway; Decimal)
        {
            Caption = 'Safeway';
        }
        field(51; Kroger; Decimal)
        {
            Caption = 'Kroger';
        }
        field(52; Bunzl; Decimal)
        {
            Caption = 'Bunzl';
        }
        field(53; Walmart; Decimal)
        {
            Caption = 'Walmart';
        }
        field(54; Others; Decimal)
        {
            Caption = 'Others';
        }
        field(55; Domestic; Decimal)
        {
            Caption = 'Domestic';
        }
        field(56; "Project Total"; Decimal)
        {
            Caption = 'Project Total';
        }
        field(57; Export; Decimal)
        {
            Caption = 'Export';
        }
        field(58; Totals; Decimal)
        {
            Caption = 'Totals';
        }
        field(59; "Hippo Sak"; Decimal)
        {
            Caption = 'Hippo Sak';
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

