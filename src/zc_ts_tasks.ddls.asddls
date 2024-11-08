@EndUserText.label: 'Tasks Projection View'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_ts_tasks
  as projection on zi_ts_tasks
{
  key TaskId,
      @Search.defaultSearchElement: true
  key ClientId,
      @Search.defaultSearchElement: true
  key ProjectId,
      @Search.defaultSearchElement: true
  key ActivityId,
      @Search.defaultSearchElement: true
      Description,
      HoursEst,
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
