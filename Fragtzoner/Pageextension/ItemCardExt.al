pageextension 50200 "Item Card Ext." extends "Item Card"
{
    actions
    {
        addlast(Functions)
        {
            action("Item Freight Zone")
            {
                ApplicationArea = All;
                Caption = 'Item Freight Zone', Comment = 'DAN="Vare Fragtzone"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ItemFreightZoneList: Page "Item Freight Zone";
                    ItemFreightZone: Record "Item FreightZone";
                begin
                    ItemFreightZone.SetFilter("Item No.", Rec."No.");
                    ItemFreightZoneList.SetTableView(ItemFreightZone);
                    ItemFreightZoneList.Run();
                end;
            }
        }

    }
}
