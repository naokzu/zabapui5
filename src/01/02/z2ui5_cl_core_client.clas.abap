CLASS z2ui5_cl_core_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_client .

    DATA mo_action TYPE REF TO z2ui5_cl_core_action.

    METHODS constructor
      IMPORTING
        !action TYPE REF TO z2ui5_cl_core_action.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_core_client IMPLEMENTATION.


  METHOD constructor.

    mo_action = action.

  ENDMETHOD.


  METHOD z2ui5_if_client~clear.

    IF val = z2ui5_if_client=>cs_clear-view.
      CLEAR mo_action->ms_next-s_set-s_view.
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_if_client~get.
        DATA lo_params TYPE REF TO z2ui5_if_ajson.
        DATA temp1 LIKE LINE OF lo_params->mt_json_tree.
        DATA lr_comp LIKE REF TO temp1.
          DATA temp2 TYPE z2ui5_if_types=>ty_s_name_value.

    CLEAR result.
    result-event = mo_action->ms_actual-event.
    result-check_launchpad_active = mo_action->mo_http_post->ms_request-s_control-check_launchpad.
    result-t_event_arg = mo_action->ms_actual-t_event_arg.
    MOVE-CORRESPONDING mo_action->mo_app->ms_draft TO result-s_draft.
    result-check_on_navigated = mo_action->ms_actual-check_on_navigated.
    MOVE-CORRESPONDING mo_action->mo_http_post->ms_request-s_front TO result-s_config.

    TRY.
        
        lo_params = mo_action->mo_http_post->ms_request-s_front-o_comp_data->slice( `/startupParameters/` ).
        IF lo_params IS NOT BOUND.
          RETURN.
        ENDIF.
        
        
        LOOP AT lo_params->mt_json_tree
            REFERENCE INTO lr_comp
            WHERE name = `1`.

          
          CLEAR temp2.
          temp2-n = shift_left( val = shift_right( val = lr_comp->path sub = `/` ) sub = `/` ).
          temp2-v = lr_comp->value.
          INSERT temp2 INTO TABLE result-t_comp_params.
        ENDLOOP.
      CATCH cx_root.
    ENDTRY.

  ENDMETHOD.


  METHOD z2ui5_if_client~get_app.
      DATA lo_app TYPE REF TO z2ui5_cl_core_app.
      DATA temp3 TYPE REF TO z2ui5_if_app.
      DATA temp4 TYPE REF TO z2ui5_if_app.

    IF id IS NOT INITIAL.
      
      lo_app = z2ui5_cl_core_app=>db_load( id ).
      
      temp3 ?= lo_app->mo_app.
      result = temp3.
    ELSE.
      
      temp4 ?= mo_action->mo_app->mo_app.
      result = temp4.
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_if_client~message_box_display.

    CLEAR mo_action->ms_next-s_set-s_msg_box.
    mo_action->ms_next-s_set-s_msg_box-text = text.
    mo_action->ms_next-s_set-s_msg_box-type = type.

  ENDMETHOD.


  METHOD z2ui5_if_client~message_toast_display.

    CLEAR mo_action->ms_next-s_set-s_msg_toast.
    mo_action->ms_next-s_set-s_msg_toast-text = text.

  ENDMETHOD.


  METHOD z2ui5_if_client~nav_app_call.
    DATA temp5 TYPE string.

    mo_action->ms_next-o_app_call = app.

    
    IF app->id_draft IS INITIAL.
      temp5 = z2ui5_cl_util=>uuid_get_c32( ).
    ELSE.
      temp5 = app->id_app.
    ENDIF.
    result = temp5.

  ENDMETHOD.


  METHOD z2ui5_if_client~nav_app_leave.
    DATA temp6 TYPE string.

    IF app IS NOT BOUND.
      app = z2ui5_if_client~get_app( z2ui5_if_client~get( )-s_draft-id_prev_app_stack ).
    ENDIF.

    mo_action->ms_next-o_app_leave = app.

    
    IF app->id_draft IS INITIAL.
      temp6 = z2ui5_cl_util=>uuid_get_c32( ).
    ELSE.
      temp6 = app->id_app.
    ENDIF.
    result = temp6.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest2_view_destroy.

    mo_action->ms_next-s_set-s_view_nest2-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest2_view_display.

    mo_action->ms_next-s_set-s_view_nest2-xml = val.
    mo_action->ms_next-s_set-s_view_nest2-id = id.
    mo_action->ms_next-s_set-s_view_nest2-method_destroy = method_destroy.
    mo_action->ms_next-s_set-s_view_nest2-method_insert = method_insert.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest2_view_model_update.

    mo_action->ms_next-s_set-s_view_nest2-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest_view_destroy.

    mo_action->ms_next-s_set-s_view_nest-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest_view_display.

    mo_action->ms_next-s_set-s_view_nest-xml = val.
    mo_action->ms_next-s_set-s_view_nest-id = id.
    mo_action->ms_next-s_set-s_view_nest-method_destroy = method_destroy.
    mo_action->ms_next-s_set-s_view_nest-method_insert = method_insert.

  ENDMETHOD.


  METHOD z2ui5_if_client~nest_view_model_update.

    mo_action->ms_next-s_set-s_view_nest-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popover_destroy.

    mo_action->ms_next-s_set-s_popover-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popover_display.

    mo_action->ms_next-s_set-s_popover-check_destroy = abap_false.
    mo_action->ms_next-s_set-s_popover-xml = xml.
    mo_action->ms_next-s_set-s_popover-open_by_id = by_id.

  ENDMETHOD.


  METHOD z2ui5_if_client~popover_model_update.

    mo_action->ms_next-s_set-s_popover-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_destroy.

    CLEAR mo_action->ms_next-s_set-s_popup.
    mo_action->ms_next-s_set-s_popup-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_display.

    mo_action->ms_next-s_set-s_popup-check_destroy = abap_false.
    mo_action->ms_next-s_set-s_popup-xml = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~popup_model_update.

    mo_action->ms_next-s_set-s_popup-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_destroy.

    mo_action->ms_next-s_set-s_view-check_destroy = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_display.

    mo_action->ms_next-s_set-s_view-xml = val.

  ENDMETHOD.


  METHOD z2ui5_if_client~view_model_update.

    mo_action->ms_next-s_set-s_view-check_update_model = abap_true.

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind.

    DATA lo_bind TYPE REF TO z2ui5_cl_core_bind_srv.
    DATA temp7 TYPE z2ui5_if_core_types=>ty_s_bind_config.
    CREATE OBJECT lo_bind TYPE z2ui5_cl_core_bind_srv EXPORTING APP = mo_action->mo_app.
    
    CLEAR temp7.
    temp7-path_only = path.
    temp7-custom_filter = custom_filter.
    temp7-custom_mapper = custom_mapper.
    temp7-tab = z2ui5_cl_util=>conv_get_as_data_ref( tab ).
    temp7-tab_index = tab_index.
    result = lo_bind->main(
      val    = z2ui5_cl_util=>conv_get_as_data_ref( val )
      type   = z2ui5_if_core_types=>cs_bind_type-one_way
      config = temp7 ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind_clear.

    DATA lo_bind TYPE REF TO z2ui5_cl_core_bind_srv.
    CREATE OBJECT lo_bind TYPE z2ui5_cl_core_bind_srv EXPORTING APP = mo_action->mo_app.
    lo_bind->clear( val ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind_edit.

    DATA lo_bind TYPE REF TO z2ui5_cl_core_bind_srv.
    DATA temp8 TYPE z2ui5_if_core_types=>ty_s_bind_config.
    CREATE OBJECT lo_bind TYPE z2ui5_cl_core_bind_srv EXPORTING APP = mo_action->mo_app.
    
    CLEAR temp8.
    temp8-path_only = path.
    temp8-custom_filter = custom_filter.
    temp8-custom_filter_back = custom_filter_back.
    temp8-custom_mapper = custom_mapper.
    temp8-custom_mapper_back = custom_mapper_back.
    temp8-tab = z2ui5_cl_util=>conv_get_as_data_ref( tab ).
    temp8-tab_index = tab_index.
    result = lo_bind->main(
      val    = z2ui5_cl_util=>conv_get_as_data_ref( val )
      type   = z2ui5_if_core_types=>cs_bind_type-two_way
      config = temp8 ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_bind_local.

    DATA lo_bind TYPE REF TO z2ui5_cl_core_bind_srv.
    DATA temp9 TYPE z2ui5_if_core_types=>ty_s_bind_config.
    CREATE OBJECT lo_bind TYPE z2ui5_cl_core_bind_srv EXPORTING APP = mo_action->mo_app.
    
    CLEAR temp9.
    temp9-path_only = path.
    temp9-custom_mapper = custom_mapper.
    temp9-custom_filter = custom_filter.
    result = lo_bind->main_local(
      val    = val
      config = temp9 ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_event.

    DATA lo_ui5 TYPE REF TO z2ui5_cl_core_event_srv.
    CREATE OBJECT lo_ui5 TYPE z2ui5_cl_core_event_srv.
    result = lo_ui5->get_event(
         val                = val
         t_arg              = t_arg
         s_cnt              = s_ctrl ).

  ENDMETHOD.


  METHOD z2ui5_if_client~_event_client.

    DATA lo_ui5 TYPE REF TO z2ui5_cl_core_event_srv.
    CREATE OBJECT lo_ui5 TYPE z2ui5_cl_core_event_srv.
    result = lo_ui5->get_event_client(
         val   = val
         t_arg = t_arg ).

  ENDMETHOD.
ENDCLASS.
