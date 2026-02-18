tableextension 50201 "Sales Header Ext." extends "Sales Header"
{

    procedure CreateInvtPutAwayPickDKK()
    var
        SH: Record "Sales Header";
        whseRequest: Record "Warehouse Request";
    begin

        if "Document Type" = "Document Type"::Order then
            if not IsApprovedForPosting() then
                exit;

        TestField(Status, Status::Released);

        CheckFreight();

        IF CanbeShiped = false then
            Error(Error2, ItemNo, ShipmentDate, Rec."Ship-to Post Code");

        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        case "Document Type" of
            "Document Type"::Order:
                begin
                    if "Shipping Advice" = "Shipping Advice"::Complete then
                        CheckShippingAdvice();
                    WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Order");
                end;
            "Document Type"::"Return Order":
                WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Return Order");
        end;
        WhseRequest.SetRange("Source No.", "No.");
        REPORT.RunModal(REPORT::"Create Invt Put-away/Pick/Mvmt", true, false, WhseRequest);
    end;



    procedure CheckFreight()
    var
        SalesLine: Record "Sales Line";
        Itemfreightzone: Record "Item FreightZone";
        FreightZipCode: Record "Freight Zone Zip Code";
        FreightZone: Record "Freight Zones";
        Weekday: Integer;
        ZipFilter: code[250];
        Error1: Label 'No freight zone found for the ship-to postal code %1', Comment = 'DAN="Ingen fragtzone fundet for leveringspostnummer %1"';

    begin
        CanbeShiped := true;
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.setrange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', '');
        IF SalesLine.find('-') then
            repeat
                Itemfreightzone.SetRange("Item No.", SalesLine."No.");
                IF Itemfreightzone.FindFirst() then Begin
                    IF Itemfreightzone."Item Certificate Attached" = true then begin

                        Weekday := Date2DWY(SalesLine."Shipment Date", 1);

                        // FreightZipCode.SetFilter("Zip Filter", Rec."Ship-to Post Code");
                        FreightZipCode.SetFilter("From Zip Code", '>=%1', Rec."Ship-to Post Code");
                        IF FreightZipCode.FindFirst() then
                            IF FreightZipCode."To Zip Code" >= Rec."Ship-to Post Code" then begin
                                FreightZone.Get(FreightZipCode."Freight Zone");
                                case Weekday of
                                    1:
                                        if Not FreightZone.Monday = true then
                                            CanbeShiped := false;
                                    2:
                                        if Not FreightZone.Tuesday = true then
                                            CanbeShiped := false;
                                    3:
                                        if Not FreightZone.Wednesday = true then
                                            CanbeShiped := false;
                                    4:
                                        if Not FreightZone.Thursday = true then
                                            CanbeShiped := false;
                                    5:
                                        if Not FreightZone.Friday = true then
                                            CanbeShiped := false;
                                end;

                            end
                            Else
                                error(Error1, Rec."Ship-to Post Code");
                    end;
                end;
                ItemNo := SalesLine."No.";
                ShipmentDate := SalesLine."Shipment Date";
            until (Salesline.Next() = 0) or (CanbeShiped = false);

    end;

    Var
        CanbeShiped: Boolean;
        ItemNo: Code[20];
        ShipmentDate: Date;
        Error2: Label 'The sales order cannot be picked, with postal code %3 and item %1, with shipment date %2', Comment = 'DAN="Salgsordren kan ikke plukkes, med postnummer %3 og vare %1, med forsendelsesdato %2"';
}
