namespace OdlaGeneral.OdlaGeneral;
using Microsoft.Integration.Shopify;
using Microsoft.Sales.Document;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Sales.Receivables;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Warehouse.Request;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Warehouse.Activity;

codeunit 50100 Odla_Utils
{

    trigger OnRun()
    var
        ShopifyorderHeader: Record "Shpfy Order Header";
        OrderShippingCharges: Record "Shpfy Order Shipping Charges";
        OrderAttribute: Record "Shpfy Order Attribute";
        SalesSetup: Record "Sales & Receivables Setup";
        TempStr: Text[100];
        TmpPos: Integer;
        Ok: Boolean;
    begin
        ShopifyorderHeader.Get('12334629814603');
        OrderShippingCharges.SetRange("Shopify Order Id", ShopifyOrderHeader."Shopify Order Id");
        if OrderShippingCharges.FindFirst() then begin
            SalesSetup.Get();
            if SalesSetup."PostNord DropPoint Code" = '' then begin
                SalesSetup."PostNord DropPoint Code" := 'OMBUD';
                SalesSetup.Modify();
            end;
            if StrPos(OrderShippingCharges."Code Value", 'postnord') > 0 then begin
                TempStr := OrderShippingCharges."Code Value";
                while StrPos(TempStr, '_') <> 0 do begin
                    TmpPos := StrPos(TempStr, '_');
                    TempStr := CopyStr(TempStr, TmpPos + 1, StrLen(TempStr) - TmpPos);
                end;
                TmpPos := 0;
                if Evaluate(TmpPos, TempStr) then begin
                    ShopifyOrderHeader."Ship-to Address 2" := TempStr;
                    ShopifyOrderHeader."Shipping Method Code" := SalesSetup."PostNord DropPoint Code";
                    ShopifyOrderHeader.Modify();
                end
            end;
        end;
    end;

    // **************************** Event Subscribers below **************************** \\

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Shpfy Product Events", OnBeforeSendCreateShopifyProduct, '', false, false)]
    internal procedure OnBeforeSendCreateShopifyProduct(ShopifyShop: Record "Shpfy Shop"; var ShopifyProduct: Record "Shpfy Product"; var ShopifyVariant: Record "Shpfy Variant"; var ShpfyTag: Record "Shpfy Tag")
    begin
        ShopifyProduct.Vendor := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Shpfy Product Events", OnBeforeSendUpdateShopifyProduct, '', false, false)]
    internal procedure OnBeforeSendUpdateShopifyProduct(ShopifyShop: Record "Shpfy Shop"; var ShopifyProduct: Record "Shpfy Product"; xShopifyProduct: Record "Shpfy Product")
    begin
        ShopifyProduct.Vendor := '';
    end;


    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Shpfy Order Events", OnBeforeMapShipmentMethod, '', false, false)]
    /// <summary> 
    /// Description for OnBeforeMapShipmentMethod.
    /// </summary>
    /// <param name="ShopifyOrderHeader">Parameter of type Record "Shopify Order Header".</param>
    /// <param name="Handled">Parameter of type Boolean.</param>
    internal procedure OnBeforeMapShipmentMethod(var ShopifyOrderHeader: Record "Shpfy Order Header"; var Handled: Boolean)
    var
        OrderShippingCharges: Record "Shpfy Order Shipping Charges";
        OrderAttribute: Record "Shpfy Order Attribute";
        SalesSetup: Record "Sales & Receivables Setup";
        TempStr: Text[100];
        TmpPos: Integer;
        Ok: Boolean;
    begin
        OrderShippingCharges.SetRange("Shopify Order Id", ShopifyOrderHeader."Shopify Order Id");
        if OrderShippingCharges.FindFirst() then begin
            SalesSetup.Get();
            if SalesSetup."PostNord DropPoint Code" = '' then begin
                SalesSetup."PostNord DropPoint Code" := 'OMBUD';
                SalesSetup.Modify();
            end;
            if StrPos(OrderShippingCharges."Code Value", 'postnord') > 0 then begin
                TempStr := OrderShippingCharges."Code Value";
                while StrPos(TempStr, '_') <> 0 do begin
                    TmpPos := StrPos(TempStr, '_');
                    TempStr := CopyStr(TempStr, TmpPos + 1, StrLen(TempStr) - TmpPos);
                end;
                TmpPos := 0;
                if Evaluate(TmpPos, TempStr) then begin
                    ShopifyOrderHeader."Ship-to Address 2" := TempStr;
                    ShopifyOrderHeader."Shipping Method Code" := SalesSetup."PostNord DropPoint Code";
                    ShopifyOrderHeader.Modify();
                    Handled := true;
                end
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", OnBeforePostSalesDoc, '', true, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        SalesLine: Record "Sales Line";
        Location: Record Location;
        Bigint: BigInteger;
    begin

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
                if SalesLine."Qty. to Ship" <> SalesLine."Quantity" then begin

                    if SalesHeader.Ship = true then begin
                    Location.Get(SalesLine."Location Code");
                    if Location.ISPickingLocation = false then
                        if (SalesHeader."Shpfy Order Id" <> Bigint) then begin
                            SalesLine.Validate("Qty. to Ship",SalesLine."Quantity");
                            SalesLine.Validate("Qty. to Invoice" ,SalesLine."Quantity");
                            SalesLine.Modify(true);
                        end;

                    if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Complete then begin
                        SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Partial;
                        SalesHeader.Modify();
                    end;
                    end;
                end;
            until SalesLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", OnAfterPostSalesDoc, '', true, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        PickLine: Record "Warehouse Activity Line";
    begin
        if SalesHeader."Shipping Advice" = SalesHeader."Shipping Advice"::Partial then begin
            PickLine.SetRange("Source No.", SalesHeader."No.");
            PickLine.SetRange("Source Type", Database::"Sales Line");
            PickLine.SetRange("Source Subtype", 1);
            PickLine.SetRange("Activity Type", PickLine."Activity Type"::"Invt. Pick");
            if PickLine.FindSet() then
                repeat
                    PickLine.Delete(true);
                until PickLine.Next() = 0;
        end;
        if SalesHeader.Delete(true) then;
    end;

    [EventSubscriber(ObjectType::Report, report::"Create Invt Put-away/Pick/Mvmt", 'OnBeforeCheckWhseRequest', '', true, false)]
    local procedure OnBeforeCheckWhseRequest(var WarehouseRequest: Record "Warehouse Request"; ShowError: Boolean; var SkipRecord: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        GetSrcDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin
        if WarehouseRequest."Source Type" = Database::"Sales Line" then begin
            if WarehouseRequest."Source Subtype" = WarehouseRequest."Source Subtype"::"1" then begin
                SkipRecord := not SalesHeader.Get(SalesHeader."Document Type"::Order, WarehouseRequest."Source No.");
                if not SkipRecord then
                    //                    SkipRecord := GetSrcDocOutbound.CheckSalesHeader(SalesHeader, ShowError);
                    SkipRecord := CheckSalesLines(SalesHeader, SalesLine, ShowError);
                if SkipRecord then
                    IsHandled := true;
            end;
        end;
    end;

    local procedure CheckSalesLines(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ShowError: Boolean) Result: Boolean
    var
        CurrItemVariant: Record "Item Variant";
        SalesOrder: Page "Sales Order";
        Location: Record Location;
        QtyOutstandingBase: Decimal;
        RecordNo: Integer;
        TotalNoOfRecords: Integer;
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
    begin

        GetSourceDocOutbound.SetCalledFromCreateWarehouseShipmentReport(true);
        Location.SetRange(ISPickingLocation, true);
        if location.FindFirst() then begin
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            SalesLine.SetRange("Location Code", Location.Code);
            if SalesLine.FindSet() then begin
                SetItemVariant(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code");
                TotalNoOfRecords := SalesLine.Count();
                repeat
                    RecordNo += 1; // alle linjer

                    if EqualItemVariant(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code") then
                        QtyOutstandingBase += SalesLine."Outstanding Qty. (Base)"
                    else begin
                        if GetSourceDocOutbound.CheckAvailability(
                             CurrItemVariant, QtyOutstandingBase, SalesLine."Location Code",
                             SalesOrder.Caption(), Database::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                        then
                            exit(true);
                        SetItemVariant(CurrItemVariant, SalesLine."No.", SalesLine."Variant Code");
                        QtyOutstandingBase := SalesLine."Outstanding Qty. (Base)";
                    end;
                    if RecordNo = TotalNoOfRecords then begin
                        // last record
                        // if CheckSalesHeaderOnBeforeCheckAvailability(SalesHeader, SalesLine, ShowError, Result) then
                        //     exit(Result);

                        if GetSourceDocOutbound.CheckAvailability(
                             CurrItemVariant, QtyOutstandingBase, SalesLine."Location Code",
                             SalesOrder.Caption(), Database::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", ShowError)
                        then
                            exit(true);
                    end;
                until SalesLine.Next() = 0;
                // sorted by item
            end;
        end;
    end;

    local procedure SetItemVariant(var CurrItemVariant: Record "Item Variant"; ItemNo: Code[20]; VariantCode: Code[10])
    begin
        CurrItemVariant."Item No." := ItemNo;
        CurrItemVariant.Code := VariantCode;
    end;

    local procedure EqualItemVariant(CurrItemVariant: Record "Item Variant"; ItemNo: Code[20]; VariantCode: Code[10]): Boolean
    begin
        exit((CurrItemVariant."Item No." = ItemNo) and (CurrItemVariant.Code = VariantCode));
    end;



}
