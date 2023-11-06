pageextension 50157 "Standard Cost Worksheet" extends "Standard Cost Worksheet"
{
    actions
    {
        addafter("&Implement Standard Cost Changes")
        {
            action("Update Indirect Cost %")
            {
                CaptionML = ENU = 'Update Indirect Cost %';
                Promoted = true;
                Image = UpdateUnitCost;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    StandardCost.UpdateIndirectCost(Rec);
                end;
            }
        }
    }
    var
        StandardCost: Codeunit "Standard Cost worksheet";
}
