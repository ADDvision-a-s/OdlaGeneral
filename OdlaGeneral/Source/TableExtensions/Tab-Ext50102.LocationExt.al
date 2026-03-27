namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Inventory.Location;

tableextension 50102 LocationExt extends Location
{
    fields
    {
        field(50100; ISPickingLocation; Boolean)
        {
            Caption = 'IS ODLA PickingLocation', comment = 'DAN="Er ODLA Plukkelokation"';
            DataClassification = ToBeClassified;
        }
    }
}
