CLASS z2ui5_cl_core_http_get DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA ms_request TYPE z2ui5_if_types=>ty_s_http_request_get.
    DATA mv_response TYPE string.

    METHODS constructor
      IMPORTING
        val TYPE z2ui5_if_types=>ty_s_http_request_get OPTIONAL.

    METHODS main
      RETURNING
        VALUE(result) TYPE string.

    METHODS get_js
      RETURNING
        VALUE(result) TYPE string.

    METHODS get_js_cc_startup
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.

    METHODS get_default_config
      RETURNING
        VALUE(result) TYPE z2ui5_if_types=>ty_s_http_request_get-t_config.

    METHODS get_default_security_policy
      RETURNING
        VALUE(result) TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_CORE_HTTP_GET IMPLEMENTATION.


  METHOD constructor.

    ms_request = val.

  ENDMETHOD.


  METHOD get_default_config.

    DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
    DATA temp2 LIKE LINE OF temp1.
    CLEAR temp1.
    
    temp2-n = `src`.
    temp2-v = `https://sdk.openui5.org/resources/sap-ui-cachebuster/sap-ui-core.js`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `data-sap-ui-theme`.
    temp2-v = `sap_horizon`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `data-sap-ui-async`.
    temp2-v = `true`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `data-sap-ui-bindingSyntax`.
    temp2-v = `complex`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `data-sap-ui-frameOptions`.
    temp2-v = `trusted`.
    INSERT temp2 INTO TABLE temp1.
    temp2-n = `data-sap-ui-compatVersion`.
    temp2-v = `edge`.
    INSERT temp2 INTO TABLE temp1.
    result = temp1.

  ENDMETHOD.


  METHOD get_default_security_policy.

    result  = `<meta http-equiv="Content-Security-Policy" content="default-src 'self' 'unsafe-inline' 'unsafe-eval' data: ` &&
   `ui5.sap.com *.ui5.sap.com sapui5.hana.ondemand.com *.sapui5.hana.ondemand.com openui5.hana.ondemand.com *.openui5.hana.ondemand.com ` &&
   `sdk.openui5.org *.sdk.openui5.org cdn.jsdelivr.net *.cdn.jsdelivr.net cdnjs.cloudflare.com *.cdnjs.cloudflare.com schemas *.schemas"/>`.

  ENDMETHOD.


  METHOD get_js.

    result = ` if (!z2ui5.Controller) { ` &&
    `sap.ui.define("z2ui5/Controller", ["sap/ui/core/mvc/Controller", "sap/ui/core/mvc/XMLView", "sap/ui/model/json/JSONModel", "sap/ui/core/BusyIndicator", "sap/m/MessageBox", "sap/m/MessageToast", "sap/ui/core/Fragment", "sap/m/BusyDialog` &&
