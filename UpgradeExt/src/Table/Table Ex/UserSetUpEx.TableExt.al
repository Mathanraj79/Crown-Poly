tableextension 50017 UserSetUpEx extends "User Setup"
{
    fields
    {
        field(50000; "Credit Manager"; Boolean)
        {
            Caption = 'Credit Manager';
            DataClassification = CustomerContent;
            Description = 'SCS1.1';
        }
        field(50002; Resin; Boolean)
        {
            Caption = 'Resin';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50004; "Shipping Manager"; Boolean)
        {
            Caption = 'Shipping Manager';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50005; "Shipping Email"; Text[80])
        {
            Caption = 'Shipping Email';
            DataClassification = CustomerContent;
            Description = 'SCSWO';
        }
        field(50006; "CS Email"; Text[80])
        {
            Caption = 'CS Email';
            DataClassification = CustomerContent;
            Description = 'SCSWO';
        }
        field(50007; "Handheld User"; Boolean)
        {
            Caption = 'Handheld User';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
    }
}
