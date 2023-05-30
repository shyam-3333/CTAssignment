({
    
  /*  fetchAllMaster : function( component, event, helper) {
        var action = component.get('c.fetchallMasterData');
        action.setCallback(this,function(response){
            var state = response.getState();
            if( state == 'SUCCESS' )
            {
                var result = JSON.parse(response.getReturnValue());
                for(var i=0 ;i < result.length ; i++)
                {
                  if(result[i].sobjectType == 'QC_Master__c' ){
                     component.set("v.QcMasterMList", result[i].sobjectList );
                  }
                  else if(result[i].sobjectType == 'QC_Question__c' ){
                      component.set("v.QcQuestionMList", result[i].sobjectList );
                  }
                  else if(result[i].sobjectType == 'QC_Response__c' ){
                     component.set("v.QcResponseMList", result[i].sobjectList );
                  }
                  else if(result[i].sobjectType == 'QC_Condition__c' ){
                    component.set("v.QcConditionMList", result[i].sobjectList );
                  }
                }

            }
        });
        $A.enqueueAction(action);
    },*/

  /*  saveFW_WHComphelper : function( component , event , helper){

        var QcMasterMList = component.get("v.QcMasterMList");
        var QcQuestionMList = component.get("v.QcQuestionMList");
        var QcResponseMList = component.get("v.QcResponseMList");
        var QcConditionMList = component.get("v.QcConditionMList");
        var qcComponent = component.get("v.QcComp");
        var childCompNamelist = component.get("v.childCompNamelist");
        var saveData = {
            parentDetail:{
                qcComp: {},*/
          //      inputParam : [] /*,
             //   testData : [] */
          /*  },
            childsDetail :[]
        };
        if(  qcComponent.Master__c )
        {
            var isCompitator = (qcComponent.Sample_Category__c == 'Competitor Products') ? true : false ;
            var inputParamMlist = isCompitator ? QcQuestionMList.filter(e => e.Component_Type__c == qcComponent.Name__c && e.RecordType.Name == 'Question' && e.Onload__c == true   )
            : QcQuestionMList.filter(e => e.Component_Type__c == qcComponent.Name__c && e.RecordType.Name == 'Question' && e.Onload__c == true && e.Competitor_Products__c == isCompitator  );
            var inputParamNewlist = [];
            for( var i = 0 ;i < inputParamMlist.length ; i++ )
            {
                var inputParam = {
                    Component_No__c : '',
                    Question__c : inputParamMlist[i].Id ,
                    Question_Name__c : inputParamMlist[i].Question__c
                };
                inputParamNewlist.push( inputParam );
            }*/
            /*
            var brandCondtionlist = [];
            brandCondtionlist = (QcConditionMList.filter( e => e.Brand__c == qcComponent.Brand__c && e.Component_Type__c == qcComponent.Name__c ));
            var compCondtionlist = [];
            compCondtionlist = ( QcConditionMList.filter( e => e.Component_Type__c == qcComponent.Name__c &&  e.Onload__c == true && e.RecordType.Name == 'Test Condition'  ));
            
            var allCondList = brandCondtionlist.concat( compCondtionlist );
            var testList =[];
            for( var i=0 ; i < allCondList.length ; i++ )
            {
                var testData = {
                    Component_Name__c : '',
                    Condition_Ref__c: allCondList[i].Id ,
                    Test_Name__c : QcQuestionMList.filter(e => e.Id == allCondList[i].Question__c)[0].Test_Name__c
                }
                testList.push(testData);
            }
            */
          /*  saveData.parentDetail.qcComp = qcComponent;
            saveData.parentDetail.inputParam = inputParamNewlist;
            //saveData.parentDetail.testData = testList;

            for(var i=0 ; i< childCompNamelist.length ; i++)
            {
                if(childCompNamelist[i] != null )
                {
                    var inputChildParamMlist = isCompitator ? QcQuestionMList.filter(e => e.Component_Type__c == childCompNamelist[i] && e.RecordType.Name == 'Question' && e.Onload__c == true ):
                    QcQuestionMList.filter(e => e.Component_Type__c == childCompNamelist[i] && e.RecordType.Name == 'Question' && e.Onload__c == true && e.Competitor_Products__c == isCompitator );
                    var inputChildParamNewlist = [];

                    for( var j = 0 ;j < inputChildParamMlist.length ; j++ )
                    {
                        var inputParam = {
                            Component_No__c : '',
                            Question__c : inputChildParamMlist[j].Id ,
                            Question_Name__c : inputChildParamMlist[j].Question__c
                        };
                        inputChildParamNewlist.push( inputParam );
                    }*/
                    /*
                    var brandChildCondtionlist = [];
                    brandChildCondtionlist = (QcConditionMList.filter( e => e.Brand__c == qcComponent.Brand__c && e.Component_Type__c == childCompNamelist[i] ));
                    var compChildCondtionlist = [];
                    compChildCondtionlist = (QcConditionMList.filter( e => e.Component_Type__c == childCompNamelist[i] &&  e.Onload__c == true && e.RecordType.Name == 'Test Condition'  ));
                    
                    var allChildCondList = brandChildCondtionlist.concat( compChildCondtionlist );
                    var testList =[];
                    for( var j=0 ; j < allChildCondList.length ; j++ )
                    {
                        var testData = {
                            Component_Name__c : '',
                            Condition_Ref__c: allChildCondList[j].Id ,
                            Test_Name__c : QcQuestionMList.filter(e => e.Id == allChildCondList[j].Question__c)[0].Test_Name__c
                        }
                        testList.push(testData);
                    }
                    */
                    
                   /* var childComp;
                    childComp = JSON.parse(JSON.stringify(qcComponent));
                    childComp.Name__c = childCompNamelist[i];*/
                  //  saveData.childsDetail.push( { qcComp : childComp ,inputParam : inputChildParamNewlist /*,testData : testList */});
                    //component.set( "v.saveData" , JSON.parse(JSON.stringify(saveData) ));
               // }
        //    }
            
            
         /*   var action = component.get("c.saveNewFWOrWHComponent");
            action.setParams({
                "newFWOrWHData" : JSON.stringify(saveData)
            });
            action.setCallback( this , function(response){
                var state = response.getState();
                if( state === 'SUCCESS' )
                {
                    var result = JSON.parse( response.getReturnValue() );
                    component.set( "v.savedData" , result);
                    var parentRec=[];
                    parentRec.push( result.parentDetail.qcComp ) ;
                    var childCompList = [];
                    for( var i = 0 ; i< result.childsDetail.length ; i++)
                    {
                        childCompList.push( result.childsDetail[i].qcComp );
                    }

                    var allCompList = parentRec.concat( childCompList );
                    component.set("v.allCompList", allCompList );
                    var selectRecordPage = component.find("selectRecordPage");
                    $A.util.removeClass( selectRecordPage , "slds-hide");
                    $A.util.addClass( selectRecordPage , "slds-show");

                    var selectTypesPage = component.find("selectTypesPage");
                    $A.util.removeClass( selectTypesPage , "slds-show");
                    $A.util.addClass( selectTypesPage , "slds-hide");
                }else{
                    let errorResult = (response.getError()).map((item,index)=>{
                    return item.message;
                    });
                    alert(JSON.stringify(errorResult));
                }
            });
            $A.enqueueAction(action); 
        }
        else if( qcComponent.Master_Variant__c != null  )
        {
            
            var masterVarientComp = component.get( "v.masterVarientComp" );
            qcComponent.Brand__c = masterVarientComp.parentDetail.qcComp.Brand__c ;
            qcComponent.Brands__c = masterVarientComp.parentDetail.qcComp.Brands__c ;
            qcComponent.Vendor__c = masterVarientComp.parentDetail.qcComp.Vendor__c ;
            saveData.parentDetail.qcComp = qcComponent ;
            var parentInputdata = masterVarientComp.parentDetail.inputParam;
            for( var i =0 ; i < parentInputdata.length ; i++ )
            {
                parentInputdata[i].Id = '' ;
                parentInputdata[i].Component_No__c = '' ;
            }
            saveData.parentDetail.inputParam = parentInputdata;

            var childCompNamelist = component.get( "v.childCompNamelist" );
            var copiedMVchildComp = component.get( "v.copyMstrVarientChildCompList" );

            var childQcCompDetails = masterVarientComp.childsDetail ;
            for( var i =0 ; i < childCompNamelist.length ; i++ )
            {
                if(  JSON.stringify(copiedMVchildComp).includes( childCompNamelist[i]))
                {
                    var child = childQcCompDetails.filter( e => e.qcComp.Name__c == childCompNamelist[i] )[0];
                    var childComp;
                    childComp = JSON.parse(JSON.stringify(qcComponent));
                    childComp.Name__c = childCompNamelist[i];
                    childComp.IsCopied_From_Master__c = true;
                    var inputChildParamNewlist = child.inputParam;
                    for( var j = 0 ;j< inputChildParamNewlist.length ; j++ )
                    {
                        inputChildParamNewlist[j].Id = '' ;
                        inputChildParamNewlist[j].Component_No__c = '' ;
                    }
                    saveData.childsDetail.push( { qcComp : childComp ,inputParam : inputChildParamNewlist });

                }else{
                    var isCompitator = (qcComponent.Sample_Category__c == 'Competitor Products') ? true : false ;
                    var inputChildParamMlist = isCompitator ? QcQuestionMList.filter(e => e.Component_Type__c == childCompNamelist[i] && e.RecordType.Name == 'Question' && e.Onload__c == true  ):
                                                            QcQuestionMList.filter(e => e.Component_Type__c == childCompNamelist[i] && e.RecordType.Name == 'Question' && e.Onload__c == true && e.Competitor_Products__c == isCompitator );
                    var inputChildParamNewlist = [];

                    for( var j = 0 ;j < inputChildParamMlist.length ; j++ )
                    {
                        var inputParam = {
                            Component_No__c : '',
                            Question__c : inputChildParamMlist[j].Id ,
                            Question_Name__c : inputChildParamMlist[j].Question__c
                        };
                        inputChildParamNewlist.push( inputParam );
                    }
                    var childComp;
                    childComp = JSON.parse(JSON.stringify(qcComponent));
                    childComp.Name__c = childCompNamelist[i];
                    saveData.childsDetail.push( { qcComp : childComp ,inputParam : inputChildParamNewlist });
                }
            }

            var action = component.get("c.saveNewFWOrWHComponent");
            action.setParams({
                "newFWOrWHData" : JSON.stringify(saveData)
            });
            action.setCallback( this , function(response){
                var state = response.getState();
                if( state === 'SUCCESS' )
                {
                    var result = JSON.parse( response.getReturnValue() );
                    component.set( "v.savedData" , result);
                    var parentRec=[];
                    parentRec.push( result.parentDetail.qcComp ) ;
                    var childCompList = [];
                    for( var i = 0 ; i< result.childsDetail.length ; i++)
                    {
                        childCompList.push( result.childsDetail[i].qcComp );
                    }

                    var allCompList = parentRec.concat( childCompList );
                    component.set("v.allCompList", allCompList );
                    var selectRecordPage = component.find("selectRecordPage");
                    $A.util.removeClass( selectRecordPage , "slds-hide");
                    $A.util.addClass( selectRecordPage , "slds-show");

                    var selectTypesPage = component.find("selectTypesPage");
                    $A.util.removeClass( selectTypesPage , "slds-show");
                    $A.util.addClass( selectTypesPage , "slds-hide");
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

    newWatchCompSaveHelper : function( component, event, helper, watchComp ){
        var QcMasterMList = component.get("v.QcMasterMList");
        var QcQuestionMList = component.get("v.QcQuestionMList");
        var QcResponseMList = component.get("v.QcResponseMList");
        var QcConditionMList = component.get("v.QcConditionMList");
        var qcComp = component.get("v.QcComp");
        var saveData = {
            parentDetail:{
                qcComp: {},
                inputParam : []
            },
            childsDetail :[]
        };
        if( watchComp != null || watchComp != undefined)
        {
            var isCompitator = (qcComp.Sample_Category__c == 'Competitor Products') ? true : false ;
            var inputParamMlist = isCompitator ? QcQuestionMList.filter(e => e.Component_Type__c == watchComp && e.RecordType.Name == 'Question' && e.Onload__c == true   )
             : QcQuestionMList.filter(e => e.Component_Type__c == watchComp && e.RecordType.Name == 'Question' && e.Onload__c == true && e.Competitor_Products__c == isCompitator  );
            var inputParamNewlist = [];
            for( var i = 0 ;i < inputParamMlist.length ; i++ )
            {
                var inputParam = {
                    Component_No__c : '',
                    Question__c : inputParamMlist[i].Id ,
                    Question_Name__c : inputParamMlist[i].Question__c
                };
                inputParamNewlist.push( inputParam );
            }

            var singleComp;
            singleComp = JSON.parse(JSON.stringify(qcComp));
            singleComp.Name__c = watchComp;
            saveData.parentDetail.qcComp = singleComp;
            saveData.parentDetail.inputParam = inputParamNewlist;

            var action = component.get("c.saveNewWatchComponent");
            action.setParams({
                "newWatchComponentData" : JSON.stringify(saveData)
            });
            action.setCallback( this , function(response){
                var state = response.getState();
                if( state === 'SUCCESS' )
                {
                    var result = JSON.parse( response.getReturnValue() );
                    component.set( "v.savedData" , result);
                    var parentRec=[];
                    parentRec.push( result.parentDetail.qcComp ) ;

                    component.set("v.allCompList", parentRec );
                    var selectRecordPage = component.find("selectRecordPage");
                    $A.util.removeClass( selectRecordPage , "slds-hide");
                    $A.util.addClass( selectRecordPage , "slds-show");

                    var selectTypesPage = component.find("selectTypesPage");
                    $A.util.removeClass( selectTypesPage , "slds-show");
                    $A.util.addClass( selectTypesPage , "slds-hide");

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

    checkRecorIsLoak : function(component,event,helper, checkId){
        var action=component.get('c.isRecordSubmitForApproval');
        action.setParams({
            'recordId': checkId
        });
        action.setCallback(this,(response)=>{
            if(response.getState()==="SUCCESS"){
                let result= response.getReturnValue();
                component.set('v.isRecordLock',result);
            }
        });
        $A.enqueueAction(action); 
    }*/
})