@EndUserText.label: 'Client Projection View'
@Search.searchable: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_TS_CLIENT as projection on zi_ts_client as Clients
{
    key ClientId,
    @Search.defaultSearchElement: true
    ClientDesc,
    @Search.defaultSearchElement: true
    Active,
CreatedBy,
CreatedAt,
LastChangedBy,
LastChangedAt,
LocalLastChangedAt,

    /* Associations */
    _Project : redirected to composition child zc_ts_project,
    _Office : redirected to composition child zc_ts_office,
    _Employees : redirected to composition child zc_ts_employees
}
