xmlport 50200 konti
{

    Caption = 'Indlæs ref';
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '"';
    TextEncoding = UTF8;



    schema
    {
        textelement(RootNodeName)
        {

            tableelement(GLAccount; "G/L Account")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                fieldelement(No; GLAccount."No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        checkIfGLAccountExist(GLAccount."No.");
                    end;
                }
            }
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
    procedure checkIfGLAccountExist(No: Code[20])
    var
        gl: Record "G/L Account";
    begin
        if No <> '' then
            If not gl.get(No) then begin
                gl."No." := No;
                if gl.Insert() then;
            end;
    end;
}




