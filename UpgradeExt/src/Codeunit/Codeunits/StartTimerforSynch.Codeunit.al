codeunit 50003 "Start Timer for Synch."
{
    SingleInstance = true;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        ValidateOutputJnl: Codeunit "Transfer Order";
        ValidateConsumpJnl: Codeunit "Validate Consumption Journal";
        ValidateScrap: Codeunit "Validate Scrap Journal";
    begin
        //For use with Job Queue
        CLEAR(ValidateScrap);
        CLEAR(ValidateOutputJnl);
        CLEAR(ValidateConsumpJnl);

        ValidateScrap.RUN();
        ValidateOutputJnl.RUN();
        ValidateConsumpJnl.RUN();

        COMMIT();
    end;


    procedure PostProduction()
    var
        ManufSetup: Record "Manufacturing Setup";
        ValidateOutputJnl: Codeunit "Transfer Order";
        ValidateConsumpJnl: Codeunit "Validate Consumption Journal";
        ValidateScrap: Codeunit "Validate Scrap Journal";
    begin
        //For use directly with NAS
        /*
        ManufSetup.GET;
        ManufSetup.TESTFIELD("Time Interval");
        
        ValidateConsumpJnl.RUN;
        ValidateOutputJnl.RUN;
        ValidateScrap.RUN;
        
        COMMIT;
        SLEEP(ManufSetup."Time Interval");
        */

    end;
}

