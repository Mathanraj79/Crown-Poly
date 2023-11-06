pageextension 50168 Zones extends Zones
{
    layout
    {
        addafter("Bin Type Code")
        {
            field("Storage Zone"; Rec."Storage Zone")
            {
                ApplicationArea = all;
            }
        }
    }
}
