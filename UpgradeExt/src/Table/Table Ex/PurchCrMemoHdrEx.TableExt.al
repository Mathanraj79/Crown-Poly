tableextension 50028 "Purch.Cr.Memo Hdr.Ex" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50006; "Amount Approved"; Decimal)
        {
            Caption = 'Amount Approved';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50007; "Receiving Approval"; Code[10])
        {
            Caption = 'Receiving Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50008; "Previous Dept Approval"; Code[10])
        {
            Caption = 'Previous Dept Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50009; "Previous Exec. Approval"; Code[10])
        {
            Caption = 'Previous Exec. Approval';
            DataClassification = CustomerContent;
            Description = 'SCSML';
        }
        field(50010; "F.O.B."; Code[20])
        {
            Caption = 'F.O.B.';
            TableRelation = FOB;
            Description = 'SCSML';
            DataClassification = CustomerContent;
        }
    }
}
