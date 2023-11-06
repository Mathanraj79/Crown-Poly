tableextension 50004 CustomerEx extends Customer
{
    fields
    {
        field(50000; "Grace Period"; DateFormula)
        {
            Caption = 'Grace Period';
            DataClassification = CustomerContent;
        }
        field(50001; "Address 3"; Text[80])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50002; Attention; Text[50])
        {
            Caption = 'Attention';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50003; "Attn. Phone No."; Code[20])
        {
            Caption = 'Attn. Phone No.';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50005; "Salesperson 2"; Code[10])
        {
            Caption = 'Salesperson 2';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50006; Broker; Code[10])
        {
            Caption = 'Broker';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50007; "Broker 2"; Code[10])
        {
            Caption = 'Broker 2';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50008; "Default Ship-to Address"; Code[10])
        {
            Caption = 'Default Ship-to Address';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }
        field(50009; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50010; "CP Balance"; Decimal)
        {
            Caption = 'CP Balance';
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = FIELD("No."),
                                       "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50011; "CP Balance Due"; Decimal)
        {
            Caption = 'CP Balance Due ';
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = FIELD("No."),
                                       "Posting Date" = FIELD("Date Filter")));
            Editable = false;
            AutoFormatType = 1;
        }
        field(50012; "EDI Customer"; Boolean)
        {
            Caption = 'EDI Customer';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50045; "Sales Quantity"; Decimal)
        {
            Caption = 'Sales Quantity';
            DataClassification = CustomerContent;
            Description = 'SSC69';
            Editable = false;

        }
        field(50046; "Sales Amount"; Decimal)
        {
            Caption = 'Sales Amount';
            DataClassification = CustomerContent;
            Description = 'SSC69';
            Editable = false;
        }
        field(50047; "Exclude from Superfund Tax"; Boolean)
        {
            Caption = 'Exclude from Superfund Tax';
            DataClassification = CustomerContent;
        }
        field(81000; "Trash Bag Sold Qty"; Decimal)
        {
            Caption = 'Trash Bag Sold Qty';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Bags Count" WHERE("Sell-to Customer No." = FIELD("No."),
                     "Posting Date" = FIELD("Date Filter"),
                         Type = FILTER(Item),
                            "No." = FILTER(65015 .. 69999)));
            Description = 'IWEB.001';
            Editable = false;

        }
        field(81001; "Trash Bag Cr. Qty"; Decimal)
        {
            Caption = 'Trash Bag Cr. Qty ';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Cr.Memo Line"."Bags Count" WHERE("Sell-to Customer No." = FIELD("No."),
                 "Posting Date" = FIELD("Date Filter"),
                    Type = FILTER(Item),
                        "No." = FILTER(65015 .. 69999)));
            Description = 'IWEB.001';
            Editable = false;
        }
        field(81002; "Display Currency"; Boolean)
        {
            Caption = 'Display Currency';
            DataClassification = CustomerContent;
        }
        field(81003; "Product Code Filter"; Code[250])
        {
            Caption = 'Product Code Filter';
            FieldClass = FlowFilter;
            Description = 'IWEB785';
        }
        field(81004; "Trash Bag Sold Qty - Gen"; Decimal)
        {
            Caption = 'Trash Bag Sold Qty - Gen';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Bags Count" WHERE("Sell-to Customer No." = FIELD("No."),
                "Posting Date" = FIELD("Date Filter"),
                    Type = FILTER(Item),
                       "Item Category Code" = FIELD("Product Code Filter")));
            Description = 'IWEB.001,IWEB785 >Changed CalcFormula';
            Editable = false;

        }
        field(81005; "Trash Bag Cr. Qty - Gen"; Decimal)
        {
            Caption = 'Trash Bag Cr. Qty - Gen';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Cr.Memo Line"."Bags Count" WHERE("Sell-to Customer No." = FIELD("No."),
                "Posting Date" = FIELD("Date Filter"),
                    Type = FILTER(Item),
                           "Item Category Code" = FIELD("Product Code Filter")));
            Description = 'IWEB.001,IWEB785 >Changed CalcFormula';
            Editable = false;
        }

    }
}
