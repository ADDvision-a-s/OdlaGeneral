namespace Fragtzoner.Fragtzoner;

using Microsoft.Warehouse.Activity;

pageextension 50202 "Warehouse Activity Header Ext" extends "Inventory Pick"
{
    layout
    {
        addafter("Assignment Time")
        {
            group("Volume and Weight")
            {

                field("Volume"; Rec."Volume when Pick created")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight when Pick created")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight when Pick created")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}