namespace BCAddinHub.SalesChart;

using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Receivables;

codeunit 50120 "Cust. Sales Chart Mgt."
{
    /// <summary>Builds the chart JSON with the sales (LCY) of the last 12 months incl. the current one.</summary>
    procedure BuildChartJson(CustomerNo: Code[20]): Text
    var
        GLSetup: Record "General Ledger Setup";
        Root: JsonObject;
        Points: JsonArray;
        Point: JsonObject;
        MonthStart: Date;
        i: Integer;
        Result: Text;
    begin
        GLSetup.Get();
        MonthStart := CalcDate('<-CM-11M>', WorkDate());

        for i := 1 to 12 do begin
            Clear(Point);
            Point.Add('key', Format(MonthStart, 0, 9));
            Point.Add('label', Format(MonthStart, 0, '<Month Text,3> <Year>'));
            Point.Add('value', GetSales(CustomerNo, MonthStart, CalcDate('<CM>', MonthStart)));
            Points.Add(Point);
            MonthStart := CalcDate('<1M>', MonthStart);
        end;

        Root.Add('title', SalesLast12MonthsLbl);
        Root.Add('currency', GLSetup."LCY Code");
        Root.Add('points', Points);
        Root.WriteTo(Result);
        exit(Result);
    end;

    /// <summary>Opens the customer ledger entries of the month that was clicked.</summary>
    procedure DrillDown(CustomerNo: Code[20]; MonthKey: Text)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        MonthStart: Date;
    begin
        if not Evaluate(MonthStart, MonthKey, 9) then
            exit;
        CustLedgerEntry.SetRange("Customer No.", CustomerNo);
        CustLedgerEntry.SetRange("Posting Date", MonthStart, CalcDate('<CM>', MonthStart));
        Page.Run(Page::"Customer Ledger Entries", CustLedgerEntry);
    end;

    local procedure GetSales(CustomerNo: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.SetRange("Customer No.", CustomerNo);
        CustLedgerEntry.SetRange("Posting Date", FromDate, ToDate);
        CustLedgerEntry.CalcSums("Sales (LCY)");
        exit(CustLedgerEntry."Sales (LCY)");
    end;

    var
        SalesLast12MonthsLbl: Label 'Sales, last 12 months';
}
