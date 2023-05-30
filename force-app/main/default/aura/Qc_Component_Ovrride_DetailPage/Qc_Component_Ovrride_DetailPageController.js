({
	/*doInit : function(component, event, helper) {
		
        var brand = component.get("v.QcRecord.Brand__c");
        var vendor = component.get("v.QcRecord.Vendor__c");
        let qcMaster = component.get('v.QcMasterMList');

        var selectedBrand = qcMaster.filter( e => e.Id == brand )[0];
        var selectedVendor = qcMaster.filter( e => e.Id == vendor )[0];
        component.set("v.seleteBrandLookup", selectedBrand );
        component.set("v.seleteVendorLookup", selectedVendor );
        //component.set("v.showLookupfields", true );

        var masterVarient = component.get("v.QcRecord.Master_Variant__c");
        if( masterVarient != undefined || masterVarient != null)
        {
            helper.fetchMVNamehelper( component , event , masterVarient );
        }

        helper.fetchDependetPicklistHelper( component , event, helper );
        helper.fetchInputDatahelper( component, event, helper );
        helper.fetchPickListValues( component, event, helper );
        
	},

    clickApproval : function( component, event ,helper){
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        var recId = component.get("v.QcRecord.Id");
        
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": recId
        });
        relatedListEvent.fire();

    },

    reliabilityReport : function( component , event , helper){
        var qcCompName = component.get("v.QcRecord.Name__c");
        if( qcCompName == 'Full-Watch' )
            window.open('/apex/QC_FullWatchReport?id='+ component.get('v.QcRecord.Id') );
        else if( qcCompName == 'Watch-Head')
            window.open('/apex/QC_WatchHeadReport?id='+ component.get('v.QcRecord.Id') );
    },
    detailedReport : function( component , event , helper){
        var qcCompName = component.get("v.QcRecord.Name__c");
        if(qcCompName == 'Full-Watch'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Watch-Head'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Case'){
            window.open('/apex/QC_caseDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Leather-Strap'){
            window.open('/apex/QC_leatherStrapDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Dial'){
            window.open('/apex/QC_DialReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Metal-Strap'){
            window.open('/apex/QC_MetalStrapDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Special-Strap'){
            window.open('/apex/QC_specialStrapDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Battery'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Packaging'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Module'){
            window.open('/apex/QC_moduleDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }
    },


    componentReport : function( component , event , helper){
        var qcCompName = component.get("v.QcRecord.Name__c");
         if(qcCompName == 'Case'){
            window.open('/apex/QC_CaseReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Leather-Strap'){
            window.open('/apex/QC_LeatherStrapReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Dial'){
            window.open('/apex/QC_DialReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Metal-Strap'){
            window.open('/apex/QC_MetalStrapReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Special-Strap'){
            window.open('/apex/QC_SpecialStrapReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Battery'){
            window.open('/apex/QC_BatteryReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Packaging'){
            window.open('/apex/QC_PackagingReport?id='+ component.get('v.QcRecord.Id') );
        }
    },


    allTestfindingReport : function( component , event , helper){
        var qcCompName = component.get("v.QcRecord.Name__c");
        if( qcCompName == 'Full-Watch' )
            window.open('/apex/QC_AllTestFindingSummaryReport?id='+ component.get('v.QcRecord.Id') );
        else if( qcCompName == 'Watch-Head')
            window.open('/apex/QC_AllTestFindingSummaryReportWH?id='+ component.get('v.QcRecord.Id') );
    },

    clickApprovalSubmission : function( component , event , helper){
        debugger;
        var action = component.get("c.submitForAppProcessTemp");
        action.setParams({
            'RecId1': component.get("v.QcRecord.Id")
        });
        
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                "recordId": component.get("v.QcRecord.Id")
                });
                navEvt.fire();
            }
            
        });
        $A.enqueueAction(action);
    },

    clickClone : function( component , event , helper){
        debugger;
        var action = component.get("c.getCompDetail");
        action.setParams({
            'recdId': component.get("v.QcRecord.Id") 
        });
        
        action.setCallback(this, function (response) {
            if (response.getState() == "SUCCESS") {
                
                var selectedRecPack = JSON.parse(response.getReturnValue());
                let parentQcCompRec = JSON.parse(JSON.stringify(selectedRecPack.parentDetail.qcComp));
                parentQcCompRec.Id = null
                parentQcCompRec.Name = null;
                parentQcCompRec.Component__r = null ;
                parentQcCompRec.Report_Ref_Number__c = '';
                parentQcCompRec.Document_Status__c = 'Draft' ;
                parentQcCompRec.Component_Status__c = 'Active' ;
                parentQcCompRec.Sample_Category__c = 'New' ;
                parentQcCompRec.Sample_Date__c = null ;
                parentQcCompRec.Watch_variant__c = null ;
                parentQcCompRec.Final_Verdict__c = null ;
                

                let parentInputdata = selectedRecPack.parentDetail.inputParam.map((item,index,arr) => { 
                item["Id"] = null;
                item["Name"] = null;
                item["Component_No__c"] = '';   
                return item;
                });
                console.log( parentInputdata );

                let parentTestdata = selectedRecPack.parentDetail.testData == null ? null : selectedRecPack.parentDetail.testData.map((item,index,arr) => { 
                item["Id"] = null;
                item["Name"] = null;
                item["Component_Name__c"] = '';   
                return item;
                });

                console.log( parentTestdata );

                let childRecInfo = selectedRecPack.childsDetail.map( ( item , index, arr) =>{
                item.qcComp.Id = null;
                item.qcComp.Name = null;
                item.qcComp.Parent__c = '';
                item.qcComp.Report_Ref_Number__c = '';
                item.qcComp.Component__r = null ;
                item.qcComp.Document_Status__c = 'Draft' ;
                item.qcComp.Component_Status__c = 'Active' ;
                item.qcComp.Sample_Category__c = 'New' ;
                item.qcComp.Sample_Date__c = null ;
                item.qcComp.Watch_variant__c = null ;
                item.qcComp.SKU_Reference__c = null ;
                item.qcComp.Final_Verdict__c = null ;
                

                item.inputParam.map((childItem,childIndex,chilAarr) => { 
                    childItem["Id"] = null;
                    childItem["Name"] = null;
                    childItem["Component_No__c"] = '';   
                    return childItem;
                    });

                    item.testData == null ? null : item.testData.map((childItem,childIndex,chilAarr) => { 
                    childItem["Id"] = null;
                    childItem["Name"] = null;
                    childItem["Component_Name__c"] = '';   
                    return childItem;
                    });
                    return item;
                });

                let cloneRec = {
                parentDetail : { qcComp : parentQcCompRec , inputParam : parentInputdata, testData : parentTestdata  } ,
                childsDetail : childRecInfo
                };

                var action = component.get("c.saveClonedFWOrWHComponent");
                action.setParams({
                    "cloneData" : JSON.stringify(cloneRec)
                });
                action.setCallback( this , function(response){
                    var state = response.getState();
                    if( state === 'SUCCESS' )
                    {
                        var result = JSON.parse( response.getReturnValue() );

                        var navEvt = $A.get("e.force:navigateToSObject");
                        navEvt.setParams({
                        "recordId": result.parentDetail.qcComp.Id
                        });
                        navEvt.fire();
                        
                    }else{
                        let errorResult = (response.getError()).map((item,index)=>{
                        return item.message;
                        });
                        alert(JSON.stringify(errorResult));
                    }
                });
                $A.enqueueAction(action); 
            }
            
        });
        $A.enqueueAction(action);
    },
	// selectLookupRec : function( component, event ,helper){
    //     var seectedRecId = event.getParam('customId');
    //     var recordByEvent = event.getParam('recordByEvent');
	// 	var label = event.getParam('label');
	// 	if(label == 'Brand' )
	// 	{
	// 		if( recordByEvent != null ){
    //             component.set("v.seleteBrandLookup", recordByEvent );
    //             component.set("v.QcRecord.Brand__c", recordByEvent.Id );
	// 		    component.set("v.QcRecord.Brands__c", recordByEvent.Name );
	// 		    helper.dependentClusterAddition( component, event , component.get("v.QcRecord.Brands__c") );
	// 		    return;
	// 	    }
	// 		else{
    //             component.set("v.seleteBrandLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
	// 			component.set("v.QcRecord.Brand__c", '' );
	// 		    component.set("v.QcRecord.Brands__c", '' );
	// 		    component.set('v.ClusterList',[]);
	// 		    return;
	// 	    }
	// 	}
	// 	if(label == 'Vendor' )
	// 	{
	// 		if( recordByEvent != null ){
	// 		    component.set("v.seleteVendorLookup", recordByEvent );
	// 		    component.set("v.QcRecord.Vendor__c", recordByEvent.Id );
	// 		    return;
	// 	    }
	// 		else{
	// 			component.set("v.seleteVendorLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
	// 			component.set("v.QcRecord.Vendor__c", '' );
	// 		    return;
	// 	    }
	// 	}
        
    // },

	// clickQcCompEdit : function(component, event, helper) {
    //     component.set( "v.isQcCompEdit" , false );

    //     var saveQcComp = component.find('saveQcComp');
    //     $A.util.removeClass( saveQcComp , "slds-hide" );
    //     $A.util.addClass( saveQcComp , "slds-show" );

    //     var editQcComp = component.find('editQcComp');
    //     $A.util.removeClass( editQcComp , "slds-show" );
    //     $A.util.addClass( editQcComp , "slds-hide" );
    // },

    // clickQcCompSave : function(component, event, helper) {
    //     component.set( "v.isQcCompEdit" , true );

    //     var editQcComp = component.find('editQcComp');
    //     $A.util.removeClass( editQcComp , "slds-hide" );
    //     $A.util.addClass( editQcComp , "slds-show" );

    //     var saveQcComp = component.find('saveQcComp');
    //     $A.util.removeClass( saveQcComp , "slds-show" );
    //     $A.util.addClass( saveQcComp , "slds-hide" );

        
    //     var qcComponent = component.get('v.QcRecord');
    //     if( qcComponent.Parent__c == undefined || qcComponent.Parent__c == null ){

    //         if(qcComponent.Sample_Date__c == undefined || qcComponent.Sample_Date__c == null || qcComponent.Sample_Date__c == '' )
    //         {
    //             alert('Enter sample date');
    //             return;
    //         }
            
    //         if( (qcComponent.Brand__c == undefined || qcComponent.Brand__c.length == 0)  )
    //         {
    //             alert('Enter Brand');
    //             return;
    //         }
    
    //         if( (qcComponent.Sample_Received_From__c == undefined || qcComponent.Sample_Received_From__c == null)  )
    //         {
    //             alert('Enter Sample recieved From Email');
    //             return;
    //         }

    //         var allQcCompList = component.get('v.allQcCompList');
    //         var childComponentList = allQcCompList.filter( e=> e.Parent__c != null);
    //         var qcCompList=[];
    //         qcCompList.push( qcComponent );
    //         for(var i=0 ; i < childComponentList.length ; i++ )
    //         {
    //             var child = JSON.parse(JSON.stringify( qcComponent )) ;
    //             child.Id = childComponentList[i].Id ;
    //             child.Name__c = childComponentList[i].Name__c ;
    //             child.Parent__c = childComponentList[i].Parent__c ;
    //             child.Report_Ref_Number__c = null ;
    //             child.SKU_Reference__c = childComponentList[i].SKU_Reference__c ;
    //             child.General_Observation__c = childComponentList[i].General_Observation__c ;
    //             child.Final_Verdict__c = childComponentList[i].Final_Verdict__c ;
    //             childComponentList[i] =  child  ;
    //             qcCompList.push( child );

    //         }
    //         helper.saveChildQcCompRecordHelper( component, event, qcCompList );
    //     }
        
    // },

    // clickQcCompCancel : function(component, event, helper) {
    //     component.set( "v.isQcCompEdit" , true );

    //     var editQcComp = component.find('editQcComp');
    //     $A.util.removeClass( editQcComp , "slds-hide" );
    //     $A.util.addClass( editQcComp , "slds-show" );

    //     var saveQcComp = component.find('saveQcComp');
    //     $A.util.removeClass( saveQcComp , "slds-show" );
    //     $A.util.addClass( saveQcComp , "slds-hide" );
    // },

    // clickInputParamEdit :function(component, event, helper) {
    //     component.set( "v.isInputParamEdit" , false );

    //     var saveInputParam = component.find('saveInputParam');
    //     $A.util.removeClass( saveInputParam , "slds-hide" );
    //     $A.util.addClass( saveInputParam , "slds-show" );

    //     var editInputParam = component.find('editInputParam');
    //     $A.util.removeClass( editInputParam , "slds-show" );
    //     $A.util.addClass( editInputParam , "slds-hide" );
    // },

    // clickInputParamCancel :function(component, event, helper) {
    //     component.set( "v.isInputParamEdit" , true );

    //     var editInputParam = component.find('editInputParam');
    //     $A.util.removeClass( editInputParam , "slds-hide" );
    //     $A.util.addClass( editInputParam , "slds-show" );

    //     var saveInputParam = component.find('saveInputParam');
    //     $A.util.removeClass( saveInputParam , "slds-show" );
    //     $A.util.addClass( saveInputParam , "slds-hide" );
    //     component.set('v.isAddRow', false);
    // },

    // clickAddInput : function(component, event, helper) {
    //     //component.set('v.isAddRow', true);
    //     var newQcInputData = { sobjectType :'QC_Input_Data__c' ,
    //                            isManual__c: true ,
    //                            Component_No__c : component.get('v.QcRecord.Id'),
    //                            Question_Name__c:'',
    //                            Value__c:'',
    //                            Comments__c:'' };
    //     var inputParamList = component.get('v.inputParamList');
    //     var inputParam = {question: newQcInputData ,picklist:[] };
    //     inputParamList.push( inputParam ) ;
    //     component.set('v.inputParamList', inputParamList );

    // },

    // clickDeleteInputData : function(component, event, helper) {
    //     var index = event.getSource().get("v.value");
    //     var inputParamList = component.get('v.inputParamList');
    //     var deleteInputData = inputParamList[index];

    //     if( deleteInputData.question.Id != undefined ){
    //         var action = component.get('c.deleteInputDataMethod');
    //         action.setParams({
    //             'inputDataRecstr' :  JSON.stringify( deleteInputData.question )
    //         }); 
    //         action.setCallback(this,function(response){

    //             var state = response.getState();
    //             if( state === 'SUCCESS')
    //             {
    //                 var remainingInputData = inputParamList.filter( e => e.question.Id != deleteInputData.question.Id );
    //                 component.set('v.inputParamList', remainingInputData);
    //             }
    //         });
    //         $A.enqueueAction(action);
    //     }
    //     else{
    //         var remainingInputData = inputParamList.filter( (item,indexValue) => { return indexValue != index; } );
    //         component.set('v.inputParamList', remainingInputData);
    //     }

    // },

    // clickInputParamSave : function(component, event, helper) {
        
    //     var QcQuestionMList = component.get("v.QcQuestionMList");
    //     var inputParamList = component.get("v.inputParamList");
    //     var saveInputParamList = [];
    //     for(var i =0 ; i< inputParamList.length ; i++)
    //     {
    //         var isCompitator = (component.get('v.qcComponent.Sample_Category__c') == 'Competitor Products') ? true : false ;
    //         if( ! inputParamList[i].question.isManual__c )
    //         {
    //             var mQuestion = QcQuestionMList.filter( e => e.Id == inputParamList[i].question.Question__c )[0];
    //             if(  !isCompitator && mQuestion.IsNumeric__c && inputParamList[i].question.Value__c != undefined &&isNaN(inputParamList[i].question.Value__c ))
    //             {
    //                 alert( inputParamList[i].question.Question__r.Question__c +' Value must be numeric');
    //                 saveInputParamList = [];
    //                 return ;
    //             }
    //             if( !isCompitator && mQuestion.Response_Required__c && (inputParamList[i].question.Value__c == undefined || inputParamList[i].question.Value__c == '')  )
    //             {
    //                 alert( 'Please enter value for '+inputParamList[i].question.Question__r.Question__c );
    //                 saveInputParamList = [];
    //                 return ;
    //             }
    //         }else{
    //             if( inputParamList[i].question.Question_Name__c == '' )
    //             {
    //                 alert( 'Please enter Question Name all Manual records ');
    //                 return ;
    //             }
    //         }
            
    //         saveInputParamList.push( inputParamList[i].question );
    //     }
    //     if( saveInputParamList.length > 0)
    //         helper.saveInputParamHelper(component,event,saveInputParamList);
    // },

    // clickTestEdit :function(component, event, helper) {
    //     component.set( "v.isTestEdit" , false );

    //     var saveTest = component.find('saveTest');
    //     $A.util.removeClass( saveTest , "slds-hide" );
    //     $A.util.addClass( saveTest , "slds-show" );

    //     var editTest = component.find('editTest');
    //     $A.util.removeClass( editTest , "slds-show" );
    //     $A.util.addClass( editTest , "slds-hide" );
    // },

    // clickTestCancel :function(component, event, helper) {
    //     component.set( "v.isTestEdit" , true );

    //     var editTest = component.find('editTest');
    //     $A.util.removeClass( editTest , "slds-hide" );
    //     $A.util.addClass( editTest , "slds-show" );

    //     var saveTest = component.find('saveTest');
    //     $A.util.removeClass( saveTest , "slds-show" );
    //     $A.util.addClass( saveTest , "slds-hide" );
    // },

    // clickAddTest : function(component, event, helper) {
    //     //component.set('v.isAddRow', true);
    //     var newQcTestData = { sobjectType :'QC_Test_Data__c' ,
    //                         Test_Name__c : '',
    //                         Component_Name__c : component.get('v.QcRecord.Id') ,
    //                         UOM_Input__c : '' ,
    //                         Specification_Input__c : '',
    //                         Acceptance_Criteria__c: '',
    //                         Observation__c : '',
    //                         Comments_and_Remarks__c : '',
    //                         Conclusion__c : '',
    //                         isManual__c  :  true
    //                         };
    //     var qcTestList = component.get('v.qcTestList');
    //     qcTestList.push( newQcTestData ) ;
    //     component.set('v.qcTestList', qcTestList );

    // },

    // clickTestSave : function(component, event, helper) {
        
    //     var qcTestList = component.get("v.qcTestList");
    //     var saveTestList = [];
    //     for(var i =0 ; i< qcTestList.length ; i++)
    //     {
    //         //var isCompitator = (component.get('v.QcRecord.Sample_Category__c') == 'Competitor Products') ? true : false ;
    //         if( ! qcTestList[i].isManual__c )
    //         {

    //         }else{
    //             if( qcTestList[i].Test_Name__c == '' )
    //             {
    //                 alert( 'Please enter Test Name for all Manual records ');
    //                 return ;
    //             }
    //         }
            
    //         saveTestList.push( qcTestList[i] );
    //     }
    //     if( saveTestList.length > 0)
    //         helper.saveTestHelper(component,event,saveTestList);
    // },

    // clickDeleteTest : function (component, event, helper) 
    // {
    //     var index = event.getSource().get("v.value");
    //     var qcTestList = component.get('v.qcTestList');
    //     var deleteTestData = qcTestList[index];

    //     if( deleteTestData.Id != undefined ){
    //         var action = component.get('c.deleteTestDataMethod');
    //         action.setParams({
    //             'testDataRecstr' :  JSON.stringify( deleteTestData )
    //         }); 
    //         action.setCallback(this,function(response){

    //             var state = response.getState();
    //             if( state === 'SUCCESS')
    //             {
    //                 var remainingTestData = qcTestList.filter( e => e.Id != deleteTestData.Id );
    //                 component.set('v.qcTestList', remainingTestData);
    //             }
    //         });
    //         $A.enqueueAction(action);
    //     }
    //     else{
    //         var remainingTestData = qcTestList.filter( (item,indexValue) => { return indexValue != index; } );
    //         component.set('v.qcTestList', remainingTestData);
    //     }
    // },

    // onChangePickVal : function (component, event, helper) 
    // {
    //     var multivaluePicklistValue = event.getParam('selectedValues');
    //     var multivaluePicklistName = event.getParam('picklistName');
    //     var qcInputIndex = event.getParam('questionIndex');
    //     var inputParamList = component.get("v.inputParamList");
    //     var a =[];
    //     var b ;
    //     for(var i=0 ; i< multivaluePicklistValue.length ;i++)
    //     {
    //         a.push( {'label': multivaluePicklistValue[i] ,'value': multivaluePicklistValue[i]});
    //         if(b == null || b == undefined )
    //             b = multivaluePicklistValue[i];
    //         else
    //             b = b + ','+multivaluePicklistValue[i];
    //     }
        
    //     inputParamList[qcInputIndex].question.Value__c = b ;
    //     component.set("v.inputParamList",inputParamList);
    // },

    genTest : function(component,event,helper){
        debugger;
        var genTest = component.find("genTest").get("v.value");
        if( component.get('v.QcRecord.Brand__c') == undefined)
        {
            component.find("genTest").set("v.value",false);
            alert("Enter Brand Value");
            return;
        }
        console.log(genTest);
        if( genTest )
        {
            var testFindings = component.find("testFindings");
            $A.util.removeClass( testFindings , 'slds-hide' );
            $A.util.addClass( testFindings , 'slds-show' );
            var qcComponent = component.get('v.QcRecord');
            if( qcComponent.Name__c != undefined && qcComponent.Name__c != 'Module' && qcComponent.Name__c != 'Battery' )
            {
                helper.getTestFindingHelper( component,event , qcComponent );
            }
        }
        else{
            var testFindings = component.find("testFindings");
            $A.util.removeClass( testFindings , 'slds-show' );
            $A.util.addClass( testFindings , 'slds-hide' );
        }
        
    }*/

})