CLASS z2ui5_cl_fw_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS factory
      IMPORTING
        app             TYPE REF TO object
        attri           TYPE z2ui5_cl_fw_binding=>ty_t_attri
        viewname        TYPE string
      RETURNING
        VALUE(r_result) TYPE REF TO z2ui5_cl_fw_model.

    METHODS main_set_backend
      IMPORTING
        model TYPE REF TO data ##NEEDED.

    METHODS main_set_frontend
      RETURNING
        VALUE(result) TYPE string.

    DATA mo_app   TYPE REF TO object.
    DATA mt_attri TYPE z2ui5_cl_fw_binding=>ty_t_attri.
    DATA mv_viewname TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_fw_model IMPLEMENTATION.


  METHOD factory.

    CREATE OBJECT r_result.
    r_result->mo_app = app.
    r_result->mt_attri = attri.
    r_result->mv_viewname = viewname.

  ENDMETHOD.


  METHOD main_set_backend.

    DATA temp1 LIKE LINE OF mt_attri.
    DATA lr_attri LIKE REF TO temp1.
          DATA lv_name_back TYPE string.
          FIELD-SYMBOLS <backend> TYPE any.
          DATA lv_name_front TYPE string.
          FIELD-SYMBOLS <frontend> TYPE any.
    LOOP AT mt_attri REFERENCE INTO lr_attri
        WHERE bind_type = z2ui5_cl_fw_binding=>cs_bind_type-two_way AND
              viewname  = mv_viewname.
      TRY.
          
          lv_name_back = `MO_APP->` && lr_attri->name.

          
          UNASSIGN <backend>.
          ASSIGN (lv_name_back) TO <backend>.
          IF sy-subrc <> 0.
            RAISE EXCEPTION TYPE z2ui5_cx_util_error
              EXPORTING
                val = `NO_BACKEND_VALUE_FOUND_WITH_NAME__` && lv_name_back.
          ENDIF.

          
          lv_name_front = `MODEL->` && lr_attri->name_front.
          
          UNASSIGN <frontend>.
          ASSIGN (lv_name_front) TO <frontend>.
          IF sy-subrc <> 0.
            RAISE EXCEPTION TYPE z2ui5_cx_util_error
              EXPORTING
                val = `NO_FRONTEND_VALUE_FOUND_WITH_NAME__` && lv_name_front.
          ENDIF.

          CASE lr_attri->type_kind.

            WHEN cl_abap_typedescr=>typekind_table.
              z2ui5_cl_util_func=>trans_ref_tab_2_tab(
                EXPORTING
                    ir_tab_from = <frontend>
                    pretty_name = lr_attri->pretty_name
                IMPORTING
                    t_result    = <backend> ).

            WHEN cl_abap_typedescr=>typekind_struct1 OR cl_abap_typedescr=>typekind_struct2.
              z2ui5_cl_util_func=>trans_ref_struc_2_struc(
                  EXPORTING
                      ir_struc_from = <frontend>
                      pretty_name   = lr_attri->pretty_name
                  IMPORTING
                      r_result      = <backend> ).

            WHEN OTHERS.

              ASSIGN <frontend>->* TO <frontend>.
              CASE lr_attri->type_kind.
                WHEN  cl_abap_typedescr=>typekind_date  OR cl_abap_typedescr=>typekind_time.
                  z2ui5_cl_util_func=>trans_json_2_any(
                    EXPORTING
                        val = `"` && <frontend> && `"`
                    CHANGING
                        data = <backend> ).

                WHEN OTHERS.
                  <backend> = <frontend>.
              ENDCASE.

          ENDCASE.

        CATCH cx_root.
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.


  METHOD main_set_frontend.

    DATA lr_view_model TYPE REF TO z2ui5_cl_util_tree_json.
    DATA lo_update TYPE REF TO z2ui5_cl_util_tree_json.
    DATA temp2 LIKE LINE OF mt_attri.
    DATA lr_attri LIKE REF TO temp2.
      DATA temp3 TYPE REF TO z2ui5_cl_util_tree_json.
      DATA lo_actual LIKE temp3.
      DATA lv_name_back TYPE string.
      FIELD-SYMBOLS <attribute> TYPE any.
            DATA temp4 TYPE string.
    lr_view_model = z2ui5_cl_util_tree_json=>factory( ).
    
    lo_update = lr_view_model->add_attribute_object( z2ui5_cl_fw_binding=>cv_model_edit_name ).

    
    
    LOOP AT mt_attri REFERENCE INTO lr_attri WHERE bind_type <> ``.

      IF lr_attri->bind_type = z2ui5_cl_fw_binding=>cs_bind_type-one_time.
        lr_view_model->add_attribute( n           = lr_attri->name
                                      v           = lr_attri->data_stringify
                                      apos_active = abap_false ).
        CONTINUE.
      ENDIF.

      
      IF lr_attri->bind_type = z2ui5_cl_fw_binding=>cs_bind_type-one_way.
        temp3 = lr_view_model.
      ELSE.
        temp3 = lo_update.
      ENDIF.
      
      lo_actual = temp3.

      
      lv_name_back = `MO_APP->` && lr_attri->name.
      
      ASSIGN (lv_name_back) TO <attribute>.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE z2ui5_cx_util_error
          EXPORTING
            val = `Error while creating the response, seems that some app data is not available anymore. <p>BINDING_ERROR - No attribute found with name: ` && lr_attri->name && `</p>`.
      ENDIF.

      CASE lr_attri->type_kind.

        WHEN `h`.
          lo_actual->add_attribute( n           = lr_attri->name_front
                                    v           = z2ui5_cl_util_func=>trans_json_by_any( any = <attribute>  pretty_mode = lr_attri->pretty_name compress_mode = lr_attri->compress )
                                    apos_active = abap_false ).

        WHEN OTHERS.

          IF z2ui5_cl_util_func=>boolean_check_by_name( lr_attri->type ) IS NOT INITIAL.

            
            CASE <attribute>.
              WHEN abap_true.
                temp4 = `true`.
              WHEN OTHERS.
                temp4 = `false`.
            ENDCASE.
            lo_actual->add_attribute( n  = lr_attri->name_front
                             v           = temp4
                             apos_active = abap_false ).

          ELSE.

            lo_actual->add_attribute( n  = lr_attri->name_front
                             v           = z2ui5_cl_util_func=>trans_json_by_any( any = <attribute> pretty_mode = lr_attri->pretty_name compress_mode = lr_attri->compress )
                             apos_active = abap_false ).

          ENDIF.

      ENDCASE.

    ENDLOOP.

    result = lr_view_model->stringify( ).

  ENDMETHOD.
ENDCLASS.