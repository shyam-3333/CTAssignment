({
	/*doInit : function(component, event, helper) {
		 
        var baseUrl = window.location.hostname;
        component.set("v.baseUrl", "https://"+baseUrl); 

        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set('v.today', today);
    
        component.set('v.qcCompResetObj',JSON.parse(JSON.stringify(component.get("v.QcRecord"))));
        var brand = component.get("v.QcRecord.Brand__c");
        var vendor = component.get("v.QcRecord.Vendor__c");
        let qcMaster = component.get('v.QcMasterMList');

        var selectedBrand = qcMaster.filter( e => e.Id == brand )[0];
        var selectedVendor = qcMaster.filter( e => e.Id == vendor )[0];
        component.set("v.seleteBrandLookup", selectedBrand );
        component.set("v.seleteVendorLookup", selectedVendor );
        component.set("v.showLookupfields", true );
        
        var masterVarient = component.get("v.QcRecord.Master_Variant__c");
        if( masterVarient != undefined || masterVarient != null)
        {
            helper.fetchMVNamehelper( component , event , masterVarient );
        }
        
        helper.fetchInputDatahelper( component, event, helper );
        helper.fetchDependetPicklistHelper( component , event, helper );
        helper.fetchPickListValues( component, event, helper );

	},
	selectLookupRec : function( component, event ,helper){
        var seectedRecId = event.getParam('customId');
        var recordByEvent = event.getParam('recordByEvent');
		var label = event.getParam('label');
		if(label == 'Brand' )
		{
			if( recordByEvent != null ){
                component.set("v.seleteBrandLookup", recordByEvent );
                component.set("v.QcRecord.Brand__c", recordByEvent.Id );
			    component.set("v.QcRecord.Brands__c", recordByEvent.Name );
			    helper.dependentClusterAddition( component, event , component.get("v.QcRecord.Brands__c") );
			    return;
		    }
			else{
                component.set("v.seleteBrandLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
				component.set("v.QcRecord.Brand__c", '' );
			    component.set("v.QcRecord.Brands__c", '' );
			    component.set('v.ClusterList',[]);
			    return;
		    }
		}
		if(label == 'Vendor' )
		{
			if( recordByEvent != null ){
			    component.set("v.seleteVendorLookup", recordByEvent );
			    component.set("v.QcRecord.Vendor__c", recordByEvent.Id );
			    return;
		    }
			else{
				component.set("v.seleteVendorLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
				component.set("v.QcRecord.Vendor__c", '' );
			    return;
		    }
		}
        
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

    clickQcCompEdit : function(component, event, helper) {
        component.set( "v.isQcCompEdit" , false );
    
        var saveQcComp = component.find('saveQcComp');
        $A.util.removeClass( saveQcComp , "slds-hide" );
        $A.util.addClass( saveQcComp , "slds-show" );

        var editQcComp = component.find('editQcComp');
        $A.util.removeClass( editQcComp , "slds-show" );
        $A.util.addClass( editQcComp , "slds-hide" );

        var inputParamButton = component.find("inputParamButton");
        $A.util.removeClass( inputParamButton , "slds-show" );
        $A.util.addClass( inputParamButton , "slds-hide" );

        var testFindingButton = component.find("testFindingButton");
        $A.util.removeClass( testFindingButton , "slds-show" );
        $A.util.addClass( testFindingButton , "slds-hide" );

        // var qcCompButton = component.find("qcCompButton");
        // $A.util.removeClass( qcCompButton , "slds-show" );
        // $A.util.addClass( qcCompButton , "slds-hide" );
        
    },

    changefinalVerdict : function(component, event, helper) {
        debugger;
        var oldFinalVerdict = event.getParam("oldValue");
        component.set("v.oldFinalVerdict", oldFinalVerdict );
    },

    clickQcCompSave : function(component, event, helper) {
        var qcComponent = component.get('v.QcRecord');
        if(qcComponent.Sample_Date__c == undefined || qcComponent.Sample_Date__c == null || qcComponent.Sample_Date__c == '' )
        {
            alert('Enter sample date');
            return;
        }
        
        if( (qcComponent.Brand__c == undefined || qcComponent.Brand__c.length == 0)  )
        {
            alert('Enter Brand');
            return;
        }

        if( (qcComponent.Sample_Received_From__c == undefined || qcComponent.Sample_Received_From__c == null)  )
        {
            alert('Enter Sample recieved From Email');
            return;
        }
        
        var oldFinalVerdict = JSON.parse(JSON.stringify(component.get("v.qcCompResetObj"))).Final_Verdict__c;//component.get("v.oldFinalVerdict");
        if( (qcComponent.Parent__c == undefined || qcComponent.Parent__c == null) && qcComponent.Final_Verdict__c != oldFinalVerdict )
        {
            var qcCompList = component.get('v.allQcCompList');
            //var rejectedChild = qcCompList.filter( e=> e.Parent__c != null && (e.Final_Verdict__c == "Reject" || e.Final_Verdict__c == "" || e.Final_Verdict__c == undefined ));
            var rejectedChild = qcCompList.filter( e=> e.Parent__c != null && ( e.Final_Verdict__c == "None" || e.Final_Verdict__c == "" || e.Final_Verdict__c == undefined ));
            if( rejectedChild.length != 0 )
            {
                var compNameStr='';
                for(var i=0; i< rejectedChild.length ; i++ )
                {
                    if( i == rejectedChild.length-1)
                    {
                        compNameStr = compNameStr + rejectedChild[i].Name__c;
                    }
                    else{
                        compNameStr = compNameStr + rejectedChild[i].Name__c + ",  " ;  
                    }
                    
                }

                //alert( 'The components ' + compNameStr + ' is/are rejected Do you wish to continue with the same verdict ? ');
                alert( 'The components ' + compNameStr + ' is/are not selected.please Enter verdicts for all component  ');
                return ;
            }

            var qcTestList = component.get("v.qcTestList");
            if( qcComponent.Name__c != 'Battery')
            {
                if( qcTestList.length == 0)
                {
                    alert( "there is no Test Findings" );
                    return;
                }else{
                    
                    if( qcComponent.Name__c != 'Module')
                    {
                        var isTestObservationPresent = qcTestList.some((item) => {
                            return (item.Observation__c == undefined || item.Observation__c == null || item.Observation__c == "")
                        });
                        if(isTestObservationPresent )
                        {
                            alert( "Fill All the Test findings Observation");
                            return;
                        } 
                    }
                    else{
    
                        var isTestObservationPresent = qcTestList.some((item) => {
                            return ((item.Specification_Input__c == 'Test observation' || item.Specification_Input__c == '24 Hours/Color Change' || item.Specification_Input__c == '3000 Actuation' || item.Test_Name__c == 'General Observation' )) && ((item.Observation__c == undefined || item.Observation__c == null || item.Observation__c == ""))
                        });
                        if(isTestObservationPresent )
                        {
                            alert( "Fill All the Test findings Observation");
                            return;
                        } 
    
                    }
                }
            }
            
        }

        if( qcComponent.Parent__c != undefined  && qcComponent.Final_Verdict__c != oldFinalVerdict )
        {
            var qcCompList = component.get('v.allQcCompList'); 
            var parentComp = qcCompList.filter( e=>  e.Id == qcComponent.Parent__c )[0];
            if( !(parentComp.Final_Verdict__c == undefined || parentComp.Final_Verdict__c == "None" ||parentComp.Final_Verdict__c == "" ) )
            {
                alert( "You cannot change the verdict since final verdict is captured at full watch/Watch head level" );
                return;
            }

            var qcTestList = component.get("v.qcTestList");
            if( qcTestList.length == 0)
            {
                alert( "there is no Test Findings please genarate test findings" );
                return;
            }else{
                var isTestObservationPresent = qcTestList.some((item) => {
                    return (item.Observation__c == undefined || item.Observation__c == null || item.Observation__c == "")
                });
                if(isTestObservationPresent )
                {
                    alert( "Fill All the Test findings Observation before saving the Final verdict");
                    return;
                } 
            }
        }

        
        component.set( "v.isQcCompEdit" , true );

        var editQcComp = component.find('editQcComp');
        $A.util.removeClass( editQcComp , "slds-hide" );
        $A.util.addClass( editQcComp , "slds-show" );
    
        var saveQcComp = component.find('saveQcComp');
        $A.util.removeClass( saveQcComp , "slds-show" );
        $A.util.addClass( saveQcComp , "slds-hide" );

        var inputParamButton = component.find("inputParamButton");
        $A.util.removeClass( inputParamButton , "slds-hide" );
        $A.util.addClass( inputParamButton , "slds-show" );

        var testFindingButton = component.find("testFindingButton");
        $A.util.removeClass( testFindingButton , "slds-hide" );
        $A.util.addClass( testFindingButton , "slds-show" );
        
        if( qcComponent.Parent__c == undefined || qcComponent.Parent__c == null ){

            var allQcCompList = component.get('v.allQcCompList');
            var childComponentList = allQcCompList.filter( e=> e.Parent__c != null);
            var qcCompList=[];
            qcCompList.push( qcComponent );
            for(var i=0 ; i < childComponentList.length ; i++ )
            {
                var child = JSON.parse(JSON.stringify( qcComponent )) ;
                child.Id = childComponentList[i].Id ;
                child.Name__c = childComponentList[i].Name__c ;
                child.Parent__c = childComponentList[i].Parent__c ;
                child.Report_Ref_Number__c = null ;
                child.SKU_Reference__c = childComponentList[i].SKU_Reference__c ;
                child.General_Observation__c = childComponentList[i].General_Observation__c ;
                child.Final_Verdict__c = childComponentList[i].Final_Verdict__c ;
                child.Test_generated__c = childComponentList[i].Test_generated__c ;
                childComponentList[i] =  child  ;
                qcCompList.push( child );

            }
            helper.saveChildQcCompRecordHelper( component, event, qcCompList );
        }
        else{
            helper.saveIndividualQcComp( component, event,helper, qcComponent );
        }
    
},

clickQcCompCancel : function(component, event, helper) {
    component.set( "v.isQcCompEdit" , true );
    let qcComp = JSON.parse(JSON.stringify(component.get("v.qcCompResetObj")));
    component.set('v.QcRecord', qcComp );
    let allQcCompList = JSON.parse(JSON.stringify(component.get("v.allQcCompList")));
    allQcCompList = allQcCompList.map( e => { if( e.Id == qcComp.Id ){ e = qcComp } return e});
    var evt = component.getEvent("sendAllQcCompRecord");
    evt.setParams({
        "allQcRecList" : allQcCompList  ,
        });
    evt.fire();
    var editQcComp = component.find('editQcComp');
    $A.util.removeClass( editQcComp , "slds-hide" );
    $A.util.addClass( editQcComp , "slds-show" );

    var saveQcComp = component.find('saveQcComp');
    $A.util.removeClass( saveQcComp , "slds-show" );
    $A.util.addClass( saveQcComp , "slds-hide" );

    var inputParamButton = component.find("inputParamButton");
    $A.util.removeClass( inputParamButton , "slds-hide" );
    $A.util.addClass( inputParamButton , "slds-show" );

    var testFindingButton = component.find("testFindingButton");
    $A.util.removeClass( testFindingButton , "slds-hide" );
    $A.util.addClass( testFindingButton , "slds-show" );
},

clickInputParamEdit :function(component, event, helper) {
    component.set( "v.isInputParamEdit" , false );

    var saveInputParam = component.find('saveInputParam');
    $A.util.removeClass( saveInputParam , "slds-hide" );
    $A.util.addClass( saveInputParam , "slds-show" );

    var editInputParam = component.find('editInputParam');
    $A.util.removeClass( editInputParam , "slds-show" );
    $A.util.addClass( editInputParam , "slds-hide" );

    var qcCompButton = component.find("qcCompButton");
    $A.util.removeClass( qcCompButton , "slds-show" );
    $A.util.addClass( qcCompButton , "slds-hide" );

    var testFindingButton = component.find("testFindingButton");
    $A.util.removeClass( testFindingButton , "slds-show" );
    $A.util.addClass( testFindingButton , "slds-hide" );

    
},

    clickInputParamCancel :function(component, event, helper) {
        component.set( "v.isInputParamEdit" , true );
        component.set( "v.inputParamList",JSON.parse(JSON.stringify( component.get("v.inputParamResetList"))));

        var editInputParam = component.find('editInputParam');
        $A.util.removeClass( editInputParam , "slds-hide" );
        $A.util.addClass( editInputParam , "slds-show" );

        var saveInputParam = component.find('saveInputParam');
        $A.util.removeClass( saveInputParam , "slds-show" );
        $A.util.addClass( saveInputParam , "slds-hide" );
        component.set('v.isAddRow', false);

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-hide" );
        $A.util.addClass( qcCompButton , "slds-show" );
        
        var testFindingButton = component.find("testFindingButton");
        $A.util.removeClass( testFindingButton , "slds-hide" );
        $A.util.addClass( testFindingButton , "slds-show" );
    },

    clickAddInput : function(component, event, helper) {
        //component.set('v.isAddRow', true);
        var newQcInputData = { sobjectType :'QC_Input_Data__c' ,
                            isManual__c: true ,
                            Component_No__c : component.get('v.QcRecord.Id'),
                            Question_Name__c:'',
                            Value__c:'',
                            Comments__c:'' };
        var inputParamList = component.get('v.inputParamList');
        var inputParam = {question: newQcInputData ,picklist:[] };
        inputParamList.push( inputParam ) ;
        component.set('v.inputParamList', inputParamList );

    },

    clickDeleteInputData : function(component, event, helper) {
        var index = event.getSource().get("v.value");
        var inputParamList = component.get('v.inputParamList');
        var deleteInputData = inputParamList[index];
        if (!confirm( "do you wants to delete input Parameter")) {
            return;
        } 
        else {
            if( deleteInputData.question.Id != undefined ){
                var action = component.get('c.deleteInputDataMethod');
                action.setParams({
                    'inputDataRecstr' :  JSON.stringify( deleteInputData.question )
                }); 
                action.setCallback(this,function(response){

                    var state = response.getState();
                    if( state === 'SUCCESS')
                    {
                        var remainingInputData = inputParamList.filter( e => e.question.Id != deleteInputData.question.Id );
                        component.set('v.inputParamList', JSON.parse(JSON.stringify( remainingInputData )));
                        component.set( "v.inputParamResetList",JSON.parse(JSON.stringify( remainingInputData )));
                    }
                });
                $A.enqueueAction(action);
            }
            else{
                var remainingInputData = inputParamList.filter( (item,indexValue) => { return indexValue != index; } );
                
                component.set( "v.inputParamList",JSON.parse(JSON.stringify( remainingInputData )));
                component.set( "v.inputParamResetList",JSON.parse(JSON.stringify( remainingInputData )));
            }
        }

    },

    clickInputParamSave : function(component, event, helper) {
        
        var QcQuestionMList = component.get("v.QcQuestionMList");
        console.log('QcQuestionMList',QcQuestionMList);
        var inputParamList = component.get("v.inputParamList");
        console.log('inputParamList',inputParamList);
        var saveInputParamList = [];
        for(var i =0 ; i< inputParamList.length ; i++)
        {
            var isCompitator = (component.get('v.QcRecord.Sample_Category__c') == 'Competitor Products') ? true : false ;
            if( ! inputParamList[i].question.isManual__c )
            {
                var mQuestion = QcQuestionMList.filter( e => e.Id == inputParamList[i].question.Question__c )[0];
                if(  !isCompitator && mQuestion.IsNumeric__c && inputParamList[i].question.Value__c != undefined &&isNaN(inputParamList[i].question.Value__c ))
                {
                    alert( inputParamList[i].question.Question__r.Question__c +' Value must be numeric');
                    saveInputParamList = [];
                    return ;
                }
                if( !isCompitator && mQuestion.Response_Required__c && (inputParamList[i].question.Value__c == undefined || inputParamList[i].question.Value__c == '')  )
                {
                    alert( 'Please enter value for '+inputParamList[i].question.Question__r.Question__c );
                    saveInputParamList = [];
                    return ;
                }
            }else{
                if( inputParamList[i].question.Question_Name__c == '' )
                {
                    alert( 'Please enter Question Name all Manual records ');
                    return ;
                }
            }
            
            saveInputParamList.push( inputParamList[i].question );
            
        }

        if( component.get('v.QcRecord.Name__c') == 'Case' )
        {
            if( inputParamList.some((item)=>{ return item.question.Value__c == 'Double Side Curved' }) && inputParamList.some((item)=>{ return item.question.Value__c == 'Gasket' }))
            {
                helper.toastMessageHelper( component , event , helper , 'ERROR' , ' If Glass Profile as \"Double Side Curved\" and Glass Fitting* as \"Gasket\" is not allow to save' , '3000', 'info_alt', 'ERROR' , 'dismissible');
                saveInputParamList = [];
                return ;
            }
        }

        if( saveInputParamList.length > 0)
        {
            if (!confirm( "Please provide your consent to refresh Test findings records.")) {
                component.set( "v.inputParamList",JSON.parse(JSON.stringify( component.get("v.inputParamResetList"))));
                return;
            } 
            else {
                helper.saveInputParamHelper(component,event,saveInputParamList,helper);
            }
        }
            

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-hide" );
        $A.util.addClass( qcCompButton , "slds-show" );
        
        var testFindingButton = component.find("testFindingButton");
        $A.util.removeClass( testFindingButton , "slds-hide" );
        $A.util.addClass( testFindingButton , "slds-show" );
    },

    clickTestEdit :function(component, event, helper) {
        component.set( "v.isTestEdit" , false );

        var saveTest = component.find('saveTest');
        $A.util.removeClass( saveTest , "slds-hide" );
        $A.util.addClass( saveTest , "slds-show" );

        var editTest = component.find('editTest');
        $A.util.removeClass( editTest , "slds-show" );
        $A.util.addClass( editTest , "slds-hide" );

        var inputParamButton = component.find("inputParamButton");
        $A.util.removeClass( inputParamButton , "slds-show" );
        $A.util.addClass( inputParamButton , "slds-hide" );

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-show" );
        $A.util.addClass( qcCompButton , "slds-hide" );
    },

    clickTestCancel :function(component, event, helper) {
        component.set( "v.isTestEdit" , true );
        component.set( "v.qcTestList",JSON.parse(JSON.stringify( component.get("v.qcTestResetList") )));
        component.set( "v.batteryTests",JSON.parse(JSON.stringify( component.get("v.batteryResetTests") )));

        var editTest = component.find('editTest');
        $A.util.removeClass( editTest , "slds-hide" );
        $A.util.addClass( editTest , "slds-show" );

        var saveTest = component.find('saveTest');
        $A.util.removeClass( saveTest , "slds-show" );
        $A.util.addClass( saveTest , "slds-hide" );

        var inputParamButton = component.find("inputParamButton");
        $A.util.removeClass( inputParamButton , "slds-hide" );
        $A.util.addClass( inputParamButton , "slds-show" );

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-hide" );
        $A.util.addClass( qcCompButton , "slds-show" );
    },

    clickAddTest : function(component, event, helper) {
        //component.set('v.isAddRow', true);
        var newQcTestData = { sobjectType :'QC_Test_Data__c' ,
                            Test_Name__c : '',
                            Component_Name__c : component.get('v.QcRecord.Id') ,
                            UOM_Input__c : '' ,
                            Specification_Input__c : '',
                            Acceptance_Criteria__c: '',
                            Observation__c : '',
                            Comments_and_Remarks__c : '',
                            Conclusion__c : '',
                            imageurl__c :'',
                            isManual__c  :  true
                            };
        var qcTestList = component.get('v.qcTestList');
        qcTestList.push( newQcTestData ) ;
        component.set('v.qcTestList', qcTestList );

    },

    clickTestSave : function(component, event, helper) {
        
        if( component.get('v.QcRecord.Name__c') != 'Battery' ){
            var qcTestList = component.get("v.qcTestList");
            var saveTestList = [];
            for(var i =0 ; i< qcTestList.length ; i++)
            {
                //var isCompitator = (component.get('v.QcRecord.Sample_Category__c') == 'Competitor Products') ? true : false ;
                if( ! qcTestList[i].isManual__c )
                {

                }else{
                    if( qcTestList[i].Test_Name__c == '' )
                    {
                        alert( 'Please enter Test Name for all Manual records ');
                        return ;
                    }
                }
                
                saveTestList.push( qcTestList[i] );
            }
            if( saveTestList.length > 0)
                helper.saveTestHelper(component,event,helper,saveTestList);
        }else if( component.get('v.QcRecord.Name__c') == 'Battery' ){
            var batteryTests = JSON.parse(JSON.stringify(component.get( 'v.batteryTests')));
            var qcTestList = [...batteryTests.viTests, ...batteryTests.capacityTests , ...batteryTests.leakageTests];
            
            if(qcTestList.length > 0){
                helper.saveTestHelper(component,event,helper,qcTestList);
            }

        }

        var inputParamButton = component.find("inputParamButton");
        $A.util.removeClass( inputParamButton , "slds-hide" );
        $A.util.addClass( inputParamButton , "slds-show" );

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-hide" );
        $A.util.addClass( qcCompButton , "slds-show" );
        
    },

    clickDeleteTest : function (component, event, helper) 
    {
        var index = event.getSource().get("v.value");
        var qcTestList = component.get('v.qcTestList');
        var deleteTestData = qcTestList[index];
        if (!confirm( "do you wants to delete "+ deleteTestData.Test_Name__c +"!")) {
            return;
        } 
        else {
 
            if( deleteTestData.Id != undefined && deleteTestData.Id != '' ){
                var action = component.get('c.deleteTestDataMethod');
                action.setParams({
                    'testDataRecstr' :  JSON.stringify( deleteTestData )
                }); 
                action.setCallback(this,function(response){

                    var state = response.getState();
                    if( state === 'SUCCESS')
                    {
                        var remainingTestData = qcTestList.filter( e => e.Id != deleteTestData.Id );
                        
                        component.set( "v.qcTestList",JSON.parse(JSON.stringify( remainingTestData)));
                        component.set( "v.qcTestResetList",JSON.parse(JSON.stringify( remainingTestData )));

                    }
                });
                $A.enqueueAction(action);
            }
            else{
                var remainingTestData = qcTestList.filter( (item,indexValue) => { return indexValue != index; } );
                component.set( "v.qcTestList",JSON.parse(JSON.stringify( remainingTestData)));
                component.set( "v.qcTestResetList",JSON.parse(JSON.stringify( remainingTestData )));

            }
        }
    },

    onChangePickVal : function (component, event, helper)
    {
        var multivaluePicklistValue = event.getParam('selectedValues');
        var multivaluePicklistName = event.getParam('picklistName');
        var qcInputIndex = event.getParam('questionIndex');
        var inputParamList = component.get("v.inputParamList");
        var a =[];
        var b ;
        for(var i=0 ; i< multivaluePicklistValue.length ;i++)
        {
            a.push( {'label': multivaluePicklistValue[i] ,'value': multivaluePicklistValue[i]});
            if(b == null || b == undefined )
                b = multivaluePicklistValue[i];
            else
                b = b + ','+multivaluePicklistValue[i];
        }
        
        inputParamList[qcInputIndex].question.Value__c = b ;
        component.set("v.inputParamList",inputParamList);
    },

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
                helper.getTestFindingHelper( component,event , helper, qcComponent);
            }
            else if(qcComponent.Name__c == 'Module'){
                helper.getModuleTestFindingHelper( component,event ,helper,qcComponent );
            }
            else if(qcComponent.Name__c == 'Battery'){
                helper.getBatteryTestFindingHelper( component,event , qcComponent );
            }
        }
        else{
            var testFindings = component.find("testFindings");
            $A.util.removeClass( testFindings , 'slds-show' );
            $A.util.addClass( testFindings , 'slds-hide' );
        }
        
    },

    onTestkeyup : function(component,event,helper){
        var value = event.getSource().get("v.value");
        var qcTestList = component.get( 'v.qcTestList');
        var fieldName = event.getSource().get("v.name");
        var rowIndex = event.getSource().get("v.id");
        var observationField = (fieldName == 'After_Test1__c') ? 'Observation1__c' : (fieldName == 'After_Test2__c') ? 'Observation2__c' : (fieldName == 'After_Test3__c') ? 'Observation3__c' : (fieldName == 'After_Test4__c') ? 'Observation4__c' : (fieldName == 'After_Test5__c') ? 'Observation5__c' : ''  ;
        if( value === 'R' || value === 'S' )
        {
            qcTestList[rowIndex][fieldName] = value;
            qcTestList[rowIndex][observationField] = value ;
            component.set( 'v.qcTestList',qcTestList);
            return;
        }else{
            qcTestList[rowIndex][fieldName] = '';
            qcTestList[rowIndex][observationField] = '' ;
            component.set( 'v.qcTestList',qcTestList);
            return;
        }
    },

    onNumkeyup : function(component,event,helper){
        var value = event.getSource().get("v.value");
        var qcTestList = component.get( 'v.qcTestList');
        var fieldName = event.getSource().get("v.name");
        var rowIndex = event.getSource().get("v.id");
        var observationField = (fieldName == 'Initial1__c' || fieldName == 'After_Test1__c') ? 'Observation1__c' : (fieldName == 'Initial2__c' || fieldName == 'After_Test2__c') ? 'Observation2__c' : 
                                (fieldName == 'Initial3__c' || fieldName == 'After_Test3__c') ? 'Observation3__c' : (fieldName == 'Initial4__c' || fieldName == 'After_Test4__c') ? 'Observation4__c' : 
                                (fieldName == 'Initial5__c' || fieldName == 'After_Test5__c') ? 'Observation5__c' : ''  ;
        var initialFName = (fieldName == 'After_Test1__c') ? 'Initial1__c' : (fieldName == 'After_Test2__c' ) ? 'Initial2__c' : 
                            (fieldName == 'After_Test3__c') ? 'Initial3__c' : (fieldName == 'After_Test4__c' ) ? 'Initial4__c' : 
                            (fieldName == 'After_Test5__c') ? 'Initial5__c' : ''  ;
        var afterFName =   (fieldName == 'Initial1__c') ? 'After_Test1__c' : (fieldName == 'Initial2__c' ) ? 'After_Test2__c' : 
                            (fieldName == 'Initial3__c') ? 'After_Test3__c' : (fieldName == 'Initial4__c' ) ? 'After_Test4__c' : 
                            (fieldName == 'Initial5__c') ? 'After_Test5__c' : ''  ;
        if( !isNaN( value ) )
        {
            qcTestList[rowIndex][fieldName] = Number(value).toFixed(2);
            if( initialFName != "" ){
                
                var res  = (qcTestList[rowIndex][fieldName] - qcTestList[rowIndex][initialFName]) != 0 ?  (qcTestList[rowIndex][fieldName] - qcTestList[rowIndex][initialFName]) : (qcTestList[rowIndex][fieldName] == "" && qcTestList[rowIndex][initialFName] == "") ? 'U' : 0 ;
                qcTestList[rowIndex][observationField]  =  isNaN(res) ? '' : Number(res).toFixed(2);
            }else if( afterFName != ""){
                var res =  (qcTestList[rowIndex][afterFName] - qcTestList[rowIndex][fieldName]) != 0 ?  (qcTestList[rowIndex][afterFName] - qcTestList[rowIndex][fieldName]) : (qcTestList[rowIndex][afterFName] == "" && qcTestList[rowIndex][fieldName] == "") ? 'U' : 0 ;
                qcTestList[rowIndex][observationField] = isNaN(res) ? '' : Number(res).toFixed(2);
            }
            
            component.set( 'v.qcTestList',qcTestList);
            return;
        }else{
            qcTestList[rowIndex][fieldName] = '';
            if( initialFName != "" ){
                var res  =  (qcTestList[rowIndex][fieldName] - qcTestList[rowIndex][initialFName]) != 0 ?  (qcTestList[rowIndex][fieldName] - qcTestList[rowIndex][initialFName]) : (qcTestList[rowIndex][fieldName] == "" && qcTestList[rowIndex][initialFName] == "") ? 'U' : 0 ;
                qcTestList[rowIndex][observationField] = isNaN(res) ? '' : Number(res).toFixed(2);
            }else if( afterFName != ""){
                var res   = (qcTestList[rowIndex][afterFName] - qcTestList[rowIndex][fieldName]) != 0 ?  (qcTestList[rowIndex][afterFName] - qcTestList[rowIndex][fieldName]) : (qcTestList[rowIndex][afterFName] == "" && qcTestList[rowIndex][fieldName] == "") ? 'U' : 0 ;
                qcTestList[rowIndex][observationField] = isNaN(res) ? '' : Number(res).toFixed(2);
            }
            component.set( 'v.qcTestList',qcTestList);
            return;
        }
    },

    capacityKeyup : function( component,event,helper)
    {
        var value = event.getSource().get("v.value");
        var rowIndex = event.getSource().get("v.id");
        var inputParamList = component.get("v.inputParamList");
        var capacityTest = component.get('v.batteryTests.capacityTests');
        var capacity = inputParamList.filter( e => e.question.Question_Name__c == 'Capacity(mAh)')[0].question.Value__c ;
        if( !isNaN( value ) )
        {
            capacityTest[rowIndex].Determined_value__c = (value * 100)/capacity;
            if(capacityTest[rowIndex].Determined_value__c == 0)
            {
                capacityTest[rowIndex].Determined_value__c = '';
            }
        }
        else{
            event.getSource().set("v.value" , '');
            capacityTest[rowIndex].Determined_value__c = '';
        }
        component.set( 'v.batteryTests.capacityTests', capacityTest );
    },


    submitRecordForApproval : function( component , event , helper)
    {
        var allQcCompList = component.get('v.allQcCompList');
        var inputParamList = component.get('v.inputParamList');
        allQcCompList = allQcCompList.filter( e => (e.Final_Verdict__c == undefined ||  e.Final_Verdict__c == 'None' || e.Final_Verdict__c == "") );
        if( allQcCompList != undefined && allQcCompList.length == 0)
        {
           
            if( component.get("v.QcRecord.Sample_Category__c")  != 'Competitor Products' )
            {
                var inputParamList = component.get('v.inputParamList');
                let isValueNotMissing = (inputParamList.filter(e => e.question.Question__r.Response_Required__c ).length == 0 || inputParamList.some(e => e.question.Question__r.Response_Required__c && (e.question.Value__c != 'None' && e.question.Value__c != '' && e.question.Value__c != undefined)  ))
                let isChildValueNotMissing = true;
                //isChildValueNotMissing = helper.isAllChildInputMandatoryisFilled( component, event, helper );
                if( isValueNotMissing)
                {
                    var allQcCompList = component.get("v.allQcCompList");
                    var allChildQcCompIdList = allQcCompList.map( e => { if(e.Parent__c != undefined ) return e.Id }).filter( e => e != undefined);
                    if( allChildQcCompIdList.length > 0 )
                    {
                        var action = component.get('c.fetchAllChildCompInputParam');
                        action.setParams({
                            allQcCompIdList : allChildQcCompIdList
                        });
        
                        action.setCallback( this ,function(response){
                            var state = response.getState();
                            if( state === 'SUCCESS')
                            {
                                var QcResponseMList = component.get("v.QcResponseMList");
                                var allQcCompList = component.get("v.allQcCompList");
                                var allChildQcCompIdList = allQcCompList.map( e => { if(e.Parent__c != undefined ) return e.Id }).filter( e => e != undefined);
        
                                var result = JSON.parse(response.getReturnValue());
                                let isChildValueNotMissing = true;
                                for(let i=0 ; i< allChildQcCompIdList.length ; i++ )
                                {
                                    let inputParamList = JSON.parse(result[ allChildQcCompIdList[i] ]);
                                    let flag  = (inputParamList.filter(e => e.Question__r.Response_Required__c ).length == 0 || inputParamList.some(e => e.Question__r.Response_Required__c && (e.Value__c != 'None' && e.Value__c != '' && e.Value__c != undefined)  ))  ;
                                    if( flag == false )
                                    {
                                        isChildValueNotMissing = flag;
                                    }
                                }
                                
                                if(isChildValueNotMissing)
                                {
                                    helper.submitForApprovalProcess(component,event,helper);
                                }else{
                                    alert('Please Enter mandatory input parameters');
                                    return;
                                }
        
                            }
                        });
                        $A.enqueueAction(action);
                    }else{
                        helper.submitForApprovalProcess(component,event,helper);
                    }
                    
                }else{
                    alert('Please Enter mandatory input parameters');
                    return;
                }
            }else{
                helper.submitForApprovalProcess(component,event,helper);
            }
        }else{
            alert("fill all verdicts")
            return ;
        }
        
    },

    imageupload : function( component , event , helper)
    {
        debugger;
        var uploadedFiles = event.getParam("files")[0];
        
        var imageUrl = '/sfc/servlet.shepherd/version/download/'+uploadedFiles.contentVersionId ;
        var imageFieldName = event.getSource().get("v.name");
        var qcComp = component.get('v.QcRecord');
        qcComp[imageFieldName] = imageUrl ;
        component.set('v.QcRecord',qcComp);
        var action = component.get('c.updatePicturePath');
        debugger;
        //set parametrs
        action.setParams({
            rec : JSON.stringify(component.get('v.QcRecord'))
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state === 'DRAFT') {
                
                var data = response.getReturnValue();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'image uploaded',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
    },

    imageuploadToTest : function( component , event , helper)
    {
        debugger;
        var uploadedFiles = event.getParam("files")[0];
        
        var imageUrl = '/sfc/servlet.shepherd/version/download/'+uploadedFiles.contentVersionId ;
        var index = event.getSource().get("v.name");
        var qcTestList = component.get('v.qcTestList');
        qcTestList[index]["imageurl__c"] = imageUrl ;
        component.set('v.qcTestList',qcTestList);
        // var action = component.get('c.updatePicturePath');
        // debugger;
        // //set parametrs
        // action.setParams({
        //     rec : JSON.stringify(component.get('v.QcRecord'))
        // });
        
        // action.setCallback(this, function(response){
        //     var state = response.getState();
        //     if(state === 'SUCCESS' || state === 'DRAFT') {
                
        //         var data = response.getReturnValue();
        //         var toastEvent = $A.get("e.force:showToast");
        //         toastEvent.setParams({
        //             title : 'Success',
        //             message: 'image uploaded',
        //             duration:' 5000',
        //             key: 'info_alt',
        //             type: 'success',
        //             mode: 'dismissible'
        //         });
        //         toastEvent.fire();
        //     }
        // });
        
        // $A.enqueueAction(action);
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
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Leather-Strap'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Dial'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Metal-Strap'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Special-Strap'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Battery'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Packaging'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }else if(qcCompName == 'Module'){
            window.open('/apex/QC_FullWatchDetailedReport?id='+ component.get('v.QcRecord.Id') );
        }
    },

    allTestfindingReport : function( component , event , helper){
        var qcCompName = component.get("v.QcRecord.Name__c");
        if( qcCompName == 'Full-Watch' )
            window.open('/apex/QC_AllTestFindingSummaryReport?id='+ component.get('v.QcRecord.Id') );
        else if( qcCompName == 'Watch-Head')
            window.open('/apex/QC_AllTestFindingSummaryReportWH?id='+ component.get('v.QcRecord.Id') );
    },


    onInputValuechange : function( component, event, helper ){
        var QcMasterMList = component.get("v.QcMasterMList");
        console.log('QcMasterMList::::',QcMasterMList);
        var QcQuestionMList = component.get("v.QcQuestionMList");
        console.log('QcQuestionMList::::',QcQuestionMList);
        var QcResponseMList = component.get("v.QcResponseMList");
        console.log('QcResponseMList::::',QcResponseMList);
        var QcConditionMList = component.get("v.QcConditionMList");
        console.log('QcConditionMList::::',QcConditionMList);
        var questionValue = event.getSource().get('v.value');
        console.log('questionValue:::::',questionValue);
        var questionItem = event.getSource().get('v.name');
        console.log('qcCond::::',qcCond);
        var qcCond = QcConditionMList.filter( e => e.Response__r != undefined && e.Response__r.Response__c == questionValue && e.Response__r.Question__c == questionItem.Question__c && e.RecordType.Name == 'Question Condition' && e.Question__c != undefined && e.Question__r.Component_Type__c == component.get("v.QcRecord.Name__c") )[0];
        console.log('qcCond::::',qcCond);
        if(qcCond != undefined && qcCond.Id != undefined ){
            var qcQuest = QcQuestionMList.filter( e => e.Id == qcCond.Question__c )[0];
            var inputParamList = component.get("v.inputParamList").map( (item) => { return item.question } );
            console.log('inputParamList',inputParamList);
            if( ! inputParamList.some((item) => { return item.Question__c == qcQuest.Id}))
            {
                var newQcInputData = { sobjectType :'QC_Input_Data__c' ,
                                isManual__c: false ,
                                Component_No__c : component.get('v.QcRecord.Id'),
                                Question_Name__c:'',
                                Question__c : qcQuest.Id ,
                                Question__r: {Question__c : qcQuest.Question__c ,Type__c : qcQuest.Type__c, Question_Unique_No__c : qcQuest.Question_Unique_No__c,Order_Number__c:qcQuest.Order_Number__c},
                                Value__c:'',
                                Comments__c:'' 
                            };
                
                var inputParam = {question: newQcInputData ,picklist:[] };
                var qcResponseList = QcResponseMList.filter( e=> e.Question__c == newQcInputData.Question__c);
                
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
                var newinputPlist = component.get("v.inputParamList");
                newinputPlist.push( inputParam );
                //newinputPlist.sort((a,b)=>{ return a.question.Question__r.Question_Unique_No__c - b.question.Question__r.Question_Unique_No__c });
                newinputPlist.sort((a,b)=>{ return a.question.Question__r.Order_Number__c - b.question.Question__r.Order_Number__c });
                component.set("v.inputParamList", JSON.parse(JSON.stringify(newinputPlist )));
            }
        }
    }*/
})