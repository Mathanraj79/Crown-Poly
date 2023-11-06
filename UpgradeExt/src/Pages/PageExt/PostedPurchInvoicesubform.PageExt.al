pageextension 50132 "Posted Purch. Invoice subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify("Unit Price (LCY)")
        {
            HideValue = true;
            Visible = false;
        }
        modify("Unit Cost (LCY)")
        {
            HideValue = true;
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
    }

    var
        PostedPurch: Codeunit "Posted Purch. Invoice Subform";

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        PostedPurch.CheckResin(Rec);
    end;
}
