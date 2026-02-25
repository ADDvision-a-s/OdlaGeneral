pageextension 50203 "Sales Setup ext." extends "Sales & Receivables Setup"
{

    layout
    {
        addafter("Copy Customer Name to Entries")
        {
            field("Freight Zone Active"; Rec."Freight Zone Active")
            {
                ApplicationArea = All;
            }
        }
    }
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
            // action("gl")
            // {
            //     Caption = 'GL Account', Comment = 'Dan="Konti."';
            //     ApplicationArea = All;
            //     Image = Lot;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;


            //     trigger OnAction();
            //     var
            //         glxmlpage: XmlPort konti;
            //     begin

            //         glxmlpage.Run;
            //     end;
            // }
        }

    }
}
