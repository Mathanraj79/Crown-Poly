xmlport 50003 FAs
{
    FormatEvaluate = Xml;
    UseDefaultNamespace = false;

    schema
    {
        textelement(FAs)
        {
            tableelement("Capacity Unit of Measure";"Capacity Unit of Measure")
            {
                AutoReplace = true;
                XmlName = 'CUM';
                fieldelement(c1; "Capacity Unit of Measure".Code)
                {
                }
                fieldelement(c2; "Capacity Unit of Measure".Description)
                {
                }
                fieldelement(c3; "Capacity Unit of Measure".Type)
                {
                }
            }
            tableelement(Employee; Employee)
            {
                AutoReplace = true;
                XmlName = 'EMP';
                fieldelement(c1; Employee."No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c2; Employee."First Name")
                {
                    FieldValidate = No;
                }
                fieldelement(c3; Employee."Last Name")
                {
                    FieldValidate = No;
                }
                fieldelement(c4; Employee."Search Name")
                {
                    FieldValidate = No;
                }
                fieldelement(c5; Employee.Status)
                {
                    FieldValidate = No;
                }
                fieldelement(c6; Employee."Last Date Modified")
                {
                    FieldValidate = No;
                }
                fieldelement(c7; Employee."No. Series")
                {
                    FieldValidate = No;
                }
            }
            tableelement("FA Posting Group"; "FA Posting Group")
            {
                AutoReplace = true;
                XmlName = 'FAPG';
                fieldelement(c1; "FA Posting Group".Code)
                {
                }
                fieldelement(c2; "FA Posting Group"."Acquisition Cost Account")
                {
                }
                fieldelement(c3; "FA Posting Group"."Accum. Depreciation Account")
                {
                }
                fieldelement(c4; "FA Posting Group"."Write-Down Account")
                {
                }
                fieldelement(c5; "FA Posting Group"."Appreciation Account")
                {
                }
                fieldelement(c6; "FA Posting Group"."Custom 1 Account")
                {
                }
                fieldelement(c7; "FA Posting Group"."Custom 2 Account")
                {
                }
                fieldelement(c8; "FA Posting Group"."Acq. Cost Acc. on Disposal")
                {
                }
                fieldelement(c9; "FA Posting Group"."Accum. Depr. Acc. on Disposal")
                {
                }
                fieldelement(c10; "FA Posting Group"."Write-Down Acc. on Disposal")
                {
                }
                fieldelement(c11; "FA Posting Group"."Appreciation Acc. on Disposal")
                {
                }
                fieldelement(c12; "FA Posting Group"."Custom 1 Account on Disposal")
                {
                }
                fieldelement(c13; "FA Posting Group"."Custom 2 Account on Disposal")
                {
                }
                fieldelement(c14; "FA Posting Group"."Gains Acc. on Disposal")
                {
                }
                fieldelement(c15; "FA Posting Group"."Losses Acc. on Disposal")
                {
                }
                fieldelement(c16; "FA Posting Group"."Book Val. Acc. on Disp. (Gain)")
                {
                }
                fieldelement(c17; "FA Posting Group"."Sales Acc. on Disp. (Gain)")
                {
                }
                fieldelement(c18; "FA Posting Group"."Write-Down Bal. Acc. on Disp.")
                {
                }
                fieldelement(c19; "FA Posting Group"."Apprec. Bal. Acc. on Disp.")
                {
                }
                fieldelement(c20; "FA Posting Group"."Custom 1 Bal. Acc. on Disposal")
                {
                }
                fieldelement(c21; "FA Posting Group"."Custom 2 Bal. Acc. on Disposal")
                {
                }
                fieldelement(c22; "FA Posting Group"."Maintenance Expense Account")
                {
                }
                fieldelement(c23; "FA Posting Group"."Maintenance Bal. Acc.")
                {
                }
                fieldelement(c24; "FA Posting Group"."Acquisition Cost Bal. Acc.")
                {
                }
                fieldelement(c25; "FA Posting Group"."Depreciation Expense Acc.")
                {
                }
                fieldelement(c26; "FA Posting Group"."Write-Down Expense Acc.")
                {
                }
                fieldelement(c27; "FA Posting Group"."Appreciation Bal. Account")
                {
                }
                fieldelement(c28; "FA Posting Group"."Custom 1 Expense Acc.")
                {
                }
                fieldelement(c29; "FA Posting Group"."Custom 2 Expense Acc.")
                {
                }
                fieldelement(c30; "FA Posting Group"."Sales Bal. Acc.")
                {
                }
                fieldelement(c31; "FA Posting Group"."Allocated Acquisition Cost %")
                {
                }
                fieldelement(c32; "FA Posting Group"."Allocated Depreciation %")
                {
                }
                fieldelement(c33; "FA Posting Group"."Allocated Write-Down %")
                {
                }
                fieldelement(c34; "FA Posting Group"."Allocated Appreciation %")
                {
                }
                fieldelement(c35; "FA Posting Group"."Allocated Custom 1 %")
                {
                }
                fieldelement(c36; "FA Posting Group"."Allocated Custom 2 %")
                {
                }
                fieldelement(c37; "FA Posting Group"."Allocated Sales Price %")
                {
                }
                fieldelement(c38; "FA Posting Group"."Allocated Maintenance %")
                {
                }
                fieldelement(c39; "FA Posting Group"."Allocated Gain %")
                {
                }
                fieldelement(c40; "FA Posting Group"."Allocated Loss %")
                {
                }
                fieldelement(c41; "FA Posting Group"."Allocated Book Value % (Gain)")
                {
                }
                fieldelement(c42; "FA Posting Group"."Allocated Book Value % (Loss)")
                {
                }
                fieldelement(c43; "FA Posting Group"."Sales Acc. on Disp. (Loss)")
                {
                }
                fieldelement(c44; "FA Posting Group"."Book Val. Acc. on Disp. (Loss)")
                {
                }
            }
            tableelement("FA Class"; "FA Class")
            {
                AutoReplace = true;
                XmlName = 'FAC';
                fieldelement(c1; "FA Class".Code)
                {
                }
                fieldelement(c2; "FA Class".Name)
                {
                }
            }
            tableelement("FA Subclass"; "FA Subclass")
            {
                AutoReplace = true;
                XmlName = 'FASC';
                fieldelement(c1; "FA Subclass".Code)
                {
                }
                fieldelement(c2; "FA Subclass".Name)
                {
                }
            }
            tableelement("FA Location"; "FA Location")
            {
                AutoReplace = true;
                XmlName = 'FAL';
                fieldelement(c1; "FA Location".Code)
                {
                }
                fieldelement(c2; "FA Location".Name)
                {
                }
            }
            tableelement("Machine Center";"Machine Center")
            {
                AutoReplace = true;
                XmlName = 'MC';
                fieldelement(c1; "Machine Center"."No.")
                {
                }
                fieldelement(c2; "Machine Center".Name)
                {
                }
                fieldelement(c3; "Machine Center"."Search Name")
                {
                }
                fieldelement(c4; "Machine Center"."Name 2")
                {
                }
                fieldelement(c5; "Machine Center".Address)
                {
                }
                fieldelement(c6; "Machine Center"."Address 2")
                {
                }
                fieldelement(c8; "Machine Center".City)
                {
                }
                fieldelement(c9; "Machine Center"."Post Code")
                {
                }
                fieldelement(c10; "Machine Center"."Work Center No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c11; "Machine Center"."Direct Unit Cost")
                {
                }
                fieldelement(c12; "Machine Center"."Indirect Cost %")
                {
                }
                fieldelement(c13; "Machine Center"."Unit Cost")
                {
                }
                fieldelement(c14; "Machine Center"."Queue Time")
                {
                }
                fieldelement(c15; "Machine Center"."Queue Time Unit of Meas. Code")
                {
                }
                fieldelement(c16; "Machine Center"."Last Date Modified")
                {
                }
                fieldelement(c17; "Machine Center".Capacity)
                {
                }
                fieldelement(c18; "Machine Center".Efficiency)
                {
                }
                fieldelement(c19; "Machine Center"."Maximum Efficiency")
                {
                }
                fieldelement(c20; "Machine Center"."Minimum Efficiency")
                {
                }
                fieldelement(c21; "Machine Center".Blocked)
                {
                }
                fieldelement(c22; "Machine Center"."Setup Time")
                {
                }
                fieldelement(c23; "Machine Center"."Wait Time")
                {
                }
                fieldelement(c24; "Machine Center"."Move Time")
                {
                }
                fieldelement(c25; "Machine Center"."Fixed Scrap Quantity")
                {
                }
                fieldelement(c26; "Machine Center"."Scrap %")
                {
                }
                fieldelement(c27; "Machine Center"."Setup Time Unit of Meas. Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c28; "Machine Center"."Wait Time Unit of Meas. Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c29; "Machine Center"."Send-Ahead Quantity")
                {
                }
                fieldelement(c30; "Machine Center"."Move Time Unit of Meas. Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c31; "Machine Center"."Flushing Method")
                {
                }
                fieldelement(c32; "Machine Center"."Minimum Process Time")
                {
                }
                fieldelement(c33; "Machine Center"."Maximum Process Time")
                {
                }
                fieldelement(c34; "Machine Center"."Concurrent Capacities")
                {
                }
                fieldelement(c35; "Machine Center"."No. Series")
                {
                }
                fieldelement(c36; "Machine Center"."Overhead Rate")
                {
                }
                fieldelement(c37; "Machine Center"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(c38; "Machine Center".County)
                {
                }
                fieldelement(c40; "Machine Center"."Expected Cases")
                {
                }
            }
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoReplace = true;
                XmlName = 'FAS';
                fieldelement(c1; "Fixed Asset"."No.")
                {
                }
                fieldelement(c2; "Fixed Asset".Description)
                {
                }
                fieldelement(c3; "Fixed Asset"."Search Description")
                {
                }
                fieldelement(c4; "Fixed Asset"."Description 2")
                {
                }
                fieldelement(c5; "Fixed Asset"."FA Class Code")
                {
                }
                fieldelement(c6; "Fixed Asset"."FA Subclass Code")
                {
                }
                fieldelement(c8; "Fixed Asset"."Global Dimension 1 Code")
                {
                }
                fieldelement(c9; "Fixed Asset"."Global Dimension 2 Code")
                {
                }
                fieldelement(c10; "Fixed Asset"."Location Code")
                {
                }
                fieldelement(c11; "Fixed Asset"."FA Location Code")
                {
                }
                fieldelement(c12; "Fixed Asset"."Vendor No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c13; "Fixed Asset"."Main Asset/Component")
                {
                    FieldValidate = No;
                }
                fieldelement(c14; "Fixed Asset"."Component of Main Asset")
                {
                    FieldValidate = No;
                }
                fieldelement(c15; "Fixed Asset"."Budgeted Asset")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c16; "Fixed Asset"."Warranty Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c17; "Fixed Asset"."Responsible Employee")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c18; "Fixed Asset"."Serial No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c19; "Fixed Asset"."Last Date Modified")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c20; "Fixed Asset".Blocked)
                {
                    FieldValidate = No;
                }
                fieldelement(c21; "Fixed Asset"."Maintenance Vendor No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c22; "Fixed Asset"."Under Maintenance")
                {
                    FieldValidate = No;
                }
                fieldelement(c23; "Fixed Asset"."Next Service Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c24; "Fixed Asset".Inactive)
                {
                    FieldValidate = No;
                }
                fieldelement(c25; "Fixed Asset"."No. Series")
                {
                    FieldValidate = No;
                }
                fieldelement(c26; "Fixed Asset"."FA Posting Group")
                {
                    FieldValidate = No;
                }
                fieldelement(c27; "Fixed Asset"."Operating Lease Acq. Cost")
                {
                    FieldValidate = No;
                }
                fieldelement(c28; "Fixed Asset"."Machine Center Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
            }
            tableelement("FA Depreciation Book"; "FA Depreciation Book")
            {
                AutoReplace = true;
                LinkTableForceInsert = false;
                XmlName = 'FADB';
                fieldelement(c1; "FA Depreciation Book"."FA No.")
                {
                    FieldValidate = No;
                }
                fieldelement(c2; "FA Depreciation Book"."Depreciation Book Code")
                {
                    AutoCalcField = false;
                    FieldValidate = No;
                }
                fieldelement(c3; "FA Depreciation Book"."Depreciation Method")
                {
                    FieldValidate = No;
                }
                fieldelement(c4; "FA Depreciation Book"."Depreciation Starting Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c5; "FA Depreciation Book"."Straight-Line %")
                {
                    FieldValidate = No;
                }
                fieldelement(c6; "FA Depreciation Book"."No. of Depreciation Years")
                {
                    FieldValidate = No;
                }
                fieldelement(c8; "FA Depreciation Book"."No. of Depreciation Months")
                {
                    FieldValidate = No;
                }
                fieldelement(c9; "FA Depreciation Book"."Fixed Depr. Amount")
                {
                    FieldValidate = No;
                }
                fieldelement(c10; "FA Depreciation Book"."Declining-Balance %")
                {
                    FieldValidate = No;
                }
                fieldelement(c11; "FA Depreciation Book"."Depreciation Table Code")
                {
                    FieldValidate = No;
                }
                fieldelement(c12; "FA Depreciation Book"."Final Rounding Amount")
                {
                    FieldValidate = No;
                }
                fieldelement(c13; "FA Depreciation Book"."Final Rounding Amount")
                {
                    FieldValidate = No;
                }
                fieldelement(c14; "FA Depreciation Book"."Ending Book Value")
                {
                    FieldValidate = No;
                }
                fieldelement(c15; "FA Depreciation Book"."FA Posting Group")
                {
                    FieldValidate = No;
                }
                fieldelement(c16; "FA Depreciation Book"."Depreciation Ending Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c17; "FA Depreciation Book"."Acquisition Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c18; "FA Depreciation Book"."G/L Acquisition Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c19; "FA Depreciation Book"."Disposal Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c20; "FA Depreciation Book"."Last Acquisition Cost Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c21; "FA Depreciation Book"."Last Depreciation Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c22; "FA Depreciation Book"."Last Write-Down Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c23; "FA Depreciation Book"."Last Appreciation Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c24; "FA Depreciation Book"."Last Custom 1 Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c25; "FA Depreciation Book"."Last Custom 2 Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c26; "FA Depreciation Book"."Last Salvage Value Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c27; "FA Depreciation Book"."FA Exchange Rate")
                {
                    FieldValidate = No;
                }
                fieldelement(c28; "FA Depreciation Book"."Fixed Depr. Amount below Zero")
                {
                }
                fieldelement(c29; "FA Depreciation Book"."Last Date Modified")
                {
                }
                fieldelement(c30; "FA Depreciation Book"."First User-Defined Depr. Date")
                {
                    FieldValidate = No;
                }
                fieldelement(c31; "FA Depreciation Book"."Use FA Ledger Check")
                {
                }
                fieldelement(c32; "FA Depreciation Book"."Last Maintenance Date")
                {
                }
                fieldelement(c33; "FA Depreciation Book"."Depr. below Zero %")
                {
                }
                fieldelement(c34; "FA Depreciation Book"."Projected Disposal Date")
                {
                }
                fieldelement(c35; "FA Depreciation Book"."Projected Proceeds on Disposal")
                {
                }
                fieldelement(c36; "FA Depreciation Book"."Depr. Starting Date (Custom 1)")
                {
                }
                fieldelement(c37; "FA Depreciation Book"."Depr. Ending Date (Custom 1)")
                {
                }
                fieldelement(c38; "FA Depreciation Book"."Accum. Depr. % (Custom 1)")
                {
                }
                fieldelement(c39; "FA Depreciation Book"."Depr. This Year % (Custom 1)")
                {
                }
                fieldelement(c40; "FA Depreciation Book"."Property Class (Custom 1)")
                {
                }
                fieldelement(c41; "FA Depreciation Book".Description)
                {
                    FieldValidate = No;
                }
                fieldelement(c42; "FA Depreciation Book"."Main Asset/Component")
                {
                    FieldValidate = No;
                }
                fieldelement(c43; "FA Depreciation Book"."Component of Main Asset")
                {
                }
                fieldelement(c44; "FA Depreciation Book"."FA Add.-Currency Factor")
                {
                }
                fieldelement(c45; "FA Depreciation Book"."Use Half-Year Convention")
                {
                }
                fieldelement(c46; "FA Depreciation Book"."Use DB% First Fiscal Year")
                {
                }
                fieldelement(c47; "FA Depreciation Book"."Temp. Ending Date")
                {
                }
                fieldelement(c48; "FA Depreciation Book"."Temp. Fixed Depr. Amount")
                {
                }
                fieldelement(c49; "FA Depreciation Book"."Ignore Def. Ending Book Value")
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

