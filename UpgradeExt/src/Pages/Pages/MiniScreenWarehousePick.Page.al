page 50048 "Mini Screen - Warehouse Pick"
{
    // SSC56 06/06/13
    // - added Print Picking List

    Caption = 'Warehouse Pick';
    InsertAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = WHERE(Type = CONST(Pick));
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
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(CurrentLocationCode; CurrentLocationCode)
                {
                    Caption = 'Location Code';
                    Editable = false;
                    Lookup = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
            }
            part(WhseActivityLines; "Whse. Pick Subform")
            {

                SubPageLink = "Activity Type" = FIELD(Type),
                              "No." = FIELD("No.");

                SubPageView = SORTING("Activity Type", "No.", "Sorting Sequence No.")
                              WHERE("Breakbulk" = CONST(false));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("P&ick")
            {
                Caption = 'P&ick';
                Image = CreateInventoryPickup;
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ToolTip = 'Executes the List action.';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        rec.LookupActivityHeader(CurrentLocationCode, Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type), "No." = FIELD("No.");
                    ApplicationArea = All;
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("Registered Picks")
                {
                    Caption = 'Registered Picks';
                    Image = RegisteredDocs;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Registered Whse. Activity List";
                    RunPageLink = Type = FIELD(Type), "Whse. Activity No." = FIELD("No.");
                    ApplicationArea = All;
                    RunPageView = SORTING("Whse. Activity No.");
                    ToolTip = 'Executes the Registered Picks action.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Autofill Qty. to Handle")
                {
                    Caption = 'Autofill Qty. to Handle';
                    Image = AutofillQtyToHandle;
                    ToolTip = 'Executes the Autofill Qty. to Handle action.';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        AutofillQtyToHandle();
                    end;
                }
                action("Delete Qty. to Handle")
                {
                    Caption = 'Delete Qty. to Handle';
                    Image = DeleteQtyToHandle;
                    ToolTip = 'Executes the Delete Qty. to Handle action.';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        DeleteQtyToHandle();
                    end;
                }
                // separator()
                // {
                // }
            }
            group("&Registering")
            {
                Caption = '&Registering';
                Image = PostOrder;
                action(RegisterPick)
                {
                    Caption = '&Register Pick';
                    Image = RegisterPick;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the &Register Pick action.';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        RegisterActivityYesNo();
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    WhseActPrint.PrintPickHeader(Rec);
                end;
            }
            action("Print Picking List")
            {
                Caption = 'Print Picking List';
                Image = PickLines;
                ToolTip = 'Executes the Print Picking List action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //>>SSC56
                    WhseActPrint.PrintPickHeader(Rec);
                    //<<SSC56
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrentLocationCode := Rec."Location Code";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.UPDATE();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage()
    begin
        Rec.ErrorIfUserIsNotWhseEmployee();
    end;

    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
        CurrentLocationCode: Code[10];

    local procedure AutofillQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.AutofillQtyToHandle();
    end;

    local procedure DeleteQtyToHandle()
    begin
        CurrPage.WhseActivityLines.PAGE.DeleteQtyToHandle();
    end;

    local procedure RegisterActivityYesNo()
    begin
        CurrPage.WhseActivityLines.PAGE.RegisterActivityYesNo();
    end;

    local procedure SortingMethodOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure BreakbulkFilterOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;
}

