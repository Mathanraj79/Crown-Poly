page 50039 "Prod. Manager Dashboard"
{
    Caption = 'Prod. Manager Dashboard';
    PageType = Card;
    SourceTable = "Machine Center";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = all;
                }
                field(StartingDate; StartingDate)
                {
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.ProdRtng.PAGE.FilterforDate(StartingDate, EndingDate);
                    end;
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the value of the Ending Date field.';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.ProdRtng.PAGE.FilterforDate(StartingDate, EndingDate);
                    end;
                }
            }
            part(ProdRtng; "Production Order Rounting")
            {
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("Starting Date", "Starting Time", "Ending Date", "Ending Time", "No.")
                              WHERE(Type = FILTER("Machine Center"),
                                    Status = FILTER(Released));
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Finish Prod. Order")
            {
                Caption = 'Finish Prod. Order';
                ApplicationArea = all;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CurrPage.ProdRtng.PAGE.FinishProdorder();
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CurrPage.ProdRtng.PAGE.PostOutput();
                end;
            }
        }
    }

    var
        StartingDate: Date;
        EndingDate: Date;
}

