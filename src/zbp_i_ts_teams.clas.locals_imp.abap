CLASS lhc_Teams DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setActive FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Teams~setActive.

ENDCLASS.

CLASS lhc_Teams IMPLEMENTATION.

  METHOD setActive.

     READ ENTITIES OF Zi_ts_client IN LOCAL MODE
  ENTITY Teams
    FIELDS ( Active )
    WITH CORRESPONDING #( keys )
  RESULT DATA(Teams).

 MODIFY ENTITIES OF Zi_ts_client IN LOCAL MODE
   ENTITY Teams
     UPDATE FIELDS ( Active )
     WITH VALUE #( FOR Teamsi IN Teams  ( %tky          = Teamsi-%tky
                                           Active = 'X' ) )
 REPORTED DATA(update_reported).

 "Set the changing parameter
 reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.
