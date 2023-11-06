pageextension 50100 "General Ledger Entry" extends "General Ledger Entries"
{
    layout
    {
        moveafter("Document No."; "External Document No.")
        moveafter("External Document No."; "Source Type")
        moveafter("Source Type"; "Source No.")
        // moveafter(Description; "G/L")
        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }
    }
}
