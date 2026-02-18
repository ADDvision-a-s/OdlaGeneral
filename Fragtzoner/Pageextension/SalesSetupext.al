pageextension 50203 "Sales Setup ext." extends "Sales & Receivables Setup"
{
    actions
    {
        addlast(navigation)
        {
            action("Freight Zone")
            {
                ApplicationArea = All;
                Caption = 'Freight Zone', Comment = 'DAN="Fragtzone"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FreightZoneList: Page "Freight Zones";
                begin

                    FreightZoneList.Run();
                end;
            }
            action("Freight Zone Zip Code")
            {
                ApplicationArea = All;
                Caption = 'Freight Zone Zip Code', Comment = 'DAN="Fragtzone postnummer"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    FreightZoneZipCodeList: Page "Freight Zone Zip Code";
                begin
                    FreightZoneZipCodeList.SetVisibility(True);
                    FreightZoneZipCodeList.Run();
                end;
            }
        }

    }
}
