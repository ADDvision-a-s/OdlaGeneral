table 50200 "Freight Zones"
{
    Caption = 'Freight Zones', comment = 'Dan="Fragtzoner"';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'Dan="Kode"';
        }
        field(2; Monday; Boolean)
        {
            Caption = 'Monday', Comment = 'Dan="Mandag"';
        }
        field(3; Tuesday; Boolean)
        {
            Caption = 'Tuesday', Comment = 'Dan="Tirsdag"';
        }
        field(4; Wednesday; Boolean)
        {
            Caption = 'Wednesday', Comment = 'Dan="Onsdag"';
        }
        field(5; Thursday; Boolean)
        {
            Caption = 'Thursday', Comment = 'Dan="Torsdag"';
        }
        field(6; Friday; Boolean)
        {
            Caption = 'Friday', Comment = 'Dan="Fredag"';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description', Comment = 'Dan="Beskrivelse"';
        }
        // field(8; "From Zip Code"; Code[10])
        // {
        //     Caption = 'From Zip Code', Comment = 'Dan="Fra postnummer"';
        //     TableRelation = "Post Code";
        //     ValidateTableRelation = true;
        //     NotBlank = true;
        // }
        // field(9; "To Zip Code"; Code[10])
        // {
        //     Caption = 'To Zip Code', Comment = 'Dan="Til postnummer"';
        //     TableRelation = "Post Code";
        //     ValidateTableRelation = true;
        //     NotBlank = true;
        // }

    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
