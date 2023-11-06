page 50000 Pricing
{
    Caption = 'Pricing';
    PageType = List;
    SourceTable = Pricing;
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
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = all;
                }
                field("Min. Qty"; Rec."Min. Qty")
                {
                    Caption = 'Min. Qty';
                    ToolTip = 'Specifies the value of the Min. Qty field.';
                    ApplicationArea = all;
                }
                field("Ship Via"; Rec."Ship Via")
                {
                    Caption = 'Ship Via';
                    ToolTip = 'Specifies the value of the Ship Via field.';
                    ApplicationArea = all;
                }
                field("Combined Minimum Qty."; Rec."Combined Minimum Qty.")
                {
                    Caption = 'Combined Minimum Qty.';
                    ToolTip = 'Specifies the value of the Combined Minimum Qty. field.';
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Comment';
                    ToolTip = 'Specifies the value of the Comment field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

