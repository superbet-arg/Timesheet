@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tasks Interface view'

define view entity zi_ts_tasks
  as select from ztts_tasks

  association        to parent ZI_TS_Project as _Project on  $projection.ClientId  = _Project.ClientId
                                                         and $projection.ProjectId = _Project.ProjectId
  association [0..1] to zi_ts_client         as _Client  on  $projection.ClientId = _Client.ClientId

{
  key task_id               as TaskId,
  key client_id             as ClientId,
  key project_id            as ProjectId,
        @Consumption.valueHelpDefinition: [{entity: { name: 'ZI_TS_ACTIVITY_VH',
                                                element: 'ActivityId' },
                                                additionalBinding: [{  element: 'ClientId' , localElement: 'ClientId' , usage:  #FILTER },
                                                                    {  element: 'ProjectId' , localElement: 'ProjectId' , usage:  #FILTER }]
                                                }]
  key activity_id           as ActivityId,
      description           as Description,
      hours_est             as HoursEst,
      active                as Active,
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
