page 50029 "Total Net Price Worksheet"
{
    Caption = 'Total Net Price Worksheet';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "Total Net Price";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = all;
                }
                field("End User Cases"; Rec."End User Cases")
                {
                    Caption = 'End User Cases';
                    ToolTip = 'Specifies the value of the End User Cases field.';
                    ApplicationArea = all;
                }
                field("End User Case Percent"; Rec."End User Case Percent")
                {
                    Caption = 'End User Case Percent';
                    ToolTip = 'Specifies the value of the End User Case Percent field.';
                    ApplicationArea = all;
                }
                field("Base Price Case"; Rec."Base Price Case")
                {
                    Caption = 'Base Price Case';
                    ToolTip = 'Specifies the value of the Base Price Case field.';
                    ApplicationArea = all;
                }
                field(Freight; Rec.Freight)
                {
                    Caption = 'Freight';
                    ToolTip = 'Specifies the value of the Freight field.';
                    ApplicationArea = all;
                }
                field(Instant; Rec.Instant)
                {
                    Caption = 'Instant';
                    ToolTip = 'Specifies the value of the Instant field.';
                    ApplicationArea = all;
                }
                field(POD; Rec.POD)
                {
                    Caption = 'POD';
                    ToolTip = 'Specifies the value of the POD field.';
                    ApplicationArea = all;
                }
                field(Quarterly; Rec.Quarterly)
                {
                    Caption = 'Quarterly';
                    ToolTip = 'Specifies the value of the Quarterly field.';
                    ApplicationArea = all;
                }
                field(Annually; Rec.Annually)
                {
                    Caption = 'Annually';
                    ToolTip = 'Specifies the value of the Annually field.';
                    ApplicationArea = all;
                }
                field("Case Cost Deduction"; Rec."Case Cost Deduction")
                {
                    Caption = 'Case Cost Deduction';
                    ToolTip = 'Specifies the value of the Case Cost Deduction field.';
                    ApplicationArea = all;
                }
                field("Broker Commission Percent"; Rec."Broker Commission Percent")
                {
                    Caption = 'Broker Commission';
                    ToolTip = 'Specifies the value of the Broker Commission field.';
                    ApplicationArea = all;
                }
                field("Sales Commission Percent"; Rec."Sales Commission Percent")
                {
                    Caption = 'Sales Commission';
                    ToolTip = 'Specifies the value of the Sales Commission field.';
                    ApplicationArea = all;
                }
                field("Single Net Price"; Rec."Single Net Price")
                {
                    Caption = 'Single Net Price';
                    ToolTip = 'Specifies the value of the Single Net Price field.';
                    ApplicationArea = all;
                }
                field("Double Net Price"; Rec."Double Net Price")
                {
                    Caption = 'Double Net Price';
                    ToolTip = 'Specifies the value of the Double Net Price field.';
                    ApplicationArea = all;
                }
                field("Triple Net Price"; Rec."Triple Net Price")
                {
                    Caption = 'Triple Net Price';
                    ToolTip = 'Specifies the value of the Triple Net Price field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

