@EndUserText.label: 'Project Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_ts_project as projection on ZI_TS_Project as Project
{
    key ProjectId, 
        @Search.defaultSearchElement: true
    key ClientId,
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
    _Client : redirected to parent ZC_TS_CLIENT,
    _Activity: redirected to composition child ZC_TS_ACTIVITY ,
    _Teams : redirected to composition child ZC_TS_teams,
    _Tasks: redirected to composition child zc_ts_tasks,
    _EmplProj : redirected to composition child zc_ts_empl_proj
    
}
