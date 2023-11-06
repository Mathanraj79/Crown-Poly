xmlport 50001 Item1
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(Items)
        {
            tableelement("Unit of Measure"; "Unit of Measure")
            {
                AutoReplace = true;
                XmlName = 'UOMs';
                fieldelement(Code; "Unit of Measure".Code)
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(Description; "Unit of Measure".Description)
                {
                }
            }
            tableelement("Inventory Posting Group"; "Inventory Posting Group")
            {
                AutoReplace = true;
                XmlName = 'IPG';
                fieldelement(Code; "Inventory Posting Group".Code)
                {
                }
                fieldelement(Desc; "Inventory Posting Group".Description)
                {
                }
            }
            tableelement("Tax Group"; "Tax Group")
            {
                AutoReplace = true;
                XmlName = 'TGC';
                fieldelement(Code; "Tax Group".Code)
                {
                }
                fieldelement(Desc; "Tax Group".Description)
                {
                }
            }
            tableelement("Item Discount Group"; "Item Discount Group")
            {
                AutoReplace = true;
                XmlName = 'IDG';
                fieldelement(Code; "Item Discount Group".Code)
                {
                }
                fieldelement(Desc; "Item Discount Group".Description)
                {
                }
            }
            tableelement("Item Category"; "Item Category")
            {
                AutoReplace = true;
                XmlName = 'ICAT';
                fieldelement(C1; "Item Category".Code)
                {
                }
                fieldelement(c2; "Item Category".Description)
                {
                }
                // fieldelement(c3; "Item Category"."Def. Gen. Prod. Posting Group")
                // {
                // }
                // fieldelement(c4; "Item Category"."Def. Inventory Posting Group")
                // {
                // }
                // fieldelement(c5; "Item Category"."Def. Tax Group Code")
                // {
                // }
                // fieldelement(c6; "Item Category"."Def. Costing Method")
                // {
                // }
                // fieldelement(c7; "Item Category"."Def. VAT Prod. Posting Group")
                // {
                // }
            }
            tableelement("Ink Colors"; "Ink Colors")
            {
                AutoReplace = true;
                XmlName = 'Ink';
                fieldelement(c1; "Ink Colors".Code)
                {
                }
                fieldelement(c2; "Ink Colors".Description)
                {
                }
            }
            tableelement("Bag Dimensions"; "Bag Dimensions")
            {
                AutoReplace = true;
                XmlName = 'BD';
                fieldelement(c1; "Bag Dimensions".Code)
                {
                }
                fieldelement(c2; "Bag Dimensions".Description)
                {
                }
            }
            tableelement("Film Types"; "Film Types")
            {
                AutoReplace = true;
                XmlName = 'FT';
                fieldelement(c1; "Film Types".Code)
                {
                }
                fieldelement(c2; "Film Types".Description)
                {
                }
            }
            tableelement("Film Colors"; "Film Colors")
            {
                AutoReplace = true;
                XmlName = 'FC';
                fieldelement(c1; "Film Colors".Code)
                {
                }
                fieldelement(c2; "Film Colors".Description)
                {
                }
            }
            tableelement(Palletizations; Palletizations)
            {
                AutoReplace = true;
                XmlName = 'Pallet';
                fieldelement(c1; Palletizations.Code)
                {
                }
                fieldelement(c2; Palletizations.Description)
                {
                }
            }
            tableelement("Case Dimensions"; "Case Dimensions")
            {
                AutoReplace = true;
                XmlName = 'CD';
                fieldelement(c1; "Case Dimensions".Code)
                {
                }
                fieldelement(c2; "Case Dimensions".Description)
                {
                }
            }
            tableelement(Item; Item)
            {
                AutoReplace = true;
                MaxOccurs = Unbounded;
                XmlName = 'Item';
                fieldelement("No."; Item."No.")
                {
                    MaxOccurs = Unbounded;
                }
                fieldelement("No._2"; Item."No. 2")
                {
                }
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(SearchDesc; Item."Search Description")
                {
                }
                fieldelement(Description2; Item."Description 2")
                {
                }
                fieldelement(Base_Unit_of_Measure; Item."Base Unit of Measure")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c1; Item."Price Unit Conversion")
                {
                }
                fieldelement(c2; Item."Inventory Posting Group")
                {
                }
                fieldelement(c3; Item."Shelf No.")
                {
                }
                fieldelement(c4; Item."Item Disc. Group")
                {
                }
                fieldelement(c5; Item."Allow Invoice Disc.")
                {
                }
                fieldelement(c6; Item."Statistics Group")
                {
                }
                fieldelement(c7; Item."Commission Group")
                {
                }
                fieldelement(c8; Item."Unit Price")
                {
                }
                fieldelement(c9; Item."Price/Profit Calculation")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c10; Item."Profit %")
                {
                }
                fieldelement(c11; Item."Costing Method")
                {
                }
                fieldelement(c12; Item."Unit Cost")
                {
                }
                fieldelement(c13; Item."Standard Cost")
                {
                }
                fieldelement(c14; Item."Last Direct Cost")
                {
                }
                fieldelement(c15; Item."Indirect Cost %")
                {
                }
                fieldelement(c16; Item."Cost is Adjusted")
                {
                }
                fieldelement(c17; Item."Allow Online Adjustment")
                {
                }
                fieldelement(c18; Item."Vendor No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c19; Item."Vendor Item No.")
                {
                }
                fieldelement(c20; Item."Lead Time Calculation")
                {
                }
                fieldelement(c21; Item."Reorder Point")
                {
                }
                fieldelement(c22; Item."Maximum Inventory")
                {
                }
                fieldelement(c23; Item."Reorder Quantity")
                {
                }
                fieldelement(c24; Item."Alternative Item No.")
                {
                }
                fieldelement(c25; Item."Unit List Price")
                {
                }
                fieldelement(c26; Item."Duty Due %")
                {
                }
                fieldelement(c27; Item."Duty Code")
                {
                }
                fieldelement(c28; Item."Gross Weight")
                {
                }
                fieldelement(c29; Item."Net Weight")
                {
                }
                fieldelement(c30; Item."Units per Parcel")
                {
                }
                fieldelement(c31; Item."Unit Volume")
                {
                }
                fieldelement(c32; Item.Durability)
                {
                }
                fieldelement(c33; Item."Freight Type")
                {
                }
                fieldelement(c34; Item."Tariff No.")
                {
                }
                fieldelement(c35; Item."Duty Unit Conversion")
                {
                }
                fieldelement(c36; Item."Country/Region Purchased Code")
                {
                }
                fieldelement(c37; Item."Budget Quantity")
                {
                }
                fieldelement(c38; Item."Budgeted Amount")
                {
                }
                fieldelement(c39; Item."Budget Profit")
                {
                }
                fieldelement(c40; Item.Blocked)
                {
                }
                fieldelement(c41; Item."Last Date Modified")
                {
                }
                fieldelement(c42; Item."Price Includes VAT")
                {
                }
                fieldelement(c43; Item."VAT Bus. Posting Gr. (Price)")
                {
                }
                fieldelement(c44; Item."Gen. Prod. Posting Group")
                {
                }
                fieldelement(c45; Item."Country/Region of Origin Code")
                {
                }
                fieldelement(c46; Item."Automatic Ext. Texts")
                {
                }
                fieldelement(c47; Item."No. Series")
                {
                }
                fieldelement(c48; Item."Tax Group Code")
                {
                }
                fieldelement(c49; Item."VAT Prod. Posting Group")
                {
                }
                fieldelement(c50; Item.Reserve)
                {
                }
                fieldelement(c51; Item."Global Dimension 1 Code")
                {
                }
                fieldelement(c52; Item."Global Dimension 2 Code")
                {
                }
                fieldelement(c53; Item."Low-Level Code")
                {
                }
                fieldelement(c54; Item."Lot Size")
                {
                }
                fieldelement(c56; Item."Last Unit Cost Calc. Date")
                {
                }
                fieldelement(c57; Item."Rolled-up Material Cost")
                {
                }
                fieldelement(c58; Item."Rolled-up Capacity Cost")
                {
                }
                fieldelement(c59; Item."Scrap %")
                {
                }
                fieldelement(c60; Item."Inventory Value Zero")
                {
                }
                fieldelement(c61; Item."Discrete Order Quantity")
                {
                }
                fieldelement(c62; Item."Minimum Order Quantity")
                {
                }
                fieldelement(c63; Item."Maximum Order Quantity")
                {
                }
                fieldelement(c64; Item."Safety Stock Quantity")
                {
                }
                fieldelement(c65; Item."Order Multiple")
                {
                }
                fieldelement(c66; Item."Safety Lead Time")
                {
                }
                fieldelement(c67; Item."Flushing Method")
                {
                }
                fieldelement(c68; Item."Replenishment System")
                {
                }
                fieldelement(c69; Item."Rounding Precision")
                {
                }
                fieldelement(c70; Item."Sales Unit of Measure")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c71; Item."Purch. Unit of Measure")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c72; Item."Time Bucket")
                {
                }
                fieldelement(c73; Item."Reordering Policy")
                {
                }
                fieldelement(c74; Item."Include Inventory")
                {
                }
                fieldelement(c75; Item."Manufacturing Policy")
                {
                }
                fieldelement(c76; Item."Manufacturer Code")
                {
                }
                fieldelement(c77; Item."Item Category Code")
                {
                }
                fieldelement(c78; Item."Created From Nonstock Item")
                {
                }
                fieldelement(c79; Item."Item Category Code")
                {
                }
                fieldelement(c80; Item."Service Item Group")
                {
                }
                fieldelement(c81; Item."Item Tracking Code")
                {
                }
                fieldelement(c82; Item."Lot Nos.")
                {
                }
                fieldelement(c83; Item."Expiration Calculation")
                {
                }
                fieldelement(c84; Item."Duty Class")
                {
                }
                fieldelement(c85; Item."Sales G/L Account")
                {
                }
                fieldelement(c86; Item."Purch. G/L Account")
                {
                }
                fieldelement(c87; Item."Print Text")
                {
                }
                fieldelement(c88; Item."Ink Color No. 1")
                {
                }
                fieldelement(c89; Item."Ink Color No. 2")
                {
                }
                fieldelement(c90; Item."Ink Color No. 3")
                {
                }
                fieldelement(c91; Item."Die Cut")
                {
                }
                fieldelement(c92; Item."Bag Dimensions")
                {
                }
                fieldelement(c93; Item."Film Gauge")
                {
                }
                fieldelement(c94; Item."Film Type")
                {
                }
                fieldelement(c95; Item."Bags per Roll/Bundle")
                {
                }
                fieldelement(c96; Item."Rolls/Bundles per Case")
                {
                }
                fieldelement(c97; Item."Case Count")
                {
                }
                fieldelement(c98; Item."Film Color")
                {
                }
                fieldelement(c99; Item.Glue)
                {
                }
                fieldelement(c100; Item."UPC Code")
                {
                }
                fieldelement(c101; Item.Palletization)
                {
                }
                fieldelement(c102; Item."Pallet Dimensions")
                {
                }
                fieldelement(c103; Item."Pallets per Truck")
                {
                }
                fieldelement(c104; Item."Cases per Truck")
                {
                }
                fieldelement(c105; Item."Case Dimensions")
                {
                }
                fieldelement(c106; Item."Case Cube")
                {
                }
                fieldelement(c107; Item."Description 3")
                {
                }
                fieldelement(c108; Item."Description 4")
                {
                }
                fieldelement(c109; Item."Description 5")
                {
                }
                fieldelement(c110; Item.Resin)
                {
                }
                fieldelement(c111; Item."Item Type")
                {
                }
                fieldelement(c112; Item."Amount on Sales Order")
                {
                }
                fieldelement(c113; Item.Scrap)
                {
                }
                fieldelement(c114; Item."Physical Inventory Group Code")
                {
                }
                fieldelement(c115; Item."Shortcut Dimension 3")
                {
                }
                fieldelement(c116; Item."Hippo Junior")
                {
                }
                fieldelement(c117; Item."T Shirt")
                {
                }
                fieldelement(c118; Item."Print Scrap")
                {
                }
                fieldelement(c119; Item."Clear Scrap")
                {
                }
                fieldelement(c120; Item."Scrap Dept")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c121; Item."Scrap Item")
                {
                    FieldValidate = No;
                }
                fieldelement(c122; Item."Die Cut Scrap")
                {
                }
                fieldelement(c123; Item."Do not Allow Two Sided Entry")
                {
                }
                fieldelement(c124; Item."CP Overhead Rate")
                {
                }
                fieldelement(c125; Item."Die Cut Item")
                {
                    FieldValidate = No;
                }
                fieldelement(c126; Item.Quantity)
                {
                }
                fieldelement(c127; Item.Amount)
                {
                }
                fieldelement(c128; Item."RPO Notes")
                {
                }
                fieldelement(c129; Item."Film Titan")
                {
                }
                fieldelement(c131; Item."Updated Date/Time")
                {
                }
                fieldelement(c132; Item."Routing No.")
                {
                    AutoCalcField = true;
                    FieldValidate = No;
                }
                fieldelement(c133; Item."Production BOM No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c134; Item."Single-Level Material Cost")
                {
                }
                fieldelement(c135; Item."Single-Level Capacity Cost")
                {
                }
                fieldelement(c136; Item."Single-Level Subcontrd. Cost")
                {
                }
                fieldelement(c137; Item."Single-Level Cap. Ovhd Cost")
                {
                }
                fieldelement(c138; Item."Single-Level Mfg. Ovhd Cost")
                {
                }
                fieldelement(c139; Item."Overhead Rate")
                {
                }
                fieldelement(c140; Item."Rolled-up Subcontracted Cost")
                {
                }
                fieldelement(c141; Item."Rolled-up Mfg. Ovhd Cost")
                {
                }
                fieldelement(c142; Item."Rolled-up Cap. Overhead Cost")
                {
                }
                fieldelement(c143; Item."Order Tracking Policy")
                {
                }
                fieldelement(c144; Item.Critical)
                {
                }
                fieldelement(c145; Item."Common Item No.")
                {
                }
                fieldelement(C146; Item."Serial Nos.")
                {
                }
                fieldelement(c147; Item."Last Updated By")
                {
                    AutoCalcField = false;
                    FieldValidate = No;

                    trigger OnAfterAssignField()
                    begin
                        //Item."Last Updated By":=Item."Last Updated By";
                        //Item.MODIFY;
                    end;
                }
            }
            tableelement("item unit of measure"; "Item Unit of Measure")
            {
                AutoReplace = true;
                XmlName = 'IUOM';
                fieldelement(ItemNo; "Item Unit of Measure"."Item No.")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(Code; "Item Unit of Measure".Code)
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(Qty; "Item Unit of Measure"."Qty. per Unit of Measure")
                {
                }
                fieldelement(Len; "Item Unit of Measure".Length)
                {
                }
                fieldelement(Wid; "Item Unit of Measure".Width)
                {
                }
                fieldelement(Hei; "Item Unit of Measure".Height)
                {
                }
                fieldelement(Cub; "Item Unit of Measure".Cubage)
                {
                }
                fieldelement(Weight; "Item Unit of Measure".Weight)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

