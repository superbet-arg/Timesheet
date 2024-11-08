@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Activity'
@Consumption.valueHelpDefault.fetchValues: #AUTOMATICALLY_WHEN_DISPLAYED

define view entity ZI_TS_ACTIVITY_VH
  as select from ztts_activity
{
  key activity_id           as ActivityId,
  key client_id             as ClientId,
  key project_id            as ProjectId,
      description           as Description,
      active                as Active
//      @Semantics.user.createdBy: true
//      created_by            as CreatedBy,
//      @Semantics.systemDateTime.createdAt: true
//      created_at            as CreatedAt,
//      @Semantics.user.lastChangedBy: true
//      last_changed_by       as LastChangedBy,
//      @Semantics.systemDateTime.lastChangedAt: true
//      last_changed_at       as LastChangedAt,
//      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      local_last_changed_at as LocalLastChangedAt
}
