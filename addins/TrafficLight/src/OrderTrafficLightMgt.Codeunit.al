namespace BCAddinHub.TrafficLight;

using Microsoft.Sales.Document;

codeunit 50100 "Order Traffic Light Mgt."
{
    procedure GetStatus(SalesHeader: Record "Sales Header"; var Caption: Text): Text
    var
        SalesLine: Record "Sales Line";
        HasOutstanding: Boolean;
        IsOverdue: Boolean;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("Outstanding Quantity", '<>0');
        SalesLine.SetLoadFields("Shipment Date");
        if SalesLine.FindSet() then
            repeat
                HasOutstanding := true;
                if (SalesLine."Shipment Date" <> 0D) and (SalesLine."Shipment Date" < WorkDate()) then
                    IsOverdue := true;
            until (SalesLine.Next() = 0) or IsOverdue;

        case true of
            IsOverdue:
                begin
                    Caption := OverdueLbl;
                    exit('red');
                end;
            HasOutstanding:
                begin
                    Caption := OpenLbl;
                    exit('yellow');
                end;
            else begin
                Caption := ShippedLbl;
                exit('green');
            end;
        end;
    end;

    var
        OverdueLbl: Label 'Delivery overdue';
        OpenLbl: Label 'Open quantities, on schedule';
        ShippedLbl: Label 'Fully shipped';
}
