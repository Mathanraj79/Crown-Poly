report 50024 "Update GL Account to PurchRec"
{
    Permissions = TableData "Purchase Line" = m,
                  TableData "Purch. Rcpt. Line" = m;
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = all;
    Caption = 'Update GL Account to PurchRec';
    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            DataItemTableView = WHERE(Type = FILTER("G/L Account"));
            RequestFilterFields = "Order No.", "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchRcptLine."Order No.") AND
                  (PurchaseHeader.Status = PurchaseHeader.Status::Open) THEN
                    PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Open);
                PurchaseHeader.MODIFY();

                GLAccount.GET(ToGlNo);
                PurchRcptLine."No." := ToGlNo;
                PurchRcptLine.Description := GLAccount.Name;
                PurchRcptLine.MODIFY();

                PurchLine.RESET();
                PurchLine.SETRANGE("Document No.", PurchRcptLine."Order No.");
                PurchLine.SETRANGE(Type, PurchRcptLine.Type::"G/L Account");
                PurchLine.SETRANGE("No.", FromGLNo);
                IF PurchLine.FINDFIRST() THEN BEGIN
                    PurchLine."No." := ToGlNo;
                    PurchLine.Description := GLAccount.Name;
                    PurchLine.MODIFY();
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Records have been Updated.');
            end;

            trigger OnPreDataItem()
            begin
                //IF PurchRcptLine.GETFILTER("Order No.") = '' THEN
                //  ERROR('Select Document No. to update.');

                IF (FromGLNo = '') OR (ToGlNo = '') THEN
                    ERROR('Select From and To GL Account No. For Update.');

                IF FromGLNo = ToGlNo THEN
                    ERROR('From and To GL Account No. Must Be Different.');

                PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::"G/L Account");
                PurchRcptLine.SETRANGE("No.", FromGLNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Insert Old GL Account No."; FromGLNo)
                    {
                        TableRelation = "G/L Account"."No.";
                        ToolTip = 'Specifies the value of the FromGLNo field.';
                        caption = 'Insert Old GL Account No.';
                        ApplicationArea = all;
                    }
                    field("Insert New GL Account No."; ToGlNo)
                    {
                        TableRelation = "G/L Account"."No.";
                        ToolTip = 'Specifies the value of the ToGlNo field.';
                        caption = 'Insert New GL Account No.';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        GLAccount: Record "G/L Account";
        FromGLNo: Code[20];
        ToGlNo: Code[20];

}

