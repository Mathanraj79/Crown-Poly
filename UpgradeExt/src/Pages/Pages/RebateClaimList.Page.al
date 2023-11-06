page 50081 "Rebate Claim List"
{
    Caption = 'Rebate Claim List';
    CardPageID = "Rebate Claim";
    Editable = false;
    PageType = List;
    SourceTable = "Rebate Claim";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Rebate Claim No."; Rec."Rebate Claim No.")
                {
                    Caption = 'Rebate Claim No.';
                    ToolTip = 'Specifies the value of the Rebate Claim No. field.';
                    ApplicationArea = all;
                }
                field("End User No."; Rec."End User No.")
                {
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Quantity Claimed"; Rec."Quantity Claimed")
                {
                    Caption = 'Quantity Claimed';
                    ToolTip = 'Specifies the value of the Quantity Claimed field.';
                    ApplicationArea = all;
                }
                field("Date Claimed"; Rec."Date Claimed")
                {
                    Caption = 'Date Claimed';
                    ToolTip = 'Specifies the value of the Date Claimed field.';
                    ApplicationArea = all;
                }
                field(Exported; Rec.Exported)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register Claims")
            {
                Caption = 'Register Claims';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Register Claims action.';
                ApplicationArea = all;
                trigger OnAction()
                var
                    RebateClaim: Record 50008;
                begin
                    Rec.FindRebateID();
                end;
            }
        }
    }
}

