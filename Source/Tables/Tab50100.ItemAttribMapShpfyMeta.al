table 50100 ItemAttribMap_Shpfy_Meta
{
    Caption = 'ItemAttribMap_Shpfy_Meta';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Item Attribute ID"; Integer)
        {
            Caption = 'ID', Comment = 'DAN="Vareattribut ID"';
            TableRelation = "Item Attribute".ID;
            trigger OnValidate()
            var
                ItemAttributeRec: Record "Item Attribute";
            begin
                if ItemAttributeRec.Get("Item Attribute ID") then
                    "Item Attribute Name" := ItemAttributeRec.Name
                else
                    "Item Attribute Name" := '';
            end;
        }
        field(2; "Item Attribute Name"; Text[250])
        {
            Caption = 'Item Attribute Name', Comment = 'DAN="Vareattribut Navn"';
        }
        field(3; "Shopify Key Name"; Text[250])
        {
            Caption = 'Shopify Key Name', Comment = 'DAN="Shopify Nøgle Navn"';
        }
    }
    keys
    {
        key(PK; "Item Attribute ID")
        {
            Clustered = true;
        }
    }
}
