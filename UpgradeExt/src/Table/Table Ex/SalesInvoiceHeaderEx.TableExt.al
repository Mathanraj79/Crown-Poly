tableextension 50021 SalesInvoiceHeaderEx extends "Sales Invoice Header"
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
        field(50025; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            DataClassification = CustomerContent;
            Description = 'SCSSM01 110807';
        }
        field(50050; "Sales Order Printed"; Integer)
        {
            Caption = 'Sales Order Printed';
            DataClassification = CustomerContent;
            Description = 'SCSFN 110807';
            Editable = false;
        }
        field(50051; "Pick List Printed"; Integer)
        {
            Caption = 'Pick List Printed';
            DataClassification = CustomerContent;
            Description = 'SCSFN 110807';
            Editable = false;
        }
        field(50052; "Sales Shipment Number"; Code[20])
        {
            Caption = 'Sales Shipment Number';
            FieldClass = FlowField;
            CalcFormula = Lookup("Sales Shipment Header"."No." WHERE("Order No." = FIELD("Order No.")));
        }
        field(75000; "Last Updated By"; Code[50])
        {
            Caption = 'Last Updated By';
            DataClassification = CustomerContent;
            TableRelation = User;
            Description = 'SCSNP';
        }
        field(75001; "Updated Date/Time"; DateTime)
        {
            Caption = 'Updated Date/Time';
            DataClassification = CustomerContent;
            Description = 'SCSNP';
        }
    }
    keys
    {
        key(key14; "Sell-to Customer No.", "Posting Date") { }
    }
}
