@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Overtime Interface View'

define view entity ZI_TS_Overtime as select from ztts_overtime as Overtime

//association [1..1] to zi_ts_hours as _Hours on $projection.EntryId = _Hours.EntryId

{
    key entry_id as EntryId,
    ov_hours as OvHours,
    justification as Justification,
    
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
