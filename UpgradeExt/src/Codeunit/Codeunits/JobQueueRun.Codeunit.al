codeunit 50008 "JobQueue - Run"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ManfSetup.GET();
        CASE REC."Parameter String" OF
            'DAILYPROD':
                DailyProduction();
            'DAILYPRODALL':
                DailyProductionAll();
            'PRODREPORT':
                ProdReport();
        END;
    end;

    var
        ManfSetup: Record "Manufacturing Setup";
        Subject: Text;


    procedure DailyProduction()
    var
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        DailyProduction: Report "Admin Daily/Mon Prod. Totals";
        TempBlob: codeunit "Temp Blob";
        Instr: InStream;
        OutStr: OutStream;

        FileName: Text[250];
    begin
        WorkCenter.RESET();
        IF WorkCenter.FINDFIRST() THEN BEGIN
            //WorkCenter.TESTFIELD("Distribution Email ID");
            WorkCenter.SETFILTER("Distribution Email ID", '<>%1', '');
            REPEAT
                FileName := 'C:\temp\DailyProduction_' + FORMAT(WorkCenter."No.") + '.pdf';
                CLEAR(DailyProduction);
                CLEAR(MachineCenter);
                MachineCenter.RESET();
                MachineCenter.SETRANGE("Work Center No.", WorkCenter."No.");
                IF MachineCenter.FINDFIRST() THEN BEGIN
                    DailyProduction.SETTABLEVIEW(MachineCenter);
                    DailyProduction.USEREQUESTPAGE(FALSE);
                    TempBlob.CreateOutStream(OutStr);
                    DailyProduction.SaveAs(FileName, ReportFormat::Pdf, OutStr);
                    TempBlob.CreateInStream(Instr);
                    //DailyProduction.SAVEASPDF(FileName);

                    Subject := FORMAT(WorkCenter."No.") + '_Daily Production';

                    //IF FILE.EXISTS(FileName) THEN
                    SendMail(FileName, Subject, WorkCenter."Distribution Email ID" + ';' + ManfSetup."Daily Production To EmailIDs", WorkCenter."No.", Instr);
                END;
            UNTIL WorkCenter.NEXT() = 0;
        END;
    end;

    procedure DailyProductionAll()
    var
    // FileName: Text;
    // Filemgt: Codeunit "File Management";
    // WorkCenter: Record "Work Center";
    // MachineCenter: Record "Machine Center";
    // DailyProduction: Report "Admin Daily/Mon Prod. Totals";
    // FromWC: Code[20];
    // ToWC: Code[20];
    begin
        /*
        WorkCenter.RESET;
        IF WorkCenter.FINDFIRST THEN
           FromWC := WorkCenter."No.";
        WorkCenter.RESET;
        IF WorkCenter.FINDLAST THEN
           ToWC := WorkCenter."No.";
        
        FileName :='C:\temp\DailyProduction_All_WC.pdf';
        CLEAR(DailyProduction);
        CLEAR(MachineCenter);
        MachineCenter.RESET;
        MachineCenter.SETRANGE("Work Center No.",FromWC,ToWC);
        IF MachineCenter.FINDFIRST THEN BEGIN
          DailyProduction.SETTABLEVIEW(MachineCenter);
          DailyProduction.USEREQUESTPAGE(FALSE);
          DailyProduction.SAVEASPDF(FileName);
        
          Subject := 'AllWC_Daily Production';
          IF FILE.EXISTS(FileName) THEN
            SendMailAll(FileName,Subject,ManfSetup."Daily Production To EmailIDs");
        END;
        */

    end;


    procedure SendMail(FileName: Text; Subject: Text; ToEmailIDs: Text; LWorkCenter: Code[20]; Instr: InStream)
    var
        // SMTPMail: Codeunit 400;
        // FileIO: DotNet File;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        CR: Char;
    begin
        CR := 13;
        ManfSetup.TESTFIELD("Daily Production From Email ID");
        // SMTPMail.CreateMessage('CROWN POLY', ManfSetup."Daily Production From Email ID", ToEmailIDs, Subject, '', TRUE);

        // IF LWorkCenter = '' THEN
        //     SMTPMail.AppendBody('All Workcenters')
        // ELSE
        //     SMTPMail.AppendBody('Workcenter: ' + FORMAT(LWorkCenter));
        // IF FileName <> '' THEN
        //     SMTPMail.AddAttachment(FileName);
        // SMTPMail.Send;

        // IF FileName <> '' THEN
        //     FileIO.Delete(FileName);

        EmailMessage.Create(ToEmailIDs, Subject, '');
        IF LWorkCenter = '' THEN
            EmailMessage.AppendToBody('All Workcenters')
        ELSE
            EmailMessage.AppendToBody('Workcenter: ' + FORMAT(LWorkCenter));
        IF FileName <> '' THEN
            EmailMessage.AddAttachment(FileName, 'PDF', Instr);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    procedure SendMailAll(FileName: Text; Subject: Text; ToEmailIDs: Text)
    var
        //CR: Char;
        // SMTPMail: Codeunit 400;
        // FileIO: DotNet File;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        // CR := 13;
        // ManfSetup.TESTFIELD("Daily Production From Email ID");
        // SMTPMail.CreateMessage('CROWN POLY', ManfSetup."Daily Production From Email ID", ToEmailIDs, Subject, '', TRUE);

        // SMTPMail.AppendBody('All Workcenters');
        // IF FileName <> '' THEN
        //     SMTPMail.AddAttachment(FileName);
        // SMTPMail.Send;

        // IF FileName <> '' THEN
        //     FileIO.Delete(FileName);

        EmailMessage.Create(ManfSetup."Daily Production From Email ID", Subject, ToEmailIDs);
        EmailMessage.AppendToBody('All Workcenters');
        IF FileName <> '' THEN
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    procedure ProdReport()
    var
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        ShiftCalendar: Record "Shift Calendar";
        ProductionReport: Report "Production Report 4";
        TempBlob: codeunit "Temp Blob";
        FileName: Text;
        Instr: InStream;
        OutStr: OutStream;
    begin
        WorkCenter.RESET();
        IF WorkCenter.FINDFIRST() THEN BEGIN
            WorkCenter.TESTFIELD("Distribution Email ID");
            WorkCenter.SETFILTER("Distribution Email ID", '<>%1', '');
            REPEAT
                ShiftCalendar.RESET();
                ShiftCalendar.SETRANGE(ProdDate, CALCDATE('<-1D>', TODAY));
                IF ShiftCalendar.FindSet() THEN
                    REPEAT
                        FileName := 'C:\temp\ProductionReport_' + FORMAT(WorkCenter."No.") + '_' + FORMAT(ShiftCalendar.Shift) + '.pdf';
                        CLEAR(ProductionReport);
                        CLEAR(MachineCenter);
                        MachineCenter.RESET();
                        MachineCenter.SETRANGE("Work Center No.", WorkCenter."No.");
                        IF MachineCenter.FINDFIRST() THEN BEGIN
                            ProductionReport.SETTABLEVIEW(MachineCenter);
                            ProductionReport.InitParameters(ShiftCalendar.Shift, ShiftCalendar.ProdDate, WorkCenter."No.");
                            ProductionReport.USEREQUESTPAGE(FALSE);
                            TempBlob.CreateOutStream(OutStr);
                            ProductionReport.SaveAs(FileName, ReportFormat::Pdf, OutStr);
                            TempBlob.CreateInStream(Instr);
                            //ProductionReport.SAVEASPDF(FileName);

                            Subject := FORMAT(WorkCenter."No.") + '_Shift' + FORMAT(ShiftCalendar.Shift) + '_ProductionReport';
                            if FileName <> '' then
                                SendMail(FileName, Subject, WorkCenter."Distribution Email ID", WorkCenter."No.", Instr);
                        END;
                    UNTIL ShiftCalendar.NEXT() = 0;
            UNTIL WorkCenter.NEXT() = 0;
        END;
    end;
}

