pageextension 50101 PickList_Ext extends "Inventory Picks"
{
    // actions
    // {
    //     addlast(processing)
    //     {
    //         action("Cleanup")
    //         {
    //             Image = Delete;
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 WareHouseActivityLine: Record "Warehouse Activity Line";
    //                 WareHouseActivityHeader: Record "Warehouse Activity Header";
    //                 So: Record "Sales header";

    //             begin
    //                 //WareHouseActivityHeader.SetFilter("No.", 'IPI000001|IPI001075');
    //                 if WareHouseActivityHeader.Find('-') then
    //                     repeat
    //                         If not so.get(WareHouseActivityHeader."Source Subtype", WareHouseActivityHeader."Source No.") then begin
    //                             WareHouseActivityLine.SetRange("No.", WareHouseActivityHeader."No.");
    //                             if WareHouseActivityLine.Find('-') then
    //                                 WareHouseActivityLine.Deleteall();
    //                             WareHouseActivityHeader.Delete();
    //                         end;
    //                     until WareHouseActivityHeader.Next() = 0;
    //                 Message('Cleanup is done');

    //             end;
    //         }

    //     }

    // }
}