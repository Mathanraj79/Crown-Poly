page 50085 "Import Data from Excel"
{
    PageType = Card;
    SourceTable = Integer;
    SourceTableView = WHERE(Number = CONST(1));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Import)
            {
                Caption = 'Import';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("50000 Pricing")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50000 Pricing';
                ToolTip = 'Executes the 50000 Pricing action.';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Pricing" data?') THEN
                        REPORT.RUNMODAL(50085, TRUE, FALSE)
                end;
            }
            action("50002 Rebate Program Header")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50002 Rebate Program Header';
                ToolTip = 'Executes the 50002 Rebate Program Header action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Rebate Program Header" data?') THEN
                        REPORT.RUNMODAL(50086, TRUE, FALSE)
                end;
            }
            action("50003 Rebate Program Details")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50003 Rebate Program Details';
                ToolTip = 'Executes the 50003 Rebate Program Details action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Rebate Program Details" data?') THEN
                        REPORT.RUNMODAL(50087, TRUE, FALSE)

                end;
            }
            action("50004 End User")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50004 End User';
                ToolTip = 'Executes the 50004 End User action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "End User" data?') THEN
                        REPORT.RUNMODAL(50088, TRUE, FALSE)
                end;
            }
            action("50005 Report Incidents")
            {
                Image = "Report";
                PromotedCategory = Process;
                Promoted = true;
                Caption = '50005 Report Incidents';
                ToolTip = 'Executes the 50005 Report Incidents action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Report Incidents" data?') THEN
                        REPORT.RUNMODAL(50089, TRUE, FALSE)
                end;
            }
            action("50006 Incidents")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50006 Incidents';
                ToolTip = 'Executes the 50006 Incidents action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Incidents" data?') THEN
                        REPORT.RUNMODAL(50090, TRUE, FALSE)
                end;
            }
            action("50007 Rebate Program-End User")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50007 Rebate Program-End User';
                ToolTip = 'Executes the 50007 Rebate Program-End User action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Rebate Program - End User" data?') THEN
                        REPORT.RUNMODAL(50091, TRUE, FALSE)

                end;
            }
            action("50008 Rebate Claims")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50008 Rebate Claims';
                ToolTip = 'Executes the 50008 Rebate Claims action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Rebate Claims" data?') THEN
                        REPORT.RUNMODAL(50092, TRUE, FALSE)
                end;
            }
            action("50009 Item Location Min/Max")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50009 Item Location Min/Max';
                ToolTip = 'Executes the 50009 Item Location Min/Max action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Item Location Min/MAX" data?') THEN
                        REPORT.RUNMODAL(50093, TRUE, FALSE)
                end;
            }
            action("50016 Net Price")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50016 Net Price';
                ToolTip = 'Executes the 50016 Net Price action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Net Price" data?') THEN
                        REPORT.RUNMODAL(50094, TRUE, FALSE)
                end;
            }
            action("50019 Total Net Price")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50019 Total Net Price';
                ToolTip = 'Executes the 50019 Total Net Price action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Total Net Price" data?') THEN
                        REPORT.RUNMODAL(50095, TRUE, FALSE)

                end;
            }
            action("50021 Sales Commision Setup")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50021 Sales Commision Setup';
                ToolTip = 'Executes the 50021 Sales Commision Setup action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Sales Commision Setup" data?') THEN
                        REPORT.RUNMODAL(50096, TRUE, FALSE)
                end;
            }
            action("50030 Rebate Ledger Entries")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50030 Rebate Ledger Entries';
                ToolTip = 'Executes the 50030 Rebate Ledger Entries action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Rebate Ledger Entries" data?') THEN
                        REPORT.RUNMODAL(50097, TRUE, FALSE)
                end;
            }
            action("50038 Monthly Goal")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '50038 Monthly Goal';
                ToolTip = 'Executes the 50038 Monthly Goal action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Monthly Goal" data?') THEN
                        REPORT.RUNMODAL(50098, TRUE, FALSE)
                end;
            }
            action("232 Gen. Journal Batch")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '232 Gen. Journal Batch';
                ToolTip = 'Executes the 232 Gen. Journal Batch action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Gen. Journal Batch" data?') THEN
                        REPORT.RUNMODAL(50099, TRUE, FALSE)
                end;
            }
            action("233 Item Journal Batch")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '233 Item Journal Batch';
                ToolTip = 'Executes the 233 Item Journal Batch action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Item Journal Batch" data?') THEN
                        REPORT.RUNMODAL(50100, TRUE, FALSE)
                end;
            }
            action("99 Item Vendor")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '99 Item Vendor';
                ToolTip = 'Executes the 99 Item Vendor action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Item Vendor" data?') THEN
                        REPORT.RUNMODAL(50101, TRUE, FALSE)
                end;
            }
            action("90 BOM Component")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '90 BOM Component';
                ToolTip = 'Executes the 90 BOM Component action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "BOM Component" data?') THEN
                        REPORT.RUNMODAL(50102, TRUE, FALSE)
                end;
            }
            action("81 Gen. Journal Line")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '81 Gen. Journal Line';
                ToolTip = 'Executes the 81 Gen. Journal Line action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Gen. Journal Line" data?') THEN
                        REPORT.RUNMODAL(50103, TRUE, FALSE)
                end;
            }
            action("7012 Purchase Price")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                Caption = '7012 Purchase Price';
                ToolTip = 'Executes the 7012 Purchase Price action.';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure to import "Purchase Price" data?') THEN
                        REPORT.RUNMODAL(50104, TRUE, FALSE)
                end;
            }
        }
    }
}

