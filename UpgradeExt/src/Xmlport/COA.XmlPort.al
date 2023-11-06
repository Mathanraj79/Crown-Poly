xmlport 50005 COA
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(COAs)
        {
            tableelement("Gen. Business Posting Group"; "Gen. Business Posting Group")
            {
                AutoReplace = true;
                XmlName = 'CUM';
                fieldelement(c1; "Gen. Business Posting Group".Code)
                {
                }
                fieldelement(c2; "Gen. Business Posting Group".Description)
                {
                }
                fieldelement(c3; "Gen. Business Posting Group"."Def. VAT Bus. Posting Group")
                {
                }
                fieldelement(c4; "Gen. Business Posting Group"."Auto Insert Default")
                {
                }
            }
            tableelement("Gen. Product Posting Group"; "Gen. Product Posting Group")
            {
                AutoReplace = true;
                XmlName = 'GPPG';
                fieldelement(c1; "Gen. Product Posting Group".Code)
                {
                }
                fieldelement(c2; "Gen. Product Posting Group".Description)
                {
                }
                fieldelement(c3; "Gen. Product Posting Group"."Def. VAT Prod. Posting Group")
                {
                }
                fieldelement(c4; "Gen. Product Posting Group"."Auto Insert Default")
                {
                }
            }
            tableelement("Tax Area"; "Tax Area")
            {
                AutoReplace = true;
                XmlName = 'TA';
                fieldelement(c1; "Tax Area".Code)
                {
                }
                fieldelement(c2; "Tax Area".Description)
                {
                }
                fieldelement(c3; "Tax Area"."Country/Region")
                {
                    FieldValidate = No;
                }
            }
            tableelement("Tax Group"; "Tax Group")
            {
                AutoReplace = true;
                XmlName = 'TG';
                fieldelement(c1; "Tax Group".Code)
                {
                }
                fieldelement(c2; "Tax Group".Description)
                {
                }
            }
            tableelement("VAT Product Posting Group"; "VAT Product Posting Group")
            {
                AutoReplace = true;
                XmlName = 'VPPG';
                fieldelement(c1; "VAT Product Posting Group".Code)
                {
                }
                fieldelement(c2; "VAT Product Posting Group".Description)
                {
                }
            }
            tableelement(Dimension; Dimension)
            {
                AutoReplace = true;
                XmlName = 'Dim';
                fieldelement(c1; Dimension.Code)
                {
                }
                fieldelement(c2; Dimension.Name)
                {
                }
                fieldelement(c3; Dimension."Code Caption")
                {
                }
                fieldelement(c4; Dimension."Filter Caption")
                {
                }
                fieldelement(c5; Dimension.Description)
                {
                }
                fieldelement(c6; Dimension.Blocked)
                {
                }
                fieldelement(c8; Dimension."Consolidation Code")
                {
                }
                fieldelement(c9; Dimension."Map-to IC Dimension Code")
                {
                }
            }
            tableelement("Dimension Value"; "Dimension Value")
            {
                AutoReplace = true;
                XmlName = 'DimV';
                fieldelement(c1; "Dimension Value"."Dimension Code")
                {
                }
                fieldelement(c2; "Dimension Value".Code)
                {
                }
                fieldelement(c3; "Dimension Value".Name)
                {
                }
                fieldelement(c4; "Dimension Value"."Dimension Value Type")
                {
                }
                fieldelement(c5; "Dimension Value".Totaling)
                {
                }
                fieldelement(c6; "Dimension Value".Blocked)
                {
                }
                fieldelement(c8; "Dimension Value"."Consolidation Code")
                {
                }
                fieldelement(c9; "Dimension Value".Indentation)
                {
                }
                fieldelement(c10; "Dimension Value"."Global Dimension No.")
                {
                }
                fieldelement(c11; "Dimension Value"."Map-to IC Dimension Code")
                {
                }
                fieldelement(c12; "Dimension Value"."Map-to IC Dimension Value Code")
                {
                }
            }
            tableelement("G/L Account"; "G/L Account")
            {
                AutoReplace = true;
                XmlName = 'COA';
                fieldelement(c1; "G/L Account"."No.")
                {
                }
                fieldelement(c2; "G/L Account".Name)
                {
                }
                fieldelement(c3; "G/L Account"."Search Name")
                {
                }
                fieldelement(c4; "G/L Account"."Account Type")
                {
                }
                fieldelement(c5; "G/L Account"."Global Dimension 1 Code")
                {
                }
                fieldelement(c6; "G/L Account"."Global Dimension 2 Code")
                {
                }
                fieldelement(c8; "G/L Account"."Income/Balance")
                {
                }
                fieldelement(c9; "G/L Account"."Debit/Credit")
                {
                }
                fieldelement(c10; "G/L Account"."No. 2")
                {
                }
                fieldelement(c11; "G/L Account".Blocked)
                {
                }
                fieldelement(c12; "G/L Account"."Direct Posting")
                {
                }
                fieldelement(c14; "G/L Account"."Reconciliation Account")
                {
                }
                fieldelement(c15; "G/L Account"."New Page")
                {
                }
                fieldelement(c16; "G/L Account"."No. of Blank Lines")
                {
                }
                fieldelement(c17; "G/L Account".Indentation)
                {
                }
                fieldelement(c18; "G/L Account"."Last Date Modified")
                {
                }
                fieldelement(c19; "G/L Account"."Budgeted Amount")
                {
                }
                fieldelement(c20; "G/L Account".Totaling)
                {
                }
                fieldelement(c21; "G/L Account"."Consol. Translation Method")
                {
                }
                fieldelement(c22; "G/L Account"."Consol. Debit Acc.")
                {
                }
                fieldelement(c23; "G/L Account"."Consol. Credit Acc.")
                {
                }
                fieldelement(c24; "G/L Account"."Gen. Posting Type")
                {
                }
                fieldelement(c25; "G/L Account"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(c26; "G/L Account"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(c27; "G/L Account"."Automatic Ext. Texts")
                {
                }
                fieldelement(c28; "G/L Account"."Tax Area Code")
                {
                }
                fieldelement(c29; "G/L Account"."Tax Liable")
                {
                }
                fieldelement(c30; "G/L Account"."Tax Group Code")
                {
                }
                fieldelement(c31; "G/L Account"."VAT Bus. Posting Group")
                {
                }
                fieldelement(c32; "G/L Account"."VAT Prod. Posting Group")
                {
                }
                fieldelement(c33; "G/L Account"."Additional-Currency Net Change")
                {
                }
                fieldelement(c34; "G/L Account"."Add.-Currency Balance at Date")
                {
                }
                fieldelement(c35; "G/L Account"."Additional-Currency Balance")
                {
                }
                fieldelement(c36; "G/L Account"."Exchange Rate Adjustment")
                {
                }
                fieldelement(c37; "G/L Account"."Default IC Partner G/L Acc. No")
                {
                }
                fieldelement(c38; "G/L Account"."GIFI Code")
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

