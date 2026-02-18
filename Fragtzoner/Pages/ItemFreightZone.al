page 50202 "Item Freight Zone"
{
    ApplicationArea = All;
    Caption = 'Item Freight Zone', Comment = 'DAN="Vare Fragtzone"';
    PageType = List;
    SourceTable = "Item FreightZone";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                }
                field("Item Certificate Attached"; Rec."Item Certificate Attached")
                {
                }
            }
        }
    }
}
