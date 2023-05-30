({
	
    doInit : function(component, event, helper) {
        var qcAccessCompData = {'Id':component.get("v.recordId")}
        component.set("v.selectedLookUpRecordForConstr",qcAccessCompData );
        //alert('override updated');
        var action = component.get("c.fetchQcAccessCompData");
        
        action.setParams({"reportRefId" : component.get("v.recordId")
        });
        
       action.setCallback(this,function(response){
            //debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
               var result=response.getReturnValue();
                var constrnRefObj = {};
                if(result[0].Construction_Refer_Number__c != undefined && result[0].Construction_Refer_Number__c != null && result[0].Construction_Refer_Number__c != ''){
                    constrnRefObj = {'sobjectType' : 'QC_Access_Component__c', 'Id': result[0].Construction_Refer_Number__c, 'Report_Ref_Number__c' : result[0].Construction_Refer_Number__r.Report_Ref_Number__c};
                }
                component.set("v.parentSampleCategory",result[0].Sample_Category__c );
                component.set("v.isConstructionTesting",result[0].isConstructionTesting__c);
                component.set("v.isReliabilityTesting",result[0].isReliabilityTesting__c);
                component.set("v.sampleTypeValue",result[0].Sample_Type__c);
				//component.set("v.reportRefNumb",result[0].Report_Ref_Number__c.substring(result[0].Report_Ref_Number__c.indexOf('/')-1,result[0].Report_Ref_Number__c.indexOf('/')));
                debugger;
                if(result[0].Report_Ref_Number__c.substring(result[0].Report_Ref_Number__c.indexOf('/')-1,result[0].Report_Ref_Number__c.indexOf('/')) =='C'){
                    component.set("v.labelSwitch","Construction Testing");
                    component.set("v.displayTabset", true);
                    component.set("v.displayReliabTabset", false);
                }
                else{
                    component.set("v.labelSwitch","Reliability Testing");
                    component.set("v.constrRefNo",constrnRefObj);
                    component.set("v.displayTabset", false);
                    component.set("v.displayReliabTabset", true);
                }
                if(result[0].Document_Status__c == 'Published' || result[0].Document_Status__c == 'Submitted for Approval'){
                    component.set("v.disableApprovalButton",false);
                    component.set("v.disableApprovalButtonConstr",false);
                }else{
                    component.set("v.disableApprovalButton",true);
                    component.set("v.disableApprovalButtonConstr",true);
                }
               // alert('---------labelSwitch----------'+component.get("v.labelSwitch"));
            }
         });
         $A.enqueueAction(action);  
    },
    
    enableSaveMode : function(component, event, helper) {
       // var labelSwitch = component.get("v.labelSwitch");
         var recId = component.get("v.recordId");
       /*  if(labelSwitch == 'Reliability Testing'){
             recId = component.get("v.constrRefNo").Id;
         } */
        if(recId != undefined){
            var action = component.get("c.fetchDocumentStatus");
            action.setParams({
             'RecId': recId
          });
        
          action.setCallback(this, function(response) {
              if (response.getState() == "SUCCESS") {
                  var result=response.getReturnValue();
                  if(result.Document_Status__c == 'Submitted for Approval' || result.Document_Status__c == 'Published'){
                     component.set("v.isReadonly", true); 
                      component.set("v.disableApprovalButton",false);
                     var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                           title : 'Error Message',
                           message: 'Record cannot be edit. It is either submitted for approval or published!!',
                           messageTemplate: '',
                           duration:' 5000',
                           key: 'error_alt',
                           type: 'error',
                           mode: 'dismissible'
                       });
                    toastEvent.fire(); 
                  }else{
                      component.set("v.isReadonly",false);
                      component.set("v.disableApprovalButton",false);
                  }
              }
             
          });
          $A.enqueueAction(action); 
        }
    },
                             
	enableSaveModeReliabConstr : function(component, event, helper) {
         var recId = component.get("v.recordId");
         if(recId != undefined){
            var action = component.get("c.fetchMasterValue");
            action.setParams({
             'RecId': recId
          });
        
          action.setCallback(this, function(response) {
              if (response.getState() == "SUCCESS") {
                  var result=response.getReturnValue();
                  if(result.master_Reliability__c == true){
                     component.set("v.isReadonly", true); 
                      component.set("v.disableApprovalButton",false);
                     var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                           title : 'Error Message',
                           message: 'Record cannot be edit. It is a master record!!',
                           messageTemplate: '',
                           duration:' 5000',
                           key: 'error_alt',
                           type: 'error',
                           mode: 'dismissible'
                       });
                    toastEvent.fire(); 
                  }else{
                      component.set("v.isReadonly",false);
                      component.set("v.disableApprovalButton",false);
                      component.set("v.masterChkVal",result.master_Reliability__c);
                  }
              }
             
          });
          $A.enqueueAction(action); 
        }
    },
                             
    saveDataFromParent : function(component, event, helper) {
        var validateCount = component.get("v.countValidateAccInput");
        component.set("v.countValidateAccInput",validateCount + 1);
    },
    
    cancelData : function(component, event, helper) {
        component.set("v.isReadonly",true);
        component.set("v.disableApprovalButton",true);
        component.set("v.cloneRecButton",false);
    },
    callAccInputSave : function(component, event, helper) {
        var qCAccessComponentId = event.getParam("qCAccessComponentId");
        //alert('--------qCAccessComponentId-------------'+qCAccessComponentId);
        component.set("v.qCAccessComponentId",qCAccessComponentId);
        var saveCountAccInput = component.get("v.countSaveAccInput");
        component.set("v.countSaveAccInput",saveCountAccInput + 1);
        component.set("v.isReadonly",true);
        component.set("v.disableApprovalButton",true);
        var constructionRefNumber = event.getParam("constructionRefNumber");
        component.set("v.constrRefNo",constructionRefNumber);
    },
    passMultiSelectVal : function(component, event, helper) {
        component.set("v.passMutipickValCount",component.get("v.passMutipickValCount") + 1);
    },
    submitRecordForApproval : function(component, event, helper){
        var VerdictCounter = component.get("v.finalverCounter");
        component.set("v.finalverCounter", VerdictCounter+1);
         
    },
    gotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        var labelSwitch = component.get("v.labelSwitch");
         var recId = component.get("v.recordId");
         if(labelSwitch == 'Reliability Testing'){
             recId = component.get("v.constrRefNo").Id;
         }
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": recId
        });
        relatedListEvent.fire();
    },
    showReliabilityReport : function(component,event,helper){
		var recordCompId = component.get("v.recordId");
        /*var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId="+recordCompId
              
            });
            urlEvent.fire(); */
        window.open(window.location.origin + '/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId='+recordCompId, '_blank');
    },
    showDetailedReport : function(component,event,helper){
		var recordCompId = component.get("v.recordId");
        window.open(window.location.origin + '/apex/QC_Acc_DetailConstr_CommonPage?compId='+recordCompId, '_blank');

    },
    showReliabilityReportConstr : function(component,event,helper){
		var recordCompId = component.get("v.constrRefNo").Id;
        window.open(window.location.origin + '/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId='+recordCompId, '_blank');
    },
    showDetailedReportConstr : function(component,event,helper){
		var recordCompId = component.get("v.constrRefNo").Id;
        window.open(window.location.origin + '/apex/QC_Acc_DetailConstr_CommonPage?compId='+recordCompId, '_blank');

    },
     fetchObservatnEvntValue : function(component,event,helper){
       var ObrvEvntVal = event.getParam("isError");
        
        if(ObrvEvntVal == false){
            var saveCount = component.get("v.callSaveFromParent");
            component.set("v.callSaveFromParent",saveCount + 1);
        }else{
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please fill all the Observations value in order to proceed!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }
    },
     validateApproval : function(component,event,helper){
        var VerdStatus = event.getParam("isFinalVerdStatus");
         var labelSwitch = component.get("v.labelSwitch");
         var recId = component.get("v.recordId");
         if(labelSwitch == 'Reliability Testing'){
             recId = component.get("v.constrRefNo").Id;
         }
         //alert('------VerdStatus-------'+VerdStatus);
        if(VerdStatus == false){
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Success Message',
                   message: 'Record is submitted for approval!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'success',
                   mode: 'dismissible'
               });
           	toastEvent.fire(); 
            helper.submitForApprovalProcess(component,event,helper,recId);
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
    enableSaveModeForConstr : function(component, event, helper) {
        if(component.get("v.recordId") != undefined){
            var action = component.get("c.fetchDocStatusForConstr");
            action.setParams({
             'RecId': component.get("v.recordId")
          });
        
          action.setCallback(this, function(response) {
              if (response.getState() == "SUCCESS") {
                  var result=response.getReturnValue();
                  if(result.Document_Status__c == 'Submitted for Approval' || result.Document_Status__c == 'Published'){
                     component.set("v.isReadonlyForConstr", true); 
                     component.set("v.disableApprovalButtonConstr",false);
                      
                     var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                           title : 'Error Message',
                           message: 'Record cannot be edit. It is either submitted for approval or published!!',
                           messageTemplate: '',
                           duration:' 5000',
                           key: 'error_alt',
                           type: 'error',
                           mode: 'dismissible'
                       });
                    toastEvent.fire(); 
                  }else{
                      component.set("v.isReadonlyForConstr",false);
                      component.set("v.disableApprovalButtonConstr",false);
                  }
              }
             
          });
          $A.enqueueAction(action); 
        }
            
        
    },
    saveDataFromParentForConstr : function(component, event, helper) {
        var saveCount = component.get("v.callConstrSaveFromParent");
        component.set("v.callConstrSaveFromParent",saveCount + 1);
    },
    
    cancelDataForConstr : function(component, event, helper) {
        component.set("v.isReadonlyForConstr",true);
        component.set("v.disableApprovalButtonConstr",true);
    },
    callAccInputSaveForConstr : function(component, event, helper) {
        var qCAccessComponentId = event.getParam("qcCompIdForReliab");
        component.set("v.qCAccessComponentIdForConstr",qCAccessComponentId);
        var saveCountAccInput = component.get("v.countConstrSaveAccInput");
        component.set("v.countConstrSaveAccInput",saveCountAccInput + 1);
        component.set("v.isReadonlyForConstr",true);
        component.set("v.disableApprovalButtonConstr",true);
    },
    passMultiSelectVal : function(component, event, helper) {
        component.set("v.passMutipickValCount",component.get("v.passMutipickValCount") + 1);
    },
    submitReliabConstrRecForApproval : function(component, event, helper){
        var VerdictCounter = component.get("v.finalVerdCounterConstr");
        component.set("v.finalVerdCounterConstr", VerdictCounter+1);
         
    },
    constrGotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.recordId")
        });
        relatedListEvent.fire();
    },
  /*  fetchObservatnEvntValue : function(component,event,helper){
       var ObrvEvntVal = event.getParam("isError");
        if(ObrvEvntVal == false){
            var saveCount = component.get("v.callSaveFromParent");
            component.set("v.callSaveFromParent",saveCount + 1);
        }else{
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please fill all the Observations value in order to proceed!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }
    },*/
     validateApprovalForConstr : function(component,event,helper){
        var VerdStatus = event.getParam("finalVerdStatReliab");
        // alert('------VerdStatus-------'+VerdStatus);
        if(VerdStatus == false){
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Success Message',
                   message: 'Record is submitted for approval!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'success',
                   mode: 'dismissible'
               });
           	toastEvent.fire(); 
            helper.submitConstrForApprovalProcess(component,event,helper);
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

    CloneRec : function(component,event,helper)
    {
        component.set("v.cloneRecButton",true);
        component.set("v.isReadonly",false);
    },
})