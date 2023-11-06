table 50045 "PNP Daily - New"
{
    // ---------------------------------------------------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------IWEB ETC.-------------------------------------------------------------
    // ---------------------------------------------------------------------------------------------------------------------------------------
    // CODE        DATE              DEV                 COMMENT
    // ---------------------------------------------------------------------------------------------------------------------------------------
    // 001         05.25.16          IWEB.DJ             Replaced WALMART with "Reusable Bag"

    Caption = 'PNP Daily';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Date; Date)
        {
            Caption = 'Date';
        }
        field(50; "Column 1"; Decimal)
        {
            Caption = 'Column 1';
        }
        field(51; "Column 2"; Decimal)
        {
            Caption = 'Column 2';
        }
        field(52; "Column 3"; Decimal)
        {
            Caption = 'Column 3';
        }
        field(53; "Column 4"; Decimal)
        {
            Caption = 'Column 4';
        }
        field(54; "Column 5"; Decimal)
        {
            Caption = 'Column 5';
        }
        field(55; "Column 6"; Decimal)
        {
            Caption = 'Column 6';
        }
        field(56; "Column 7"; Decimal)
        {
            Caption = 'Column 7';
        }
        field(57; "Column 8"; Decimal)
        {
            Caption = 'Column 8';
        }
        field(58; "Column 9"; Decimal)
        {
            Caption = 'Column 9';
        }
        field(59; "Column 10"; Decimal)
        {
            Caption = 'Column 10';
        }
        field(60; "Column 11"; Decimal)
        {
            Caption = 'Column 11';
        }
        field(61; "Column 12"; Decimal)
        {
            Caption = 'Column 12';
        }
        field(62; "Column 13"; Decimal)
        {
            Caption = 'Column 13';
        }
        field(63; "Column 14"; Decimal)
        {
            Caption = 'Column 14';
        }
        field(64; "Column 15"; Decimal)
        {
            Caption = 'Column 15';
        }
        field(50000; "Projected Total"; Decimal)
        {
            Caption = 'Projected Total';
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

