namespace BCAddinHub.TrafficLight;

using Microsoft.Sales.Document;

page 50100 "Order Traffic Light FactBox"
{
    PageType = CardPart;
    SourceTable = "Sales Header";
    Caption = 'Delivery Status';
    Editable = false;

    layout
    {
        area(Content)
        {
            usercontrol(TrafficLight; TrafficLight)
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    IsReady := true;
                    UpdateLight();
                end;

                trigger LightClicked(Status: Text)
                var
                    SalesLine: Record "Sales Line";
                begin
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetFilter("Outstanding Quantity", '<>0');
                    Page.Run(Page::"Sales Lines", SalesLine);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateLight();
    end;

    local procedure UpdateLight()
    var
        TrafficLightMgt: Codeunit "Order Traffic Light Mgt.";
        Status: Text;
        Caption: Text;
    begin
        // Never call the add-in before ControlReady has fired.
        if not IsReady then
            exit;
        Status := TrafficLightMgt.GetStatus(Rec, Caption);
        CurrPage.TrafficLight.SetStatus(Status, Caption);
    end;

    var
        IsReady: Boolean;
}
