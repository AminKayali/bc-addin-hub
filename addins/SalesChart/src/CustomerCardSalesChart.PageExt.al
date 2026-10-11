namespace BCAddinHub.SalesChart;

using Microsoft.Sales.Customer;

pageextension 50120 "Customer Card Sales Chart" extends "Customer Card"
{
    layout
    {
        addfirst(factboxes)
        {
            part(CustSalesChart; "Cust. Sales Chart FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
