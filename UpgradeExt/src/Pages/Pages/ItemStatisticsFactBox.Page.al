page 50050 "Item Statistics FactBox"
{
    Caption = 'Item Statistics FactBox';
    PageType = CardPart;
    SourceTable = Item;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Item No.';
                ToolTip = 'Specifies the value of the Item No. field.';
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field(Inventory; Rec.Inventory)
            {
                Caption = 'Inventory';
                ToolTip = 'Specifies the value of the Inventory field.';
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                Caption = 'Qty. on Purch. Order';
                ToolTip = 'Specifies the value of the Qty. on Purch. Order field.';
                ApplicationArea = All;
            }
            field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                Caption = 'Qty. on Prod. Order';
                ToolTip = 'Specifies the value of the Qty. on Prod. Order field.';
                ApplicationArea = All;
            }
            field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                Caption = 'Qty. on Component Lines';
                ToolTip = 'Specifies the value of the Qty. on Component Lines field.';
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                Caption = 'Qty. on Sales Order';
                ToolTip = 'Specifies the value of the Qty. on Sales Order field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
    procedure ShowDetails()
    begin
        PAGE.RUN(PAGE::"Item Card", Rec);
    end;
}

