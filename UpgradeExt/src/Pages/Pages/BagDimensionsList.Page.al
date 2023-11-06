page 50011 "Bag Dimensions List"
{
    Caption = 'Bag Dimensions List';
    PageType = List;
    SourceTable = "Bag Dimensions";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

