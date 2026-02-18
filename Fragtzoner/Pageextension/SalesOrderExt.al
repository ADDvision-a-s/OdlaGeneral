// pageextension 50202 "Sales Order Ext." extends "Sales Order"
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

//                 ApplicationArea = Warehouse;
//                 Caption = 'Create Inventor&y Put-away/Pick', Comment = 'DAN="Opret lager & Læg på lager/plukning"';
//                 Ellipsis = true;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = CreateInventoryPickup;

//                 trigger OnAction()
//                 begin
//                     Rec.PerformManualRelease();
//                     Rec.CreateInvtPutAwayPickDKK();
//                 end;
//             }
//         }
//     }


// }
