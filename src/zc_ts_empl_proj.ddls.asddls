@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employees Project Assigment Projection View'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_ts_empl_proj
  as projection on ZI_TS_empl_proj
{
  key EmployeeId,
      @Search.defaultSearchElement: true
  key ClientId,
      @Search.defaultSearchElement: true
  key ProjectId,
      @Search.defaultSearchElement: true
      Active,
      CreatedBy,
CreatedAt,
LastChangedBy,
LastChangedAt,
LocalLastChangedAt,

      /* Associations */
      _Project : redirected to parent zc_ts_project,
      _Client  : redirected to ZC_TS_CLIENT
}
