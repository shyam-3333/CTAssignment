({
    doInit : function(component, event, helper) {
        helper.doInit(component, event, helper);
        helper.getApprovalList(component); 
        helper.checkRecorIsLoak(component,event,helper);
    },
    onkeyupmethod : function(component, event, helper){
        var data=component.get("v.alltestParameter");
        for(var x=0;x<data.length;x++){
            if(data[x].Name=='Hardness (HV)'){
                data[x].Average_Value__c=parseFloat(data[x].Minimum__c)+parseFloat(data[x].Maximum__c);
                data[x].Average_Value__c=parseFloat(parseFloat(data[x].Average_Value__c)/2).toFixed(2); 
                if(data[x].Average_Value__c=='NaN'){
                    data[x].Average_Value__c=0;
                }
            }
            
        }
        
        component.set("v.alltestParameter",data);
        //alert(':::data:::'+component.get("v.testParamList"));
    },
    enableSaveMode : function(comp){
        let isrecordlok= comp.get('v.isRecordLock');
        comp.set('v.isReadonly',isrecordlok);
        //alert('isrecordlok'+isrecordlok);
        if(isrecordlok){
             var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Information',
                   message: 'Record is Lock!!',
                   duration:'5000',
                    key: 'info_alt',
                   type: 'warning',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }
        
    },
    cancelData : function(comp){
        comp.set('v.isReadonly',true);
    },
    saveData : function(component,event,helper){
        helper.saveInfo(component,event,helper);
    },
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
   },
    
    submitRecordForApproval : function(component, event, helper) {
        debugger;
        if(component.get('v.QCMTlComponentObject.Final_Verdict__c') != 'None'){
            helper.submitForApprovalProcess(component,event,helper);
        }else{
            var toastEvent = $A.get("e.force:showToast");
               toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please select Final Verdict Value other than None!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
           	toastEvent.fire();
        }  
        
    }, 
    
     gotoRelatedList : function (component, event, helper) {
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "ProcessSteps",
            "parentRecordId": component.get("v.recordId")
        });
        relatedListEvent.fire();
    },
    
 // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    },
    detailedReportMethod : function(component,event,helper){
        debugger;
        if(component.get('v.QCMTlComponentObject.Testing_Type__c')=='Raw Material'){
            var recordCompId = component.get("v.recordId");
        	/*var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/QCMTLRawMaterialPDFReportPDF?compId="+recordCompId,
              "isredirect": "true"
            });
            urlEvent.fire();*/
            window.open(window.location.origin +'/apex/QCMTLRawMaterialPDFReportPDF?compId='+recordCompId,'_blank');
        }
        if(component.get('v.QCMTlComponentObject.Testing_Type__c')=='Plating' ){
            var recordCompId = component.get("v.recordId");
            /*var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                  "url": "/apex/QCMTLPlatingMatTestingReport?compId="+recordCompId,
                  "isredirect": "true"
                });
                urlEvent.fire();*/
              window.open(window.location.origin +'/apex/QCMTLPlatingMatTestingReport?compId='+recordCompId,'_blank');
        }
        if(component.get('v.QCMTlComponentObject.Testing_Type__c')=='Plating and Material Composition'){
            var recordCompId = component.get("v.recordId");
            /*var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                  "url": "/apex/QCMTLPlatingMatTestingReport?compId="+recordCompId,
                  "isredirect": "true"
                });
                urlEvent.fire();*/
              window.open(window.location.origin +'/apex/QCMTLComponentPlatingmaterialCompVFPage?compId='+recordCompId,'_blank');
        }
        
    }
})