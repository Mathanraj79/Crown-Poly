tableextension 50031 RequisitionLineEx extends "Requisition Line"
{
    fields
    {
        field(50000; "Resin Direct Unit Cost"; Decimal)
        {
            Caption = 'Resin Direct Unit Cost';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Direct Unit Cost" := "Resin Direct Unit Cost";
                VALIDATE("Direct Unit Cost");
                //SCSML END
            end;
        }
        field(50010; "Safety Stock Quantity"; Decimal)
        {
            Caption = 'Safety Stock Quantity';
            DataClassification = CustomerContent;
            Description = 'SCSMVB';
            Editable = false;
        }
        field(50020; "Maximum Inventory"; Decimal)
        {
            Caption = 'Maximum Inventory';
            DataClassification = CustomerContent;
            Description = 'SCSMVB';
            Editable = false;
        }
    }
}
