table 50020 "Rebate Worksheet"
{
    Caption = 'Rebate Worksheet';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Rebate ID"; Code[20])
        {
            Caption = 'Rebate ID';
            TableRelation = "Rebate Program Header";
        }
        field(3; "Enduser ID"; Code[20])
        {
            Caption = 'Enduser ID';
            TableRelation = "End User";
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(5; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(6; "Total Rebate Amount"; Decimal)
        {
            Caption = 'Total Rebate Amount';
        }
        field(7; "Rebate Method"; Option)
        {
            Caption = 'Rebate Method';
            OptionCaption = 'Credit Memo,Check To End User';
            OptionMembers = "Credit Memo","Check To End User";
        }
        field(8; "Date Claimed"; Date)
        {
            Caption = 'Date Claimed';
        }
        field(9; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(10; "Rebate Ledg. No."; Integer)
        {
            Caption = 'Rebate Ledg. No.';
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(12; "Quantity Claimed"; Decimal)
        {
            Caption = 'Quantity Claimed';
        }
        field(13; "Rebate Amount"; Decimal)
        {
            Caption = 'Rebate Amount';
        }
        field(14; Consolidate; Boolean)
        {
            Caption = 'Consolidate';
        }
        field(15; "Do Not Consolidate"; Boolean)
        {
            Caption = 'Do Not Consolidate';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Rebate Method", Consolidate, "Customer No.", "Item No.")
        {
            SumIndexFields = "Quantity Claimed", "Total Rebate Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        rebateLedgerEntry: Record "Rebate Ledger Entries";
    begin
        IF rebateLedgerEntry.GET("Rebate Ledg. No.") THEN BEGIN
            rebateLedgerEntry.Exported := FALSE;
            rebateLedgerEntry.MODIFY();
        END;
    end;
}

