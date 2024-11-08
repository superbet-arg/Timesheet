@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Teams Projection View'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_TS_teams
  as projection on ZI_TS_teams
{
  key TeamId,
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
