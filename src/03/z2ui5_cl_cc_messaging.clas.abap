CLASS z2ui5_cl_cc_messaging DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_s_item,
        message        TYPE string,
        description    TYPE string,
        type           TYPE string,
        target         TYPE string,
        additionaltext TYPE string,
        date           TYPE string,
        descriptionurl TYPE string,
        persistent     TYPE string,
      END OF ty_s_item.
    TYPES ty_t_items TYPE STANDARD TABLE OF ty_s_item WITH DEFAULT KEY ##NEEDED.

    METHODS constructor
      IMPORTING
        view TYPE REF TO z2ui5_cl_xml_view.

    METHODS control
      IMPORTING
        items         TYPE clike OPTIONAL
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



CLASS Z2UI5_CL_CC_MESSAGING IMPLEMENTATION.


  METHOD constructor.

    me->mo_view = view.

  ENDMETHOD.


  METHOD control.
    DATA temp1 TYPE z2ui5_if_client=>ty_t_name_value.
    DATA temp2 LIKE LINE OF temp1.

    result = mo_view.
    
    CLEAR temp1.
    
    temp2-n = `items`.
    temp2-v = items.
    INSERT temp2 INTO TABLE temp1.
    mo_view->_generic( name   = `Messaging`
              ns     = `z2ui5`
              t_prop = temp1 ).

  ENDMETHOD.


  METHOD get_js.

    result = `debugger; jQuery.sap.declare("z2ui5.Messaging");` && |\n| &&
    `sap.ui.require([` && |\n|  &&
    `   "sap/ui/core/Control",` && |\n|  &&
    `   "sap/ui/core/Messaging",` && |\n|  &&
    `], (Control, Messaging) => {` && |\n|  &&
    `   "use strict";` && |\n|  &&
    |\n|  &&
    `   return Control.extend("z2ui5.Messaging", {` && |\n|  &&
    `       metadata: {` && |\n|  &&
    `           properties: {` && |\n|  &&
    `               items: { type: "Array" }` && |\n|  &&
    `           }` && |\n|  &&
    `       },` && |\n|  &&
    `       init() {` && |\n|  &&
     `         if (!sap.z2ui5.oMessaging){` && |\n|  &&
     `         sap.z2ui5.oMessaging = {};` && |\n|  &&
     `         sap.z2ui5.oMessaging.oMessageProcessor = new sap.ui.core.message.ControlMessageProcessor();` && |\n|  &&
    `          sap.z2ui5.oMessaging.oMessageManager = sap.ui.getCore().getMessageManager();` && |\n|  &&
    `          sap.z2ui5.oMessaging.oMessageManager.registerMessageProcessor(sap.z2ui5.oMessaging.oMessageProcessor);` && |\n|  &&
    `        }` && |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       onModelChange(oEvent) {` && |\n|  &&
    `           this.Messaging2Model();` && |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       Messaging2Model( ){` && |\n|  &&
    `           debugger;` && |\n|  &&
    `           var oData = Messaging.getMessageModel().getData();` && |\n|  &&
    `           var Model = [];` && |\n|  &&
    `           oData.forEach(element => {` && |\n|  &&
    `               Model.push( { ` && |\n|  &&
    `                       MESSAGE : element.message , ` && |\n|  &&
    `                       DESCRIPTION : element.description , ` && |\n|  &&
    `                       TYPE : element.type, ` && |\n|  &&
    `                       TARGET : element.aTargets[0] , ` && |\n|  &&
    `                       ADDITIONALTEXT : element.additionalText , ` && |\n|  &&
    `                       DATE : element.date , ` && |\n|  &&
    `                       DESCRIPTIONURL : element.descriptionUrl, ` && |\n|  &&
    `                       PERSISTENT : element.persistent } );` && |\n|  &&
    `           });` && |\n|  &&
    `           this.setProperty("items", Model );` && |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       Model2Messaging( ){` && |\n|  &&
    `           var Model = this.getProperty("items");` && |\n|  &&
    `           if(!Model) { return; }` && |\n|  &&
    |\n|  &&
    `           Model.forEach(element => {` && |\n|  &&
    `               var target = element.TARGET.split("--")[1];` && |\n|  &&
    `               if ( target == undefined ) { target = element.TARGET }` && |\n|  &&
    `               var oMessage = new sap.ui.core.message.Message({` && |\n|  &&
    `                   message: element.MESSAGE,` && |\n|  &&
    `                   description: element.DESCRIPTION,` && |\n|  &&
    `                   type: element.TYPE,` && |\n|  &&
    `                   target : sap.z2ui5.oView.getId( 'testINPUT' ) + '--' + target,` && |\n|  &&
    `                   additionalText : element.ADDITIONALTEXT , ` && |\n|  &&
    `                   date : element.DATE , ` && |\n|  &&
    `                   descriptionUrl : element.DESCRIPTIONURL, ` && |\n|  &&
    `                   persistent : element.PERSISTENT,` && |\n|  &&
    `                   processor : this.oMessageProcessor` && |\n|  &&
    `                 });` && |\n|  &&
    `                Messaging.addMessages(oMessage) ;` && |\n|  &&
    `           });` && |\n|  &&
    `           var resBinding = new sap.ui.model.ListBinding(Messaging.getMessageModel(), "/" );` && |\n|  &&
    `           resBinding.attachChange(this.onModelChange.bind(this));` && |\n|  &&
    `       },` && |\n|  &&
    |\n|  &&
    `       renderer(oRm, oControl) {` && |\n|  &&
    `           if(oControl.isInitialized) { return; }` && |\n|  &&
      `               oControl.Model2Messaging();` && |\n|  &&
      `                Messaging.registerObject(sap.z2ui5.oView, true);` && |\n|  &&
    `           oControl.isInitialized = true;` && |\n|  &&
        `           setTimeout( (oControl) => { ` && |\n|  &&
*    `               Messaging.registerObject(sap.z2ui5.oView, true);` && |\n|  &&
    `                   ` && |\n|  &&
    `   ` && |\n|  &&
    `               }, 50 , oControl );` && |\n|  &&
    `       }` && |\n|  &&
    `   });` && |\n|  &&
    `});`.

  ENDMETHOD.


  METHOD load_cc.

    result = mo_view->_generic( ns = `html` name = `script` )->_cc_plain_xml( get_js( ) )->get_parent( ).

  ENDMETHOD.
ENDCLASS.