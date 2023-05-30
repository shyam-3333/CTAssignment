({
    onLoadMethod : function(component, event, helper) {
        var action = component.get('c.onLoadMethod');
        component.set("v.Spinner", true);
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                component.set("v.Spinner", false);
                component.set('v.skinnModelItemList',response.getReturnValue());
            } else {
                component.set("v.Spinner", false);
                alert('please check the Object permission');
            }
        });
        $A.enqueueAction(action);
    },
    convertArrayOfObjectsToCSV : function(component,objectRecords){
        // declare variables
        var csvStringResult, counter, keys, columnDivider, lineDivider;
       
        // check if "objectRecords" parameter is null, then return from function
        if (objectRecords == null || !objectRecords.length) {
            return null;
         }
        // store ,[comma] in columnDivider variabel for sparate CSV values and 
        // for start next line use '\n' [new line] in lineDivider varaible  
        columnDivider = ',';
        lineDivider =  '\n';
 
        // in the keys valirable store fields API Names as a key 
        // this labels use in CSV file header  
        keys = ['Id','Serial_No__c','Item_Name__c','Type__c','Order_No__c',
                'Parent_Order_No__c','Assigned_Team__c','Planned_Lead_Time__c',
                'TemplateType__c','Approval_required__c' ];
        
        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;
 
        for(var i=0; i < objectRecords.length; i++){   
            counter = 0;
           
             for(var sTempkey in keys) {
                var skey = keys[sTempkey] ;  
 
              // add , [comma] after every String value,. [except first]
                  if(counter > 0){ 
                      csvStringResult += columnDivider; 
                   }   
               
               csvStringResult +=  objectRecords[i][skey]; 
               
               counter++;
 
            } // inner for loop close 
             csvStringResult += lineDivider;
          }// outer main for loop close 
       
       // return the CSV formate String 
        return csvStringResult;        
    },
    showTost: function (component, event, helper, VariantName, Message) {
        if (VariantName == "warring")
            helper.warringTMsg(component, event, helper, Message);
        if (VariantName == "error")
            helper.errorTMsg(component, event, helper, Message);
        if (VariantName == "information")
            helper.informationTMsg(component, event, helper, Message);
        if (VariantName == "success")
            helper.successTMsg(component, event, helper, Message);
    },
    warringTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Warning!",
            "type": "warning",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    errorTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "type": "error",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    informationTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Information!",
            "type": "info",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    successTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type": "success",
            "message": "" + Message
        });
        toastEvent.fire();
    },
})