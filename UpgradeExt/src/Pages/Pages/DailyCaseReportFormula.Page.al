page 50086 "Daily Case Report Formula"
{
    PageType = List;
    SourceTable = "Daily Case Report Formula";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("PNP Daily Field ID"; Rec."PNP Daily Field ID")
                {
                    Editable = false;
                    Caption = 'PNP Daily Field ID';
                    ToolTip = 'Specifies the value of the PNP Daily Field ID field.';
                    ApplicationArea = All;
                }
                field("PNP Daily Field Name"; Rec."PNP Daily Field Name")
                {
                    Caption = 'PNP Daily Field Name';
                    ToolTip = 'Specifies the value of the PNP Daily Field Name field.';
                    ApplicationArea = All;
                }
                field("Item Routing"; Rec."Item Routing")
                {
                    Caption = 'Item Routing';
                    ToolTip = 'Specifies the value of the Item Routing field.';
                    ApplicationArea = All;
                }
                field("Customer No. Filter"; Rec."Customer No. Filter")
                {
                    Caption = 'Customer No. Filter';
                    ToolTip = 'Specifies the value of the Customer No. Filter field.';
                    ApplicationArea = All;
                }
                field("Item No. Filter"; Rec."Item No. Filter")
                {
                    Caption = 'Item No. Filter';
                    ToolTip = 'Specifies the value of the Item No. Filter field.';
                    ApplicationArea = All;
                }
                field("Item Type Filter"; Rec."Item Type Filter")
                {
                    Caption = 'Item Type Filter';
                    ToolTip = 'Specifies the value of the Item Type Filter field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    Caption = 'Global Dimension 1 Filter';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Filter field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    Caption = 'Global Dimension 2 Filter';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Filter field.';
                    ApplicationArea = All;
                }
                field("1000 bag count"; Rec."1000 bag count")
                {
                    Caption = '1000 bag count';
                    ToolTip = 'Specifies the value of the 1000 bag count field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

