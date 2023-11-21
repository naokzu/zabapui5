CLASS ltcl_integration_test DEFINITION FINAL FOR TESTING
  DURATION long
  RISK LEVEL harmless.

  PUBLIC SECTION.


  PRIVATE SECTION.
    METHODS test_index_html FOR TESTING RAISING cx_static_check.
    METHODS test_xml_view      FOR TESTING RAISING cx_static_check.
    METHODS test_id            FOR TESTING RAISING cx_static_check.
    METHODS test_xml_popup     FOR TESTING RAISING cx_static_check.
    METHODS test_bind_one_way  FOR TESTING RAISING cx_static_check.
    METHODS test_bind_two_way  FOR TESTING RAISING cx_static_check.
    METHODS test_message_toast FOR TESTING RAISING cx_static_check.
    METHODS test_message_box   FOR TESTING RAISING cx_static_check.
    METHODS test_landing_page  FOR TESTING RAISING cx_static_check.
    METHODS test_scroll_cursor FOR TESTING RAISING cx_static_check.
    METHODS test_navigate      FOR TESTING RAISING cx_static_check.
    METHODS test_startup_path  FOR TESTING RAISING cx_static_check.

    METHODS test_app_change_value FOR TESTING RAISING cx_static_check.
    METHODS test_app_event        FOR TESTING RAISING cx_static_check.
    METHODS test_app_dump         FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_integration_test IMPLEMENTATION.

  METHOD test_xml_view.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = ``.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
        `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    
    UNASSIGN <val>.
    
    lv_assign = `PARAMS->S_VIEW->XML->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    <val> = shift_left( <val> ).
    IF <val>(9) <> `<mvc:View`.
      cl_abap_unit_assert=>fail( msg  = 'xml view - intital view wrong' ).
    ENDIF.

  ENDMETHOD.

  METHOD test_index_html.

    DATA lv_index_html TYPE string.
    lv_index_html = z2ui5_cl_fw_http_handler=>http_get( ).
    IF lv_index_html IS INITIAL.
      cl_abap_unit_assert=>fail( 'HTTP GET - index html initial' ).
    ENDIF.

  ENDMETHOD.


  METHOD test_id.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = ``.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    
    UNASSIGN <val>.
    
    lv_assign = `ID->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> IS INITIAL.
      cl_abap_unit_assert=>fail( msg  = 'id - initial value is initial'
                                 quit = 5 ).
    ENDIF.
  ENDMETHOD.

  METHOD test_bind_one_way.

    DATA lo_test TYPE REF TO z2ui5_cl_fw_integration_test.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.
    CREATE OBJECT lo_test TYPE z2ui5_cl_fw_integration_test.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_ONE_WAY`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).


    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    
    UNASSIGN <val>.
    
    lv_assign = `OVIEWMODEL->QUANTITY->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `500`.
      cl_abap_unit_assert=>fail( msg  = 'data binding - initial set EDIT wrong'
                                 quit = 5 ).
    ENDIF.
  ENDMETHOD.

  METHOD test_bind_two_way.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = ``.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    
    UNASSIGN <val>.
    
    lv_assign = `OVIEWMODEL->EDIT->QUANTITY->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `500`.
      cl_abap_unit_assert=>fail( msg  = 'data binding - initial set EDIT wrong'
                                 quit = 5 ).
    ENDIF.
  ENDMETHOD.

  METHOD test_message_box.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_MESSAGE_BOX`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    

    UNASSIGN <val>.
    
    lv_assign = `PARAMS->S_MSG_BOX->TEXT->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `test message box`.
      cl_abap_unit_assert=>fail( msg  = 'message box - text wrong'
                                 quit = 5 ).
    ENDIF.

    UNASSIGN <val>.
    lv_assign = `PARAMS->S_MSG_BOX->TYPE->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `information`.
      cl_abap_unit_assert=>fail( msg  = 'message box - type wrong'
                                 quit = 5 ).
    ENDIF.
  ENDMETHOD.

  METHOD test_message_toast.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_MESSAGE_TOAST`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    

    UNASSIGN <val>.
    
    lv_assign = `PARAMS->S_MSG_TOAST->TEXT->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `test message toast`.
      cl_abap_unit_assert=>fail( msg  = 'message toast - text wrong'
                                 quit = 5 ).
    ENDIF.

  ENDMETHOD.


  METHOD test_xml_popup.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_POPUP`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

    
    UNASSIGN <val>.
    
    lv_assign = `PARAMS->S_POPUP->XML->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    <val> = shift_left( <val> ).
    IF <val>(9) <> `<mvc:View`.
      cl_abap_unit_assert=>fail( msg  = 'xml popup - intital popup wrong'
                                 quit = 5 ).
    ENDIF.
  ENDMETHOD.

  METHOD test_landing_page.

*    DATA(lv_response) = z2ui5_cl_fw_http_handler=>http_post(
*       `{ "OLOCATION" : { "SEARCH" : ""}}` ).
*
*    DATA lo_data TYPE REF TO data.
*    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
*                               CHANGING  data = lo_data ).
*
*    FIELD-SYMBOLS <val> TYPE any.
*    UNASSIGN <val>.
*    DATA(lv_assign) = `PARAMS->S_VIEW->XML->*`.
*    ASSIGN lo_data->(lv_assign) TO <val>.
*    <val> = shift_left( <val> ).
*    IF <val> NS `Step 4`.
*      cl_abap_unit_assert=>fail( msg  = 'landing page - not started when no app'
*                                 quit = 5 ).
*    ENDIF.
  ENDMETHOD.

  METHOD test_scroll_cursor.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_SCROLL_CURSOR`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

  ENDMETHOD.

  METHOD test_startup_path.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_NAVIGATE`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
      `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

  ENDMETHOD.

  METHOD test_navigate.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.

    z2ui5_cl_fw_integration_test=>sv_state = `TEST_NAVIGATE`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(
       `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lo_data ).

  ENDMETHOD.


  METHOD test_app_change_value.

    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.
    DATA temp3 TYPE string.
    DATA lv_id LIKE temp3.
    DATA lv_request TYPE string.
    lv_response = z2ui5_cl_fw_http_handler=>http_post(  `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize(
      EXPORTING
         json            = lv_response
      CHANGING
        data             = lo_data ).

    

    UNASSIGN <val>.
    
    lv_assign = `ID->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> IS INITIAL.
      cl_abap_unit_assert=>fail( msg = 'id - initial value is initial' quit = 5 ).
    ENDIF.
    
    temp3 = <val>.
    
    lv_id = temp3.

    
    lv_request = `{ "VIEWNAME": "MAIN" , "EDIT":{"QUANTITY":"600"},"ID": "` && lv_id && `" ,"ARGUMENTS":[{"EVENT":"BUTTON_POST","METHOD":"UPDATE"}]}`.
    lv_response = z2ui5_cl_fw_http_handler=>http_post( lv_request ).

    CLEAR lo_data.
    /ui2/cl_json=>deserialize(
      EXPORTING
         json            = lv_response
      CHANGING
        data             = lo_data ).

    UNASSIGN <val>.
    lv_assign = `OVIEWMODEL->EDIT->QUANTITY->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    IF <val> <> `600`.
      cl_abap_unit_assert=>fail( msg = 'data binding - frontend updated value wrong after roundtrip' quit = 5 ).
    ENDIF.


  ENDMETHOD.

  METHOD test_app_event.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_assign TYPE string.
    DATA temp4 TYPE string.
    DATA lv_id LIKE temp4.
    DATA lv_request TYPE string.

    z2ui5_cl_fw_integration_test=>sv_state = ``.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post(  `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize(
      EXPORTING
         json            = lv_response
      CHANGING
        data             = lo_data ).

    

    UNASSIGN <val>.
    
    lv_assign = `ID->*`.
    ASSIGN lo_data->(lv_assign) TO <val>.
    cl_abap_unit_assert=>assert_not_initial( <val> ).


    
    temp4 = <val>.
    
    lv_id = temp4.
    
    lv_request = `{"EDIT":{"QUANTITY":"700"},"ID": "` && lv_id && `" ,"ARGUMENTS": [{"EVENT":"BUTTON_POST","METHOD":"UPDATE"}], "VIEWNAME" : "MAIN"}`.
    lv_response = z2ui5_cl_fw_http_handler=>http_post( lv_request ).

    CLEAR lo_data.
    /ui2/cl_json=>deserialize(
      EXPORTING
         json            = lv_response
      CHANGING
        data             = lo_data ).

    UNASSIGN <val>.
    ASSIGN (`LO_DATA->PARAMS->*`) TO <val>.
    ASSIGN (`<VAL>-S_MSG_TOAST->*`) TO <val>.
    ASSIGN (`<VAL>-TEXT->*`) TO <val>.
    cl_abap_unit_assert=>assert_not_initial( <val> ).

*    cl_abap_unit_assert=>assert_equals(
*        act                  = <val>
*        exp                  = `tomato 700 - send to the server` ).

  ENDMETHOD.

  METHOD test_app_dump.
    DATA lv_response TYPE string.
    DATA lo_data TYPE REF TO data.
    FIELD-SYMBOLS <val> TYPE any.
    DATA lv_text TYPE string .

    z2ui5_cl_fw_integration_test=>sv_state = `ERROR`.
    
    lv_response = z2ui5_cl_fw_http_handler=>http_post( `{ "OLOCATION" : { "SEARCH" : "app_start=z2ui5_cl_fw_integration_test"}}` ).

    
    /ui2/cl_json=>deserialize(
      EXPORTING
         json            = lv_response
      CHANGING
        data             = lo_data ).

    
    
    UNASSIGN <val>.
    ASSIGN (`LO_DATA->PARAMS->S_VIEW->XML->*`) TO <val>.
    cl_abap_unit_assert=>assert_not_initial( <val> ).

*    lv_text = <val>.
*    lv_text = shift_left( lv_text ).
*    IF lv_text NS `An exception with the type CX_SY_ZERODIVIDE was raised`.
*      cl_abap_unit_assert=>fail( msg = 'system app error - not shown by exception' quit = 5 ).
*    ENDIF.

  ENDMETHOD.


ENDCLASS.