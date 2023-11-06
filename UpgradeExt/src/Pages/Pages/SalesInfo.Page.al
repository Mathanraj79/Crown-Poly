page 50040 "Sales Info."
{
    Caption = 'Sales Info.';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Info.";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = all;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                    ToolTip = 'Specifies the value of the Document Line No. field.';
                    ApplicationArea = all;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    Caption = 'Invoice Date';
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                    ApplicationArea = all;
                }
                field("Sell-To Customer No."; Rec."Sell-To Customer No.")
                {
                    Caption = 'Sell-To Customer No.';
                    ToolTip = 'Specifies the value of the Sell-To Customer No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = all;
                }
                field(Reference; Rec.Reference)
                {
                    Caption = 'Reference';
                    ToolTip = 'Specifies the value of the Reference field.';
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

