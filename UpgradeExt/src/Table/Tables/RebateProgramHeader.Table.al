table 50002 "Rebate Program Header"
{
    Caption = 'Rebate Program Header';
    DataClassification = CustomerContent;
    // DrillDownPageID = 50080;
    // LookupPageID = 50080;

    fields
    {
        field(1; "Rebate No."; Code[20])
        {
            Caption = 'Rebate No.';

            trigger OnValidate()
            begin
                IF "Rebate No." <> xRec."Rebate No." THEN BEGIN
                    GenLedgSetup.GET();
                    NoSeriesMgt.TestManual(GenLedgSetup."Rebate Nos.");
                END;
            end;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(4; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = Customer,"End User";

            trigger OnValidate()
            begin
                "No." := '';
            end;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Customer Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Customer Type" = FILTER("End User")) "End User";
        }
        field(6; "Rebate Type"; Option)
        {
            Caption = 'Rebate Type';
            OptionCaption = 'Instant Credit,Monthly,Quarterly,Annual';
            OptionMembers = "Instant Credit",Monthly,Quarterly,Annual;
        }
        field(7; "Rebate Method"; Option)
        {
            Caption = 'Rebate Method';
            OptionCaption = 'Credit Memo,Check';
            OptionMembers = "Credit Memo",Check;
        }
        field(8; Check; Boolean)
        {
            Caption = 'Check';
        }
    }

    keys
    {
        key(Key1; "Rebate No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Rebate No." = '' THEN BEGIN
            GenLedgSetup.GET();
            GenLedgSetup.TESTFIELD("Rebate Nos.");
            NoSeriesMgt.InitSeries(GenLedgSetup."Rebate Nos.", '', 0D, "Rebate No.", TextCode);
        END;
    end;

    var
        GenLedgSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TextCode: Code[10];

    procedure AssistEdit(OldRebate: Record "Rebate Program Header"): Boolean
    var
        RebatePHedr: Record "Rebate Program Header";
    begin
        RebatePHedr := Rec;
        GenLedgSetup.GET();
        GenLedgSetup.TESTFIELD("Rebate Nos.");
        IF NoSeriesMgt.SelectSeries(GenLedgSetup."Rebate Nos.", '', TextCode) THEN BEGIN
            NoSeriesMgt.SetSeries(RebatePHedr."Rebate No.");
            Rec := RebatePHedr;
            EXIT(TRUE);
        END;
    end;
}

