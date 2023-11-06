report 50003 "Bill of Lading"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src\Report\Layout\BillofLading.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Bill of Lading';
    dataset
    {
        dataitem("BOL Header"; "BOL Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(BOL_Header_No_; "No.")
            {
            }
            column(BOL_Header_BOL_Date_; "BOL Header"."BOL Date")
            {
            }
            column(BOL_Header_SCAC; "BOL Header".SCAC)
            {
            }
            column(BOL_Header_PU_Date_; "BOL Header"."PU Date")
            {
            }
            column(SO_SONo; 'SO#' + SONo)
            {
            }
            column(Notes_BOL_Header__Notes; 'Notes: ' + "BOL Header".Notes)
            {
            }
            column(CompanyAddress_1_; CompanyAddress[1])
            {
            }
            column(CompanyAddress_2_; CompanyAddress[2])
            {
            }
            column(CompanyAddress_3_; CompanyAddress[3])
            {
            }
            column(CompanyAddress_4_; CompanyAddress[4])
            {
            }
            column(CompanyAddress_5_; CompanyAddress[5])
            {
            }
            column(ShiptoAddress_5_; ShiptoAddress[5])
            {
            }
            column(ShiptoAddress_4_; ShiptoAddress[4])
            {
            }
            column(ShiptoAddress_2_; ShiptoAddress[2])
            {
            }
            column(ShiptoAddress_3_; ShiptoAddress[3])
            {
            }
            column(ShiptoAddress_1_; ShiptoAddress[1])
            {
            }
            column(BOL_Header_Ship_to_Contact_; "BOL Header"."Ship-to Contact")
            {
            }
            column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
            {
            }
            column(CompanyInformation__Ship_to_Contact_; CompanyInformation."Ship-to Contact")
            {
            }
            column(Cust__Phone_No__; Cust."Phone No.")
            {
            }
            column(BOL_Header_Total_No__of_Units_; "BOL Header"."Total No. of Units")
            {
            }
            column(POList; POList)
            {
            }
            column(BOL_Header_Weight; "BOL Header".Weight)
            {
            }
            column(BOL_Header_No__of_Units_; "BOL Header"."No. of Units")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(BOL_Header_Payment_Method_; "BOL Header"."Payment Method")
            {
            }
            column(No__UnitsCaption; No__UnitsCaptionLbl)
            {
            }
            column(Purchase_Order_NumberCaption; Purchase_Order_NumberCaptionLbl)
            {
            }
            column(Purchase_Order_WeightCaption; Purchase_Order_WeightCaptionLbl)
            {
            }
            column(Sub_TotalsCaption; Sub_TotalsCaptionLbl)
            {
            }
            column(Line_TotalsCaption; Line_TotalsCaptionLbl)
            {
            }
            column(Total_UnitsCaption; Total_UnitsCaptionLbl)
            {
            }
            dataitem("BOL Lines"; "BOL Lines")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending);
                column(BOL_Lines_Description; Description)
                {
                }
                column(BOL_Lines_Item_No_; "BOL Lines"."Item No.")
                {
                }
                column(BOL_Lines_NMFC_Item_No_; "BOL Lines"."NMFC Item No.")
                {
                }
                column(BOL_Lines_Class; "BOL Lines".Class)
                {
                }
                column(BOL_Lines_Weight; "BOL Lines".Weight)
                {
                }
                column(PLT_; 'PLT')
                {
                }
                column(BOL_Lines_No__Of_Pallets_Per_Line_; "BOL Lines"."No. Of Pallets Per Line")
                {
                }
                column(ContainerDesc; ContainerDesc)
                {
                }
                column(BOL_Lines_No_; "No.")
                {
                }
                column(BOL_Lines_Line_No_; "Line No.")
                {
                }
                column(PrintNotes; PrintNotes)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    recItem.RESET();
                    IF recItem.GET("No.") THEN;
                    LineNumber += 1;
                    IF LineCount = LineNumber THEN
                        PrintNotes := TRUE;

                    ContainerDesc := 'CONTAINING ' + FORMAT("BOL Lines"."Shipping Units (Qty.)") + ' ' + FORMAT("BOL Lines"."Package Type");
                end;

                trigger OnPreDataItem()
                begin
                    LineCount := COUNT;
                    LineNumber := 0;
                    PrintNotes := FALSE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                POList := '';
                CompanyInformation.GET();
                FormatAddress.FormatAddr(CompanyAddress, "BOL Header"."Shipper Name", '', '', "BOL Header"."Shipper Address",
                  "BOL Header"."Shipper Address 2", "BOL Header"."Shipper City", "BOL Header"."Shipper Post Code",
                  "BOL Header"."Shipper State", "BOL Header"."Shipper Country");
                FormatAddress.FormatAddr(ShiptoAddress, "BOL Header"."Ship-to Name", '', '', "BOL Header"."Ship-to Address",
                  "BOL Header"."Ship-to Address 2", "BOL Header"."Ship-to City", "BOL Header"."Ship-to Post Code",
                  "BOL Header"."Ship-to State", "BOL Header"."Ship-to Country");

                IF Cust.GET("BOL Header"."Customer No.") THEN;
                IF ShiptoInstructions.GET("BOL Header"."Customer No.", "BOL Header"."Ship-to Code") THEN;

                recBOLLine.RESET();
                recBOLLine.SETRANGE("No.", "BOL Header"."No.");
                IF recBOLLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF recSH.GET(recSH."Document Type"::Order, recBOLLine."Order No.") THEN
                            POList += recSH."External Document No." + '/';
                    UNTIL recBOLLine.NEXT() = 0;
                    IF STRLEN(POList) > 1 THEN
                        POList := COPYSTR(POList, 1, STRLEN(POList) - 1);
                END;


                SONo := '';
                BOLLines.SETRANGE("No.", "BOL Header"."No.");
                IF BOLLines.FIND('-') THEN
                    SONo := BOLLines."Order No.";

                "BOL Header".CALCFIELDS("Total No. of Units");
                "BOL Header".CALCFIELDS("No. of Units");
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("BOL Lines"."Shipping Units (Qty.)");
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

    var
        CompanyInformation: Record "Company Information";
        Cust: Record Customer;
        recItem: Record Item;
        ShiptoInstructions: Record "Ship-to Address";
        recBOLLine: Record "BOL Lines";
        recSH: Record "Sales Header";
        BOLLines: Record "BOL Lines";
        FormatAddress: Codeunit "Format Address";
        //NoSeries: Codeunit NoSeriesManagement;
        PrintNotes: Boolean;
        LineCount: Integer;
        LineNumber: Integer;
        SONo: Code[20];
        ContainerDesc: Text[80];
        No__UnitsCaptionLbl: Label 'No. Units';
        Purchase_Order_NumberCaptionLbl: Label 'Purchase Order Number';
        Purchase_Order_WeightCaptionLbl: Label 'Purchase Order Weight';
        Sub_TotalsCaptionLbl: Label 'Sub-Totals';
        Line_TotalsCaptionLbl: Label 'Line Totals';
        Total_UnitsCaptionLbl: Label 'Total Units';
        ShiptoAddress: array[8] of Text[50];
        CompanyAddress: array[8] of Text[50];
        POList: Text;
}

