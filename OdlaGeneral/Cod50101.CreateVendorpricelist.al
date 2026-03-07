namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.Pricing;

codeunit 50101 "Create Vendor pricelist"
{

    trigger OnRun()
    var
        Item: Record Item;
        PurchasePrice: Record "Purchase Price";

    begin
        If Item.find('-') then
            repeat
                if Item."Vendor No." <> '' then begin
                    PurchasePrice.Init();
                    PurchasePrice."Item No." := Item."No.";
                    PurchasePrice."Vendor No." := Item."Vendor No.";
                    PurchasePrice."Unit of Measure Code" := Item."Base Unit of Measure";
                    PurchasePrice."Direct Unit Cost" := Item."Unit Cost";
                    IF PurchasePrice."Direct Unit Cost" <> 0 then
                        IF PurchasePrice.Insert() then;
                end;
            until Item.next() = 0;
    end;

}
