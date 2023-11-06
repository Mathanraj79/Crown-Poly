page 50008 "End Users"
{
    Caption = 'End Users';
    PageType = List;
    SourceTable = "End User";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("End User No."; Rec."End User No.")
                {
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = All;
                }
                field("End User Table"; Rec."End User Table")
                {
                    Caption = 'End User Table';
                    ToolTip = 'Specifies the value of the End User Table field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select End User")
            {
                Caption = 'Select End User';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Select End User action.';
                Image = Select;
                ApplicationArea = All;
                trigger OnAction()
                var
                    EndUser: Record "End User";
                    RebateEnsUser: Record "Rebate Program - End User";
                begin
                    //SETRECFILTER;
                    EndUser.COPY(Rec);
                    Rec.RESET();
                    IF EndUser.FINDSET() THEN
                        REPEAT
                            RebateEnsUser."Rebate No." := rebateNo;
                            RebateEnsUser."End User No." := EndUser."End User No.";
                            RebateEnsUser.INSERT();
                        UNTIL EndUser.NEXT() = 0;
                end;
            }
        }
    }

    var
        rebateNo: Code[20];

    procedure SetrebateID(var rebateNoVar: Code[20])
    begin
        rebateNo := rebateNoVar;
    end;
}

