page 50083 "Salesperson Commision Setup"
{
    Caption = 'Salesperson Commision Setup';
    PageType = List;
    SourceTable = "Sales Commision Setup";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code';
                    ToolTip = 'Specifies the value of the Salesperson Code field.';
                    ApplicationArea = all;
                }
                field(Broker; Rec.Broker)
                {
                    Caption = 'Broker';
                    ToolTip = 'Specifies the value of the Broker field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = all;
                }
                field("Commision %"; Rec."Commision %")
                {
                    Caption = 'Commision %';
                    ToolTip = 'Specifies the value of the Commision % field.';
                    ApplicationArea = all;
                }
                field("Commision Type"; Rec."Commision Type")
                {
                    Caption = 'Commision Type';
                    ToolTip = 'Specifies the value of the Commision Type field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

