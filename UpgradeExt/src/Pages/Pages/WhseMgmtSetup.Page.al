page 50019 "Whse. Mgmt Setup"
{
    // SSC56 - new object

    Caption = 'Warehouse Management Setup';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Whse. Mgmt Setup";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = all;
                }
                field(SubType; Rec.SubType)
                {
                    Caption = 'SubType';
                    ToolTip = 'Specifies the value of the SubType field.';
                    ApplicationArea = all;
                }
                field("Default Location Code"; Rec."Default Location Code")
                {
                    Caption = 'Default Location Code';
                    ToolTip = 'Specifies the value of the Default Location Code field.';
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

