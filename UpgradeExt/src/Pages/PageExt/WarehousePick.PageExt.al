pageextension 50155 "Warehouse Pick" extends "Warehouse Pick"
{
    actions
    {
        addafter("&Print")
        {
            action("Print Picking List ")
            {
                CaptionML = ENU = 'Print Picking List';
                Image = PickLines;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    WhseActPrint.PrintPickHeader(Rec);
                end;
            }
        }
    }
    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
}
