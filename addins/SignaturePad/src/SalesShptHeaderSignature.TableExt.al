namespace BCAddinHub.SignaturePad;

using Microsoft.Sales.History;

tableextension 50110 "Sales Shpt. Header Signature" extends "Sales Shipment Header"
{
    fields
    {
        field(50110; "Signature"; Media)
        {
            Caption = 'Signature';
            DataClassification = CustomerContent;
        }
        field(50111; "Signed By"; Text[100])
        {
            Caption = 'Signed By';
            DataClassification = CustomerContent;
        }
        field(50112; "Signed At"; DateTime)
        {
            Caption = 'Signed At';
            DataClassification = CustomerContent;
        }
    }
}
