namespace BCAddinHub.SalesChart;

using Microsoft.Sales.Customer;

page 50120 "Cust. Sales Chart FactBox"
{
    PageType = CardPart;
    SourceTable = Customer;
    Caption = 'Sales Trend';
    Editable = false;

    layout
    {
        area(Content)
        {
            usercontrol(SalesChart; SalesChart)
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    IsReady := true;
                    UpdateChart();
                end;

                trigger BarClicked("Key": Text)
                var
                    ChartMgt: Codeunit "Cust. Sales Chart Mgt.";
                begin
                    ChartMgt.DrillDown(Rec."No.", "Key");
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateChart();
    end;

    local procedure UpdateChart()
    var
        ChartMgt: Codeunit "Cust. Sales Chart Mgt.";
    begin
        if not IsReady then
            exit;
        // Avoid recalculating when the same customer is shown again.
        if Rec."No." = LastCustomerNo then
            exit;
        LastCustomerNo := Rec."No.";
        CurrPage.SalesChart.Render(ChartMgt.BuildChartJson(Rec."No."));
    end;

    var
        IsReady: Boolean;
        LastCustomerNo: Code[20];
}
