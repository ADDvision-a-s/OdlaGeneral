namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Inventory.Location;

pageextension 50104 "Location Card Ext" extends "Location Card"
{
    layout
    {
        addlast(Pick)
        {
            group(ODLA)
            {
                Caption = 'ODLA';
                field(ISPickingLocation; Rec.ISPickingLocation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
