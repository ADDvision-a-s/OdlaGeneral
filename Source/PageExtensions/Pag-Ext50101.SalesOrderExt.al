namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Sales.Document;

pageextension 50101 SalesOrder_Ext extends "Sales Order List"
{
    layout
    {
        addafter("Location Code")
        {
            field(pickExists; Rec."Pick Exists")
            {
                Style = Unfavorable;
                StyleExpr = Rec."Pick Exists" = false;
                ApplicationArea = All;
                Caption = 'Pick Exists', comment = 'DAN="Pluk er oprettet"';
                Editable = false;
            }
        }
    }

}
