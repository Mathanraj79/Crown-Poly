report 50011 "Item - Palletized Weight"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\ItemPalletizedWeight.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Item - Palletized Weight';
    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(No_Item; "No.")
            {
            }
            column(Desc_Item; Description)
            {
            }
            column(PalletizedWeight_Item; "Palletized Weight")
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Palletized Weight" := CalcPalletizedWeight();
            end;
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
}

