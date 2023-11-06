tableextension 50051 "Shop Calendar Working DaysEx" extends "Shop Calendar Working Days"
{
    fields
    {
        field(50000; "Week 1"; Boolean)
        {
            Caption = 'Week 1';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50001; "Week 2"; Boolean)
        {
            Caption = 'Week 2';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
    }
}
