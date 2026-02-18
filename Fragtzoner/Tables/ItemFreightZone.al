table 50202 "Item FreightZone"
{
    Caption = 'Item FreightZone', Comment = 'Dan="Vare Fragtzone"';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.', Comment = 'Dan="Varenummer"';
            tableRelation = Item;
        }
        field(2; "Item Certificate Attached"; Boolean)
        {
            Caption = 'Item Certificate Attached', Comment = 'Dan="Varecertifikat vedhæftet"';
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}
