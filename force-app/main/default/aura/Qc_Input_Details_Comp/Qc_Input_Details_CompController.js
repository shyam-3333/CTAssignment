({
  /*  doinit : function(component, event, helper) {
    
        var baseUrl = window.location.hostname;
        component.set("v.baseUrl","https://"+baseUrl);
        
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set('v.today', today); 

         component.set('v.showApprovalHistroy',true);
         component.set('v.qcCompResetObj',JSON.parse(JSON.stringify(component.get("v.qcComponent"))));
         
        var brand = component.get("v.qcComponent.Brand__c");
        var vendor = component.get("v.qcComponent.Vendor__c");
        let qcMaster = component.get('v.QcMasterMList');

        var selectedBrand = qcMaster.filter( e => e.Id == brand )[0];
        var selectedVendor = qcMaster.filter( e => e.Id == vendor )[0];
        component.set("v.seleteBrandLookup", selectedBrand );
        component.set("v.seleteVendorLookup", selectedVendor );
        component.set("v.showLookupfields", true );

        var masterVarient = component.get("v.qcComponent.Master_Variant__c");
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
                component.set("v.qcComponent.Brand__c", recordByEvent.Id );
			    component.set("v.qcComponent.Brands__c", recordByEvent.Name );
			    helper.dependentClusterAddition( component, event , component.get("v.qcComponent.Brands__c") );
			    return;
		    }
			else{
                component.set("v.seleteBrandLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
				component.set("v.qcComponent.Brand__c", '' );
			    component.set("v.qcComponent.Brands__c", '' );
			    component.set('v.ClusterList',[]);
			    return;
		    }
		}
		if(label == 'Vendor' )
		{
			if( recordByEvent != null ){
			    component.set("v.seleteVendorLookup", recordByEvent );
			    component.set("v.qcComponent.Vendor__c", recordByEvent.Id );
			    return;
		    }
			else{
				component.set("v.seleteVendorLookup", {'sobjectType' : 'QC_Master__c','Id':'','Name':''} );
				component.set("v.qcComponent.Vendor__c", '' );
			    return;
		    }
		}
        
    },

    changeBrand : function(component, event, helper) {
        debugger;
        var qcComp = JSON.parse(JSON.stringify(component.get("v.qcComponent")))  ;
        var brandId = qcComp.Brand__c[0];
        if( brandId == undefined ){
            component.set("v.qcComponent.Brands__c", '' );
            return;
        }
        var action = component.get("c.getBrandName");
        action.setParams({
            "brandId" : brandId
        });
        action.setCallback(this,function(Response){
            var state = Response.getState();
            if(state === "SUCCESS")
            {
                var result = Response.getReturnValue();
                component.set("v.qcComponent.Brands__c",result);
                debugger;
            }
        });
        $A.enqueueAction(action);
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
    },

    clickQcCompSave : function(component, event, helper) {
        
        var qcComponent = component.get('v.qcComponent');
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
                childComponentList[i] =  child  ;
                qcCompList.push( child );

            }
            helper.saveChildQcCompRecordHelper( component, event, qcCompList ,helper);
        }
        else{
            var action = component.get("c.saveIndividualQcComp");
            action.setParams({
                qcComp : JSON.stringify(qcComponent)
            });

            action.setCallback( this , function(response){
                var state = response.getState();
                if(state === 'SUCCESS')
                {
                    alert("Qc Component is Saved");
                }else{
                    let errorResult = (response.getError()).map((item,index)=>{
                        return item.message;
                        });
                        alert(JSON.stringify(errorResult));
                }
            });
            $A.enqueueAction(action);
        }
        
    },

    clickQcCompCancel : function(component, event, helper) {
        component.set( "v.isQcCompEdit" , true );
        let qcComp = JSON.parse(JSON.stringify(component.get("v.qcCompResetObj")));
        component.set('v.qcComponent', qcComp );
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
    },

    clickAddInput : function(component, event, helper) {
        //component.set('v.isAddRow', true);
        var newQcInputData = { sobjectType :'QC_Input_Data__c' ,
                               isManual__c: true ,
                               Component_No__c : component.get('v.qcComponent.Id'),
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
                
                component.set('v.inputParamList', JSON.parse(JSON.stringify( remainingInputData )));
                component.set( "v.inputParamResetList",JSON.parse(JSON.stringify( remainingInputData )));
            }
        }
    },

    clickInputParamSave : function(component, event, helper) {
        
        var QcQuestionMList = component.get("v.QcQuestionMList");
        var inputParamList = component.get("v.inputParamList");
        var saveInputParamList = [];
        for(var i =0 ; i< inputParamList.length ; i++)
        {
            var isCompitator = (component.get('v.qcComponent.Sample_Category__c') == 'Competitor Products') ? true : false ;
            if( ! inputParamList[i].question.isManual__c )
            {
                var mQuestion = QcQuestionMList.filter( e => e.Id == inputParamList[i].question.Question__c )[0];
                if(  !isCompitator && mQuestion.IsNumeric__c && inputParamList[i].question.Value__c != undefined &&isNaN(inputParamList[i].question.Value__c ))
                {
                    alert( inputParamList[i].question.Question__r.Question__c +' Value must be numeric');
                    saveInputParamList = [];
                    return ;
                }
                if( !isCompitator && mQuestion.Response_Required__c && (inputParamList[i].question.Value__c == "None" || inputParamList[i].question.Value__c == undefined || inputParamList[i].question.Value__c == '')  )
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

        if( component.get('v.qcComponent.Name__c') == 'Case' )
        {
            if( inputParamList.some((item)=>{ return item.question.Value__c == 'Double Side Curved' }) && inputParamList.some((item)=>{ return item.question.Value__c == 'Gasket' }))
            {
                helper.toastMessageHelper( component , event , helper , 'ERROR' , ' If Glass Profile as \"Double Side Curved\" and Glass Fitting* as \"Gasket\" is not allow to save' , '3000', 'info_alt', 'ERROR' , 'dismissible');
                saveInputParamList = [];
                return ;
            }
        }
        if( saveInputParamList.length > 0)
            helper.saveInputParamHelper(component,event,saveInputParamList, helper);

        var qcCompButton = component.find("qcCompButton");
        $A.util.removeClass( qcCompButton , "slds-hide" );
        $A.util.addClass( qcCompButton , "slds-show" );
    },

// this methods is used to collect multivalue picklist From MultivaluePicklistEvent
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

    submitRecordForApproval : function(component, event, helper) {
        
        
        if( component.get("v.qcComponent.Sample_Category__c")  != 'Competitor Products' )
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
                    var action = component.get("c.fetchAllChildCompInputParam");
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
                            console.log('I am in if::');
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
       
        
    }, 

    imageupload : function( component , event , helper)
    {
        debugger;
        var uploadedFiles = event.getParam("files")[0];
        
        var imageUrl = '/sfc/servlet.shepherd/version/download/'+uploadedFiles.contentVersionId ;
        var imageFieldName = event.getSource().get("v.name");
        var qcComp = component.get('v.qcComponent');
        qcComp[imageFieldName] = imageUrl ;
        component.set('v.qcComponent',qcComp);
        var action = component.get('c.updatePicturePath');
        debugger;
        //set parametrs
        action.setParams({
            rec : JSON.stringify(component.get('v.qcComponent'))
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

    onInputValuechange : function( component, event, helper )
    {
        var QcMasterMList = component.get("v.QcMasterMList");
        var QcQuestionMList = component.get("v.QcQuestionMList");
        var QcResponseMList = component.get("v.QcResponseMList");
        var QcConditionMList = component.get("v.QcConditionMList");
        var questionValue = event.getSource().get('v.value');
        var questionItem = event.getSource().get('v.name');

        var qcCond = QcConditionMList.filter( e => e.Response__r != undefined && e.Response__r.Response__c == questionValue && e.Response__r.Question__c == questionItem.Question__c && e.RecordType.Name == 'Question Condition' && e.Question__c != undefined && e.Question__r.Component_Type__c == component.get("v.qcComponent.Name__c") )[0];
        
        if(qcCond != undefined && qcCond.Id != undefined )
        {
            var qcQuest = QcQuestionMList.filter( e => e.Id == qcCond.Question__c )[0];
            var inputParamList = component.get("v.inputParamList").map( (item) => { return item.question } );
            if( ! inputParamList.some((item) => { return item.Question__c == qcQuest.Id}))
            {
                var newQcInputData = { sobjectType :'QC_Input_Data__c' ,
                            isManual__c: false ,
                            Component_No__c : component.get('v.qcComponent.Id'),
                            Question_Name__c:'',
                            Question__c : qcQuest.Id ,
                            Question__r: {Question__c : qcQuest.Question__c ,Type__c : qcQuest.Type__c, Question_Unique_No__c : qcQuest.Question_Unique_No__c , Order_Number__c:qcQuest.Order_Number__c},
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
        

    } */

})