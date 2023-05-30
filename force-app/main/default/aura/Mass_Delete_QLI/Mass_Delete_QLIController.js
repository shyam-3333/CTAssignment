({
    doinit : function(component, event, helper) {
        helper.toApex(component, event, helper);
    },
    
    onCheck : function(component, event, helper) {
        var id = event.target.id;
        var check = event.target.checked;
        var wraplist = component.get("v.wrapperList");
        wraplist[id].check = check;
        component.set("v.wrapperList",wraplist);
    },
    
    DeleteQli : function(component, event, helper) {
        component.set("v.delBtn",true);
       
        var wraplist = component.get("v.wrapperList");
        var selectedFalg = false;
        for(var i = 0 ; i < wraplist.length ;i++)
        {
            if(wraplist[i].check == true)
            {
                selectedFalg = true ;
            }
        }
        
        if( selectedFalg )
        {
            var action = component.get("c.deleteQli");
            action.setParams({
                "qliListStr" : JSON.stringify( wraplist )
            });
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state === "SUCCESS"){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "The record has been deleted successfully."
                    });
                    toastEvent.fire();
                    $A.get("e.force:closeQuickAction").fire();
                }
            });
            $A.enqueueAction(action);
        }
        else{
            component.set("v.delBtn",false);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error!",
                "message": "Quote line item deletion failed."
            });
            toastEvent.fire();
        }
    }
})