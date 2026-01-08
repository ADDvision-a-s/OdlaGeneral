report 50100 "Synchronize Attributes Shpfy"
{
    ApplicationArea = All;
    Caption = 'Synchronize Attributes Shpfy';
    UsageCategory = Tasks;
    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            var
                ItemAttribute: Record "Item Attribute";
                ItemAttributeValue: Record "Item Attribute Value";
                ItemAttributeMapping: Record "Item Attribute Value Mapping";
                AttributeMapShpfy: Record "ItemAttribMap_Shpfy_Meta";
                ShopifyMeta: Record "Shpfy Metafield";
                ShopifyProduct: Record "Shpfy Product";
            begin
                ShopifyProduct.SetRange("Item No.",Item."No.");
                if not shopifyProduct.FindFirst() then
                    exit;

                ItemAttributeMapping.SetRange("Table ID", DATABASE::"Item");
                ItemAttributeMapping.SetRange("No.", Item."No.");
                if ItemAttributeMapping.FindSet() then
                    repeat
                        if ItemAttribute.Get(ItemAttributeMapping."Item Attribute ID") then 
                            if AttributeMapShpfy.Get(ItemAttribute.ID) then begin

                                ShopifyMeta.Reset();
                                                                
                                if ItemAttributeValue.Get(ItemAttributeMapping."Item Attribute Value Mapping ID", Item."No.", ItemAttribute."No.") then begin
                                    // Find Shopify Product
                                    if ShopifyProduct.Get(Item."No.") then begin
                                        // Create or Update Metafield in Shopify
                                        ShopifyMeta.Init();
                                        ShopifyMeta."Owner ID" := ShopifyProduct.ID;
                                        ShopifyMeta."Owner Resource" := ShopifyProduct."Resource Type";
                                        ShopifyMeta.Namespace := 'attributes';
                                        ShopifyMeta.Key := AttributeMapShpfy."Shopify Key Name";
                                        ShopifyMeta.Value := ItemAttributeValue.Value;
                                        ShopifyMeta."Value Type" := 'string';
                                        ShopifyMeta.Modify(true);
                                    end;
                                end;
                            end;
                        end;
                    until ItemAttributeMapping.Next() = 0;
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
