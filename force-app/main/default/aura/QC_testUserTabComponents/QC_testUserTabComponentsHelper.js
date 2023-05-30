({
	/* fetchDependetPicklistHelper : function( component, event, helper ) {
		
        var action = component.get("c.fetchDependentPicklist");
        action.setParams({
            objectDetails : JSON.stringify(component.get('v.QcRecord')) , 
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
                    helper.dependentClusterAddition( component, event , component.get("v.QcRecord.Brands__c") );
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
                           {"objectName": "QC_Test_Data__c","picklistFieldName":"Conclusion__c","attributeName":"tetConclusionList"},
                           {"objectName":"QC_Components__c","picklistFieldName":"Sample_Department__c","attributeName":"sampleDepartmentList"}
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

        var qcComp = component.get( "v.QcRecord" );
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
                    console.log('qcResponseList::::::::::::::::',qcResponseList);
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

                var testGenarated = component.get("v.QcRecord.Test_generated__c");
                 var iscompiedFromMaster = component.get("v.QcRecord.IsCopied_From_Master__c");
                if(testGenarated != undefined && testGenarated || iscompiedFromMaster  )
                {
                    component.find("genTest").set("v.value",true);
                    
                    var testFindings = component.find("testFindings");
                    $A.util.removeClass( testFindings , 'slds-hide' );
                    $A.util.addClass( testFindings , 'slds-show' );
                    var qcComponent = component.get('v.QcRecord');
                    if( qcComponent.Name__c != undefined && qcComponent.Name__c != 'Module' && qcComponent.Name__c != 'Battery' )
                    {
                        helper.getTestFindingHelper( component,event ,helper, qcComponent );
                    }
                    else if(qcComponent.Name__c == 'Module'){
                        helper.getModuleTestFindingHelper( component,event , helper,qcComponent );
                    }
                    else if(qcComponent.Name__c == 'Battery'){
                        helper.getBatteryTestFindingHelper( component,event , qcComponent );
                    }
                }else{
                    component.find("genTest").set("v.value",false);
                    component.set("v.genarateTestDisabled", false );
                    component.set("v.qcTestList", [] );

                    var testFindings = component.find("testFindings");
                    $A.util.removeClass( testFindings , 'slds-show' );
                    $A.util.addClass( testFindings , 'slds-hide' );
                }

            }
        });
        $A.enqueueAction(action);
    },

    saveInputParamHelper : function( component, event, saveInputParamList,helper ) {
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
                console.log('result',result);
                var inputParamList =[];
                for( var i=0 ; i< result.length  ; i++)
                {
                    var inputParam = {question: result[i],picklist:[] };
                    console.log('inputParam',inputParam);
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
                alert('Records saved successfully!');
                component.set( "v.isInputParamEdit" , true );
                var editInputParam = component.find('editInputParam');
                $A.util.removeClass( editInputParam , "slds-hide" );
                $A.util.addClass( editInputParam , "slds-show" );
                var saveInputParam = component.find('saveInputParam');
                $A.util.removeClass( saveInputParam , "slds-show" );
                $A.util.addClass( saveInputParam , "slds-hide" );

                if( component.get("v.QcRecord.Test_generated__c"))
                {
                    helper.refreshTestData( component, event ,helper);
                }
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

    saveIndividualQcComp : function( component,event,helper,qcComponent)
    {
        var action = component.get("c.saveIndividualQcComp");
        action.setParams({
            qcComp : JSON.stringify(qcComponent)
        });

        action.setCallback( this , function(response){
            var state = response.getState();
            if(state === 'SUCCESS')
            {
                var allQcComp = component.get("v.allQcCompList");
                allQcComp = allQcComp.map( (item) => {
                    if( item.Id == qcComponent.Id)
                    {
                        return qcComponent;
                    }else{
                        return item;
                    }
                });
                var evt = component.getEvent("sendAllQcCompRecord");
                evt.setParams({
                    "allQcRecList" : allQcComp  
                    });
                evt.fire();
                alert("Qc Component is Saved");
            }else{
                let errorResult = (response.getError()).map((item,index)=>{
                    return item.message;
                    });
                    alert(JSON.stringify(errorResult));
            }
        });
        $A.enqueueAction(action);
    },

	saveChildQcCompRecordHelper : function( component, event, qcCompInfoListStr ) {
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
                var evt = component.getEvent("sendAllQcCompRecord");
                evt.setParams({
                    "allQcRecList" : recArray  
                    });
                evt.fire();
            }else{
				let errorResult = (response.getError()).map((item,index)=>{
				return item.message;
				});
				alert(JSON.stringify(errorResult));
			}
        });
        $A.enqueueAction(action);
    },

    getTestFindingHelper : function( component,event , helper, qcComp ){
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        const QcResponseMList = component.get("v.QcResponseMList");
        if( qcComp.Name__c != '' )
        {
            if( qcComp.Test_generated__c || qcComp.IsCopied_From_Master__c)
            {
                let action = component.get("c.fetchQcTestData");
                action.setParams({
                    "recId" : qcComp.Id 
                });
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if( state === 'SUCCESS')
                    {
                        var result = JSON.parse(response.getReturnValue());
                        
                        if( result.length == 0  && qcComp.IsCopied_From_Master__c)
                        {
                            var testAction = component.get( "c.fetchMatersTest" );
                            testAction.setParams({
                                compName : qcComp.Name__c,
                                recId : qcComp.Master_Variant__c
                            });
                            testAction.setCallback( this ,function( testResponse ){
                                var state = testResponse.getState();
                                if( state === 'SUCCESS' )
                                {
                                    var testResult = JSON.parse( testResponse.getReturnValue() );
                                    if( testResult.length == 0){
                                        alert( 'genatate Test Findings in Master' );
                                    }else{
                                         
                                        component.set( 'v.qcTestList' , result );
                                        component.set ( "v.genarateTestDisabled" , true);
                                    }
                                }
                            });
                            $A.enqueueAction( testAction );
                        }else{
                            component.set( 'v.qcTestList' , JSON.parse(JSON.stringify( result )) );
                            component.set( 'v.qcTestResetList' , JSON.parse(JSON.stringify( result )) );
                            component.set ( "v.genarateTestDisabled" , true);
                        }
                        
                        
                    }else{
                        let errorResult = (response.getError()).map((item,index)=>{
                        return item.message;
                        });
                        alert(JSON.stringify(errorResult));
                    }
                });
                $A.enqueueAction(action);
            }else{
                    var isCompitator = (qcComp.Sample_Category__c == 'Competitor Products') ? true : false ;
                    var brandCondtionlist = [];
                    brandCondtionlist = QcConditionMList.filter( e => e.Brand__c == qcComp.Brand__c && e.Component_Type__c == qcComp.Name__c && e.RecordType.Name == 'Test Condition' );
                    var compCondtionlist = [];
                    compCondtionlist = isCompitator ?  QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  (e.Action__c == "Visible"  ||  e.Onload__c == true)  )   : 
                                                        QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  e.Onload__c == true  );
                    var allCondList = compCondtionlist.concat( brandCondtionlist );
                    var inputParamList = component.get('v.inputParamList');
                    if( qcComp.Name__c == 'Special-Strap' )
                    {
                        var genderInputDataSS = inputParamList.filter( e => e.question.Question_Name__c == 'Gender')[0];
                        if(  genderInputDataSS.question.Value__c != 'None' &&  genderInputDataSS.question.Value__c != undefined)
                        {
                            var response = QcResponseMList.filter( e=> e.Component_Type__c == qcComp.Name__c &&  e.Response__c == genderInputDataSS.question.Value__c)[0];
                            var genderCondSS = QcConditionMList.filter(e => e.Response__c == response.Id &&  e.Component_Type__c == qcComp.Name__c  && e.RecordType.Name == 'Test Condition' )[0];
                            allCondList.push(genderCondSS);
                        }
                    }
                    if( qcComp.Name__c == 'Case' )
                    {
                        var pushButton = inputParamList.filter( e => e.question.Question_Name__c == 'Push button')[0];
                        if(pushButton.question.Value__c == 'Yes'){
                            var response = QcResponseMList.filter( e=> e.Component_Type__c == qcComp.Name__c &&  e.Response__c == pushButton.question.Value__c)[0];
                            var pushButtonCondSS = QcConditionMList.filter(e => e.Response__c == response.Id &&  e.Component_Type__c == qcComp.Name__c  && e.RecordType.Name == 'Test Condition' )[0];
                            allCondList.push(pushButtonCondSS);
                        }
                        
                    }
                   class qcTestClass {
                        constructor(){
                            return {
                                sobjectType :'QC_Test_Data__c' ,
                                Condition_Ref__c : '',
                                Test_Name__c : '',
                                Component_Name__c : '',
                                UOM_Input__c : '' ,
                                Specification_Input__c : '',
                                Acceptance_Criteria__c : '' ,
                                Observation__c : '',
                                Comments_and_Remarks__c : '',
                                Conclusion__c : '',
                                Active__c : true,
                            };
                        }
                    }
                    allCondList.sort((a,b)=>{ return b.Onload__c-a.Onload__c});
                    allCondList = allCondList.filter( e=> e != undefined );
                    var qcTestDatalist = allCondList.map( (item)=>{
    
                        var qcQuestion = QcQuestionMList.filter( e => e.Id == item.Question__c )[0];
                        console.log(qcQuestion);
                        var qcTest = new qcTestClass();
                        qcTest.Test_Name__c = qcQuestion.Test_Name__c;
                        qcTest.Component_Name__c = qcComp.Id;
                        qcTest.Condition_Ref__c = item.Id;
                        qcTest.Specification_Input__c = qcQuestion.Specification__c;
                        qcTest.Acceptance_Criteria__c = qcQuestion.Acceptance_Criteria__c;
                        qcTest.UOM_Input__c = qcQuestion.UOM__c ; 
                        return qcTest;
                    });
                    
                    component.set( 'v.qcTestList' , qcTestDatalist );
                    component.set( 'v.qcTestResetList' , JSON.parse(JSON.stringify( qcTestDatalist )) );
                    component.set ( "v.genarateTestDisabled" , true);
            }
        }
    },
        
    getModuleTestFindingHelper : function( component,event ,helper ,qcComp ){
            
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        var inputParamList = component.get("v.inputParamList");
        if( qcComp.Name__c != '' )
        {
            if( qcComp.Test_generated__c || qcComp.IsCopied_From_Master__c )
            {
                let action = component.get("c.fetchQcTestData");
                action.setParams({
                    "recId" : qcComp.Id 
                });
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if( state === 'SUCCESS')
                    {
                        var result = JSON.parse(response.getReturnValue());

                        var typeOfModule = inputParamList.filter( e => e.question.Question_Name__c == 'Type of Module')[0];
                        console.log('typeOfModule',typeOfModule);
                        var qcTestDatalist = result.map( (qcTest,index)=>{
                            qcTest.condition = QcConditionMList.filter( e => e.Id == qcTest.Condition_Ref__c)[0];
                            if(index != 0 && qcTest.Test_Name__c == result[index-1].Test_Name__c ){
                                qcTest.rowSpan = true ;
                            }else{
                                qcTest.rowSpan = false ;
                            }
                            return qcTest;
                        });
                        console.log('Type of model ::::::::::::',typeOfModule.question.Value__c);
                        if(typeOfModule.question.Value__c == 'Anadigi'){
                            typeOfModule.question.Value__c = 'Digital';
                            component.set( 'v.typeOfModule', typeOfModule.question.Value__c  );
                            
                        }else{
                            component.set( 'v.typeOfModule', typeOfModule.question.Value__c  );
                        }
                        component.set( 'v.qcTestList' , JSON.parse(JSON.stringify( qcTestDatalist )) );
                        component.set( 'v.qcTestResetList' , JSON.parse(JSON.stringify( qcTestDatalist )) );
                        component.set ( "v.genarateTestDisabled" , true);
                    }else{
                        let errorResult = (response.getError()).map((item,index)=>{
                        return item.message;
                        });
                        alert(JSON.stringify(errorResult));
                    }
                });
                $A.enqueueAction(action);
            }else{
                
                var isCompitator = (qcComp.Sample_Category__c == 'Competitor Products') ? true : false ;
                var inputParamList = component.get("v.inputParamList");
                var typeOfModule = inputParamList.filter( e => e.question.Question_Name__c == 'Type of Module')[0];
                component.set( 'v.typeOfModule', typeOfModule.question.Value__c );
                if(typeOfModule.question.Value__c == 'Anadigi'){
                    typeOfModule.question.Value__c = 'Digital';
                }
                var brandCondtionlist = [];
                brandCondtionlist = QcConditionMList.filter( e => e.Brand__c == qcComp.Brand__c && e.Component_Type__c == qcComp.Name__c && e.RecordType.Name == 'Test Condition' );
                var compCondtionlist = [];
                compCondtionlist = isCompitator ?  QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  ((typeOfModule.question.Value__c == 'Digital' || typeOfModule.question.Value__c == 'Smart Watch') ? e.Type_of_Module__c == typeOfModule.question.Value__c : e.Type_of_Module__c == undefined))   : 
                                                QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  e.Onload__c == true && ((typeOfModule.question.Value__c == 'Digital' || typeOfModule.question.Value__c == 'Smart Watch') ? e.Type_of_Module__c == typeOfModule.question.Value__c : e.Type_of_Module__c == undefined) );

                // var genaralObservationCond = QcConditionMList.filter( e => e.Question_Name__c == "General Observation" && e.RecordType.Name == 'Test Condition' );
               
                var allCondList = compCondtionlist.concat( brandCondtionlist );
                class qcTestClass {
                    constructor(){
                        return {
                            sobjectType :'QC_Test_Data__c' ,
                            Condition_Ref__c : '',
                            Test_Name__c : '',
                            Component_Name__c : '',
                            UOM_Input__c : '' ,
                            Specification_Input__c : '',
                            Acceptance_Criteria__c : '' ,
                            Initial1__c : '',
                            Initial2__c : '',
                            Initial3__c : '',
                            Initial4__c : '',
                            Initial5__c : '',
                            Initial_Test_Observation__c : '',
                            After_Test1__c : '',
                            After_Test2__c : '',
                            After_Test3__c : '',
                            After_Test4__c : '',
                            After_Test5__c : '',
                            After_Test_Observation__c : '',
                            Observation1__c : '',
                            Observation2__c : '',
                            Observation3__c : '',
                            Observation4__c : '',
                            Observation5__c : '',
                            Parent__c : '',
                            RecordTypeId : '',
                            Observation__c : '',
                            Comments_and_Remarks__c : '',
                            Conclusion__c : '',
                            Active__c : true,
                            condition : '',
                        };
                    }
                }
                allCondList.sort((a,b)=>{ return b.Onload__c-a.Onload__c});
                allCondList = allCondList.filter( e=> e != undefined );
                var qcTestDatalist = allCondList.map( (item,index)=>{

                    var qcQuestion = QcQuestionMList.filter( e => e.Id == item.Question__c )[0];
                    console.log(qcQuestion);
                    var qcTest = new qcTestClass();
                    qcTest.Test_Name__c = qcQuestion.Test_Name__c;
                    qcTest.Component_Name__c = qcComp.Id;
                    qcTest.Condition_Ref__c = item.Id;
                    qcTest.condition = item;
                    qcTest.Specification_Input__c = qcQuestion.Specification__c;
                    qcTest.Acceptance_Criteria__c = qcQuestion.Acceptance_Criteria__c;
                    qcTest.UOM_Input__c = qcQuestion.UOM__c ; 
                    if(index != 0 && qcQuestion.Test_Name__c == allCondList[index-1].Question_Name__c ){
                        qcTest.rowSpan = true ;
                    }else{
                        qcTest.rowSpan = false ;
                        qcTest.Initial1__c = 'R';
                        qcTest.Initial2__c = 'R';
                        qcTest.Initial3__c = 'R';
                        qcTest.Initial4__c = 'R';
                        qcTest.Initial5__c = 'R';
                    }
                    return qcTest;
                });
                
                component.set( 'v.qcTestList' , JSON.parse(JSON.stringify( qcTestDatalist )) );
                component.set( 'v.qcTestResetList' , JSON.parse(JSON.stringify( qcTestDatalist )) );
                component.set ( "v.genarateTestDisabled" , true);
                helper.saveTestHelper(component,event,helper,qcTestDatalist);
            }
        }
    },

    getBatteryTestFindingHelper : function( component,event , qcComp ){
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcConditionMList = component.get("v.QcConditionMList");
        if( qcComp.Name__c != '' )
        {
            if( qcComp.Test_generated__c || qcComp.IsCopied_From_Master__c )
            {
                let action = component.get("c.fetchQcTestData");
                action.setParams({
                    "recId" : qcComp.Id 
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
                        component.set( 'v.batteryTests' , JSON.parse(JSON.stringify( batteryTests )) );
                        component.set( 'v.batteryResetTests' , JSON.parse(JSON.stringify( batteryTests )) );
                        component.set ( "v.genarateTestDisabled" , true);
                    }else{
                        let errorResult = (response.getError()).map((item,index)=>{
                        return item.message;
                        });
                        alert(JSON.stringify(errorResult));
                    }
                });
                $A.enqueueAction(action);
            }else{
                
                    var isCompitator = (qcComp.Sample_Category__c == 'Competitor Products') ? true : false ;
                    var brandCondtionlist = [];
                    brandCondtionlist = QcConditionMList.filter( e => e.Brand__c == qcComp.Brand__c && e.Component_Type__c == qcComp.Name__c && e.RecordType.Name == 'Test Condition' );
                    var compCondtionlist = [];
                    compCondtionlist = isCompitator ?  QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  (e.Action__c == "Visible"  ||  e.Onload__c == true)  )   : 
                                                        QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  e.Onload__c == true  );
                    var allCondList = compCondtionlist.concat( brandCondtionlist );
                   class qcTestClass {
                        constructor(){
                            return {
                                sobjectType :'QC_Test_Data__c' ,
                                Condition_Ref__c : '',
                                Test_Name__c : '',
                                Component_Name__c : '',
                                UOM_Input__c : '' ,
                                Specification_Input__c : '',
                                Acceptance_Criteria__c : '' ,
                                Observation__c : '',
                                Comments_and_Remarks__c : '',
                                Conclusion__c : '',
                                Active__c : true,
                            };
                        }
                    }

                    allCondList.sort((a,b)=>{ return b.Onload__c-a.Onload__c});
                    allCondList = allCondList.filter( e=> e != undefined );
                    var qcTestDatalist = allCondList.map( (item ,index)=>{
    
                        var qcQuestion = QcQuestionMList.filter( e => e.Id == item.Question__c )[0];
                        console.log(qcQuestion);
                        var qcTest = new qcTestClass();
                        qcTest.Test_Name__c = qcQuestion.Test_Name__c;
                        qcTest.Component_Name__c = qcComp.Id;
                        qcTest.Condition_Ref__c = item.Id;
                        qcTest.Specification_Input__c = qcQuestion.Specification__c;
                        qcTest.Acceptance_Criteria__c = qcQuestion.Acceptance_Criteria__c;
                        qcTest.UOM_Input__c = qcQuestion.UOM__c ; 
                        qcTest.Determined_value__c = '';
                        if(index != 0 && qcQuestion.Test_Name__c == allCondList[index-1].Question_Name__c ){
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
                    component.set( 'v.batteryTests' , JSON.parse(JSON.stringify( batteryTests )) );
                    component.set( 'v.batteryResetTests' , JSON.parse(JSON.stringify( batteryTests )) );
                    component.set ( "v.genarateTestDisabled" , true);
            }
        }
    },

    saveTestHelper : function(component,event,helper, saveTestList)
    {
        console.log('saveTestList',saveTestList);
        var qcComp = component.get('v.QcRecord');
        qcComp.Test_generated__c = true;
        component.set( 'v.QcRecord' , JSON.parse(JSON.stringify(qcComp)) );
        component.set( 'v.qcCompResetObj' , JSON.parse(JSON.stringify(qcComp)) );
        
        let action = component.get('c.saveQcTestDataMethod');
        let saveTestFinalList = JSON.parse(JSON.stringify(saveTestList));
        if(qcComp.Name__c == 'Module')
        {
            saveTestFinalList = saveTestFinalList.map((item)=>{
                delete item.rowSpan;
                delete item.condition;
                return item;
            });
        }
        if(qcComp.Name__c == 'Battery')
        {
            component.set( 'v.batteryResetTests' , JSON.parse(JSON.stringify( saveTestList )) );
            saveTestFinalList = saveTestFinalList.map((item)=>{
                delete item.rowSpan;
                return item;
            });
        }
        action.setParams({
            "qcTestListStr" : JSON.stringify({ testList : saveTestFinalList} ),
            "qcCompRec"  : JSON.stringify( qcComp )
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state === 'SUCCESS')
            {
                var result = JSON.parse( response.getReturnValue() );
                var qcComponent = component.get('v.QcRecord');
               
                if( qcComponent.Name__c != undefined && qcComponent.Name__c != 'Module' && qcComponent.Name__c != 'Battery' )
                {
                    helper.getTestFindingHelper( component,event ,helper, qcComponent );
                }
                else if(qcComponent.Name__c == 'Module'){
                    helper.getModuleTestFindingHelper( component,event ,helper, qcComponent );
                }
                else if(qcComponent.Name__c == 'Battery'){
                    helper.getBatteryTestFindingHelper( component,event , qcComponent );
                }
                //alert('Test Records are saved');

                component.set( "v.isTestEdit" , true );

                var editTest = component.find('editTest');
                $A.util.removeClass( editTest , "slds-hide" );
                $A.util.addClass( editTest , "slds-show" );

                var saveTest = component.find('saveTest');
                $A.util.removeClass( saveTest , "slds-show" );
                $A.util.addClass( saveTest , "slds-hide" );
            }
        });
        $A.enqueueAction(action);
    },

    
    submitForApprovalProcess : function (component, event, helper) {
        debugger;
        var action = component.get("c.submitForAppProcessTemp");
        action.setParams({
            'RecId1': component.get("v.QcRecord.Id")
        });
        
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                debugger;
                var approvalProcessResponse = JSON.parse(response.getReturnValue());
                component.set("v.approvalList", response.getReturnValue());
                helper.checkRecorIsLoak(component,event,helper);
                var QcChildCompList = component.get( 'v.allQcCompList' ).filter( e => e.Parent__c != null );
                
                var qcPComp = component.get('v.QcRecord');
                qcPComp.Document_Status__c = 'Submit for Publish';
                var recArray = [];
                recArray.push( qcPComp  );
                for(var i = 0 ; i < QcChildCompList.length ;i++)
                {
                    QcChildCompList[i].Document_Status__c = 'Submit for Publish';
                    recArray.push(  QcChildCompList[i]   );
                }

                component.set("v.QcRecord", JSON.parse(JSON.stringify(qcPComp)) );
                var evt = component.getEvent("sendAllQcCompRecord");
                evt.setParams({
                    "allQcRecList" : recArray  
                    });
                evt.fire();
                alert("Approval Submitted");

                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                "recordId": qcPComp.Id
                });
                navEvt.fire();
            }
            
        });
        $A.enqueueAction(action);
    },

    checkRecorIsLoak : function(component,event,helper){
        var action=component.get('c.isRecordSubmitForApproval');
        action.setParams({
            'recordId': component.get('v.QcRecord.Id')
        });
        action.setCallback(this,(response)=>{
            if(response.getState()==="SUCCESS"){
                let result= response.getReturnValue();
                component.set('v.isRecordLock',result);
            }
        });
        $A.enqueueAction(action); 
    },

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
    },


    refreshTestData : function(component,event,helper){
        const QcMasterMList = component.get("v.QcMasterMList");
        const QcQuestionMList = component.get("v.QcQuestionMList");
        const QcResponseMList = component.get("v.QcResponseMList");
        const QcConditionMList = component.get("v.QcConditionMList")
        var inputParamList = component.get('v.inputParamList');
        var qcRecorName = component.get('v.QcRecord.Name__c');
        var qcComp = component.get('v.QcRecord');
        var qcTestList =component.get('v.qcTestList');
        if(qcRecorName == 'Case'){
            var pushButton = inputParamList.filter( e => e.question.Question_Name__c == 'Push button')[0];
            
            if(pushButton.question.Value__c == 'Yes'){
                console.log('qcTestList=>'+qcTestList);
                var isPushTestExist = qcTestList.some(e => e.Test_Name__c == 'Push Button test');
                if(!isPushTestExist){
                    var pushTestData = QcConditionMList.filter(e => e.Component_Type__c == qcRecorName &&   e.RecordType.Name == 'Test Condition' && e.Action__c == 'Visible' && e.Question_Name__c == 'Push Button test')[0];
                    var pushTestQuestion = QcQuestionMList.filter(e => e.Id == pushTestData.Question__c)[0];
                    var qcTest = {
                        Test_Name__c : pushTestQuestion.Test_Name__c,
                        Component_Name__c : qcComp.Id,
                        Condition_Ref__c : pushTestData.Id,
                        Specification_Input__c : pushTestQuestion.Specification__c,
                        Acceptance_Criteria__c : pushTestQuestion.Acceptance_Criteria__c,
                        UOM_Input__c : pushTestQuestion.UOM__c
                    }
                    qcTestList.push(qcTest);
                    component.set('v.qcTestList',JSON.parse(JSON.stringify( qcTestList)));
                    component.set('v.qcTestResetList',JSON.parse(JSON.stringify( qcTestList)));
                }
            }else if(pushButton.question.Value__c == 'No' || pushButton.question.Value__c == 'None'){
                debugger;
                var PushTestExist = qcTestList.filter(e => e.Test_Name__c == 'Push Button test')[0];
                var isPushTestExist = PushTestExist.Test_Name__c == 'Push Button test' ? true : false;
                if(isPushTestExist){
                    var pushTestRec = qcTestList.filter(e => e.Test_Name__c == 'Push Button test')[0];
                    qcTestList = qcTestList.filter(e => e.Test_Name__c != 'Push Button test');
                    component.set('v.qcTestList',JSON.parse(JSON.stringify( qcTestList)));
                    component.set('v.qcTestResetList',JSON.parse(JSON.stringify( qcTestList)));
                    let action = component.get("c.disableTestRec");
                action.setParams({
                    "recId" : pushTestRec.Id 
                });
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if( state === 'SUCCESS')
                    {
                        alert('Changes are committed');
                    }
                });
                $A.enqueueAction(action);
                }
            }
        }
        else if(qcRecorName == 'Special-Strap' || qcRecorName == 'Metal-Strap' || qcRecorName == 'Leather-Strap')
        {
            
            var genderInputDataSS = inputParamList.filter( e => e.question.Question_Name__c == 'Gender')[0];
            var response = QcResponseMList.filter( e=> e.Component_Type__c == qcComp.Name__c &&  e.Response__c == genderInputDataSS.question.Value__c)[0];
            var genderCondSS = QcConditionMList.filter(e => e.Response__c == response.Id &&  e.Component_Type__c == qcRecorName && e.RecordType.Name == 'Test Condition' )[0];
            var qcQuestion = QcQuestionMList.filter( e => e.Id == genderCondSS.Question__c )[0];
            var qcGenderDepTest = {
                
                sobjectType :'QC_Test_Data__c' ,
                Condition_Ref__c : genderCondSS.Id,
                Test_Name__c : qcQuestion.Test_Name__c,
                Component_Name__c : qcComp.Id ,
                UOM_Input__c : qcQuestion.UOM__c ,
                Specification_Input__c : qcQuestion.Specification__c,
                Observation__c : '',
                Comments_and_Remarks__c : '',
                Conclusion__c : '',
                
            };
            var oldGenderDependetValueCond = qcTestList.filter( e => e.Test_Name__c == 'Withstanding force')[0];
            if(oldGenderDependetValueCond != undefined && oldGenderDependetValueCond.Condition_Ref__c != qcGenderDepTest.Condition_Ref__c )
            {
                qcTestList =  qcTestList.filter( e => e.Test_Name__c != 'Withstanding force');
                qcTestList.push( qcGenderDepTest );
                var action = component.get("c.disableTestRec");
                action.setParams({
                    "recIdList" : [oldGenderDependetValueCond.Id]
                });
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if(state === "SUCCESS"){
                        var result = response.getReturnValue();
                    }
                });
                $A.enqueueAction( action );
            }else if(oldGenderDependetValueCond == undefined){
                qcTestList.push( qcGenderDepTest );
            }
            
            component.set('v.qcTestList',JSON.parse(JSON.stringify( qcTestList)));
            component.set('v.qcTestResetList',JSON.parse(JSON.stringify( qcTestList)));

            
        }else if(qcRecorName == 'Module'){
            var typeOfModule = component.get( 'v.typeOfModule');
            console.log('typeOfModule',typeOfModule);
            var newModuleType = inputParamList.filter( e => e.question.Question_Name__c == 'Type of Module')[0].question.Value__c;
            console.log('newModuleType',newModuleType);
            if( typeOfModule != newModuleType)
            {
                qcTestList = qcTestList.filter( e => e.Id != undefined );
                console.log('qcTestList',qcTestList);
                var qcTestIdList = qcTestList.map( (item) =>{ return item.Id  });
                console.log('qcTestIdList',qcTestIdList);
                var action = component.get("c.disableTestRec");
                action.setParams({
                    "recIdList" : qcTestIdList
                });
                action.setCallback(this,function(response){
                    var state = response.getState();
                    if(state === "SUCCESS"){
                        var result = response.getReturnValue();
                        console.log('result',result);
                        var isCompitator = (qcComp.Sample_Category__c == 'Competitor Products') ? true : false ;
                        var inputParamList = component.get("v.inputParamList");
                        var typeOfModule = inputParamList.filter( e => e.question.Question_Name__c == 'Type of Module')[0];
                        console.log('typeOfModule::::',typeOfModule);
                        component.set( 'v.typeOfModule', typeOfModule.question.Value__c  );
                        var brandCondtionlist = [];
                        brandCondtionlist = QcConditionMList.filter( e => e.Brand__c == qcComp.Brand__c && e.Component_Type__c == qcComp.Name__c && e.RecordType.Name == 'Test Condition' );
                        var compCondtionlist = [];
                        console.log('typeOfModule.question.Value__c', typeOfModule.question.Value__c);
                        if(typeOfModule.question.Value__c == 'Anadigi'){
                            typeOfModule.question.Value__c  = 'Digital';
                            component.set( 'v.typeOfModule', typeOfModule.question.Value__c  );
                        }
                        compCondtionlist = isCompitator ?  QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  ((typeOfModule.question.Value__c == 'Digital' || typeOfModule.question.Value__c == 'Smart Watch' ) ? e.Type_of_Module__c == typeOfModule.question.Value__c : e.Type_of_Module__c == undefined))   : 
                                                        QcConditionMList.filter( e => e.Component_Type__c == qcComp.Name__c &&   e.RecordType.Name == 'Test Condition' &&  e.Onload__c == true && ((typeOfModule.question.Value__c == 'Digital' || typeOfModule.question.Value__c == 'Smart Watch') ? e.Type_of_Module__c == typeOfModule.question.Value__c : e.Type_of_Module__c == undefined) );
                       
                        // var genaralObservationCond = QcConditionMList.filter( e => e.Question_Name__c == "General Observation" && e.RecordType.Name == 'Test Condition' );
                        var allCondList = compCondtionlist.concat( brandCondtionlist );
                       // if( typeOfModule.question.Value__c != 'Quartz')
                           // allCondList = allCondList.concat( genaralObservationCond );
                        class qcTestClass {
                            constructor(){
                                return {
                                    sobjectType :'QC_Test_Data__c' ,
                                    Condition_Ref__c : '',
                                    Test_Name__c : '',
                                    Component_Name__c : '',
                                    UOM_Input__c : '' ,
                                    Specification_Input__c : '',
                                    Acceptance_Criteria__c : '' ,
                                    Initial1__c : '',
                                    Initial2__c : '',
                                    Initial3__c : '',
                                    Initial4__c : '',
                                    Initial5__c : '',
                                    Initial_Test_Observation__c : '',
                                    After_Test1__c : '',
                                    After_Test2__c : '',
                                    After_Test3__c : '',
                                    After_Test4__c : '',
                                    After_Test5__c : '',
                                    After_Test_Observation__c : '',
                                    Observation1__c : '',
                                    Observation2__c : '',
                                    Observation3__c : '',
                                    Observation4__c : '',
                                    Observation5__c : '',
                                    Parent__c : '',
                                    RecordTypeId : '',
                                    Observation__c : '',
                                    Comments_and_Remarks__c : '',
                                    Conclusion__c : '',
                                    Active__c : true,
                                    condition : '',
                                };
                            }
                        }
                        allCondList.sort((a,b)=>{ return b.Onload__c-a.Onload__c});
                        allCondList = allCondList.filter( e=> e != undefined );
                        var qcTestDatalist = allCondList.map( (item,index)=>{
                            var qcQuestion = QcQuestionMList.filter( e => e.Id == item.Question__c )[0];
                            console.log(qcQuestion);
                            var qcTest = new qcTestClass();
                            qcTest.Test_Name__c = qcQuestion.Test_Name__c;
                            qcTest.Component_Name__c = qcComp.Id;
                            qcTest.Condition_Ref__c = item.Id;
                            qcTest.condition = item;
                            qcTest.Specification_Input__c = qcQuestion.Specification__c;
                            qcTest.Acceptance_Criteria__c = qcQuestion.Acceptance_Criteria__c;
                            qcTest.UOM_Input__c = qcQuestion.UOM__c ; 
                            if(index != 0 && qcQuestion.Test_Name__c == allCondList[index-1].Question_Name__c ){
                                qcTest.rowSpan = true ;
                            }else{
                                qcTest.rowSpan = false ;
                                qcTest.Initial1__c = 'R';
                                qcTest.Initial2__c = 'R';
                                qcTest.Initial3__c = 'R';
                                qcTest.Initial4__c = 'R';
                                qcTest.Initial5__c = 'R';
                            }
                            return qcTest;
                        });
                        
                        component.set('v.qcTestList',JSON.parse(JSON.stringify( qcTestDatalist)));
                        component.set('v.qcTestResetList',JSON.parse(JSON.stringify( qcTestDatalist)));
                        component.set ( "v.genarateTestDisabled" , true);
                        helper.saveTestHelper(component,event,helper,qcTestDatalist);
                    }
                });
                $A.enqueueAction( action );
            }else{
                if(qcTestList.length == 0){
                    qcComp.Test_generated__c =  false;
                    helper.getModuleTestFindingHelper( component,event,helper ,qcComp );
                }
            }
        }
    }, */

})