page 50017 "Item Storage Bins"
{
    // SSC56 - new object

    Caption = 'Item Storage Bins';
    DataCaptionExpression = Rec.GetCaption();
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Item Storage Bin";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    Caption = 'Variant Code';
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                    ToolTip = 'Specifies the value of the Zone Code field.';
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                    ToolTip = 'Specifies the value of the Bin Code field.';
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    Caption = 'Default';
                    ToolTip = 'Specifies the value of the Default field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    ApplicationArea = All;
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

