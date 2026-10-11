namespace BCAddinHub.SignaturePad;

using Microsoft.Sales.History;
using System.Text;
using System.Utilities;

codeunit 50110 "Signature Mgt."
{
    Permissions = tabledata "Sales Shipment Header" = rm;

    procedure SaveShipmentSignature(ShipmentNo: Code[20]; Base64Png: Text; SignedBy: Text[100])
    var
        SalesShptHeader: Record "Sales Shipment Header";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
    begin
        if SignedBy = '' then
            Error(SignedByMissingErr);

        TempBlob.CreateOutStream(OutStr);
        Base64Convert.FromBase64(Base64Png, OutStr);
        TempBlob.CreateInStream(InStr);

        SalesShptHeader.Get(ShipmentNo);
        SalesShptHeader.Signature.ImportStream(InStr, StrSubstNo(SignatureDescTxt, ShipmentNo), 'image/png');
        SalesShptHeader."Signed By" := SignedBy;
        SalesShptHeader."Signed At" := CurrentDateTime();
        SalesShptHeader.Modify();
    end;

    var
        SignedByMissingErr: Label 'Please enter the name of the person signing.';
        SignatureDescTxt: Label 'Signature shipment %1', Comment = '%1 = Shipment No.';
}
