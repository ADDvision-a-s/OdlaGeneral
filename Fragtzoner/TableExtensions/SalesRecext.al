namespace Fragtzoner.Fragtzoner;

using Microsoft.Sales.Setup;

tableextension 50200 "Sales & Rec. ext." extends "Sales & Receivables Setup"
{
    fields
    {
        field(50200; "Freight Zone Active"; Boolean)
        {
            Caption = 'Freight Zone Active', Comment = 'DAN="Fragtzone aktiv"';
            DataClassification = ToBeClassified;
        }

    }
}
