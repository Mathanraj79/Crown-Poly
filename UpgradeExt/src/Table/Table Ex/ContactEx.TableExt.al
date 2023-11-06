tableextension 50040 ContactEx extends Contact
{
    fields
    {
        field(60000; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
    }
}
