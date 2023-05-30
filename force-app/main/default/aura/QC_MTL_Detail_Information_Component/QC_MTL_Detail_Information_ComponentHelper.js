({
    doInit : function(component, event, helper) {
        var action =component.get("c.getQCMTLComponentRecord");
        action.setParams({
            "recordId" : component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.QCMTlComponentObject',result);
                if(result.Titan_Specification_Reference__c!=undefined ){
                    var qcAccessMasterObject={'sObject' : 'QC_Access_Master__c', 'Id' : result.Titan_Specification_Reference__c ,'Name' : result.Titan_Specification_Reference__r.Name};
                    var supplierGradesObject={'sObject' : 'Supplier_Grade__c', 'Id' : result.Supplier_Grade__c,'Name' : result.Supplier_Grade__r.Name};
                    component.set('v.selectedLookUpRecordForTitanSpec',qcAccessMasterObject);
                    component.set('v.selectedLookUpRecordForSupplierGrd',supplierGradesObject);
                    component.set('v.lookupValueIncrementerForTitanSpec',component.get('v.lookupValueIncrementerForTitanSpec')+1);
                    component.set('v.lookupValueIncrementerForSupplrGrd',component.get('v.lookupValueIncrementerForSupplrGrd')+1);
                }
            }
        });
        $A.enqueueAction(action);
    },
    handleSubmit : function(component, event, helper){
        
    }
})