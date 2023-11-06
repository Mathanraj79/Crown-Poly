page 50026 "Posted BOL Subform"
{
    Caption = 'Lines';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted BOL Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("NMFC Item No."; Rec."NMFC Item No.")
                {
                    Caption = 'NMFC Item No.';
                    ToolTip = 'Specifies the value of the NMFC Item No. field.';
                    ApplicationArea = all;
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = all;
                }
                field("Package Type"; Rec."Package Type")
                {
                    Caption = 'Package Type';
                    ToolTip = 'Specifies the value of the Package Type field.';
                    ApplicationArea = all;
                }
                field("Shipping Units (Qty.)"; Rec."Shipping Units (Qty.)")
                {
                    Caption = 'Shipping Units (Qty.)';
                    ToolTip = 'Specifies the value of the Shipping Units (Qty.) field.';
                    ApplicationArea = all;
                }
                field(Class; Rec.Class)
                {
                    Caption = 'Class';
                    ToolTip = 'Specifies the value of the Class field.';
                    ApplicationArea = all;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    ToolTip = 'Specifies the value of the Weight field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

