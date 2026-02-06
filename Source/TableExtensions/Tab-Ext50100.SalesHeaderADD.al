namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Sales.Document;
using Microsoft.Warehouse.Activity;

tableextension 50100 SalesHeader_ADD extends "Sales Header"
{
    fields
    {
        field(50100; "Pick Exists"; Boolean)
        {
            Caption = 'Pick Exists', comment = 'DAN="Pluk er oprettet"';
            FieldClass = FlowField;
            CalcFormula = Exist("Warehouse Activity Line" where ("Source No." = field("No."),
                                                        "Source Type" = CONST(Database::"Sales Line"),
                                                        "Source Subtype" = CONST(1),
                                                        "Activity Type" = CONST(5)));
        }
    }
}
