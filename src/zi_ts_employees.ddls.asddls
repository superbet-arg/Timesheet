@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employees Interface View'

define view entity ZI_TS_EMPLOYEES
  as select from ztts_employees

  association        to parent zi_ts_client as _Client on $projection.ClientId = _Client.ClientId
  association [0..1] to ZI_TS_OFFICE        as _Office on $projection.OfficeId = _Office.OfficeId

{
  key employee_id as EmployeeId,
  key client_id   as ClientId,
      name        as Name,
      active      as Active,
      @Consumption.valueHelpDefinition: [{entity: { name: 'ZI_TS_OFFICE_VH',
                                                element: 'OfficeId' },
                                                additionalBinding: [{  element: 'ClientId' , localElement: 'ClientId' , usage:  #FILTER }]
                                                }]
      office_id   as OfficeId,
       @Semantics.user.createdBy: true
       created_by            as CreatedBy,
       @Semantics.systemDateTime.createdAt: true
       created_at            as CreatedAt,
       @Semantics.user.lastChangedBy: true
       last_changed_by       as LastChangedBy,
       @Semantics.systemDateTime.lastChangedAt: true
       last_changed_at       as LastChangedAt,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
       local_last_changed_at as LocalLastChangedAt,
       
      _Client,
      _Office
}
