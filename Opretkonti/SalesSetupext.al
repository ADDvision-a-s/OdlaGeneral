pageextension 50203 "Sales Setup ext." extends "Sales & Receivables Setup"
{
    actions
    {
        addlast(navigation)
        {

            action("gl")
            {
                Caption = 'Create GL Account', Comment = 'Dan="Opret Konti."';
                ApplicationArea = All;
                Image = Lot;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction();
                var
                    glxmlpage: XmlPort konti;
                begin

                    glxmlpage.Run;
                end;
            }
        }

    }
}
