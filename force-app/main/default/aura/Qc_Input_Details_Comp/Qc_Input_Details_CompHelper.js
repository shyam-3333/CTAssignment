({
   /* fetchDependetPicklistHelper : function( component, event, helper ) {
		
        var action = component.get("c.fetchDependentPicklist");
        action.setParams({
            objectDetails : JSON.stringify(component.get('v.qcComponent')) , 
			controllingField  :  'Brands__c' ,
			dependentField : 'Cluster__c' ,
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var result = response.getReturnValue() ;
                if( result != undefined && result != null )
                {
                    var res = JSON.parse(result);
					var objKeys = Object.keys(res);
					var brands = objKeys.map((item)=>{ return {'label': item   , 'value': item }; });
                    component.set('v.BrandsList', brands );
					component.set('v.dependentPickList',res);
                    helper.dependentClusterAddition( component, event , component.get("v.qcComponent.Brands__c") );
                }
            }else{
				let errorResult = (response.getError()).map((item,index)=>{
				return item.message;
				});	
				alert(JSON.stringify(errorResult));
			}
        });

        $A.enqueueAction(action);
	},

    fetchPickListValues : function( component, event, helper) {
        
        var picklistMap = [{"objectName": "QC_Components__c","picklistFieldName":"Final_Verdict__c","attributeName":"finalVerdictList"},
                           {"objectName":"QC_Components__c","picklistFieldName":"Sample_Department__c","attributeName":"sampleDepartmentList"},
                           {"objectName": "QC_Test_Data__c","picklistFieldName":"Conclusion__c","attributeName":"tetConclusionList"},
                          ];

        var action = component.get("c.getPickListValue");
        action.setParams({
            picklistMap : JSON.stringify( picklistMap ) 
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var result = response.getReturnValue() ;
                if( result != undefined && result != null )
                {
                    var res = JSON.parse(result);
                    var pickarr = [] ;
                    for(var i = 0 ; i < res.length ; i++ )
                    {
                        for (var j = 0; j < res[i].picklistValues.length ; j++ ) {
                            pickarr.push({"label": res[i].picklistValues[j] , "value": res[i].picklistValues[j] });
                        }
                        component.set("v."+ res[i].attributeName ,pickarr);
                        pickarr = [];
                    }
                }
                
            }
        });

        $A.enqueueAction(action);
    },

    fetchMVNamehelper : function( component , event, masterVarient )
    {
        var action = component.get( "c.getMasterVarient" );
        action.setParams({
            "mvId" : masterVarient
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var result = response.getReturnValue();
                component.set( "v.masterVarient" , result );
            }
        });
        $A.enqueueAction(action);
    },

    fetchInputDatahelper : function( component, event, helper ) {

        var qcComp = component.get( "v.qcComponent" );
        var action = component.get( "c.fetchInputData" );
        action.setParams({
            "qcCompId" : qcComp.Id 
        });
        action.setCallback( this, function( response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var QcMasterMList = component.get("v.QcMasterMList");
                var QcQuestionMList = component.get("v.QcQuestionMList");
                var QcResponseMList = component.get("v.QcResponseMList");
                var QcConditionMList = component.get("v.QcConditionMList");


                var result = JSON.parse(response.getReturnValue());
                var inputParamList =[];
                for( var i=0 ; i< result.length  ; i++)
                {
                    var inputParam = {question: result[i],picklist:[] };
                    var qcResponseList = QcResponseMList.filter( e=> e.Question__c == result[i].Question__c);
                    
                    if( qcResponseList.length != 0 ){
                        var x=[];
                        var picklistJson = qcResponseList.reduce(function (first,str,i) {
                        if( i == 1)
                            x.push({"label": first.Response__c , 'value': first.Response__c } );
                        x.push({"label": str.Response__c , 'value': str.Response__c} );
                        if( qcResponseList.length >= i)
                            return x ;
                        });
                        inputParam.picklist = picklistJson ;
                    }
                    inputParamList.push( inputParam );
                }
                inputParamList.sort((a,b)=>{ return a.question.Question__r.Order_Number__c - b.question.Question__r.Order_Number__c });
                component.set( "v.inputParamList",JSON.parse(JSON.stringify( inputParamList )));
                component.set( "v.inputParamResetList",JSON.parse(JSON.stringify( inputParamList )));

                var qcComponent = component.get('v.qcComponent');
                if( qcComponent.Sample_Category__c == 'Re-submission' )
                {
                    if( qcComponent.Name__c != undefined && qcComponent.Name__c != 'Module' && qcComponent.Name__c != 'Battery' )
                    {
                        helper.getTestFindingHelper( component,event , qcComponent );
                    }
                    else if(qcComponent.Name__c == 'Module'){
                        helper.getModuleTestFindingHelper( component,event , qcComponent );
                    }
                    else if(qcComponent.Name__c == 'Battery'){
                        helper.getBatteryTestFindingHelper( component,event , qcComponent );
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },

    fetchTestDataHelper : function( component, event, helper ) {
        var qcComp = component.get( "v.qcComponent" );
        var action = component.get( "c.fetchTestDatainResubission" );
        action.setParams({
            "qcCompId" : qcComp.Parent__c 
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' )
            {
                var result = response.getReturnValue();
            }
        });
        $A.enqueueAction(action);

    },
    saveInputParamHelper : function( component, event, saveInputParamList ,helper) {

        let saveInputParamFinalList = JSON.parse(JSON.stringify(saveInputParamList));
        saveInputParamFinalList = saveInputParamFinalList.map((item)=> { delete item.Question__r; return item; });
        var action = component.get( "c.saveInputParamMethod" );
        action.setParams({
            "inputParamList" : JSON.stringify({ inputDataList : saveInputParamFinalList})
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var QcMasterMList = component.get("v.QcMasterMList");
                var QcQuestionMList = component.get("v.QcQuestionMList");
                var QcResponseMList = component.get("v.QcResponseMList");
                var QcConditionMList = component.get("v.QcConditionMList");


                var result = JSON.parse(JSON.stringify( saveInputParamList ))
                var inputParamList =[];
                for( var i=0 ; i< result.length  ; i++)
                {
                    var inputParam = {question: result[i],picklist:[] };
                    var qcResponseList = QcResponseMList.filter( e=> e.Question__c == result[i].Question__c);
                    
                    if( qcResponseList.length != 0 ){
                        var x=[];
                        var picklistJson = qcResponseList.reduce(function (first,str,i) {
                        if( i == 1)
                            x.push({"label": first.Response__c , 'value': first.Response__c } );
                        x.push({"label": str.Response__c , 'value': str.Response__c} );
                        if( qcResponseList.length >= i)
                            return x ;
                        });
                        inputParam.picklist = picklistJson ;
                    }
                    inputParamList.push( inputParam );
                }
                
                component.set( "v.inputParamList",JSON.parse(JSON.stringify( inputParamList )));
                component.set( "v.inputParamResetList",JSON.parse(JSON.stringify( inputParamList )));
                helper.toastMessageHelper( component , event , helper , 'SUCCESS' , 'Input Data is Saved ', '3000', 'info_alt', 'SUCCESS' , 'dismissible');

                component.set( "v.isInputParamEdit" , true );

                var editInputParam = component.find('editInputParam');
                $A.util.removeClass( editInputParam , "slds-hide" );
                $A.util.addClass( editInputParam , "slds-show" );

                var saveInputParam = component.find('saveInputParam');
                $A.util.removeClass( saveInputParam , "slds-show" );
                $A.util.addClass( saveInputParam , "slds-hide" );
            }
        });
        $A.enqueueAction(action);
    },


    dependentClusterAddition : function(  component, event , BrandName ){
		var dependentPickList = component.get("v.dependentPickList");
		if( dependentPickList[BrandName] != undefined )
		{
			var clusterList = JSON.parse(JSON.stringify( dependentPickList[BrandName] )); 
			var formattedCluster = clusterList.map((item)=>{ return {'label': item   , 'value': item }; });
			component.set('v.ClusterList',formattedCluster);
		}
		
	},


    saveChildQcCompRecordHelper : function( component, event, qcCompInfoListStr ,helper ) {
        var action = component.get( "c.saveChildQcCompMethod" );
        action.setParams({
            "qcCompInfoListStr" : JSON.stringify({ qcCompList : qcCompInfoListStr})
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS' )
            {
                var result = response.getReturnValue();
                var recArray = [];
                for(var i = 0 ; i < qcCompInfoListStr.length ;i++)
                {
                    recArray.push(  qcCompInfoListStr[i]   );
                }
                helper.toastMessageHelper( component , event , helper , 'SUCCESS' , 'Qc Component is saved ', '3000', 'info_alt', 'SUCCESS' , 'dismissible');
                var evt = component.getEvent("sendAllQcCompRecord");
                evt.setParams({
                    "allQcRecList" : recArray  ,
                    });
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
    },

    submitForApprovalProcess: function (component, event, helper) {
        console.log('qcComponent'+component.get("v.qcComponent.Id"));
        var action = component.get("c.submitForAppProcess");
        action.setParams({
            'RecId': component.get("v.qcComponent.Id")
        });
        
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                debugger;
                var approvalProcessResponse = response.getReturnValue();
                component.set("v.approvalList", response.getReturnValue());
                helper.checkRecorIsLoak(component,event,helper);
                var QcChildCompList = component.get( 'v.allQcCompList' ).filter( e => e.Parent__c != null );
                console.log('QcChildCompList::'+QcChildCompList);
                var qcPComp = component.get('v.qcComponent');
                qcPComp.Document_Status__c = 'Submitted for Approval';
                var recArray = [];
                recArray.push( qcPComp  );
                for(var i = 0 ; i < QcChildCompList.length ;i++)
                {
                    QcChildCompList[i].Document_Status__c = 'Submitted for Approval';
                    recArray.push(  QcChildCompList[i]   );
                }
                helper.toastMessageHelper( component , event , helper , 'SUCCESS' , 'Submitted For Approval ', '3000', 'info_alt', 'SUCCESS' , 'dismissible');
                var evt = component.getEvent("sendAllQcCompRecord");
                evt.setParams({
                    "allQcRecList" : recArray  ,
                    });
                evt.fire();
                
            }
            
        });
        $A.enqueueAction(action);
    },

    checkRecorIsLoak : function(component,event,helper){
        var action=component.get('c.isRecordSubmitForApproval');
        action.setParams({
            'recordId': component.get('v.qcComponent.Id')
        });
        action.setCallback(this,(response)=>{
            if(response.getState()==="SUCCESS"){
                let result= response.getReturnValue();
                component.set('v.isRecordLock',result);
            }
        });
        $A.enqueueAction(action); 
    },

    getTestFindingHelper : function( component,event , qcComp ){
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        const QcResponseMList = component.get("v.QcResponseMList");
        if( qcComp.Name__c != '' )
        {
            let action = component.get("c.fetchRejectedTest");
            action.setParams({
                "rec" : JSON.stringify(qcComp) 
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if( state === 'SUCCESS')
                {
                    var result = JSON.parse(response.getReturnValue());
                    component.set( 'v.qcTestList' , result );
                }else{
                    let errorResult = (response.getError()).map((item,index)=>{
                    return item.message;
                    });
                    helper.toastMessageHelper( component , event , helper , 'ERROR' , JSON.stringify(errorResult), '3000', 'info_alt', 'ERROR' , 'dismissible');
                }
            });
            $A.enqueueAction(action);
        }
    },
        
    getModuleTestFindingHelper : function( component,event , qcComp ){
            
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        var inputParamList = component.get("v.inputParamList");
        if( qcComp.Name__c != '' )
        {
            let action = component.get("c.fetchRejectedTest");
            action.setParams({
                "rec" : JSON.stringify(qcComp)  
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if( state === 'SUCCESS')
                {
                    var result = JSON.parse(response.getReturnValue());
                    var typeOfModule = inputParamList.filter( e => e.question.Question_Name__c == 'Type of Module')[0];
                    var qcTestDatalist = result.map( (qcTest,index)=>{
                    qcTest.condition = QcConditionMList.filter( e => e.Id == qcTest.Condition_Ref__c)[0];
                    if(index != 0 && qcTest.Test_Name__c == result[index-1].Test_Name__c ){
                        qcTest.rowSpan = true ;
                    }else{
                        qcTest.rowSpan = false ;
                    }
                    return qcTest;
                });
                component.set( 'v.typeOfModule', typeOfModule.question.Value__c  );
                component.set( 'v.qcTestList' , qcTestDatalist );
                
                }else{
                    let errorResult = (response.getError()).map((item,index)=>{
                    return item.message;
                    });
                    helper.toastMessageHelper( component , event , helper , 'ERROR' , JSON.stringify(errorResult), '3000', 'info_alt', 'ERROR' , 'dismissible');
                }
            });
            $A.enqueueAction(action);
            
        }
    },

    getBatteryTestFindingHelper : function( component,event , qcComp ){
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        if( qcComp.Name__c != '' )
        {
            let action = component.get("c.fetchRejectedTest");
            action.setParams({
                "rec" : JSON.stringify(qcComp) 
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if( state === 'SUCCESS')
                {
                    var result = JSON.parse(response.getReturnValue());
                    var qcTestDatalist = result.map( (qcTest,index)=>{
                        if(index != 0 && qcTest.Test_Name__c == result[index-1].Test_Name__c ){
                            qcTest.rowSpan = true ;
                        }else{
                            qcTest.rowSpan = false ;
                        }
                        return qcTest;
                    });
                    var viTest = qcTestDatalist.filter( e => e.Test_Name__c == 'Visual Inspection');
                    var capacityTest = qcTestDatalist.filter( e => e.Acceptance_Criteria__c != 'Leakage Test' && e.Test_Name__c != 'Visual Inspection' );
                    var leakageTest = qcTestDatalist.filter( e => e.Acceptance_Criteria__c == 'Leakage Test');
                    var batteryTests = {viTests : viTest, 
                                        capacityTests : capacityTest ,
                                        leakageTests : leakageTest };
                    component.set( 'v.batteryTests' , batteryTests );
                }else{
                    let errorResult = (response.getError()).map((item,index)=>{
                    return item.message;
                    });
                    helper.toastMessageHelper( component , event , helper , 'ERROR' , JSON.stringify(errorResult), '3000', 'info_alt', 'ERROR' , 'dismissible');
                }
            });
            $A.enqueueAction(action);
            
        }
    },

    // isAllChildInputMandatoryisFilled : function( component , event ,helper )
    // {
    //     var allQcCompList = component.get("v.allQcCompList");
    //     var allChildQcCompIdList = allQcCompList.map( e => { if(e.Parent__c != undefined ) return e.Id }).filter( e => e != undefined);
    //     var action = component.get("c.fetchAllChildCompInputParam");
    //     action.setParams({
    //         allQcCompIdList : allChildQcCompIdList
    //     });

    //     action.setCallback( this ,function(response){
    //         var state = response.getState();
    //         if( state === 'SUCCESS')
    //         {
    //             var QcResponseMList = component.get("v.QcResponseMList");
    //             var allQcCompList = component.get("v.allQcCompList");
    //             var allChildQcCompIdList = allQcCompList.map( e => { if(e.Parent__c != undefined ) return e.Id }).filter( e => e != undefined);

    //             var result = JSON.parse(response.getReturnValue());
    //             let isValueNotMissing = true;
    //             for(let i=0 ; i< allChildQcCompIdList.length ; i++ )
    //             {
    //                 let inputParamList = JSON.parse(result[ allChildQcCompIdList[i] ]);
    //                 isValueNotMissing  = (inputParamList.filter(e => e.Question__r.Response_Required__c ).length == 0 || inputParamList.some(e => e.Question__r.Response_Required__c && (e.Value__c != 'None' && e.Value__c != '' && e.Value__c != undefined)  ))
    //             }
    //             debugger;
    //             return isValueNotMissing;

    //         }
    //     });
    //     $A.enqueueAction(action);
    // },

    toastMessageHelper : function( component , event , helper , title , message, duration, key, type , mode)
    {
        var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : title,
                    message: message,
                    duration: duration,
                    key: key,
                    type: type,
                    mode: mode
                });
                toastEvent.fire();
    },*/
})