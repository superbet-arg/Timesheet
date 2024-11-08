@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Hours Interface View'

define view entity zi_ts_hours as select from ztts_hours as Hours

//association [1..1] to ZI_TS_employees as _Employee on $projection.EmployeeId = _Employee.EmployeeId
//association [1..1] to ZI_TS_Empl_Proj as _EmplProject on $projection.ProjectId = _EmplProject.ProjectId and
//                                                         $projection.EmployeeId = _EmplProject.EmployeeId
//association [1..1] to ZI_TS_teams as _Teams on $projection.TeamId = _Teams.TeamId
//association [1..1] to ZI_TS_activity as _Activity on $projection.ActivityId = _Activity.ActivityId
//association [1..1] to ZI_TS_tasks as _Tasks on $projection.TaskId = _Tasks.TaskId

{
    key entry_id as EntryId,
    key employee_id as EmployeeId,
    key project_id as ProjectId,
    key zdate as Zdate,
    key team_id as TeamId,
    key activity_id as ActivityId,
    key task_id as TaskId,
    zhours as Zhours,
    description as Description,
    comments as Comments,
           @Semantics.user.createdBy: true
       created_by            as CreatedBy,
       @Semantics.systemDateTime.createdAt: true
       created_at            as CreatedAt,
       @Semantics.user.lastChangedBy: true
       last_changed_by       as LastChangedBy,
       @Semantics.systemDateTime.lastChangedAt: true
       last_changed_at       as LastChangedAt,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
       local_last_changed_at as LocalLastChangedAt
}
