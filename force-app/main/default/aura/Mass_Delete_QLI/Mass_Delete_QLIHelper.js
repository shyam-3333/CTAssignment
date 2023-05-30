({
    toApex : function(component, event, helper) {
        debugger;
        var quoteId = component.get("v.recordId");
        var action = component.get("c.fetchQLIs");
        action.setParams({
            'qId' : quoteId
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === "SUCCESS"){
                var wrapList = response.getReturnValue();
                component.set("v.wrapperList",JSON.parse( wrapList));
            }
        });
    $A.enqueueAction(action);
    }
})