({
	myAction : function(component, event, helper) {
		helper.helperMethod(component,event,helper);
	},
	saveData : function(component, event, helper) {
        var sampleEmail = component.get("v.sampleRecvdFrom");
        var regExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        var sampleDate = component.get("v.sampleDate");
      	var today = new Date();        
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
        
        // if date is less then 10, then append 0 before date   
        if(dd < 10){
            dd = '0' + dd;
        } 
    	// if month is less then 10, then append 0 before date    
        if(mm < 10){
            mm = '0' + mm;
        }
        var todayFormattedDate = yyyy+'-'+mm+'-'+dd;
        
        if(component.get("v.sampleRecvd") < 1 ){
            var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Sample Size should be always greater than 0 !!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
               toastEvent.fire();
         }else if((sampleEmail !=undefined && sampleEmail !='') && !regExp.test(String(sampleEmail).toLowerCase())){
                var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                       title : 'Error Message',
                       message: 'Please Enter a valid email address !!',
                       messageTemplate: '',
                       duration:' 5000',
                       key: 'error_alt',
                       type: 'error',
                       mode: 'dismissible'
                   });
                   toastEvent.fire(); 
         }else if((sampleDate != undefined || sampleDate != '') && sampleDate > todayFormattedDate){
             var toastEvent = $A.get("e.force:showToast");
             toastEvent.setParams({
                 title : 'Error Message',
                 message: 'Sample Date cannot be future date !!',
                 messageTemplate: '',
                 duration:' 5000',
                 key: 'error_alt',
                 type: 'error',
                 mode: 'dismissible'
             });
             toastEvent.fire();  
        }else{
             helper.saveProdInfoData(component, event, helper);
         }
	},
       
    handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        if(customId == 'vendorId'){
            component.set("v.selectedLookUpRecordForVendor",selectedRecordFromEvent);
        }
        if(customId == 'brandId'){
            component.set("v.selectedLookUpRecordForBrand",selectedRecordFromEvent);
        }
    },
    
    fetchVerdStat :function(component, event, helper){
       // alert('--------verdictCounter-------'+component.get("v.finalverCounter"));
      var finalVerdStat =component.find("verdictId").get("v.value");
        //alert('Final Veridct Status Value:::'+finalVerdStat);
        var isStatus=false;
        if(finalVerdStat == undefined || finalVerdStat =='' || finalVerdStat =='None'){
            isStatus=true;
        }
        //Firing event to parent component with isStatus value.
        var finalVerEvnt = component.getEvent("FinalVerdEvntForReliab"); 
        finalVerEvnt.setParams({"finalVerdStatReliab" : isStatus });
        finalVerEvnt.fire();
        
    },
    
})