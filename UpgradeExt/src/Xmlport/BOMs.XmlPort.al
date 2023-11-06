xmlport 50004 BOMs
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(BOMs)
        {
            tableelement("Routing Link"; "Routing Link")
            {
                AutoReplace = true;
                XmlName = 'RL';
                fieldelement(c1; "Routing Link".Code)
                {
                }
                fieldelement(c2; "Routing Link".Description)
                {
                }
            }
            tableelement("Production BOM Header"; "Production BOM Header")
            {
                AutoReplace = true;
                XmlName = 'BH';
                fieldelement(c1; "Production BOM Header"."No.")
                {
                }
                fieldelement(c2; "Production BOM Header".Description)
                {
                }
                fieldelement(c3; "Production BOM Header"."Description 2")
                {
                }
                fieldelement(c4; "Production BOM Header"."Search Name")
                {
                }
                fieldelement(c5; "Production BOM Header"."Unit of Measure Code")
                {
                }
                fieldelement(c6; "Production BOM Header"."Low-Level Code")
                {
                }
                fieldelement(c7; "Production BOM Header"."Creation Date")
                {
                }
                fieldelement(c8; "Production BOM Header"."Last Date Modified")
                {
                }
                fieldelement(c9; "Production BOM Header".Status)
                {
                    FieldValidate = No;
                }
                fieldelement(c10; "Production BOM Header"."Version Nos.")
                {
                }
                fieldelement(c11; "Production BOM Header"."No. Series")
                {
                }
            }
            tableelement("Production BOM Line"; "Production BOM Line")
            {
                AutoReplace = true;
                XmlName = 'BL';
                fieldelement(c1; "Production BOM Line"."Production BOM No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c2; "Production BOM Line"."Line No.")
                {
                }
                fieldelement(c3; "Production BOM Line"."Version Code")
                {
                }
                fieldelement(c4; "Production BOM Line".Type)
                {
                }
                fieldelement(c5; "Production BOM Line"."No.")
                {
                }
                fieldelement(c6; "Production BOM Line".Description)
                {
                }
                fieldelement(c8; "Production BOM Line"."Unit of Measure Code")
                {
                }
                fieldelement(c9; "Production BOM Line".Quantity)
                {
                }
                fieldelement(c10; "Production BOM Line".Position)
                {
                }
                fieldelement(c11; "Production BOM Line"."Position 2")
                {
                }
                fieldelement(c12; "Production BOM Line"."Position 3")
                {
                }
                fieldelement(c14; "Production BOM Line"."Routing Link Code")
                {
                }
                fieldelement(c15; "Production BOM Line"."Scrap %")
                {
                }
                fieldelement(c16; "Production BOM Line"."Variant Code")
                {
                }
                fieldelement(c17; "Production BOM Line"."Starting Date")
                {
                }
                fieldelement(c18; "Production BOM Line"."Ending Date")
                {
                }
                fieldelement(c19; "Production BOM Line".Length)
                {
                }
                fieldelement(c20; "Production BOM Line".Width)
                {
                }
                fieldelement(c21; "Production BOM Line".Weight)
                {
                }
                fieldelement(c22; "Production BOM Line".Depth)
                {
                }
                fieldelement(c23; "Production BOM Line"."Calculation Formula")
                {
                }
                fieldelement(c24; "Production BOM Line"."Quantity per")
                {
                }
                fieldelement(c25; "Production BOM Line"."Resin Item")
                {
                }
                fieldelement(c26; "Production BOM Line"."Scrap Item")
                {
                }
                fieldelement(c27; "Production BOM Line"."CP Scrap %")
                {
                }
                fieldelement(c28; "Production BOM Line"."Scrap Qty")
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

