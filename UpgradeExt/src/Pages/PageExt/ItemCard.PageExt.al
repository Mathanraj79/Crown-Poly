pageextension 50107 "Item Card" extends "Item Card"
{
    layout
    {
        // addafter(Description)
        // {
        //     field("Description 2"; Rec."Description 2")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        addafter("Last Date Modified")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
        }
        modify("Unit Cost")
        {
            Visible = ResinEnable;
        }
        modify("Unit Price")
        {
            Visible = ResinEnable;

        }
        modify("Overhead Rate")
        {
            Visible = ResinEnable;
        }
        modify("Indirect Cost %")
        {
            Visible = ResinEnable;
        }
        modify("Last Direct Cost")
        {
            Visible = ResinEnable;
        }
        modify("Last Phys. Invt. Date")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = ResinEnable;
        }

    }
    actions
    {
        addafter("&Create Stockkeeping Unit")
        {
            action("Create Extended Text")
            {
                Image = CreateDocument;
                ApplicationArea = all;
                trigger OnAction()
                var
                    //  CreateExtText : Report 50016;
                    Itm: Record 27;
                begin
                    Itm.COPY(Rec);
                    Itm.SETRECFILTER();
                    //  CreateExtText.SETTABLEVIEW(Itm);
                    //  CreateExtText.USEREQUESTPAGE(FALSE);
                    //  CreateExtText.RUN;
                end;
            }
        }
        addbefore(History)
        {
            action("Item Location Min Max")
            {
                CaptionML = ENU = 'Item Location Min Max',
                                 ESM = 'Identificadores',
                                 FRC = 'Identificateurs',
                                 ENC = 'Identifiers';
                //   RunObject=Page 50002;
                //   RunPageLink=Item No.=FIELD(No.);
                Promoted = true;
                PromotedIsBig = true;
                Image = UnitOfMeasure;
                ApplicationArea = all;


            }

        }
        addbefore("&Bin Contents")
        {
            action("Storage Bins")
            {
                // RunObject=Page 50017;
                //  RunPageView=SORTING(Location Code,Zone Code,Bin Code,Item No.,Variant Code,Unit of Measure Code);
                // RunPageLink=Item No.=FIELD(No.);
                Image = BinContent;
                ApplicationArea = all;
            }
        }

    }

    var
        UserSetup: Record "User Setup";
        ResinEnable: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetResinEnable();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

    end;



    PROCEDURE SetResinEnable();
    BEGIN
        //SCSML New function to Enable/Disable Costing fields if Item is resin
        UserSetup.INIT();
        IF UserSetup.GET(USERID) THEN BEGIN
            // IF NOT UserSetup.Resin THEN BEGIN
            //   IF Resin THEN BEGIN
            ResinEnable := FALSE;
        END ELSE BEGIN
            ResinEnable := TRUE;
        END;
        // END ELSE BEGIN
        //   ResinEnable := TRUE;
    END;
    //   END;
    // END;
}
