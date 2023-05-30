({
 
    submitForApprovalProcess : function(component, event, helper,recId){
       var action = component.get("c.submitForAppProcess");
        action.setParams({
         'RecId': recId
      });
    
      action.setCallback(this, function(response) {
          if (response.getState() == "SUCCESS") {
              debugger;
              var approvalProcessResponse = response.getReturnValue();
              component.set("v.showApprovalHistoryCmp", true);
          }
         
      });
      $A.enqueueAction(action); 
    },
    submitConstrForApprovalProcess : function(component, event, helper){
       var action = component.get("c.submitForAppProcess");
        action.setParams({
         'RecId': component.get("v.recordId")
      });
    
      action.setCallback(this, function(response) {
          if (response.getState() == "SUCCESS") {
              debugger;
              var approvalProcessResponse = response.getReturnValue();
              component.set("v.showApprovalHistoryForConstrCmp", true);
          }
         
      });
      $A.enqueueAction(action); 
    },
    
})