`",   "sap/ui/VersionInfo" ], function(Control` &&
  `ler, XMLView, JSONModel, BusyIndicator, MessageBox, MessageToast, Fragment, mBusyDialog, VersionInfo ) {` && |\n| &&
               `    "use strict";` && |\n| &&
               `    return Controller.extend("z2ui5.Controller", {` && |\n| &&
               `        async onAfterRendering() {` && |\n| &&
               `         try{` && |\n| &&
               `            if (!sap.z2ui5.oResponse.PARAMS) {` && |\n| &&
               `            BusyIndicator.hide();` && |\n| &&
               `                sap.z2ui5.isBusy = false;` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            const {S_POPUP, S_VIEW_NEST, S_VIEW_NEST2, S_POPOVER} = sap.z2ui5.oResponse.PARAMS;` && |\n| &&
               `            if (S_POPUP?.CHECK_DESTROY) {` && |\n| &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n| &&
               `            }` && |\n| &&
               `            if (S_POPOVER?.CHECK_DESTROY) {` && |\n| &&
               `                sap.z2ui5.oController.PopoverDestroy();` && |\n| &&
               `            }` && |\n| &&
               `            if (S_POPUP?.XML) {` && |\n| &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n| &&
               `                await this.displayFragment(S_POPUP.XML, 'oViewPopup');` && |\n| &&
               `            }` && |\n| &&
               `            if (!sap.z2ui5.checkNestAfter) {` && |\n| &&
               `                if (S_VIEW_NEST?.XML) {` && |\n| &&
               `                    sap.z2ui5.oController.NestViewDestroy();` && |\n| &&
               `                    await this.displayNestedView(S_VIEW_NEST.XML, 'oViewNest', 'S_VIEW_NEST');` && |\n| &&
               `                    sap.z2ui5.checkNestAfter = true;` && |\n| &&
               `                }` && |\n| &&
               `            }` && |\n| &&
               `            if (!sap.z2ui5.checkNestAfter2) {` && |\n| &&
               `                if (S_VIEW_NEST2?.XML) {` && |\n| &&
               `                    sap.z2ui5.oController.NestViewDestroy2();` && |\n| &&
               `                    await this.displayNestedView2(S_VIEW_NEST2.XML, 'oViewNest2', 'S_VIEW_NEST2');` && |\n| &&
               `                    sap.z2ui5.checkNestAfter2 = true;` && |\n| &&
               `                }` && |\n| &&
               `            }` && |\n| &&
               `            if (S_POPOVER?.XML) {` && |\n| &&
               `                await this.displayPopover(S_POPOVER.XML, 'oViewPopover', S_POPOVER.OPEN_BY_ID);` && |\n| &&
               `            }` && |\n| &&
               `            BusyIndicator.hide();` && |\n| &&
               `            sap.z2ui5.isBusy = false;` && |\n| &&
               `            sap.z2ui5.onAfterRendering.forEach(item=>{` && |\n| &&
               `                if (item !== undefined) {` && |\n| &&
               `                    item();` && |\n| &&
               `                }` && |\n| &&
               `            }` && |\n| &&
               `            )` && |\n| &&
`           }catch(e){BusyIndicator.hide(); sap.z2ui5.isBusy = false; MessageBox.error( e.toLocaleString() , { title : "Unexpected Error Occured - App Terminated" , actions : [ ] , onClose :  () => {  new mBusyDialog({ text : "Please Restart t` &&
`he App" }).open();  } } ) }` && |\n| &&
               `        },` && |\n| &&
               |\n| &&
               `        async displayFragment(xml, viewProp) {` && |\n| &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `            const oFragment = await Fragment.load({` && |\n| &&
               `                definition: xml,` && |\n| &&
               `                controller: sap.z2ui5.oControllerPopup,` && |\n| &&
               `                id: "popupId"` && |\n| &&
               `            });` && |\n| &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `            oFragment.setModel(oview_model);` && |\n| &&
               `            sap.z2ui5[viewProp] = oFragment;` && |\n| &&
               `            sap.z2ui5[viewProp].Fragment = Fragment;` && |\n| &&
               `                oFragment.open();` && |\n| &&
               `        },` && |\n| &&
               `        async displayPopover(xml, viewProp, openById) {` && |\n| &&
               `          // let sapUiCore = sap.ui.require('sap/ui/core/Core');` && |\n| &&
               `           sap.ui.require(["sap/ui/core/Element"], async function(Element) { ` &&
    `   ` &&
        ` ` && |\n| &&
               `            const oFragment = await Fragment.load({` && |\n| &&
               `                definition: xml,` && |\n| &&
               `                controller: sap.z2ui5.oControllerPopover,` && |\n| &&
               `                 id: "popoverId"` && |\n| &&
               `            });` && |\n| &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `            oFragment.setModel(oview_model);` && |\n| &&
               `            sap.z2ui5[viewProp] = oFragment;` && |\n| &&
               `            sap.z2ui5[viewProp].Fragment = Fragment;` && |\n| &&
               `            let oControl = {};` && |\n| &&
               `            if( sap.z2ui5.oView?.byId(openById) ) {` && |\n| &&
               `              oControl = sap.z2ui5.oView.byId(openById);` && |\n| &&
               `            } else if ( sap.z2ui5.oViewPopup?.Fragment.byId('popupId',openById) ) {` && |\n| &&
               `              oControl = sap.z2ui5.oViewPopup.Fragment.byId('popupId',openById);` && |\n| &&
               `            } else if ( sap.z2ui5.oViewNest?.byId(openById) ) {` && |\n| &&
               `              oControl = sap.z2ui5.oViewNest.byId(openById);` && |\n| &&
               `            } else if ( sap.z2ui5.oViewNest2?.byId(openById) ) {` && |\n| &&
               `              oControl = sap.z2ui5.oViewNest2.byId(openById);` && |\n| &&
               `            } else {` && |\n| &&
               `               if(sapUiCore.byId(openById)) {` && |\n| &&
               `               //   oControl = sapUiCore.byId(openById);` && |\n| &&
               `                  oControl = Element.getElementById(openById);` && |\n| &&
               `                } else {` && |\n| &&
               `                  oControl = null;` && |\n| &&
               `                };` && |\n| &&
               `            }` && |\n| &&
               `             oFragment.openBy(oControl);` && |\n| &&
               `       }); },` && |\n| &&
               `        async displayNestedView(xml, viewProp, viewNestId) {` && |\n| &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `            const oView = await XMLView.create({` && |\n| &&
               `                definition: xml,` && |\n| &&
               `                controller: sap.z2ui5.oControllerNest,` && |\n| &&
               `                preprocessors: { xml: { models: { template: oview_model } } }` && |\n| &&
               `            });` && |\n| &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `            oView.setModel(oview_model);` && |\n| &&
               `            let oParent = sap.z2ui5.oView.byId(sap.z2ui5.oResponse.PARAMS[viewNestId].ID);` && |\n| &&
               `            if (oParent) {` && |\n| &&
               `                try {` && |\n| &&
               `                    oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_DESTROY]();` && |\n| &&
               `                } catch {}` && |\n| &&
               `                oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_INSERT](oView);` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5[viewProp] = oView;` && |\n| &&
               `        },` && |\n| &&
               `        async displayNestedView2(xml, viewProp, viewNestId) {` && |\n| &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `            const oView = await XMLView.create({` && |\n| &&
               `                definition: xml,` && |\n| &&
               `                controller: sap.z2ui5.oControllerNest2,` && |\n| &&
               `                preprocessors: { xml: { models: { template: oview_model } } }` && |\n| &&
               `            });` && |\n| &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `            oView.setModel(oview_model);` && |\n| &&
               `            let oParent = sap.z2ui5.oView.byId(sap.z2ui5.oResponse.PARAMS[viewNestId].ID);` && |\n| &&
               `            if (oParent) {` && |\n| &&
               `                try {` && |\n| &&
               `                    oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_DESTROY]();` && |\n| &&
               `                } catch {}` && |\n| &&
               `                oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_INSERT](oView);` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5[viewProp] = oView;` && |\n| &&
               `        },` && |\n| &&
               `        PopupDestroy() {` && |\n| &&
               `            if (!sap.z2ui5.oViewPopup) {` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            if (sap.z2ui5.oViewPopup.close) {` && |\n| &&
               `                try {` && |\n| &&
               `                    sap.z2ui5.oViewPopup.close();` && |\n| &&
               `                } catch {}` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oViewPopup.destroy();` && |\n| &&
               `        },` && |\n| &&
               `        PopoverDestroy() {` && |\n| &&
               `            if (!sap.z2ui5.oViewPopover) {` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            if (sap.z2ui5.oViewPopover.close) {` && |\n| &&
               `                try {` && |\n| &&
               `                    sap.z2ui5.oViewPopover.close();` && |\n| &&
               `                } catch {}` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oViewPopover.destroy();` && |\n| &&
               `        },` && |\n| &&
               `        NestViewDestroy() {` && |\n| &&
               `            if (!sap.z2ui5.oViewNest) {` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oViewNest.destroy();` && |\n| &&
               `        },` && |\n| &&
               `        NestViewDestroy2() {` && |\n| &&
               `            if (!sap.z2ui5.oViewNest2) {` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oViewNest2.destroy();` && |\n| &&
               `        },` && |\n| &&
               `        ViewDestroy() {` && |\n| &&
               `            if (!sap.z2ui5.oView) {` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oView.destroy();` && |\n| &&
               `        },` && |\n| &&
               `        eF(...args) {` && |\n| &&
               `            sap.z2ui5.onBeforeEventFrontend.forEach(item => {` && |\n| &&
               `                if (item !== undefined) {` && |\n| &&
               `                    item(args);` && |\n| &&
               `                }` && |\n| &&
               `              }` && |\n| &&
               `            )` && |\n| &&
               `            let oCrossAppNavigator;` && |\n| &&
               `            switch (args[0]) {` && |\n| &&
               `            case 'DOWNLOAD_B64_FILE':` && |\n| &&
               `                var a = document.createElement("a");` && |\n| &&
               `                a.href = args[1];` && |\n| &&
               `                a.download = args[2];` && |\n| &&
               `                a.click();` && |\n| &&
               `                break;` && |\n| &&
               `            case 'CROSS_APP_NAV_TO_PREV_APP':` && |\n| &&
               `                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");` && |\n| &&
               `                oCrossAppNavigator.backToPreviousApp();` && |\n| &&
               `                break;` && |\n| &&
               `            case 'CROSS_APP_NAV_TO_EXT':` && |\n| &&
               `                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");` && |\n| &&
               `                const hash = (oCrossAppNavigator.hrefForExternal({` && |\n| &&
               `                    target: args[1],` && |\n| &&
               `                    params: args[2]` && |\n| &&
               `                })) || "";` && |\n| &&
               `                if (args[3] === 'EXT') {` && |\n| &&
               `                    let url = window.location.href.split('#')[0] + hash;` && |\n| &&
               `                    sap.m.URLHelper.redirect(url, true);` && |\n| &&
               `                } else {` && |\n| &&
               `                    oCrossAppNavigator.toExternal({` && |\n| &&
               `                        target: {` && |\n| &&
               `                            shellHash: hash` && |\n| &&
               `                        }` && |\n| &&
               `                    });` && |\n| &&
               `                }` && |\n| &&
               `                break;` && |\n| &&
               `            case 'LOCATION_RELOAD':` && |\n| &&
               `                window.location = args[1];` && |\n| &&
               `                break;` && |\n| &&
               `            case 'OPEN_NEW_TAB':` && |\n| &&
               `                window.open(args[1], '_blank');` && |\n| &&
               `                break;` && |\n| &&
               `            case 'POPUP_CLOSE':` && |\n| &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n| &&
               `                break;` && |\n| &&
               `            case 'POPOVER_CLOSE':` && |\n| &&
               `                sap.z2ui5.oController.PopoverDestroy();` && |\n| &&
               `                break;` && |\n| &&
               `            case 'NAV_CONTAINER_TO':` && |\n| &&
               `                var navCon = sap.z2ui5.oView.byId(args[1]);` && |\n| &&
               `                var navConTo = sap.z2ui5.oView.byId(args[2]);` && |\n| &&
               `                navCon.to(navConTo);` && |\n| &&
               `                break;` && |\n| &&
               `            case 'NEST_NAV_CONTAINER_TO':` && |\n| &&
               `                navCon = sap.z2ui5.oViewNest.byId(args[1]);` && |\n| &&
               `                navConTo = sap.z2ui5.oViewNest.byId(args[2]);` && |\n| &&
               `                navCon.to(navConTo);` && |\n| &&
               `                break;` && |\n| &&
               `            case 'NEST2_NAV_CONTAINER_TO':` && |\n| &&
               `                navCon = sap.z2ui5.oViewNest2.byId(args[1]);` && |\n| &&
               `                navConTo = sap.z2ui5.oViewNest2.byId(args[2]);` && |\n| &&
               `                navCon.to(navConTo);` && |\n| &&
               `                break;` && |\n| &&
               `            case 'POPUP_NAV_CONTAINER_TO':` && |\n| &&
               `                navCon = Fragment.byId("popupId",args[1]);` && |\n| &&
               `                navConTo = Fragment.byId("popupId",args[2]);` && |\n| &&
               `                navCon.to(navConTo);` && |\n| &&
               `                break;` && |\n| &&
               `            }` && |\n| &&
               `        },` && |\n| &&
               `        eB(...args) {` && |\n| &&
               `            if (!window.navigator.onLine) {` && |\n| &&
               `                MessageBox.alert('No internet connection! Please reconnect to the server and try again.');` && |\n| &&
               `                return;` && |\n| &&
               `            }` && |\n| &&
               `           if (sap.z2ui5.isBusy == true) {` && |\n| &&
               `             if (!args[0][2]) { ` && |\n| &&
               `                   let oBusyDialog = new mBusyDialog();` && |\n| &&
               `                   oBusyDialog.open();` && |\n| &&
               `                setTimeout( (oBusyDialog) => { oBusyDialog.close() } , 100 , oBusyDialog );` && |\n| &&
               `                    return;` && |\n| &&
               `                 }` && |\n| &&
               `                }` && |\n| &&
               `            sap.z2ui5.isBusy = true;` && |\n| &&
               `             BusyIndicator.show();` && |\n| &&
               `            sap.z2ui5.oBody = {};` && |\n| &&
               `            if ( args[0][3] ) {` && |\n| &&
               `                sap.z2ui5.oBody.XX = sap.z2ui5.oView.getModel().getData().XX;` && |\n| &&
               `                sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n| &&
               `            }` && |\n| &&
               `            else if ( sap.z2ui5.oController == this ) {` && |\n| &&
               `                sap.z2ui5.oBody.XX = sap.z2ui5.oView.getModel().getData().XX;` && |\n| &&
               `                sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n| &&
               `            }else if ` && |\n| &&
               `               (  sap.z2ui5.oControllerPopup == this ) {` && |\n| &&
               `                    if (sap.z2ui5.oViewPopup){` && |\n| &&
               `                    sap.z2ui5.oBody.XX = sap.z2ui5.oViewPopup.getModel().getData().XX;` && |\n| &&
               `                   }` && |\n| &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n| &&
               `                }else if ( ` && |\n| &&
               `                sap.z2ui5.oControllerPopover == this ) {` && |\n| &&
               `                            sap.z2ui5.oBody.XX = sap.z2ui5.oViewPopover.getModel().getData().XX;` && |\n| &&
               `                            sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n| &&
               `                }else if ( ` && |\n| &&
               `                sap.z2ui5.oControllerNest == this ) {` && |\n| &&
               `                    sap.z2ui5.oBody.XX = sap.z2ui5.oViewNest.getModel().getData().XX;` && |\n| &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'NEST';` && |\n| &&
               `                }else if (` && |\n| &&
               `                sap.z2ui5.oControllerNest2 == this ) {` && |\n| &&
               `                    sap.z2ui5.oBody.XX = sap.z2ui5.oViewNest2.getModel().getData().XX;` && |\n| &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'NEST2';` && |\n| &&
               `                }` && |\n| &&
               `            sap.z2ui5.onBeforeRoundtrip.forEach(item=>{` && |\n| &&
               `                if (item !== undefined) {` && |\n| &&
               `                    item();` && |\n| &&
               `                }})` && |\n| &&
               `            if (args[0][1]) {` && |\n| &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n| &&
               `            }` && |\n| &&
               `            sap.z2ui5.oBody.ID = sap.z2ui5.oResponse.ID;` && |\n| &&
               `            sap.z2ui5.oBody.ARGUMENTS = args;` && |\n| &&
               `                     sap.z2ui5.oBody.ARGUMENTS.forEach( ( item , i ) => { ` && |\n| &&
           `    if ( i == 0 ) {  return; } if ( typeof item === 'object'  ){  ` && |\n| &&
            `      sap.z2ui5.oBody.ARGUMENTS[ i ] = JSON.stringify( item ); ` && |\n| &&
           `     }  ` && |\n| &&
          `     });  ` && |\n| &&
*               `            for (let i = 1 ; i < sap.z2ui5.oBody.ARGUMENTS.length; i++ ) { ` && |\n| &&
*               `             if ( typeof sap.z2ui5.oBody.ARGUMENTS[ i ] === 'object'  ){ ` && |\n| &&
*               `               sap.z2ui5.oBody.ARGUMENTS[ i ] = JSON.stringify( sap.z2ui5.oBody.ARGUMENTS[ i ] )` && |\n| &&
*               `             } ` && |\n| &&
*               `            } ` && |\n| &&
               `            sap.z2ui5.oResponseOld = sap.z2ui5.oResponse;` && |\n| &&
               `            sap.z2ui5.oController.Roundtrip();` && |\n| &&
               `        },` && |\n| &&
               `        responseError(response) {` && |\n| &&
               `            document.write(response);` && |\n| &&
               `        },` && |\n| &&
               `        updateModelIfRequired(paramKey, oView) {` && |\n| &&
               `            if (sap.z2ui5.oResponse.PARAMS == undefined) { return; }` && |\n| &&
               `            if (sap.z2ui5.oResponse.PARAMS[paramKey]?.CHECK_UPDATE_MODEL) {` && |\n| &&
               `                let model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `                model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `                if (oView) { oView.setModel(model); }` && |\n| &&
               `            }` && |\n| &&
               `        },` && |\n| &&
               `        async responseSuccess(response) {` && |\n| &&
               `         try{` && |\n| &&
               `            sap.z2ui5.oResponse = response;` && |\n| &&
               `            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.CHECK_DESTROY) {` && |\n| &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n| &&
               `            };` && |\n| &&
               `            if(sap.z2ui5.oResponse.PARAMS?.S_FOLLOW_UP_ACTION?.CUSTOM_JS) {` && |\n| &&
               `              setTimeout(() => {` && |\n| &&
               `                  let mParams = sap.z2ui5.oResponse?.PARAMS.S_FOLLOW_UP_ACTION.CUSTOM_JS.split("'");` && |\n| &&
               `                  let mParamsEF = mParams.filter((val, index) => index % 2)` && |\n| &&
               `                  if(mParamsEF.length) {` && |\n| &&
               `                    sap.z2ui5.oController.eF.apply( undefined , mParamsEF);` && |\n| &&
               `                  } else {` && |\n| &&
               `                    Function("return " + mParams[0])();` && |\n| &&
               `                  }` && |\n| &&
               `                },100);` && |\n| &&
               `              };` && |\n| &&
               |\n| &&
               `            sap.z2ui5.oController.showMessage('S_MSG_TOAST', sap.z2ui5.oResponse.PARAMS);` && |\n| &&
               `            sap.z2ui5.oController.showMessage('S_MSG_BOX', sap.z2ui5.oResponse.PARAMS);` && |\n| &&
               `            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML) { if ( sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML !== '') {` && |\n| &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n| &&
               `               await sap.z2ui5.oController.createView(sap.z2ui5.oResponse.PARAMS.S_VIEW.XML, sap.z2ui5.oResponse.OVIEWMODEL);` && |\n| &&
               `            return;  } } ` && |\n| &&
               `                this.updateModelIfRequired('S_VIEW', sap.z2ui5.oView);` && |\n| &&
               `                this.updateModelIfRequired('S_VIEW_NEST', sap.z2ui5.oViewNest);` && |\n| &&
               `                this.updateModelIfRequired('S_VIEW_NEST2', sap.z2ui5.oViewNest2);` && |\n| &&
               `                this.updateModelIfRequired('S_POPUP', sap.z2ui5.oViewPopup);` && |\n| &&
               `                this.updateModelIfRequired('S_POPOVER', sap.z2ui5.oViewPopover);` && |\n| &&
               `                sap.z2ui5.oController.onAfterRendering();` && |\n| &&
               `           }catch(e){BusyIndicator.hide(); if(e.message.includes("openui5")) { if(e.message.includes("script load error")) { sap.z2ui5.oController.checkSDKcompatibility(e) } } else { ` && |\n| &&
               `             MessageBox.error(e.toLocaleString()); } }` && |\n| &&
               `        },` && |\n| &&
               `       async checkSDKcompatibility(err) {` && |\n| &&
               `          let oCurrentVersionInfo = await VersionInfo.load();` && |\n| &&
               `          var ui5_sdk = oCurrentVersionInfo.gav.includes('com.sap.ui5') ? true : false;` && |\n| &&
*               `        //  var ui5_sdk = sap.ui.getVersionInfo().gav.includes('com.sap.ui5') ? true : false;` && |\n| &&
               `          if(!ui5_sdk) {` && |\n| &&
               `            if(err) {` && |\n| &&
               `              MessageBox.error("openui5 SDK is loaded, module: " + err._modules + " is not availabe in openui5" );` && |\n| &&
               `              return;` && |\n| &&
               `            };` && |\n| &&
               `          };` && |\n| &&
               `          MessageBox.error(err.toLocaleString());` && |\n| &&
               `        },` && |\n| &&
               `        showMessage(msgType, params) {` && |\n| &&
               `            if (params == undefined) { return; }` && |\n| &&
               `            if (params[msgType]?.TEXT !== undefined) {` && |\n| &&
               `                if (msgType === 'S_MSG_TOAST') {` && |\n| &&
               `                    MessageToast.show(params[msgType].TEXT,{duration: params[msgType].DURATION ? parseInt(params[msgType].DURATION) : 3000 ,` && |\n| &&
               `                                                            width: params[msgType].WIDTH ? params[msgType].WIDTH : '15em' ,` && |\n| &&
*               `                                                            my: params[msgType].MY ? params[msgType].MY : 'leftcenter' ,` && |\n| &&
*               `                                                            at: params[msgType].AT ? params[msgType].AT : 'CenterCenter' ,` && |\n| &&
*               `                                                            of: params[msgType].OF ? params[msgType].OF : window ,` && |\n| &&
*               `                                                            offset: params[msgType].OFFSET ? params[msgType].OFFSET : '0 0' ,` && |\n| &&
*               `                                                            collision: params[msgType].COLLISION ? params[msgType].COLLISION : 'fit fit' ,` && |\n| &&
               `                                                            onClose: params[msgType].ONCLOSE ? params[msgType].ONCLOSE : null ,` && |\n| &&
               `                                                            autoClose: params[msgType].AUTOCLOSE ? true : false ,` && |\n| &&
               `                                                            animationTimingFunction: params[msgType].ANIMATIONTIMINGFUNCTION ? params[msgType].ANIMATIONTIMINGFUNCTION : 'ease' ,` && |\n| &&
               `                                                            animationDuration: params[msgType].ANIMATIONDURATION ? parseInt(params[msgType].ANIMATIONDURATION) : 1000 ,` && |\n| &&
               `                                                            closeonBrowserNavigation: params[msgType].CLOSEONBROWSERNAVIGATION ? true : false` && |\n| &&
               `                     });` && |\n| &&
               `                     if(params[msgType].CLASS) {` && |\n| &&
               `                      let mtoast = {};` && |\n| &&
               `                      mtoast = document.getElementsByClassName("sapMMessageToast")[0];` && |\n| &&
               `                      if(mtoast) { mtoast.classList.add(params[msgType].CLASS); }` && |\n| &&
               `                     };` && |\n| &&
               `                } else if (msgType === 'S_MSG_BOX') {` && |\n| &&
               `                    if (params[msgType].TYPE) {` && |\n| &&
               `                     MessageBox[params[msgType].TYPE](params[msgType].TEXT);` && |\n| &&
               `                    } else {` && |\n| &&
               `                      MessageBox.show(params[msgType].TEXT,{styleClass:params[msgType].STYLECLASS ? params[msgType].STYLECLASS : '',` && |\n| &&
               `                                                                             title: params[msgType].TITLE ? params[msgType].TITLE : '',` && |\n| &&
               `                                                                             onClose: params[msgType].ONCLOSE ? Function("sAction", "return " + params[msgType].ONCLOSE) : null,` && |\n| &&
               `                                                                             actions: params[msgType].ACTIONS ? params[msgType].ACTIONS : 'OK',` && |\n| &&
               `                                                                             emphasizedAction: params[msgType].EMPHASIZEDACTION ? params[msgType].EMPHASIZEDACTION : 'OK',` && |\n| &&
               `                                                                             initialFocus: params[msgType].INITIALFOCUS ? params[msgType].INITIALFOCUS : null,` && |\n| &&
               `                                                                             textDirection: params[msgType].TEXTDIRECTION ? params[msgType].TEXTDIRECTION : 'Inherit',` && |\n| &&
               `                                                                             icon: params[msgType].ICON ? params[msgType].ICON : 'NONE' ,` && |\n| &&
               `                                                                             details: params[msgType].DETAILS ? params[msgType].DETAILS : '',` && |\n| &&
               `                                                                             closeOnNavigation: params[msgType].CLOSEONNAVIGATION ? true : false` && |\n| &&
               `                                                                          }` && |\n| &&
               `                                                    )` && |\n| &&
               `                    }` && |\n| &&
               `            }` && |\n| &&
              `            }` && |\n| &&
               `        },` && |\n| &&
               `        async createView(xml, viewModel) {` && |\n| &&
               `            let oview_model = new JSONModel(viewModel);` && |\n| &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n| &&
               `          sap.z2ui5.oView = await XMLView.create({` && |\n| &&
               `                definition: xml,` && |\n| &&
               `                models: oview_model,` && |\n| &&
               `                controller: sap.z2ui5.oController,` && |\n| &&
               `                id: 'mainView',` && |\n| &&
               `                preprocessors: { xml: { models: { template: oview_model } } }` && |\n| &&
               `            });` && |\n| &&
               `            sap.z2ui5.oView.setModel(sap.z2ui5.oDeviceModel, "device");` && |\n| &&
               `            if (sap.z2ui5.oParent) {` && |\n| &&
               `                sap.z2ui5.oParent.removeAllPages();` && |\n| &&
               `                sap.z2ui5.oParent.insertPage(sap.z2ui5.oView);` && |\n| &&
               `            } else {` && |\n| &&
               `                sap.z2ui5.oView.placeAt("content");` && |\n| &&
               `            }` && |\n| &&
               `        },` && |\n| &&
               `        async readHttp() {` && |\n| &&
               `            const response = await fetch(sap.z2ui5.pathname, {` && |\n| &&
               `                method: 'POST',` && |\n| &&
               `                headers: {` && |\n| &&
               `                    'Content-Type': 'application/json'` && |\n| &&
               `                },` && |\n| &&
               `                body: JSON.stringify(sap.z2ui5.oBody)` && |\n| &&
               `            });` && |\n| &&
               `            if (!response.ok) {` && |\n| &&
               `                const responseText = await response.text();` && |\n| &&
               `                sap.z2ui5.oController.responseError(responseText);` && |\n| &&
               `            } else {` && |\n| &&
               `                const responseData = await response.json();` && |\n| &&
               `                sap.z2ui5.responseData = responseData;` && |\n| &&
*               `              if( !sap.z2ui5.oBody.APP_START ) { sap.z2ui5.APP_START = sap.z2ui5.responseData.S_FRONT.APP; }` && |\n| &&
               `                sap.z2ui5.oController.responseSuccess({` && |\n| &&
               `                   ID : responseData.S_FRONT.ID,` && |\n| &&
               `                   PARAMS : responseData.S_FRONT.PARAMS,` && |\n| &&
               `                   OVIEWMODEL : responseData.MODEL,` && |\n| &&
               `                 });` && |\n| &&
               `            }` && |\n| &&
               `        },` && |\n| &&
               `        Roundtrip() {` && |\n| &&
               `            sap.z2ui5.checkTimerActive = false;` && |\n| &&
               `            sap.z2ui5.checkNestAfter = false;` && |\n| &&
               `            sap.z2ui5.checkNestAfter2 = false;` && |\n| &&
               `       let event =  (args) => { if ( args != undefined  ) { return args[0][0]; } };` && |\n| &&
               `            sap.z2ui5.oBody.S_FRONT = {` && |\n| &&
               `                ID: sap.z2ui5?.oBody?.ID,` && |\n| &&
               `                COMPDATA: (sap.z2ui5.ComponentData) ? sap.z2ui5.ComponentData : {} ,` && |\n| &&
*               `                APP_START: sap.z2ui5?.oBody?.APP_START,` && |\n| &&
               `                XX: sap.z2ui5?.oBody?.XX,` && |\n| &&
               `                ORIGIN: window.location.origin,` && |\n| &&
               `                PATHNAME: window.location.pathname, // sap.z2ui5.pathname,` && |\n| &&
               `                SEARCH: (sap.z2ui5.search) ?  sap.z2ui5.search : window.location.search,` && |\n| &&
               `                VIEW: sap.z2ui5.oBody?.VIEWNAME,` && |\n| &&
               `                T_STARTUP_PARAMETERS: sap.z2ui5.startupParameters,` && |\n| &&
           `                   EVENT:  event(sap.z2ui5.oBody?.ARGUMENTS),` && |\n| &&
               `            };` && |\n| &&
               `   if (  sap.z2ui5.oBody?.ARGUMENTS != undefined  ) { if ( sap.z2ui5.oBody?.ARGUMENTS.length > 0 ) { sap.z2ui5.oBody?.ARGUMENTS.shift(); } }` && |\n| &&
               `             sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG = sap.z2ui5.oBody?.ARGUMENTS;` && |\n| &&
               `            delete sap.z2ui5.oBody.ID;` && |\n| &&
               `            delete sap.z2ui5.oBody?.VIEWNAME;` && |\n| &&
*               `            delete sap.z2ui5.oBody?.APP_START;` && |\n| &&
               `            delete sap.z2ui5.oBody?.S_FRONT.XX;` && |\n| &&
               `            delete sap.z2ui5.oBody?.ARGUMENTS;` && |\n| &&
              `            if  (!sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG) { delete sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG; } ` && |\n| &&
              `            if  (sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG) { if (sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG.length == 0 ) { delete sap.z2ui5.oBody.S_FRONT.T_EVENT_ARG; } }` && |\n| &&
              `            if  (sap.z2ui5.oBody.S_FRONT.T_STARTUP_PARAMETERS == undefined) { delete sap.z2ui5.oBody.S_FRONT.T_STARTUP_PARAMETERS; } ` && |\n| &&
              `            if ( sap.z2ui5.oBody.S_FRONT.SEARCH == '' ){ delete sap.z2ui5.oBody.S_FRONT.SEARCH; } ` && |\n| &&
              `            if (!sap.z2ui5.oBody.XX){ delete sap.z2ui5.oBody.XX; } ` && |\n| &&
               `           sap.z2ui5.oController.readHttp();` && |\n| &&
               `        },` && |\n| &&
               `    })` && |\n| &&
               `}); } ` && |\n| &&
               `sap.ui.require(["z2ui5/Controller", "sap/ui/core/BusyIndicator", "sap/ui/model/json/JSONModel", "sap/ui/core/mvc/XMLView", "sap/ui/core/Fragment", "sap/m/MessageToast", "sap/m/MessageBox"], (Controller,BusyIndicator, JSONModel)=>{` &&
                |\n| &&
               `    BusyIndicator.show();` && |\n| &&
               `    sap.z2ui5.oController = new Controller();` && |\n| &&
               `    sap.z2ui5.oControllerNest = new Controller();` && |\n| &&
               `    sap.z2ui5.oControllerNest2 = new Controller();` && |\n| &&
               `    sap.z2ui5.oControllerPopup = new Controller();` && |\n| &&
               `    sap.z2ui5.oControllerPopover = new Controller();` && |\n| &&
               `    sap.z2ui5.pathname = sap.z2ui5.pathname ||  window.location.pathname;` && |\n| &&
               `    sap.z2ui5.checkNestAfter = false;` && |\n| &&
               `    sap.z2ui5.oBody = {` && |\n| &&
*               `        APP_START: sap.z2ui5.APP_START` && |\n| &&
               `    };` && |\n| &&
               `    sap.z2ui5.oController.Roundtrip();` && |\n| &&
               `    sap.z2ui5.onBeforeRoundtrip = [];` && |\n| &&
               `    sap.z2ui5.onAfterRendering = [];` && |\n| &&
               `    sap.z2ui5.onBeforeEventFrontend = [];` && |\n| &&
               `    sap.z2ui5.onAfterRoundtrip = []; ` && |\n| &&
*               `        // set device model` && |\n|  &&
*               `        sap.z2ui5.oDeviceModel = new JSONModel({` && |\n|  &&
*               `            isTouch : sap.ui.Device.support.touch,` && |\n|  &&
*               `            isNoTouch : !sap.ui.Device.support.touch,` && |\n|  &&
*               `            isPhone : sap.ui.Device.system.phone,` && |\n|  &&
*               `            isNoPhone : !sap.ui.Device.system.phone,` && |\n|  &&
*               `            listMode : sap.ui.Device.system.phone ? "None" : "SingleSelectMaster",` && |\n|  &&
*               `            listItemType : sap.ui.Device.system.phone ? "Active" : "Inactive"` && |\n|  &&
*               `        });` && |\n|  &&
*               `        sap.z2ui5.oDeviceModel.setDefaultBindingMode("OneWay");` && |\n|  &&
               `        ` && |\n| &&
               `    }` && |\n| &&
               `);`.

  ENDMETHOD.


  METHOD get_js_cc_startup.

    result = ` ` &&
        z2ui5_cl_cc_timer=>get_js( ) &&
        z2ui5_cl_cc_focus=>get_js( ) &&
        z2ui5_cl_cc_title=>get_js( ) &&
        z2ui5_cl_cc_lp_title=>get_js( ) &&
        z2ui5_cl_cc_history=>get_js( ) &&
        z2ui5_cl_cc_scrolling=>get_js( ) &&
        z2ui5_cl_cc_info=>get_js( ) &&
        z2ui5_cl_cc_geoloc=>get_js( ) &&
        z2ui5_cl_cc_file_upl=>get_js( ) &&
        z2ui5_cl_cc_multiinput=>get_js( ) &&
        z2ui5_cl_cc_uitable=>get_js( ) &&
        z2ui5_cl_cc_util=>get_js( ) &&
        z2ui5_cl_cc_favicon=>get_js( ) &&
       `  `.

  ENDMETHOD.


  METHOD main.

    DATA temp3 TYPE z2ui5_if_types=>ty_t_name_value.
    DATA lt_config LIKE temp3.
    DATA temp4 TYPE string.
    DATA lv_sec_policy LIKE temp4.
    DATA temp5 LIKE LINE OF lt_config.
    DATA lr_config LIKE REF TO temp5.
    DATA lv_add_js TYPE string.
    DATA temp6 TYPE z2ui5_if_types=>ty_s_http_request_get-json_model_limit.
    DATA temp7 TYPE REF TO z2ui5_cl_core_draft_srv.
    IF ms_request-t_config IS INITIAL.
      temp3 = get_default_config( ).
    ELSE.
      temp3 = ms_request-t_config.
    ENDIF.
    
    lt_config = temp3.

    
    IF ms_request-content_security_policy IS INITIAL.
      temp4 = get_default_security_policy( ).
    ELSE.
      temp4 = ms_request-content_security_policy.
    ENDIF.
    
    lv_sec_policy = temp4.

    mv_response = `<!DOCTYPE html>` && |\n| &&
               `<html lang="en">` && |\n| &&
               `<head>` && |\n| &&
                  lv_sec_policy && |\n| &&
               `    <meta charset="UTF-8">` && |\n| &&
               `    <meta name="viewport" content="width=device-width, initial-scale=1.0">` && |\n| &&
               `    <meta http-equiv="X-UA-Compatible" content="IE=edge">` && |\n| &&
               `    <title>abap2UI5</title>` && |\n| &&
               `    <style>` && |\n| &&
               `        html, body, body > div, #container, #container-uiarea {` && |\n| &&
               `            height: 100%;` && |\n| &&
               `        }` && |\n| &&
               `        .dbg-ltr {` && |\n| &&
               `            direction: ltr !important;` && |\n| &&
               `        }` && |\n| &&
               `    </style> ` &&
               `    <script id="sap-ui-bootstrap"`.

    
    
    LOOP AT lt_config REFERENCE INTO lr_config.
      mv_response = mv_response && | { lr_config->n }='{ lr_config->v }'|.
    ENDLOOP.

    mv_response = mv_response &&
        ` ></script></head>` && |\n| &&
        `<body class="sapUiBody sapUiSizeCompact" >` && |\n| &&
        `    <div id="content"  data-handle-validation="true" ></div>` && |\n| &&
        `<abc/>` && |\n|.

    
    lv_add_js = get_js_cc_startup( ) && ms_request-custom_js.

    
    IF ms_request-json_model_limit IS NOT INITIAL.
      temp6 = ms_request-json_model_limit.
    ELSE.
      temp6 = 100.
    ENDIF.
    mv_response = mv_response  &&
               `<script> sap.z2ui5 = sap.z2ui5 || {} ;  if ( typeof z2ui5 == "undefined" ) { var z2ui5 = {}; };` && |\n| &&
               get_js( ) && |\n| &&
               lv_add_js && |\n| &&
    `          sap.z2ui5.JSON_MODEL_LIMIT = ` && temp6 && `;`.

    mv_response = mv_response &&
       z2ui5_cl_cc_debug_tool=>get_js( ).

    mv_response = mv_response && |\n| &&
                 `</script>` && |\n| &&
                 `<abc/></body></html>`.

    
    CREATE OBJECT temp7 TYPE z2ui5_cl_core_draft_srv.
    temp7->cleanup( ).
    result = mv_response.

  ENDMETHOD.
ENDCLASS.
