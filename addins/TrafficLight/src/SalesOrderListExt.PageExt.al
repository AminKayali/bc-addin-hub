namespace BCAddinHub.TrafficLight;

using Microsoft.Sales.Document;

pageextension 50100 "Sales Order List Traffic Light" extends "Sales Order List"
{
    layout
    {
        addfirst(factboxes)
        {
            part(OrderTrafficLight; "Order Traffic Light FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
        }
    }
}
