tableextension 50043 "Prod. Order Routing LineEx" extends "Prod. Order Routing Line"
{
    fields
    {
        field(50000; "Qty. on Prod. Order"; Decimal)
        {
            Caption = 'Qty. on Prod. Order';
            FieldClass = FlowField;
            CalcFormula = Lookup("Prod. Order Line".Quantity WHERE(Status = FILTER(Released),
                                      "Prod. Order No." = FIELD("Prod. Order No.")));
            Editable = false;
        }
        field(50001; "Qty. Finished"; Decimal)
        {
            Caption = 'Qty. Finished';
            FieldClass = FlowField;
            CalcFormula = Lookup("Prod. Order Line"."Finished Quantity" WHERE(Status = FILTER(Released),
                                       "Prod. Order No." = FIELD("Prod. Order No.")));
            Editable = false;
        }
        field(50002; "Qty. on Output Jnl."; Decimal)
        {
            Caption = 'Qty. on Output Jnl.';
            FieldClass = FlowField;
            CalcFormula = Sum("Output Journal"."Output Quantity" WHERE("Prod. Order No." = FIELD("Prod. Order No.")));
            Editable = false;
        }
        field(50003; "Qty. to Post"; Decimal)
        {
            Caption = 'Qty. to Post';
            DataClassification = CustomerContent;
        }
        field(50004; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Prod. Order Line"."Item No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                    "Line No." = FIELD("Routing Reference No.")));
            Editable = false;
        }
    }
    keys
    {
        key(key13; "Starting Date", "Starting Time", "Ending Date", "Ending Time", "No.") { }
    }
}
