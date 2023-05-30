({
	saveProdInfoData : function(component,event,helper)  {
		var selectedSampleType = component.get("v.childSampleType");
        var vendorLookup = component.get("v.selectedLookUpRecordForVendor");
        var brandLookup = component.get("v.selectedLookUpRecordForBrand");
        component.set("v.test2",true);
        var compId = component.get("v.constructRefNo").Id;
        //alert('------compId---------'+compId);
        //this is the way you can set the fields value which is passed to apex class to insert the record 
        var data={'sobjectType': 'QC_Access_Component__c',
                  'Sample_Type__c': component.get("v.childSampleType"),
                  'Sample_Category__c': component.get("v.childSampleCategory"),
                  'Sub_Category__c': component.get("v.childSubCategory"),
                  'SKU_Reference__c' : component.get("v.SKURef"),
                  'No_Of_Sample_Received__c' : component.get("v.sampleRecvd"),
                  'Sample_Received_Date__c' : component.get("v.sampleDate"),
                  'isReliabilityTesting__c' : component.get("v.test2"),
                  'Final_Verdict__c' : component.find("verdictId").get("v.value"),
                  'Sample_Received_From__c' : component.get("v.sampleRecvdFrom"),
                  'Sample_Received_From2__c' : component.get("v.sampleRecvdFrom2"),
                  'Sample_Received_From3__c' : component.get("v.sampleRecvdFrom3"),
                  'Sample_Received_From4__c' : component.get("v.sampleRecvdFrom4"),
                  'Sample_Received_From5__c' : component.get("v.sampleRecvdFrom5"),
                  'Vendor__c' : component.get("v.selectedLookUpRecordForVendor").Id,
                  'Brand__c' : component.get("v.selectedLookUpRecordForBrand").Id,
                  'General_Observation__c' : component.get("v.observatnComments"),
                  'Vendor_Reference__c' : component.get("v.vendorRef"),
                  'Gender__c' : component.find("genderId").get("v.value"),
                  'Construction_Refer_Number__c' : component.get("v.constructRefNo").Id,
                  'isReferredConstructionTest__c' : true,
                  'master_Reliability__c' : component.get("v.isMasterReliability")
                 } 
        
        var finRes=component.get("v.qcCompIdForReliab");
        //alert('-----finRes-------'+finRes);
        if(finRes != undefined && finRes !='' ){
            var action =component.get("c.updateComponent");
			action.setParams({
				"recId" : component.get("v.qcCompIdForReliab"),
                "qacIdObj" : data
			});
		}

        if((finRes == undefined || finRes == '')  && (selectedSampleType == 'New' || selectedSampleType == 'Alternate Development' || selectedSampleType == 'Re-Certification' || selectedSampleType == 'Competitor Products')){
            var action=component.get("c.saveNewReliabilityData");
            action.setParams({
            	"qcObjForReliabNew" : data  
        	});
        } 
        if((finRes == undefined || finRes == '')  && (selectedSampleType == 'Re-Submission')){
            var action=component.get("c.saveReliabReSubData");
        	action.setParams({
                "sampleType" : component.get("v.childSampleType"),
            	"referenceNoObj" : component.get("v.referenceComponentNo"),
                "qacObj" : data
        	});
        }
        action.setCallback(this,function(response){
            debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
               var result=response.getReturnValue();
               component.set("v.isReadonly",true);
               component.set("v.recordStatusValue", result.Record_Status__c);
               component.set("v.documentStatusValue", result.Document_Status__c);
               component.set("v.reportReferenceValue",result.Report_Ref_Number__c);
               component.set("v.qcCompIdForReliab",result.Id);
               var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Success Message',
                   message: 'Record Saved Successfully!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'success',
                   mode: 'dismissible'
           		});
           		toastEvent.fire();
                
               // fire a component event to parent
              //  if(selectedSampleType == 'New' || selectedSampleType == 'Alternate Development' || selectedSampleType == 'Re-Certification' || selectedSampleType == 'Competitor Products'){
                    var compEvent = component.getEvent("QcAccessComponentRelaibSavedEvnt");
                    compEvent.setParams({"qcCompIdForReliab" : result.Id });
                    compEvent.fire();
               // }
               /* if(selectedSampleType == 'Re-Submission'){
                    var compEvent = component.getEvent("QcAccessComponentRelaibSavedEvnt");
                    compEvent.setParams({"qcCompIdForReliab" : result.Id });
                    compEvent.setParams({"constructionRefNumber" : result})
                    compEvent.fire();
                }*/
               

            }
         });
         $A.enqueueAction(action);
	},
    fetchReSubmissionData :function(component,event,helper){
     	var reportRefNo = component.get("v.referenceComponentNo").Id;
        if(reportRefNo !=undefined && reportRefNo !=''){
             var action = component.get("c.fetchReSubmissionData");
            action.setParams({"reportRefNo" : reportRefNo});
            action.setCallback(this,function(response){
                if(response.getState() == "SUCCESS"){
                    var result = response.getReturnValue();
                    var vendorName ={};
               		var brandName = {};
                    var constructRefNumber = {};
                if(result.Vendor__c !=undefined && result.Vendor__c !=''){
                	vendorName ={'sObject' :'QC_Access_Master__c','Id' : result.Vendor__c,'Name' :result.Vendor__r.Name};
                }
                if(result.Brand__c != undefined && result.Brand__c !=''){
                    brandName = {'sObject' :'QC_Access_Master__c', 'Id' :result.Brand__c,'Name' : result.Brand__r.Name};
                }
                if(result.Construction_Refer_Number__c != undefined && result.Construction_Refer_Number__c != ''){
                    constructRefNumber = {'sobjectType' : 'QC_Access_Component__c', 'Id': result.Construction_Refer_Number__c, 'Report_Ref_Number__c' : result.Construction_Refer_Number__r.Report_Ref_Number__c};
                }
                
                    component.set("v.reportReferenceValue" ,result.Report_Ref_Number__c);
                    component.set("v.recordStatusValue" ,result.Record_Status__c);
                    //component.set("v.childSampleType" ,result.Sample_Type__c);
                    component.set("v.childSampleCategory" ,result.Sample_Category__c);
                    component.set("v.childSubCategory" ,result.Sub_Category__c);
                    //component.set("v.documentStatusValue",result.Document_Status__c);
                    component.set("v.SKURef",result.SKU_Reference__c); 
                    component.set("v.sampleRecvd",result.No_Of_Sample_Received__c);
                    component.set("v.sampleDate",result.Sample_Received_Date__c);
                    component.set("v.sampleRecvdFrom",result.Sample_Received_From__c);
                    component.set("v.sampleRecvdFrom2",result.Sample_Received_From2__c);
                    component.set("v.sampleRecvdFrom3",result.Sample_Received_From3__c);
                    component.set("v.sampleRecvdFrom4",result.Sample_Received_From4__c);
                    component.set("v.sampleRecvdFrom5",result.Sample_Received_From5__c);
                    component.set("v.vendorRef",result.Vendor_Reference__c);
                    component.set("v.selectedLookUpRecordForVendor", vendorName);
                    component.set("v.prepopulateCount1", component.get("v.prepopulateCount1") + 1);
                    component.set("v.selectedLookUpRecordForBrand",brandName);
                    component.set("v.prepopulateBrandCount1", component.get("v.prepopulateBrandCount1") + 1);
                    component.find("genderId").set("v.value", result.Gender__c);
                    component.set("v.constructRefNo",constructRefNumber);
                } 
            });
            $A.enqueueAction(action);
            	
        }
    },
})