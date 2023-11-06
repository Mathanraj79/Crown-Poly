tableextension 50035 TrackingSpecificationEx extends "Tracking Specification"
{
    fields
    {
        field(50000; "Master Lot No."; Code[20])
        {
            Caption = 'Master Lot No.';
            DataClassification = CustomerContent;
            Description = 'SCS1.00';
        }
        field(50001; "No. Of Slits"; Integer)
        {
            Caption = 'No. Of Slits';
            DataClassification = CustomerContent;
            Description = 'SCS1.00';
            trigger OnValidate()
            begin
                IF "No. Of Slits" > 26 THEN
                    ERROR(CPText001Lbl);
            end;
        }
        field(50005; "Source Entry No."; Integer)
        {
            Caption = 'Source Entry No.';
            DataClassification = CustomerContent;
            Description = 'SSC56';
        }
        field(50006; "Source Entry Type"; Option)
        {
            Caption = 'Source Entry Type';
            DataClassification = CustomerContent;
            OptionMembers = "Tracking Specification","Reservation Entry";
            Description = 'SSC56';
        }
    }
    var
        CPText001Lbl: Label 'ENU=The No. of Slits can not be above 26.';
}
