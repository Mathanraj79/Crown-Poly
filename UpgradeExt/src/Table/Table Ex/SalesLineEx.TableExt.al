tableextension 50011 SalesLineEx extends "Sales Line"
{
    fields
    {
        field(50000; "Resin Unit Cost"; Decimal)
        {
            Caption = 'Resin Unit Cost';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Unit Cost" := "Resin Unit Cost";
                VALIDATE("Unit Cost");
                //SCSML END
            END;
        }
        field(50001; "Resin Unit Price"; Decimal)
        {
            Caption = 'Resin Unit Price';
            DataClassification = CustomerContent;
            Description = 'SCSML';
            trigger OnValidate()
            begin
                //SCSML BEGIN
                "Unit Price" := "Resin Unit Price";
                VALIDATE("Unit Price");
                //SCSML END
            END;
        }
        field(50004; "Item Type"; Option)
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
            OptionMembers = "Hippo Sak","Pull n Pak","Strip Rolls","Master Rolls","Trash Bag","Reusable Bag";
            Description = 'SCSEL 07-17-07';
        }
        field(50005; "Zero Price"; Boolean)
        {
            Caption = 'Zero Price ';
            DataClassification = CustomerContent;
            Description = 'SCSSM01';
        }
        field(50010; "Est. Shipment Date"; Date)
        {
            Caption = 'Est. Shipment Date';
            DataClassification = CustomerContent;
            Description = 'SCSFN 110507';
        }
        field(50015; "Bags per Case"; Integer)
        {
            Caption = 'Bags per Case';
            DataClassification = CustomerContent;
            Description = 'SCSEL 121907';
        }
        field(50016; "Bags Count"; Decimal)
        {
            Caption = 'Bags Count';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'SCSEL 121907';
        }
        field(70000; "PostingDate"; Date)
        {
            Caption = 'Posting Date';
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            begin
                //scssm01 begin
                GetSalesHeader();
                "Est. Shipment Date" := SalesHeader."Shipment Date";
                //scssm01 end
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                "Bags Count" := Quantity * "Bags per Case";  //SCSEL 12-19-07

                //SCSNP BEGIN
                IF (Quantity <> xRec.Quantity) AND (xRec.Quantity <> 0) THEN BEGIN
                    Salesheader1.GET("Document Type", "Document No.");
                    Salesheader1."Last Updated By" := USERID();
                    Salesheader1."Updated Date/Time" := CURRENTDATETIME;
                    Salesheader1.MODIFY();
                END;
                //SCSNP END
            end;
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                IF "Unit Price" = 0 THEN
                    "Zero Price" := TRUE
                ELSE
                    "Zero Price" := FALSE;

                //SCSNP BEGIN
                IF ("Unit Price" <> xRec."Unit Price") AND (xRec."Unit Price" <> 0) THEN BEGIN
                    Salesheader1.GET("Document Type", "Document No.");
                    Salesheader1."Last Updated By" := USERID();
                    Salesheader1."Updated Date/Time" := CURRENTDATETIME;
                    Salesheader1.MODIFY();
                END;
            end;
        }

    }

    keys
    {
        key(key22; "Document Type", "Document No.", Type, "No.") { }
        key(key23; "Document Type", "Shipment Date") { }
        key(key24; "Document Type", Type, "Location Code", "No.", "Planned Shipment Date") { }
        key(key25; "Document Type", Type, "Planned Shipment Date", "No.") { }
        key(key26; "Document Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shipment Date") { }
    }
    var
        SalesHeader: record "Sales Header";
        Salesheader1: Record "Sales Header";

    trigger OnAfterInsert()
    begin
        //BusSnapShot
        GetSalesHeader();
        "Posting Date" := SalesHeader."Posting Date";
        //end BUSS

        "Est. Shipment Date" := SalesHeader."Shipment Date"; //SCSFN 110507
    end;

}
