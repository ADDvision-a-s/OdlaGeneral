report 50100 "Synchronize Attributes Shpfy"
{
    ApplicationArea = All;
    Caption = 'Synchronize Attributes Shpfy', Comment = 'DAN="Synkroniser attributter fra shopify"';
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
                Shop: Record "Shpfy Shop";
                ItemAttributeName: Text[250];
                Country: Record "Country/Region";
            begin
                ShopifyProduct.SetRange("Item No.", Item."No.");
                if not shopifyProduct.FindFirst() then
                    exit;
                //Shop.Get();

                //if Shop."Sync Item" = Shop."Sync Item"::"From Shopify" then begin
                if DeleteAndCreate then begin
                    ItemAttributeMapping.SetRange("Table ID", Database::Item);
                    ItemAttributeMapping.SetRange("No.", Item."No.");
                    if ItemAttributeMapping.FindSet() then
                        repeat
                            ItemAttributeMapping.Delete();
                        until ItemAttributeMapping.Next() = 0;
                end;
                Counter += 1;
                if (Counter MOD 50) = 0 then
                    Window.Update();
                ShopifyMeta.SetRange("Owner ID", ShopifyProduct.ID);
                ShopifyMeta.SetRange("Owner Type", ShopifyMeta."Owner Type"::Product);
                if ShopifyMeta.FindSet() then begin
                    repeat
                        ItemAttributeName := ShopifyMeta.Namespace + '_' + ShopifyMeta.Name;
                        //Find Evt Mapping mellem meta felter og item attributter
                        Clear(AttributeMapShpfy);
                        AttributeMapShpfy.SetCurrentKey("Shopify Key Name");                        
                        AttributeMapShpfy.SetRange("Shopify Key Name", ItemAttributeName);
                        if AttributeMapShpfy.FindFirst() then begin
                            ItemAttributeName := AttributeMapShpfy."Item Attribute Name";
                        end;
                        Clear(ItemAttribute);
                        ItemAttribute.SetCurrentKey(Name);
                        ItemAttribute.SetRange(Name, ItemAttributeName);
                        if not ItemAttribute.FindFirst() then begin
                            ItemAttributeName := ItemAttributeName;
                            ItemAttribute.Validate(Name, ItemAttributeName);
                            ItemAttribute.Insert(true);
                        end;
                        Clear(ItemAttributeValue);
                        ItemAttributeValue.SetRange("Attribute ID", ItemAttribute.ID);
                        ItemAttributeValue.SetRange(Value, ShopifyMeta.Value);
                        if not ItemAttributeValue.FindFirst() then begin
                            ItemAttributeValue.Validate("Attribute ID", ItemAttribute.ID);
                            ItemAttributeValue.Validate(Value, ShopifyMeta.Value);
                            ItemAttributeValue.Insert(true);
                        end;
                        Clear(ItemAttributeMapping);
                        ItemAttributeMapping.SetRange("Table ID", Database::Item);
                        ItemAttributeMapping.SetRange("No.", Item."No.");
                        ItemAttributeMapping.SetRange("Item Attribute ID", ItemAttribute.ID);
                        if not ItemAttributeMapping.FindFirst() then begin
                            ItemAttributeMapping.Init();
                            ItemAttributeMapping.Validate("Table ID", Database::Item);
                            ItemAttributeMapping.Validate("No.", Item."No.");
                            ItemAttributeMapping.Validate("Item Attribute ID", ItemAttribute.ID);
                            ItemAttributeMapping.Validate("Item Attribute Value ID", ItemAttributeValue.ID);
                            ItemAttributeMapping.Insert(true);
                        end else begin
                            if ItemAttributeMapping."Item Attribute Value ID" <> ItemAttributeValue.ID then begin
                                ItemAttributeMapping.Validate("Item Attribute Value ID", ItemAttributeValue.ID);
                                ItemAttributeMapping.Modify(true);
                            end;
                        end;
                        if StrPos(ItemAttributeName, 'country_of_origin') <> 0 then begin
                            if Country.Get(CopyStr(ShopifyMeta.Value, 1, MaxStrLen(Country."Code"))) then begin
                                if Item."Country/Region of Origin Code" <> Country."Code" then begin
                                    Item.Validate("Country/Region of Origin Code", ShopifyMeta.Value);
                                    Item.Modify(true);
                                end;
                            end;
                        end;
                    until ShopifyMeta.Next() = 0;
                end;

                /*end else begin
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
                end;*/
            end;

            trigger OnPreDataItem()
            // var
            //     MetafieldAPI: Codeunit "Shpfy Metafield API";
            //     ParentTableNo: Integer;
            //     OwnerId: BigInteger;
            begin
                Window.Open('Getting attributes from Shopify...###1', Counter);
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
                    field(DeleteAndCreate; DeleteAndCreate)
                    {
                        ApplicationArea = All;
                        Caption = 'Delete existing mappings before creating new ones based on Shopify data', Comment = 'DAN="Slet eksisterende attributter før nye oprettes baseret på Shopify data"';
                    }

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
    var
        Window: Dialog;
        Counter: Integer;
        DeleteAndCreate: Boolean;

}
