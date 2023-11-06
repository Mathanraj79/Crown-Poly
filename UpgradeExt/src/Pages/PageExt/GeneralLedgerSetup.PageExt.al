pageextension 50124 "General Ledger Setup" extends "General Ledger Setup"
{

    layout
    {
        addafter("Max. Payment Tolerance Amount")
        {

        }
        addafter("PAC Environment")
        {
            group("Rebates")
            {
                CaptionML = ENU = 'Rebates',
                           ESM = 'Liquidaci¢n',
                           FRC = 'Affectation',
                           ENC = 'Application';

            }
        }
    }
}
