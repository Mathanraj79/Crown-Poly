tableextension 50030 "Ship-To-AddressEx" extends "Ship-to Address"
{
    fields
    {
        field(50000; "Default Ship-to Address"; Boolean)
        {
            Caption = 'Default Ship-to Address';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
            trigger OnValidate()
            begin
                IF "Default Ship-to Address" THEN BEGIN
                    ShiptoAdd.RESET();
                    ShiptoAdd.SETRANGE("Customer No.", "Customer No.");
                    ShiptoAdd.SETRANGE("Default Ship-to Address", TRUE);
                    IF ShiptoAdd.FINDFIRST() THEN
                        ERROR(CPText001Lbl, ShiptoAdd.Code);
                END;
            end;
        }
        field(50001; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50009; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSFN';
            InitValue = D;
        }

    }
    var
        ShiptoAdd: Record "Ship-to Address";
        CPText001Lbl: label 'ENU=Current Default Ship-to Address is %1', Comment = '%1 Document Type';
}
