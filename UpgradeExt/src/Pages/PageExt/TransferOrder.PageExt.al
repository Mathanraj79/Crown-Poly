pageextension 50153 "Transfer Order" extends "Transfer Order"
{
    layout
    {

    }
    actions
    {
        addafter("F&unctions")
        {
            action("Suggest Produced Item")
            {
                CaptionML = ENU = 'Suggest Produced Item to Transfer';
                Image = Production;
                trigger OnAction()
                var
                //TransHeader : Record 5740;
                //SuggestProducedItems : Report 50040;
                begin

                end;
            }
        }
        addafter("Create &Whse. Receipt")
        {
            action("CreatePostWhseReceiptPut-Away")
            {
                CaptionML = ENU = 'Create && Post &Whse. Receipt and Put-away';
                Image = NewReceipt;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    TransferOrder.CreatePostWhseReceiptPutAway(Rec);
                end;
            }
        }
    }
    var
        TransferOrder: Codeunit "Transfer Order";
}
