page 50084 "Input Dialogbox"
{
    Caption = 'Enter Quantity';
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(Quantity; Quantity)
            {
                Caption = 'Quantity';
                ColumnSpan = 2;
                ToolTip = 'Specifies the value of the Quantity field.';
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    SetQuantity(Quantity);
                end;
            }
        }
    }

    actions
    {
    }

    var
        Quantity: Decimal;


    procedure SetQuantity(Qty: Decimal)
    begin
        Quantity := Qty;
    end;


    procedure GetQuantity(): Decimal
    begin
        EXIT(Quantity);
    end;
}

