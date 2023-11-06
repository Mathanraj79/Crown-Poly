page 50036 "Mini Screen - Sales Lines 1"
{
    // SSC56 - new object

    Caption = 'Sales Lines';
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Sales Order No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                    ApplicationArea = All;
                }
                repeater(Lines)
                {
                    Caption = 'Lines';
                    field(Type; Rec.Type)
                    {
                        Caption = 'Type';
                        ToolTip = 'Specifies the value of the Type field.';
                        ApplicationArea = All;
                    }
                    field("No."; Rec."No.")
                    {
                        Caption = 'No.';
                        ToolTip = 'Specifies the value of the No. field.';
                        ApplicationArea = All;
                    }
                    field("Location Code"; Rec."Location Code")
                    {
                        Caption = 'Location Code';
                        ToolTip = 'Specifies the value of the Location Code field.';
                        ApplicationArea = All;
                    }
                    field(Quantity; Rec.Quantity)
                    {
                        Caption = 'Quantity';
                        ToolTip = 'Specifies the value of the Quantity field.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Item Tracking Lines")
            {
                Caption = 'Item Tracking Lines';
                Image = LotInfo;
                ToolTip = 'Executes the Item Tracking Lines action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ReserveSalesLine: Codeunit "Sales Line-Reserve";
                begin
                    Rec.OpenItemTrackingLines();
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'Executes the Dimensions action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    SalesHeader.ShowDocDim();
                end;
            }
            action("Create Bill of Lading")
            {
                Caption = 'Create Bill of Lading';
                ToolTip = 'Executes the Create Bill of Lading action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    recBOLHeader: Record "BOL Header";
                    BOLmgt: Codeunit 50001;
                    fbol: Page "BOL Form";
                begin
                    BOLmgt.CreateBOL(SalesHeader);

                    recBOLHeader.RESET();
                    recBOLHeader.SETRANGE("No.", SalesHeader."BOL No.");
                    fbol.SETTABLEVIEW(recBOLHeader);
                    fbol.RUNMODAL();
                end;
            }
            action("Bill of Lading")
            {
                Caption = 'Bill of Lading';
                ToolTip = 'Executes the Bill of Lading action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    BOLMgmt: Codeunit 50001;
                begin
                    BOLMgmt.ListBOL(SalesHeader);
                end;
            }
            action(Post1)
            {
                Caption = 'P&ost';
                Image = PostOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ShortCutKey = 'F9';
                ToolTip = 'Executes the P&ost action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Post(CODEUNIT::"Sales-Post (Yes/No)");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
    end;

    var
        SalesHeader: Record "Sales Header";

    local procedure Post(PostingCodeunitID: Integer)
    begin
        SalesHeader.SendToPosting(PostingCodeunitID);
        CurrPage.CLOSE();
    end;
}

