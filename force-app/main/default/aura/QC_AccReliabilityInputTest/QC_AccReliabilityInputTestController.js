({
	doInit : function(component, event, helper) {
        var cate=component.get("v.cat");
        var multiSelectList = component.get("v.multiSelectList");
        
        if(cate != undefined && cate != null && cate != ''){
            helper.showInput(component, event, helper);
            
        }
	},
    reInit : function(component, event, helper) {
        var cate=component.get("v.cat");
        if(cate != undefined && cate != null && cate != ''){
            helper.showInput(component, event, helper);
            
        }
    },
    validateInput : function(component, event, helper) {
        var sampleType = component.get("v.childSampleType");
        var multiSelectResponses = component.get("v.multiSelectList");
        var isInputResponse = false;
        for(var i=0; i < multiSelectResponses.length; i++){
            if(multiSelectResponses[i].responseIds == '' || multiSelectResponses[i].responseIds == undefined){
                isInputResponse = true;
            }
        }
        if(sampleType =='New' || sampleType == 'Alternate Development' || sampleType == 'Re-Certification' || sampleType == 'Competitor Products'){
            var testData =component.get("v.testData");
            var error = false;
            if(testData.length!=undefined && testData.length>0){
                for(var t =0; t < testData.length; t ++ ){
                    if(((testData[t].observation == undefined || testData[t].observation == '') && testData[t].finalVerdict != 'None') || (isInputResponse == true)){
                        error = true;
                        break;
                    }
            	}
            }else {
                
              /*  var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'Please select proper main material!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire(); */
                if(isInputResponse == true){
                    error = true;
                }
                
            }
            
        }
        if(sampleType =='Re-Submission'){
            var testData =component.get("v.testParamListReSub");
            var error = false;
            if(multiSelectResponses[0].responseIds == ''){
                error = true;
            }
            for(var t =0; t < testData.length; t ++ ){
                if(((testData[t].testParamObservation == undefined || testData[t].testParamObservation == '') && testData[t].testParamVerdict != 'None') || ( isInputResponse == true)){
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

    setMultipickValFromConstTab : function(component, event, helper) {
        var cate=component.get("v.cat");
        var constrInpPickList =event.getParam("multiSelectPckValues");
       // alert('==--Passed value from event for Constr Input Param---->>'+constrInpPickList);
        component.set("v.constrInpPickList",constrInpPickList);
    },

    handleSelectChangeEvent: function(component, event, helper) {
   		var selectedItems = event.getParam("values");
        var picklistId = event.getParam("picklistId");
        var questionId = event.getParam("questionId");
        var responseIds = event.getParam("responseIds");
        var picklistLabel = event.getParam("picklistLabel");
        var tData = component.get("v.testData");
        if(picklistLabel == 'Main Material'){
            var multiSelectList = component.get("v.multiSelectList");
            for(var i = 0; i < multiSelectList.length; i++){
                if(i == picklistId){
                    multiSelectList[i].questId = questionId;
                    multiSelectList[i].selectedOptions = selectedItems;
                    multiSelectList[i].responseIds = responseIds;
                }
            }
            var questRespIds = questionId+'_'+responseIds.join();
            component.set("v.multiSelectList",multiSelectList);
            
            //validate
            var constrInpPickList = component.get("v.constrInpPickList");
            var mismatch = 'no';
            for(var j = 0; j< multiSelectList.length; j++){
                if(multiSelectList[j].label == 'Main Material'){
                    //alert('response value = '+constrInpPickList[i].selectedOptions.join()+' response Id= '+constrInpPickList[i].responseIds.join());
                    for(var i = 0; i< constrInpPickList.length; i++){
                        if(constrInpPickList[i].label == 'Main Material'){
                            //alert('length'+multiSelectList[j].responseIds.length);
                            //alert('length'+constrInpPickList[i].responseIds.length);
                            if(multiSelectList[j].responseIds.length != constrInpPickList[i].responseIds.length){
                                mismatch = 'yes';
                                break;
                            }
                            for(var k = 0; k < multiSelectList[j].responseIds.length; k++){
                                if(!constrInpPickList[i].responseIds.includes(multiSelectList[j].responseIds[k])){
                                   mismatch = 'yes';
                                   break; 
                                }
                            }
                            //alert('response value = '+constrInpPickList[i].selectedOptions.join()+' response Id= '+constrInpPickList[i].responseIds.join());
                        }
                    }
                    
                }
            }
            if(mismatch == 'no'){
                helper.callShowTest(component, event, helper,questRespIds);  
            }else{
               // alert('main material does not match');
                component.set("v.testData",null);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'Main Material value is not matching',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
            
            
        }else{
            var multiSelectList = component.get("v.multiSelectList");
            for(var i = 0; i < multiSelectList.length; i++){
                if(i == picklistId){
                    multiSelectList[i].questId = questionId;
                    multiSelectList[i].selectedOptions = selectedItems;
                    multiSelectList[i].responseIds = responseIds;
                }
            }
            var questRespIds = questionId+'_'+responseIds.join();
            component.set("v.multiSelectList",multiSelectList);
        }
        
        
          
	},
    saveAccInputData :function(component, event, helper) {
        var tData=component.get("v.testData");
        var sampleType = component.get("v.childSampleType" );
        var resubTestData = component.get("v.testParamListReSub");
        debugger;
        //alert('Need to inplement Acc Input data save functionality');
        component.set("v.isReadonly",true);
        var multiSelectList = component.get("v.multiSelectList");
        var QcAccessQuesResponseList = [];
        var observatnList =[];
        var operation = '';
        var finalverdict= [];
        
        if(component.get("v.isQcResponseSaved") == true){
            operation = 'update';
            var compResId= component.get("v.qCAccessComponentId");
            
        }
        else{
            operation = 'insert';
            
        }
        if(sampleType == 'New' || sampleType == 'Alternate Development' || sampleType == 'Re-Certification' || sampleType == 'Competitor Products'){
            for(var j=0;j<tData.length;j++){
                observatnList.push(tData[j].observation);
                finalverdict.push(tData[j].finalVerdict);
                var QcAccTestResp={'sobjectType' : 'QC_Access_QuesResponse__c',
                                   'QC_Access_Component__c' : component.get("v.qCAccessComponentId"),
                                   'Observation__c': tData[j].observation,
                                   'QC_Access_Questions__c' : tData[j].testQuestId,
                                   'Verdict__c' : tData[j].finalVerdict,
                                   'Remarks__c' : tData[j].remarks,
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
        }
        
        if(sampleType == 'Re-Submission'){
            component.set("v.isResubVedict",false);
            for(var j=0;j<resubTestData.length;j++){
               	observatnList.push(resubTestData[j].testParamObservation);
                finalverdict.push(resubTestData[j].testParamVerdict);
                var QcAccTestResp={'sobjectType' : 'QC_Access_QuesResponse__c',
                                   'QC_Access_Component__c' : component.get("v.qCAccessComponentId"),
                                   'Observation__c': resubTestData[j].testParamObservation,
                                   'QC_Access_Questions__c' : resubTestData[j].testQuestId,
                                   'Verdict__c' : resubTestData[j].testParamVerdict,
                                   'Remarks__c' : resubTestData[j].remarks,
                                   'RecordTypeId' :'0121O000001ZXkC'};
                QcAccessQuesResponseList.push(QcAccTestResp);
                //console.log('observation::>>'+QcAccessQuesResponseList[j].Observation__c);   
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
        }
        var RowItemList = component.get("v.testParameterList");
        //alert(':::component.get("v.testParameterList"):: '+component.get("v.testParameterList"));
		if(RowItemList.length >0){
        var paramAddList =[];
        for(var i = 0; i< RowItemList.length; i++){
                var addedRow={'sobjectType' : 'QC_Access_Questions__c',
                                   'Test_Name__c': RowItemList[i].testNameForDisplay,
                                   'Product_Specification__c': RowItemList[i].productSpec,
                                   'Acceptance_Criteria__c': RowItemList[i].acceptanceCriteria,
                              	   'Temp_Observation__c': RowItemList[i].observation,
                                   'Temp_Verdict__c' : RowItemList[i].finalVerdict,
                                   'Temp_Remarks__c' : RowItemList[i].remarks,
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
					
						 var action = component.get("c.saveReliabInpRespData");
						action.setParams({"qaqrList" : JSON.stringify(QcAccessQuesResponseList), "operation" :operation
						});
				   
						
					   action.setCallback(this,function(response){
							debugger;
							var state=response.getState();
							if(state=="SUCCESS"){
								debugger;
							   var result=response.getReturnValue();
                                component.set("v.isQcResponseSaved",true);
                              /*   if(finalverdict.length > 0 && !finalverdict.includes('None')){
                        component.set("v.isQcResponseSaved",false);
                    }
                    else{
                        component.set("v.isQcResponseSaved",true); 
                    }*/
								
								
							}
						 });
				   
						 $A.enqueueAction(action); 
                }
             });
       
             $A.enqueueAction(actionRowItemList);
		}//if ends for new test row added using + button
        else{
           var action = component.get("c.saveReliabInpRespData");
            action.setParams({"qaqrList" : JSON.stringify(QcAccessQuesResponseList), "operation" :operation
            });
            
           action.setCallback(this,function(response){
                debugger;
                var state=response.getState();
                if(state=="SUCCESS"){
                   var result=response.getReturnValue();
                    component.set("v.isQcResponseSaved",true); 
                    /*if(finalverdict.length > 0 && !finalverdict.includes('None')){
                            component.set("v.isQcResponseSaved",false);
                        }
                        else{
                            component.set("v.isQcResponseSaved",true); 
                        }*/
                        
                    }
             });
             $A.enqueueAction(action);        
        }
    },
    
    resubmitEditModeOn :function(component, event, helper) {
        var sampleType = component.get("v.childSampleType" );
        if(sampleType =='Re-Submission'){
          component.set("v.isResubVedict",true);  
        } 
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