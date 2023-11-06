tableextension 50045 "Warehouse Activity LineEx" extends "Warehouse Activity Line"
{
    fields
    {
        field(50000; "Suggested Serial No."; Code[50])
        {
            Caption = 'Suggested Serial No.';
            DataClassification = CustomerContent;
            Description = 'SSC56';
            Editable = false;
        }
        field(50001; "Suggested Lot No."; Code[50])
        {
            Caption = 'Suggested Lot No.';
            DataClassification = CustomerContent;
            Description = 'SSC56';
            Editable = false;
        }
        field(50002; "Suggested Bin Code"; Code[20])
        {
            Caption = 'Suggested Bin Code';
            DataClassification = CustomerContent;
            Description = 'SSC56';
            Editable = false;
        }

    }
}
