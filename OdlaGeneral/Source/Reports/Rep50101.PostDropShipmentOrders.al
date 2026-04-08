namespace OdlaGeneral.OdlaGeneral;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Location;
using Microsoft.Sales.Posting;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Setup;

report 50101 PostDropShipmentOrders
{
    ApplicationArea = All;
    Caption = 'PostDropShipmentOrders';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = const(Order),
                                                                             Status = const(Released));
            trigger OnPreDataItem()
            begin
                SalesSetup.Get();
            end;

            trigger OnAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
                Location: Record Location;
                Item: Record Item;
                SalesHeader2: Record "Sales Header";
                SalesPost: Codeunit "Sales-Post";
            begin
                SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetFilter("Location Code", '<>%1', '');
                if SalesLine.FindSet() then 
                    repeat
                            Location.Get(SalesLine."Location Code");
                            if Location.ISPickingLocation = true then begin
                                Item.Get(SalesLine."No.");
                                if Item.Type = "Item Type"::Inventory then begin
                                    exit;
                                end;
                            end;
                    until salesline.Next() = 0;
                    SalesHeader2.get(SalesHeader."Document Type", SalesHeader."No.");
                    SalesHeader2.Ship := true;
                    SalesHeader2.Invoice := true;
                    SalesPost.Run(SalesHeader2);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        SalesSetup: Record "Sales & Receivables Setup";
}
