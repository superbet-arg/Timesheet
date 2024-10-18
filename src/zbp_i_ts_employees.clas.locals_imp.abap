CLASS lhc_Employees DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateOffice FOR VALIDATE ON SAVE
      IMPORTING keys FOR Employees~validateOffice.

ENDCLASS.

CLASS lhc_Employees IMPLEMENTATION.

  METHOD validateOffice.

    " Entity Manipulation Language to read the Office entered.
    READ ENTITIES OF zi_ts_client IN LOCAL MODE
    ENTITY Employees
    FIELDS ( EmployeeID ClientId OfficeId ) WITH CORRESPONDING #( keys )
    RESULT DATA(Employee).

    IF Employee IS NOT INITIAL.
      " Check if Office ID exist
      SELECT FROM ztts_office FIELDS client_id, office_id, Active
        FOR ALL ENTRIES IN @Employee
        WHERE client_id = @Employee-ClientId AND
              office_id = @Employee-OfficeId
        INTO TABLE @DATA(office_db).
    ENDIF.

    DATA lo_message TYPE REF TO if_abap_behv_message.

    LOOP AT Employee ASSIGNING FIELD-SYMBOL(<fs_employee>).

      READ TABLE office_db INTO DATA(wa_office_db) WITH KEY client_id = <fs_employee>-ClientId
                                                            office_id = <fs_employee>-OfficeId.

      IF sy-subrc NE 0.

        lo_message = me->new_message(
        id = 'ZRAP_TS_MSG'
        number = 001 " Office &1 was not maintained in Office table..
        severity = ms-error
        v1 = <fs_employee>-OfficeId
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

      ELSE.

* Validate Office is active.
        IF wa_office_db-active IS INITIAL.

          lo_message = me->new_message(
              id = 'ZRAP_TS_MSG'
              number = 004 " &1 &2 is not active.
              severity = ms-error
              v1 = 'Office'
              v2 = <fs_employee>-OfficeId
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

        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
