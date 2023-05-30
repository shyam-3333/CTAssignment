({
	helperMethod : function(component, event, helper) {
		var action=component.get("c.fetchMaterialData");
        var data= component.get("v.referencedReportId");
        //alert('--------data(referenced)--------'+data);
        action.setParams(
            {"reportRefId" : data
                
            });
		action.setCallback(this,function(response){
            var state=response.getState();
            if(state=="SUCCESS"){
                var result=response.getReturnValue();
                var brandName = {};
                if(result[0].Brand__c != undefined && result[0].Brand__c != null && result[0].Brand__c != ''){
                    brandName = {'sobjectType' : 'QC_Access_Master__c', 'Id': result[0].Brand__c, 'Name' : result[0].Brand__r.Name};
                }
                component.set("v.mtlReportReferValue",result[0].Report_Reference_Number__c);
                component.set("v.sampleSize",result[0].Sample_Size_Qty__c);
                component.set("v.materialTestType",result[0].Testing_Type__c);
                component.set("v.rawMaterialType",result[0].Raw_Material_Type__c);
                component.set("v.mtlRecordStatusValue",result[0].Record_Status__c);
                component.set("v.documentStatusValue",result[0].Document_Status__c);
                component.set("v.qcMtlCompRecordId" , result[0].Id);
                component.set("v.sampleRecvdFrom",result[0].Sample_Received_From__c);
               	component.set("v.sampleDate",result[0].Sample_Received_Date__c);
                component.set("v.selectedLookUpRecordForBrand",brandName);
                component.set("v.prepopulateBrandCount", component.get("v.prepopulateBrandCount") + 1);
                component.set("v.mtlUserEmail",result[0].MTL_User_Email__c);
                component.find("verdictId").set(("v.value"),result[0].Final_Verdict__c);
                // fire a component event to parent
               /*var compEvent = component.getEvent("QCMtlSamplQtySizeEvent");
               compEvent.setParams({"sampleSize" : result[0].Sample_Size_Qty__c });
               compEvent.fire();*/

            }
        });
        $A.enqueueAction(action);
       
	},
})