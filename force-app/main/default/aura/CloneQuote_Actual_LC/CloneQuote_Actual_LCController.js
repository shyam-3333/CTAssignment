({
    onLoadC : function(component, event, helper) {
        debugger;
        var recId = component.get("v.recordId");
        var action = component.get("c.onLoad");
        action.setParams({
            'quoId':recId,
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                if(result === "Not approved")
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": "Quote is not approved."
                    });
                    toastEvent.fire();
                    window.location.reload();
                  
                }
                else{
                    var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Quote cloned successfully."
                });
                toastEvent.fire();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"+result
                });
                    urlEvent.fire();
                }
                
                
                
            }
            
        });
        $A.enqueueAction(action);
    }
})