@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Employees Projection View'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_ts_employees
  as projection on ZI_TS_EMPLOYEES
{
  key EmployeeId,
      @Search.defaultSearchElement: true
  key ClientId,
      @Search.defaultSearchElement: true
      Name,
      @Search.defaultSearchElement: true
      OfficeId,
      @Search.defaultSearchElement: true
      HoursDay,
      @Search.defaultSearchElement: true
      Active,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      /* Associations */
      _Client : redirected to parent ZC_TS_CLIENT,
      _Office
}
