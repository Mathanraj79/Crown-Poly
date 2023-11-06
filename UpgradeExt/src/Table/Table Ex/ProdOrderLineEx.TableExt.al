tableextension 50042 "Prod. Order LineEx" extends "Prod. Order Line"
{
    fields
    {
        field(50000; "CP Prod. Order No."; Code[20])
        {
            Caption = 'CP Prod. Order No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(key13; "Item No.") { }
    }
}
