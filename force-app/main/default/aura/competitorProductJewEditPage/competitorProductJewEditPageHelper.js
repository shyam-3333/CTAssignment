({
    getRecType : function(component, event, helper){
		var recId = component.get("v.recordId");
        var action = component.get("c.getRecodTypeName");
         action.setParams({
            'recId':recId
        });
        action.setCallback(this,function(response){
           var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                console.log(result);
                component.set("v.RecTypeName",result);//options
            }
        });
         $A.enqueueAction(action);   
	}
})