CLASS z2ui5_cl_cc_title DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        view TYPE REF TO z2ui5_cl_xml_view.

    METHODS control
      IMPORTING
        title         TYPE clike OPTIONAL
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_xml_view.

    METHODS load_cc
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_xml_view.

    CLASS-METHODS get_js
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
    DATA mo_view TYPE REF TO z2ui5_cl_xml_view.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_cc_title IMPLEMENTATION.

  METHOD constructor.

    me->mo_view = view.

  ENDMETHOD.

  METHOD control.
    DATA temp1 TYPE z2ui5_if_client=>ty_t_name_value.
    DATA temp2 LIKE LINE OF temp1.

    result = mo_view.
    
    CLEAR temp1.
    
    temp2-n = `title`.
    temp2-v = title.
    INSERT temp2 INTO TABLE temp1.
    mo_view->_generic( name   = `CCTitle`
              ns     = `z2ui5`
              t_prop = temp1 ).

  ENDMETHOD.

  METHOD load_cc.

    result = mo_view->_generic( ns = `html` name = `script` )->_cc_plain_xml( get_js( ) )->get_parent( ).

  ENDMETHOD.

  METHOD get_js.

    result = `debugger; jQuery.sap.declare("z2ui5.CCTitle");` && |\n| &&
    `sap.ui.require([` && |\n|  &&
    `   "sap/ui/core/Control"` && |\n|  &&
    `], (Control) => {` && |\n|  &&
    `   "use strict";` && |\n|  &&
    |\n|  &&
    `   return Control.extend("z2ui5.CCTitle", {` && |\n|  &&
    `       metadata : {` && |\n|  &&
    `           properties: {` && |\n|  &&
    `                title: {` && |\n|  &&
    `                    type: "string",` && |\n|  &&
    `                    defaultValue: ""` && |\n|  &&
    `                },` && |\n|  &&
    `            }` && |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       init () {` && |\n|  &&
    |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       onAfterRendering() {` && |\n|  &&
    |\n|  &&
    `       },` && |\n|  &&
    `       renderer(oRm, oControl) {` && |\n|  &&
    |\n|  &&
    `        debugger; document.title = oControl.getProperty( "title" );` && |\n|  &&
    `        }` && |\n|  &&
    `   });` && |\n|  &&
    `});`.

  ENDMETHOD.

ENDCLASS.