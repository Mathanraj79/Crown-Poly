page 50047 "Mini Screen - Sales Lines 2"
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
            group(general)
            {
                Caption = 'general';
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
                Promoted = true;
                ToolTip = 'Executes the Item Tracking Lines action.';
                ApplicationArea = All;
                trigger OnAction()
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
                    fbol: Page 50022;
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
            // separator()
            // {
            // }
            action("Create &Whse. Shipment && Pick Ticket")
            {
                Caption = 'Create &Whse. Shipment && Pick Ticket';
                Image = NewShipment;
                ToolTip = 'Executes the Create &Whse. Shipment && Pick Ticket action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                begin
                    //>>SSC56
                    GetSourceDocOutbound.CreateFromSalesOrder(SalesHeader);

                    IF NOT Rec.FIND('=><') THEN
                        Rec.INIT();
                    //<<SSC56
                end;
            }
            action("Post &Pick Ticket && Whse. Shipment")
            {
                Caption = 'Post &Pick Ticket && Whse. Shipment';
                Image = Post;
                ToolTip = 'Executes the Post &Pick Ticket && Whse. Shipment action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                begin
                    //>>SSC56
                    SalesHeader.PostPickAndWhseShipment(SalesHeader);
                    //<<SSC56
                end;
            }
            // separator()
            // {
            // }
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

