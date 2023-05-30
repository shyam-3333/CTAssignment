({
	myAction : function(component, event, helper) {
		helper.helperMethod(component,event,helper);
	},
	saveData : function(component, event, helper) {
        var sampleEmail1 = component.get("v.sampleRecvdFrom");
        var sampleEmail2 = component.get("v.sampleRecvdFrom2");
        var sampleEmail3 = component.get("v.sampleRecvdFrom3");
        var sampleEmail4 = component.get("v.sampleRecvdFrom4");
        var sampleEmail5 = component.get("v.sampleRecvdFrom5");
        var sampleDate = component.get("v.sampleDate");
        var regExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
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
        
        if((sampleEmail1 !=undefined && sampleEmail1 !='') && !regExp.test(String(sampleEmail1).toLowerCase()) &&
          (sampleEmail2 !=undefined && sampleEmail2 !='') && !regExp.test(String(sampleEmail2).toLowerCase()) &&
          (sampleEmail3 !=undefined && sampleEmail3 !='') && !regExp.test(String(sampleEmail3).toLowerCase()) &&
          (sampleEmail4 !=undefined && sampleEmail4 !='') && !regExp.test(String(sampleEmail4).toLowerCase()) &&
          (sampleEmail5 !=undefined && sampleEmail5 !='') && !regExp.test(String(sampleEmail5).toLowerCase()) ){
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
      var finalVerdStat =component.find("verdictId").get("v.value");
       // alert('Final Veridct Status Value:::'+finalVerdStat);
        var isStatus=false;
        if(finalVerdStat == undefined || finalVerdStat =='' || finalVerdStat =='None'){
            isStatus=true;
        }
        //Firing event to parent component with isStatus value.
        var finalVerEvnt = component.getEvent("FinalVerdStatEvnt"); 
        finalVerEvnt.setParams({"isFinalVerdStatus" : isStatus });
        finalVerEvnt.fire();
        
    },
    onchangeSamplesize : function(component, event, helper){
        var samplesizevalue=component.get('v.sampleRecvd');
        var data=parseInt(samplesizevalue);
        //var id=event.currentTarget.id;
        if(data<=1){
             data=1;
        }
        component.set('v.sampleRecvd',data);
    },
    
    onCheck :  function(component, event, helper){
        var checkCmp = component.find("additionalEmail").get('v.value');
        debugger;
        if( checkCmp )
        {
            var cmpTarget = component.find('additionalEmailFieldShow');
            $A.util.removeClass(cmpTarget, 'slds-hide');
            $A.util.addClass(cmpTarget, 'slds-show');

        }
        else{
            var cmpTarget = component.find('additionalEmailFieldShow');
            $A.util.removeClass(cmpTarget, 'slds-show');
            $A.util.addClass(cmpTarget, 'slds-hide');
        }
    }, 
})