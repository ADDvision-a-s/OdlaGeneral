// pageextension 50204 "Change relation CreateInvtP SO" extends "Sales Order"
// {

//     actions
//     {
//         modify("Create Inventor&y Put-away/Pick")
//         {
//             Visible = False;
//         }
//         addbefore("Create &Warehouse Shipment")
//         {
//             action("Create Inventor&y Put-away/Pick 2")
//             {
//                 AccessByPermission = TableData "Posted Invt. Pick Header" = R;
//                 ApplicationArea = Warehouse;
//                 Caption = 'Create Inventor&y Put-away/Pick', Comment = 'DAN="Opret lager & Læg på lager/plukning"';
//                 Ellipsis = true;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = CreateInventoryPickup;

//                 trigger OnAction()
//                 var
//                     SalesLine: Record "Sales Line";
//                     Volume: Decimal;
//                     GrossWeight: Decimal;
//                     netWeight: Decimal;
//                     WarehouseHeader: Record "Warehouse Activity Header";
//                 begin
//                     Rec.PerformManualRelease();
//                     Rec.CreateInvtPutAwayPick();

//                     // Commit();

//                     // SalesLine.SetRange("Document Type", Rec."Document Type");
//                     // SalesLine.SetRange("Document No.", Rec."No.");
//                     // IF SalesLine.FindSet() THEN
//                     //     REPEAT
//                     //         Volume += SalesLine."Quantity (Base)" * SalesLine."Unit Volume";
//                     //         GrossWeight += SalesLine."Quantity (Base)" * SalesLine."Gross Weight";
//                     //         netWeight += SalesLine."Quantity (Base)" * SalesLine."Net Weight";
//                     //     UNTIL SalesLine.Next() = 0;

//                     // Rec."Volume when Pick created" := Volume;
//                     // Rec."Net Weight when Pick created" := netWeight;
//                     // Rec."Gross Weight when Pick created" := GrossWeight;
//                     // Rec.Modify();

//                     // IF WarehouseHeader.Get(Rec."Warehouse Type", rec."Warehouse No.") then begin
//                     //     WarehouseHeader."Volume when Pick created" := Volume;
//                     //     WarehouseHeader."Net Weight when Pick created" := netWeight;
//                     //     WarehouseHeader."Gross Weight when Pick created" := GrossWeight;
//                     //     WarehouseHeader.Modify();
//                     // end;

//                     if not Rec.Find('=><') then
//                         Rec.Init();


//                 end;
//             }
//         }


//     }
// }
