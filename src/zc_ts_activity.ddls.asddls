@EndUserText.label: 'Activity Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_TS_ACTIVITY
  as projection on ZI_TS_activity
{
  key ActivityId,
      @Search.defaultSearchElement: true
  key ClientId,
      @Search.defaultSearchElement: true
  key ProjectId,
      @Search.defaultSearchElement: true
      Description,
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
