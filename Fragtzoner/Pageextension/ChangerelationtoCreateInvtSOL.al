// pageextension 50205 "Chang relation CreateInvtP SOL" extends "Sales Order List"
// {

//     actions
//     {
//         modify("Create Inventor&y Put-away/Pick")
//         {
//             Visible = False;
//         }
//         addbefore("Create &Warehouse Shipment")
//         {
//             action("Create Inventor&y Put-away/Pick DKK")
//             {
//                 AccessByPermission = TableData "Posted Invt. Pick Header" = R;
//                 ApplicationArea = Warehouse;
//                 Caption = 'Create Inventor&y Put-away/Pick', Comment = 'DAN="Opret lager & Læg på lager/plukning"';
//                 Ellipsis = true;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = CreatePutawayPick;

//                 trigger OnAction()
//                 var
//                     SalesLine: Record "Sales Line";
//                     Volume: Decimal;
//                     GrossWeight: Decimal;
//                     netWeight: Decimal;
//                 begin
//                     Rec.PerformManualRelease();
//                     Rec.CreateInvtPutAwayPick();

//                     SalesLine.SetRange("Document Type", Rec."Document Type");
//                     SalesLine.SetRange("Document No.", Rec."No.");
//                     IF SalesLine.FindSet() THEN
//                         REPEAT
//                             Volume += SalesLine."Quantity (Base)" * SalesLine."Unit Volume";
//                             GrossWeight += SalesLine."Quantity (Base)" * SalesLine."Gross Weight";
//                             netWeight += SalesLine."Quantity (Base)" * SalesLine."Net Weight";
//                         UNTIL SalesLine.Next() = 0;
//                     if not Rec.Find('=><') then
//                         Rec.Init();


//                 end;
//             }
//         }
//     }

// }
