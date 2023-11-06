tableextension 50006 VendorEx extends Vendor
{
    fields
    {
        field(50000; "Default G/L Account"; Code[20])
        {
            Caption = 'Default G/L Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Description = 'SCS1.1';
        }
        field(50001; "Address 3"; Text[50])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50002; Attention; Text[50])
        {
            Caption = 'Attention';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50003; "Attn. Phone No."; Code[20])
        {
            Caption = 'Attn. Phone No.';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50004; "Old Vendor No."; Code[30])
        {
            Caption = 'Old Vendor No.';
            DataClassification = CustomerContent;
        }
        field(50005; "Print Contact"; Text[50])
        {
            Caption = 'Print Contact';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50006; "Insurance Required"; Boolean)
        {
            Caption = 'Insurance Required';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50007; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            DataClassification = CustomerContent;
            TableRelation = FOB;
            Description = 'SCSML';
        }
        field(50009; "Use Remit-To Address"; Boolean)
        {
            Caption = 'Use Remit-To Address';
            DataClassification = CustomerContent;
            Description = 'DJS';
        }
        field(50010; "Remit-To Address"; Text[30])
        {
            Caption = 'Remit-To Address';
            DataClassification = CustomerContent;
            Description = 'DJS';
        }
        field(50011; "Remit-To Address 2"; Text[30])
        {
            Caption = 'Remit-To Address 2';
            DataClassification = CustomerContent;
            Description = 'DJS';
        }
        field(50012; "Remit-To City"; Text[30])
        {
            Caption = 'Remit-To City';
            DataClassification = CustomerContent;
            Description = 'DJS';
            ValidateTableRelation = false;
            // TestTableRelation = false;
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            trigger OnValidate()
            var
                PostCode: record "Post Code";
            begin
                PostCode.ValidateCity("Remit-To City", "Remit-To Post Code", "Remit-To County", "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50013; "Remit-To Post Code"; Code[20])
        {
            Caption = 'Remit-To Post Code';
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
            //TestTableRelation = false;
            Description = 'DJS';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            trigger OnValidate()
            var
                PostCode: record "Post Code";
            begin
                PostCode.ValidatePostCode("Remit-To City", "Remit-To Post Code", "Remit-To County", "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50014; "Remit-To County"; Text[30])
        {
            Caption = 'Remit-To County';
            DataClassification = CustomerContent;
            // ValidateTableRelation=false;
            //  TestTableRelation=false;
            Description = 'DJS';
        }
        field(50015; "Remit-to Name"; Text[30])
        {
            Caption = 'Remit-to Name';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
        field(50016; "Remit-to Name 2"; Text[30])
        {
            Caption = 'Remit-to Name 2';
            DataClassification = CustomerContent;
            Description = 'SCSFN';
        }
    }
}
