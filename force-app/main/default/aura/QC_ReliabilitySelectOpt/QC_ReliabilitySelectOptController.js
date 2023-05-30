({
	toggle : function(component, event, helper) {
		var sel = component.find("mySelect");
         var nav =	sel.get("v.value");
         if (nav == "New" || nav == "Re-Certification" || nav == "Alternate Development" || nav == "Re-Submission" || nav == "Competitor Products") {     
              component.set("v.toggleGer", true);
         }
         else if(nav == "None"){
            component.set("v.toggleGer", false);
         }
        component.set("v.sampleTypeValue", nav);
	},
    doInit : function(component, event, helper) {
        helper.fetchPicklistValues(component, 'Category__c', 'Sub_Category__c');
    },
    onControllerFieldChange: function(component, event, helper) {
      //alert(event.getSource().get("v.value"));
      // get the selected value
      var controllerValueKey = event.getSource().get("v.value");
         //alert("=====controllerValueKey==>>"+controllerValueKey);
 
      // get the map values   
      var Map = component.get("v.depnedentFieldMap");
 
      // check if selected value is not equal to None then call the helper function.
      // if controller field value is none then make dependent field value is none and disable field
      if (controllerValueKey != '--- None ---') {
 
         // get dependent values for controller field by using map[key].  
         // for i.e "India" is controllerValueKey so in the map give key Name for get map values like 
         // map['India'] = its return all dependent picklist values.
         var ListOfDependentFields = Map[controllerValueKey];
         helper.fetchDepValues(component, ListOfDependentFields);
 
      } else {
         var defaultVal = [{
            class: "optionClass",
            label: '--- None ---',
            value: '--- None ---'
         }];
         component.set("v.SampleType", defaultVal);
         component.set("v.isDependentDisable", true);
      }
      var sampleTypeval = component.find("samCat").get("v.value");
      component.set("v.parentSampleCategory", sampleTypeval);
      component.set("v.parentSType",component.find("mySelect").get("v.value"));
      component.set("v.parentSubCategory",component.find("sampleSubTypeId").get("v.value"));
      if(component.get("v.sampleTypeValue") == 'Re-Submission' && sampleTypeval != null  && sampleTypeval != '' ){
             component.set("v.isReSubmission", true);
      }
   },
    goToNextPage : function(component, event, helper){
        var constructRefNo = component.get("v.selectedLookUpRecordForConstr");
       // alert('constructRefNo :: '+JSON.stringify(constructRefNo));
      // var constrRefId =('constructRefNo:: '+constructRefNo.Report_Ref_Number__c);
        var sampleTyp =component.find("mySelect").get("v.value");
        var mastVal = component.get("v.masterCheckValue");
        if((constructRefNo != undefined && constructRefNo != '' && mastVal == true) || (sampleTyp == 'Re-Submission') ){
            component.set("v.isMasterReliability", true);
        }
        if(component.get("v.selectedLookUpRecordForReSub") != undefined && component.get("v.selectedLookUpRecordForReSub") != '' && sampleTyp == 'Re-Submission'){
            var constructRefNumber = {};
            var action = component.get("c.fetchConstrRefData");
            action.setParams({
             'reportRefId': component.get("v.selectedLookUpRecordForReSub").Id
                 
            });
            action.setCallback(this, function(response) {
             if (response.getState() == "SUCCESS") {
                //store the return response from server (map<string,List<string>>)  
                var result = response.getReturnValue();
                    constructRefNumber = {'sobjectType' : 'QC_Access_Component__c', 'Id': result[0].Construction_Refer_Number__c, 'Report_Ref_Number__c' : result[0].Construction_Refer_Number__r.Report_Ref_Number__c};
                 	component.set("v.constrReferenceNumber",constructRefNumber);
                 	component.set("v.selectedLookUpRecordForConstr",constructRefNumber);
                 	component.set("v.toggleSec1", false);
                    component.set("v.toggleSec2", true);
                    component.set("v.parentSampleCategory",component.get("v.SampleCategoryValue"));
                    //component.set("v.constrReferenceNumber",constructRefNo);
                    component.set("v.parentSType",component.get("v.sampleTypeValue"));
                    component.set("v.parentSubCategory",component.get("v.selectedSubType"));
                 //}
             }
          });
          $A.enqueueAction(action);
        }
        
        if(constructRefNo != undefined && constructRefNo != '' && mastVal == true || mastVal == false){
            var action = component.get("c.savemasterReferedValue");
            action.setParams({
                'constrRefId' : component.get("v.selectedLookUpRecordForConstr").Id,
             	'masterReferedValue': true
                 
            });
        }
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var samplCateg =component.get("v.SampleCategoryValue");
        var samplSubCateg =component.get("v.selectedSubType");
        var resubRefNo = component.get("v.selectedLookUpRecordForReSub").Report_Ref_Number__c;
        if((samplCateg == undefined || samplCateg =="None" ) && (samplSubCateg == undefined || samplSubCateg=="")){
            
            //alert('fill the fields values!!');
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Error Message',
               message: 'Please fill the mandatory fields!!',
               messageTemplate: '',
               duration:' 5000',
               key: 'error_alt',
               type: 'error',
               mode: 'dismissible'
           });
           toastEvent.fire();
            
        }
        else if((samplCateg != undefined && samplCateg !="None" ) && (samplSubCateg == undefined || samplSubCateg=="")){
             //alert('Please select the related Sub-Category!!');
             var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               title : 'Error Message',
               message: 'Please select the Related Sub Category!!',
               messageTemplate: '',
               duration:' 5000',
               key: 'error_alt',
               type: 'error',
               mode: 'dismissible'
           });
           toastEvent.fire();
        }else if(sampleTyp == 'Re-Submission' && resubRefNo == undefined){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'Please select proper re-submit reference no. value!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            
        }else if((sampleTyp == 'New' || sampleTyp == 'Alternate Development' || sampleTyp == 'Re-Certification' || sampleTyp == 'Competitor Products') && constructRefNo == undefined){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'Please select proper Construction reference no. value!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            
        }
            else{
            component.set("v.toggleSec1", false);
            component.set("v.toggleSec2", true);
            component.set("v.parentSampleCategory",component.find("samCat").get("v.value"));
            component.set("v.constrReferenceNumber",constructRefNo);
            component.set("v.parentSType",component.find("mySelect").get("v.value"));
            component.set("v.parentSubCategory",component.find("sampleSubTypeId").get("v.value"));
        }
            }
          });
          $A.enqueueAction(action);
           
        

	},
	handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        
        if(customId == 'qCAccessComponentNumber'){
            component.set("v.selectedLookUpRecordForConstr",selectedRecordFromEvent);
        }
        if(customId == 'qCAccessComponentResub'){
            component.set("v.selectedLookUpRecordForReSub",selectedRecordFromEvent);
        }
        
    },
    enableSaveMode : function(component, event, helper) {
        component.set("v.showApprovalConst",false);
        if(component.get("v.masterCheckValue") == true || component.get("v.sampleTypeValue") == 'Re-Submission'){
            component.set("v.isReadonly",true);
        }else{
            component.set("v.isReadonly",false);
        }
        
    },
    enableSaveModeForReliab : function(component, event, helper) {
        component.set("v.isReadonlyForReliab",false); 
        component.set("v.showApproval",false);
    },
    saveDataFromParentConstr : function(component, event, helper) {
        var saveCount = component.get("v.callSaveFromParent");
        component.set("v.callSaveFromParent",saveCount + 1);
    },
    cancelData : function(component, event, helper) {
        component.set("v.isReadonly",true);
        component.set("v.showApprovalConst",true);
    },
    cancelDataForReliab : function(component, event, helper) {
        component.set("v.isReadonlyForReliab",true);
        component.set("v.showApproval",true);
    },
    callAccInputSave : function(component, event, helper) {
        var qCAccessComponentId = event.getParam("qCAccessComponentId");
        component.set("v.qCAccessComponentId",qCAccessComponentId);
        component.set("v.showApprovalConst",true);
        var saveCountAccInput = component.get("v.countSaveAccInput");
        component.set("v.countSaveAccInput",saveCountAccInput + 1);
        component.set("v.isReadonly",true);
        var constructionRefNumber = event.getParam("constructionRefNumber");
        component.set("v.constrReferenceNumber",constructionRefNumber);
    },
    callAccInputSaveForReliab : function(component, event, helper) {
        var qCAccessComponentId = event.getParam("qcCompIdForReliab");
        component.set("v.qCAccessComponentIdForRelaib",qCAccessComponentId);
        component.set("v.showApproval",true);
        var saveCountAccInput = component.get("v.countReliabSaveAccInput");
        component.set("v.countReliabSaveAccInput",saveCountAccInput + 1);
        component.set("v.isReadonlyForReliab",true);
    },
    passMultiSelectVal : function(component, event, helper) {
        component.set("v.passMutipickValCount",component.get("v.passMutipickValCount") + 1);
    },
    saveDataFromParentReliability : function(component, event, helper) {
        var validateCount = component.get("v.countValidateAccInput"); 
        component.set("v.countValidateAccInput",validateCount + 1);
        
    },
     submitReliabConstrRecForApproval : function(component, event, helper) {
        var VerdictCounter = component.get("v.finalVerdCounter");
        component.set("v.finalVerdCounter", VerdictCounter+1);
    },
    submitReliabRecForApproval : function(component, event, helper) {
        var ReliabVerdictCounter = component.get("v.finalVerdCounterReliab");
        component.set("v.finalVerdCounterReliab", ReliabVerdictCounter+1);
    },
    
    
    validateReliabConstrApproval : function(component,event,helper){
        var VerdStatus = event.getParam("isFinalVerdStatus");
        //alert('VerdStatus:::'+VerdStatus);
        if(VerdStatus == false){
            helper.submitReliabConstrForApprovalProcess(component,event,helper);
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
    
     validateApprovalForReliab : function(component,event,helper){
        var VerdStatus = event.getParam("finalVerdStatReliab");
        //alert('VerdStatus:::'+VerdStatus);
        if(VerdStatus == false){
            helper.submitReliabForApprovalProcess(component,event,helper);
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
    
    gotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.qCAccessComponentId")
        });
        relatedListEvent.fire();
    },
    
    reliabGotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.qCAccessComponentIdForRelaib")
        });
        relatedListEvent.fire();
    },
    
    onChangeCheckBox : function(component,event,helper){
      var checkBoxVal = component.find("masterCheckId").get("v.checked");
      component.set("v.masterCheckValue" , checkBoxVal); 
    },
    
    fetchObservatnEvntValue : function(component,event,helper){
       var ObrvEvntVal = event.getParam("isError");
       // alert('fetchObservatnEvntValue:::'+ObrvEvntVal);
        if(ObrvEvntVal == false){
            var saveCount = component.get("v.callRelaibSaveFromParent");
        	component.set("v.callRelaibSaveFromParent",saveCount + 1);
        }else{
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please fill the input parameters or Observations value in order to proceed!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }
    },
    showConstructionReliabilityReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentId");
        var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId="+recordCompId,
              "isredirect": "true"
            });
            urlEvent.fire();
    
    },
    showConstructionDetailedReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentId");
        var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QC_Acc_DetailConstr_CommonPage?compId="+recordCompId,
              "isredirect": "true"
            });
            urlEvent.fire();

    },
    showReliabilityReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentIdForRelaib");
        var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId="+recordCompId,
              "isredirect": "true"
            });
            urlEvent.fire();
    
    },
    showDetailedReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentIdForRelaib");
        var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QC_Acc_DetailConstr_CommonPage?compId="+recordCompId,
              "isredirect": "true"
            });
            urlEvent.fire();

    },


    
})