page 50007 "Rebates Screen"
{
    Caption = 'Rebates Screen';
    PageType = List;
    SourceTable = "Rebate Screen";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = all;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = all;
                }
                field("Instant Credit"; Rec."Instant Credit")
                {
                    Caption = 'Instant Credit';
                    ToolTip = 'Specifies the value of the Instant Credit field.';
                    ApplicationArea = all;
                }
                field("Proof of Delivery Rebate"; Rec."Proof of Delivery Rebate")
                {
                    Caption = 'Proof of Delivery Rebate';
                    ToolTip = 'Specifies the value of the Proof of Delivery Rebate field.';
                    ApplicationArea = all;
                }
                field("Quarterly Rebate"; Rec."Quarterly Rebate")
                {
                    Caption = 'Quarterly Rebate';
                    ToolTip = 'Specifies the value of the Quarterly Rebate field.';
                    ApplicationArea = all;
                }
                field("Quarterly Rebate %"; Rec."Quarterly Rebate %")
                {
                    Caption = 'Quarterly Rebate %';
                    ToolTip = 'Specifies the value of the Quarterly Rebate % field.';
                    ApplicationArea = all;
                }
                field("Annual Rebate"; Rec."Annual Rebate")
                {
                    Caption = 'Annual Rebate';
                    ToolTip = 'Specifies the value of the Annual Rebate field.';
                    ApplicationArea = all;
                }
                field("Annual Rebate %"; Rec."Annual Rebate %")
                {
                    Caption = 'Annual Rebate %';
                    ToolTip = 'Specifies the value of the Annual Rebate % field.';
                    ApplicationArea = all;
                }
                field("End User Annual Rebate"; Rec."End User Annual Rebate")
                {
                    Caption = 'End User Annual Rebate';
                    ToolTip = 'Specifies the value of the End User Annual Rebate field.';
                    ApplicationArea = all;
                }
                field("End User Annual Rebate %"; Rec."End User Annual Rebate %")
                {
                    Caption = 'End User Annual Rebate %';
                    ToolTip = 'Specifies the value of the End User Annual Rebate % field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

