reportextension 50007 "CP G/L Register" extends "G/L Register"
{
    RDLCLayout = 'src\Report\Layout\GLRegister.rdl';
    dataset
    {
        add("G/L Entry")
        {
            column(DivisionCode; "Global Dimension 1 Code") { }
        }

    }
}
