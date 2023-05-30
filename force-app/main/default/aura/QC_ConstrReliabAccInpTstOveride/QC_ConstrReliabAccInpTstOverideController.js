({
	doInit : function(component, event, helper) {
        var cate=component.get("v.cat");
        
       /* var cmpEvnt=$A.get("e.c:passDataToReliab");
        cmpEvnt.setParams({
            "multiSelectPckValues" : component.get("v.multiSelectList")
        });
        cmpEvnt.fire();*/
        
        if(cate != undefined && cate != null && cate != ''){
            helper.showInput(component, event, helper);
            
        }
	},
    reInit : function(component, event, helper) {
        var cate=component.get("v.cat");
       // var multiSelectList = component.get("v.multiSelectList");
        if(cate != undefined && cate != null && cate != ''){
            helper.showInput(component, event, helper);
        }
    },

    handleSelectChangeEvent: function(component, event, helper) {
   		var selectedItems = event.getParam("values");
        var picklistId = event.getParam("picklistId");
        var questionId = event.getParam("questionId");
        var responseIds = event.getParam("responseIds");
        var tData=component.get("v.testData");
        
        var multiSelectList = component.get("v.multiSelectList");
        for(var i = 0; i < multiSelectList.length; i++){
            if(i == picklistId){
                multiSelectList[i].questId = questionId;
                multiSelectList[i].selectedOptions = selectedItems;
                multiSelectList[i].responseIds = responseIds;
            }
        }
        component.set("v.multiSelectList",multiSelectList);
       /* var cmpEvnt= component.get("passDataToReliab");
        cmpEvnt.setParams({
            "multiSelectPckValues" : component.get("v.multiSelectList")
        });
        cmpEvnt.fire();  */ 
        
	},
    
    saveAccInputData :function(component, event, helper) {
        var tData=component.get("v.testParamListReliabConst");
        var sampleType = component.get("v.subChildSampleType" );
        debugger;
        //alert('Need to inplement Acc Input data save functionality');
        component.set("v.isReadonly",true);
        var multiSelectList = component.get("v.multiSelectList");
        var QcAccessQuesResponseList = [];
        var compId = component.get("v.qCAccessComponentId");
        var operation = '';
        var observatnList =[];
        var finalverdict = [];
        //alert('-----isQcResponseSaved-------'+component.get("v.isQcResponseSaved"));
        if(component.get("v.isQcResponseSaved") == true){
            operation = 'update';
            var compResId= component.get("v.qCAccessComponentId");
            
        }else{
            operation = 'insert';
        }
        
        
        for(var j=0;j<tData.length;j++){
            observatnList.push(tData[j].testParamObservation);
            finalverdict.push(tData[j].testParamVerdict);
            var QcAccTestResp={'sobjectType' : 'QC_Access_QuesResponse__c',
                               'QC_Access_Component__c' : component.get("v.qCAccessComponentId"),
                               'Observation__c': tData[j].testParamObservation,
                               'QC_Access_Questions__c' : tData[j].testQuestId,
                               'Verdict__c' : tData[j].testParamVerdict,
                               'RecordTypeId' :'0121O000001ZXkC'};
            QcAccessQuesResponseList.push(QcAccTestResp);
        }

        for(var i = 0; i< multiSelectList.length; i++){
            if(multiSelectList[i].responseIds.length > 0){
                var QcAccessQuesResponse = { 'sobjectType': 'QC_Access_QuesResponse__c',
                           'QC_Access_Component__c': component.get("v.qCAccessComponentId"),
                           'QC_Access_Questions__c': multiSelectList[i].questId,
                           'Multiple_QuesResponseId__c':multiSelectList[i].responseIds.join(),
                           'Response_Values__c':multiSelectList[i].selectedOptions.join(),
                                            'RecordTypeId': '0121O000001ZXkB' 
                                            
                       };
                QcAccessQuesResponseList.push(QcAccessQuesResponse);
            }
        }
        
        var RowItemList = component.get("v.testParameterList");
        //alert(':::component.get("v.testParameterList"):: '+component.get("v.testParameterList"));
		if(RowItemList.length >0){
        var paramAddList =[];
        for(var i = 0; i< RowItemList.length; i++){
                var addedRow={'sobjectType' : 'QC_Access_Questions__c',
                                   'Test_Name__c': RowItemList[i].testNameForDisplay,
                                   'Product_Specification__c': RowItemList[i].testParamProdSpec,
                                   'Acceptance_Criteria__c': RowItemList[i].testParamAccep,
                              	   'Temp_Observation__c': RowItemList[i].testParamObservation,
                                   'Temp_Verdict__c' : RowItemList[i].testParamVerdict,
                                   'RecordTypeId' :'0121O000001ZXkE'};
          paramAddList.push(addedRow); 
        }
        var actionRowItemList = component.get("c.saveAddTestParam");
        	actionRowItemList.setParams({"addTestRowList" : paramAddList
                                          
            });
       
           actionRowItemList.setCallback(this,function(response){
                debugger;
                var state=response.getState();
                if(state=="SUCCESS"){
                   var result=response.getReturnValue();
                   // alert('--result--'+result);
                   //component.set("v.addRowItemList",result); 
                   
				   var addTestRowList = result;
					for(var i = 0; i< addTestRowList.length; i++){
							observatnList.push(addTestRowList[i].Temp_Observation__c);
                        	finalverdict.push(addTestRowList[i].Temp_Verdict__c);
							var addedRow={'sobjectType' : 'QC_Access_QuesResponse__c',
											   'QC_Access_Component__c' : component.get("v.qCAccessComponentId"),
											   'Observation__c': addTestRowList[i].Temp_Observation__c,
											   'QC_Access_Questions__c' : addTestRowList[i].Id,
											   'Verdict__c' : addTestRowList[i].Temp_Verdict__c,
											   'RecordTypeId' :'0121O000001ZXkC'};
							QcAccessQuesResponseList.push(addedRow);
			 
							
						}
					
						 var action = component.get("c.saveAccInpRespData");
						action.setParams({"qaqrList" : JSON.stringify(QcAccessQuesResponseList), "operation" :operation
						});
				   
						
					   action.setCallback(this,function(response){
							debugger;
							var state=response.getState();
							if(state=="SUCCESS"){
								debugger;
							   var result=response.getReturnValue();
                                
                        component.set("v.isQcResponseSaved",true); 
                    
								
								
							}
						 });
				   
						 $A.enqueueAction(action); 
                }
             });
       
             $A.enqueueAction(actionRowItemList);
		}//if ends for new test row added using + button
        else{
            var action = component.get("c.saveAccInpRespData");
        action.setParams({"qaqrList" : JSON.stringify(QcAccessQuesResponseList),
                          "operation":operation
        }); 
        
       action.setCallback(this,function(response){
            debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
               var result=response.getReturnValue();
                var verdictCount = finalverdict.length;
                if(finalverdict.length > 0 && !finalverdict.includes('None')){
                        component.set("v.isQcResponseSaved",false);
                    }
                    else{
                        component.set("v.isQcResponseSaved",true); 
                    }
								
                

            }
         });
         $A.enqueueAction(action);
        }
       
                
        
    },
    passMultiPickListValues :function(component, event, helper) {
    
       
        var appEvent = $A.get("e.c:PassConstrPickListValuesToReliabEvnt");
		appEvent.setParams({
            "multiSelectPckValues" : component.get("v.multiSelectList")
        });
        appEvent.fire(); 
     },
    
    validateInput : function(component, event, helper) {
        var sampleType = component.get("v.subChildSampleType");
        //alert('--------sampleType--------'+sampleType);
        if(sampleType =='New' || sampleType == 'Alternate Development' || sampleType == 'Re-Certification' || sampleType == 'Competitor Products'){
        var testData =component.get("v.testParamListReliabConst");
        var error = false;
        for(var t =0; t < testData.length; t ++ ){
            if((testData[t].testParamObservation == undefined || testData[t].testParamObservation == '') && testData[t].testParamVerdict != 'None'){
                error = true;
                break;
            }
        }
        }
        if(component.get("v.subChildSampleType") =='Re-Submission'){
            var testData =component.get("v.testParamListReliabConst");
            var error = false;
            for(var t =0; t < testData.length; t ++ ){
                if((testData[t].testParamObservation == undefined || testData[t].testParamObservation == '') && testData[t].testParamVerdict != 'None'){
                    error = true;
                    break;
                }
            }   
        }
        
            // fire an event to parent component with error  = true. Parent component will not proceed to save
        	var observEvntValue=component.getEvent("ObservatnDataEvnt");
        	observEvntValue.setParams({"isError" : error});
        	observEvntValue.fire();
           
    },
    addRow: function(component, event, helper) {
       helper.createObjectData(component, event);
    },
    removeDeletedRow: function(component, event, helper) {
       var lastIndex=event.currentTarget.id;
        var removeRaw = component.get("v.testParameterList");
        var updatedata=[];
        delete removeRaw[lastIndex];
        for(var dat in removeRaw){
            if(dat!=undefined)
                updatedata.push(removeRaw[dat]);
        }
        component.set("v.testParameterList", updatedata);
    },
    
      
})