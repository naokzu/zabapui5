CLASS z2ui5_cl_popup_error DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    CLASS-METHODS factory
      IMPORTING
        error           TYPE ref to cx_root
        i_title         TYPE string DEFAULT `Error View`
        i_icon          TYPE string DEFAULT 'sap-icon://question-mark'
        i_button_text   TYPE string DEFAULT `OK`
      RETURNING
        VALUE(r_result) TYPE REF TO z2ui5_cl_popup_error.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA title TYPE string.
    DATA icon TYPE string.
    DATA question_text TYPE string.
    DATA button_text_confirm TYPE string.
    DATA check_initialized TYPE abap_bool.
    METHODS view_display.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_popup_error IMPLEMENTATION.

  METHOD factory.

    CREATE OBJECT r_result.
    r_result->title = i_title.
    r_result->icon = i_icon.
    r_result->question_text = error->get_text( ).
    r_result->button_text_confirm = i_button_text.

  ENDMETHOD.


  METHOD view_display.

    DATA popup TYPE REF TO Z2UI5_CL_XML_VIEW.
    popup = z2ui5_cl_xml_view=>factory_popup(  )->dialog(
                  title = title
                  icon = icon
                  afterclose = client->_event( 'BUTTON_CONFIRM' )
              )->content(
                  )->vbox( 'sapUiMediumMargin'
                      )->text( question_text
              )->get_parent( )->get_parent(
              )->footer( )->overflow_toolbar(
                  )->toolbar_spacer(
                  )->button(
                      text  = button_text_confirm
                      press = client->_event( 'BUTTON_CONFIRM' )
                      type  = 'Emphasized' ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      view_display( ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.
      WHEN `BUTTON_CONFIRM`.
        client->popup_destroy( ).
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
