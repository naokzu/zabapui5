CLASS z2ui5_cl_fw_utility_json DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA mo_root         TYPE REF TO z2ui5_cl_fw_utility_json.
    DATA mo_parent       TYPE REF TO z2ui5_cl_fw_utility_json.
    DATA mv_name         TYPE string.
    DATA mv_value        TYPE string.
    TYPES ty_temp1 TYPE STANDARD TABLE OF REF TO z2ui5_cl_fw_utility_json WITH DEFAULT KEY.
DATA mt_values       TYPE ty_temp1.
    DATA mr_actual       TYPE REF TO data.
    DATA mv_apost_active TYPE abap_bool.

    CLASS-METHODS factory
      IMPORTING
        iv_json       TYPE clike OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS constructor.

    METHODS get_attribute
      IMPORTING
        name          TYPE string
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS get_val
      RETURNING
        VALUE(result) TYPE string.

    METHODS get_val_ref
      RETURNING
        VALUE(result) TYPE REF TO data.

    METHODS add_attribute
      IMPORTING
        n             TYPE clike
        v             TYPE clike
        apos_active   TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS add_attribute_object
      IMPORTING
        name          TYPE clike
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS add_attribute_struc
      IMPORTING
        val           TYPE data
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS add_attribute_instance
      IMPORTING
        val           TYPE REF TO z2ui5_cl_fw_utility_json
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

    METHODS stringify
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.

    CLASS-METHODS new
      IMPORTING
        io_root       TYPE REF TO z2ui5_cl_fw_utility_json
        iv_name       TYPE simple
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_fw_utility_json.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_FW_UTILITY_JSON IMPLEMENTATION.


  METHOD add_attribute.
    DATA temp1 TYPE string.

    result = new( io_root = mo_root
                  iv_name = n ).

    
    IF apos_active = abap_true.
      temp1 = escape( val = v format = cl_abap_format=>e_json_string ).
    ELSE.
      temp1 = v.
    ENDIF.
    result->mv_value = temp1.

    result->mv_apost_active = apos_active.
    result->mo_parent       = me.
    INSERT result INTO TABLE mt_values.

  ENDMETHOD.


  METHOD add_attribute_instance.

    val->mo_root   = mo_root.
    val->mo_parent = me.
    INSERT val INTO TABLE mt_values.
    result = val.

  ENDMETHOD.


  METHOD add_attribute_object.

    result = new( io_root = mo_root
                  iv_name = name ).
    INSERT result INTO TABLE mt_values.
    result->mo_parent = me.

  ENDMETHOD.


  METHOD add_attribute_struc.

    FIELD-SYMBOLS <value> TYPE any.
    DATA temp2 TYPE REF TO cl_abap_structdescr.
    DATA lo_struc LIKE temp2.
    DATA lt_comp TYPE abap_component_tab.
    DATA temp3 LIKE LINE OF lt_comp.
    DATA lr_comp LIKE REF TO temp3.
    temp2 ?= cl_abap_datadescr=>describe_by_data( val ).
    
    lo_struc = temp2.
    
    lt_comp = lo_struc->get_components( ).

    
    
    LOOP AT lt_comp REFERENCE INTO lr_comp.
      ASSIGN COMPONENT lr_comp->name OF STRUCTURE val TO <value>.
      add_attribute( n = lr_comp->name
                     v = <value> ).
    ENDLOOP.

    result = me.

  ENDMETHOD.


  METHOD constructor.
    mo_root = me.
  ENDMETHOD.


  METHOD factory.
    DATA temp4 TYPE string.

    CREATE OBJECT result.
    result->mo_root = result.

    
    temp4 = iv_json.
    /ui2/cl_json=>deserialize(
        EXPORTING
            json         = temp4
            assoc_arrays = abap_true
        CHANGING
            data         = result->mr_actual ).

  ENDMETHOD.


  METHOD get_attribute.

    DATA temp1 TYPE xsdboolean.
    DATA lv_name TYPE string.
    FIELD-SYMBOLS <attribute> TYPE any.
    DATA temp2 TYPE xsdboolean.
    temp1 = boolc( mr_actual IS INITIAL ).
    z2ui5_cl_fw_utility=>raise( when = temp1 ).

    result = new( io_root = mo_root
                  iv_name = name ).

    
    lv_name = 'MR_ACTUAL->' && replace( val  = name
                                              sub  = `-`
                                              with = `_`
                                              occ  = 0 ).

    
    ASSIGN (lv_name) TO <attribute>.
    
    temp2 = boolc( sy-subrc <> 0 ).
    z2ui5_cl_fw_utility=>raise( when = temp2 ).

    result->mr_actual = <attribute>.
    result->mo_parent = me.
    INSERT result INTO TABLE mt_values.

  ENDMETHOD.


  METHOD get_val.

    FIELD-SYMBOLS <attribute> TYPE any.
    DATA temp3 TYPE xsdboolean.
    ASSIGN mr_actual->* TO <attribute>.
    
    temp3 = boolc( sy-subrc <> 0 ).
    z2ui5_cl_fw_utility=>raise( when = temp3
                                v    = `value of attribute in JSON not found` ).
    result = <attribute>.

  ENDMETHOD.


  METHOD get_val_ref.

    result = mr_actual.

  ENDMETHOD.


  METHOD new.
    DATA temp5 TYPE string.

    CREATE OBJECT result.
    result->mo_root = io_root.
    
    temp5 = iv_name.
    result->mv_name = temp5.

  ENDMETHOD.


  METHOD stringify.

    DATA lo_attri LIKE LINE OF mt_values.
    LOOP AT mt_values INTO lo_attri.

      IF sy-tabix > 1.
        result = result && `,`.
      ENDIF.

      result = |{ result }"{ lo_attri->mv_name }":|.

      IF lo_attri->mt_values IS NOT INITIAL.
        result = result && lo_attri->stringify( ).
      ELSEIF lo_attri->mv_apost_active = abap_true OR lo_attri->mv_value IS INITIAL.
        result = result && `"` && lo_attri->mv_value && `"`.
      ELSE.
        result = result && lo_attri->mv_value.
      ENDIF.

    ENDLOOP.

    result = `{` && result && `}`.

  ENDMETHOD.
ENDCLASS.