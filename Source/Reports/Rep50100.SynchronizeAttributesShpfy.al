report 50100 "Synchronize Attributes Shpfy"
{
    ApplicationArea = All;
    Caption = 'Synchronize Attributes Shpfy';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                ItemAttribute: Record "Item Attribute";
                ItemAttributeValue: Record "Item Attribute Value";
                ItemAttributeMapping: Record "Item Attribute Value Mapping";
                AttributeMapShpfy: Record "ItemAttribMap_Shpfy_Meta";
                ShopifyMeta: Record "Shpfy Metafield";
                ShopifyProduct: Record "Shpfy Product";
            begin
                ShopifyProduct.SetRange("Item No.", Item."No.");
                if not shopifyProduct.FindFirst() then
                    exit;

                if AttributeMapShpfy.FindSet() then
                    repeat

                        ItemAttributeMapping.SetRange("Table ID", DATABASE::"Item");
                        ItemAttributeMapping.SetRange("No.", Item."No.");
                        ItemAttributeMapping.SetRange("Item Attribute ID", AttributeMapShpfy."Item Attribute ID");
                        if ItemAttributeMapping.Findfirst() then begin
                            if ItemAttributeValue.Get(ItemAttributeMapping."Item Attribute ID", ItemAttributeMapping."Item Attribute Value ID") then;
                            Clear(ShopifyMeta);
                            ShopifyMeta.SetRange("Owner ID", ShopifyProduct.ID);
                            ShopifyMeta.SetRange(Namespace, AttributeMapShpfy.Namespace);
                            ShopifyMeta.SetRange(Name, AttributeMapShpfy."Shopify Key Name");
                            if not ShopifyMeta.FindFirst() then begin
                                if ItemAttributeMapping."Item Attribute Value ID" <> 0 then begin
                                    ShopifyMeta.Init();
                                    ShopifyMeta.Validate("Owner ID", ShopifyProduct.ID);
                                    ShopifyMeta.Validate(Name, AttributeMapShpfy."Shopify Key Name");
                                    ShopifyMeta.Validate("Owner Type", ShopifyMeta."Owner Type"::Product);
                                    ShopifyMeta.Validate("Parent Table No.", Database::"Shpfy Product");
                                    ShopifyMeta.Validate(Namespace, AttributeMapShpfy.Namespace);
                                    ShopifyMeta.Validate(Name, AttributeMapShpfy."Shopify Key Name");
                                    ShopifyMeta.Validate(Type, AttributeMapShpfy.Type);
                                    ShopifyMeta.Validate(Value, ItemAttributeValue.Value);
                                    ShopifyMeta.Insert(true);
                                end;
                            end else begin
                                ShopifyMeta.Value := ItemAttributeValue.Value;
                                ShopifyMeta.Type := AttributeMapShpfy.Type;
                                ShopifyMeta.Modify(true);
                            end;
                        end else begin
                            Clear(ShopifyMeta);
                            ShopifyMeta.SetRange("Owner ID", ShopifyProduct.ID);
                            ShopifyMeta.SetRange(Namespace, AttributeMapShpfy.Namespace);
                            ShopifyMeta.SetRange(Name, AttributeMapShpfy."Shopify Key Name");
                            if ShopifyMeta.FindFirst() then begin
                                ShopifyMeta.Delete(true);
                            end;
                        end;
                    until AttributeMapShpfy.Next() = 0;
            end;

            trigger OnPreDataItem()
            // var
            //     MetafieldAPI: Codeunit "Shpfy Metafield API";
            //     ParentTableNo: Integer;
            //     OwnerId: BigInteger;
            begin
                //     Evaluate(ParentTableNo, Rec.GetFilter("Parent Table No."));
                //     Evaluate(OwnerId, Rec.GetFilter("Owner Id"));
                //     MetafieldAPI.SetShop(Shop);
                //     MetafieldAPI.GetMetafieldDefinitions(ParentTableNo, OwnerId);
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
