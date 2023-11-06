page 50075 "Rebate Program"
{
    Caption = 'Rebate Program';
    PageType = List;
    SourceTable = "Rebate Program Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Rebate No."; Rec."Rebate No.")
                {
                    Caption = 'Rebate No.';
                    ToolTip = 'Specifies the value of the Rebate No. field.';
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
            }
        }
    }

    actions
    {
    }
}

