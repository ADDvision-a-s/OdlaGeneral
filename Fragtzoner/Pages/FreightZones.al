page 50200 "Freight Zones"
{
    ApplicationArea = All;
    Caption = 'Freight Zones', Comment = 'Dan="Fragtzoner"';
    PageType = List;
    SourceTable = "Freight Zones";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                // field("From Zip Code"; Rec."From Zip Code")
                // {
                // }
                // field("To Zip Code"; Rec."To Zip Code")
                // {
                // }              
                field(Monday; Rec.Monday)
                {
                }
                field(Tuesday; Rec.Tuesday)
                {
                }
                field(Wednesday; Rec.Wednesday)
                {
                }
                field(Thursday; Rec.Thursday)
                {
                }
                field(Friday; Rec.Friday)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'Functions', Comment = 'DAN="Funktioner"';

                action("From/To Zip Code")
                {
                    ApplicationArea = All;
                    Caption = 'From/To Zip Code', Comment = 'DAN="Fra/Til postnummer"';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        FromToZipPage: Page "Freight Zone Zip Code";
                        FromToZip: Record "Freight Zone Zip Code";
                    begin
                        FromToZip.SetFilter("Freight Zone", Rec."Code");
                        FromToZipPage.SetTableView(FromToZip);
                        FromToZipPage.SetVisibility(false);
                        FromToZipPage.Run()
                    end;
                }
            }
        }
    }
}

