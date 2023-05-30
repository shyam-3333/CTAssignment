({
	fetchPicklistValues: function(component, controllerField, dependentField) {
      // call the server side function  
      var action = component.get("c.getDependentOptionsImpl");
      // pass paramerters [object name , contrller field name ,dependent field name] -
      // to server side function 
 
      action.setParams({
         'objApiName': 'QC_Access_Questions__c',
         'contrfieldApiName': controllerField,
         'depfieldApiName': dependentField
      });
      //set callback   
      action.setCallback(this, function(response) {
         if (response.getState() == "SUCCESS") {
            //store the return response from server (map<string,List<string>>)  
            var StoreResponse = response.getReturnValue();
 
            // once set #StoreResponse to depnedentFieldMap attribute 
            component.set("v.depnedentFieldMap", StoreResponse);
 
            // create a empty array for store map keys(@@--->which is controller picklist values) 
 
            var listOfkeys = []; // for store all map keys (controller picklist values)
            var ControllerField = []; // for store controller picklist value to set on ui field. 
 
            // play a for loop on Return map 
            // and fill the all map key on listOfkeys variable.
            for (var singlekey in StoreResponse) {
               listOfkeys.push(singlekey);
            }
 
            //set the controller field value for ui:inputSelect  
            if (listOfkeys != undefined && listOfkeys.length > 0) {
               ControllerField.push({
                  class: "optionClass",
                  label: "--- None ---",
                  value: "--- None ---"
               });
            }
 
            for (var i = 0; i < listOfkeys.length; i++) {
               ControllerField.push({
                  class: "optionClass",
                  label: listOfkeys[i],
                  value: listOfkeys[i]
               });
            }
            // set the ControllerField variable values to country(controller picklist field)
            component.set("v.SampleCat", ControllerField);
         }
      });
      $A.enqueueAction(action);
   },
 
 
   fetchDepValues: function(component, ListOfDependentFields) {
      // create a empty array var for store dependent picklist values for controller field)  
      var dependentFields = [];
 
      if (ListOfDependentFields != undefined && ListOfDependentFields.length > 0) {
         dependentFields.push({
            class: "optionClass",
            label: "--- None ---",
            value: "--- None ---"
         });
 
      }
      for (var i = 0; i < ListOfDependentFields.length; i++) {
         dependentFields.push({
            class: "optionClass",
            label: ListOfDependentFields[i],
            value: ListOfDependentFields[i]
         });
      }
      // set the dependentFields variable values to State(dependent picklist field) on ui:inputselect    
      component.set("v.subType", dependentFields);
      // make disable false for ui:inputselect field 
      component.set("v.isDependentDisable", false);
   },
    submitReliabConstrForApprovalProcess : function(component, event, helper){
       var action = component.get("c.submitForAppProcess");
        action.setParams({
         'RecId': component.get("v.qCAccessComponentId")
      });
    
      action.setCallback(this, function(response) {
          if (response.getState() == "SUCCESS") {
              debugger;
              var approvalProcessResponse = response.getReturnValue();
              component.set("v.showApprovalHistoryCmp", true);
          }
         
      });
      $A.enqueueAction(action); 
    },
    
    submitReliabForApprovalProcess : function(component, event, helper){
       var action = component.get("c.submitForAppProcess");
        action.setParams({
         'RecId': component.get("v.qCAccessComponentIdForRelaib")
      });
    
      action.setCallback(this, function(response) {
          if (response.getState() == "SUCCESS") {
              debugger;
              var approvalProcessResponse = response.getReturnValue();
              component.set("v.showApprovalHistoryForReliabCmp", true);
          }
         
      });
      $A.enqueueAction(action); 
    } 
    
})