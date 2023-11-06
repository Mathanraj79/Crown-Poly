pageextension 50133 "Posted Purch. Cr. Memo Subform" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        modify("Unit Cost (LCY)")
        {
            Caption = 'Unit Cost';

        }
        modify("Unit Price (LCY)")
        {
            Caption = 'Unit Price';
        }
    }

    var
        PostedPurch: Codeunit "Post Purchase Cr. memo";

    trigger OnAfterGetRecord()

    begin
        PostedPurch.CheckResin(Rec);
    end;
}
