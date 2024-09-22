CLASS z2ui5_cl_http_handler DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-DATA so_sticky_handler TYPE REF TO z2ui5_cl_core_http_post.

    CLASS-METHODS main
      IMPORTING
        body          TYPE string
        config        TYPE z2ui5_if_types=>ty_s_http_request_get OPTIONAL
      EXPORTING
        attributes    TYPE z2ui5_if_types=>ty_s_http_handler_attributes
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS http_post
      IMPORTING
        val           TYPE string
      EXPORTING
        attributes    TYPE z2ui5_if_types=>ty_s_http_handler_attributes
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS http_get
      IMPORTING
        val           TYPE z2ui5_if_types=>ty_s_http_request_get OPTIONAL
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_http_handler IMPLEMENTATION.


  METHOD http_get.

    DATA lo_get TYPE REF TO z2ui5_cl_core_http_get.
    CREATE OBJECT lo_get TYPE z2ui5_cl_core_http_get EXPORTING VAL = val.
    result = lo_get->main( ).

  ENDMETHOD.


  METHOD http_post.
      DATA lo_post TYPE REF TO z2ui5_cl_core_http_post.
    CLEAR attributes.

    IF so_sticky_handler IS NOT BOUND.
      
      CREATE OBJECT lo_post TYPE z2ui5_cl_core_http_post EXPORTING VAL = val.
    ELSE.
      so_sticky_handler = lo_post.
    ENDIF.
    result = lo_post->main(
      IMPORTING
        attributes = attributes ).

    so_sticky_handler = lo_post.

  ENDMETHOD.

  METHOD main.
      DATA lo_get TYPE REF TO z2ui5_cl_core_http_get.
        DATA lo_post TYPE REF TO z2ui5_cl_core_http_post.
          DATA temp1 TYPE REF TO z2ui5_if_app.
          DATA li_app LIKE temp1.
    CLEAR attributes.

    IF body IS INITIAL.
      
      CREATE OBJECT lo_get TYPE z2ui5_cl_core_http_get EXPORTING VAL = config.
      result = lo_get->main( ).
    ELSE.
      IF so_sticky_handler IS NOT BOUND.
        
        CREATE OBJECT lo_post TYPE z2ui5_cl_core_http_post EXPORTING VAL = body.
      ELSE.
        lo_post = so_sticky_handler.
        lo_post->mv_request_json = body.
      ENDIF.
*      DATA(lo_post) = NEW z2ui5_cl_core_http_post( body ).
      result = lo_post->main(
        IMPORTING
          attributes = attributes ).
    ENDIF.

    TRY.
        IF lo_post IS BOUND.
          
          temp1 ?= lo_post->mo_action->mo_app->mo_app.
          
          li_app = temp1.
          IF li_app->check_sticky = abap_true.
            so_sticky_handler = lo_post.
          ELSE.
            CLEAR so_sticky_handler.
          ENDIF.

        ENDIF.
      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
