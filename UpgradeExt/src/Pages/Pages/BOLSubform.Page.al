page 50023 "BOL Subform"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "BOL Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("NMFC Item No."; Rec."NMFC Item No.")
                {
                    Caption = 'NMFC Item No.';
                    ToolTip = 'Specifies the value of the NMFC Item No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    DrillDownPageID = "NMFC Item List";
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Package Type"; Rec."Package Type")
                {
                    Caption = 'Package Type';
                    ToolTip = 'Specifies the value of the Package Type field.';
                    ApplicationArea = All;
                }
                field("Shipping Units (Qty.)"; Rec."Shipping Units (Qty.)")
                {
                    Caption = 'Shipping Units (Qty.)';
                    ToolTip = 'Specifies the value of the Shipping Units (Qty.) field.';
                    ApplicationArea = All;
                }
                field(Class; Rec.Class)
                {
                    Caption = 'Class';
                    ToolTip = 'Specifies the value of the Class field.';
                    ApplicationArea = All;
                }
                field("No. Of Pallets Per Line"; Rec."No. Of Pallets Per Line")
                {
                    Caption = 'No. Of Pallets Per Line';
                    ToolTip = 'Specifies the value of the No. Of Pallets Per Line field.';
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

