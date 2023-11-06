tableextension 50019 SalesShipmentHeaderEx extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Override Pricing"; Boolean)
        {
            Caption = 'Override Pricing';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50001; "Freight Bills"; Decimal)
        {
            Caption = 'Freight Bills';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50002; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50014; "BOL No."; Code[20])
        {
            Caption = 'BOL No.';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50015; "Salesperson 2"; Code[20])
        {
            Caption = 'Salesperson 2';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50016; "Broker 1"; Code[20])
        {
            Caption = 'Broker 1';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            Description = 'SCSFN';

        }
        field(50017; "Broker 2"; Code[20])
        {
            Caption = 'Broker 2';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50020; Finalized; Boolean)
        {
            Caption = 'Finalized';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50021; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50023; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50090; "Actual Delivery Date"; Date)
        {
            Caption = 'Actual Delivery Date';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
    }
}
