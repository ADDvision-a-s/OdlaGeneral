xmlport 50100 "Import Item Attributes"
{
    Caption = 'Import Item Attributes', Comment = 'DAN="Importér vareattributter"';
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)

            {
                AutoSave = false;
                AutoReplace = false;
                AutoUpdate = false;

                textelement(ItemAttributeValue1)
                {
                }
                textelement(ItemAttributeValue2)
                {
                }
                textelement(ItemAttributeValue3)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue4)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue5)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue6)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue7)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue8)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue9)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue10)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue11)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue12)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue13)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue14)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue15)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue16)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue17)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue18)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue19)
                {
                    MinOccurs = Zero;
                }
                textelement(ItemAttributeValue20)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
                    Attrib: Record "Item Attribute";
                    AttribValue: Record "Item Attribute Value";
                    AttributeId: Integer;
                begin
                    if CurrRec = 0 then begin
                        AttribCounter := 0;
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue2);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue3);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue4);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue5);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue6);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue7);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue8);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue9);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue10);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue11);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue12);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue13);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue14);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue15);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue16);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue17);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue18);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue19);
                        CheckCreateItemAttribute(Attrib, ItemAttributeValue20);
                        //FirstRecord - Headervalues
                    end;
                    if CurrRec <> 0 then begin
                        if Item.Get(ItemAttributeValue1) then begin
                            CheckCreateItemAttributeValue(ItemAttribIds[1], AttribValue, ItemAttributeValue2);
                            CheckCreateItemAttributeValue(ItemAttribIds[2], AttribValue, ItemAttributeValue3);
                            CheckCreateItemAttributeValue(ItemAttribIds[3], AttribValue, ItemAttributeValue4);
                            CheckCreateItemAttributeValue(ItemAttribIds[4], AttribValue, ItemAttributeValue5);
                            CheckCreateItemAttributeValue(ItemAttribIds[5], AttribValue, ItemAttributeValue6);
                            CheckCreateItemAttributeValue(ItemAttribIds[6], AttribValue, ItemAttributeValue7);
                            CheckCreateItemAttributeValue(ItemAttribIds[7], AttribValue, ItemAttributeValue8);
                            CheckCreateItemAttributeValue(ItemAttribIds[8], AttribValue, ItemAttributeValue9);
                            CheckCreateItemAttributeValue(ItemAttribIds[9], AttribValue, ItemAttributeValue10);
                            CheckCreateItemAttributeValue(ItemAttribIds[10], AttribValue, ItemAttributeValue11);
                            CheckCreateItemAttributeValue(ItemAttribIds[11], AttribValue, ItemAttributeValue12);
                            CheckCreateItemAttributeValue(ItemAttribIds[12], AttribValue, ItemAttributeValue13);
                            CheckCreateItemAttributeValue(ItemAttribIds[13], AttribValue, ItemAttributeValue14);
                            CheckCreateItemAttributeValue(ItemAttribIds[14], AttribValue, ItemAttributeValue15);
                            CheckCreateItemAttributeValue(ItemAttribIds[15], AttribValue, ItemAttributeValue16);
                            CheckCreateItemAttributeValue(ItemAttribIds[16], AttribValue, ItemAttributeValue17);
                            CheckCreateItemAttributeValue(ItemAttribIds[17], AttribValue, ItemAttributeValue18);
                            CheckCreateItemAttributeValue(ItemAttribIds[18], AttribValue, ItemAttributeValue19);
                            CheckCreateItemAttributeValue(ItemAttribIds[19], AttribValue, ItemAttributeValue20);
                        ItemsImported += 1;
                        end else begin
                            ItemsNotExisting += 1;
                        end;
                    end;
                    Window.Update();
                    CurrRec += 1;
                    currXMLport.skip;
                end;

            }
        }

    }
    var
        AttribCounter: Integer;
        CurrRec: Integer;
        ItemAttribIds: array[20] of Integer;
        Window: Dialog;
        Text001: Label 'Importing #####1###. Please wait... items not found: ######2#####', Comment = 'DAN="Importerer #####1###. Vent venligst... varer ikke fundet: ######2#####"';
        ItemsImported: Integer;
        ItemsNotExisting: Integer;

    procedure CheckCreateItemAttribute(var Attrib: Record "Item Attribute"; AttribName: Text[250]) AttribId: Integer
    var
    begin
        AttribCounter += 1;
        if StrLen(AttribName) = 0 then
            exit(0);
        Clear(Attrib);
        Attrib.SetFilter(Name, '@' + AttribName);
        if Attrib.FindFirst() = false then begin
            Attrib.Init();
            Attrib.Validate(Name, AttribName);
            Attrib.Insert(true);
        end;
        ItemAttribIds[AttribCounter] := Attrib.ID;
    end;

    trigger OnPreXmlPort()
    var
    begin
        Window.Open(Text001, ItemsImported, ItemsNotExisting);
    end;

    procedure CheckCreateItemAttributeValue(ItemAttributeId: Integer; var AttribValue: Record "Item Attribute Value"; AttribValueName: Text[250])
    var
    begin
        if ItemAttributeId = 0 then
            exit;
        Clear(AttribValue);
        if (StrLen(AttribValueName) <> 0) then begin
            AttribValue.SetRange(Value, AttribValueName);
            AttribValue.SetRange("Attribute ID", ItemAttributeId);
            if AttribValue.FindFirst() = false then begin
                AttribValue.Init();
                AttribValue.Validate("Attribute ID", ItemAttributeId);
                AttribValue.Validate(Value, AttribValueName);
                AttribValue.Insert(true);
            end;
        end;
        UpdateItemAttributeMapping(Item."No.", ItemAttributeId, AttribValue.ID);
    end;

    procedure UpdateItemAttributeMapping(ItemNo: Code[20]; ItemAttributeId: Integer; ItemAttributeValueId: Integer)
    var
        ItemAttribValueMapping: Record "Item Attribute Value Mapping";
        DeleteIfExists: Boolean;
    begin
        if ItemAttributeId = 0 then
            exit;
        if ItemAttributeValueId = 0 then
            DeleteIfExists := true;
        ItemAttribValueMapping.SetRange("Table ID", DATABASE::Item);
        ItemAttribValueMapping.SetRange("No.", ItemNo);
        ItemAttribValueMapping.SetRange("Item Attribute ID", ItemAttributeId);
        if ItemAttribValueMapping.FindFirst() then begin
            if DeleteIfExists then begin
                ItemAttribValueMapping.Delete();
            end else begin
                ItemAttribValueMapping.Validate("Item Attribute Value ID", ItemAttributeValueId);
                ItemAttribValueMapping.Modify(true);
            end;
        end else if not DeleteIfExists then begin
            ItemAttribValueMapping.Init();
            ItemAttribValueMapping.Validate("Table ID", DATABASE::Item);
            ItemAttribValueMapping.validate("No.", ItemNo);
            ItemAttribValueMapping."Item Attribute ID" := ItemAttributeId;
            ItemAttribValueMapping.Validate("Item Attribute Value ID", ItemAttributeValueId);
            ItemAttribValueMapping.Insert(true);
        end;
    end;
}

