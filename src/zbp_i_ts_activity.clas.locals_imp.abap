CLASS lhc_Activity DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setActive FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Activity~setActive.

ENDCLASS.

CLASS lhc_Activity IMPLEMENTATION.

  METHOD setActive.

     READ ENTITIES OF Zi_ts_client IN LOCAL MODE
  ENTITY Activity
    FIELDS ( Active )
    WITH CORRESPONDING #( keys )
  RESULT DATA(Activity).

 MODIFY ENTITIES OF Zi_ts_client IN LOCAL MODE
   ENTITY Activity
     UPDATE FIELDS ( Active )
     WITH VALUE #( FOR Activityi IN Activity  ( %tky          = Activityi-%tky
                                                Active = 'X' ) )
 REPORTED DATA(update_reported).

 "Set the changing parameter
 reported = CORRESPONDING #( DEEP update_reported ).


  ENDMETHOD.

ENDCLASS.
