page 50049 "Item Tracking Line Bins"
{
    // SSC56 - new object

    AutoSplitKey = true;
    Caption = 'Item Tracking Line Bins';
    DataCaptionFields = "Item No.", "Location Code";
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "Item Tracking Line Bin";
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Item No."; TrackingSpecificationSource."Item No.")
                {
                    Caption = 'Item No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the TrackingSpecificationSource field.';
                    ApplicationArea = All;
                }
                field("Serial No."; TrackingSpecificationSource."Serial No.")
                {
                    Caption = 'Serial No.';
                    Editable = false;
                    Visible = SerialNoVisible;
                    ToolTip = 'Specifies the value of the TrackingSpecificationSource field.';
                    ApplicationArea = All;
                }
                field("Lot No."; TrackingSpecificationSource."Lot No.")
                {
                    Caption = 'Lot No.';
                    Editable = false;
                    Visible = LotNoVisible;
                    ToolTip = 'Specifies the value of the TrackingSpecificationSource field.';
                    ApplicationArea = All;
                }
                field("Qty. to Handle (Base)1"; TrackingSpecificationSource."Qty. to Handle (Base)")
                {
                    Caption = 'Total Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ToolTip = 'Specifies the value of the TrackingSpecificationSource field.';
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                Caption = 'Group';
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    Caption = 'Zone Code';
                    ToolTip = 'Specifies the value of the Zone Code field.';
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                    ToolTip = 'Specifies the value of the Bin Code field.';
                    ApplicationArea = All;
                }
                field("Qty. to Handle (Base)"; Rec."Qty. to Handle (Base)")
                {
                    Caption = 'Qty. to Handle (Base)';
                    ToolTip = 'Specifies the value of the Qty. to Handle (Base) field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    trigger OnInit()
    begin
        LotNoVisible := TRUE;
        SerialNoVisible := TRUE;
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.TRANSFERFIELDS(TrackingSpecificationSource);
        Rec."Qty. to Handle (Base)" := 0;
    end;

    trigger OnOpenPage()
    begin
        IF TrackingSpecificationSource."Lot No." = '' THEN
            LotNoVisible := FALSE;
        IF TrackingSpecificationSource."Serial No." = '' THEN
            SerialNoVisible := FALSE;

        Rec.TransferFields(TrackingSpecificationSource);

        IF TempTrackingSpecificationBin.FINDSET() THEN
            REPEAT
                Rec := TempTrackingSpecificationBin;
                Rec.INSERT();
            UNTIL TempTrackingSpecificationBin.NEXT() = 0;

        Rec.SETRANGE("Entry No.", TrackingSpecificationSource."Entry No.");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CurrQty := 0;

        TempTrackingSpecificationBin.RESET();
        TempTrackingSpecificationBin.SETRANGE("Entry No.", Rec."Entry No.");
        TempTrackingSpecificationBin.DELETEALL();
        TempTrackingSpecificationBin.RESET();

        Rec.SETRANGE("Entry No.", TrackingSpecificationSource."Entry No.");
        IF Rec.FINDSET() THEN
            REPEAT
                TempTrackingSpecificationBin := Rec;
                IF NOT TempTrackingSpecificationBin.INSERT() THEN
                    TempTrackingSpecificationBin.MODIFY();
                CurrQty := CurrQty + Rec."Qty. to Handle (Base)";
            UNTIL Rec.NEXT() = 0;

        IF CurrQty > Rec."Quantity (Base)" THEN
            ERROR(Text002Lbl, Rec."Quantity (Base)");
    end;

    var
        TempTrackingSpecificationBin: Record "Item Tracking Line Bin" temporary;
        TrackingSpecificationSource: Record "Tracking Specification";
        CurrQty: Decimal;
        LotNoVisible: Boolean;
        SerialNoVisible: Boolean;
        Text001Lbl: Label 'Quantity must be %1.', Comment = '%1 Quantity';
        Text002Lbl: Label 'The total quantity must not be greater than %1.', Comment = '%1 Quantity';


    procedure SetSource(lTrackingSpecification: Record "Tracking Specification"; var lTrackingSpecificationBin: Record "Item Tracking Line Bin" temporary)
    begin
        TrackingSpecificationSource.COPY(lTrackingSpecification);

        IF lTrackingSpecificationBin.FINDSET() THEN
            REPEAT
                TempTrackingSpecificationBin := lTrackingSpecificationBin;
                TempTrackingSpecificationBin.INSERT();
            UNTIL lTrackingSpecificationBin.NEXT() = 0;
    end;

    procedure GetStorageBins(var TrackingSpecificationLineBin: Record "Item Tracking Line Bin" temporary)
    begin
        IF TempTrackingSpecificationBin.FINDSET() THEN BEGIN
            TrackingSpecificationLineBin.RESET();

            TrackingSpecificationLineBin.SETRANGE("Entry No.", Rec."Entry No.");
            TrackingSpecificationLineBin.DELETEALL();
            TrackingSpecificationLineBin.RESET();
            REPEAT
                TrackingSpecificationLineBin := TempTrackingSpecificationBin;
                IF NOT TrackingSpecificationLineBin.INSERT() THEN
                    TrackingSpecificationLineBin.MODIFY();
            UNTIL TempTrackingSpecificationBin.NEXT() = 0;
        END;
    end;
}

