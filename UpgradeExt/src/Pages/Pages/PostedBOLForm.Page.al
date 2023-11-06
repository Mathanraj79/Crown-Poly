page 50025 "Posted BOL Form"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Posted BOL Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                group(Shipper1)
                {
                    Caption = 'Shipper';
                    field("Customer No."; Rec."Customer No.")
                    {
                        Editable = false;
                        Caption = 'Customer No.';
                        ToolTip = 'Specifies the value of the Customer No. field.';
                        ApplicationArea = all;
                    }
                    field("Customer Name"; Rec."Customer Name")
                    {
                        Editable = false;
                        Caption = 'Customer Name';
                        ToolTip = 'Specifies the value of the Customer Name field.';
                        ApplicationArea = all;
                    }
                }
                field("No. of Units"; Rec."No. of Units")
                {
                    Caption = 'No. of Units';
                    ToolTip = 'Specifies the value of the No. of Units field.';
                    ApplicationArea = all;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = all;
                }
                field(SCAC; Rec.SCAC)
                {
                    Caption = 'SCAC';
                    ToolTip = 'Specifies the value of the SCAC field.';
                    ApplicationArea = all;
                }
                group("ShipTo")
                {
                    Caption = 'Ship To';
                    field("Ship-to Code"; Rec."Ship-to Code")
                    {
                        Caption = 'Ship-to Code';
                        ToolTip = 'Specifies the value of the Ship-to Code field.';
                        ApplicationArea = all;
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        Caption = 'Ship-to Name';
                        ToolTip = 'Specifies the value of the Ship-to Name field.';
                        ApplicationArea = all;
                    }
                }
                field("BOL Date"; Rec."BOL Date")
                {
                    Caption = 'BOL Date';
                    ToolTip = 'Specifies the value of the BOL Date field.';
                    ApplicationArea = all;
                }
                field("PU Date"; Rec."PU Date")
                {
                    Caption = 'PU Date';
                    ToolTip = 'Specifies the value of the PU Date field.';
                    ApplicationArea = all;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                    ToolTip = 'Specifies the value of the Payment Method field.';
                    ApplicationArea = all;
                }
            }
            part("Posted BOL Subform"; "Posted BOL Subform")
            {
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "Line No.");
            }
            group(Shipper)
            {
                Caption = 'Shipper';
                field("Shipper Name"; Rec."Shipper Name")
                {
                    Caption = 'Shipper Name';
                    ToolTip = 'Specifies the value of the Shipper Name field.';
                    ApplicationArea = all;
                }
                field("Shipper Address"; Rec."Shipper Address")
                {
                    Caption = 'Shipper Address';
                    ToolTip = 'Specifies the value of the Shipper Address field.';
                    ApplicationArea = all;
                }
                field("Shipper Address 2"; Rec."Shipper Address 2")
                {
                    Caption = 'Shipper Address 2';
                    ToolTip = 'Specifies the value of the Shipper Address 2 field.';
                    ApplicationArea = all;
                }
                field("Shipper City"; Rec."Shipper City")
                {
                    Caption = 'Shipper City';
                    ToolTip = 'Specifies the value of the Shipper City field.';
                    ApplicationArea = all;
                }
                field("Shipper State"; Rec."Shipper State")
                {
                    Caption = 'Shipper State';
                    ToolTip = 'Specifies the value of the Shipper State field.';
                    ApplicationArea = all;
                }
                field("Shipper Country"; Rec."Shipper Country")
                {
                    Caption = 'Shipper Country';
                    ToolTip = 'Specifies the value of the Shipper Country field.';
                    ApplicationArea = all;
                }
                field("Shipper Phone No."; Rec."Shipper Phone No.")
                {
                    Caption = 'Shipper Phone No.';
                    ToolTip = 'Specifies the value of the Shipper Phone No. field.';
                    ApplicationArea = all;
                }
                field("Shipper Post Code"; Rec."Shipper Post Code")
                {
                    Caption = 'Shipper Post Code';
                    ToolTip = 'Specifies the value of the Shipper Post Code field.';
                    ApplicationArea = all;
                }
                field("Shipper Contact"; Rec."Shipper Contact")
                {
                    Caption = 'Shipper Contact';
                    ToolTip = 'Specifies the value of the Shipper Contact field.';
                    ApplicationArea = all;
                }
            }
            group("Ship To")
            {
                Caption = 'Ship To';
                field("Ship-to Code1"; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code';
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                    ApplicationArea = all;
                }
                field("Ship-to Name1"; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name';
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
                    ApplicationArea = all;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address';
                    ToolTip = 'Specifies the value of the Ship-to Address field.';
                    ApplicationArea = all;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2';
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                    ApplicationArea = all;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City';
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                    ApplicationArea = all;
                }
                field("Ship-to State"; Rec."Ship-to State")
                {
                    Caption = 'Ship-to State';
                    ToolTip = 'Specifies the value of the Ship-to State field.';
                    ApplicationArea = all;
                }
                field("Ship-to Country"; Rec."Ship-to Country")
                {
                    Caption = 'Ship-to Country';
                    ToolTip = 'Specifies the value of the Ship-to Country field.';
                    ApplicationArea = all;
                }
                field("Ship-to Phone No."; Rec."Ship-to Phone No.")
                {
                    Caption = 'Ship-to Phone No.';
                    ToolTip = 'Specifies the value of the Ship-to Phone No. field.';
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code';
                    ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact';
                    ToolTip = 'Specifies the value of the Ship-to Contact field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

