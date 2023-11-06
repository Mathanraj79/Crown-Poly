tableextension 50008 ItemEx extends Item
{
    fields
    {
        field(50000; "Sales G/L Account"; Code[20])
        {
            Caption = 'Sales G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Description = 'SCS1.1';
        }
        field(50001; "Purch. G/L Account"; Code[20])
        {
            Caption = 'Purch. G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Description = 'SCS1.1';
        }
        field(50002; "Print Text"; Text[30])
        {
            Caption = 'Print Text ';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50003; "Ink Color No. 1"; Code[10])
        {
            Caption = 'Ink Color No. 1';
            DataClassification = CustomerContent;
            TableRelation = "Ink Colors";
            Description = 'SCSFN';
        }
        field(50004; "Ink Color No. 2"; Code[10])
        {
            Caption = 'Ink Color No. 2';
            DataClassification = CustomerContent;
            TableRelation = "Ink Colors";
            Description = 'SCSFN';
        }
        field(50005; "Ink Color No. 3"; Code[10])
        {
            Caption = 'Ink Color No. 3';
            DataClassification = CustomerContent;
            TableRelation = "Ink Colors";
            Description = 'SCSFN';
        }
        field(50006; "Die Cut"; Code[20])
        {
            Caption = 'Die Cut';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50007; "Bag Dimensions"; Code[20])
        {
            Caption = 'Bag Dimensions';
            DataClassification = CustomerContent;
            TableRelation = "Bag Dimensions";
            Description = 'SCSFN';
        }
        field(50008; "Film Gauge"; Decimal)
        {
            Caption = 'Film Gauge';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //IWEB634.Begin
                "Actual Film Gauge" := "Film Gauge";
                //IWEB634.End
            end;
        }
        field(50009; "Film Type"; Code[10])
        {
            Caption = 'Film Type';
            DataClassification = CustomerContent;
            TableRelation = "Film Types";
            Description = 'SCSFN';
        }
        field(50010; "Bags per Roll/Bundle"; Integer)
        {
            Caption = 'Bags per Roll/Bundle';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50011; "Rolls/Bundles per Case"; Integer)
        {
            Caption = 'Rolls/Bundles per Case';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50012; "Case Count"; Integer)
        {
            Caption = 'Case Count';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50013; "Film Color"; Code[20])
        {
            Caption = 'Film Color';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50014; "Glue"; Boolean)
        {
            Caption = 'Glue';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50015; "UPC Code"; Code[20])
        {
            Caption = 'UPC Code';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50016; "Palletization"; Text[30])
        {
            Caption = 'Palletization';
            DataClassification = CustomerContent;
            TableRelation = Palletizations;
            Description = 'SCSFN';
        }
        field(50017; "Pallet Dimensions"; Text[30])
        {
            Caption = 'Pallet Dimensions';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50018; "Pallets per Truck"; Integer)
        {
            Caption = 'Pallets per Truck';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50019; "Cases per Truck"; Integer)
        {
            Caption = 'Cases per Truck';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50020; "Case Dimensions"; Code[20])
        {
            Caption = 'Case Dimensions';
            DataClassification = CustomerContent;
            TableRelation = "Case Dimensions";
            Description = 'SCSFN';
        }
        field(50021; "Case Cube"; Decimal)
        {
            Caption = 'Case Cube';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50022; "Description 3"; Text[40])
        {
            Caption = 'Description 3';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50023; "Description 4"; Text[60])
        {
            Caption = 'Description 4';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50024; "Description 5"; Text[60])
        {
            Caption = 'Description 5';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50025; "Resin"; Boolean)
        {
            Caption = 'Resin';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                UserSetup.Init();
                IF UserSetup.GET(USERID) THEN
                    IF NOT UserSetup.Resin THEN
                        ERROR(CPText001Lbl);
            end;
        }
        field(50026; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            OptionMembers = "Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
            Description = 'SCSML';
        }
        field(50027; "Amount on Sales Order"; Decimal)
        {
            Caption = 'Amount on Sales Order';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50028; "Production Cases"; Decimal)
        {
            Caption = 'Production Cases';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                "Posting Date" = FIELD("Date Filter"),
              "Location Code" = FIELD("Location Filter"),
            "Entry Type" = FILTER(Output)));
            Description = 'SCSFN';
            Editable = false;
        }
        field(50029; "Sales Cases"; Decimal)
        {
            Caption = 'Sales Cases';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                    "Posting Date" = FIELD("Date Filter"),
                  "Location Code" = FIELD("Location Filter"),
                     "Entry Type" = FILTER(Sale)));
            Description = 'SCSFN';
            Editable = false;
        }
        field(50030; "Adj. Transfers"; Decimal)
        {
            Caption = 'Adj. Transfers';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                            "Posting Date" = FIELD("Date Filter"),
                        "Location Code" = FIELD("Location Filter"),
                     "Entry Type" = FILTER("Transfer" | "Positive Adjmt." | "Negative Adjmt.")));
            Description = 'SCSFN';
            Editable = false;

        }
        field(50031; "Scrap"; Boolean)
        {
            Caption = 'Scrap';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50032; "Physical Inventory Group Code"; Code[1])
        {
            Caption = 'Physical Inventory Group Code';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50033; "Shortcut Dimension 3"; Code[20])
        {
            Caption = 'Shortcut Dimension 3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('ITEM CATEGORY'));
            trigger OnValidate()
            BEGIN
                ValidateShortcutDimCode(3, "Shortcut Dimension 3");
            END;
        }
        field(50034; "Hippo Junior"; Boolean)
        {
            Caption = 'Hippo Junior';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50035; "T Shirt"; Boolean)
        {
            Caption = 'T Shirt';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50036; "Print Scrap"; Boolean)
        {
            Caption = 'Print Scrap ';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50037; "Clear Scrap"; Boolean)
        {
            Caption = 'Clear Scrap';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50038; "Scrap Dept"; Code[20])
        {
            Caption = 'Scrap Dept';
            DataClassification = CustomerContent;
            TableRelation = "Work Center";
            Description = 'DJS 20080225';
        }
        field(50039; "Scrap Item"; Code[20])
        {
            Caption = 'Scrap Item';
            DataClassification = CustomerContent;
            TableRelation = Item WHERE("Scrap" = CONST(true));
            Description = 'DJS 20080225';
        }
        field(50040; "Qty. to Ship on Sales Orders"; Decimal)
        {
            Caption = 'Qty. to Ship on Sales Orders';
            Description = 'SCSFN 091907';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Qty. to Ship" WHERE("Document Type" = FILTER(Order),
                Type = FILTER(Item),
                   "No." = FIELD("No."),
                  "Location Code" = FIELD("Location Filter"),
                     "Variant Code" = FIELD("Variant Filter"),
                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));

        }
        field(50041; "Die Cut Scrap"; Boolean)
        {
            Caption = 'Die Cut Scrap';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50042; "Do not Allow Two Sided Entry"; Boolean)
        {
            Caption = 'Do not Allow Two Sided Entry';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50043; "CP Overhead Rate"; Decimal)
        {
            Caption = 'CP Overhead Rate';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Unit Cost" > 0 THEN
                    VALIDATE("Indirect Cost %", ROUND(("CP Overhead Rate" / "Unit Cost" * 100), 0.01)); //SCSSM01
            end;
        }
        field(50044; "Die Cut Item"; Code[20])
        {
            Caption = 'Die Cut Item';
            DataClassification = CustomerContent;
            TableRelation = Item WHERE("Scrap" = CONST(true));
            Description = 'DJS 20080225';
        }
        field(50045; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            Description = 'TN1001';
            Editable = false;
        }
        field(50046; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            Description = 'TN1001';
            Editable = false;
        }
        field(50050; "RPO Notes"; Text[30])
        {
            Caption = 'RPO Notes';
            DataClassification = CustomerContent;
        }
        field(50051; "Film Titan"; Text[30])
        {
            Caption = 'Film Titan';
            DataClassification = CustomerContent;
        }
        field(50060; "Type of Item"; Option)
        {
            Caption = 'Type of Item';
            DataClassification = CustomerContent;
            OptionMembers = Domestic,Export;
            Description = 'SSC56';
        }
        field(50061; "Print Sides"; Code[10])
        {
            Caption = 'Print Sides';
            DataClassification = CustomerContent;
            Description = 'IWEB.001';
        }
        field(50062; "Actual Film Gauge"; Decimal)
        {
            Caption = 'Actual Film Gauge';
            DataClassification = CustomerContent;
            Description = 'IWEB.634';
        }
        field(50063; "Tie Length"; Decimal)
        {
            Caption = 'Tie Length';
            DataClassification = CustomerContent;
            Description = 'IWEB.1054';
        }
        field(50064; "Superfund Tax Liable"; Boolean)
        {
            Caption = 'Superfund Tax Liable';
            DataClassification = CustomerContent;
            Description = 'IW1629';
        }
        field(75000; "Last Updated By"; Code[50])
        {
            Caption = 'Last Updated By';
            DataClassification = CustomerContent;
            TableRelation = User;
            Description = 'SCSNP';
            Editable = false;
        }
        field(75001; "Updated Date/Time"; DateTime)
        {
            Caption = 'Updated Date/Time';
            DataClassification = CustomerContent;
            Description = 'SCSNP';
            Editable = false;
        }
        field(75002; "Palletized Weight"; Decimal)
        {
            Caption = 'Palletized Weight';
            DataClassification = CustomerContent;
            Description = 'IWEB.002';
        }
        field(75003; "Machine Center Filter"; Code[20])
        {
            Caption = 'Machine Center Filter';
            FieldClass = FlowFilter;
            Editable = false;
        }
        field(75004; "Resin Pound Qty."; Decimal)
        {
            Caption = 'Resin Pound Qty.';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = FILTER("Output" | "Positive Adjmt."),
              "Posting Date" = FIELD("Date Filter"),
                   "Machine Center Code" = FIELD("Machine Center Filter")));
            Editable = false;
        }
        field(75005; "Resin Pound"; Decimal)
        {
            Caption = 'Resin Pound';
            FieldClass = FlowField;
            CalcFormula = Sum("Production BOM Line".Quantity WHERE("Production BOM No." = FIELD("Production BOM No."),
                       "Resin Item" = FILTER(true)));
            Editable = false;
        }
        field(75006; "Count Ledg Entries"; Integer)
        {
            Caption = 'Count Ledg Entries';
            FieldClass = FlowField;
            CalcFormula = Count("Item Ledger Entry" WHERE("Item No." = FIELD("No."),
                   "Posting Date" = FIELD("Date Filter"),
                  "Machine Center Code" = FIELD("Machine Center Filter"),
                     "Entry Type" = FILTER("Output" | "Positive Adjmt.")));
            Editable = false;
        }

    }
    keys
    {
        key(key20; "Item Type") { }
        key(key21; "Global Dimension 1 Code") { }
    }

    trigger OnAfterModify()
    begin
        //SCSNP BEGIN
        "Last Updated By" := USERID();
        "Updated Date/Time" := CURRENTDATETIME;
        //SCSNP END
    end;

    PROCEDURE CalcPalletizedWeight(): Decimal;
    VAR
        WarehouseSetup: Record "Warehouse Setup";
    BEGIN
        //002 (IWEB)
        WarehouseSetup.Get();
        EXIT("Gross Weight" * "Case Count" + WarehouseSetup."Pallet Weight");
    END;

    var
        UserSetup: Record "User Setup";
        CPText001Lbl: Label 'You do not have permissions to modify the Resin field.';

}
