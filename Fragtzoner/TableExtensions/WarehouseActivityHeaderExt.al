namespace Fragtzoner.Fragtzoner;

using Microsoft.Warehouse.Activity;

tableextension 50202 "Warehouse Activity Header Ext" extends "Warehouse Activity Header"
{

    fields
    {
        field(50200; "Volume when Pick created"; Decimal)
        {
            Caption = 'Volume when Pick created';
            DataClassification = ToBeClassified;
        }
        field(50201; "Net Weight when Pick created"; Decimal)
        {
            Caption = 'Net Weight when Pick created';
            DataClassification = ToBeClassified;
        }
        field(50202; "Gross Weight when Pick created"; Decimal)
        {
            Caption = 'Gross Weight when Pick created';
            DataClassification = ToBeClassified;
        }
    }
}
