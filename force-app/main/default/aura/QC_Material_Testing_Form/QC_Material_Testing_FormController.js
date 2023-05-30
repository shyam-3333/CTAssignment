({
   doInit : function(component, event, helper) {
      //  helper.doInit(component, event, helper);
    },
    nextPage : function(component, event, helper){
        helper.nextPage(component, event, helper);
    },
    handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        if(customId == 'qcMTLReferenceId'){
            component.set("v.selectedLookUpRecordForMatRefNo",selectedRecordFromEvent);
        } 
        
    }, 
     enableSaveMode : function(component, event, helper) {
         let ischeckLock=component.get('v.isRecordLock');
         if(ischeckLock){
            component.set('v.isReadonly',ischeckLock); 
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Information',
                   message: 'Record is Lock!!',
                   duration:'5000',
                    key: 'info_alt',
                   type: 'warning',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
         }else{
             component.set("v.isReadonly",false);
         }
    },
    cancelData : function(component, event, helper) {
        component.set("v.isReadonly",true);
        component.set("v.toggleInputForm",false);
        component.set("v.toggleSec1",true);
    }, 
    
   /* changeCounterValue : function(component,event,handler){
        var count = event.getParam("counterVal");
        component.set("v.callUpdateFrmParntInptParam" , count);
    },*/ //comment by Anin
	callMtlInputSave : function(component, event, helper) {
        var qCMtlComponentId = event.getParam("qCMTLTestComponentId");
        component.set("v.qCMtlComponentId",qCMtlComponentId);
        var saveCountMtlInput = component.get("v.countSaveMtlInput");
        component.set("v.countSaveMtlInput",saveCountMtlInput + 1);
        component.set("v.isReadonly",true);
        
    },
    
    sampleSizeChange : function(component,event,helper){
        var evntVal =event.getParam("changedSamplSz");
        //alert('In parent event value::'+evntVal);
        component.set("v.changeSampleSizeData",evntVal);
    } ,
    
    validateApproval : function(component,event,helper){
        var VerdStatus = event.getParam("isFinalVerdStatus");
        //alert('VerdStatus:::'+VerdStatus);
        if(VerdStatus == false){
            helper.submitForApprovalProcess(component,event,helper);
        }else{
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please select Final Verdict Value other than None!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }  
    },
    
    submitRecordForApproval : function(component, event, helper) {
        var VerdictCounter = component.get("v.finalverCounter");
        component.set("v.finalverCounter", VerdictCounter+1);
        var VerdictCounterPlating = component.get("v.finalverCounterPlating");
        component.set("v.finalverCounterPlating", VerdictCounterPlating + 1);
        helper.checkRecorIsLock(component,event,helper);
		
    },
    
    gotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.qCMtlComponentId")
        });
        relatedListEvent.fire();
    },
    
    saveDataFromParent : function(component, event, helper) {
        debugger;
        var validateCount = component.get("v.callSaveFromParent");
        component.set("v.callSaveFromParent",validateCount + 1);
		var passData=component.get('v.countSaveMtlInput');
        component.set("v.callSaveFromParent",passData + 1);
        //component.set("v.countValidateAccInput",validateCount + 1);
    },
        
    /*fetchSampleSizeValue : function(component, event, helper) {
         var selectedSampleValueFrmEvnt = event.getParam("sampleSize");
        component.set("v.sampleSizeQty",selectedSampleValueFrmEvnt);
    }*/
})