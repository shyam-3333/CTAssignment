({
    sendEmails : function(component, event, helper) {

        debugger;
        var recId = component.get("v.recordId");
        var action = component.get("c.attachWordpdf");
        action.setParams({
            'Ids':recId,
            'butt':'ProformaInvoiceGV'
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
})