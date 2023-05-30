({
	saveProdInfoData : function(component,event,helper) {
		var selectedSampleType = component.get("v.childSampleType");
        var counterVal=component.get("v.callSaveFromParent");
		//alert(counterVal);
        if(selectedSampleType =="Competitor Products"){
            component.set("v.test2",true); //setting the value as true to update the custom setting for construction testing
        }
        if(selectedSampleType == 'New' || selectedSampleType == 'Alternate Development' || selectedSampleType == 'Re-Certification' || selectedSampleType == 'Re-Submission'){
           component.set("v.test2",true);  
        }
       
        var vendorLookup = component.get("v.selectedLookUpRecordForVendor");
        var brandLookup = component.get("v.selectedLookUpRecordForBrand");
        //this is the way you can set the fields value which is passed to apex class to insert the record 
        var data={'sobjectType': 'QC_Access_Component__c',
                  'Sample_Type__c': component.get("v.childSampleType"),
                  'Sample_Category__c': component.get("v.childSampleCategory"),
                  'Sub_Category__c': component.get("v.childSubCategory"),
                  'SKU_Reference__c' : component.get("v.SKURef"),
                  'No_Of_Sample_Received__c' : component.get("v.sampleRecvd"),
                  'Sample_Received_Date__c' : component.get("v.sampleDate"),
                  'isConstructionTesting__c' : component.get("v.test2"),
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
                  'Gender__c' : component.find("genderId").get("v.value")
                 } 
 
        var finRes=component.get("v.qcAccCompRecordId");
        if(finRes != undefined && finRes !='' ){
            var action =component.get("c.updateComponent");
			action.setParams({
				"recId" : component.get("v.qcAccCompRecordId"),
                "qacIdObj" : data
			});
		}
        
		if((finRes == undefined || finRes == '')  && (selectedSampleType == 'New' || selectedSampleType == 'Alternate Development' || selectedSampleType == 'Re-Certification' || selectedSampleType == 'Competitor Products')){
            //alert(':::coming inside the counterval in insert method>>:::::');
            var action=component.get("c.saveAndFetchDetails");
            action.setParams({
            	"qacObj" : data  
        	});
        } 
        if((finRes == undefined || finRes == '') && selectedSampleType == 'Re-Submission'){
            var action=component.get("c.saveReSubmissionData");
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
               //alert('record created');
			   component.set("v.qcAccCompRecordId" , result.Id);
               component.set("v.observatnComments" , result.General_Observation__c);
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
               var compEvent = component.getEvent("QcAccessComponentSavedEvent");
               compEvent.setParams({"qCAccessComponentId" : result.Id            
				});
               compEvent.fire();
                if( component.get( 'v.cloneFlag' ) )
                {
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        'url': 'https://lightningqc--titan.lightning.force.com/' + result.Id 
                    });
                    urlEvent.fire();
                }
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
                if(result.Vendor__c !=undefined && result.Vendor__c !=''){
                	vendorName ={'sObject' :'QC_Access_Master__c','Id' : result.Vendor__c,'Name' :result.Vendor__r.Name};
                }
                if(result.Brand__c != undefined && result.Brand__c !=''){
                    brandName = {'sObject' :'QC_Access_Master__c', 'Id' :result.Brand__c,'Name' : result.Brand__r.Name};
                }
                    if( !component.get( 'v.cloneFlag' ) )
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
                    component.set("v.observatnComments",result.General_Observation__c);
                    component.set("v.selectedLookUpRecordForVendor", vendorName);
                    component.set("v.prepopulateCount", component.get("v.prepopulateCount") + 1);
                    component.set("v.selectedLookUpRecordForBrand",brandName);
                    component.set("v.prepopulateBrandCount", component.get("v.prepopulateBrandCount") + 1);
                    component.find("genderId").set("v.value", result.Gender__c);
                } 
            });
            $A.enqueueAction(action);
            	
        }
    },
   
})