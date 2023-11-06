tableextension 50010 SalesHeaderEx extends "Sales Header"
{
    fields
    {
        field(50000; "Override Pricing"; Boolean)
        {
            Caption = 'Override Pricing';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50001; "Freight Bills"; Decimal)
        {
            Caption = 'Freight Bills';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50002; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50014; "BOL No."; Code[20])
        {
            Caption = 'BOL No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("BOL Order"."BOL No." WHERE("Order No." = FIELD("No.")));
            Description = 'SCSFN';
            Editable = false;
        }
        field(50015; "Salesperson 2"; Code[20])
        {
            Caption = 'Salesperson 2';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            Description = 'SCSFN';
        }
        field(50016; "Broker 1"; Code[20])
        {
            Caption = 'Broker 1';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            Description = 'SCSFN';
        }
        field(50017; "Broker 2"; Code[20])
        {
            Caption = 'Broker 2';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            Description = 'SCSFN';
        }
        field(50018; "Rebate Claim"; Boolean)
        {
            Caption = 'Rebate Claim';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50019; "Rebate Claim No."; Code[20])
        {
            Caption = 'Rebate Claim No.';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50020; Finalized; Boolean)
        {
            Caption = 'Finalized';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin

                //SCSNP BEGIN
                IF (Finalized <> xRec.Finalized) THEN BEGIN
                    "Last Updated By" := USERID();
                    "Updated Date/Time" := CURRENTDATETIME;
                END;
                //SCSNP END
            END;
        }
        field(50021; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50022; "Instant Rebates"; Boolean)
        {
            Caption = 'Instant Rebates';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50023; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50050; "Sales Order Printed"; Integer)
        {
            Caption = 'Sales Order Printed';
            DataClassification = CustomerContent;
            Description = 'SCSFN 110807';
            Editable = true;
        }
        field(50051; "Pick List Printed"; Integer)
        {
            Caption = 'Pick List Printed';
            DataClassification = CustomerContent;
            InitValue = 0;
            Description = 'SCSFN 110807';
            Editable = true;
        }
        field(75000; "Last Updated By"; Code[50])
        {
            Caption = 'Last Updated By';
            DataClassification = CustomerContent;
            TableRelation = User;
            Description = 'SCSNP';
            Editable = false;
        }
        field(75001; "Updated Date/Time"; DateTime)
        {
            Caption = 'Updated Date/Time';
            DataClassification = CustomerContent;
            Description = 'SCSNP';
            Editable = false;
        }
        modify("Sell-to Customer No.")
        {

            trigger OnAfterValidate()
            VAR
                recShiptoAdd: Record "Ship-to Address";
            begin
                //SCSFN
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    recShiptoAdd.RESET();
                    recShiptoAdd.SETRANGE("Customer No.", "Sell-to Customer No.");
                    recShiptoAdd.SETRANGE("Default Ship-to Address", TRUE);
                    IF recShiptoAdd.FindFirst()
                     THEN
                        VALIDATE("Ship-to Code", recShiptoAdd.Code);
                END;
                //SCSFN
            end;
        }
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            VAR
                Customer: Record Customer;
                AmountDue: Decimal;
                GracePeriodText: Text[50];
                DueDate: Date;
            begin
                //AV01 begin

                //SCS1.1
                IF "Bill-to Customer No." <> '' THEN   //SCSSM01 Added code
                    Customer.GET("Bill-to Customer No.")
                ELSE
                    Customer.GET("Sell-to Customer No.");//SCSSM01 Added code

                GLSetup.GET();
                AmountDue := 0;
                CustLedgEntry.RESET();
                CustLedgEntry.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date", "Currency Code");
                CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                CustLedgEntry.SETRANGE("Customer No.", "Bill-to Customer No.");
                CustLedgEntry.SETRANGE(Open, TRUE);
                IF CustLedgEntry.FINDSET() THEN
                    REPEAT
                        CLEAR(DueDate);
                        //SCSFN 011608 CALCULATE DUE DATE BASED ON DEFAULT TERMS GRACE PERIOD IF CUSTOMER GRACE PERIOD IS BLANK
                        GracePeriodText := '';
                        IF EVALUATE(GracePeriodText, FORMAT(Customer."Grace Period")) THEN;
                        IF GracePeriodText = '' THEN
                            DueDate := CALCDATE(GLSetup."Terms Grace Period", CustLedgEntry."Due Date")
                        ELSE
                            DueDate := CALCDATE(Customer."Grace Period", CustLedgEntry."Due Date");
                        //SCSFN 011608 END
                        IF DueDate < WORKDATE() THEN BEGIN
                            CustLedgEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            AmountDue += CustLedgEntry."Remaining Amt. (LCY)";
                            // DJSIM 20080828
                        END;
                    UNTIL CustLedgEntry.NEXT() = 0;

                //DJSIM 20080828 BEGIN
                IF AmountDue > GLSetup."OverDue Limit" THEN
                    "On Hold" := 'DUE';
                //DJSIM 20080828 END

                Customer.CALCFIELDS("Balance (LCY)");
                Customer.CALCFIELDS("Outstanding Orders (LCY)");
                AmountDue := ABS(Customer."Balance (LCY)") + ABS(Customer."Outstanding Orders (LCY)");
                IF Customer."Credit Limit (LCY)" < AmountDue THEN
                    "On Hold" := 'CRD';
                //SCS1.1
                //AV01 End 
            end;
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        SalesLine."Est. Shipment Date" := "Shipment Date";
                        SalesLine.MODIFY();
                    UNTIL SalesLine.NEXT() = 0;

                //SCSNP BEGIN
                IF ("Shipment Date" <> xRec."Shipment Date") AND (xRec."Shipment Date" <> 0D) THEN BEGIN
                    "Last Updated By" := USERID();
                    "Updated Date/Time" := CURRENTDATETIME;
                END;
                //SCSNP END
            end;
        }

        modify("On Hold")
        {
            trigger OnAfterValidate()
            begin
                //SCS1.1
                TESTFIELD(Status, Status::Open);
                UserSetup.GET(USERID);
                IF NOT UserSetup."Credit Manager" THEN
                    ERROR(CPText001Lbl);
                //SCS1.1
            end;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            begin
                //SCS1.1
                IF ("Document Type" = "Document Type"::Order) AND ("External Document No." <> '') THEN BEGIN
                    SalesHeader2.RESET();
                    SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
                    SalesHeader2.SETFILTER("No.", '<>%1', "No.");
                    SalesHeader2.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                    SalesHeader2.SETRANGE("External Document No.", "External Document No.");
                    IF SalesHeader2.FINDFIRST() THEN
                        MESSAGE(CPText002Lbl, SalesHeader2."No.");
                END;

                CustLedgEntry2.RESET();
                CustLedgEntry2.SETRANGE("Document Type", CustLedgEntry2."Document Type"::Invoice);
                CustLedgEntry2.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                CustLedgEntry2.SETRANGE("External Document No.", "External Document No.");
                IF CustLedgEntry2.FINDFIRST() THEN
                    MESSAGE(CPText003Lbl, CustLedgEntry2."Document No.");
                //SCS1.1

                //SCSNP BEGIN
                IF ("External Document No." <> xRec."External Document No.") AND (xRec."External Document No." <> '') THEN BEGIN
                    "Last Updated By" := USERID();
                    "Updated Date/Time" := CURRENTDATETIME;
                END;
                //SCSNP END
            END;
        }
        modify("Shipping Agent Code")
        {
            trigger OnAfterValidate()
            begin
                //SCSFN .01
                IF lCurrentStatus = lCurrentStatus::Released THEN
                    ReleaseDocument.RUN(Rec); //SCSFN
            end;
        }
        modify("Requested Delivery Date")
        {
            trigger OnAfterValidate()
            begin
                //SCSNP BEGIN
                IF ("Requested Delivery Date" <> xRec."Requested Delivery Date") AND (xRec."Requested Delivery Date" <> 0D) THEN BEGIN
                    "Last Updated By" := USERID();
                    "Updated Date/Time" := CURRENTDATETIME;
                END;
                //SCSNP END
            end;
        }
        modify("Shipping Time")
        {
            trigger OnBeforeValidate()
            begin
                //SCSFN .01
                lCurrentStatus := Status;
                IF Status = Status::Released THEN BEGIN
                    ReleaseDoc.SetIgnoreReviseOrderMail(TRUE);
                    ReleaseDocument.Reopen(Rec);
                END;
                //SCSFN
            end;

            trigger OnAfterValidate()
            var
                lCurrentStatus: Option "Open","Released";
            begin
                //SCSFN .01
                IF lCurrentStatus = lCurrentStatus::Released THEN
                    ReleaseDocument.RUN(Rec); //SCSFN
            end;
        }
        modify("Shipping Agent Service Code")
        {
            trigger OnBeforeValidate()
            begin
                //SCSFN .01
                lCurrentStatus := Status;
                IF Status = Status::Released THEN BEGIN
                    ReleaseDoc.SetIgnoreReviseOrderMail(TRUE);
                    ReleaseDocument.Reopen(Rec);
                END;
                //SCSFN
            end;

            trigger OnAfterValidate()
            begin
                //SCSFN .01
                IF lCurrentStatus = lCurrentStatus::Released THEN
                    ReleaseDocument.RUN(Rec); //SCSFN
            end;
        }

    }
    keys
    {
        key(key14; "Shipment Date") { }
    }

    var
        UserSetup: Record "User Setup";
        SalesTaxDifference: Record "Sales Tax Amount Difference";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: record "General Ledger Setup";
        SalesHeader2: Record "Sales Header";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        //BusST: Codeunit 14005085; 
        ReleaseDoc: Codeunit "Release Sales Document Ext";
        ReleaseDocument: codeunit "Release Sales Document";
        lCurrentStatus: Option "Open","Released";
        CPText001Lbl: Label 'ENU=You are not authorized to modify this field. Please Contact your Credit Manager!';
        CPText002Lbl: Label 'ENU=Warning: PO# already used on SO#: %1', Comment = '%1 = Document Type';
        CPText003Lbl: Label 'ENU=Warning: PO# already used on posted invoice#: %1', Comment = '%1 = Document Type';


    trigger OnAfterInsert()
    begin
        //BUSS
        // IF "Document Type" = "Document Type"::Quote THEN
        //     BusST.AddToQuoteTotal;   doubt
        //end

    end;

    PROCEDURE CustomPricing(NewSalesHeader: Record "Sales Header");
    VAR
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Pricing: Record Pricing;
        UnitPrice: Decimal;
        TotalOrderQty: Decimal;
        MostCombQty: Decimal;
    BEGIN
        //SCSML New function update Prices on Sales Lines
        TotalOrderQty := 0;
        SalesHeader.INIT();
        IF SalesHeader.GET(NewSalesHeader."Document Type", NewSalesHeader."No.") THEN BEGIN
            SalesLine.INIT();
            SalesLine.RESET();
            SalesLine.SETRANGE("Document Type", NewSalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", NewSalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            IF SalesLine.FINDSET() THEN
                REPEAT
                    TotalOrderQty += SalesLine.Quantity;
                UNTIL SalesLine.NEXT() = 0;

            SalesLine.INIT();
            SalesLine.RESET();
            SalesLine.SETRANGE("Document Type", NewSalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", NewSalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            IF SalesLine.FINDSET() THEN
                REPEAT
                    Pricing.INIT();
                    Pricing.RESET();
                    Pricing.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
                    Pricing.SETRANGE("Item No.", SalesLine."No.");
                    //Pricing.SETFILTER("Start Date",'<=%1',WORKDATE);
                    //Pricing.SETFILTER("End Date",'>%1|=%2',WORKDATE,0D);
                    Pricing.SETFILTER("Start Date", '<=%1', NewSalesHeader."Shipment Date");
                    Pricing.SETFILTER("End Date", '>%1|=%2', NewSalesHeader."Shipment Date", 0D);

                    Pricing.SETFILTER("Min. Qty", '<=%1', SalesLine.Quantity);
                    //Pricing.SETFILTER("Unit Price",'<>%1',0);
                    //   {IF "Shipment Method Code" = 'WILL CALL' THEN
                    //      Pricing.SETRANGE("Ship Via",Pricing."Ship Via"::"1")
                    //    ELSE
                    //      Pricing.SETRANGE("Ship Via",Pricing."Ship Via"::"0");}
                    Pricing.SETRANGE("Ship Via", NewSalesHeader."Shipment Method Code");
                    IF Pricing.FINDSET() THEN begin
                        UnitPrice := 0;
                        REPEAT
                            IF TotalOrderQty >= Pricing."Combined Minimum Qty." THEN BEGIN
                                IF (MostCombQty <= Pricing."Combined Minimum Qty.") OR (MostCombQty = 0) THEN
                                    MostCombQty := Pricing."Combined Minimum Qty.";
                                UnitPrice := Pricing."Unit Price";
                            END;
                        UNTIL Pricing.NEXT() = 0;
                        IF UnitPrice <> 0 THEN BEGIN
                            SalesLine."Unit Price" := UnitPrice;
                            SalesLine.VALIDATE(Quantity);
                            SalesLine.VALIDATE("Unit Price");
                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                            IF SalesLine."Line Amount" <> 0 THEN
                                SalesLine.VALIDATE("Line Amount");
                            SalesLine.MODIFY();
                        END;
                    END;
                UNTIL SalesLine.NEXT() = 0;
        END;
    END;


    PROCEDURE EmailShipping(ShippingEmail: Text[80]);
    VAR
        SalesHeader: Record "Sales Header";
        Filemgt: Codeunit "Mail Management";
        TempBlob: codeunit "Temp Blob";
        Email_: codeunit "Email Message";
        Email: codeunit Email;

        InStr: InStream;
        OuStr: OutStream;
        Filepath: Text[60];
        FileName: Text;
        EmailMessage: Text[250];
        Subject: Text[250];

    BEGIN
        EXIT; //SCS-Saro
        CLEAR(Email_);
        CLEAR(Subject);
        CLEAR(Filepath);
        Filepath := 'c:\';
        SalesHeader.RESET();
        SalesHeader.SETRANGE("Document Type", "Document Type");
        SalesHeader.SETRANGE("No.", "No.");
        IF SalesHeader.FIND('-') THEN BEGIN
            EmailMessage := 'Sales Order No.' + '  ' + SalesHeader."No." + ' has been changed.';
            Subject := 'Released Sales Order has been changed.';
            FileName := Filepath + FORMAT(SalesHeader."No.") + '.html';

            // IF EXISTS(FileName) THEN
            //     ERASE(FileName);
            // REPORT.SAVEASHTML(REPORT::"Sales Order Email", FileName, TRUE, SalesHeader);
            // mail.NewMessage(ShippingEmail, '', Subject, Email_, FileName, FALSE);
            // ERASE(FileName);

            TempBlob.CreateOutStream(OuStr);
            //Report.SaveAs(Report::"Sales Order Email", FileName, ReportFormat::Html, OuStr);
            TempBlob.CreateInStream(InStr);
            Email_.Create(ShippingEmail, Subject, '');
            Email_.AddAttachment(FileName, 'Html', InStr);
            Email.Send(Email_, Enum::"Email Scenario"::Default);

        END;
    END;

    PROCEDURE EmailCS(CSEmail: Text[80]);
    VAR
        SalesHeader: Record "Sales Header";
        TempBlob: codeunit "Temp Blob";
        Email_: codeunit "Email Message";
        Email: codeunit Email;

        Filepath: Text[60];
        FileName: Text[60];
        EMailMessage: Text[250];
        Subject: Text[250];
        InStr: InStream;
        OuStr: OutStream;
    BEGIN
        EXIT; //SCS-Saro
        Clear(EMailMessage);
        CLEAR(Subject);
        CLEAR(Filepath);
        Filepath := 'c:\';

        SalesHeader.RESET();
        SalesHeader.SETRANGE("Document Type", "Document Type");
        SalesHeader.SETRANGE("No.", "No.");
        IF SalesHeader.FIND('-') THEN BEGIN
            EMailMessage := 'Sales Order No.' + '  ' + SalesHeader."No." + ' credit hold has been removed.';
            Subject := 'Sales Order credit hold removed.';
            FileName := Filepath + FORMAT(SalesHeader."No.") + '.html';
            // IF EXISTS(FileName) THEN
            //     ERASE(FileName);
            // REPORT.SAVEASHTML(REPORT::"Sales Order Email", FileName, TRUE, SalesHeader);
            // mail.NewMessage(CSEmail, '', Subject, EMailMessage, FileName, FALSE);
            // ERASE(FileName);   //Doubt

            TempBlob.CreateOutStream(OuStr);
            // Report.SaveAs(Report::"Sales Order Email", FileName, ReportFormat::Html, OuStr);
            TempBlob.CreateInStream(InStr);
            Email_.Create(CSEmail, Subject, '');
            Email_.AddAttachment(FileName, 'Html', InStr);
            Email.Send(Email_, Enum::"Email Scenario"::Default);
        END;
    END;

    PROCEDURE "<SSC56 Functions>"();
    BEGIN
    END;

    PROCEDURE PostPickAndWhseShipment(VAR SalesHeader: Record "Sales Header");
    VAR
        WhseShptLine: Record "Warehouse Shipment Line";
        WhseActivityLine: Record "Warehouse Activity Line";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
        WMSMgt: Codeunit "WMS Management";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
    BEGIN
        // Post Pick
        WhseActivityLine.RESET();
        WhseActivityLine.SETRANGE("Activity Type", WhseActivityLine."Activity Type"::Pick);
        WhseActivityLine.SETRANGE("Source Type", 37);
        WhseActivityLine.SETRANGE("Source Subtype", SalesHeader."Document Type");
        WhseActivityLine.SETRANGE("Source No.", SalesHeader."No.");
        IF WhseActivityLine.FINDFIRST() THEN BEGIN
            WMSMgt.CheckBalanceQtyToHandle(WhseActivityLine);
            WhseActivityRegister.RUN(WhseActivityLine);
        END;

        // Post Whse. Shipment
        WhseShptLine.RESET();
        WhseShptLine.SETRANGE("Source Type", 37);
        WhseShptLine.SETRANGE("Source Subtype", SalesHeader."Document Type");
        WhseShptLine.SETRANGE("Source No.", SalesHeader."No.");
        IF WhseShptLine.FINDFIRST() THEN BEGIN
            WhsePostShipment.SetPostingSettings(FALSE);
            WhsePostShipment.SetPrint(FALSE);
            WhsePostShipment.RUN(WhseShptLine);
            WhsePostShipment.GetResultMessage();
        END;
    END;
}
