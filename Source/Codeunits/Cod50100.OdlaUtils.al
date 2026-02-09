namespace OdlaGeneral.OdlaGeneral;
using Microsoft.Integration.Shopify;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;

codeunit 50100 Odla_Utils
{

    trigger OnRun()
    var
    begin

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
            if StrPos(OrderShippingCharges."Code Value", 'POSTNORD') > 0 then begin
                TempStr := OrderShippingCharges."Code Value";
                while StrPos(TempStr, '_') <> 0 do begin
                    TmpPos := StrPos(TempStr, '_');
                    TempStr := CopyStr(TempStr, TmpPos + 1, StrLen(TempStr) - TmpPos);
                end;
                TmpPos := 0;
                if Evaluate(TmpPos, TempStr) then begin
                    ShopifyOrderHeader."Ship-to Address 2" := TempStr;
                    ShopifyOrderHeader."Shipping Method Code" := SalesSetup."PostNord DropPoint Code";
                    Handled := true;
                end
            end;
        end;
    end;


    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", OnCheckAndUpdateOnBeforeCheckShip, '', false, false)]
    // local procedure OnCheckAndUpdateOnBeforeCheckShip(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")
    // begin
    //     Ishandled := True;
    // end;

}
