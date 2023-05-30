({
	/*fetchAllMaster : function( component, event, helper) {
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
    }, */
})