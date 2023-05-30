({
    sendEmails : function(component, event, helper) {

        var recId = component.get("v.recordId");
		var action1 = component.get("c.checkValidation");
        var validation;
        action1.setParams({
            'qId':recId,
        });
        action1.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                validation = result;
                if(validation === 'No Payment Tracker'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "type" : 'error',
                        "mode" : 'dismissible',
                        "message": " Please create Payment Tracker "
                    });
                    toastEvent.fire();
                }
                else if(validation === 'Amount recieved in payment tracker must be greater or equal than price after discount in quote'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        
                        "type" : 'error',
        				"mode" : 'dismissible',
        				"duration" : 5000,
                        "message": "Amount recieved in payment tracker must be greater or equal than price after discount in quote."
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                else if(validation === 'Approval process is started on payment tracker'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        
                        "type" : 'success',
        				"mode" : 'dismissible',
        				"duration" : 5000,
                        "message": "Approval process started on payment tracker record."
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                else if(validation === 'Approval is Pending'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        
                        "title": "Error!",
                        "type" : 'error',
                        "mode" : 'dismissible',
        				"duration" : 5000,
                        "message": "Payment tracker approval process is in progress."
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                else if(validation === 'Approval is Rejected'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        
                        "type" : 'success',
        				"mode" : 'dismissible',
        				"duration" : 5000,
                        "message": "Approval is rejected."
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                else if(validation === 'L2 approval is approved'){
                   // helper.checkVal(component,event,validation);
                   var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        
                        "type" : 'success',
                        "mode" : 'dismissible',
                        "duration" : 5000,
                        "message": "Payment Tracker record is already approved."
                    });
                    toastEvent.fire();
                    window.location.reload();
                   
                }
                else if(validation != 'Approved'){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "type" : 'error',
                        "mode" : 'dismissible',
                        "duration" : 5000,
                        "message": "Quote is not approved."
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                    else{
 window.location.reload();                        
                    }
                
                
                    
                
            }
            
        });
        $A.enqueueAction(action1);
       
            
        
    },
    
    
})