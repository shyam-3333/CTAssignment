({
	myAction : function(component, event, helper) {
		helper.helperMethod(component,event,helper);
        
	},
    saveData : function(component, event, helper) {
       
       	var dateData =component.get("v.sampleDate");
        var dataArr=[];
         if ((dateData !=undefined && dateData !='') && isNaN(Date.parse(dateData)) && dateData != (new Date(dateData)).toISOString().substr(0,10)) {
				dataArr.push(dateData);
       			   var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Date cannot be text value !!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
               toastEvent.fire();
    	} 
        	var emailData = component.get("v.sampleRecvdFrom");
           	var regExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if((emailData !=undefined && emailData !='') && !regExp.test(String(emailData).toLowerCase())){
                dataArr.push(emailData);
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
            }  
        //this is the way you can set the fields value which is passed to apex class to insert the record 
        var mtlemail=component.get('v.mtlUserEmail');
        if((mtlemail ==undefined || mtlemail =='')){
            dataArr.push(mtlemail);
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
        }
        
        	var data={'sobjectType': 'QC_MTL_Component__c',
                  'Raw_Material_Type__c': component.get("v.rawMaterialType"),
                  'Report_Reference_Number__c': component.get("v.mtlReportReferValue"),
                  'Testing_Type__c' : component.get("v.materialTestType"),
                  'Sample_Size_Qty__c' : component.get("v.sampleSize"),
                  'Sample_Received_Date__c' : component.get("v.sampleDate"),
                  'Sample_Received_From__c' : component.get("v.sampleRecvdFrom"),
                  'MTL_User_Email__c' : component.get("v.mtlUserEmail"),
                  'Brand__c' : component.get("v.selectedLookUpRecordForBrand").Id,
                  'Final_Verdict__c' : component.find("verdictId").get("v.value")
                  
                 }
               //alert('data---'+data);
		var componentId =component.get("v.qcMtlCompRecordId");
        //var selectedSampleType =component.get("v.materialSampleType");
        if(componentId != 'undefined' && componentId !='' && dataArr.length == 0){
            var action=component.get("c.updateComponent");
            action.setParams({
            	"recId" : component.get("v.qcMtlCompRecordId"),
                "infoData" : data
        	});
			action.setCallback(this,function(response){
            debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
               var result=response.getReturnValue();
               component.set("v.isReadonly",true);
               component.set("v.mtlRecordStatusValue", result.Record_Status__c);
               component.set("v.documentStatusValue", result.Document_Status__c);
               component.set("v.mtlReportReferValue",result.Report_Reference_Number__c);
               component.set("v.sampleDate",result.CreatedDate); 
                //alert('record updated!!');
               var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Success Message',
                   message: 'Record Updated Successfully!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'success',
                   mode: 'dismissible'
               });
           		toastEvent.fire();
                component.set("v.qcMtlCompRecordId" , result.Id);
                
               // fire a component event to parent
               var compEvent = component.getEvent("QcMtlComponentSavedEvent");
               compEvent.setParams({"qCMTLTestComponentId" : result.Id });
               compEvent.fire();
             /*   var counter=1;
                var compEv = component.getEvent("updateInpParamData");
                compEv.setParams({"counterVal" :counter});
                compEv.fire();*/
                
                //making changes here to test if we can uncheck the dispTest checkbox.
                /*var evntData = component.get("uncheckGenTestCounterEvnt");
                var counter =1;
                evntData.setParams({"uncheckGenTestCounter" : counter});
                evntData.fire();*/

            }
         });
		  $A.enqueueAction(action);
        }
			else{
					var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                       title : 'Error Message',
                       message: 'Please fill the details correctly in order to proceed !!',
                       messageTemplate: '',
                       duration:' 5000',
                       key: 'error_alt',
                       type: 'error',
                       mode: 'dismissible'
                   });
                   toastEvent.fire();
				
			}
        
        
	
	},
       
    handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        if(customId == 'mtlUserId'){
            component.set("v.selectedLookUpRecordForVendor",selectedRecordFromEvent);
        }
        if(customId == 'brandId'){
            component.set("v.selectedLookUpRecordForBrand",selectedRecordFromEvent);
        }
    },
    changeSampleSize : function(component,event,helper){
      var changedSample=component.get("v.sampleSize");
        //alert('changed sample size:: '+changedSample);
        var evntdata= component.getEvent("ChangedSampleSizeEvnt");
        evntdata.setParams({"changedSamplSz":changedSample});
        evntdata.fire();
    },
    
    fetchVerdictStatus :function(component, event, helper){
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
    
})