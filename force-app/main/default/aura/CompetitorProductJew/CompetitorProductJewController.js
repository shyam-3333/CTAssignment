({
    doinit : function(component, event, helper) {
        var recId = component.get("v.recordId");
        helper.getRecordTypes(component, event, helper);
    },
    clickNext : function(component, event, helper) {
        debugger;
        var recTypeName = component.get("v.selectedRecType");
        if(recTypeName != null && recTypeName != '' && recTypeName != undefined ){
            var radioDivTemp = component.find("radioDiv");
            $A.util.removeClass(radioDivTemp,"slds-show");
            $A.util.addClass(radioDivTemp,"slds-hide");
            
            var detailDivTemp = component.find("detailDiv");
            $A.util.removeClass(detailDivTemp,"slds-hide");
            $A.util.addClass(detailDivTemp,"slds-show");
        }
        else{
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "type": "Error",
                    "message": "Select record type."
                });
                toastEvent.fire();
        }
        
    },
    cancel : function(component, event, helper){
        var eUrl= $A.get("e.force:navigateToURL"); eUrl.setParams({ "url": 'https://titanlightningapps.lightning.force.com/lightning/o/Competitor_Product_Jew__c/list?filterName=Recent' }); eUrl.fire();
    }
})