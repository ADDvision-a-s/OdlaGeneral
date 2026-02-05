namespace OdlaGeneral.OdlaGeneral;
using Microsoft.Integration.Shopify;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;

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


    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post", OnCheckAndUpdateOnBeforeCheckShip, '', false, false)]
    // local procedure OnCheckAndUpdateOnBeforeCheckShip(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")
    // begin
    //     Ishandled := True;
    // end;

}
