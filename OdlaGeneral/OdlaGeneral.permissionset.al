namespace Odla;

using OdlaGeneral.OdlaGeneral;

permissionset 50100 OdlaGeneral
{
    Assignable = true;
    Permissions = tabledata ItemAttribMap_Shpfy_Meta=RIMD,
        table ItemAttribMap_Shpfy_Meta=X,
        xmlport "Import Item Attributes"=X,
        page "Item Attribute Map To Shpfy"=X,
        report "Synchronize Attributes Shpfy"=X,
        codeunit Odla_Utils=X,
        codeunit "Create Vendor pricelist"=X;
}