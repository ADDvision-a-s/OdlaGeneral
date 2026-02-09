namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Sales.Setup;
using Microsoft.Foundation.Shipping;

tableextension 50101 ADD_SalesSetup_Ext extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "PostNord DropPoint Code"; Text[10])
        {
            Caption = 'PostNord DropPoint Code', Comment = 'DAN="Shopify Drop point kode';
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
        }
    }
}
