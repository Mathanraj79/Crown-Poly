tableextension 50016 ItemJournalLineEx extends "Item Journal Line"
{
    fields
    {
        field(50000; "Machine Center Code"; Code[20])
        {
            Caption = 'Machine Center Code';
            DataClassification = CustomerContent;
            TableRelation = "Machine Center";
            Description = 'SCSML';
        }
        field(50001; "Resin Unit Amount"; Decimal)
        {
            Caption = 'Resin Unit Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Unit Amount" := "Resin Unit Amount";
                VALIDATE("Unit Amount");
                //SCSML END
            end;
        }
        field(50002; "Resin Amount"; Decimal)
        {
            Caption = 'Resin Amount';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                Amount := "Resin Amount";
                VALIDATE(Amount);
                //SCSML END

            end;
        }
        field(50003; "Resin Unit Cost"; Decimal)
        {
            Caption = 'Resin Unit Cost';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                "Unit Cost" := "Resin Unit Cost";  //SCMSL
            end;
        }
        field(50005; "Shift"; Code[10])
        {
            Caption = 'Shift';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50006; "Validated"; Boolean)
        {
            Caption = 'Validated';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50007; "Checked"; Boolean)
        {
            Caption = 'Checked';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }

    }
}
