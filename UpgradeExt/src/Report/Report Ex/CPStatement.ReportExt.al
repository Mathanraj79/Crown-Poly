reportextension 50000 "CP Statement" extends Statement
{
    dataset
    {
    }
    PROCEDURE GetBatchParameters();
    VAR
        //EasyPDFState: Codeunit 14103461;
    BEGIN
        // EASYPDF.begin
        // IF EasyPDFState.GetBatchData(FilterData, ParameterData) THEN BEGIN

        //     EVALUATE(PrintEntriesDue, COPYSTR(SELECTSTR(1, ParameterData), 2));
        //     EVALUATE(PrintAllHavingEntry, COPYSTR(SELECTSTR(2, ParameterData), 2));
        //     EVALUATE(PrintAllHavingBal, COPYSTR(SELECTSTR(3, ParameterData), 2));
        //     EVALUATE(PrintReversedEntries, COPYSTR(SELECTSTR(4, ParameterData), 2));
        //     EVALUATE(PrintUnappliedEntries, COPYSTR(SELECTSTR(5, ParameterData), 2));
        //     EVALUATE(IncludeAgingBand, COPYSTR(SELECTSTR(6, ParameterData), 2));
        //     EVALUATE(PeriodLength, COPYSTR(SELECTSTR(7, ParameterData), 2));
        //     EVALUATE(DateChoice, COPYSTR(SELECTSTR(8, ParameterData), 2));
        //     EVALUATE(LogInteraction, COPYSTR(SELECTSTR(9, ParameterData), 2));

        // END;
        // EASYPDF.end
    END;

    var
        FilterData: Text[250];
        ParameterData: Text[250];
}
