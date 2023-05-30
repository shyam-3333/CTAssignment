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
        alert('-----isQcResponseSaved-------'+component.get("v.isQcResponseSaved"));
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
       
        var action = component.get("c.saveAccInpRespData");
        action.setParams({"qaqrList" : JSON.stringify(QcAccessQuesResponseList),
                          "operation":operation
        }); 
        
       action.setCallback(this,function(response){
            debugger;
            var state=response.getState();
            if(state=="SUCCESS"){
               var result=response.getReturnValue();
               component.set("v.isQcResponseSaved",true); 

            }
         });
         $A.enqueueAction(action);        
        
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
        var multiSelectResponses = component.get("v.multiSelectList");
        if(sampleType =='New' || sampleType == 'Alternate Development' || sampleType == 'Re-Certification' || sampleType == 'Competitor Products'){
        var testData =component.get("v.testParamListReliabConst");
        var error = false;
        for(var t =0; t < testData.length; t ++ ){
            if(((testData[t].testParamObservation == undefined || testData[t].testParamObservation == '') && testData[t].testParamVerdict != 'None') || (multiSelectResponses[0].responseIds == '')) {
                error = true;
                break;
            }
        }
        }
        if(component.get("v.subChildSampleType") =='Re-Submission'){
            var testData =component.get("v.testParamListReSub");
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
      
})