pageextension 50120 "Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        modify("Unit Cost (LCY)")
        {
            Caption = 'Resin unit Cost';
            Editable = ResinEditable;
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
            Editable = ResinEditable;
            Caption = 'Resin Unit Price';
        }

    }
    actions
    {
        modify(InsertExtTexts)
        {
            Caption = 'Insert &Ext. Text';
        }
    }

    var
        ResinEditable: Boolean;
        SalesLine: Codeunit "Sales Quote SubForm";

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ResinEditable := SalesLine.CheckResin(Rec);
    end;
}
