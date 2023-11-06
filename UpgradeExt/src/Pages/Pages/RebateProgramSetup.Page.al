page 50079 "Rebate Program Setup"
{
    Caption = 'Rebate Program Setup';
    PageType = Card;
    SourceTable = "Rebate Program Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Rebate Details")
            {
                Caption = 'Rebate Details';
                field("Rebate No."; Rec."Rebate No.")
                {
                    Caption = 'Rebate No.';
                    ToolTip = 'Specifies the value of the Rebate No. field.';
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    QuickEntry = false;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    QuickEntry = false;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                    ApplicationArea = all;
                }
                field("Rebate Method"; Rec."Rebate Method")
                {
                    Caption = 'Rebate Method';
                    ToolTip = 'Specifies the value of the Rebate Method field.';
                    ApplicationArea = all;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    Caption = 'Customer Type';
                    ToolTip = 'Specifies the value of the Customer Type field.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF Rec."Customer Type" = Rec."Customer Type"::Customer THEN
                            "No.Editable" := TRUE
                        ELSE
                            "No.Editable" := FALSE
                    end;
                }
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
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
            }
            part("Rebate Program - End User"; "Rebate Program - End User")
            {
                SubPageLink = "Rebate No." = FIELD("Rebate No.");
                SubPageView = SORTING("Rebate No.", "End User No.");
                ApplicationArea = all;

            }
            part("Rebate Program Details"; "Rebate Program Details")
            {
                SubPageLink = "Rebate No." = FIELD("Rebate No.");
                SubPageView = SORTING("Rebate No.", "Item No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Rebate)
            {
                Caption = 'Rebate';
                action("Ledger Entries")
                {
                    Caption = 'Ledger Entries';
                    ApplicationArea = all;
                    ToolTip = 'Executes the Ledger Entries action.';
                    Image = LedgerEntries;
                    RunObject = Page "Rebate Ledger Entries";
                    RunPageLink = "Rebate No." = FIELD("Rebate No.");
                    RunPageView = SORTING("Entry No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec."Customer Type" = Rec."Customer Type"::Customer THEN
            "No.Editable" := TRUE
        ELSE
            "No.Editable" := FALSE
    end;

    trigger OnInit()
    begin
        "No.Editable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF Rec."Customer Type" = Rec."Customer Type"::Customer THEN
            "No.Editable" := TRUE
        ELSE
            "No.Editable" := FALSE
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        "No.Editable": Boolean;
}

