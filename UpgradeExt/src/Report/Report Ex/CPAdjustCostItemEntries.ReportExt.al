reportextension 50002 "CP Adjust Cost - Item Entries" extends "Adjust Cost - Item Entries"
{
    dataset
    {
    }
    trigger OnPreReport()
    begin
        //001 - START
        UpdateLogAdjustCostRun();
        //001 - END
    end;

    trigger OnPostReport()
    begin
        //001 - START
        InsertLogAdjustCostRun();
        //001 - END
    end;

    PROCEDURE InsertLogAdjustCostRun();
    BEGIN
        LogAdjustCostRun.INIT();
        LogAdjustCostRun."Start DateTime" := CURRENTDATETIME;
        IF ItemNoFilter <> '' THEN
            LogAdjustCostRun."Report Filters" := ItemNoFilter
        ELSE
            LogAdjustCostRun."Report Filters" := ItemCategoryFilter;
        LogAdjustCostRun.INSERT();
    END;

    PROCEDURE UpdateLogAdjustCostRun();
    BEGIN
        LogAdjustCostRun."End DateTime" := CURRENTDATETIME;
        LogAdjustCostRun."Run Duration" := LogAdjustCostRun."End DateTime" - LogAdjustCostRun."Start DateTime";
        LogAdjustCostRun.MODIFY();
    END;

    var
        LogAdjustCostRun: Record "Adjust Cost Run - Log";
}
