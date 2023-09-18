CLASS z2ui5_cl_fw_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_client.

    DATA mo_handler TYPE REF TO z2ui5_cl_fw_handler.

    METHODS constructor
      IMPORTING
        handler TYPE REF TO z2ui5_cl_fw_handler.

  PROTECTED SECTION.

    METHODS set_arg_string
      IMPORTING
        val           TYPE string_table
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.



CLASS z2ui5_cl_fw_client IMPLEMENTATION.


  METHOD constructor.

    mo_handler = handler.

  ENDMETHOD.


  METHOD z2ui5_if_client~cursor_set.

    CLEAR mo_handler->ms_next-s_set-s_cursor.
    mo_handler->ms_next-s_set-s_cursor-id = id.
    mo_handler->ms_next-s_set-s_cursor-cursorpos = cursorpos.
    mo_handler->ms_next-s_set-s_cursor-selectionend = selectionend.
    mo_handler->ms_next-s_set-s_cursor-selectionstart = selectionstart.

  ENDMETHOD.


  METHOD z2ui5_if_client~get.

    CLEAR result.
    result-event = mo_handler->ms_actual-event.
    result-check_launchpad_active = mo_handler->ms_actual-check_launchpad_active.
    result-t_event_arg = mo_handler->ms_actual-t_event_arg.
    result-t_scroll_pos = mo_handler->ms_actual-t_scroll_pos.
    result-t_message_manager = mo_handler->ms_actual-t_message_manager.
    MOVE-CORRESPONDING mo_handler->ms_db TO result-s_draft.
    result-check_on_navigated = mo_handler->ms_actual-check_on_navigated.
    result-s_config = z2ui5_cl_fw_handler=>ss_config.

  ENDMETHOD.


  METHOD z2ui5_if_client~get_app.
    DATA temp1 TYPE REF TO z2ui5_if_app.
    temp1 ?= z2ui5_cl_fw_db=>load_app( id )-app.
    result = temp1.
  ENDMETHOD.


  METHOD z2ui5_if_client~message_box_display.

    CLEAR mo_handler->ms_next-s_set-s_msg_box.
    mo_handler->ms_next-s_set-s_msg_box-text = text.
    mo_handler->ms_next-s_set-s_msg_box-type = type.

  ENDMETHOD.


  METHOD z2ui5_if_client~message_toast_display.

    CLEAR mo_handler->ms_next-s_set-s_msg_toast.
    mo_handler->ms_next-s_set-s_msg_toast-text = text.

  ENDMETHOD.


  METHOD z2ui5_if_client~nav_app_call.
    mo_handler->ms_next-o_app_call = app.
  ENDMETHOD.


  METHOD z2ui5_if_client~nav_app_leave.
    mo_handler->ms_next-o_app_leave = app.
  ENDMETHOD.


  METHOD z2ui5_if_client~nest_view_destroy.

    mo_handler->ms_next-s_set-s_view_nest-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest_view_display.

    mo_handler->ms_next-s_set-s_view_nest-xml = val.
    mo_handler->ms_next-s_set-s_view_nest-id = id.
    mo_handler->ms_next-s_set-s_view_nest-method_destroy = method_destroy.
    mo_handler->ms_next-s_set-s_view_nest-method_insert = method_insert.

  ENDMETHOD.

  METHOD z2ui5_if_client~nest_view_display2.

    mo_handler->ms_next-s_set-s_view_nest2-xml = val.
    mo_handler->ms_next-s_set-s_view_nest2-id = id.
    mo_handler->ms_next-s_set-s_view_nest2-method_destroy = method_destroy.
    mo_handler->ms_next-s_set-s_view_nest2-method_insert = method_insert.

  ENDMETHOD.

  METHOD z2ui5_if_client~nest_view_model_update.

    mo_handler->ms_next-s_set-s_view_nest-check_update_model = abap_true.

  ENDMETHOD.

  METHOD z2ui5_if_client~nest_view_model_update2.

    mo_handler->ms_next-s_set-s_view_nest2-check_update_model = abap_true.

  ENDMETHOD.

  METHOD z2ui5_if_client~popover_destroy.

    mo_handler->ms_next-s_set-s_popover-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popover_display.

    mo_handler->ms_next-s_set-s_popover-check_destroy = abap_false.
    mo_handler->ms_next-s_set-s_popover-xml = xml.
    mo_handler->ms_next-s_set-s_popover-open_by_id = by_id.

  ENDMETHOD.


  METHOD z2ui5_if_client~popover_model_update.

    mo_handler->ms_next-s_set-s_popover-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_destroy.

    mo_handler->ms_next-s_set-s_popup-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_display.

    mo_handler->ms_next-s_set-s_popup-check_destroy = abap_false.
    mo_handler->ms_next-s_set-s_popup-xml = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_model_update.

    mo_handler->ms_next-s_set-s_popup-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~scroll_position_set.

    mo_handler->ms_next-s_set-t_scroll = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~timer_set.

    mo_handler->ms_next-s_set-s_timer-interval_ms    = interval_ms.
    mo_handler->ms_next-s_set-s_timer-event_finished = event_finished.

  ENDMETHOD.


  METHOD z2ui5_if_client~title_set.

    mo_handler->ms_next-s_set-title = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~url_param_set.

    mo_handler->ms_next-s_set-search = val.
    mo_handler->ms_actual-s_config-search = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_destroy.

    mo_handler->ms_next-s_set-s_view-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_display.

    mo_handler->ms_next-s_set-s_view-xml = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_model_update.

    mo_handler->ms_next-s_set-s_view-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind.

    DATA lo_binder TYPE REF TO z2ui5_cl_fw_binding.
    lo_binder = z2ui5_cl_fw_binding=>factory(
                        app   = mo_handler->ms_db-app
                        attri = mo_handler->ms_db-t_attri
                        check_attri = mo_handler->ms_db-check_attri
                        type  = z2ui5_cl_fw_binding=>cs_bind_type-one_way
                        data  = val
                        pretty_name = pretty_name
                      ).

    result = lo_binder->main( ).
    mo_handler->ms_db-t_attri = lo_binder->mt_attri.
    mo_handler->ms_db-check_attri = lo_binder->mv_check_attri.

    IF path = abap_false.
      result = `{` && result && `}`.
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind_local.

    DATA lo_binder TYPE REF TO z2ui5_cl_fw_binding.
    lo_binder = z2ui5_cl_fw_binding=>factory(
                        app   = mo_handler->ms_db-app
                        attri = mo_handler->ms_db-t_attri
                        check_attri = mo_handler->ms_db-check_attri
                        type  = z2ui5_cl_fw_binding=>cs_bind_type-one_time
                        data  = val
                        pretty_name = pretty_name
                      ).

    result = lo_binder->main( ).
    mo_handler->ms_db-t_attri = lo_binder->mt_attri.
    mo_handler->ms_db-check_attri = lo_binder->mv_check_attri.

    IF path = abap_false.
      result = `{` && result && `}`.
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind_edit.

    DATA lo_binder TYPE REF TO z2ui5_cl_fw_binding.
    lo_binder = z2ui5_cl_fw_binding=>factory(
                        app   = mo_handler->ms_db-app
                        attri = mo_handler->ms_db-t_attri
                        check_attri = mo_handler->ms_db-check_attri
                        type  = z2ui5_cl_fw_binding=>cs_bind_type-two_way
                        data  = val
                        view  = view
                        pretty_name = pretty_name
                      ).

    result = lo_binder->main( ).
    mo_handler->ms_db-t_attri = lo_binder->mt_attri.
    mo_handler->ms_db-check_attri = lo_binder->mv_check_attri.

    IF path = abap_false.
      result = `{` && result && `}`.
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_if_client~_event.

    result = `onEvent( { 'EVENT' : '` && val && `', 'METHOD' : 'UPDATE' , 'CHECK_VIEW_DESTROY' : ` && z2ui5_cl_fw_utility=>boolean_abap_2_json( check_view_destroy ) && ` }`.
    result = result && set_arg_string( t_arg ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_event_client.

    result = `onEventFrontend( { 'EVENT' : '` && val && `' }` && set_arg_string( t_arg ).

  ENDMETHOD.


  METHOD set_arg_string.
      DATA temp2 LIKE LINE OF val.
      DATA lr_arg LIKE REF TO temp2.
        DATA lv_new TYPE string.

    IF val IS NOT INITIAL.

      
      
      LOOP AT val REFERENCE INTO lr_arg.
        
        lv_new = lr_arg->*.
        IF lv_new IS INITIAL.
          CONTINUE.
        ENDIF.
        IF lv_new(1) <> `$` AND lv_new(1) <> `{`.
          lv_new = `"` && lv_new && `"`.
        ENDIF.
        result = result && `, ` && lv_new.
      ENDLOOP.

    ENDIF.

    result = result && `)`.

  ENDMETHOD.

  METHOD z2ui5_if_client~message_manager_add.

    mo_handler->ms_next-s_set-s_message_manager-t_message = val.

  ENDMETHOD.

    METHOD z2ui5_if_client~message_manager_clear.

    mo_handler->ms_next-s_set-s_message_manager-check_clear = abap_true.

  ENDMETHOD.

ENDCLASS.
