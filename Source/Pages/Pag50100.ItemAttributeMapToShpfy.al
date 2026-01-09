page 50100 "Item Attribute Map To Shpfy"
{
    ApplicationArea = All;
    Caption = 'Item Attribute Map To Shopify', Comment = 'DAN="Vareattribut mapning til Shopify"';
    PageType = List;
    SourceTable = ItemAttribMap_Shpfy_Meta;
    UsageCategory = Administration;
    AdditionalSearchTerms = 'Vareattribut,Shopify,Nøgle,Navn,Mapning';

    Editable = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Attribute ID"; Rec."Item Attribute ID")
                {
                }
                field("Item Attribute Name"; Rec."Item Attribute Name")
                {
                }
                field("Shopify Key Name"; Rec."Shopify Key Name")
                {
                }
                field(Namespace; Rec.Namespace)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportItemAttributes)
            {
                Caption = 'Import Item Attributes', Comment = 'DAN="Importér vareattributter"';
                Image = Import;
                trigger OnAction()
                var
                    XmlImport: XmlPort "Import Item Attributes";
                    Text0001: Label 'Item attributes have been imported successfully.', comment = 'DAN="Vareattributter er importeret succesfuldt."';
                begin
                    XmlImport.Run();
                    Message('Item attributes have been imported successfully.');
                end;
            }
            action(SynchronizeAttributes)
            {
                Caption = 'Synchronize Attributes to Shopify', Comment = 'DAN="Synkronisér attributter til Shopify"';
                Image = TransferToLines;
                trigger OnAction()
                var
                begin
                    Report.Run(Report::"Synchronize Attributes Shpfy",true);
                end;
            }
        }
    }
}
