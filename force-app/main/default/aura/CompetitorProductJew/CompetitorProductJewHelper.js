({
	getRecordTypes : function(component, event, helper) {
        debugger;
		var action = component.get("c.getRecordType");
        action.setCallback(this,function(response){
           var state=response.getState();
            if(state === "SUCCESS")
            {
                var result = response.getReturnValue();
                console.log(result);
                var temp = [];
                for(var i = 0; i<result.length; i++){//{key: key, value: result[key]}
                    temp.push({label:result[i].Name,value:result[i].Name});
                }
                
                component.set("v.recTypeList",temp);//options
            }
        });
         $A.enqueueAction(action);                 
	}
})