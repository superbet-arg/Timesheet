@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Employees Project Assig Interf Project'

define view entity ZI_TS_empl_proj
  as select from ztts_empl_proj as EmplProj

  association        to parent ZI_TS_Project as _Project on  $projection.ClientId  = _Project.ClientId
                                                         and $projection.ProjectId = _Project.ProjectId
  association [0..1] to zi_ts_client         as _Client  on  $projection.ClientId = _Client.ClientId

{
        @Consumption.valueHelpDefinition: [{entity: { name: 'ZI_TS_EMPLOYEES_VH',
                                                element: 'EmployeeId' },
                                                additionalBinding: [{  element: 'ClientId' , localElement: 'ClientId' , usage:  #FILTER }]
                                                }]
  key employee_id as EmployeeId,
  key client_id   as ClientId,
  key project_id  as ProjectId,
      active      as Active,
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
       
      _Project,
      _Client
}
