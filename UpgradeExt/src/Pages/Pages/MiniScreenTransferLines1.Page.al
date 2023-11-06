page 50045 "Mini Screen - Transfer Lines 1"
{
    // SSC56 - new object

    Caption = 'Transfer Lines';
    DataCaptionFields = "Document No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Transfer Line";
    SourceTableView = WHERE("Derived From Line No." = CONST(0));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(general)
            {
                Caption = 'general';
                field(TransferHeaderNo; TransferHeader."No.")
                {
                    Caption = 'Transfer Order No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the TransferHeader field.';
                    ApplicationArea = All;

                }
                field(TypeOfItem; TypeOfItem)
                {
                    Caption = 'Type Of Item';
                    OptionCaption = ' ,Domestic,Export';
                    ToolTip = 'Specifies the value of the Type Of Item field.';
                    ApplicationArea = All;
                }
                repeater(Lines)
                {
                    Caption = 'Lines';
                    field("Item No."; Rec."Item No.")
                    {
                        Editable = false;
                        Caption = 'Item No.';
                        ToolTip = 'Specifies the value of the Item No. field.';
                        ApplicationArea = All;
                    }
                    field(Quantity; Rec.Quantity)
                    {
                        Caption = 'Quantity';
                        ToolTip = 'Specifies the value of the Quantity field.';
                        ApplicationArea = All;
                    }
                    field("Unit of Measure Code"; Rec."Unit of Measure Code")
                    {
                        Caption = 'Unit of Measure Code';
                        ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                        ApplicationArea = All;
                    }
                    field("Qty. to Ship"; Rec."Qty. to Ship")
                    {
                        Caption = 'Qty. to Ship';
                        ToolTip = 'Specifies the value of the Qty. to Ship field.';
                        ApplicationArea = All;
                    }
                    field("Quantity Shipped"; Rec."Quantity Shipped")
                    {
                        Visible = false;
                        Caption = 'Quantity Shipped';
                        ToolTip = 'Specifies the value of the Quantity Shipped field.';
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
            action("Suggest Produced Item")
            {
                Caption = 'Suggest Produced Item to Transfer';
                Image = Production;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Suggest Produced Item to Transfer action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    WhseHouseMgmtSetup: Record "Whse. Mgmt Setup";
                    TransHeader2: Record "Transfer Header";
                    SuggestProducedItems: Report 50040;
                begin
                    //>>SSC56
                    WhseHouseMgmtSetup.GET(WhseHouseMgmtSetup.Type::Item, TypeOfItem);
                    WhseHouseMgmtSetup.TESTFIELD("Default Location Code");
                    TransferHeader.GET(Rec."Document No.");
                    IF TransferHeader."Transfer-to Code" <> WhseHouseMgmtSetup."Default Location Code" THEN BEGIN
                        TransferHeader.SetHideValidationDialog(TRUE);
                        TransferHeader.VALIDATE("Transfer-to Code", WhseHouseMgmtSetup."Default Location Code");
                        TransferHeader.MODIFY();
                        COMMIT();
                    END;

                    TransHeader2.GET(Rec."Document No.");
                    TransHeader2.SETRECFILTER();
                    SuggestProducedItems.SetPostingDate(TransHeader2."Posting Date");
                    SuggestProducedItems.SetTypeOfItem(TypeOfItem);
                    SuggestProducedItems.SETTABLEVIEW(TransHeader2);
                    SuggestProducedItems.USEREQUESTPAGE(FALSE);
                    SuggestProducedItems.RUNMODAL();

                    CurrPage.UPDATE();
                    //<<SSC56
                end;
            }
            action("Item Tracking Lines")
            {
                Caption = 'Item Tracking Lines';
                Image = Shipment;
                ToolTip = 'Executes the Item Tracking Lines action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.OpenItemTrackingLines(0);
                end;
            }
            action("Post Shipment")
            {
                Caption = 'P&ost Shipment';
                Image = PostOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ShortCutKey = 'F9';
                ToolTip = 'Executes the P&ost Shipment action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
                begin
                    IF CONFIRM(Text001Lbl, TRUE) THEN
                        TransferPostShipment.RUN(TransferHeader);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TransferHeader.GET(Rec."Document No.");
    end;

    var
        TransferHeader: Record "Transfer Header";
        TypeOfItem: Option " ",Domestic,Export;
        Text001Lbl: Label 'Do you want to post the shipment?';

    procedure SetTransferHeader(DocNo: Code[20])
    begin
        TransferHeader.GET(DocNo);
    end;
}

