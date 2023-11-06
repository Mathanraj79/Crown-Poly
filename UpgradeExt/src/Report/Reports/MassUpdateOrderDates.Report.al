report 50023 "Mass Update Order Dates"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;
    Caption = 'Mass Update Order Dates';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Shipment Date";

            trigger OnAfterGetRecord()
            var
                OrderStatusChanged: Boolean;
            begin
                CLEAR(OrderStatusChanged);
                "Sales Header".SetHideValidationDialog(TRUE);
                IF Status = Status::Released THEN BEGIN
                    OrderStatusChanged := TRUE;
                    Status := Status::Open;
                END;

                "Posting Date" := NewDate;
                "Shipment Date" := NewDate;
                VALIDATE("Document Date", NewDate);

                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        SalesLine.SetHideValidationDialog(TRUE);
                        SalesLine."Shipment Date" := NewDate;
                        SalesLine."Planned Shipment Date" := SalesLine.CalcPlannedShptDate(FIELDNO("Shipment Date"));
                        SalesLine."Planned Delivery Date" := SalesLine.CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
                        SalesLine."Est. Shipment Date" := "Shipment Date";
                        SalesLine.MODIFY();
                    UNTIL SalesLine.NEXT() = 0;

                IF OrderStatusChanged THEN
                    Status := Status::Released;
                MODIFY();
                OrderCount += 1;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Posting Date and Shipment Date has been updated for %1 Sales Orders', OrderCount);
            end;

            trigger OnPreDataItem()
            begin
                IF GETFILTER("Shipment Date") = '' THEN
                    ERROR('Please enter Shipment Date filter.');

                IF NewDate = 0D THEN
                    ERROR('Please enter New Date Value.');

                OrderCount := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("New Date"; NewDate)
                    {
                        ToolTip = 'Specifies the value of the NewDate field.';
                        caption = 'NewDate';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesLine: Record "Sales Line";
        OrderCount: Integer;
        NewDate: Date;
}

