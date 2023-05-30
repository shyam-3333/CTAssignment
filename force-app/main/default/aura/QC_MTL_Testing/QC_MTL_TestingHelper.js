({
    onload : function(component, event, helper) {
        var action=component.get('c.getSchemaValue');
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.testingTypePickList',result[0]);
                component.set('v.rawMaterialPickList',result[1]);
                component.set('v.pickListMaterialSampleType',result[2]);
                console.log(result);
            }
        });
        $A.enqueueAction(action);
    },
    toggleMethod : function(component, event, helper){
        component.set("v.parentTestingTypeValue",component.find("mySelect").get("v.value"));
        var sampleType = component.find('materialPicklistId').get('v.value');
        if(component.get('v.SelectedTestingTypeValue')=='Raw Material' && sampleType == 'New'){
            component.set('v.toggleGer','true');
            component.set('v.togglePlatingTesting','true');
        }
        else if((component.get('v.SelectedTestingTypeValue')=='Plating' || component.get('v.SelectedTestingTypeValue')=='Plating and Material Composition' )){
            component.set('v.toggleGer','false');
            component.set('v.togglePlatingTesting','true');
        }
        else if(component.get('v.SelectedTestingTypeValue')=='Raw Material' && sampleType == 'Re-Submission'){
              component.set('v.toggleGer','false');
              component.set('v.togglePlatingTesting','true');
        }
        else if(component.get('v.SelectedTestingTypeValue')=='Raw Material' && sampleType == '--None--'){
            component.set('v.toggleGer','false');
            component.set('v.togglePlatingTesting','false');
        }
        else{
            component.set('v.toggleGer','false');
            component.set('v.togglePlatingTesting','false');
        }
    },
  /*  nextPage : function(component, event, helper){
        if(component.get('v.SelectedMaterialTypeValue')=='--None--' || component.get('v.SelectedMaterialTypeValue')==undefined){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Please Select Material Type',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
            
        }
        else {
            component.set('v.toggleSec1','false');
            component.set('v.toggleInputForm','true'); 
        }
    },*/
    nextPagePlatingTesting : function(component, event, helper){
        var sampleType = component.find('materialPicklistId').get('v.value');
        var referenceId = component.get("v.selectedLookUpRecordForReSub").Id;
        if(component.get("v.SelectedTestingTypeValue") == 'Raw Material' && (component.get('v.SelectedMaterialTypeValue')=='--None--' || component.get('v.SelectedMaterialTypeValue')==undefined) && sampleType == 'New'){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Please Select Material Type',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
            
        }else if(sampleType == 'Re-Submission' && (referenceId == '' || referenceId == undefined)){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Please Select Reference Number!!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }else if(sampleType == '' || sampleType == undefined || sampleType == '--None--'){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Please Select Sample type!!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        } else if(component.get('v.SelectedTestingTypeValue')=='' || component.get('v.SelectedTestingTypeValue')==undefined || component.get('v.SelectedTestingTypeValue')=='--None--' ){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message: 'Please Select Testing type!!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }
        else {
            component.set('v.toggleSec1',false);
            component.set('v.toggleInputForm',true);
            component.set("v.selectedSampleTypeValue",component.find("materialPicklistId").get("v.value"));
            
        }
    },
})