codeunit 50200 "Odlanu events"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", 'OnBeforeGetSourceDocHeader', '', false, false)]
    local procedure OnBeforeGetSourceDocHeader(var WhseRequest: Record "Warehouse Request"; var IsHandled: Boolean; var RecordExists: Boolean)
    var
        Salesandrecei: Record "Sales & Receivables Setup";
    begin
        Salesandrecei.Get();
        if not Salesandrecei."Freight Zone Active" then
            exit;

        CheckFreight(WhseRequest);
        if CanbeShiped = false then begin
            RecordExists := false;
            IsHandled := true;
            If GuiAllowed then
                // error(Error2, ItemNo, ShipmentDate, SalesHeader."Ship-to Post Code")
                // else
                Message(Error2, ItemNo, ShipmentDate, SalesHeader."Ship-to Post Code");
        end;


    end;

    procedure CheckFreight(WhseRequest: Record "Warehouse Request")
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
        SalesLine.SetRange("Document No.", WhseRequest."Source No.");
        SalesLine.SetRange("Document Type", WhseRequest."Source Subtype");
        SalesLine.setrange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', '');
        IF SalesLine.find('-') then
            repeat
                SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
                Itemfreightzone.SetRange("Item No.", SalesLine."No.");
                IF Itemfreightzone.FindFirst() then Begin
                    IF Itemfreightzone."Item Certificate Attached" = true then begin

                        Weekday := Date2DWY(SalesLine."Shipment Date", 1);
                        FreightZipCode.SetFilter("From Zip Code", '>=%1', SalesHeader."Ship-to Post Code");
                        IF FreightZipCode.FindFirst() then
                            IF FreightZipCode."To Zip Code" >= SalesHeader."Ship-to Post Code" then begin
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
                                error(Error1, SalesHeader."Ship-to Post Code");
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
        SalesHeader: Record "Sales Header";

}
