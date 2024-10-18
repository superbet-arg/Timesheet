@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Office Value Help'
@Consumption.valueHelpDefault.fetchValues: #AUTOMATICALLY_WHEN_DISPLAYED

define view entity ZI_TS_OFFICE_VH
  as select from ztts_office
{
  key office_id             as OfficeId,
  key client_id             as ClientId,
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
