({
       getPickListval: function(component,event,helper){
        var action = component.get("c.getPickListValue");
        action.setParams({
            'objectApiName': 'QC_MTL_Component__c',
            'pickListFieldApiName': 'Part_Name_New__c'
        });
        action.setCallback(this, function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.partNameOptions',result);
            }
        });
         $A.enqueueAction(action);
    },
    saveData :function(component,event,helper){
        component.set('v.Spinner',true);
        var testingType =component.get("v.parentTestingType");
        var materialType =component.get("v.parentMaterialType");
        var counterVal=component.get("v.callSaveFromParent");
        var sampleType = component.get("v.parentSampleType");
        var deptValue = component.get('v.selectedDepartmentValue');
        var reqTestValue = component.get('v.selectedRequiredTestValue');
        var mtlUserEmail = component.find("mtlUserEmailId").get("v.value");
        //var suplrName = component.get("v.")
         var dataToBeSaved ={'sObject' : 'QC_MTL_Component__c',
                            'Testing_Type__c' :testingType,
                            'Raw_Material_Type__c': materialType,
                            'RM_Size__c':component.get('v.RMSize'),
                            'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                             'plater_Name__c' : component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                            'Invoice_Dc_No__c':component.get('v.invoiceNo'),
                            'Heat_No_Grade__c':component.get('v.heatNo'),
                            'Sample_Size_Qty__c':component.get('v.sampleSize'),
                            'Supply_Quantity__c':component.get('v.supplyQty'),
                            'Titan_Specification_Reference__c':component.get('v.selectedLookUpRecordForTitanSpec').Id,
                            'Supplier_Grade__c' :component.get('v.selectedLookUpRecordForSupplierGrd').Id,
                            'Brand__c' : component.get('v.selectedLookUpRecordForBrand').Id,
                            'Raw_Material_Name__c' : component.get('v.rawMaterial'),
                            'Specification_revision__c': component.get('v.specRevisionValue'),
                            'Material__c':component.get('v.selectedMaterialValue'),
                            'Plating_Type__c':component.get('v.selectedPlatingTypeValue'),
                            'Department__c':component.get('v.selectedDepartmentValue'),
                            'Required_Test__c':component.get('v.selectedRequiredTestValue'),
                            'Part_Name__c':component.get('v.partName'),
                            'Source__c':component.get('v.sourceField'),
                            'Model__c':component.get('v.modelField'),
                            'Docket_Number__c':component.get('v.docketNumberField'),
                            'Batch_Quantity__c':component.get('v.batchQuantityField'),
                             'Remarks__c' : component.get('v.PlatingRemarks'),
                            'MTL_User_Email__c' : mtlUserEmail,
                            'Component_Name__c' : component.get('v.componentNameValue'),
                            'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                            'Material_Sample_Type__c' : component.get('v.parentSampleType'),
                            'Optional_Test__c' : component.get('v.selectedOptionalTest'),
                            'Sample_Received_From__c' : component.get('v.sampleRecvdFrom')};
        var dpar;
        var requitest;
        if(testingType=='Plating'){
            dataToBeSaved ={'sObject' : 'QC_MTL_Component__c',
                            'Testing_Type__c' :testingType,
                            'Raw_Material_Type__c': materialType,
                            'RM_Size__c':component.get('v.RMSize'),
                            'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                            'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                            'Invoice_Dc_No__c':component.get('v.invoiceNo'),
                            'Heat_No_Grade__c':component.get('v.heatNo'),
                            'Sample_Size_Qty__c':component.get('v.sampleSize'),
                            'Supply_Quantity__c':component.get('v.supplyQty'),
                            'Titan_Specification_Reference__c':component.get('v.selectedLookUpRecordForTitanSpec').Id,
                            'Supplier_Grade__c' :component.get('v.selectedLookUpRecordForSupplierGrd').Id,
                            'Brand__c' : component.get('v.selectedLookUpRecordForBrand').Id,
                            'Raw_Material_Name__c' : component.get('v.rawMaterial'),
                            'Specification_revision__c': component.get('v.specRevisionValue'),
                            'Material__c':component.get('v.selectedMaterialValue'),
                            'Plating_Type__c':component.get('v.selectedPlatingTypeValue'),
                            'Department__c':component.get('v.selectedDepartmentValue'),
                            'Required_Test__c':component.get('v.selectedRequiredTestValue'),
                            'Part_Name__c':component.get('v.partName'),
                            'Source__c':component.get('v.sourceField'),
                            'Model__c':component.get('v.modelField'),
                            'Docket_Number__c':component.get('v.docketNumberField'),
                            'Batch_Quantity__c':component.get('v.batchQuantityField'),
                            'Remarks__c' : component.get('v.PlatingRemarks'),
                            'MTL_User_Email__c' : mtlUserEmail,
                            'Component_Name__c' : component.get('v.componentNameValue'),
                            'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                            'Material_Sample_Type__c' : component.get('v.parentSampleType'),
                            'Optional_Test__c' : component.get('v.selectedOptionalTest'),
                            'Sample_Received_From__c' : component.get('v.sampleRecvdFrom'),
                            'Actual_Department_Name__c' : component.get('v.OtherDept')};
        }
        else if(testingType=='Plating and Material Composition'){
             var dataVal;
             var datavar1;
            if(component.get("v.componentNameValue") =='Accessories' && component.get("v.componentAccValue") !=undefined){
                dataVal = component.get("v.componentAccValue");
            }
            else if(component.get("v.componentNameValue") =='Others' && component.get("v.componentOtherValue") !=undefined){
                datavar1 = component.get("v.componentOtherValue");
            }
            dataToBeSaved ={'sObject' : 'QC_MTL_Component__c',
                            'Testing_Type__c' :testingType,
                            'Raw_Material_Type__c': materialType,
                            'RM_Size__c':component.get('v.RMSize'),
                            'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                            'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                            'Invoice_Dc_No__c':component.get('v.invoiceNo'),
                            'Heat_No_Grade__c':component.get('v.heatNo'),
                            'Sample_Size_Qty__c':component.get('v.sampleSize'),
                            'Supply_Quantity__c':component.get('v.supplyQty'),
                            'Titan_Specification_Reference__c':component.get('v.selectedLookUpRecordForTitanSpec').Id,
                            'Supplier_Grade__c' :component.get('v.selectedLookUpRecordForSupplierGrd').Id,
                            'Brand__c' : component.get('v.selectedLookUpRecordForBrand').Id,
                            'Raw_Material_Name__c' : component.get('v.rawMaterial'),
                            'Specification_revision__c': component.get('v.specRevisionValue'),
                            'Material__c':component.get('v.selectedMaterialValue'),
                            'Plating_Type__c':component.get('v.selectedPlatingTypeValue'),
                            'Department_PMC__c':component.get('v.selectedDepartmentValue'),
                            'Required_test_PMC__c':component.get('v.selectedRequiredTestValue'),
                            'Part_Name__c':component.get('v.partName'),
                            'Source__c':component.get('v.sourceField'),
                            'Model__c':component.get('v.modelField'),
                            'Docket_Number__c':component.get('v.docketNumberField'),
                            'Batch_Quantity__c':component.get('v.batchQuantityField'),
                            'Remarks__c' : component.get('v.PlatingRemarks'),
                            'MTL_User_Email__c' : mtlUserEmail,
                            'Component_Name__c' : component.get('v.componentNameValue'),
                            'Component_Accessories__c' : dataVal,
            				'Component_Others__c'    : datavar1,
                            'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                            'Material_Sample_Type__c' : component.get('v.parentSampleType'),
                            'Optional_Test__c' : component.get('v.selectedOptionalTest'),
                            'Sample_Received_From__c' : component.get('v.sampleRecvdFrom'),
                             'Actual_Department_Name__c' : component.get('v.OtherDept')};
        }
            else if(testingType=='Raw Material'){
                dataToBeSaved ={'sObject' : 'QC_MTL_Component__c',
                            'Testing_Type__c' :testingType,
                            'Raw_Material_Type__c': materialType,
                            'RM_Size__c':component.get('v.RMSize'),
                            'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                            'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                            'Invoice_Dc_No__c':component.get('v.invoiceNo'),
                            'Heat_No_Grade__c':component.get('v.heatNo'),
                            'Sample_Size_Qty__c':component.get('v.sampleSize'),
                            'Supply_Quantity__c':component.get('v.supplyQty'),
                            'Titan_Specification_Reference__c':component.get('v.selectedLookUpRecordForTitanSpec').Id,
                            'Supplier_Grade__c' :component.get('v.selectedLookUpRecordForSupplierGrd').Id,
                            'Brand__c' : component.get('v.selectedLookUpRecordForBrand').Id,
                            'Raw_Material_Name__c' : component.get('v.rawMaterial'),
                            'Specification_revision__c': component.get('v.specRevisionValue'),
                            'Material__c':component.get('v.selectedMaterialValue'),
                            'Plating_Type__c':component.get('v.selectedPlatingTypeValue'),
                            'Department__c':component.get('v.selectedDepartmentValue'),
                            'Required_Test__c':component.get('v.selectedRequiredTestValue'),
                            'Part_Name__c':component.get('v.partName'),
                            'Source__c':component.get('v.sourceField'),
                            'Model__c':component.get('v.modelField'),
                            'Docket_Number__c':component.get('v.docketNumberField'),
                            'Batch_Quantity__c':component.get('v.batchQuantityField'),
                            'Remarks__c' : component.get('v.PlatingRemarks'),    
                            'MTL_User_Email__c' : mtlUserEmail,
                            'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                            'Material_Sample_Type__c' : component.get('v.parentSampleType'),
                             'TCL_Designation__c' : component.get('v.tclDesignation'),    
                            'Sample_Received_From__c' : component.get('v.sampleRecvdFrom')};
            }
        //alert(counterVal);
       
        
        
        
        var finRes=component.get("v.qcMtlCompRecordId");
        if((finRes == undefined || finRes =='' ) && sampleType == 'New'){
            var action = component.get("c.insertInfo");
            action.setParams({
                "infoData" : dataToBeSaved
            });
        }
        
        if((finRes != undefined && finRes !='')){
            var action =component.get("c.updateComponent");
            action.setParams({
                "recId" : component.get("v.qcMtlCompRecordId"),
                "infoData" : dataToBeSaved
            });
        }
        if((finRes == undefined || finRes =='') && sampleType == 'Re-Submission'){
            var action =component.get("c.saveResubData");
            action.setParams({
                "sampleType" : component.get("v.parentSampleType"),
                "referenceNoObj" : component.get("v.referencedReSubReportId"),
                "qacObj" : dataToBeSaved
            });
        }
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success!',
                    message: 'Record is created !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
            var result=response.getReturnValue();
            
            component.set("v.isReadonly",true);
            component.set("v.reportReferenceValue",result.Report_Reference_Number__c);
            component.set("v.documentStatusValue",result.Document_Status__c);
            component.set("v.recordStatusValue",result.Record_Status__c);
            component.set("v.qcMtlCompRecordId" , result.Id);
        });
        $A.enqueueAction(action);
    },
  
    hideSpinner : function(component, event, helper){
        component.set('v.Spinner',false);
    },
    fetchPicklistValues: function(component, controllerField, dependentField) {
        // call the server side function  
        var action = component.get("c.getDependentOptionsImplements");
        // pass paramerters [object name , contrller field name ,dependent field name] -
        // to server side function 
        
        action.setParams({
            'objDetail': 'QC_MTL_Component__c',
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField
        });
        //set callback   
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                //store the return response from server (map<string,List<string>>)  
                var StoreResponse = response.getReturnValue();
                
                // once set #StoreResponse to depnedentFieldMap attribute 
                component.set("v.mapofMaterialPlatingPickList", StoreResponse);
                
                // create a empty array for store map keys(@@--->which is controller picklist values) 
                
                var listOfkeys = []; // for store all map keys (controller picklist values)
                var ControllerField = []; // for store controller picklist value to set on ui field. 
                
                // play a for loop on Return map 
                // and fill the all map key on listOfkeys variable.
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
                
                //set the controller field value for ui:inputSelect  
                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: "None"
                    });
                }
                
                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push({
                        class: "optionClass",
                        label: listOfkeys[i],
                        value: listOfkeys[i]
                    });
                }
                // set the ControllerField variable values to country(controller picklist field)
                component.set("v.materialPickList", ControllerField);
            }
        });
        $A.enqueueAction(action);
        
    },
    fetchPicklistValuesDepartmemt: function(component, controllerField, dependentField) {
        // call the server side function  
        var action = component.get("c.getDependentOptionsImplements");
        // pass paramerters [object name , contrller field name ,dependent field name] -
        // to server side function 
        
        action.setParams({
            'objDetail': 'QC_MTL_Component__c',
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField
        });
        //set callback   
        action.setCallback(this, function(response) {
            // alert('----------'+response.getState());
            if (response.getState() == "SUCCESS") {
                //store the return response from server (map<string,List<string>>)  
                var StoreResponse = response.getReturnValue();
                
                // once set #StoreResponse to depnedentFieldMap attribute 
                component.set("v.mapofDepartmentRequiredTestPickList", StoreResponse);
                
                // create a empty array for store map keys(@@--->which is controller picklist values) 
                
                var listOfkeys = []; // for store all map keys (controller picklist values)
                var ControllerField = []; // for store controller picklist value to set on ui field. 
                
                // play a for loop on Return map 
                // and fill the all map key on listOfkeys variable.
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
                
                //set the controller field value for ui:inputSelect  
                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                
                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push({
                        class: "optionClass",
                        label: listOfkeys[i],
                        value: listOfkeys[i]
                    });
                }
                // set the ControllerField variable values to country(controller picklist field)
                component.set("v.departmentPickList", ControllerField);
            }
        });
        $A.enqueueAction(action);
    },
    fetchDepValues: function(component, ListOfDependentFields) {
        // create a empty array var for store dependent picklist values for controller field)  
        var dependentFields = [];
        
        if (ListOfDependentFields != undefined && ListOfDependentFields.length > 0) {
            dependentFields.push({
                class: "optionClass",
                label: "--- None ---",
                value: ""
            });
            
        }
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push({
                class: "optionClass",
                label: ListOfDependentFields[i],
                value: ListOfDependentFields[i]
            });
        }
        // set the dependentFields variable values to State(dependent picklist field) on ui:inputselect    
        component.set("v.platingPickList", dependentFields);
        // make disable false for ui:inputselect field 
        // component.set("v.isDependentDisable", false);
    },
    fetchRequiredTestValues : function(component, ListOfDependentFields){
        var dependentFields = [];
        
        if (ListOfDependentFields != undefined && ListOfDependentFields.length > 0) {
            dependentFields.push({
                class: "optionClass",
                label: "--- None ---",
                value: ""
            });
            
        }
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push({
                class: "optionClass",
                label: ListOfDependentFields[i],
                value: ListOfDependentFields[i]
            });
        }
        // set the dependentFields variable values to State(dependent picklist field) on ui:inputselect    
        component.set("v.requiredTestPickList", dependentFields);
        // make disable false for ui:inputselect field 
        // component.set("v.isDependentDisable", false);
    },
    getCustomSettingValues : function(component, event, helper){
        var action = component.get("c.getCustomSetting");
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set('v.allCustonSettingValues',result);  
            }
        });
        
        $A.enqueueAction(action);
        console.log(component.get('v.allCustonSettingValues'));
    },
    getSourcePickListValues : function(component,event,helper){
        var action = component.get("c.getPickListValue");
        action.setParams({
            objectApiName : 'QC_MTL_Component__c',
            pickListFieldApiName : 'New_Source_PickList__c'
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set('v.sourcePickList',result);  
            }
        });
        
        $A.enqueueAction(action);
    },
    getComponentNamePickListValues : function(component,event,helper){
        var action = component.get("c.getPickListValue");        
        action.setParams({
            objectApiName : 'QC_MTL_Component__c',
            pickListFieldApiName : 'Component_Name_New__c'
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                component.set('v.componentName',result);  
            }
        });
        
        $A.enqueueAction(action);
    },
    /* fetchChemicalCompPicklist : function(component, event, helper){
    var action=component.get("c.getSchemaValue");
        action.setCallback(this,function(response){
            var status = response.getState();
            if(status === "SUCCESS"){
                var result = response.getReturnValue();
                var listFromDB = result[0];
                var materialComplist = [];
                for(var i= 0 ; i <listFromDB.length; i++){
                    materialComplist.push({"label" :listFromDB[i],"value" :listFromDB[i],"selected" :false })
                }
                var listFromDB2 = result[1];
                var materialComplist2 = [];
                for(var i= 0 ; i <listFromDB2.length; i++){
                    materialComplist2.push({"label" :listFromDB2[i],"value" :listFromDB2[i],"selected" :false })
                }
                var listFromDB3 = result[2];
                var materialComplist3 = [];
                for(var i= 0 ; i <listFromDB3.length; i++){
                    materialComplist3.push({"label" :listFromDB3[i],"value" :listFromDB3[i],"selected" :false })
                }
                var listFromDB4 = result[3];
                var materialComplist4 = [];
                for(var i= 0 ; i <listFromDB4.length; i++){
                    materialComplist4.push({"label" :listFromDB4[i],"value" :listFromDB4[i],"selected" :false })
                }
                var listFromDB5 = result[4];
                var materialComplist5 = [];
                for(var i= 0 ; i <listFromDB5.length; i++){
                    materialComplist5.push({"label" :listFromDB5[i],"value" :listFromDB5[i],"selected" :false })
                }
                
                component.set('v.materialCompositionPickList',materialComplist);
                component.set('v.materialCompositionPickList2',materialComplist2);
                component.set('v.materialCompositionPickList3',materialComplist3);
                component.set('v.materialCompositionPickList4',materialComplist4);
                component.set('v.materialCompositionPickList5',materialComplist5);
                console.log(result);
            }
        });
        $A.enqueueAction(action);
    },*/
    fetchReSubRecords : function(component, event, helper){
        debugger;
        var action=component.get("c.fetchMaterialReSubData");
        var referenceId = component.get("v.referencedReSubReportId");
        //alert('--------data(referenced)--------'+data);
        action.setParams(
            {"reportRefId" : referenceId
             
            });
        action.setCallback(this,function(response){
            var state=response.getState();
            var departmentPickList = component.get("v.departmentPickList");
            var materialPickList = component.get("v.materialPickList");
            /* var materialCompositionPickList = component.get("v.materialCompositionPickList");
            var materialCompositionPickList2 = component.get("v.materialCompositionPickList2");
            var materialCompositionPickList3 = component.get("v.materialCompositionPickList3");
            var materialCompositionPickList4 = component.get("v.materialCompositionPickList4");
            var materialCompositionPickList5 = component.get("v.materialCompositionPickList5");*/
            if(state=="SUCCESS"){
                var result=response.getReturnValue();
                var titanSpec = {};
                if(result[0].Titan_Specification_Reference__c != undefined && result[0].Titan_Specification_Reference__c != null && result[0].Titan_Specification_Reference__c != ''){
                    titanSpec = {'sobjectType' : 'QC_Access_Master__c', 'Id': result[0].Titan_Specification_Reference__c, 'Name' : result[0].Titan_Specification_Reference__r.Name};
                }
                var supplierGrade = {};
                if(result[0].Supplier_Grade__c != undefined && result[0].Supplier_Grade__c != null && result[0].Supplier_Grade__c != ''){
                    supplierGrade = {'sobjectType' : 'Supplier_Grade__c', 'Id': result[0].Supplier_Grade__c, 'Name' : result[0].Supplier_Grade__r.Name};
                }
                var brandName = {};
                if(result[0].Brand__c != undefined && result[0].Brand__c != null && result[0].Brand__c != ''){
                    brandName = {'sobjectType' : 'QC_Access_Master__c', 'Id': result[0].Brand__c, 'Name' : result[0].Brand__r.Name};
                }
                var suplrName = {};
                if(result[0].Supplier_Name_New__c !=undefined && result[0].Supplier_Name_New__c !=''){
                    suplrName ={'sobjectType' : 'QC_Access_Master__c', 'Id': result[0].Supplier_Name_New__c, 'Name' : result[0].Supplier_Name_New__r.Name};
                }
                var PlaterName = {};
                if(result[0].plater_Name__c !=undefined && result[0].plater_Name__c !=''){
                    PlaterName ={'sobjectType' : 'QC_Access_Master__c', 'Id': result[0].plater_Name__c, 'Name' : result[0].plater_Name__r.Name};
                }
                component.set("v.reportReferenceValue",result[0].Report_Reference_Number__c);
                //component.set("v.parentSampleType",result[0].Material_Sample_Type__c);
                component.set("v.parentTestingType",result[0].Testing_Type__c);
                component.set("v.parentMaterialType",result[0].Raw_Material_Type__c);
                component.set("v.rawMaterial",result[0].Raw_Material_Name__c);
                //component.set("v.documentStatusValue",result[0].Document_Status__c);
                component.set("v.selectedLookUpRecordForTitanSpec" ,titanSpec );
                component.set("v.prepopulateCount", component.get("v.prepopulateCount") + 1);
                //component.set("v.recordStatusValue",result[0].Record_Status__c);
                component.set("v.specRevisionValue",result[0].Specification_revision__c);
                //component.set("v.supplierName",result[0].Supplier_Name__c);
                component.set("v.invoiceNo",result[0].Invoice_Dc_No__c);
                component.set("v.RMSize",result[0].RM_Size__c);
                component.set("v.heatNo",result[0].Heat_No_Grade__c);
                component.set("v.supplyQty",result[0].Supply_Quantity__c);
                component.set("v.sampleSize",result[0].Sample_Size_Qty__c);
                component.set("v.selectedLookUpRecordForSupplierGrd",supplierGrade);
                component.set("v.prepopulateSupplierCount", component.get("v.prepopulateSupplierCount") + 1);
                component.set("v.mtlSelectedLookupRecForSuplrName",suplrName);
                component.set("v.mtlSelectedLookupRecForPlaterName",PlaterName);
                component.set("v.lookupValueIncrmntrForSuplrName",component.get("v.lookupValueIncrmntrForSuplrName")+1);
                component.set("v.sampleRecvdFrom",result[0].Sample_Received_From__c);
                component.set("v.PlatingRemarks",result[0].Remarks__c);
                component.set("v.mtlUserEmail",result[0].MTL_User_Email__c);
                for(var i = 0;i <departmentPickList.length; i ++){
                    if(departmentPickList[i].value == result[0].Department__c){
                        departmentPickList[i].selected = result[0].Department__c;
                        component.set('v.selectedDepartmentValue',result[0].Department__c);
                        break;
                    }
                }
                component.set("v.partName",result[0].Part_Name__c);
                component.set("v.sourceField",result[0].Source__c);
                component.set("v.modelField",result[0].Model__c);
                component.set("v.docketNumberField",result[0].Docket_Number__c);
                component.set("v.batchQuantityField",result[0].Batch_Quantity__c);
               // debugger;
                for(var prop in brandName){
                    if(brandName.hasOwnProperty(prop)){
                       	component.set("v.selectedLookUpRecordForBrand",brandName);
                		component.set("v.prepopulateBrandCount", component.get("v.prepopulateBrandCount") + 1);  
                    }	
                }
                
                for(var i = 0;i < materialPickList.length; i++){
                    if(materialPickList[i].value == result[0].Material__c){
                        materialPickList[i].selected = result[0].Material__c;
                        component.set('v.selectedMaterialValue',result[0].Material__c);
                        break; 
                    }
                }
                var MapForPlatingPickList = component.get("v.mapofMaterialPlatingPickList");
                var ListOfPlatingFieldsOnLoad = MapForPlatingPickList[result[0].Material__c];
                if(ListOfPlatingFieldsOnLoad != undefined){
                    this.fetchDepValues(component, ListOfPlatingFieldsOnLoad); 
                }
                
                var platingPickList = component.get("v.platingPickList");
                
                for(var i = 0;i < platingPickList.length; i++){
                    if(platingPickList[i].value == result[0].Plating_Type__c){
                        platingPickList[i].selected = result[0].Plating_Type__c;
                        component.set('v.selectedPlatingTypeValue',result[0].Plating_Type__c);
                        break; 
                    }
                }
                
                // component.set("v.specRevisionValue",result[0].Specification_revision__c);
                
                var MapForReqPickList = component.get("v.mapofDepartmentRequiredTestPickList");//to fetch the required test list which is dependent on department picklist
                //var ListOfDependentFieldsOnLoad = MapForReqPickList[result[0].Department__c];
                if(result[0].Department__c != undefined && result[0].Department__c !='' && result[0].Department__c !=null){
                    this.fetchRequiredTestValues(component, ListOfDependentFieldsOnLoad);
                }
                var requiredTestPickList = component.get("v.requiredTestPickList");
                
                for(var i = 0;i < requiredTestPickList.length; i++){
                    if(requiredTestPickList[i].value == result[0].Required_Test__c){
                        requiredTestPickList[i].selected = result[0].Required_Test__c;
                        component.set('v.selectedRequiredTestValue',result[0].Required_Test__c);
                        break; 
                    }
                }
                component.set("v.SampleSizePlatingField",result[0].Sample_Size_Plating__c);
                component.set("v.componentNameValue",result[0].Component_Name__c);
                var deptName=component.get('v.selectedDepartmentValue');
                if(deptName!=undefined && deptName.includes('Other')){
                    component.set('v.IfSelectedDeptOthers',true);
                    component.set('v.OtherDept',result[0].Actual_Department_Name__c)
                }else{
                    component.set('v.IfSelectedDeptOthers',false);
                }
                //component.find("chemicalPickListId").set("v.value",result[0].Chemical_Composition_Elements__c);
                /*  for(var i = 0;i < materialCompositionPickList.length; i++){
                    if(materialCompositionPickList[i].value == result[0].Chemical_Composition_Elements__c){
                       materialCompositionPickList[i].selected = result[0].Chemical_Composition_Elements__c;
                       break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList2.length; i++){
                    if(materialCompositionPickList2[i].value == result[0].Chemical_Composition_Elements_2__c){
                       materialCompositionPickList2[i].selected = result[0].Chemical_Composition_Elements_2__c;
                       break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList3.length; i++){
                    if(materialCompositionPickList3[i].value == result[0].Chemical_Composition_Elements_3__c){
                       materialCompositionPickList3[i].selected = result[0].Chemical_Composition_Elements_3__c;
                       break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList4.length; i++){
                    if(materialCompositionPickList4[i].value == result[0].Chemical_Composition_Elements_4__c){
                       materialCompositionPickList4[i].selected = result[0].Chemical_Composition_Elements_4__c;
                       break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList5.length; i++){
                    if(materialCompositionPickList5[i].value == result[0].Chemical_Composition_Elements_5__c){
                       materialCompositionPickList5[i].selected = result[0].Chemical_Composition_Elements_5__c;
                       break; 
                    }
                }*/
                
            }
        });
        $A.enqueueAction(action);
        
    },
    fetchOptionTestValue : function(component, event, helper){
        var action=component.get('c.getOptionTestValues');
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.optionalTestCustomSettingValues',result);
                // alert(''+result);
                
            }
        });
        $A.enqueueAction(action);
    },
    
    setSpecificationRevision : function(component, event, helper, titanSpecificationId){
        var action=component.get('c.specRevisionValue');
        action.setParams(
            {"titanSpecificationId" : titanSpecificationId
             
            });
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                component.set('v.specRevisionValue',result[0].Specification_Revision__c);
                //component.set("v.tclDesignation",result[0].TCL_Designation__c);
            }
        });
        $A.enqueueAction(action);
    },
    getSuggestionValue : function(component, event, helper){
        var availableTags;
        var action=component.get('c.getAllRawMaterialName');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state==="SUCCESS"){
                availableTags=response.getReturnValue();
                $( "#AutoSuggestion" ).autocomplete({
                    source: availableTags
                });
            }
        });
        $A.enqueueAction(action);
    },
    setTCLDesignation : function(component, event, helper, supplierGradeId){
        var action=component.get('c.tclDesignationValue');
        action.setParams(
            {
                "supplierGradeID" : supplierGradeId
             
            });
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                //component.set('v.specRevisionValue',result[0].Specification_Revision__c);
                component.set("v.tclDesignation",result[0].TCL_Designation__c);
            }
        });
        $A.enqueueAction(action);
    },
    setSuplrName : function(component,event,helper,suplrNameId){
      var action = component.get('c.suplrNameValue');
        action.setParams({"suplrNameId" : suplrNameId});
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                //component.set('v.specRevisionValue',result[0].Specification_Revision__c);
                //component.set("v.tclDesignation",result[0].TCL_Designation__c);
            }
        });
        $A.enqueueAction(action);
    }, 
    
    setPlaterName : function(component,event,helper,PlaterNameId){
      var action = component.get('c.PlaterNameValue');
        action.setParams({"PlaterNameId" : PlaterNameId});
        action.setCallback(this,function(response){
            if(response.getState() == "SUCCESS"){
                var result = response.getReturnValue();
                //component.set('v.specRevisionValue',result[0].Specification_Revision__c);
                //component.set("v.tclDesignation",result[0].TCL_Designation__c);
            }
        });
        $A.enqueueAction(action);
    },
    validationCheckStringHasSpeciNumber : function(batchQueString){
        
    	var checkStringHasNuberSpe = new RegExp("[0-9!@#$%^&*(),.?:{}|<>]");
    	var stringHasAlp =new RegExp("[A-Za-z]");
        if(checkStringHasNuberSpe.test(batchQueString)){
            if(stringHasAlp.test(batchQueString)){
            	return true;
            } else {
                return false;
            }
        }
	}
    
})