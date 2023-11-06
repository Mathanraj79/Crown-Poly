xmlport 50008 "Def Dimensions"
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(Customers)
        {
            tableelement("Default Dimension"; "Default Dimension")
            {
                AutoReplace = true;
                XmlName = 'DDIM';
                fieldelement(c1; "Default Dimension"."Table ID")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c2; "Default Dimension"."No.")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c3; "Default Dimension"."Dimension Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c4; "Default Dimension"."Dimension Value Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c5; "Default Dimension"."Value Posting")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c6; "Default Dimension"."Multi Selection Action")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
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

    var
        rCust: Record Customer;
        rShip: Record "Ship-to Address";
}

