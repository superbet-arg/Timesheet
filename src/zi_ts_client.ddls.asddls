@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Client Interface View'

define root view entity zi_ts_client as select from ztts_client as Clients

composition [0..*] of ZI_TS_Project as _Project  
composition [0..*] of ZI_TS_OFFICE as _Office
composition [0..*] of ZI_TS_EMPLOYEES as _Employees

{
    key client_id as ClientId,
    client_desc as ClientDesc,
    active as Active,
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
    _Office,
    _Employees
}
