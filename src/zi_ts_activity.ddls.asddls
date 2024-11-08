@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Activity interface View'

define view entity ZI_TS_activity
  as select from ztts_activity as Activity

  association        to parent ZI_TS_Project as _Project on  $projection.ClientId  = _Project.ClientId
                                                         and $projection.ProjectId = _Project.ProjectId
  association [0..1] to zi_ts_client         as _Client  on  $projection.ClientId = _Client.ClientId

{
  key activity_id as ActivityId,
  key client_id   as ClientId,
  key project_id  as ProjectId,
      description as Description,
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
