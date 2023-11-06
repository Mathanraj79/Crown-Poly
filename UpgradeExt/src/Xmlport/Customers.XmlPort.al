xmlport 50006 Customers
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(Customers)
        {
            tableelement("Payment Terms"; "Payment Terms")
            {
                AutoReplace = true;
                XmlName = 'PT';
                fieldelement(c1; "Payment Terms".Code)
                {
                }
                fieldelement(c2; "Payment Terms"."Due Date Calculation")
                {
                }
                fieldelement(c3; "Payment Terms"."Discount Date Calculation")
                {
                }
                fieldelement(c4; "Payment Terms"."Discount %")
                {
                }
                fieldelement(c5; "Payment Terms".Description)
                {
                }
                fieldelement(c6; "Payment Terms"."Calc. Pmt. Disc. on Cr. Memos")
                {
                }
            }
            tableelement("Finance Charge Terms"; "Finance Charge Terms")
            {
                AutoReplace = true;
                XmlName = 'FC';
                fieldelement(c1; "Finance Charge Terms".Code)
                {
                }
                fieldelement(c2; "Finance Charge Terms"."Interest Rate")
                {
                }
                fieldelement(c3; "Finance Charge Terms"."Minimum Amount (LCY)")
                {
                }
                fieldelement(c4; "Finance Charge Terms"."Additional Fee (LCY)")
                {
                }
                fieldelement(c5; "Finance Charge Terms".Description)
                {
                }
                fieldelement(c6; "Finance Charge Terms"."Interest Calculation Method")
                {
                }
                fieldelement(c8; "Finance Charge Terms"."Interest Period (Days)")
                {
                }
                fieldelement(c9; "Finance Charge Terms"."Grace Period")
                {
                }
                fieldelement(c10; "Finance Charge Terms"."Due Date Calculation")
                {
                }
                fieldelement(c11; "Finance Charge Terms"."Interest Calculation")
                {
                }
                fieldelement(c12; "Finance Charge Terms"."Post Interest")
                {
                }
                fieldelement(c13; "Finance Charge Terms"."Post Additional Fee")
                {
                }
                fieldelement(c14; "Finance Charge Terms"."Line Description")
                {
                }
            }
            tableelement("Country/Region"; "Country/Region")
            {
                AutoReplace = true;
                XmlName = 'Country';
                fieldelement(c1; "Country/Region".Code)
                {
                }
                fieldelement(c2; "Country/Region".Name)
                {
                }
                fieldelement(c3; "Country/Region"."EU Country/Region Code")
                {
                }
                fieldelement(c4; "Country/Region"."Intrastat Code")
                {
                }
                fieldelement(c5; "Country/Region"."Address Format")
                {
                }
                fieldelement(c6; "Country/Region"."Contact Address Format")
                {
                }
            }
            tableelement("Shipment Method"; "Shipment Method")
            {
                AutoReplace = true;
                XmlName = 'SM';
                fieldelement(c1; "Shipment Method".Code)
                {
                }
                fieldelement(c2; "Shipment Method".Description)
                {
                }
            }
            tableelement("Salesperson/Purchaser"; "Salesperson/Purchaser")
            {
                AutoReplace = true;
                XmlName = 'SP';
                fieldelement(c1; "Salesperson/Purchaser".Code)
                {
                }
                fieldelement(c2; "Salesperson/Purchaser".Name)
                {
                }
                fieldelement(c3; "Salesperson/Purchaser"."Commission %")
                {
                }
                fieldelement(c4; "Salesperson/Purchaser"."Global Dimension 1 Code")
                {
                }
                fieldelement(c5; "Salesperson/Purchaser"."Global Dimension 2 Code")
                {
                }
                fieldelement(c6; "Salesperson/Purchaser"."E-Mail")
                {
                }
                fieldelement(c8; "Salesperson/Purchaser"."Phone No.")
                {
                }
                fieldelement(c9; "Salesperson/Purchaser"."Job Title")
                {
                }
                fieldelement(c10; "Salesperson/Purchaser"."Search E-Mail")
                {
                }
                fieldelement(c11; "Salesperson/Purchaser".Broker)
                {
                }
            }
            tableelement(Location; Location)
            {
                AutoReplace = true;
                XmlName = 'LOC';
                fieldelement(c1; Location.Code)
                {
                }
                fieldelement(c2; Location.Name)
                {
                }
                fieldelement(c3; Location."Name 2")
                {
                }
                fieldelement(c4; Location.Address)
                {
                }
                fieldelement(c5; Location."Address 2")
                {
                }
                fieldelement(c6; Location.City)
                {
                }
                fieldelement(c8; Location."Phone No.")
                {
                }
                fieldelement(c9; Location."Phone No. 2")
                {
                }
                fieldelement(c10; Location."Telex No.")
                {
                }
                fieldelement(c11; Location."Fax No.")
                {
                }
                fieldelement(c12; Location.Contact)
                {
                }
                fieldelement(c14; Location."Post Code")
                {
                }
                fieldelement(c15; Location.County)
                {
                }
                fieldelement(c16; Location."E-Mail")
                {
                }
                fieldelement(c17; Location."Home Page")
                {
                }
                fieldelement(c18; Location."Country/Region Code")
                {
                }
                fieldelement(c19; Location."Use As In-Transit")
                {
                }
                fieldelement(c20; Location."Require Put-away")
                {
                }
                fieldelement(c21; Location."Require Pick")
                {
                }
                fieldelement(c22; Location."Cross-Dock Due Date Calc.")
                {
                }
                fieldelement(c23; Location."Use Cross-Docking")
                {
                }
                fieldelement(c24; Location."Require Receive")
                {
                }
                fieldelement(c25; Location."Require Shipment")
                {
                }
                fieldelement(c26; Location."Bin Mandatory")
                {
                }
                fieldelement(c27; Location."Directed Put-away and Pick")
                {
                }
                fieldelement(c28; Location."Default Bin Selection")
                {
                }
                fieldelement(c29; Location."Outbound Whse. Handling Time")
                {
                }
                fieldelement(c30; Location."Inbound Whse. Handling Time")
                {
                }
                fieldelement(c31; Location."Put-away Template Code")
                {
                }
                fieldelement(c32; Location."Use Put-away Worksheet")
                {
                }
                fieldelement(c33; Location."Allow Breakbulk")
                {
                }
                fieldelement(c34; Location."Bin Capacity Policy")
                {
                }
                fieldelement(c35; Location."Open Shop Floor Bin Code")
                {
                }
                fieldelement(c36; Location."To-Production Bin Code")
                {
                }
                fieldelement(c37; Location."From-Production Bin Code")
                {
                }
                fieldelement(c38; Location."Adjustment Bin Code")
                {
                }
                fieldelement(c39; Location."Always Create Put-away Line")
                {
                }
                fieldelement(c40; Location."Always Create Pick Line")
                {
                }
                fieldelement(c41; Location."Special Equipment")
                {
                }
                fieldelement(c42; Location."Receipt Bin Code")
                {
                }
                fieldelement(c43; Location."Shipment Bin Code")
                {
                }
                fieldelement(c44; Location."Cross-Dock Bin Code")
                {
                }
                fieldelement(c45; Location."From-Assembly Bin Code")
                {
                }
                fieldelement(c46; Location."To-Assembly Bin Code")
                {
                }
                fieldelement(c47; Location."Base Calendar Code")
                {
                }
                fieldelement(c48; Location."Use ADCS")
                {
                }
                fieldelement(c49; Location."Tax Area Code")
                {
                }
                fieldelement(c50; Location."Tax Exemption No.")
                {
                }
                fieldelement(c51; Location."In Transit Code")
                {
                }
            }
            tableelement("Customer Posting Group"; "Customer Posting Group")
            {
                AutoReplace = true;
                XmlName = 'CPG';
                fieldelement(c1; "Customer Posting Group".Code)
                {
                }
                fieldelement(c2; "Customer Posting Group"."Receivables Account")
                {
                }
                fieldelement(c3; "Customer Posting Group"."Service Charge Acc.")
                {
                }
                fieldelement(c4; "Customer Posting Group"."Payment Disc. Debit Acc.")
                {
                }
                fieldelement(c5; "Customer Posting Group"."Invoice Rounding Account")
                {
                }
                fieldelement(c6; "Customer Posting Group"."Interest Account")
                {
                }
                fieldelement(c8; "Customer Posting Group"."Debit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(c9; "Customer Posting Group"."Credit Curr. Appln. Rndg. Acc.")
                {
                }
                fieldelement(c10; "Customer Posting Group"."Debit Rounding Account")
                {
                }
                fieldelement(c11; "Customer Posting Group"."Credit Rounding Account")
                {
                }
                fieldelement(c12; "Customer Posting Group"."Payment Disc. Credit Acc.")
                {
                }
                fieldelement(c14; "Customer Posting Group"."Payment Tolerance Debit Acc.")
                {
                }
                fieldelement(c15; "Customer Posting Group"."Payment Tolerance Credit Acc.")
                {
                }
            }
            tableelement("Post Code"; "Post Code")
            {
                AutoReplace = true;
                XmlName = 'Post';
                fieldelement(c1; "Post Code".Code)
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c2; "Post Code".City)
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c3; "Post Code"."Search City")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
            }
            tableelement(Territory; Territory)
            {
                AutoReplace = true;
                XmlName = 'TER';
                fieldelement(c1; Territory.Code)
                {
                }
                fieldelement(c2; Territory.Name)
                {
                }
            }
            tableelement("Payment Method"; "Payment Method")
            {
                AutoReplace = true;
                XmlName = 'PayMe';
                fieldelement(c1; "Payment Method".Code)
                {
                }
                fieldelement(c2; "Payment Method".Description)
                {
                }
                fieldelement(c3; "Payment Method"."Bal. Account Type")
                {
                }
                fieldelement(c4; "Payment Method"."Bal. Account No.")
                {
                }
            }
            tableelement("Shipping Agent"; "Shipping Agent")
            {
                AutoReplace = true;
                XmlName = 'SHIPA';
                fieldelement(c1; "Shipping Agent".Code)
                {
                }
                fieldelement(c2; "Shipping Agent".Name)
                {
                }
                fieldelement(c3; "Shipping Agent"."Internet Address")
                {
                }
                fieldelement(c4; "Shipping Agent"."Account No.")
                {
                }
            }
            tableelement("Reminder Terms"; "Reminder Terms")
            {
                AutoReplace = true;
                XmlName = 'REMT';
                fieldelement(c1; "Reminder Terms".Code)
                {
                }
                fieldelement(c2; "Reminder Terms".Description)
                {
                }
                fieldelement(c3; "Reminder Terms"."Post Interest")
                {
                }
                fieldelement(c4; "Reminder Terms"."Post Additional Fee")
                {
                }
                fieldelement(c5; "Reminder Terms"."Max. No. of Reminders")
                {
                }
                fieldelement(c6; "Reminder Terms"."Minimum Amount (LCY)")
                {
                }
            }
            tableelement("No. Series"; "No. Series")
            {
                AutoReplace = true;
                XmlName = 'NOSER';
                fieldelement(c1; "No. Series".Code)
                {
                }
                fieldelement(c2; "No. Series".Description)
                {
                }
                fieldelement(c3; "No. Series"."Default Nos.")
                {
                }
                fieldelement(c4; "No. Series"."Manual Nos.")
                {
                }
                fieldelement(c5; "No. Series"."Date Order")
                {
                }
            }
            tableelement("No. Series Line"; "No. Series Line")
            {
                AutoReplace = true;
                XmlName = 'NSLine';
                fieldelement(c1; "No. Series Line"."Series Code")
                {
                }
                fieldelement(c2; "No. Series Line"."Line No.")
                {
                }
                fieldelement(c3; "No. Series Line"."Starting Date")
                {
                }
                fieldelement(c4; "No. Series Line"."Starting No.")
                {
                }
                fieldelement(c5; "No. Series Line"."Ending No.")
                {
                }
                fieldelement(c6; "No. Series Line"."Warning No.")
                {
                }
                fieldelement(c8; "No. Series Line"."Increment-by No.")
                {
                }
                fieldelement(c9; "No. Series Line"."Last No. Used")
                {
                }
                fieldelement(c10; "No. Series Line".Open)
                {
                }
                fieldelement(c11; "No. Series Line"."Last Date Used")
                {
                }
            }
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
            tableelement("Base Calendar"; "Base Calendar")
            {
                AutoReplace = true;
                XmlName = 'BC';
                fieldelement(c1; "Base Calendar".Code)
                {
                    FieldValidate = No;
                }
                fieldelement(c2; "Base Calendar".Name)
                {
                }
            }
            tableelement("Shipping Agent Services"; "Shipping Agent Services")
            {
                AutoReplace = true;
                XmlName = 'SAS';
                fieldelement(c1; "Shipping Agent Services"."Shipping Agent Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c2; "Shipping Agent Services".Code)
                {
                }
                fieldelement(c3; "Shipping Agent Services".Description)
                {
                }
                fieldelement(c4; "Shipping Agent Services"."Shipping Time")
                {
                }
                fieldelement(c5; "Shipping Agent Services"."Base Calendar Code")
                {
                    FieldValidate = No;
                }
            }
            tableelement(FOB; FOB)
            {
                AutoReplace = true;
                XmlName = 'FOB';
                fieldelement(c1; FOB.Code)
                {
                    FieldValidate = No;
                }
                fieldelement(c2; FOB.Description)
                {
                    FieldValidate = No;
                }
            }
            tableelement(Customer; Customer)
            {
                AutoReplace = true;
                XmlName = 'CUST';
                fieldelement(c1; Customer."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c2; Customer.Name)
                {
                    FieldValidate = No;
                }
                fieldelement(c3; Customer."Search Name")
                {
                    FieldValidate = No;
                }
                fieldelement(c4; Customer."Name 2")
                {
                    FieldValidate = No;
                }
                fieldelement(c5; Customer.Address)
                {
                }
                fieldelement(c6; Customer."Address 2")
                {
                }
                fieldelement(c8; Customer.City)
                {
                }
                fieldelement(c9; Customer.Contact)
                {
                }
                fieldelement(c10; Customer."Phone No.")
                {
                }
                fieldelement(c11; Customer."Telex No.")
                {
                }
                fieldelement(c12; Customer."Our Account No.")
                {
                }
                fieldelement(c14; Customer."Territory Code")
                {
                }
                fieldelement(c15; Customer."Global Dimension 1 Code")
                {
                }
                fieldelement(c16; Customer."Global Dimension 2 Code")
                {
                }
                fieldelement(c17; Customer."Chain Name")
                {
                }
                fieldelement(c18; Customer."Budgeted Amount")
                {
                }
                fieldelement(c19; Customer."Credit Limit (LCY)")
                {
                }
                fieldelement(c20; Customer."Customer Posting Group")
                {
                }
                fieldelement(c21; Customer."Currency Code")
                {
                }
                fieldelement(c22; Customer."Customer Price Group")
                {
                }
                fieldelement(c23; Customer."Language Code")
                {
                }
                fieldelement(c24; Customer."Statistics Group")
                {
                }
                fieldelement(c25; Customer."Fin. Charge Terms Code")
                {
                }
                fieldelement(c26; Customer."Salesperson Code")
                {
                }
                fieldelement(c27; Customer."Shipment Method Code")
                {
                }
                fieldelement(c28; Customer."Shipping Agent Code")
                {
                }
                fieldelement(c29; Customer."Place of Export")
                {
                }
                fieldelement(c30; Customer."Invoice Disc. Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c31; Customer."Customer Disc. Group")
                {
                }
                fieldelement(c32; Customer."Country/Region Code")
                {
                }
                fieldelement(c33; Customer."Collection Method")
                {
                }
                fieldelement(c34; Customer.Amount)
                {
                }
                fieldelement(c35; Customer.Blocked)
                {
                }
                fieldelement(c36; Customer."Invoice Copies")
                {
                }
                fieldelement(c37; Customer."Last Statement No.")
                {
                }
                fieldelement(c38; Customer."Print Statements")
                {
                }
                fieldelement(c39; Customer."Bill-to Customer No.")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c40; Customer.Priority)
                {
                }
                fieldelement(c41; Customer."Payment Method Code")
                {
                }
                fieldelement(c42; Customer."Last Date Modified")
                {
                }
                fieldelement(c43; Customer."Application Method")
                {
                }
                fieldelement(c44; Customer."Prices Including VAT")
                {
                }
                fieldelement(c45; Customer."Fax No.")
                {
                }
                fieldelement(c46; Customer."Telex Answer Back")
                {
                }
                fieldelement(c47; Customer."VAT Registration No.")
                {
                }
                fieldelement(c48; Customer."Combine Shipments")
                {
                }
                fieldelement(c49; Customer."Gen. Bus. Posting Group")
                {
                }
                fieldelement(c50; Customer."Post Code")
                {
                }
                fieldelement(c51; Customer.County)
                {
                }
                fieldelement(c52; Customer."E-Mail")
                {
                }
                fieldelement(c53; Customer."Home Page")
                {
                }
                fieldelement(c54; Customer."Reminder Terms Code")
                {
                }
                fieldelement(c55; Customer."No. Series")
                {
                }
                fieldelement(c56; Customer."Tax Area Code")
                {
                }
                fieldelement(c57; Customer."Tax Liable")
                {
                }
                fieldelement(c58; Customer."VAT Bus. Posting Group")
                {
                }
                fieldelement(c59; Customer.Reserve)
                {
                }
                fieldelement(c60; Customer."Block Payment Tolerance")
                {
                }
                fieldelement(c61; Customer."IC Partner Code")
                {
                }
                fieldelement(c62; Customer."Responsibility Center")
                {
                }
                fieldelement(c63; Customer."Shipping Advice")
                {
                }
                fieldelement(c64; Customer."Shipping Time")
                {
                }
                fieldelement(c65; Customer."Shipping Agent Service Code")
                {
                }
                fieldelement(c66; Customer."Service Zone Code")
                {
                }
                fieldelement(c67; Customer."Allow Line Disc.")
                {
                }
                fieldelement(c68; Customer."Base Calendar Code")
                {
                }
                fieldelement(c69; Customer."Copy Sell-to Addr. to Qte From")
                {
                }
                fieldelement(c70; Customer."UPS Zone")
                {
                }
                fieldelement(c71; Customer."Tax Exemption No.")
                {
                }
                fieldelement(c72; Customer."Bank Communication")
                {
                }
                fieldelement(c73; Customer."Check Date Format")
                {
                }
                fieldelement(c74; Customer."Check Date Separator")
                {
                }
                fieldelement(c75; Customer."Grace Period")
                {
                }
                fieldelement(c76; Customer."Address 3")
                {
                }
                fieldelement(c77; Customer.Attention)
                {
                }
                fieldelement(c78; Customer."Attn. Phone No.")
                {
                }
                fieldelement(c79; Customer."Salesperson 2")
                {
                }
                fieldelement(c80; Customer.Broker)
                {
                }
                fieldelement(c81; Customer."Broker 2")
                {
                }
                fieldelement(c82; Customer."Default Ship-to Address")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c83; Customer."F.O.B.")
                {
                }
                fieldelement(c84; Customer."Sales Quantity")
                {
                }
                fieldelement(c85; Customer."Sales Amount")
                {
                }
                fieldelement(c86; Customer."Location Code")
                {
                    AutoCalcField = false;
                }
                fieldelement(c87; Customer."Payment Terms Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
            }
            tableelement("Ship-to Address"; "Ship-to Address")
            {
                AutoReplace = true;
                XmlName = 'SHIPTO';
                fieldelement(c1; "Ship-to Address"."Customer No.")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c2; "Ship-to Address".Code)
                {
                }
                fieldelement(c3; "Ship-to Address".Name)
                {
                }
                fieldelement(c4; "Ship-to Address"."Name 2")
                {
                }
                fieldelement(c5; "Ship-to Address".Address)
                {
                }
                fieldelement(c6; "Ship-to Address"."Address 2")
                {
                }
                fieldelement(c8; "Ship-to Address".City)
                {
                }
                fieldelement(c9; "Ship-to Address".Contact)
                {
                }
                fieldelement(c10; "Ship-to Address"."Phone No.")
                {
                }
                fieldelement(c11; "Ship-to Address"."Telex No.")
                {
                }
                fieldelement(c12; "Ship-to Address"."Shipment Method Code")
                {
                }
                fieldelement(c14; "Ship-to Address"."Shipping Agent Code")
                {
                }
                fieldelement(c15; "Ship-to Address"."Place of Export")
                {
                }
                fieldelement(c16; "Ship-to Address"."Country/Region Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c17; "Ship-to Address"."Last Date Modified")
                {
                }
                fieldelement(c18; "Ship-to Address"."Location Code")
                {
                }
                fieldelement(c19; "Ship-to Address"."Fax No.")
                {
                }
                fieldelement(c20; "Ship-to Address"."Telex Answer Back")
                {
                }
                fieldelement(c21; "Ship-to Address"."Post Code")
                {
                }
                fieldelement(c22; "Ship-to Address".County)
                {
                }
                fieldelement(c23; "Ship-to Address"."E-Mail")
                {
                }
                fieldelement(c24; "Ship-to Address"."Home Page")
                {
                }
                fieldelement(c25; "Ship-to Address"."Tax Area Code")
                {
                }
                fieldelement(c26; "Ship-to Address"."Tax Liable")
                {
                }
                fieldelement(c27; "Ship-to Address"."Shipping Agent Service Code")
                {
                }
                fieldelement(c28; "Ship-to Address"."Service Zone Code")
                {
                }
                fieldelement(c29; "Ship-to Address"."UPS Zone")
                {
                }
                fieldelement(c30; "Ship-to Address"."Default Ship-to Address")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c31; "Ship-to Address".Notes)
                {
                }
                fieldelement(c32; "Ship-to Address"."F.O.B.")
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

