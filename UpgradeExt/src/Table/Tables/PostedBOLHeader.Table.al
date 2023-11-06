table 50024 "Posted BOL Header"
{
    // ----------------------------------------------------------------------------------------------
    // ---------------------------------------------IWEB ETC.----------------------------------------
    // ----------------------------------------------------------------------------------------------
    // CODE    DATE          DEV               COMMENT
    // ----------------------------------------------------------------------------------------------
    // 001     04.08.16      IWEB.DJ           Field length increased from 30 to 50 ("Ship-To Contact","Shipper Contact")

    Caption = 'Posted BOL Header';
    DataClassification = CustomerContent;
    //LookupPageID = 50024;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(3; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(5; "BOL Date"; Date)
        {
            Caption = 'BOL Date';
        }
        field(6; "PU Date"; Date)
        {
            Caption = 'PU Date';
        }
        field(7; SCAC; Code[10])
        {
            Caption = 'SCAC';
            TableRelation = "Shipping Agent".Code;
        }
        field(11; "Shipper Name"; Text[50])
        {
            Caption = 'Shipper Name';
        }
        field(12; "Shipper Address"; Text[50])
        {
            Caption = 'Shipper Address';
        }
        field(13; "Shipper Address 2"; Text[50])
        {
            Caption = 'Shipper Address 2';
        }
        field(14; "Shipper City"; Text[50])
        {
            Caption = 'Shipper City';
        }
        field(15; "Shipper State"; Code[20])
        {
            Caption = 'Shipper State';
        }
        field(16; "Shipper Post Code"; Code[20])
        {
            Caption = 'Shipper Post Code';
        }
        field(17; "Shipper Country"; Code[10])
        {
            Caption = 'Shipper Country';
        }
        field(18; "Shipper Phone No."; Code[20])
        {
            Caption = 'Shipper Phone No.';
        }
        field(19; "Shipper Contact"; Text[50])
        {
            Caption = 'Shipper Contact';
        }
        field(20; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(21; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(22; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(23; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(24; "Ship-to City"; Text[50])
        {
            Caption = 'Ship-to City';
        }
        field(25; "Ship-to State"; Code[20])
        {
            Caption = 'Ship-to State';
        }
        field(26; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
        }
        field(27; "Ship-to Country"; Code[10])
        {
            Caption = 'Ship-to Country';
        }
        field(28; "Ship-to Phone No."; Code[20])
        {
            Caption = 'Ship-to Phone No.';
        }
        field(29; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(30; Weight; Decimal)
        {
            Caption = 'Weight';
        }
        field(31; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';
            DecimalPlaces = 0 : 0;
        }
        field(32; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionCaption = ' , Collect, Prepaid, Third Party';
            OptionMembers = " "," Collect"," Prepaid"," Third Party";
        }
        field(33; "Shipper Code"; Code[20])
        {
            Caption = 'Shipper Code';
        }
        field(34; Notes; Text[50])
        {
            Caption = 'Notes';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

