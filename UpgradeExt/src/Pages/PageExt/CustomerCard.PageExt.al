pageextension 50101 "Customer Card" extends "Customer Card"
{
    //PromotedActionCategoriesML = 'New,Process,Reports';

    layout
    {
        modify("Name 2")
        {
            Visible = true;
        }

        modify("Credit Limit (LCY)")
        {
            Visible = true;
            Editable = CreditEditable;
        }
        modify(Blocked)
        {
            Editable = false;
        }
        addafter("Customer Disc. Group")
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Caption = 'Global Dimension 2 Code';
                ApplicationArea = all;
                //  Visible = true;
            }
        }



    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if UserSetup.Get(UserId) then
            //   if  UserSetup.
            CreditEditable := true;
    end;

    var
        CreditEditable: Boolean;
        UserSetup: Record "User Setup";
}
