pageextension 50156 "Whse. Pick Subform" extends "Whse. Pick Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Suggested Serial No."; Rec."Suggested Serial No.")
            {
                ApplicationArea = all;
                Visible = false;
            }

        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Actual Serial No.',
                           ESM = 'N§ serie',
                           FRC = 'Nø de s,rie',
                           ENC = 'Serial No.';
        }
        addafter("Serial No. Blocked")
        {
            field("Suggested Lot No."; Rec."Suggested Lot No.")
            {
                ApplicationArea = all;
                Visible = true;
            }

        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Actual Lot No.',
                           ESM = 'N§ lote',
                           FRC = 'Nø de lot',
                           ENC = 'Lot No.';
            Visible = true;
        }
        modify("Zone Code")
        {
            Visible = true;
        }
        addafter("Zone Code")
        {
            field("Suggested Bin Code"; Rec."Suggested Bin Code")
            {
                ApplicationArea = all;
            }

        }
        modify("Bin Code")
        {
            Visible = true;
            CaptionML = ENU = 'Actual Bin Code',
                           ESM = 'C¢d. ubicaci¢n',
                           FRC = 'Code de zone',
                           ENC = 'Bin Code';
        }
    }
}
