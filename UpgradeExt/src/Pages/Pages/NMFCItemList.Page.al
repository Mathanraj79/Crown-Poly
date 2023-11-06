page 50001 "NMFC Item List"
{
    Caption = 'NMFC Item List';
    PageType = List;
    SourceTable = "NMFC Items";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("NMFC Item No."; Rec."NMFC Item No.")
                {
                    Caption = 'NMFC Item No.';
                    ToolTip = 'Specifies the value of the NMFC Item No. field.';
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = all;
                }
                field(Class; Rec.Class)
                {
                    Caption = 'Class';
                    ToolTip = 'Specifies the value of the Class field.';
                    ApplicationArea = all;
                }
                field("Package Type"; Rec."Package Type")
                {
                    Caption = 'Package Type';
                    ToolTip = 'Specifies the value of the Package Type field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

