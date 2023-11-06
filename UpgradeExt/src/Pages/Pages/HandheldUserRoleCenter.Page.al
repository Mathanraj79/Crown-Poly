page 50004 "Handheld User Role Center"
{
    Caption = 'Handheld User Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group("Welcome!")
            {
                Caption = 'Welcome!';
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Main Menu")
            {
                Caption = 'Main Menu';
                Image = Sales;
                RunObject = Page "Mini Screen - Main Menu";
                ToolTip = 'Executes the Main Menu action.';
                ApplicationArea = All;
            }
        }
    }
}

