({
	/* toggle : function(component, event, helper) {
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
    
    enableSaveMode : function(component, event, helper) {
        component.set("v.showApproval", false);
        if(component.get("v.qCAccessComponentId") != undefined){
            var action = component.get("c.fetchDocumentStatus");
            action.setParams({
             'RecId': component.get("v.qCAccessComponentId")
          });
        
          action.setCallback(this, function(response) {
              if (response.getState() == "SUCCESS") {
                  var result=response.getReturnValue();
                  if(result.Document_Status__c == 'Submitted for Approval' || result.Document_Status__c == 'Published'){
                     component.set("v.isReadonly", true); 
                  }else{
            		component.set("v.isReadonly",false);
                    component.set("v.inputIsReadonly",false);
              }
            }
             
          });
          $A.enqueueAction(action); 
        }else{
            component.set("v.isReadonly",false);
            component.set("v.inputIsReadonly",false);
        }
        
        
    },
    saveDataFromParent : function(component, event, helper) {
        var validateCount = component.get("v.countValidateAccInput");
        //component.set("v.callSaveFromParent",saveCount + 1);
        component.set("v.countValidateAccInput",validateCount + 1);
    },
    cancelData : function(component, event, helper) {
        component.set("v.isReadonly",true);
        component.set("v.inputIsReadonly",true);
       component.set("v.showApproval",true);
    }, 
    callAccInputSave : function(component, event, helper) {
        var qCAccessComponentId = event.getParam("qCAccessComponentId");
        component.set("v.qCAccessComponentId",qCAccessComponentId);
        component.set("v.showApproval",true);
        component.set("v.isReadonly",true);
        var saveCountAccInput = component.get("v.countSaveAccInput");
        component.set("v.countSaveAccInput",saveCountAccInput + 1);
        
        if(component.get("v.sampleTypeValue") !='Re-Submission'){
            component.set("v.inputIsReadonly",true);
        }else{
            component.set("v.inputIsReadonly",false);
        }
        
        
        component.set("v.enableReport",true);
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
      if(component.get("v.sampleTypeValue") == 'Re-Submission' && sampleTypeval != null  && sampleTypeval != '' ){
             component.set("v.isReSubmission", true);
      }
      component.set("v.parentSubCategory",component.get("v.selectedSubType"));
   },
    setSubCatValue : function(component, event, helper){
       component.set("v.parentSubCategory",component.get("v.selectedSubType"));
        var subtype = component.find("sampleSubTypeId").get("v.value");
        //alert('-------subtype-------'+subtype);
    },
    
    saveData : function(component, event, helper){
       
        debugger;
        var sampleTyp =component.find("mySelect").get("v.value");
        var samplCateg =component.get("v.SampleCategoryValue");
        var samplSubCateg =component.get("v.selectedSubType");
        var reportRefNo = component.get("v.selectedLookUpRecordForReSub").Report_Ref_Number__c;
        
        
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
        }else if(sampleTyp == 'Re-Submission' && reportRefNo == undefined){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'Please select proper reference no. value!!',
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
            debugger;
            component.set("v.parentSType",component.find("mySelect").get("v.value"));
            component.set("v.parentSubCategory",component.find("sampleSubTypeId").get("v.value"));
        }
       
},
	handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        if(customId == 'qCAccessComponentNumber'){
            component.set("v.selectedLookUpRecordForReSub",selectedRecordFromEvent);
        } 
        
    },  
    
    submitRecordForApproval : function(component, event, helper) {
        var VerdictCounter = component.get("v.finalverCounter");
        component.set("v.finalverCounter", VerdictCounter+1);
        
    },
    
    gotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.qCAccessComponentId")
        });
        relatedListEvent.fire();
    },
    
    fetchObservatnEvntValue : function(component,event,helper){
       var ObrvEvntVal = event.getParam("isError");
        //alert('fetchObservatnEvntValue:::'+ObrvEvntVal);
        if(ObrvEvntVal == false){
            var saveCount = component.get("v.callSaveFromParent");
            component.set("v.callSaveFromParent",saveCount + 1);
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
    showReliabilityReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentId");
        window.open(window.location.origin + '/apex/QC_Acc_DocumentStatus_Email_CommonPage?compId='+recordCompId, '_blank');
    
    },
    showDetailedReport : function(component,event,helper){
		var recordCompId = component.get("v.qCAccessComponentId");
        window.open(window.location.origin + '/apex/QC_Acc_DetailConstr_CommonPage?compId='+recordCompId, '_blank');

    },*/

})