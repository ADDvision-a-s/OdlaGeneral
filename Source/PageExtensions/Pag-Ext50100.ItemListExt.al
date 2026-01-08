pageextension 50100 ItemList_Ext extends "Item List"
{
    actions
    {
        addlast(Action126)
        {
            action("ItemAttributemapping")
            {
                Caption = 'itemattribute mapping to Shopify', Comment = 'DAN="Vareattribut mapning til Shopify"';
                Image = MapAccounts;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ItemAttributeMapping: Page "Item Attribute Map To Shpfy";
                begin
                    ItemAttributeMapping.RunModal();
                end;
            }
            action("ItemAttributeImport")
            {
                Caption = 'Item Attribute Import', Comment = 'DAN="Importér vare attributværdier"';
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                var
                    XmlImport: XmlPort "Import Item Attributes";
                    Text0001: Label 'Item attributes have been imported successfully.', comment = 'DAN="Vareattributter er importeret succesfuldt."';
                begin
                    XmlImport.Run();
                    Message('Item attributes have been imported successfully.');
                end;
            }
        }
        addafter(Attributes_Promoted)
        {

            actionref("ItemAttributemapping_Promoted"; "ItemAttributemapping")
            {
            }
           actionref("ItemAttributeImport_Promoted"; "ItemAttributeImport")
            {
            }

        }

    }
}