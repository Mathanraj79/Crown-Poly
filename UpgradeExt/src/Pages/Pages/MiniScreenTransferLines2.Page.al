page 50046 "Mini Screen - Transfer Lines 2"
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
            group(General)
            {
                Caption = 'General';
                field(TransferHeaderNo; TransferHeader."No.")
                {
                    Caption = 'Transfer Order No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the TransferHeader field.';
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
                    field("Unit of Measure Code"; Rec."Unit of Measure Code")
                    {
                        Caption = 'Unit of Measure Code';
                        ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                        ApplicationArea = All;
                    }
                    field("Quantity Shipped"; Rec."Quantity Shipped")
                    {
                        Caption = 'Quantity Shipped';
                        ToolTip = 'Specifies the value of the Quantity Shipped field.';
                        ApplicationArea = All;
                    }
                    field("Qty. to Receive"; Rec."Qty. to Receive")
                    {
                        Caption = 'Qty. to Receive';
                        ToolTip = 'Specifies the value of the Qty. to Receive field.';
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
                Image = Shipment;
                ToolTip = 'Executes the Item Tracking Lines action.';
                trigger OnAction()
                begin
                    Rec.OpenItemTrackingLines(1);
                end;
            }
            action("Post Receipt")
            {
                Caption = 'P&ost Receipt';
                Image = PostOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ShortCutKey = 'F9';
                ToolTip = 'Executes the P&ost Receipt action.';
                trigger OnAction()
                var
                    WhseRqst: Record "Warehouse Request";
                    WhseRcptHeader: Record "Warehouse Receipt Header";
                    WhseReceiptLine: Record "Warehouse Receipt Line";
                    WhseActivityLine: Record "Warehouse Activity Line";
                    GetSourceDocuments: Report "Get Source Documents";
                    WhsePostReceipt: Codeunit "Whse.-Post Receipt";
                    WhseActivityRegister: Codeunit "Whse.-Activity-Register";
                    WMSMgt: Codeunit "WMS Management";

                begin
                    IF CONFIRM(Text001Lbl, TRUE) THEN BEGIN
                        // Create Whse. Receipt
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        WhseRqst.SETRANGE(Type, WhseRqst.Type::Inbound);
                        WhseRqst.SETRANGE("Source Type", DATABASE::"Transfer Line");
                        WhseRqst.SETRANGE("Source Subtype", 1);
                        WhseRqst.SETRANGE("Source No.", TransferHeader."No.");
                        WhseRqst.SETRANGE("Document Status", WhseRqst."Document Status"::Released);
                        IF WhseRqst.FINDFIRST() THEN BEGIN
                            GetSourceDocuments.USEREQUESTPAGE(FALSE);
                            GetSourceDocuments.SETTABLEVIEW(WhseRqst);
                            GetSourceDocuments.RUNMODAL();
                            GetSourceDocuments.GetLastReceiptHeader(WhseRcptHeader);
                        END;

                        // Post Whse. Receipt
                        WhseRcptHeader.GET(WhseRcptHeader."No.");
                        WhseReceiptLine.RESET();
                        WhseReceiptLine.SETRANGE("No.", WhseRcptHeader."No.");
                        WhseReceiptLine.FINDFIRST();
                        WhsePostReceipt.RUN(WhseReceiptLine);

                        // Register Whse. Put-Away
                        WhseActivityLine.RESET();
                        WhseActivityLine.SETRANGE("Activity Type", WhseActivityLine."Activity Type"::"Put-away");
                        WhseActivityLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
                        WhseActivityLine.SETRANGE("Source Subtype", 1);
                        WhseActivityLine.SETRANGE("Source No.", TransferHeader."No.");
                        WhseActivityLine.FINDFIRST();
                        WMSMgt.CheckBalanceQtyToHandle(WhseActivityLine);
                        WhseActivityRegister.RUN(WhseActivityLine);

                        // Close page
                        CurrPage.CLOSE();
                    END;
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
        Text001Lbl: Label 'Do you want to post the receipt?';

    procedure SetTransferHeader(DocNo: Code[20])
    begin
        TransferHeader.GET(DocNo);
    end;
}

