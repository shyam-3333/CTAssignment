({
    fatchRecords: function (component, event, helper, whereClause, requestedFields, requstedRecordCount) {
        var action = component.get('c.fatchRecords');
        let soqlQuery = "Select " + requestedFields;
        soqlQuery += "FROM QC_MTL_Component__c ";
        soqlQuery += "where " + whereClause;
        soqlQuery += "limit " + requstedRecordCount;
        component.set('v.Spinner', true);
        let requestedJson = [
            { 'query': soqlQuery },
            { 'requestedFields': requestedFields }
        ];
        action.setParams({
            requestedParameters: JSON.stringify(requestedJson)
        });
        action.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                component.set('v.csvFile', response.getReturnValue());
                component.set('v.Spinner', false);
            } else {
                component.set('v.Spinner', false);
            }
        });
        $A.enqueueAction(action);
    },
    showTost: function (component, event, helper, VariantName, Message) {
        if (VariantName == "warring")
            helper.warringTMsg(component, event, helper, Message);
        if (VariantName == "error")
            helper.errorTMsg(component, event, helper, Message);
        if (VariantName == "information")
            helper.informationTMsg(component, event, helper, Message);
        if (VariantName == "success")
            helper.successTMsg(component, event, helper, Message);
    },
    warringTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Warning!",
            "type": "warning",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    errorTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "type": "error",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    informationTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Information!",
            "type": "info",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    successTMsg: function (component, event, helper, Message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type": "success",
            "message": "" + Message
        });
        toastEvent.fire();
    },
    fatchRawMaterial: function (component, event, helper) {
        let requestedFields = "Name,Report_Reference_Number__c,Sample_Received_From__c,MTL_User_Email__c,Raw_Material_Type__c,";
        requestedFields += "Raw_Material_Name__c,Titan_Specification_Reference_Name__c,Supplier_Grade_External_Id__c,Supplier_Name_External_Id__c,";
        requestedFields += "Invoice_Dc_No__c,RM_Size__c,Heat_No_Grade__c,Supply_Quantity__c,";
        requestedFields += "Sample_Size_Qty__c,Material_Sample_Type__c ";
        let whereClause = " Testing_Type__c='Raw Material' order by createdDate Desc ";
        let requstedRecordCount = component.get('v.noOfLetestRecords');
        helper.fatchRecords(component, event, helper, whereClause, requestedFields, requstedRecordCount);
    },
    fatchPlating: function (component, event, helper) {
        let requestedFields = "Name,Report_Reference_Number__c,Sample_Received_From__c,MTL_User_Email__c,Department__c,";
        requestedFields += "Part_Name__c,Titan_Specification_Reference_Name__c,Supplier_Name_External_Id__c,Brand_Name_External_Id__c,";
        requestedFields += "Source__c,Model__c,Docket_Number__c,Batch_Quantity__c,";
        requestedFields += "Material__c,Plating_Type__c,Specification_revision__c,Required_Test__c,Sample_Size_Plating__c,Material_Sample_Type__c,Plater_External_Id__c ";
        let whereClause = " Testing_Type__c='Plating' order by createdDate Desc ";
        let requstedRecordCount = component.get('v.noOfLetestRecords');
        helper.fatchRecords(component, event, helper, whereClause, requestedFields, requstedRecordCount);
    },
    fatchPlatingMC: function (component, event, helper) {
        let requestedFields = "Name,Report_Reference_Number__c,Sample_Received_From__c,MTL_User_Email__c,Department_PMC__c,";
        requestedFields += "Part_Name__c,Titan_Specification_Reference_Name__c,Supplier_Name_External_Id__c,Brand_Name_External_Id__c,";
        requestedFields += "Source__c,Model__c,Docket_Number__c,Batch_Quantity__c,";
        requestedFields += "Material__c,Plating_Type__c,Specification_revision__c,Required_test_PMC__c,Sample_Size_Plating__c,Material_Sample_Type__c,Plater_External_Id__c ";
        let whereClause = " Testing_Type__c='Plating and Material Composition' order by createdDate Desc ";
        let requstedRecordCount = component.get('v.noOfLetestRecords');
        helper.fatchRecords(component, event, helper, whereClause, requestedFields, requstedRecordCount);
    }

})