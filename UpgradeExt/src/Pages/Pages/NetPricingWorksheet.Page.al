page 50028 "Net Pricing Worksheet"
{
    Caption = 'Net Pricing Worksheet';
    PageType = Worksheet;
    SourceTable = "Net Price";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("End User No."; Rec."End User No.")
                {
                    Caption = 'End User No.';
                    ToolTip = 'Specifies the value of the End User No. field.';
                    ApplicationArea = All;
                }
                field("End User Cases"; Rec."End User Cases")
                {
                    Caption = 'End User Cases';
                    ToolTip = 'Specifies the value of the End User Cases field.';
                    ApplicationArea = All;
                }
                field("End User Case Percent"; Rec."End User Case Percent")
                {
                    Caption = 'End User Case Percent';
                    ToolTip = 'Specifies the value of the End User Case Percent field.';
                    ApplicationArea = All;
                }
                field("Base Price Case"; Rec."Base Price Case")
                {
                    Caption = 'Base Price Case';
                    ToolTip = 'Specifies the value of the Base Price Case field.';
                    ApplicationArea = All;
                }
                field(Freight; Rec.Freight)
                {
                    Caption = 'Freight';
                    ToolTip = 'Specifies the value of the Freight field.';
                    ApplicationArea = All;
                }
                field(Instant; Rec.Instant)
                {
                    Caption = 'Instant';
                    ToolTip = 'Specifies the value of the Instant field.';
                    ApplicationArea = All;
                }
                field(POD; Rec.POD)
                {
                    Caption = 'POD';
                    ToolTip = 'Specifies the value of the POD field.';
                    ApplicationArea = All;
                }
                field(Quarterly; Rec.Quarterly)
                {
                    Caption = 'Quarterly';
                    ToolTip = 'Specifies the value of the Quarterly field.';
                    ApplicationArea = All;
                }
                field(Annually; Rec.Annually)
                {
                    Caption = 'Annually';
                    ToolTip = 'Specifies the value of the Annually field.';
                    ApplicationArea = All;
                }
                field("Case Cost Deduction"; Rec."Case Cost Deduction")
                {
                    Caption = 'Case Cost Deduction';
                    ToolTip = 'Specifies the value of the Case Cost Deduction field.';
                    ApplicationArea = All;
                }
                field("Broker Commission Percent"; Rec."Broker Commission Percent")
                {
                    Caption = 'Broker Commission';
                    ToolTip = 'Specifies the value of the Broker Commission field.';
                    ApplicationArea = All;
                }
                field("Sales Commission Percent"; Rec."Sales Commission Percent")
                {
                    Caption = 'Sales Commission';
                    ToolTip = 'Specifies the value of the Sales Commission field.';
                    ApplicationArea = All;
                }
                field("Single Net Price"; Rec."Single Net Price")
                {
                    Caption = 'Single Net Price';
                    ToolTip = 'Specifies the value of the Single Net Price field.';
                    ApplicationArea = All;
                }
                field("Double Net Price"; Rec."Double Net Price")
                {
                    Caption = 'Double Net Price';
                    ToolTip = 'Specifies the value of the Double Net Price field.';
                    ApplicationArea = All;
                }
                field("Triple Net Price"; Rec."Triple Net Price")
                {
                    Caption = 'Triple Net Price';
                    ToolTip = 'Specifies the value of the Triple Net Price field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Create Net Price")
            {
                Caption = 'Create Net Price';
                Image = Costs;
                Promoted = true;
                RunObject = Report 50046;
                ToolTip = 'Executes the Create Net Price action.';
                ApplicationArea = All;
            }
            action("Total Net Price")
            {
                Caption = 'Total Net Price';
                ToolTip = 'Executes the Total Net Price action.';
                ApplicationArea = All;
                Image = PriceWorksheet;
                Promoted = true;
                RunObject = Page "Total Net Price Worksheet";
                RunPageLink = "Customer No." = FIELD("Customer No."), "Item No." = FIELD("Item No.");
                RunPageView = SORTING("Entry No.");
            }
        }
    }
}

