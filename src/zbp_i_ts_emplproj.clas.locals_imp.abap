CLASS lhc_EmplProj DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateEmployee FOR VALIDATE ON SAVE
      IMPORTING keys FOR EmplProj~validateEmployee.

ENDCLASS.

CLASS lhc_EmplProj IMPLEMENTATION.

  METHOD validateEmployee.


      " Entity Manipulation Language to read the Employees by Project entered.
    READ ENTITIES OF zi_ts_client IN LOCAL MODE
    ENTITY EmplProj
    FIELDS ( EmployeeID ClientId ) WITH CORRESPONDING #( keys )
    RESULT DATA(Employee).

    IF Employee IS NOT INITIAL.
      " Check if Office ID exist
      SELECT FROM ztts_employees FIELDS client_id, employee_id, Active
        FOR ALL ENTRIES IN @Employee
        WHERE client_id = @Employee-ClientId AND
              employee_id = @Employee-EmployeeId
        INTO TABLE @DATA(employee_db).
    ENDIF.

    DATA lo_message TYPE REF TO if_abap_behv_message.

    LOOP AT Employee ASSIGNING FIELD-SYMBOL(<fs_employee>).

      READ TABLE employee_db INTO DATA(wa_employee_db) WITH KEY client_id = <fs_employee>-ClientId
                                                             Employee_id = <fs_employee>-EmployeeId.

      IF sy-subrc NE 0.

        lo_message = me->new_message(
        id = 'ZRAP_TS_MSG'
        number = 002 " Office &1 was not maintained in Office table..
        severity = ms-error
        v1 = <fs_employee>-EmployeeId
        v2 = <fs_Employee>-ClientId
      ).

        " Appending the message to the RAP runtime to show it to the user.
        APPEND VALUE #(
          %tky = <fs_employee>-%tky
          %msg = lo_message
*          %element-clientid = if_abap_behv=>mk-on
*          %element-employeeid = if_abap_behv=>mk-on
           %element-officeid = if_abap_behv=>mk-on
        ) TO reported-Employees.

        " Abort the save by adding an entry to the failed component.
        APPEND VALUE #(
          %tky = <fs_employee>-%tky
          ClientId = <fs_employee>-ClientID
          EmployeeId = <fs_employee>-EmployeeId
        ) TO failed-Employees.

      else.

           IF wa_employee_db-active IS INITIAL.

         lo_message = me->new_message(
        id = 'ZRAP_TS_MSG'
        number = 004 " Office &1 was not maintained in Office table..
        severity = ms-error
        v1 = 'Employee'
        v2 = <fs_employee>-EmployeeId
      ).

        " Appending the message to the RAP runtime to show it to the user.
        APPEND VALUE #(
          %tky = <fs_employee>-%tky
          %msg = lo_message
*          %element-clientid = if_abap_behv=>mk-on
*          %element-employeeid = if_abap_behv=>mk-on
           %element-officeid = if_abap_behv=>mk-on
        ) TO reported-Employees.

        " Abort the save by adding an entry to the failed component.
        APPEND VALUE #(
          %tky = <fs_employee>-%tky
          ClientId = <fs_employee>-ClientID
          EmployeeId = <fs_employee>-EmployeeId
        ) TO failed-Employees.


           endif.

      ENDIF.

  ENDLOOP.



  ENDMETHOD.

ENDCLASS.
