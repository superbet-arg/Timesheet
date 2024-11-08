@EndUserText.label: 'Office Projection View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_ts_office as projection on ZI_TS_OFFICE
{
    key OfficeId,
    @Search.defaultSearchElement: true
    key ClientId,
    @Search.defaultSearchElement: true
    Description,
    @Search.defaultSearchElement: true
    Active,
    CreatedBy,
CreatedAt,
LastChangedBy,
LastChangedAt,
LocalLastChangedAt,
    /* Associations */
    _Client : redirected to parent ZC_TS_CLIENT
}
