codeunit 50010 "Sales Order-Printed"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        Rec.FIND();
        Rec."Sales Order Printed" := Rec."Sales Order Printed" + 1;
        Rec.MODIFY();
        COMMIT();
    end;

}

