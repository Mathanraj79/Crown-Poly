reportextension 50001 "CP Suggest Vendor Payments" extends "Suggest Vendor Payments"
{
    dataset
    {
    }

    trigger OnPreReport()
    begin
        // BalAccType := BalAccType::"Bank Account";
        // BalAccNo := 'B030';                Doubt
    end;

    var
    // BalAccType: Enum "Gen. Journal Account Type";
    // BalAccNo : Code[20];
}
