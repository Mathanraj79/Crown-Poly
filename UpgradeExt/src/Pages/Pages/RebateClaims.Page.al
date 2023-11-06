page 50009 "Rebate Claims"
{
    Caption = 'Rebate Claims';
    CardPageID = "Rebate Claim";
    PageType = List;
    SourceTable = "Rebate Claim";
    SourceTableView = SORTING(Exported);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    Editable = false;
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
                    RebateClaim: Record "Rebate Claim";
                begin
                    Rec.FindRebateID();
                end;
            }
        }
    }
}

