CLASS z2ui5_cl_fw_http_get DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA ms_request TYPE z2ui5_if_client=>ty_s_http_request_get .
    DATA mv_response TYPE string .

    METHODS constructor
      IMPORTING
        val TYPE z2ui5_if_client=>ty_s_http_request_get OPTIONAL.

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
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_FW_HTTP_GET IMPLEMENTATION.


  METHOD constructor.

    ms_request = val.

  ENDMETHOD.


  METHOD get_js.

    result = `sap.ui.define("z2ui5/Controller", ["sap/ui/core/mvc/Controller", "sap/ui/core/mvc/XMLView", "sap/ui/model/json/JSONModel", "sap/ui/core/BusyIndicator", "sap/m/MessageBox", "sap/m/MessageToast", "sap/ui/core/Fragment"], function(Control` &&
  `ler, XMLView, JSONModel, BusyIndicator, MessageBox, MessageToast, Fragment) {` && |\n|  &&
               `    "use strict";` && |\n|  &&
               `    return Controller.extend("z2ui5.Controller", {` && |\n|  &&
               `        async onAfterRendering() {` && |\n|  &&
               `         try{` && |\n|  &&
               `            if (!sap.z2ui5.oResponse.PARAMS) {` && |\n|  &&
                            `            BusyIndicator.hide();` && |\n|  &&
               `            if (sap.z2ui5.isBusy) {` && |\n|  &&
               `                sap.z2ui5.isBusy = false;` && |\n|  &&
               `            }` && |\n|  &&
               `            if (sap.z2ui5.busyDialog) {` && |\n|  &&
               `                sap.z2ui5.busyDialog.close();` && |\n|  &&
               `            }` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            const {S_POPUP, S_VIEW_NEST, S_VIEW_NEST2, S_POPOVER} = sap.z2ui5.oResponse.PARAMS;` && |\n|  &&
               `            if (S_POPUP?.CHECK_DESTROY) {` && |\n|  &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n|  &&
               `            }` && |\n|  &&
               `            if (S_POPOVER?.CHECK_DESTROY) {` && |\n|  &&
               `                sap.z2ui5.oController.PopoverDestroy();` && |\n|  &&
               `            }` && |\n|  &&
               `            if (S_POPUP?.XML) {` && |\n|  &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n|  &&
               `                await this.displayFragment(S_POPUP.XML, 'oViewPopup');` && |\n|  &&
               `            }` && |\n|  &&
               `            if (!sap.z2ui5.checkNestAfter) {` && |\n|  &&
               `                if (S_VIEW_NEST?.XML) {` && |\n|  &&
               `                    sap.z2ui5.oController.NestViewDestroy();` && |\n|  &&
               `                    await this.displayNestedView(S_VIEW_NEST.XML, 'oViewNest', 'S_VIEW_NEST');` && |\n|  &&
               `                    sap.z2ui5.checkNestAfter = true;` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `            if (!sap.z2ui5.checkNestAfter2) {` && |\n|  &&
               `                if (S_VIEW_NEST2?.XML) {` && |\n|  &&
               `                    sap.z2ui5.oController.NestViewDestroy2();` && |\n|  &&
               `                    await this.displayNestedView2(S_VIEW_NEST2.XML, 'oViewNest2', 'S_VIEW_NEST2');` && |\n|  &&
               `                    sap.z2ui5.checkNestAfter2 = true;` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `            if (S_POPOVER?.XML) {` && |\n|  &&
               `                await this.displayPopover(S_POPOVER.XML, 'oViewPopover', S_POPOVER.OPEN_BY_ID);` && |\n|  &&
               `            }` && |\n|  &&
               `            BusyIndicator.hide();` && |\n|  &&
               `            if (sap.z2ui5.isBusy) {` && |\n|  &&
               `                sap.z2ui5.isBusy = false;` && |\n|  &&
               `            }` && |\n|  &&
               `            if (sap.z2ui5.busyDialog) {` && |\n|  &&
               `                sap.z2ui5.busyDialog.close();` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.onAfterRendering.forEach(item=>{` && |\n|  &&
               `                if (item !== undefined) {` && |\n|  &&
               `                    item();` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `            )` && |\n|  &&
`           }catch(e){ BusyIndicator.hide(); sap.z2ui5.isBusy = false; MessageBox.error( e.toLocaleString() , { title : "Unexpected Error Occured - App Terminated" , actions : [ ] , onClose :  () => {  new sap.m.BusyDialog({ text : "Please Restart t` &&
`he App" }).open();  } } ) }` && |\n| &&
               `        },` && |\n|  &&
               |\n|  &&
               `        async displayFragment(xml, viewProp, openById) {` && |\n|  &&
               `            const oFragment = await Fragment.load({` && |\n|  &&
               `                definition: xml,` && |\n|  &&
               `                controller: sap.z2ui5.oControllerPopup,` && |\n|  &&
                `                id: "popupId"` && |\n|  &&
               `            });` && |\n|  &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `            oFragment.setModel(oview_model);` && |\n|  &&
               `            let oControl = openById ? this.getControlById(openById) : null;` && |\n|  &&
               `            if (oControl) {` && |\n|  &&
               `                oFragment.openBy(oControl);` && |\n|  &&
               `            } else {` && |\n|  &&
               `                oFragment.open();` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5[viewProp] = oFragment;` && |\n|  &&
               `        },` && |\n|  &&
               `        async displayPopover(xml, viewProp, openById) {` && |\n|  &&
               `            const oFragment = await Fragment.load({` && |\n|  &&
               `                definition: xml,` && |\n|  &&
               `                controller: sap.z2ui5.oControllerPopover,` && |\n|  &&
               `                 id: "popoverId"` && |\n|  &&
               `            });` && |\n|  &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `            oFragment.setModel(oview_model);` && |\n|  &&
               `            let oControl = openById ? this.getControlById(openById) : null;` && |\n|  &&
               `            if (oControl) {` && |\n|  &&
               `                oFragment.openBy(oControl);` && |\n|  &&
               `            } else {` && |\n|  &&
               `                oFragment.open();` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5[viewProp] = oFragment;` && |\n|  &&
               `        },` && |\n|  &&
               `        async displayNestedView(xml, viewProp, viewNestId) {` && |\n|  &&
               `            const oView = await XMLView.create({` && |\n|  &&
               `                definition: xml,` && |\n|  &&
               `                controller: sap.z2ui5.oControllerNest,` && |\n|  &&
               `            });` && |\n|  &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `            oView.setModel(oview_model);` && |\n|  &&
               |\n|  &&
               `            let oParent = sap.z2ui5.oView.byId(sap.z2ui5.oResponse.PARAMS[viewNestId].ID);` && |\n|  &&
               `            if (oParent) {` && |\n|  &&
               `                try {` && |\n|  &&
               `                    oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_DESTROY]();` && |\n|  &&
               `                } catch {}` && |\n|  &&
               `                oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_INSERT](oView);` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5[viewProp] = oView;` && |\n|  &&
               `        },` && |\n|  &&
               `        async displayNestedView2(xml, viewProp, viewNestId) {` && |\n|  &&
               `            const oView = await XMLView.create({` && |\n|  &&
               `                definition: xml,` && |\n|  &&
               `                controller: sap.z2ui5.oControllerNest2,` && |\n|  &&
               `            });` && |\n|  &&
               `            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `            oView.setModel(oview_model);` && |\n|  &&
               |\n|  &&
               `            let oParent = sap.z2ui5.oView.byId(sap.z2ui5.oResponse.PARAMS[viewNestId].ID);` && |\n|  &&
               `            if (oParent) {` && |\n|  &&
               `                try {` && |\n|  &&
               `                    oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_DESTROY]();` && |\n|  &&
               `                } catch {}` && |\n|  &&
               `                oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_INSERT](oView);` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5[viewProp] = oView;` && |\n|  &&
               `        },` && |\n|  &&
               `        getControlById(id) {` && |\n|  &&
               `            let oControl = sap.z2ui5.oView.byId(id);` && |\n|  &&
               `            if (!oControl) {` && |\n|  &&
               `                oControl = sap.ui.getCore().byId(id);` && |\n|  &&
*               `                debugger;` && |\n|  &&
               `            }` && |\n|  &&
               `            if (!oControl) {` && |\n|  &&
               `                oControl = sap.z2ui5.oViewNest.byId(id) || sap.z2ui5.oViewNest2.byId(id);` && |\n|  &&
               `            }` && |\n|  &&
               `            return oControl;` && |\n|  &&
               `        },` && |\n|  &&
               |\n|  &&
               `        PopupDestroy() {` && |\n|  &&
               `            if (!sap.z2ui5.oViewPopup) {` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            if (sap.z2ui5.oViewPopup.close) {` && |\n|  &&
               `                try {` && |\n|  &&
               `                    sap.z2ui5.oViewPopup.close();` && |\n|  &&
               `                } catch {}` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oViewPopup.destroy();` && |\n|  &&
               `        },` && |\n|  &&
               `        PopoverDestroy() {` && |\n|  &&
               `            if (!sap.z2ui5.oViewPopover) {` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            if (sap.z2ui5.oViewPopover.close) {` && |\n|  &&
               `                try {` && |\n|  &&
               `                    sap.z2ui5.oViewPopover.close();` && |\n|  &&
               `                } catch {}` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oViewPopover.destroy();` && |\n|  &&
               `        },` && |\n|  &&
               `        NestViewDestroy() {` && |\n|  &&
               `            if (!sap.z2ui5.oViewNest) {` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oViewNest.destroy();` && |\n|  &&
               `        },` && |\n|  &&
               `        NestViewDestroy2() {` && |\n|  &&
               `            if (!sap.z2ui5.oViewNest2) {` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oViewNest2.destroy();` && |\n|  &&
               `        },` && |\n|  &&
               `        ViewDestroy() {` && |\n|  &&
               `            if (!sap.z2ui5.oView) {` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oView.destroy();` && |\n|  &&
               `        },` && |\n|  &&
               `        onEventFrontend(...args) {` && |\n|  &&
               |\n|  &&
               `            sap.z2ui5.onBeforeEventFrontend.forEach(item => {` && |\n|  &&
               `                if (item !== undefined) {` && |\n|  &&
               `                    item(args);` && |\n|  &&
               `                }` && |\n|  &&
               `              }` && |\n|  &&
               `            )` && |\n|  &&
               |\n|  &&
               `            let oCrossAppNavigator;` && |\n|  &&
               `            switch (args[0].EVENT) {` && |\n|  &&
               `            case 'CROSS_APP_NAV_TO_PREV_APP':` && |\n|  &&
               `                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");` && |\n|  &&
               `                oCrossAppNavigator.backToPreviousApp();` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'CROSS_APP_NAV_TO_EXT':` && |\n|  &&
               `                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");` && |\n|  &&
               `                const hash = (oCrossAppNavigator.hrefForExternal({` && |\n|  &&
               `                    target: args[1],` && |\n|  &&
               `                    params: args[2]` && |\n|  &&
               `                })) || "";` && |\n|  &&
               `                if (args[3] === 'EXT') {` && |\n|  &&
               `                    let url = window.location.href.split('#')[0] + hash;` && |\n|  &&
               `                    sap.m.URLHelper.redirect(url, true);` && |\n|  &&
               `                } else {` && |\n|  &&
               `                    oCrossAppNavigator.toExternal({` && |\n|  &&
               `                        target: {` && |\n|  &&
               `                            shellHash: hash` && |\n|  &&
               `                        }` && |\n|  &&
               `                    });` && |\n|  &&
               `                }` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'LOCATION_RELOAD':` && |\n|  &&
               `                window.location = args[1];` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'OPEN_NEW_TAB':` && |\n|  &&
               `                window.open(args[1], '_blank');` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'POPUP_CLOSE':` && |\n|  &&
               `                sap.z2ui5.oController.PopupDestroy();` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'POPOVER_CLOSE':` && |\n|  &&
               `                sap.z2ui5.oController.PopoverDestroy();` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'NAV_CONTAINER_TO':` && |\n|  &&
               `                var navCon = sap.z2ui5.oView.byId(args[1]);` && |\n|  &&
               `                var navConTo = sap.z2ui5.oView.byId(args[2]);` && |\n|  &&
               `                navCon.to(navConTo);` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'NEST_NAV_CONTAINER_TO':` && |\n|  &&
               `                navCon = sap.z2ui5.oViewNest.byId(args[1]);` && |\n|  &&
               `                navConTo = sap.z2ui5.oViewNest.byId(args[2]);` && |\n|  &&
               `                navCon.to(navConTo);` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'NEST2_NAV_CONTAINER_TO':` && |\n|  &&
               `                navCon = sap.z2ui5.oViewNest2.byId(args[1]);` && |\n|  &&
               `                navConTo = sap.z2ui5.oViewNest2.byId(args[2]);` && |\n|  &&
               `                navCon.to(navConTo);` && |\n|  &&
               `                break;` && |\n|  &&
               `            case 'POPUP_NAV_CONTAINER_TO':` && |\n|  &&
               `                navCon = Fragment.byId("popupId",args[1]);` && |\n|  &&
               `                navConTo = Fragment.byId("popupId",args[2]);` && |\n|  &&
               `                navCon.to(navConTo);` && |\n|  &&
               `                break;` && |\n|  &&
               `            }` && |\n|  &&
               `        },` && |\n|  &&
               `        onEvent(...args) {` && |\n|  &&
               `            if (sap.z2ui5.isBusy) {` && |\n|  &&
               `                if (sap.z2ui5.isBusy == true) {` && |\n|  &&
               `                    sap.z2ui5.busyDialog = new sap.m.BusyDialog();` && |\n|  &&
               `                    sap.z2ui5.busyDialog.open();` && |\n|  &&
               `                    return;` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.isBusy = true;` && |\n|  &&
               `            if (!window.navigator.onLine) {` && |\n|  &&
               `                sap.m.MessageBox.alert('No internet connection! Please reconnect to the server and try again.');` && |\n|  &&
               `                sap.z2ui5.isBusy = false;` && |\n|  &&
               `                return;` && |\n|  &&
               `            }` && |\n|  &&
               `            BusyIndicator.show();` && |\n|  &&
               `            sap.z2ui5.oBody = {};` && |\n|  &&
               `            if ( sap.z2ui5.oController == this ) {` && |\n|  &&
               `                sap.z2ui5.oBody.EDIT = sap.z2ui5.oView.getModel().getData().EDIT;` && |\n|  &&
               `                sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n|  &&
               `            }else if ` && |\n|  &&
               `               (  sap.z2ui5.oControllerPopup == this ) {` && |\n|  &&
               `                    sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewPopup.getModel().getData().EDIT;` && |\n|  &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n|  &&
               `                }else if ( ` && |\n|  &&
               `                sap.z2ui5.oControllerPopover == this ) {` && |\n|  &&
               `                            sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewPopover.getModel().getData().EDIT;` && |\n|  &&
               `                            sap.z2ui5.oBody.VIEWNAME = 'MAIN';` && |\n|  &&
               `                }else if ( ` && |\n|  &&
               `                sap.z2ui5.oControllerNest == this ) {` && |\n|  &&
               `                    sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewNest.getModel().getData().EDIT;` && |\n|  &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'NEST';` && |\n|  &&
               `                }else if (` && |\n|  &&
               `                sap.z2ui5.oControllerNest2 == this ) {` && |\n|  &&
               `                    sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewNest2.getModel().getData().EDIT;` && |\n|  &&
               `                    sap.z2ui5.oBody.VIEWNAME = 'NEST2';` && |\n|  &&
               `                }` && |\n|  &&
               `            sap.z2ui5.onBeforeRoundtrip.forEach(item=>{` && |\n|  &&
               `                if (item !== undefined) {` && |\n|  &&
               `                    item();` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `            )` && |\n|  &&
               `            if (args[0].CHECK_VIEW_DESTROY) {` && |\n|  &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oBody.ID = sap.z2ui5.oResponse.ID;` && |\n|  &&
               `            sap.z2ui5.oBody.ARGUMENTS = args;` && |\n|  &&
               |\n|  &&
               `            sap.z2ui5.oResponseOld = sap.z2ui5.oResponse;` && |\n|  &&
               `            sap.z2ui5.oResponse = {};` && |\n|  &&
               `            sap.z2ui5.oController.Roundtrip();` && |\n|  &&
               `        },` && |\n|  &&
               `        responseError(response) {` && |\n|  &&
               `            document.write(response);` && |\n|  &&
               `        },` && |\n|  &&
               `        updateModelIfRequired(paramKey, oView) {` && |\n|  &&
               `            if (sap.z2ui5.oResponse.PARAMS == undefined) { return; }` && |\n|  &&
               `            if (sap.z2ui5.oResponse.PARAMS[paramKey]?.CHECK_UPDATE_MODEL) {` && |\n|  &&
               `                let model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `                model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `                oView.setModel(model);` && |\n|  &&
               `            }` && |\n|  &&
               `        },` && |\n|  &&
               `   async     responseSuccess(response) {` && |\n|  &&
               `         try{` && |\n|  &&
               `            sap.z2ui5.oResponse = response;` && |\n|  &&
               |\n|  &&
               `            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.CHECK_DESTROY) {` && |\n|  &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n|  &&
               `            }` && |\n|  &&
               |\n|  &&
               `            sap.z2ui5.oController.showMessage('S_MSG_TOAST', sap.z2ui5.oResponse.PARAMS);` && |\n|  &&
               `            sap.z2ui5.oController.showMessage('S_MSG_BOX', sap.z2ui5.oResponse.PARAMS);` && |\n|  &&
               `            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML) { if ( sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML !== '') {` && |\n|  &&
               `                sap.z2ui5.oController.ViewDestroy();` && |\n|  &&
               `               await sap.z2ui5.oController.createView(sap.z2ui5.oResponse.PARAMS.S_VIEW.XML, sap.z2ui5.oResponse.OVIEWMODEL);` && |\n|  &&
               `            return;  } } ` && |\n|  &&
               `                this.updateModelIfRequired('S_VIEW', sap.z2ui5.oView);` && |\n|  &&
               `                this.updateModelIfRequired('S_VIEW_NEST', sap.z2ui5.oViewNest);` && |\n|  &&
               `                this.updateModelIfRequired('S_VIEW_NEST2', sap.z2ui5.oViewNest2);` && |\n|  &&
               `                this.updateModelIfRequired('S_POPUP', sap.z2ui5.oViewPopup);` && |\n|  &&
               `                this.updateModelIfRequired('S_POPOVER', sap.z2ui5.oViewPopover);` && |\n|  &&
               `                sap.z2ui5.oController.onAfterRendering();` && |\n|  &&
`           }catch(e){ BusyIndicator.hide(); MessageBox.error(e.toLocaleString()); }` && |\n|  &&
               `        },` && |\n|  &&
               `        showMessage(msgType, params) {` && |\n|  &&
               `            if (params == undefined) { return; }` && |\n|  &&
               `            if (params[msgType]?.TEXT !== undefined) {` && |\n|  &&
               `                if (msgType === 'S_MSG_TOAST') {` && |\n|  &&
               `                    MessageToast.show(params[msgType].TEXT);` && |\n|  &&
               `                } else if (msgType === 'S_MSG_BOX') {` && |\n|  &&
               `                    MessageBox[params[msgType].TYPE](params[msgType].TEXT);` && |\n|  &&
               `                }` && |\n|  &&
               `            }` && |\n|  &&
               `        },` && |\n|  &&
               `        async createView(xml, viewModel) {` && |\n|  &&
               `            const oView = await XMLView.create({` && |\n|  &&
               `                definition: xml,` && |\n|  &&
               `                controller: sap.z2ui5.oController,` && |\n|  &&
               `            });` && |\n|  &&
               `            let oview_model = new JSONModel(viewModel);` && |\n|  &&
               `            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);` && |\n|  &&
               `            oView.setModel(oview_model);` && |\n|  &&
               |\n|  &&
               `            if (sap.z2ui5.oParent) {` && |\n|  &&
               `                sap.z2ui5.oParent.removeAllPages();` && |\n|  &&
               `                sap.z2ui5.oParent.insertPage(oView);` && |\n|  &&
               `            } else {` && |\n|  &&
               `                oView.placeAt("content");` && |\n|  &&
               `            }` && |\n|  &&
               `            sap.z2ui5.oView = oView;` && |\n|  &&
               `        },` && |\n|  &&
               `        async readHttp() {` && |\n|  &&
               `            const response = await fetch(sap.z2ui5.pathname, {` && |\n|  &&
               `                method: 'POST',` && |\n|  &&
               `                headers: {` && |\n|  &&
               `                    'Content-Type': 'application/json'` && |\n|  &&
               `                },` && |\n|  &&
               `                body: JSON.stringify(sap.z2ui5.oBody)` && |\n|  &&
               `            });` && |\n|  &&
               |\n|  &&
               `            if (!response.ok) {` && |\n|  &&
               `                const responseText = await response.text();` && |\n|  &&
               `                sap.z2ui5.oController.responseError(responseText);` && |\n|  &&
               `            } else {` && |\n|  &&
               `                const responseData = await response.json();` && |\n|  &&
*               `                debugger;` && |\n|  &&
               `                sap.z2ui5.oController.responseSuccess({` && |\n|  &&
               `                   ID : responseData.S_FRONTEND.ID,` && |\n|  &&
               `                   PARAMS : responseData.S_FRONTEND.PARAMS,` && |\n|  &&
               `                   OVIEWMODEL : responseData.MODEL,` && |\n|  &&
               `                 });` && |\n|  &&
               `            }` && |\n|  &&
               |\n|  &&
               `        },` && |\n|  &&
               |\n|  &&
               `        Roundtrip() {` && |\n|  &&
               |\n|  &&
               `            sap.z2ui5.checkTimerActive = false;` && |\n|  &&
               `            sap.z2ui5.checkNestAfter = false;` && |\n|  &&
               `            sap.z2ui5.checkNestAfter2 = false;` && |\n|  &&
               |\n|  &&
               `            sap.z2ui5.oBody.OLOCATION = {` && |\n|  &&
               `                ORIGIN: window.location.origin,` && |\n|  &&
               `                PATHNAME: sap.z2ui5.pathname,` && |\n|  &&
               `                SEARCH: window.location.search,` && |\n|  &&
               `                //      VERSION: sap.ui.getVersionInfo().gav,` && |\n|  &&
               `                T_STARTUP_PARAMETERS: sap.z2ui5.startupParameters,` && |\n|  &&
               `            };` && |\n|  &&
               `            if (sap.z2ui5.search) {` && |\n|  &&
               `                sap.z2ui5.oBody.OLOCATION.SEARCH = sap.z2ui5.search;` && |\n|  &&
               `            }` && |\n|  &&
               `       let event =  (args) => { if ( args != undefined  ) { return args[ 0 ].EVENT; } };` && |\n|  &&
*               `       let args =  (args) => { if (  args != undefined  ) { if ( args.length > 1 ) { return args.shift(); } } };` && |\n|  &&
               `            sap.z2ui5.oBody.S_FRONTEND = {` && |\n|  &&
               `                ID: sap.z2ui5?.oBody?.ID,` && |\n|  &&
               `                APP_START: sap.z2ui5?.oBody?.APP_START,` && |\n|  &&
               `                EDIT: sap.z2ui5?.oBody?.EDIT,` && |\n|  &&
               `                ORIGIN: sap.z2ui5.oBody.OLOCATION.ORIGIN,` && |\n|  &&
               `                PATHNAME: sap.z2ui5.oBody.OLOCATION.PATHNAME,` && |\n|  &&
               `                SEARCH: sap.z2ui5.oBody.OLOCATION.SEARCH,` && |\n|  &&
               `                VIEWNAME: sap.z2ui5.oBody.VIEWNAME,` && |\n|  &&
               `                T_STARTUP_PARAMETERS: sap.z2ui5.oBody.OLOCATION.T_STARTUP_PARAMETERS,` && |\n|  &&
           `                   EVENT:  event(sap.z2ui5.oBody?.ARGUMENTS),` && |\n|  &&
               `            };` && |\n|  &&
               `   if (  sap.z2ui5.oBody?.ARGUMENTS != undefined  ) { if ( sap.z2ui5.oBody?.ARGUMENTS.length > 0 ) { sap.z2ui5.oBody?.ARGUMENTS.shift(); } }` && |\n|  &&
               `             sap.z2ui5.oBody.S_FRONTEND.T_EVENT_ARG = sap.z2ui5.oBody?.ARGUMENTS;` && |\n|  &&
*               `            debugger;` && |\n|  &&
               `           sap.z2ui5.oController.readHttp();` && |\n|  &&
               `        },` && |\n|  &&
               `    })` && |\n|  &&
               `});` && |\n|  &&
               |\n|  &&
               `sap.ui.require(["z2ui5/Controller", "sap/ui/core/BusyIndicator", "sap/ui/core/mvc/XMLView", "sap/ui/core/Fragment", "sap/m/MessageToast", "sap/m/MessageBox", "sap/ui/model/json/JSONModel"], (Controller,BusyIndicator)=>{` && |\n|  &&
               |\n|  &&
               `    BusyIndicator.show();` && |\n|  &&
               `    sap.z2ui5.oController = new Controller();` && |\n|  &&
               `    sap.z2ui5.oControllerNest = new Controller();` && |\n|  &&
               `    sap.z2ui5.oControllerNest2 = new Controller();` && |\n|  &&
               `    sap.z2ui5.oControllerPopup = new Controller();` && |\n|  &&
               `    sap.z2ui5.oControllerPopover = new Controller();` && |\n|  &&
               |\n|  &&
               `    sap.z2ui5.pathname = sap.z2ui5.pathname ||  window.location.pathname;` && |\n|  &&
               `    sap.z2ui5.checkNestAfter = false;` && |\n|  &&
               |\n|  &&
               `    sap.z2ui5.oBody = {` && |\n|  &&
               `        APP_START: sap.z2ui5.APP_START` && |\n|  &&
               `    };` && |\n|  &&
               `    sap.z2ui5.oController.Roundtrip();` && |\n|  &&
               |\n|  &&
               `    sap.z2ui5.onBeforeRoundtrip = [];` && |\n|  &&
               `    sap.z2ui5.onAfterRendering = [];` && |\n|  &&
               `    sap.z2ui5.onBeforeEventFrontend = [];` && |\n|  &&
               `    sap.z2ui5.onAfterRoundtrip = []; }` && |\n|  &&
               `);`.

  ENDMETHOD.


  METHOD get_js_cc_startup.

    result = ` ` &&
        z2ui5_cl_fw_cc_timer=>get_js( ) &&
        z2ui5_cl_fw_cc_focus=>get_js( ) &&
        z2ui5_cl_fw_cc_title=>get_js( ) &&
        z2ui5_cl_fw_cc_history=>get_js( ) &&
        z2ui5_cl_fw_cc_scrolling=>get_js( ) &&
        z2ui5_cl_fw_cc_info_frontend=>get_js( ) &&
        z2ui5_cl_fw_cc_geolocation=>get_js( ) &&
        z2ui5_cl_fw_cc_file_uploader=>get_js( ) &&
        z2ui5_cl_fw_cc_multiinput_ext=>get_js( ) &&
        z2ui5_cl_fw_cc_uitable_ext=>get_js( ) &&
        z2ui5_cl_fw_cc_util=>get_js( ) &&
        z2ui5_cl_fw_cc_favicon=>get_js( ) &&
       `  `.

  ENDMETHOD.


  METHOD main.

    DATA lt_config LIKE ms_request-t_config.
      DATA temp1 TYPE z2ui5_if_client=>ty_t_name_value.
      DATA temp2 LIKE LINE OF temp1.
      DATA lv_sec_policy TYPE string.
    DATA temp3 LIKE LINE OF lt_config.
    DATA lr_config LIKE REF TO temp3.
    DATA lv_add_js TYPE string.
    DATA temp4 TYPE z2ui5_if_client=>ty_s_http_request_get-json_model_limit.
    lt_config = ms_request-t_config.
    IF lt_config IS INITIAL.
      
      CLEAR temp1.
      
      temp2-n = `src`.
      temp2-v = `https://ui5.sap.com/1.120.0/resources/sap-ui-core.js`.
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
      lt_config = temp1.
    ENDIF.

    IF ms_request-content_security_policy IS INITIAL.
      
      lv_sec_policy = `<meta http-equiv="Content-Security-Policy" content="default-src 'self' 'unsafe-inline' 'unsafe-eval' data: ` &&
        `ui5.sap.com *.ui5.sap.com sapui5.hana.ondemand.com *.sapui5.hana.ondemand.com sdk.openui5.org *.sdk.openui5.org cdn.jsdelivr.net *.cdn.jsdelivr.net cdnjs.cloudflare.com *.cdnjs.cloudflare.com"/>`.
    ELSE.
      lv_sec_policy = ms_request-content_security_policy.
    ENDIF.

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
      mv_response = mv_response && | { lr_config->n }="{ lr_config->v }"|.
    ENDLOOP.

    mv_response = mv_response &&
        ` ></script></head>` && |\n| &&
        `<body class="sapUiBody sapUiSizeCompact" >` && |\n| &&
        `    <div id="content"  data-handle-validation="true" ></div>` && |\n| &&
        `<abc/>` && |\n|.

    
    lv_add_js = get_js_cc_startup( ) && ms_request-custom_js.

    
    IF ms_request-json_model_limit IS NOT INITIAL.
      temp4 = ms_request-json_model_limit.
    ELSE.
      temp4 = 100.
    ENDIF.
    mv_response = mv_response  &&
               `<script> sap.z2ui5 = sap.z2ui5 || {};` && |\n|  &&
               get_js( ) && |\n| &&
               lv_add_js && |\n| &&
    `          sap.z2ui5.JSON_MODEL_LIMIT = ` && temp4 && `;`.

    mv_response = mv_response &&
       z2ui5_cl_fw_cc_debugging_tools=>get_js( ) &&
    `  sap.ui.require(["z2ui5/DebuggingTools","z2ui5/Controller"], (DebuggingTools) => { sap.z2ui5.DebuggingTools = new DebuggingTools(); ` && |\n| &&
    ` });`.

    mv_response =  mv_response && |\n| &&
                 `</script>` && |\n| &&
                 `<abc/></body></html>`.

    z2ui5_cl_fw_draft=>cleanup( ).

    result = mv_response.
  ENDMETHOD.
ENDCLASS.