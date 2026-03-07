namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Sales.Setup;

pageextension 50103 ADD_SalesSetup_Ext extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(Content)
        {
            group(ShopifyIntegrationGroup)
            {
                Caption = 'Shopify Integration';
                field(PostNordDropPointCode; Rec."PostNord DropPoint Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
