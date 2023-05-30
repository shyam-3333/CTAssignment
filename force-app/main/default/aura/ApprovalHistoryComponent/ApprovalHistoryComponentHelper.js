({  
      getApprovalList : function(component) {  
     var action = component.get("c.getApprovalData");  
     action.setParams({  
       recId: component.get("v.recordId")  
     });  
     action.setCallback(this, function(a) {  
         component.set("v.approvalList", a.getReturnValue());  
       });  
     $A.enqueueAction(action);  
      }  
 })