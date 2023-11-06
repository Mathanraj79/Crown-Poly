page 50077 "Rebate Program Details"
{
    Caption = 'Rebate Program Details';
    PageType = ListPart;
    SourceTable = "Rebate Program Details";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("Rebate Amount"; Rec."Rebate Amount")
                {
                    Caption = 'Rebate Amount';
                    ToolTip = 'Specifies the value of the Rebate Amount field.';
                    ApplicationArea = all;
                }
                field("Rebate Type"; Rec."Rebate Type")
                {
                    Caption = 'Rebate Type';
                    ToolTip = 'Specifies the value of the Rebate Type field.';
                    ApplicationArea = all;
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Comments';
                    ToolTip = 'Specifies the value of the Comments field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

