({
    /*fetchRecords : function(component, event, helper) {
        var action = component.get('c.fetchRecord');
        var objectName = component.get("v.objectName");
        var whereCondition = component.get("v.whereCondition");
        var label = component.get('v.label');
        var searchString = document.getElementById(label).value;
        var searchFieldName = component.get("v.searchFieldName");

        action.setParams({
            "objName" : objectName ,
            "whereCond" : whereCondition,
            "searchFieldName" : searchFieldName ,
            "searchStr" : searchString
        });

        action.setCallback(this,function(response){
            var state = response.getState();
            if( state == 'SUCCESS')
            {
                var result = response.getReturnValue();
                if(result != undefined && result != null )
                {
                    var recList =[];
                    for(var i=0; i< result.length ; i++)
                    {
                        var rec = { record : result[i] , displayName : result[i][searchFieldName] };
                        recList.push( rec );
                    }
                    component.set("v.recordList",  recList );
                    var dropdown = component.find("dropdown");
                    $A.util.removeClass( dropdown , "slds-hide");
                    $A.util.addClass( dropdown , "slds-show");
                }
            }
        });
        $A.enqueueAction(action);
    },*/
})