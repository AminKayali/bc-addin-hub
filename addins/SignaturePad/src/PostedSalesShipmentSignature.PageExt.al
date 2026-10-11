namespace BCAddinHub.SignaturePad;

using Microsoft.Sales.History;

pageextension 50110 "Posted Sales Shpt. Signature" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Signed By"; Rec."Signed By")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies who signed the delivery.';
            }
            field("Signed At"; Rec."Signed At")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies when the delivery was signed.';
            }
            field(Signature; Rec.Signature)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the captured signature.';
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(CaptureSignature)
            {
                ApplicationArea = All;
                Caption = 'Capture Signature';
                Image = Edit;
                ToolTip = 'Let the recipient sign the delivery on screen, tablet or with a pen.';

                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                begin
                    SalesShptHeader.SetRange("No.", Rec."No.");
                    Page.RunModal(Page::"Signature Dialog", SalesShptHeader);
                    CurrPage.Update(false);
                end;
            }
        }
        addlast(Promoted)
        {
            actionref(CaptureSignature_Promoted; CaptureSignature) { }
        }
    }
}
