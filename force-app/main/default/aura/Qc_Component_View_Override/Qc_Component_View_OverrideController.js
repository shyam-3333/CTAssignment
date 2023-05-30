({
   /* doinit : function(component, event, helper) {
        // helper.fetchCurrentUserProfile( component, event , helper );
        helper.fetchAllMaster(component, event , helper);
        helper.fetchRecordDetails(component,event,helper);
    },

    showSpinner: function(component) {
    var spinnerMain =  component.find("Spinner");
    $A.util.removeClass(spinnerMain, "slds-hide");
    },
    
    hideSpinner : function(component) {
    var spinnerMain =  component.find("Spinner");
    $A.util.addClass(spinnerMain, "slds-hide");
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