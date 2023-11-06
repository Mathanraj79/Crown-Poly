page 50013 "Film Colors List"
{
    Caption = 'Film Colors List';
    PageType = List;
    SourceTable = "Film Colors";
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field(Description; rec.Description)
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

