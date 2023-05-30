({
   /* fetchAllMaster : function( component, event, helper) {
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
    },

    fetchRecordDetails : function (component,event,helper){
        const recordId = component.get("v.recordId");
        var action = component.get("c.getCompDetail");
        action.setParams({
            "recdId" : recordId
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS")
            {
                var result = JSON.parse( response.getReturnValue());
                var parentRec=[];
                parentRec.push( result.parentDetail.qcComp ) ;
                var childCompList = [];
                for( var i = 0 ; i< result.childsDetail.length ; i++)
                {
                    childCompList.push( result.childsDetail[i].qcComp );
                }

                var allCompList = parentRec.concat( childCompList );
                allCompList = allCompList.filter( e=> e.Id != undefined );
                component.set("v.allCompList", allCompList );
                var qcRec = allCompList.filter( e=> e.Id == component.get("v.recordId") )[0];
                component.set("v.selectedTabRec",qcRec );
                component.set("v.isShowrecordDetail", true);
            }
        });
        $A.enqueueAction(action);

    },

    // fetchCurrentUserProfile : function( component, event , helper )
    // {
    //     var action = component.get('c.getProfileName');
    //     action.setCallback( this, function(response){
    //         var state = response.getState();
    //         if( state == "SUCCESS")
    //         {
    //             var result = response.getReturnValue();
    //             component.set("v.profileName",result)
    //         }
    //     });
    //     $A.enqueueAction(action);
    // }*/
})