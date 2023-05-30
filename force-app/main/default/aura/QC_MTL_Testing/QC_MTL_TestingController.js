({
    doInit : function(component, event, helper) {
        helper.onload(component, event, helper);
    },
    toggleMethod :function(component, event, helper){
        helper.toggleMethod(component, event, helper);
        //component.set('v.togglePlatingTesting',false);
    },
  /*  nextPage : function(component, event, helper){
        helper.nextPage(component, event, helper);
    },*/
    nextPagePlatingTesting :function(component, event, helper){
        helper.nextPagePlatingTesting(component, event, helper);
    },
    cancelMethod : function(component, event, helper) {
        component.set("v.isReadonly",true);
        component.set('v.toggleSec1',true);
        component.set('v.toggleInputForm',false);
    },
    saveDataFromParent : function(component, event, helper) {
        var validateCount = component.get("v.callSaveFromParent");
        component.set("v.callSaveFromParent",validateCount + 1);
    },
    enableSaveMode : function(component, event, helper) {
        component.set("v.isReadonly",false);
    },
    toggleSampleMethod : function(component, event, helper){
        var sampleType = component.get("v.SelectedMaterialSampleType");
        
        if(sampleType == 'New'){
            component.set("v.toggleTest",true);
            component.set("v.isReSubmission",false);
            component.find('mySelect').set("v.value",'--None--');
        }
        if(sampleType == 'Re-Submission'){
           component.set("v.toggleTest",true);
           component.set("v.isReSubmission",true);
        }
        if(sampleType == '--None--'){
        	component.set("v.toggleTest",false);
           	component.set("v.isReSubmission",false);
            component.set('v.toggleGer','false');
        }
    },
    handleLookupComponentEvent : function(component, event, helper) {
        var selectedRecordFromEvent = event.getParam("recordByEvent");
		var customId = event.getParam("customId");
        if(customId == 'qCMtlComponentNumber'){
            component.set("v.selectedLookUpRecordForReSub",selectedRecordFromEvent);
        } 
        
    },  
})