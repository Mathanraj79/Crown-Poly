report 50037 "Rebate Setups"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;
    Caption = 'Rebate Setups';
    dataset
    {
        dataitem("Rebate Program Header"; "Rebate Program Header")
        {
            DataItemTableView = SORTING("Rebate No.")
                                ORDER(Ascending);
            RequestFilterFields = "Rebate No.", "Start Date", "End Date", "Customer Type", "No.";
            dataitem("Rebate Program Details"; "Rebate Program Details")
            {
                DataItemLink = "Rebate No." = FIELD("Rebate No.");
                DataItemTableView = SORTING("Rebate No.", "Item No.")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    MakeExcelDetail();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(EndUserId);
                RebatePrgEndUser.RESET();
                RebatePrgEndUser.SETRANGE("Rebate No.", "Rebate No.");
                IF RebatePrgEndUser.FINDFIRST() THEN
                    EndUserId := RebatePrgEndUser."End User No.";
            end;

            trigger OnPreDataItem()
            begin
                ReportFilters := GETFILTERS();
                MakeExcelHeader();
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

    trigger OnPostReport()
    begin
        //TempExcelBuffer.GiveUserControl; charmee comment
        TempExcelBuffer.CreateNewBook('Rebate Setups');
        TempExcelBuffer.WriteSheet('Rebate Setups', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.OpenExcel();
    end;

    trigger OnPreReport()
    begin
        RowNo := 0;
        TempExcelBuffer.DELETEALL();
    end;

    var
        RebatePrgEndUser: Record "Rebate Program - End User";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        EndUserId: Code[20];
        RowNo: Integer;

        ReportFilters: Text;

    local procedure EnterCell(RowNumber: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; Format: Text[30]; CellType: Option)
    begin
        TempExcelBuffer.INIT();
        TempExcelBuffer.VALIDATE("Row No.", RowNumber);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := Format;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.INSERT();
    end;

    procedure MakeExcelHeader()
    begin
        RowNo += 1;
        EnterCell(RowNo, 1, 'Rebate Setups Report', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        IF ReportFilters <> '' THEN BEGIN
            RowNo += 1;
            EnterCell(RowNo, 1, FORMAT(ReportFilters), FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        END;

        RowNo += 2;
        EnterCell(RowNo, 1, 'Rebate No', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, 'Start Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 3, 'End Date', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 4, 'Rebate Type', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 5, 'Cust Type', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 6, 'Customer ID', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 7, 'End User ID ', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 8, 'Item No', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 9, 'Rebate Amount', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 10, 'Rebate Type', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDetail()
    begin
        RowNo += 1;
        EnterCell(RowNo, 1, FORMAT("Rebate Program Header"."Rebate No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 2, FORMAT("Rebate Program Header"."Start Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        EnterCell(RowNo, 3, FORMAT("Rebate Program Header"."End Date"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        EnterCell(RowNo, 4, FORMAT("Rebate Program Header"."Rebate Type"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 5, FORMAT("Rebate Program Header"."Customer Type"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 6, FORMAT("Rebate Program Header"."No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 7, EndUserId, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 8, FORMAT("Rebate Program Details"."Item No."), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        EnterCell(RowNo, 9, FORMAT("Rebate Program Details"."Rebate Amount"), FALSE, FALSE, FALSE, '#,##.00', TempExcelBuffer."Cell Type"::Number);
        EnterCell(RowNo, 10, FORMAT("Rebate Program Details"."Rebate Type"), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
    end;
}

