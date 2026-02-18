page 50201 "Freight Zone Zip Code"
{
    ApplicationArea = All;
    Caption = 'Freight Zone Zip Code', Comment = 'Dan="Fragtzone postnummer"';
    PageType = List;
    SourceTable = "Freight Zone Zip Code";
    UsageCategory = Lists;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Freight Zone"; Rec."Freight Zone")
                {
                    Visible = FreightZoneVisible;
                }
                field("From Zip Code"; Rec."From Zip Code")
                {
                }
                field("To Zip Code"; Rec."To Zip Code")
                {
                }
            }
        }
    }

    procedure setvisibility(FreightVisble: Boolean)
    begin
        FreightZoneVisible := FreightVisble;
        CurrPage.Update();
    end;

    var
        FreightZoneVisible: Boolean;
}
