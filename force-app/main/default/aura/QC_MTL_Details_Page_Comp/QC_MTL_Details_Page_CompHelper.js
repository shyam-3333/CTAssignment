({
    doInit: function (component, event, helper) {
        var action = component.get("c.getQCMTLComponentRecord");
        action.setParams({
            "recordId": component.get("v.recordId")
        });
        action.setCallback(this, function (response) {
            var status = response.getState();
            if (status === "SUCCESS") {
                debugger;
                var result = response.getReturnValue();
                component.set('v.QCMTlComponentObject', result.record);
                component.set('v.alltestParameter', result.alltestResponse);
                var depName;
                if(result.record.Testing_Type__c=='Plating'){
                    depName=result.record.Department__c;
                }
                if(result.record.Optional_Test__c!=undefined){
                    var optionalTestvaluses=result.record.Optional_Test__c;
                    if(optionalTestvaluses.includes("Material Composition")){
                        component.set("v.optionalTesthaveMCValue",true);
                    }else{
                        component.set("v.optionalTesthaveMCValue",false);
                    }
                }else{
                    component.set("v.optionalTesthaveMCValue",false);
                }
                
                if(result.record.Testing_Type__c=='Plating and Material Composition'){
                    depName=result.record.Department_PMC__c;
                }
                if(!(depName=='QC Appearance' || depName=='IDI' || depName=='Vendor Plating')){
                    component.set('v.minMaxDisab',true);
                }
                var listFromDB = result.allCompositionPickList[0];
                var materialComplist = [];
                for (var i = 0; i < listFromDB.length; i++) {
                    materialComplist.push({ "label": listFromDB[i], "value": listFromDB[i], "selected": false })
                }
                var listFromDB2 = result.allCompositionPickList[1];
                var materialComplist2 = [];
                for (var i = 0; i < listFromDB2.length; i++) {
                    materialComplist2.push({ "label": listFromDB2[i], "value": listFromDB2[i], "selected": false })
                }
                var listFromDB3 = result.allCompositionPickList[2];
                var materialComplist3 = [];
                for (var i = 0; i < listFromDB3.length; i++) {
                    materialComplist3.push({ "label": listFromDB3[i], "value": listFromDB3[i], "selected": false })
                }
                var listFromDB4 = result.allCompositionPickList[3];
                var materialComplist4 = [];
                for (var i = 0; i < listFromDB4.length; i++) {
                    materialComplist4.push({ "label": listFromDB4[i], "value": listFromDB4[i], "selected": false })
                }
                var listFromDB5 = result.allCompositionPickList[4];
                var materialComplist5 = [];
                for (var i = 0; i < listFromDB5.length; i++) {
                    materialComplist5.push({ "label": listFromDB5[i], "value": listFromDB5[i], "selected": false })
                }
                component.set('v.materialCompositionPickList', materialComplist);
                component.set('v.materialCompositionPickList2', materialComplist2);
                component.set('v.materialCompositionPickList3', materialComplist3);
                component.set('v.materialCompositionPickList4', materialComplist4);
                component.set('v.materialCompositionPickList5', materialComplist5);
                var materialPickList = component.get("v.materialPickList");
                var materialCompositionPickList = component.get("v.materialCompositionPickList");
                var materialCompositionPickList2 = component.get("v.materialCompositionPickList2");
                var materialCompositionPickList3 = component.get("v.materialCompositionPickList3");
                var materialCompositionPickList4 = component.get("v.materialCompositionPickList4");
                var materialCompositionPickList5 = component.get("v.materialCompositionPickList5");
                for (var i = 0; i < materialCompositionPickList.length; i++) {
                    if (materialCompositionPickList[i].value == result.record.Chemical_Composition_Elements__c) {
                        materialCompositionPickList[i].selected = result.record.Chemical_Composition_Elements__c;
                        break;
                    }
                }
                for (var i = 0; i < materialCompositionPickList2.length; i++) {
                    if (materialCompositionPickList2[i].value == result.record.Chemical_Composition_Elements_2__c) {
                        materialCompositionPickList2[i].selected = result.record.Chemical_Composition_Elements_2__c;
                        break;
                    }
                }
                for (var i = 0; i < materialCompositionPickList3.length; i++) {
                    if (materialCompositionPickList3[i].value == result.record.Chemical_Composition_Elements_3__c) {
                        materialCompositionPickList3[i].selected = result.record.Chemical_Composition_Elements_3__c;
                        break;
                    }
                }
                for (var i = 0; i < materialCompositionPickList4.length; i++) {
                    if (materialCompositionPickList4[i].value == result.record.Chemical_Composition_Elements_4__c) {
                        materialCompositionPickList4[i].selected = result.record.Chemical_Composition_Elements_4__c;
                        break;
                    }
                }
                for (var i = 0; i < materialCompositionPickList5.length; i++) {
                    if (materialCompositionPickList5[i].value == result.record.Chemical_Composition_Elements_5__c) {
                        materialCompositionPickList5[i].selected = result.record.Chemical_Composition_Elements_5__c;
                        break;
                    }
                }
                component.set('v.MaterialCompositionValue1',result.record.Chemical_Composition_ElementsObservation__c==undefined?" ":result.record.Chemical_Composition_ElementsObservation__c);
                component.set('v.MaterialCompositionValue2',result.record.Chemical_Composition_ElementsObser1__c==undefined?" ":result.record.Chemical_Composition_ElementsObser1__c);
                component.set('v.MaterialCompositionValue3',result.record.Chemical_Composition_ElementsObser2__c==undefined?" ":result.record.Chemical_Composition_ElementsObser2__c);
                component.set('v.MaterialCompositionValue4',result.record.Chemical_Composition_ElementsObser3__c==undefined?" ":result.record.Chemical_Composition_ElementsObser3__c);
                component.set('v.MaterialCompositionValue5',result.record.Chemical_Composition_ElementsObser4__c==undefined?" ":result.record.Chemical_Composition_ElementsObser4__c);
                component.set('v.MaterialCompositionResult1',result.record.Chemical_Composition_ElementsResult__c==undefined?" ":result.record.Chemical_Composition_ElementsResult__c);
                component.set('v.MaterialCompositionResult2',result.record.Chemical_Composition_ElementsResult1__c==undefined?" ":result.record.Chemical_Composition_ElementsResult1__c);
                component.set('v.MaterialCompositionResult3',result.record.Chemical_Composition_ElementsResult2__c==undefined?" ":result.record.Chemical_Composition_ElementsResult2__c);
                component.set('v.MaterialCompositionResult4',result.record.Chemical_Composition_ElementsResult3__c==undefined?" ":result.record.Chemical_Composition_ElementsResult3__c);
                component.set('v.MaterialCompositionResult5',result.record.Chemical_Composition_ElementsResult4__c==undefined?" ":result.record.Chemical_Composition_ElementsResult4__c);
                if(result.record.Component_Name__c=="Others"){
                  component.set("v.IscomponentNameOthers",true);
                }
                if(result.record.Component_Name__c=="Accessories"){
                  component.set("v.IscomponentNameAccessories",true);
                }
                debugger;
                for (var i = 0; i < result.alltestResponse.length; i++) {
                    if (result.alltestResponse[i].Plating_Testing_Type__c == 'Optional') {
                        component.set('v.IsHasOptionTest', true);
                    }
                    if (result.alltestResponse[i].Plating_Testing_Type__c == 'Regular') {
                        component.set('v.IsHasRegularTest', true);
                    }
                    if (result.alltestResponse[i].Plating_Testing_Type__c != 'Optional' && result.alltestResponse[i].Plating_Testing_Type__c != 'Regular') {
                        component.set('v.IsHasTestParam', true);
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },
    saveInfo: function (component, event, helper) {
        var record = JSON.stringify(component.get('v.QCMTlComponentObject'));
        var recordSplit=record.split('}');
        var addString1="\"Chemical_Composition_ElementsObservation__c\":\""+component.get('v.MaterialCompositionValue1')+"\",";
        var addString2="\"Chemical_Composition_ElementsObser1__c\":\""+component.get('v.MaterialCompositionValue2')+"\",";
        var addString3="\"Chemical_Composition_ElementsObser2__c\":\""+component.get('v.MaterialCompositionValue3')+"\",";
        var addString4="\"Chemical_Composition_ElementsObser3__c\":\""+component.get('v.MaterialCompositionValue4')+"\",";
        var addString5="\"Chemical_Composition_ElementsObser4__c\":\""+component.get('v.MaterialCompositionValue5')+"\",";
        var addString6="\"Chemical_Composition_ElementsResult__c\":\""+component.get('v.MaterialCompositionResult1')+"\",";
        var addString7="\"Chemical_Composition_ElementsResult1__c\":\""+component.get('v.MaterialCompositionResult2')+"\",";
        var addString8="\"Chemical_Composition_ElementsResult2__c\":\""+component.get('v.MaterialCompositionResult3')+"\",";
        var addString9="\"Chemical_Composition_ElementsResult3__c\":\""+component.get('v.MaterialCompositionResult4')+"\",";
        var addString10="\"Chemical_Composition_ElementsResult4__c\":\""+component.get('v.MaterialCompositionResult5')+"\"}";
        recordSplit[0]+=","+addString1+addString2+addString3+addString4+addString5+addString6+addString7+addString8+addString9+addString10;
        debugger;
        record=recordSplit[0];
        var alltest = JSON.stringify(component.get('v.alltestParameter'));
        var saveaction = component.get("c.savaRecord");
        saveaction.setParams({
            'record': record,
            'allTests': alltest
        });
        saveaction.setCallback(this, function (response) {
            var status = response.getState();
            if (status === "SUCCESS") {
                var result = response.getReturnValue();
                 helper.checkRecorIsLoak(component,event,helper);
                // let isrecordlok= component.get('v.isRecordLock');
                component.set('v.isReadonly', true);
            }
        });
        $A.enqueueAction(saveaction);
    },
    
    submitForApprovalProcess: function (component, event, helper) {
        var action = component.get("c.submitForAppProcess");
        action.setParams({
            'RecId': component.get("v.recordId")
        });
        
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                debugger;
                var approvalProcessResponse = response.getReturnValue();
                component.set("v.approvalList", response.getReturnValue());
                helper.checkRecorIsLoak(component,event,helper);
                //component.set("v.showApprovalHistoryCmp", true);
            }
            
        });
        $A.enqueueAction(action);
    },
    getApprovalList : function(component) {  
        var action = component.get("c.getApprovalData");  
        action.setParams({  
            recId: component.get("v.recordId")  
        });  
        action.setCallback(this, function(a) {  
            component.set("v.approvalList", a.getReturnValue()); 
            component.set("v.showApprovalHistoryCmp", true); 
        });  
        $A.enqueueAction(action);  
    },
    checkRecorIsLoak : function(component,event,helper){
        var action=component.get('c.isRecordSubmitForApproval');
        action.setParams({
            'recordId': component.get('v.recordId')
        });
        action.setCallback(this,(response)=>{
            if(response.getState()==="SUCCESS"){
            let result= response.getReturnValue();
            component.set('v.isRecordLock',result);
        }
                           });
        $A.enqueueAction(action); 
    }
    
    
})