tableextension 50055 "Production BOM LineEx" extends "Production BOM Line"
{
    fields
    {
        field(50000; "Resin Item"; Boolean)
        {
            Caption = 'Resin Item';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50001; "Scrap Item"; Boolean)
        {
            Caption = 'Scrap Item';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50002; "CP Scrap %"; Decimal)
        {
            Caption = 'CP Scrap %';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
            trigger OnValidate()
            begin
                "Scrap Qty" := "CP Scrap %" * Quantity;
            end;
        }
        field(50003; "Scrap Qty"; Decimal)
        {
            Caption = 'Scrap Qty';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                "Scrap Qty" := ("Scrap %" * Quantity) / 100;
            end;
        }
    }

}
