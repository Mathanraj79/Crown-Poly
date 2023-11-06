tableextension 50041 "Production OrderEx" extends "Production Order"
{
    fields
    {
        field(50000; "Ink Color No. 1"; Code[10])
        {
            Caption = 'Ink Color No. 1';
            DataClassification = CustomerContent;
            TableRelation = "Ink Colors";
            Description = 'SCSSM01';
        }
        field(50001; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Net Weight" WHERE("No." = FIELD("Source No.")));
            Editable = false;
        }
        field(50005; "Requested Ship Date"; Date)
        {
            Caption = 'Requested Ship Date';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50010; "Change Status"; Boolean)
        {
            Caption = 'Change Status';
            DataClassification = CustomerContent;
            Description = 'SCSMVB';
        }
        field(50011; "Desc for Gannt Chart"; Code[20])
        {
            Caption = 'Desc for Gannt Chart';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50012; "Rounting No."; Code[20])
        {
            Caption = 'Rounting No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Prod. Order Routing Line"."No." WHERE("Prod. Order No." = FIELD("No.")));
            Description = 'SCSSM01';
            Editable = false;
        }
        field(50013; "Finished Qty"; Decimal)
        {
            Caption = 'Finished Qty';
            FieldClass = FlowField;
            CalcFormula = Lookup("Prod. Order Line"."Finished Quantity" WHERE(Status = FIELD(Status),
                  "Prod. Order No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            Editable = false;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                QuantityText: Text[30];
            begin
                QuantityText := FORMAT(Quantity);
                IF (STRLEN(COPYSTR("No.", 5, STRLEN("No.")) + ' ' + "Source No." + ' ' + QuantityText)) > 20 THEN BEGIN
                    IF STRLEN("Source No." + ' ' + QuantityText) > 20 THEN
                        "Desc for Gannt Chart" := "Source No."   //SCSSM01
                    ELSE
                        "Desc for Gannt Chart" := ("Source No." + ' ' + QuantityText)   //SCSSM01
                END ELSE
                    "Desc for Gannt Chart" := (COPYSTR("No.", 5, STRLEN("No.")) + ' ' + "Source No." + ' ' + QuantityText);
            end;

        }
    }

    keys
    {
        key(key9; "Starting Date", "Starting Time", "Ending Date", "Ending Time") { }
    }
}
