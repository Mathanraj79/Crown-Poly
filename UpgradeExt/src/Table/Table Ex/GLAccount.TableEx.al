tableextension 50002 GLAccountEx extends "G/L Account"
{
    fields
    {
        field(70002; "Include in Business View"; Boolean)
        {
            Caption = 'Include in Business View';
            DataClassification = CustomerContent;
        }
        field(70003; "Reverse Sign in Business View"; Boolean)
        {
            Caption = 'Reverse Sign in Business View';
            DataClassification = CustomerContent;
        }
    }
}
