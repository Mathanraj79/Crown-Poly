tableextension 50026 "Purch.Inv.HeaderEx" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Dept Approval"; Code[10])
        {
            Caption = 'Dept Approval';
            DataClassification = CustomerContent;
        }
        field(50001; "Executive Approval"; Code[10])
        {
            Caption = 'Executive Approval';
            DataClassification = CustomerContent;
        }
        field(50003; "Expected Rcpt. Date"; Date)
        {
            Caption = 'Expected Rcpt. Date';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50004; Tax; Decimal)
        {
            Caption = 'Tax';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50005; "Total PO Amount"; Decimal)
        {
            Caption = 'Total PO Amount';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50006; "Amount Approved"; Decimal)
        {
            Caption = 'Amount Approved';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50007; "Receiving Approval"; Code[20])
        {
            Caption = 'Receiving Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';

        }
        field(50008; "Previous Dept Approval"; Code[10])
        {
            Caption = 'Previous Dept Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50009; "Previous Exec. Approval"; Code[10])
        {
            Caption = 'Previous Exec. Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50010; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50020; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent";
        }
        field(50021; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            DataClassification = CustomerContent;
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(50100; "RECEIPT POSTING DATE"; Date)
        {
            Caption = 'RECEIPT POSTING DATE';
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("Order No." = FIELD("Order No.")));
            Editable = false;
        }
    }
}
