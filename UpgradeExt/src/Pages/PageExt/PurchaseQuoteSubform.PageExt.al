pageextension 50123 "Purchase Quote Subform " extends "Purchase Quote Subform"
{
    layout
    {
        modify("Line Amount")
        {
            Caption = 'Resin Line Amount';
            Editable = ResinEditable;
        }
        modify("Unit Cost (LCY)")
        {
            Caption = 'Resin Unit Cost';
            Visible = false;
        }
        modify("Direct Unit Cost")
        {
            Editable = ResinEditable;
            Caption = 'Resin Direct Unit Cost';

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                PurchaseSubform.DirectUnitCost(rec);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                PurchaseSubform.Quantity(Rec);
            end;
        }

    }
    actions
    {
        modify("Insert &Ext. Texts")
        {
            Caption = 'Insert &Ext. Text';
        }
    }

    var
        PurchaseSubform: Codeunit "Purchase Quote Subform";
        ResinEditable: Boolean;

    trigger OnAfterGetRecord()

    begin
        PurchaseSubform.CheckResin(Rec);
    end;
}
