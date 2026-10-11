namespace BCAddinHub.SignaturePad;

using Microsoft.Sales.History;

page 50110 "Signature Dialog"
{
    PageType = Card;
    Caption = 'Capture Signature';
    SourceTable = "Sales Shipment Header";
    InsertAllowed = false;
    DeleteAllowed = false;
    DataCaptionFields = "No.", "Sell-to Customer Name";

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field(SignedBy; SignedBy)
                {
                    ApplicationArea = All;
                    Caption = 'Signed By';
                    ToolTip = 'Name of the person who signs the delivery.';
                }
            }
            usercontrol(SignaturePad; SignaturePad)
            {
                ApplicationArea = All;

                trigger ControlReady()
                begin
                    CurrPage.SignaturePad.SetLabels(ClearLbl, SaveLbl, HintLbl);
                end;

                trigger SignatureSaved(Base64Png: Text)
                var
                    SignatureMgt: Codeunit "Signature Mgt.";
                begin
                    SignatureMgt.SaveShipmentSignature(Rec."No.", Base64Png, SignedBy);
                    Message(SavedMsg);
                    CurrPage.Close();
                end;

                trigger SignatureEmpty()
                begin
                    Message(EmptyMsg);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SignedBy := Rec."Signed By";
    end;

    var
        SignedBy: Text[100];
        ClearLbl: Label 'Clear';
        SaveLbl: Label 'Save';
        HintLbl: Label 'Sign here';
        SavedMsg: Label 'The signature has been saved.';
        EmptyMsg: Label 'Please sign before saving.';
}
