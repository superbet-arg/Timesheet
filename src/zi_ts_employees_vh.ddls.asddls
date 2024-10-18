@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employees VH'
@Consumption.valueHelpDefault.fetchValues: #AUTOMATICALLY_WHEN_DISPLAYED
define view entity ZI_TS_EMPLOYEES_VH as select from ztts_employees
{
    key employee_id as EmployeeId,
    key client_id as ClientId,
    name as Name,
    office_id as OfficeId,
    active as Active

}
