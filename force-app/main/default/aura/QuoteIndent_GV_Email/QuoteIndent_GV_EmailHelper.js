({
	checkVal : function(component,event,val){
        if(val == 'L2 approval is approved'){
            var recId = component.get("v.recordId");
         var action = component.get("c.attachWordpdf");
        action.setParams({
            'Ids':recId,
            'butt':'IndentGV'
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Operation successfull."
                    });
                    toastEvent.fire();
                    window.location.reload();
                
            }
            
        });
        $A.enqueueAction(action);
        }
        
    }
})