namespace Fragtzoner.Fragtzoner;

using Microsoft.Sales.Document;

tableextension 50201 "Sales Header Extension" extends "Sales Header"
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
