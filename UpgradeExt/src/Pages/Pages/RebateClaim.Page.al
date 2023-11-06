page 50027 "Rebate Claim"
{
    Caption = 'Rebate Claim';
    PageType = Card;
    SourceTable = "Rebate Claim";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("End User No."; Rec."End User No.")
                {
                    Editable = "End User No.Editable";
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = "Item No.Editable";
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Quantity Claimed"; Rec."Quantity Claimed")
                {
                    Editable = "Quantity ClaimedEditable";
                    Caption = 'Quantity Claimed';
                    ToolTip = 'Specifies the value of the Quantity Claimed field.';
                    ApplicationArea = all;
                }
                field("Date Claimed"; Rec."Date Claimed")
                {
                    Editable = "Date ClaimedEditable";
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
            action("Register Claim")
            {
                Caption = 'Register Claim';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Register Claim action.';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.FindRebateID();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Exported THEN BEGIN
            "End User No.Editable" := FALSE;
            "Item No.Editable" := FALSE;
            "Quantity ClaimedEditable" := FALSE;
            "Date ClaimedEditable" := FALSE;
        END ELSE BEGIN
            "End User No.Editable" := TRUE;
            "Item No.Editable" := TRUE;
            "Quantity ClaimedEditable" := TRUE;
            "Date ClaimedEditable" := TRUE;
        END;
    end;

    trigger OnInit()
    begin
        "Date ClaimedEditable" := TRUE;
        "Quantity ClaimedEditable" := TRUE;
        "Item No.Editable" := TRUE;
        "End User No.Editable" := TRUE;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF Rec.Exported THEN BEGIN
            "End User No.Editable" := FALSE;
            "Item No.Editable" := FALSE;
            "Quantity ClaimedEditable" := FALSE;
            "Date ClaimedEditable" := FALSE;
        END ELSE BEGIN
            "End User No.Editable" := TRUE;
            "Item No.Editable" := TRUE;
            "Quantity ClaimedEditable" := TRUE;
            "Date ClaimedEditable" := TRUE;
        END;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Exported THEN BEGIN
            "End User No.Editable" := FALSE;
            "Item No.Editable" := FALSE;
            "Quantity ClaimedEditable" := FALSE;
            "Date ClaimedEditable" := FALSE;
        END ELSE BEGIN
            "End User No.Editable" := TRUE;
            "Item No.Editable" := TRUE;
            "Quantity ClaimedEditable" := TRUE;
            "Date ClaimedEditable" := TRUE;
        END;
    end;

    var
        "End User No.Editable": Boolean;
        "Item No.Editable": Boolean;
        "Quantity ClaimedEditable": Boolean;
        "Date ClaimedEditable": Boolean;
}

