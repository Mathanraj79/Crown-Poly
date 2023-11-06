codeunit 50030 "Transfer Order"
{


    var
        WhseRqst: Record "Warehouse Request";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WhseActivityHeader: Record "Warehouse Activity Header";
        WhseActivityLine: Record "Warehouse Activity Line";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
        WMSMgt: Codeunit "WMS Management";
        GetSourceDocuments: Report "Get Source Documents";


    procedure CreatePostWhseReceiptPutAway(var Transferorder: Record "Transfer Header")
    begin
        Transferorder.TESTFIELD(Status, Transferorder.Status::Released);
        WhseRqst.SETRANGE(Type, WhseRqst.Type::Inbound);
        WhseRqst.SETRANGE("Source Type", DATABASE::"Transfer Line");
        WhseRqst.SETRANGE("Source Subtype", 1);
        WhseRqst.SETRANGE("Source No.", Transferorder."No.");
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
        WhseActivityLine.SETRANGE("Source No.", Transferorder."No.");
        WhseActivityLine.FINDFIRST();
        WMSMgt.CheckBalanceQtyToHandle(WhseActivityLine);
        WhseActivityRegister.RUN(WhseActivityLine);
    end;
}
