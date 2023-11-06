codeunit 50107 "Standard Cost worksheet"
{

    var
        StandardCostWSRec: Record "Standard Cost Worksheet";
        ItemRec: Record Item;

    procedure UpdateIndirectCost(var StandardCost: Record "Standard Cost Worksheet")
    begin
        StandardCostWSRec.COPY(StandardCost);
        StandardCostWSRec.SETRANGE(Type, StandardCostWSRec.Type::Item);
        IF StandardCostWSRec.FIND('-') THEN
            repeat
                ItemRec.GET(StandardCostWSRec."No.");
                StandardCostWSRec.VALIDATE("New Indirect Cost %",
                  ROUND((ItemRec."CP Overhead Rate" / StandardCostWSRec."New Standard Cost") * 100, 0.01));
                StandardCostWSRec.MODIFY(TRUE);
            until StandardCostWSRec.NEXT() = 0;
    end;
}
