({
    /*doInit : function( component, event ,helper){
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

    selectLookupRec : function( component, event ,helper){
        var seectedRecId = event.getParam('customId');
        var recordByEvent = event.getParam('recordByEvent');
        component.set("v.seleteRecLookup", recordByEvent );
    },
    goToNext : function( component, event ,helper){
       // debugger;
        var selectedRec = component.get("v.seleteRecLookup");
        console.log("select rec ="+selectedRec);
        var selectReccomp = JSON.parse(JSON.stringify(selectedRec));
        if(selectReccomp !== null && selectReccomp !== ''){
            var idd = selectReccomp.Id;
            var action=component.get('c.getCompDetail');
            action.setParams({
                'recdId': idd
            });
            action.setCallback(this,(response)=>{
                if(response.getState()==="SUCCESS"){
                var result = JSON.parse( response.getReturnValue());
                var parentRec=[];
                parentRec.push( result.parentDetail.qcComp ) ;
                var childCompList = [];
                for( var i = 0 ; i< result.childsDetail.length ; i++)
                {
                    childCompList.push( result.childsDetail[i].qcComp );
                }

                var allCompList = parentRec.concat( childCompList );
                component.set("v.allCompList", allCompList );
                component.set("v.selectedTabRec", result.parentDetail.qcComp );
                component.set("v.isShowrecordDetail", true);
        }
    });
     $A.enqueueAction(action); 
    
        }else{
            alert('Please enter Report Ref Number');
            return;
        }

        var selectDiv = component.find('selectDiv');
        $A.util.removeClass(selectDiv ,'slds-show');
        $A.util.addClass(selectDiv ,'slds-hide');

        var detailDiv = component.find('detailDiv');
        $A.util.removeClass(detailDiv ,'slds-hide');
        $A.util.addClass(detailDiv ,'slds-show');
    },

    parentRecordSave : function( component, event ,helper){
        var allQcRecList = event.getParam('allQcRecList');
        if( allQcRecList != undefined || allQcRecList.length > 0)
        {
            component.set('v.allCompList',  allQcRecList  );   
        }
            
    },

    showTab : function( component, event ,helper){
        var TabNames = component.find('TabNames');
        $A.util.removeClass(TabNames ,'slds-hide');
        $A.util.addClass(TabNames ,'slds-show');
    },

    hideTabDropdown : function( component, event ,helper){
        var TabNames = component.find('TabNames');
        $A.util.removeClass(TabNames ,'slds-show');
        $A.util.addClass(TabNames ,'slds-hide');

    },

    selectTabDropdown : function( component, event ,helper){
        var TabNames = component.find('TabNames');
        $A.util.removeClass(TabNames ,'slds-show');
        $A.util.addClass(TabNames ,'slds-hide');

        var id = event.currentTarget.id;
        var recList = component.get("v.allCompList");
        if( recList != undefined && recList.length != 0 )
        {
            component.set("v.selectedTabRec", recList[id]);
        }
        
    },*/
})