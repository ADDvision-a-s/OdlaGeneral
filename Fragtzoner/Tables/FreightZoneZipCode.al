table 50201 "Freight Zone Zip Code"
{
    Caption = 'Freight Zone Zip Code', Comment = 'Dan="Fragtzone postnummer"';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Freight Zone"; Code[20])
        {
            Caption = 'Freght Zone', Comment = 'Dan="Fragtzone"';
            DataClassification = ToBeClassified;
        }
        field(2; "From Zip Code"; Code[10])
        {
            Caption = 'From Zip Code', Comment = 'Dan="Fra postnummer"';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            ValidateTableRelation = true;
            NotBlank = true;
        }
        field(3; "To Zip Code"; Code[10])
        {
            Caption = 'To Zip Code', Comment = 'Dan="Til postnummer"';
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            ValidateTableRelation = true;
            NotBlank = true;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'Dan="Linienummer"';
            DataClassification = ToBeClassified;
        }
        field(5; "Zip Filter"; Code[250])
        {
            Caption = 'Zip Filter', Comment = 'Dan="Postnummerfilter"';
            DataClassification = ToBeClassified;
        }
    }

    Keys
    {
        key(PK; "Freight Zone", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    var
        FreightZoneZip: Record "Freight Zone Zip Code";
        ErrorFound: Boolean;
        Error1: Label 'The zip code range overlaps with an existing record. Please adjust the zip code range.', Comment = 'Dan="Postnummerområdet overlapper med et eksisterende postnummerområde. Juster venligst postnummerområdet."';
    begin
        "Zip Filter" := StrSubstNo('>=' + "From Zip Code" + '..' + '<=' + "To Zip Code");
        FreightZoneZip.SetFilter("From Zip Code", '>=%1', Rec."From Zip Code");
        FreightZoneZip.SetFilter("To Zip Code", '<=%1', Rec."To Zip Code");
        if FreightZoneZip.Find('-') then
            repeat
                if (FreightZoneZip."Freight Zone" <> Rec."Freight Zone") or (FreightZoneZip."Line No." <> Rec."Line No.") then
                    ErrorFound := true;
            until (FreightZoneZip.Next() = 0) or (ErrorFound);
        if ErrorFound then
            Error(Error1);
    end;

    trigger Oninsert()
    var
        FreightZoneZip: Record "Freight Zone Zip Code";
        ErrorFound: Boolean;
        Error1: Label 'The zip code range overlaps with an existing record. Please adjust the zip code range.', Comment = 'Dan="Postnummerområdet overlapper med et eksisterende postnummerområde. Juster venligst postnummerområdet."';
    begin
        "Zip Filter" := StrSubstNo('>=' + "From Zip Code" + '..' + '<=' + "To Zip Code");
        FreightZoneZip.SetFilter("From Zip Code", '>=%1', Rec."From Zip Code");
        FreightZoneZip.SetFilter("To Zip Code", '<=%1', Rec."To Zip Code");
        if FreightZoneZip.Find('-') then
            repeat
                if (FreightZoneZip."Freight Zone" <> Rec."Freight Zone") or (FreightZoneZip."Line No." <> Rec."Line No.") then
                    ErrorFound := true;
            until (FreightZoneZip.Next() = 0) or (ErrorFound);
        if ErrorFound then
            Error(Error1);
    end;


}
