CLASS lhc_Office DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setActive FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Office~setActive.

ENDCLASS.

CLASS lhc_Office IMPLEMENTATION.

  METHOD setActive.

   READ ENTITIES OF Zi_ts_client IN LOCAL MODE
  ENTITY Office
    FIELDS ( Active )
    WITH CORRESPONDING #( keys )
  RESULT DATA(Office).

 MODIFY ENTITIES OF Zi_ts_client IN LOCAL MODE
   ENTITY Office
     UPDATE FIELDS ( Active )
     WITH VALUE #( FOR officei IN Office  ( %tky          = officei-%tky
                                           Active = 'X' ) )
 REPORTED DATA(update_reported).

 "Set the changing parameter
 reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.
