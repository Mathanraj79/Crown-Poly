report 50045 "Create Rebate Worksheet"
{
    Caption = 'Create Rebate Worksheet';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Rebate Ledger Entries"; "Rebate Ledger Entries")
        {
            DataItemTableView = SORTING("Exported")
                                WHERE("Exported" = FILTER(false),
                                      "Rebate Type" = FILTER(<> "Instant Credit"));
            RequestFilterFields = "Date Claimed", "Rebate Type";

            trigger OnAfterGetRecord()
            begin
                RebateWorksheet."Entry No." := LineNo;
                RebateWorksheet."Rebate ID" := "Rebate No.";
                IF "Customer Type" = "Customer Type"::Customer THEN
                    RebateWorksheet."Customer No." := "No."
                ELSE BEGIN
                    RebateWorksheet."Enduser ID" := "No.";
                    IF EndUser.GET("No.") THEN BEGIN
                        RebateWorksheet."Customer No." := EndUser."Customer No.";
                        RebateWorksheet."Vendor No." := EndUser."Vendor No.";
                    END;
                END;
                RebateWorksheet."Total Rebate Amount" := "Rebate Amount";
                RebateWorksheet."Rebate Method" := "Rebate Method";
                RebateWorksheet."Date Claimed" := "Date Claimed";
                RebateWorksheet."Document No." := "Rebate Claim No.";
                RebateWorksheet."Rebate Ledg. No." := "Entry No.";
                RebateWorksheet."Item No." := "Item No.";
                RebateWorksheet."Quantity Claimed" := "Quantity Claimed";
                IF RebateWorksheet.INSERT() THEN BEGIN
                    rebateLedgEntry.GET("Entry No.");
                    rebateLedgEntry.Exported := TRUE;
                    rebateLedgEntry.MODIFY();
                END;

                LineNo += 10;
            end;

            trigger OnPreDataItem()
            begin
                RebateWorksheet.RESET();
                IF RebateWorksheet.FINDLAST() THEN
                    LineNo := RebateWorksheet."Entry No." + 10
                ELSE
                    LineNo := 10;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        EndUser: Record "End User";
        RebateWorksheet: Record "Rebate Worksheet";
        rebateLedgEntry: Record "Rebate Ledger Entries";
        LineNo: Integer;
}

