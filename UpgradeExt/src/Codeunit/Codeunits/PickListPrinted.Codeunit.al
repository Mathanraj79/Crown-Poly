codeunit 50011 "Pick List-Printed"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        Rec.FIND();
        Rec."Pick List Printed" := Rec."Pick List Printed" + 1;
        Rec.MODIFY();
        COMMIT();
    end;
}

