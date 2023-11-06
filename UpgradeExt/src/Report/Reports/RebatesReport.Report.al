report 50049 "Rebates Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\RebatesReport.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Rebates Report';
    dataset
    {
        dataitem("Rebate Program Header"; "Rebate Program Header")
        {
            column(Rebate_Program___End_User__Rebate_No__Caption; "Rebate Program - End User".FIELDCAPTION("Rebate No."))
            {
            }
            column(Rebate_Program___End_User__End_User_No__Caption; "Rebate Program - End User".FIELDCAPTION("End User No."))
            {
            }
            column(Starting_DateCaption; Starting_DateCaptionLbl)
            {
            }
            column(End_DateCaption; End_DateCaptionLbl)
            {
            }
            column(Rebate_TypeCaption; Rebate_TypeCaptionLbl)
            {
            }
            column(Rebate_Program___End_User__Customer_No__Caption; "Rebate Program - End User".FIELDCAPTION("Customer No."))
            {
            }
            column(Rebate_Program_Header_Rebate_No_; "Rebate No.")
            {
            }
            dataitem("Rebate Program - End User"; "Rebate Program - End User")
            {
                DataItemLink = "Rebate No." = FIELD("Rebate No.");
                column(Rebate_Program___End_User__Rebate_No__; "Rebate No.")
                {
                }
                column(Rebate_Program___End_User__End_User_No__; "End User No.")
                {
                }
                column(Rebate_Program_Header___Start_Date_; "Rebate Program Header"."Start Date")
                {
                }
                column(Rebate_Program_Header___End_Date_; "Rebate Program Header"."End Date")
                {
                }
                column(Rebate_Program_Header___Rebate_Type_; "Rebate Program Header"."Rebate Type")
                {
                }
                column(Rebate_Program___End_User__Customer_No__; "Customer No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Customer No.");
                end;
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

    labels
    {
    }

    var
        Starting_DateCaptionLbl: Label 'Starting Date';
        End_DateCaptionLbl: Label 'End Date';
        Rebate_TypeCaptionLbl: Label 'Rebate Type';
}

