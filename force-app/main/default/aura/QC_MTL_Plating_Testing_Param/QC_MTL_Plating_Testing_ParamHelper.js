({
	fetchRecord : function(component, event, helper) {
        debugger;
		var action=component.get('c.getRecordInfo');
        action.setParams({
            'recordId' : component.get('v.referencedReportrecordObject.Id')
        });
        action.setCallback(this, function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
               var result=response.getReturnValue();
                debugger;
                  component.set("v.SampleType",result.materialInformation.Material_Sample_Type__c);
                  component.set("v.referencedReportrecordObject.Sample_Size_Plating__c",result.materialInformation.Sample_Size_Plating__c);
                  component.set("v.sampleDate",result.materialInformation.Sample_Received_Date__c);
                  component.set("v.sampleRecvdFrom",result.materialInformation.Sample_Received_From__c);
                  component.set('v.mtlRecordStatusValue',result.materialInformation.Record_Status__c);
                  component.set('v.mtlUserEmail',result.materialInformation.MTL_User_Email__c)
                  //component.set('v.materialSampleTypeField',result.materialInformation.Material_Sample_Type__c);
                if(result.materialInformation.Brand__c != undefined && result.materialInformation.Brand__c != null && result.materialInformation.Brand__c != ''){
                  var brandName  = {'sobjectType' : 'QC_Access_Master__c', 'Id': result.materialInformation.Brand__c, 'Name' : result.materialInformation.Brand__r.Name};
                component.set("v.selectedLookUpRecordForBrand",brandName);
                    component.set("v.prepopulateBrandCount", component.get("v.prepopulateBrandCount") + 1);
                
                }  
                  component.set("v.VerdictStatusValue",result.materialInformation.Final_Verdict__c);
            }
        });
        $A.enqueueAction(action);
	}
})