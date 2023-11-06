page 50031 "Rebate Information"
{
    Caption = 'Rebate Information';
    Editable = false;
    PageType = List;
    SourceTable = "Rebate Information";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer Type"; Rec."Customer Type")
                {
                    Caption = 'Customer Type';
                    ToolTip = 'Specifies the value of the Customer Type field.';
                    ApplicationArea = all;
                }
                field("Date Claimed"; Rec."Date Claimed")
                {
                    Caption = 'Date Claimed';
                    ToolTip = 'Specifies the value of the Date Claimed field.';
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
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
                field("Quantity Claimed"; Rec."Quantity Claimed")
                {
                    Caption = 'Quantity Claimed';
                    ToolTip = 'Specifies the value of the Quantity Claimed field.';
                    ApplicationArea = all;
                }
                field("Instant Amount"; Rec."Instant Amount")
                {
                    Caption = 'Instant Amount';
                    ToolTip = 'Specifies the value of the Instant Amount field.';
                    ApplicationArea = all;
                }
                field("Monthly Amount"; Rec."Monthly Amount")
                {
                    Caption = 'Monthly Amount';
                    ToolTip = 'Specifies the value of the Monthly Amount field.';
                    ApplicationArea = all;
                }
                field("POD Amount"; Rec."POD Amount")
                {
                    Caption = 'POD Amount';
                    ToolTip = 'Specifies the value of the POD Amount field.';
                    ApplicationArea = all;
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                    Caption = 'Annual Amount';
                    ToolTip = 'Specifies the value of the Annual Amount field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

