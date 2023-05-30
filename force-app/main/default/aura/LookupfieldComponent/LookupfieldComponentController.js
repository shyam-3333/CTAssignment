({
   /* doinit : function(component, event, helper) {
        var isdisable = component.get("v.isdisable");
        if( isdisable && component.get("v.selectedRecord.Name") != undefined )
        {
            var searchBox = component.find("searchBox");
            $A.util.removeClass( searchBox , "slds-show");
            $A.util.addClass( searchBox , "slds-hide");

            var lookupPill = component.find("lookupPill");
            $A.util.removeClass( lookupPill , "slds-hide");
            $A.util.addClass( lookupPill , "slds-show");
        }

    },
    changeSearchStr : function(component, event, helper) {
        helper.fetchRecords(component, event, helper);
    },

    showLookupDropdown : function(component, event, helper) {
        
        var dropdown = component.find("dropdown");
        $A.util.removeClass( dropdown , "slds-hide");
        $A.util.addClass( dropdown , "slds-show");
    },

    hideLookupDropdown : function(component, event, helper) {
        
        var dropdown = component.find("dropdown");
        $A.util.removeClass( dropdown , "slds-show");
        $A.util.addClass( dropdown , "slds-hide");
    },

    selectRecord : function(component, event, helper) {
        var dropdown = component.find("dropdown");
        $A.util.removeClass( dropdown , "slds-show");
        $A.util.addClass( dropdown , "slds-hide");

        var searchBox = component.find("searchBox");
        $A.util.removeClass( searchBox , "slds-show");
        $A.util.addClass( searchBox , "slds-hide");

        var lookupPill = component.find("lookupPill");
        $A.util.removeClass( lookupPill , "slds-hide");
        $A.util.addClass( lookupPill , "slds-show");
        debugger;

        var index = event.target.id;
        var recordObj = component.get("v.recordList")[index].record;
        component.set("v.selectedRecord",recordObj);
         
        // call the event   
        var compEvent = component.getEvent("selectedRecordEvent");
        // set the Selected sObject Record to the event attribute.  
         compEvent.setParams({"recordByEvent" : recordObj, "customId" : recordObj.Id ,"label": component.get('v.label') });  
        // fire the event  
        compEvent.fire();

    },
    removeSelectedRec : function(component, event, helper) {
        
        var searchBox = component.find("searchBox");
        $A.util.removeClass( searchBox , "slds-hide");
        $A.util.addClass( searchBox , "slds-show");

        var lookupPill = component.find("lookupPill");
        $A.util.removeClass( lookupPill , "slds-show");
        $A.util.addClass( lookupPill , "slds-hide");
        component.set("v.selectedRecord",null);
        var label = component.get('v.label');
        document.getElementById(label).value = '';
        var compEvent = component.getEvent("selectedRecordEvent");
        // set the Selected sObject Record to the event attribute.  
         compEvent.setParams({"recordByEvent" : null , "customId" : '' ,"label": label });  
         compEvent.fire();
    },*/
})