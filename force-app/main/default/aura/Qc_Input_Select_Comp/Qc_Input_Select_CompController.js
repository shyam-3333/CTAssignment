({
    /*doinit : function(component, event, helper) {
        //helper.fetchPickListValues(component, event , helper);
        helper.fetchAllMaster(component, event , helper);
    },

    showSpinner: function(component) {
    var spinnerMain =  component.find("Spinner");
    $A.util.removeClass(spinnerMain, "slds-hide");
    },
    
    hideSpinner : function(component) {
    var spinnerMain =  component.find("Spinner");
    $A.util.addClass(spinnerMain, "slds-hide");
    },

    changeBrand : function(component, event, helper) {
        debugger;
        var brandId = component.get("v.QcComp").Brand__c[0];
        var action = component.get("c.getBrandName");
        action.setParams({
            "brandId" : brandId
        });
        action.setCallback(this,function(Response){
            var state = Response.getState();
            if(state === "SUCCESS")
            {
                var result = Response.getReturnValue();
                component.set("v.QcComp.Brands__c",result);
                debugger;
            }
        });
        $A.enqueueAction(action);
     },

     changeMasterVarient : function( component, event ,helper)
     {
        var qcComp = component.get("v.QcComp");

        if( qcComp.Master_Variant__c[0] != undefined && qcComp.Master_Variant__c[0] != null && qcComp.Master_Variant__c[0] != '')
        {
            var master = component.find( "masterDiv" );
            $A.util.removeClass(master, "slds-show");
            $A.util.addClass(master, "slds-hide");
            component.set("v.QcComp.Master__c", false );

            
        }
        else{
            var master = component.find( "masterDiv" );
            $A.util.removeClass(master, "slds-hide");
            $A.util.addClass(master, "slds-show");
            component.set("v.QcComp.Master__c", false );

        }
        component.set( 'v.displayMstrVarientChildCompList', []);
        component.set( 'v.copyMstrVarientChildCompList', []);

        var childCompNamelist = component.get("v.childCompNamelist");
        for(var i =0 ; i< childCompNamelist.length ; i++)
        {
            document.getElementById(childCompNamelist[i]).checked = false ;
        }
        component.set("v.childCompNamelist",[]); 

        if(  qcComp.Master_Variant__c[0] != undefined  && qcComp.Master_Variant__c[0] != null  )
        {
            var action = component.get("c.getQcComponentPack");
            action.setParams({
                "recId" : qcComp.Master_Variant__c[0] 
            });
            action.setCallback( this , function(response){
                var state = response.getState();
                if( state === 'SUCCESS' )
                {
                    var result = response.getReturnValue();
                    var masterVarientComp = JSON.parse( result );
                    component.set( 'v.masterVarientComp',  masterVarientComp );
                    var masterVParentComp = masterVarientComp.parentDetail ;
                    var masterVChildComp = masterVarientComp.childsDetail ;
                    var masterVChildName = [];
                    for( var i =0 ; i < masterVChildComp.length ; i++ )
                    {
                        masterVChildName.push(  masterVChildComp[i].qcComp.Name__c ); 
                    }
                    component.set('v.masterVarientCompList', masterVChildName );
                    
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

     changeMaster : function( component, event ,helper)
     {
        var qcComp = JSON.parse(JSON.stringify(component.get("v.QcComp")));
        var check = event.target.checked;
        if( check != undefined && check != null && check != false)
        {
            var masterVariant = component.find( "masterVariant" );
            $A.util.removeClass(masterVariant, "slds-show");
            $A.util.addClass(masterVariant, "slds-hide");
            qcComp.Master_Variant__c = "";
            qcComp.Master__c = check;
            component.set("v.QcComp",qcComp);
        }
        else{

          var masterVariant = component.find( "masterVariant" );
            $A.util.removeClass(masterVariant, "slds-hide");
            $A.util.addClass(masterVariant, "slds-show");
            qcComp.Master_Variant__c = "";
            qcComp.Master__c = check;
            component.set("v.QcComp",qcComp);
        }
     },

     selectLookupRec : function( component, event ,helper){
        var seectedRecId = event.getParam('customId');
        var recordByEvent = event.getParam('recordByEvent');
        component.set("v.seletedRecForUpdateOrResubId", recordByEvent );

     },

     changeSampleCat : function( component, event ,helper){
        var resetQcComp = {sobjectType: "QC_Components__c", Master__c: false};
        var qcComp = component.get("v.QcComp");
        var sampcat = qcComp.Sample_Category__c ;
        qcComp = resetQcComp;
        qcComp.Sample_Category__c = sampcat ;

        component.set("v.QcComp", qcComp );
        component.set("v.seletedRecForUpdateOrResub",null);
        component.set("v.childCompNamelist",[]);
        component.set( 'v.displayMstrVarientChildCompList', []);
        component.set( 'v.copyMstrVarientChildCompList', []);
        var sampletype = component.find('sampletype');
        $A.util.removeClass(sampletype ,'slds-hide');
        $A.util.addClass(sampletype ,'slds-show');

        var refNumLookup = component.find('refNumLookup');
        $A.util.removeClass(refNumLookup ,'slds-show');
        $A.util.addClass(refNumLookup ,'slds-hide');

     },
     changeSampleType : function( component, event ,helper){
        var qcComp = component.get('v.QcComp');
        var resetQcComp = {sobjectType: "QC_Components__c", Master__c: false, Name__c : qcComp.Name__c , Sample_Category__c :qcComp.Sample_Category__c};
        
        var compName = qcComp.Name__c;
        if( compName != 'Watch-Component' )
        {
            let nameCondition = qcComp.Sample_Category__c != 'Re-Submission' ? ' Name__c=\''+compName+'\' And  Document_Status__c = \'Draft\' and Component_Status__c != \'Obsolete\' ' : ' Name__c=\''+compName+'\' And  Document_Status__c = \'Published\' and Component_Status__c != \'Obsolete\''  ;
            component.set("v.nameCondition" ,  nameCondition );
            
        }
        else{
            let nameCondition = qcComp.Sample_Category__c != 'Re-Submission' ? ' Name__c != \'Full-Watch\' And Name__c != \'Watch-Head\' And  Document_Status__c = \'Draft\' and Component_Status__c != \'Obsolete\' ' : ' Name__c != \'Full-Watch\'  And Name__c != \'Watch-Head\' And  Document_Status__c = \'Published\' and Component_Status__c != \'Obsolete\' '  ;
            component.set("v.nameCondition" ,nameCondition);
        }

        if((qcComp.Sample_Category__c == 'Update' || qcComp.Sample_Category__c == 'Re-Submission' ) )
        {
            var refNumLookup = component.find('refNumLookup');
            $A.util.removeClass(refNumLookup ,'slds-hide');
            $A.util.addClass(refNumLookup ,'slds-show');
        }
        else if( (qcComp.Sample_Category__c != 'Update' && qcComp.Sample_Category__c != 'Re-Submission' && (qcComp.Name__c == 'Full-Watch' || qcComp.Name__c == 'Watch-Head') ) )
        {
            var newFullWatchRec = component.find('newFullWatchRec');
            $A.util.removeClass(newFullWatchRec ,'slds-hide');
            $A.util.addClass(newFullWatchRec ,'slds-show');
        }else if(  (qcComp.Sample_Category__c != 'Update' && qcComp.Sample_Category__c != 'Re-Submission' && qcComp.Name__c == 'Watch-Component'  )  )
        {
            var newWatchCompRec = component.find('newWatchCompRec');
            $A.util.removeClass(newWatchCompRec ,'slds-hide');
            $A.util.addClass(newWatchCompRec ,'slds-show');
        }

        qcComp = JSON.parse(JSON.stringify(resetQcComp));
        component.set("v.QcComp", qcComp );
        component.set("v.seletedRecForUpdateOrResub",null);
        var childCompNamelist = component.get("v.childCompNamelist");
        for(var i =0 ; i< childCompNamelist.length ; i++)
        {
            document.getElementById(childCompNamelist[i]).checked = false ;
        }
        component.set("v.childCompNamelist",[]);
        component.set( 'v.displayMstrVarientChildCompList', []);
        component.set( 'v.copyMstrVarientChildCompList', []);
     },

     selectChild : function( component, event ,helper){
        var qcComponent = component.get("v.QcComp");
        if( qcComponent.Master_Variant__c != undefined)
        {
            if( qcComponent.Master_Variant__c.length == 0 )
            {
               var mvChildComp = component.find( "mvChildComp" );
               $A.util.removeClass(mvChildComp, "slds-show");
               $A.util.addClass(mvChildComp, "slds-hide");
            }else{
               var mvChildComp = component.find( "mvChildComp" );
               $A.util.removeClass(mvChildComp, "slds-hide");
               $A.util.addClass(mvChildComp, "slds-show");
            }
        }else{
            
            var mvChildComp = component.find( "mvChildComp" );
            $A.util.removeClass(mvChildComp, "slds-show");
            $A.util.addClass(mvChildComp, "slds-hide");
        }
        var id = event.target.id;
        var check = event.target.checked;
        var childCompNamelist = component.get("v.childCompNamelist");
        if(id != '')
        {
           if(check)
           {
               childCompNamelist.push(id);
               component.set("v.childCompNamelist",childCompNamelist);
               var masterVarientCompList = component.get( 'v.masterVarientCompList' );
               if(masterVarientCompList.includes( id ))
               {
                   var displayMstrVarientChildCompList = component.get( 'v.displayMstrVarientChildCompList' );
                   displayMstrVarientChildCompList.push( id );
                   component.set( 'v.displayMstrVarientChildCompList' , displayMstrVarientChildCompList  );
               }


           }else{
               childCompNamelist = childCompNamelist.filter(e => e !== id ); 
               component.set("v.childCompNamelist",childCompNamelist);

               var masterVarientCompList = component.get( 'v.masterVarientCompList' );
               if(masterVarientCompList.includes( id ))
               {
                   var displayMstrVarientChildCompList = component.get( 'v.displayMstrVarientChildCompList' );
                   displayMstrVarientChildCompList  =  displayMstrVarientChildCompList.filter(e => e !== id ); 
                   component.set( 'v.displayMstrVarientChildCompList' , displayMstrVarientChildCompList  );

                   var copyMstrVarientChildCompList = component.get('v.copyMstrVarientChildCompList');
                   if(copyMstrVarientChildCompList.length > 0)
                   {
                        copyMstrVarientChildCompList = copyMstrVarientChildCompList.filter(e => e !== id );
                        component.set( 'v.copyMstrVarientChildCompList' , copyMstrVarientChildCompList  );
                   }
               }
           }
        } 
     },

     selectMVChild : function( component ,event , helper)
     {
        var id = event.target.id;
        var check = event.target.checked;
        var childCompNamelist = component.get("v.copyMstrVarientChildCompList");
        if(id != '')
        {
           if(check)
           {
               id = id.replace('-MV','' );
               childCompNamelist.push(id);
               component.set("v.copyMstrVarientChildCompList",childCompNamelist);
           }else{
               childCompNamelist = childCompNamelist.filter(e => e !== id ); 
               component.set("v.copyMstrVarientChildCompList",childCompNamelist);
           }
        } 
     },

     newFW_OR_WHsaveAndNext : function( component, event ,helper){
        var qcComp =  component.get("v.QcComp") ;
        if(qcComp.Sample_Date__c == undefined || qcComp.Sample_Date__c == null || qcComp.Sample_Date__c == '' )
        {
            alert('Enter sample date');
            return;
        }
        
        if( (qcComp.Master_Variant__c == undefined || qcComp.Master_Variant__c.length == 0) && (qcComp.Master__c == undefined || qcComp.Master__c == false ) )
        {
            alert('Enter Master or Master varient');
            return;
        }

        if( (qcComp.Brand__c == undefined || qcComp.Brand__c.length == 0)  )
        {
            alert('Enter Brand');
            return;
        }

        if( (qcComp.Sample_Received_From__c == undefined || qcComp.Sample_Received_From__c == null)  )
        {
            alert('Enter Sample recieved From Email');
            return;
        }

        var childCompNamelist = component.get("v.childCompNamelist");
        if(childCompNamelist.length == 0)
        {
            alert('Select Child Component');
            return;
        }
        if( qcComp.Id == undefined || qcComp.Id == undefined){
            helper.saveFW_WHComphelper( component, event, helper);
        }
        

        
     },

     resubNext : function( component, event ,helper){
        var selectedRec = component.get("v.seletedRecForUpdateOrResub");
        if( selectedRec == undefined)
        {
            alert("please select record number");
            return;
        }
        var action = component.get("c.getQcComponentPack");
            action.setParams({
                "recId" : selectedRec.Id
            });
            action.setCallback( this , function(response){
                var state = response.getState();
                if( state === 'SUCCESS' )
                {
                    var qcComponent = component.get("v.QcComp");
                    if( qcComponent.Sample_Category__c == 'Update')
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
                        var checkId = component.get("v.seletedRecForUpdateOrResub.Id");
                        helper.checkRecorIsLoak(component,event,helper,checkId  );
                        
                        component.set("v.allCompList", allCompList );
                        var selectRecordPage = component.find("selectRecordPage");
                        $A.util.removeClass( selectRecordPage , "slds-hide");
                        $A.util.addClass( selectRecordPage , "slds-show");

                        var selectTypesPage = component.find("selectTypesPage");
                        $A.util.removeClass( selectTypesPage , "slds-show");
                        $A.util.addClass( selectTypesPage , "slds-hide");

                    }
                    else if(qcComponent.Sample_Category__c == 'Re-Submission'){
                        var selectedRecPack = JSON.parse( response.getReturnValue() );
                        let parentQcCompRec = JSON.parse(JSON.stringify(selectedRecPack.parentDetail.qcComp));
                        parentQcCompRec.Id = null
                        parentQcCompRec.Name = null;
                        parentQcCompRec.Parent_Report_Reference_Number__c = selectedRecPack.parentDetail.qcComp.Report_Ref_Number__c ;
                        parentQcCompRec.Component__r = null ;
                        parentQcCompRec.Report_Ref_Number__c = '';
                        parentQcCompRec.Document_Status__c = 'Draft' ;
                        parentQcCompRec.Component_Status__c = 'Active' ;
                        parentQcCompRec.Sample_Category__c = 'Re-Submission';
                        parentQcCompRec.Sample_Date__c = null ;
                        parentQcCompRec.Final_Verdict__c = null ;

                        let parentInputdata = selectedRecPack.parentDetail.inputParam == null ? null :selectedRecPack.parentDetail.inputParam.map((item,index,arr) => { 
                            item["Id"] = null;
                            item["Name"] = null;
                            item["Component_No__c"] = '';   
                           return item;
                         });
                         console.log( parentInputdata );

                         let parentTestdata = selectedRecPack.parentDetail.testData == null ? null :selectedRecPack.parentDetail.testData.map((item,index,arr) => { 
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
                            item.qcComp.Parent_Report_Reference_Number__c = '';
                            item.qcComp.Report_Ref_Number__c = '';
                            item.qcComp.Component__r = null ;
                            item.qcComp.Document_Status__c = 'Draft' ;
                            item.qcComp.Component_Status__c = 'Active' ;
                            item.qcComp.Sample_Category__c = 'Re-Submission';
                            item.qcComp.Sample_Date__c = null ;
                            item.qcComp.Final_Verdict__c = null ;

                            item.inputParam == null ? null : item.inputParam.map((childItem,childIndex,chilAarr) => { 
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

                         let resubmissionRec = {
                            parentDetail : { qcComp : parentQcCompRec , inputParam : parentInputdata, testData : parentTestdata  } ,
                            childsDetail : childRecInfo
                         };
                        
                         let parentQcComp = JSON.parse(JSON.stringify(selectedRecPack.parentDetail.qcComp)) ;
                         parentQcComp.Component_Status__c = 'Obsolete';
                         
                         var resubAction = component.get('c.saveResubmissionRecMetod');
                         resubAction.setParams({
                            'resubRecStr' : JSON.stringify(resubmissionRec),
                            'parentRecstring' : JSON.stringify( parentQcComp )
                         });

                         resubAction.setCallback(this,function(resubResponse){ 
                             debugger;
                             if( resubResponse.getState() )
                             {
                                let resubResult = JSON.parse(resubResponse.getReturnValue());
                                component.set( "v.savedData" , resubResult);
                                var parentRec=[];
                                parentRec.push( resubResult.parentDetail.qcComp ) ;
                                var childCompList = [];
                                for( var i = 0 ; i< resubResult.childsDetail.length ; i++)
                                {
                                    childCompList.push( resubResult.childsDetail[i].qcComp );
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
                         $A.enqueueAction(resubAction);

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

    newWatchCompSave : function( component, event ,helper){
        var watchComp = component.get("v.watchComp") ;
        var qcComp = component.get("v.QcComp");
        if(watchComp != undefined && qcComp.Name__c == 'Watch-Component' && (qcComp.Sample_Category__c != "Update" || qcComp.Sample_Category__c != "Re-Submission" ))
        {
            helper.newWatchCompSaveHelper( component, event, helper, watchComp);
        }
    },

    parentRecordSave : function( component, event ,helper){
        var allQcRecList = event.getParam('allQcRecList');
        if( allQcRecList != undefined || allQcRecList.length > 0)
        {
            component.set('v.allCompList',  allQcRecList  );   
            helper.checkRecorIsLoak(component,event,helper,allQcRecList[0].Id);
        }
            
    },*/
})