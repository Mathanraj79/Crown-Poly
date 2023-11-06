page 50030 "Rebate Ledger Entries"
{
    Caption = 'Rebate Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Rebate Ledger Entries";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Date Claimed"; Rec."Date Claimed")
                {
                    Caption = 'Date Claimed';
                    ToolTip = 'Specifies the value of the Date Claimed field.';
                    ApplicationArea = all;
                }
                field("Rebate Claim No."; Rec."Rebate Claim No.")
                {
                    Caption = 'Rebate Claim No.';
                    ToolTip = 'Specifies the value of the Rebate Claim No. field.';
                    ApplicationArea = all;
                }
                field("Rebate No."; Rec."Rebate No.")
                {
                    Caption = 'Rebate No.';
                    ToolTip = 'Specifies the value of the Rebate No. field.';
                    ApplicationArea = all;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    Caption = 'Customer Type';
                    ToolTip = 'Specifies the value of the Customer Type field.';
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                field("End User Cust No."; Rec."End User Cust No.")
                {
                    Caption = 'End User Cust No.';
                    ToolTip = 'Specifies the value of the End User Cust No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Rebate Type"; Rec."Rebate Type")
                {
                    Caption = 'Rebate Type';
                    ToolTip = 'Specifies the value of the Rebate Type field.';
                    ApplicationArea = all;
                }
                field("Rebate Method"; Rec."Rebate Method")
                {
                    Caption = 'Rebate Method';
                    ToolTip = 'Specifies the value of the Rebate Method field.';
                    ApplicationArea = all;
                }
                field("Quantity Claimed"; Rec."Quantity Claimed")
                {
                    Caption = 'Quantity Claimed';
                    ToolTip = 'Specifies the value of the Quantity Claimed field.';
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                    ApplicationArea = all;
                }
                field("Rebate Amount"; Rec."Rebate Amount")
                {
                    Caption = 'Rebate Amount';
                    ToolTip = 'Specifies the value of the Rebate Amount field.';
                    ApplicationArea = all;
                }
                field("Instant Credits"; Rec."Instant Credits")
                {
                    Caption = 'Instant Credits';
                    ToolTip = 'Specifies the value of the Instant Credits field.';
                    ApplicationArea = all;
                }
                field(Exported; Rec.Exported)
                {
                    Caption = 'Processed';
                    ToolTip = 'Specifies the value of the Processed field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

