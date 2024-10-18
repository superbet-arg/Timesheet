@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Interface View'

define view entity ZI_TS_Project
  as select from ztts_project as Project

  association to parent zi_ts_client   as _Client on $projection.ClientId = _Client.ClientId
  composition [0..*] of ZI_TS_activity as _Activity
  composition [0..*] of ZI_TS_teams    as _Teams
  composition [0..*] of zi_ts_tasks    as _Tasks
  composition [0..*] of zi_ts_empl_proj as _EmplProj


{
  key project_id  as ProjectId,
  key client_id   as ClientId,
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
       
      _Client,
      _Activity,
      _Teams,
      _Tasks,
      _EmplProj


}
