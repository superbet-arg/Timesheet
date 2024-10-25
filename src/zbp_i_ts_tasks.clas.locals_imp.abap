CLASS lhc_Tasks DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateActivity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Tasks~validateActivity.
    METHODS setActive FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Tasks~setActive.

ENDCLASS.

CLASS lhc_Tasks IMPLEMENTATION.

  METHOD validateActivity.

        " Entity Manipulation Language to read the Employees by Project entered.
    READ ENTITIES OF zi_ts_client IN LOCAL MODE
    ENTITY Tasks
    FIELDS ( TaskID ClientId ProjectID ActivityID ) WITH CORRESPONDING #( keys )
    RESULT DATA(Tasks).

    IF Tasks IS NOT INITIAL.
      " Check if Office ID exist
      SELECT FROM ztts_activity FIELDS activity_id, client_id, project_id, Active
        FOR ALL ENTRIES IN @Tasks
        WHERE activity_id = @Tasks-ActivityId and
              client_id = @Tasks-ClientId AND
              project_id = @Tasks-ProjectId
        INTO TABLE @DATA(tasks_db).
    ENDIF.

    DATA lo_message TYPE REF TO if_abap_behv_message.

    LOOP AT Tasks ASSIGNING FIELD-SYMBOL(<fs_tasks>).

      READ TABLE tasks_db INTO DATA(wa_tasks_db) WITH KEY activity_id = <fs_tasks>-ActivityId
                                                          client_id = <fs_tasks>-ClientId
                                                          project_id = <fs_tasks>-ProjectId.

      IF sy-subrc NE 0.

        lo_message = me->new_message(
        id = 'ZRAP_TS_MSG'
        number = 003 " Activity &1 was not mainteined in Activities table.
        severity = ms-error
        v1 = <fs_tasks>-ActivityId
      ).

        " Appending the message to the RAP runtime to show it to the user.
        APPEND VALUE #(
          %tky = <fs_tasks>-%tky
          %msg = lo_message
          %element-activityid = if_abap_behv=>mk-on
          %element-clientid = if_abap_behv=>mk-on
          %element-projectid = if_abap_behv=>mk-on
        ) TO reported-Tasks.

        " Abort the save by adding an entry to the failed component.
        APPEND VALUE #(
          %tky = <fs_tasks>-%tky
          ActivityId = <fs_tasks>-ActivityID
          ClientId = <fs_tasks>-ClientID
          ProjectId = <fs_tasks>-ProjectId
        ) TO failed-Tasks.

      else.

      IF wa_tasks_db-active IS INITIAL.

              lo_message = me->new_message(
                   id = 'ZRAP_TS_MSG'
                   number = 004 " Activity &1 was not mainteined in Activities table.
                   severity = ms-error
                   v1 = 'Activity'
                   v2 = <fs_tasks>-ActivityId
                ).

        " Appending the message to the RAP runtime to show it to the user.
        APPEND VALUE #(
          %tky = <fs_tasks>-%tky
          %msg = lo_message
          %element-activityid = if_abap_behv=>mk-on
          %element-clientid = if_abap_behv=>mk-on
          %element-projectid = if_abap_behv=>mk-on
        ) TO reported-Tasks.

        " Abort the save by adding an entry to the failed component.
        APPEND VALUE #(
          %tky = <fs_tasks>-%tky
          ActivityId = <fs_tasks>-ActivityID
          ClientId = <fs_tasks>-ClientID
          ProjectId = <fs_tasks>-ProjectId
        ) TO failed-Tasks.

             endif.

      ENDIF.

  ENDLOOP.



  ENDMETHOD.

  METHOD setActive.

     READ ENTITIES OF Zi_ts_client IN LOCAL MODE
  ENTITY Tasks
    FIELDS ( Active )
    WITH CORRESPONDING #( keys )
  RESULT DATA(Tasks).

 MODIFY ENTITIES OF Zi_ts_client IN LOCAL MODE
   ENTITY Tasks
     UPDATE FIELDS ( Active )
     WITH VALUE #( FOR Tasksi IN Tasks  ( %tky          = Tasksi-%tky
                                           Active = 'X' ) )
 REPORTED DATA(update_reported).

 "Set the changing parameter
 reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.
