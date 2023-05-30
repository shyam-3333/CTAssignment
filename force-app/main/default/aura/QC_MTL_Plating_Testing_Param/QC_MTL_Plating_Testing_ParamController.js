({
	doinit : function(component, event, helper) {
		helper.fetchRecord(component, event, helper);
	},
    saveData : function(component, event, helper) {
        
       		 var dateData =component.get("v.sampleDate");
       		 var dataArr=[];
         if (isNaN(Date.parse(dateData)) &&  (dateData != '' && dateData != undefined) && dateData != (new Date(dateData)).toISOString().substr(0,10) ) {
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
        var smplSz= component.get("v.referencedReportrecordObject.Sample_Size_Plating__c");
        if(smplSz <0){
            	  dataArr.push(smplSz);
       			   var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Sample Size should be always greater than zero !!',
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
            if(!regExp.test(String(emailData).toLowerCase()) && (emailData == '' && emailData == undefined)){
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
        var data={'sobjectType': 'QC_MTL_Component__c',
                  'Id' : component.get('v.referencedReportrecordObject.Id'),
                  'Material_Sample_Type__c': component.get("v.materialSampleTypeField"),
                  'Sample_Size_Plating__c' : component.get("v.referencedReportrecordObject.Sample_Size_Plating__c"),
                  'Sample_Received_Date__c' : component.get("v.sampleDate"),
                  'Sample_Received_From__c' : component.get("v.sampleRecvdFrom"),
                  'MTL_User__c' : component.get("v.selectedLookUpRecordForVendor").Id,
                  'Brand__c' : component.get("v.selectedLookUpRecordForBrand").Id,
                  'Final_Verdict__c' : component.find("verdictId").get("v.value")
                 } 
       // alert('data---'+data);
        
        if(dataArr.length ==0){
        var action=component.get("c.updateComponent");
            action.setParams({
                "infoData" : data
        	}); 
        action.setCallback(this,function(response){
            debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
                
               var result=response.getReturnValue();
               component.set("v.isReadonly",true);
               component.set("v.mtlRecordStatusValue", result.Record_Status__c);
               component.set("v.referencedReportrecordObject.Document_Status__c", result.Document_Status__c);
                component.set("v.referencedReportrecordObject.Report_Reference_Number__c",result.Report_Reference_Number__c);
                //alert('record updated!!');
                component.set("v.qcMtlCompRecordId" , result.Id);
               // fire a component event to parent
               var compEvent = component.getEvent("QcMtlComponentSavedEvent");
               compEvent.setParams({"qCMTLTestComponentId" : result.Id });
               compEvent.fire();
             

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
    
    fetchVerdictStatus :function(component, event, helper){
      var finalVerdStat =component.find("verdictId").get("v.value");
       //alert('-------finalVerdStat-----'+finalVerdStat);
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