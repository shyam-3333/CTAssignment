({
  /*  doInit : function(component, event, helper) {
        var action=component.get('c.getSchemaValue');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.pickListMaterialSampleType',result[0]);
                
            }
        });
        $A.enqueueAction(action);
    },*/
    nextPage : function(component, event, helper){
         var referenceId = component.get("v.selectedLookUpRecordForMatRefNo").Id;
        if((referenceId =='' || referenceId ==undefined )){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning',
                message: 'Select Reference No Field',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
            
        }else {
            component.set("v.toggleInputForm",true);
            component.set("v.toggleSec1",false);
            var SobjectData=component.get('v.selectedLookUpRecordForMatRefNo');
            component.set('v.testName',''+SobjectData.Testing_Type__c);
            //component.set("v.SelectedMaterialSampleType",component.find("materialPicklistId").get("v.value"));
        }
    },
    
     submitForApprovalProcess : function(component, event, helper){
       var action = component.get("c.submitForAppProcess");
        action.setParams({
         'RecId': component.get("v.qCMtlComponentId")
      });
    
      action.setCallback(this, function(response) {
          if (response.getState() == "SUCCESS") {
              debugger;
              var approvalProcessResponse = response.getReturnValue();
              helper.checkRecorIsLock(component,event,helper);
              component.set("v.showApprovalHistoryCmp", true);
          }
         
      });
      $A.enqueueAction(action); 
     },
    checkRecorIsLock : function(component,event,helper){
        var action=component.get('c.isRecordSubmitForApproval');
        action.setParams({
            'recordId': component.get('v.qCMtlComponentId')
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