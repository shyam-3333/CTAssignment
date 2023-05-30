({
    fetchPicklistValues: function(component, controllerField, dependentField) {
        // call the server side function  
        var action = component.get("c.getDependentOptionsImplements");
        // pass paramerters [object name , contrller field name ,dependent field name] -
        // to server side function 
        
        action.setParams({
            'objApiName': 'QC_MTL_Component__c',
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
                component.set("v.materialPickList", ControllerField);
            }
        });
        $A.enqueueAction(action);
    },
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
    
    fetchPicklistValuesDepartmemt: function(component, controllerField, dependentField) {
        // call the server side function  
        var action = component.get("c.getDependentOptionsImplements");
        // pass paramerters [object name , contrller field name ,dependent field name] -
        // to server side function 
        
        action.setParams({
            'objApiName': 'QC_MTL_Component__c',
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
                //component.find("departmentPickListId").set("v.value",'IDI');
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
    fetchChemicalCompPicklist : function(component, event, helper){
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
                //component.set('v.materialCompositionPickList',result[0]);
                console.log(result);
            }
        });
        $A.enqueueAction(action);
    },
    fetchRecordInfo : function(component, event, helper){
        
        var action=component.get("c.fetchRecordInfo");
        action.setParams({
            'Info' : component.get('v.referencedReportrecordObject')
        });
        action.setCallback(this,function(response){
            var status = response.getState();
            var departmentPickList = component.get("v.departmentPickList");
            var materialPickList = component.get("v.materialPickList");
            var materialCompositionPickList = component.get("v.materialCompositionPickList");
            var materialCompositionPickList2 = component.get("v.materialCompositionPickList2");
            var materialCompositionPickList3 = component.get("v.materialCompositionPickList3");
            var materialCompositionPickList4 = component.get("v.materialCompositionPickList4");
            var materialCompositionPickList5 = component.get("v.materialCompositionPickList5");
            if(status === "SUCCESS"){
                var result = response.getReturnValue();
                var titanSpec = {};
                if(result.records[0].Titan_Specification_Reference__c != undefined && result.records[0].Titan_Specification_Reference__c != null && result.records[0].Titan_Specification_Reference__c != ''){
                    titanSpec = {'sobjectType' : 'QC_Access_Master__c', 'Id': result.records[0].Titan_Specification_Reference__c, 'Name' : result.records[0].Titan_Specification_Reference__r.Name};
                }
                var brandName = {};
                if(result.records[0].Brand__c != undefined && result.records[0].Brand__c != null && result.records[0].Brand__c != ''){
                    brandName = {'sobjectType' : 'QC_Access_Master__c', 'Id': result.records[0].Brand__c, 'Name' : result.records[0].Brand__r.Name};
                }
                var suplrName={};
                if(result.records[0].Supplier_Name_New__c != undefined && result.records[0].Supplier_Name_New__c != null && result.records[0].Supplier_Name_New__c != ''){
                    suplrName = {'sObject' :'QC_Access_Master__c', 'Id' :result.records[0].Supplier_Name_New__c,'Name' : result.records[0].Supplier_Name_New__r.Name};  
                }
               //debugger;
                var platerName={};
                if(result.records[0].plater_Name__c != undefined && result.records[0].plater_Name__c != null && result.records[0].plater_Name__c != ''){
                    platerName = {'sObject' :'QC_Access_Master__c', 'Id' :result.records[0].plater_Name__c,'Name' : result.records[0].plater_Name__r.Name};  
                }
                debugger;
                component.set("v.componentAccValue",result.records[0].Component_Accessories__c);
                component.set("v.componentOtherValue",result.records[0].Component_Others__c);
                component.set("v.mtlSelectedLookupRecForSuplrName",suplrName);
                component.set("v.mtlSelectedLookupRecForPlaterName",platerName);
                component.set("v.selectedLookUpRecordForTitanSpec" ,titanSpec );
                component.set('v.MaterialCompositionValue1',result.records[0].Chemical_Composition_ElementsObservation__c);
                component.set('v.MaterialCompositionValue2',result.records[0].Chemical_Composition_ElementsObser1__c);
                component.set('v.MaterialCompositionValue3',result.records[0].Chemical_Composition_ElementsObser2__c);
                component.set('v.MaterialCompositionValue4',result.records[0].Chemical_Composition_ElementsObser3__c);
                component.set('v.MaterialCompositionValue5',result.records[0].Chemical_Composition_ElementsObser4__c);
                component.set('v.MaterialCompositionResult1',result.records[0].Chemical_Composition_ElementsResult__c);
                component.set('v.MaterialCompositionResult2',result.records[0].Chemical_Composition_ElementsResult1__c);
                component.set('v.MaterialCompositionResult3',result.records[0].Chemical_Composition_ElementsResult2__c);
                component.set('v.MaterialCompositionResult4',result.records[0].Chemical_Composition_ElementsResult3__c);
                component.set('v.MaterialCompositionResult5',result.records[0].Chemical_Composition_ElementsResult4__c);
                component.set("v.prepopulateCount", component.get("v.prepopulateCount") + 1);
                component.set('v.lookupValueIncrmntrForSuplrName',component.get("v.lookupValueIncrmntrForSuplrName") + 1);
                component.set('v.lookupValueIncrmntrForPlaterName',component.get("v.lookupValueIncrmntrForPlaterName") + 1);
                component.set("v.specRevisionValue",result.records[0].Specification_revision__c);
                component.set('v.partName',result.records[0].Part_Name__c);
                component.set('v.sourceField',result.records[0].Source__c);
                component.set('v.modelField',result.records[0].Model__c);
                component.set('v.docketNumberField',result.records[0].Docket_Number__c);
                component.set('v.batchQuantityField',result.records[0].Batch_Quantity__c);
                component.set('v.PlatingRemarks',result.records[0].Remarks__c);
                component.set('v.SampleSizePlatingField',result.records[0].Sample_Size_Plating__c);
                component.set('v.componentNameValue',result.records[0].Component_Name__c);
                
                if(result.records[0].Component_Name__c=='Accessories' ){
                    component.set("v.showAccessories",true);
                }
                else if(result.records[0].Component_Name__c =='Others'){
                    component.set("v.showOthers",true);
                }
                for(var i = 0;i <departmentPickList.length; i ++){
                    if(component.get('v.parentTestingType')=='Plating'){
                        if(departmentPickList[i].value == result.records[0].Department__c){
                            departmentPickList[i].selected = result.records[0].Department__c;
                            component.set('v.selectedDepartmentValue',result.records[0].Department__c);
                            break;
                        }
                    }
                    if(component.get('v.parentTestingType')=='Plating and Material Composition'){
                        if(departmentPickList[i].value == result.records[0].Department_PMC__c){
                            departmentPickList[i].selected = result.records[0].Department_PMC__c;
                            component.set('v.selectedDepartmentValue',result.records[0].Department_PMC__c);
                            break;
                        }
                    }
                }
                component.set("v.selectedLookUpRecordForBrand",brandName);
                component.set("v.prepopulateBrandCount", component.get("v.prepopulateBrandCount") + 1);
                //Added newly on 11/04/19, as asked by Ashok for specification revision-->
                component.set("v.specRevisionValue",result.records[0].Specification_revision__c);  
                for(var i = 0;i < materialPickList.length; i++){
                    if(materialPickList[i].value == result.records[0].Material__c){
                        materialPickList[i].selected = result.records[0].Material__c;
                        component.set('v.selectedMaterialValue',result.records[0].Material__c);
                        break; 
                    }
                }
                var MapForPlatingPickList = component.get("v.mapofMaterialPlatingPickList");
                var ListOfPlatingFieldsOnLoad = MapForPlatingPickList[result.records[0].Material__c];
                if(ListOfPlatingFieldsOnLoad != undefined){
                    this.fetchDepValues(component, ListOfPlatingFieldsOnLoad); 
                }
                
                var platingPickList = component.get("v.platingPickList");
                
                for(var i = 0;i < platingPickList.length; i++){
                    if(platingPickList[i].value == result.records[0].Plating_Type__c){
                        platingPickList[i].selected = result.records[0].Plating_Type__c;
                        component.set('v.selectedPlatingTypeValue',result.records[0].Plating_Type__c);
                        break; 
                    }
                }
                
                var MapForReqPickList = component.get("v.mapofDepartmentRequiredTestPickList");//to fetch the required test list which is dependent on department picklist
                var ListOfDependentFieldsOnLoad;
                if(component.get('v.parentTestingType')=='Plating'){
                    ListOfDependentFieldsOnLoad = MapForReqPickList[result.records[0].Department__c];
                }
                if(component.get('v.parentTestingType')=='Plating and Material Composition'){
                    ListOfDependentFieldsOnLoad = MapForReqPickList[result.records[0].Department_PMC__c];
                }
                if(ListOfDependentFieldsOnLoad != undefined){
                    this.fetchRequiredTestValues(component, ListOfDependentFieldsOnLoad);
                }
                var requiredTestPickList = component.get("v.requiredTestPickList");
                
                for(var i = 0;i < requiredTestPickList.length; i++){
                    if(component.get('v.parentTestingType')=='Plating'){
                        if(requiredTestPickList[i].value == result.records[0].Required_Test__c){
                            requiredTestPickList[i].selected = result.records[0].Required_Test__c;
                            component.set('v.selectedRequiredTestValue',result.records[0].Required_Test__c);
                            break; 
                        }
                    }
                    if(component.get('v.parentTestingType')=='Plating and Material Composition'){
                        if(requiredTestPickList[i].value == result.records[0].Required_test_PMC__c){
                            requiredTestPickList[i].selected = result.records[0].Required_test_PMC__c;
                            component.set('v.selectedRequiredTestValue',result.records[0].Required_test_PMC__c); 
                            break; 
                        }
                    }
                }
                for(var i = 0;i < materialCompositionPickList.length; i++){
                    if(materialCompositionPickList[i].value == result.records[0].Chemical_Composition_Elements__c){
                        materialCompositionPickList[i].selected = result.records[0].Chemical_Composition_Elements__c;
                        break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList2.length; i++){
                    if(materialCompositionPickList2[i].value == result.records[0].Chemical_Composition_Elements_2__c){
                        materialCompositionPickList2[i].selected = result.records[0].Chemical_Composition_Elements_2__c;
                        break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList3.length; i++){
                    if(materialCompositionPickList3[i].value == result.records[0].Chemical_Composition_Elements_3__c){
                        materialCompositionPickList3[i].selected = result.records[0].Chemical_Composition_Elements_3__c;
                        break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList4.length; i++){
                    if(materialCompositionPickList4[i].value == result.records[0].Chemical_Composition_Elements_4__c){
                        materialCompositionPickList4[i].selected = result.records[0].Chemical_Composition_Elements_4__c;
                        break; 
                    }
                }
                for(var i = 0;i < materialCompositionPickList5.length; i++){
                    if(materialCompositionPickList5[i].value == result.records[0].Chemical_Composition_Elements_5__c){
                        materialCompositionPickList5[i].selected = result.records[0].Chemical_Composition_Elements_5__c;
                        break; 
                    }
                }
                var requiredTest=component.get('v.selectedRequiredTestValue');
                //    if(requiredTest=='Full Test' || requiredTest=='Stock Audit'){
                //        component.set('v.toggelOptionalTest',false); 
                //    }
                //    else{
                //        component.set('v.toggelOptionalTest',true);   
                //    }
                // var listoption=component.get('v.optionalTestCustomSettingValues');
                var customSettingValues=component.get('v.optionalTestCustomSettingValues');
                var temp=[];
                var testingType;
                if(component.get('v.parentTestingType')=='Plating'){
                    testingType='PL';
                }
                else if(component.get('v.parentTestingType')=='Plating and Material Composition'){
                    testingType='PMC';
                }
                var data;
                if(customSettingValues.length!=0){
                    for(var x=0;x<customSettingValues.length;x++){
                        var dt=customSettingValues[x].split(',');
                        if(dt[0]==testingType && dt[1]==component.get('v.selectedDepartmentValue') && dt[2]==component.get('v.selectedRequiredTestValue')){
                            data=dt;
                            break;
                        }
                    }
                    if(data!=undefined){
                        for(var y=3;y<data.length;y++){
                            var templabel={'label' : data[y],'value' : data[y]};
                            temp.push(templabel);
                        }
                        component.set('v.multiOptionalValues',temp);
                    }
                    else{
                        component.set('v.multiOptionalValues',[]);  
                    }
                    
                }
                if(result.getplatingValues.length!=0 && result.records[0].Optional_Test__c!=undefined){
                    //component.set('v.multiOptionalValues',result.getplatingValues);
                    var allValues=result.getplatingValues;
                    var getvalues=result.records[0].Optional_Test__c.split(',');
                    
                    component.set('v.selectedvalues',getvalues);
                    var templist=[];
                    var ishasMCValue=false;
                    for(var x=0;x<getvalues.length;x++){
                        if(getvalues[x]!="Material Composition"){
                            var dt={'userInput' : 'Pass','testVerdict' : '','testName' : getvalues[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Optional'};
                            templist.push(dt);
                        }else{
                            ishasMCValue=true;
                        }
                    }
                    component.set("v.optionalTesthaveMCValue",ishasMCValue);
                    component.set('v.optionalTestValues',templist);
                    var reqTest11 =result.records[0].Required_test_PMC__c;
                    var dep11 =result.records[0].Department_PMC__c;
                    if((dep11 =='Customer Assurance' || dep11 =='NPD' || dep11 =='IDI' || dep11 =='QC Appearance') && (reqTest11 =='Analysis')){
                        ishasMCValue = true;
                        component.set("v.optionalTesthaveMCValue",ishasMCValue);
                        
                    }
                    //allValues.filter(function(data){
                    //    ret
                    //});
                }
                else{
                    //  component.set('v.multiOptionalValues',result.getplatingValues);
                }
                var deptName=component.get('v.selectedDepartmentValue');
                if(deptName!=undefined && deptName.includes('Other')){
                    component.set('v.IfSelectedDeptOthers',true);
                    component.set('v.OtherDept',result.records[0].Actual_Department_Name__c);
                }
            }
            
        });
        $A.enqueueAction(action);
    },
    saveRecord : function(component, event, helper){
        /* var sObjectRecordValidation={v.partName};
                                     v.selectedDepartmentValue
                                     v.sourceField
                                     v.modelField
                                     v.supplierName
                                     v.docketNumberField
                                     v.batchQuantityField
                                     v.selectedLookUpRecordForTitanSpec
                                     v.SampleSizePlatingField
                                     v.selectedMaterialValue
                                     v.selectedPlatingTypeValue
                                     v.selectedRequiredTestValue*/
        //
        //  alert('eneterbnnsj sdhjdj');
        /* var data={
            'sObject' : 'QC_MTL_Component__c',
            'Id' : component.get('v.referencedReportrecordObject.Id'),
            'Department__c' : component.get('v.selectedDepartmentValue'),
            'Part_Name__c' : component.get('v.partName'),
            'Source__c' : component.get('v.sourceField'),
            'Model__c' : component.get('v.modelField'),
            'Supplier_Name__c' : component.get('v.supplierName'),
            'Docket_Number__c' : component.get('v.docketNumberField'),
            'Batch_Quantity__c' : component.get('v.batchQuantityField'),
            'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
            'Material__c' : component.get('v.selectedMaterialValue'),
            'Titan_Specification_Reference__c' : component.get('v.selectedLookUpRecordForTitanSpec.Id'),
            'Plating_Type__c' : component.get('v.selectedPlatingTypeValue'),
            'Required_Test__c' : component.get('v.selectedRequiredTestValue'),
            'Optional_Test__c' : component.get('v.selectedvalues').toString(),
            'Chemical_Composition_Elements__c': component.get('v.selectedMaterialCompValue'),
            'Chemical_Composition_Elements_2__c': component.get('v.selectedMaterialCompValue2'),
            'Chemical_Composition_Elements_3__c': component.get('v.selectedMaterialCompValue3'),
            'Chemical_Composition_Elements_4__c': component.get('v.selectedMaterialCompValue4'),
            'Chemical_Composition_Elements_5__c': component.get('v.selectedMaterialCompValue5'),
            'Component_Name__c' : component.get('v.componentNameValue'),
            'Chemical_Composition_ElementsObservation__c': component.get('v.MaterialCompositionValue1'),
            'Chemical_Composition_ElementsObser1__c' : component.get('v.MaterialCompositionValue2'),
            'Chemical_Composition_ElementsObser2__c' : component.get('v.MaterialCompositionValue3'),
            'Chemical_Composition_ElementsObser3__c' : component.get('v.MaterialCompositionValue4'),
            'Chemical_Composition_ElementsObser4__c' : component.get('v.MaterialCompositionValue5'),
            'Chemical_Composition_ElementsResult__c' : component.get('v.MaterialCompositionResult1'),
            'Chemical_Composition_ElementsResult1__c' : component.get('v.MaterialCompositionResult2'),
            'Chemical_Composition_ElementsResult2__c' : component.get('v.MaterialCompositionResult3'),
            'Chemical_Composition_ElementsResult3__c' : component.get('v.MaterialCompositionResult4'),
            'Chemical_Composition_ElementsResult4__c' : component.get('v.MaterialCompositionResult5')
        };*/
       //debugger;
        var data;
        var testType=component.get('v.parentTestingType');
        if(testType=='Plating'){
            data={
                'sObject' : 'QC_MTL_Component__c',
                'Id' : component.get('v.referencedReportrecordObject.Id'),
                'Department__c' : component.get('v.selectedDepartmentValue'),
                'Part_Name__c' : component.get('v.partName'),
                'Source__c' : component.get('v.sourceField'),
                'Model__c' : component.get('v.modelField'),
                'Docket_Number__c' : component.get('v.docketNumberField'),
                'Batch_Quantity__c' : component.get('v.batchQuantityField'),
                'Remarks__c' : component.get('v.PlatingRemarks'),
                'General_Observation__c' :component.get("v.genrlObsrvtn"),   
                'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                'Specification_revision__c' : component.get('v.specRevisionValue'),
                'Material__c' : component.get('v.selectedMaterialValue'),
                'Titan_Specification_Reference__c' : component.get('v.selectedLookUpRecordForTitanSpec.Id'),
                'Plating_Type__c' : component.get('v.selectedPlatingTypeValue'),
                'Required_Test__c' : component.get('v.selectedRequiredTestValue'),
                'Optional_Test__c' : component.get('v.selectedvalues').toString(),
                'Chemical_Composition_Elements__c': component.get('v.selectedMaterialCompValue'),
                'Chemical_Composition_Elements_2__c': component.get('v.selectedMaterialCompValue2'),
                'Chemical_Composition_Elements_3__c': component.get('v.selectedMaterialCompValue3'),
                'Chemical_Composition_Elements_4__c': component.get('v.selectedMaterialCompValue4'),
                'Chemical_Composition_Elements_5__c': component.get('v.selectedMaterialCompValue5'),
                'Component_Name__c' : component.get('v.componentNameValue'),
                'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                'Chemical_Composition_ElementsObservation__c': component.get('v.MaterialCompositionValue1'),
                'Chemical_Composition_ElementsObser1__c' : component.get('v.MaterialCompositionValue2'),
                'Chemical_Composition_ElementsObser2__c' : component.get('v.MaterialCompositionValue3'),
                'Chemical_Composition_ElementsObser3__c' : component.get('v.MaterialCompositionValue4'),
                'Chemical_Composition_ElementsObser4__c' : component.get('v.MaterialCompositionValue5'),
                'Chemical_Composition_ElementsResult__c' : component.get('v.MaterialCompositionResult1'),
                'Chemical_Composition_ElementsResult1__c' : component.get('v.MaterialCompositionResult2'),
                'Chemical_Composition_ElementsResult2__c' : component.get('v.MaterialCompositionResult3'),
                'Chemical_Composition_ElementsResult3__c' : component.get('v.MaterialCompositionResult4'),
                'Chemical_Composition_ElementsResult4__c' : component.get('v.MaterialCompositionResult5')
            };
            
        }
        if(testType=='Plating and Material Composition'){
            var dataVal;
            var datavar1;
            if(component.get("v.componentNameValue") =='Accessories' && component.get("v.componentAccValue") !=undefined){
                dataVal = component.get("v.componentAccValue");
            }else{
                dataVal=undefined;
            }
            if(component.get("v.componentNameValue") =='Others' && component.get("v.componentOtherValue") !=undefined){
                
                datavar1 = component.get("v.componentOtherValue");
            }else{
                datavar1=undefined;
            }
            data={
                'sObject' : 'QC_MTL_Component__c',
                'Id' : component.get('v.referencedReportrecordObject.Id'),
                'Department_PMC__c' : component.get('v.selectedDepartmentValue'),
                'Part_Name__c' : component.get('v.partName'),
                'Source__c' : component.get('v.sourceField'),
                'Model__c' : component.get('v.modelField'),
                'Docket_Number__c' : component.get('v.docketNumberField'),
                'Batch_Quantity__c' : component.get('v.batchQuantityField'),
                'Remarks__c' : component.get('v.PlatingRemarks'),
                'General_Observation__c' :component.get("v.genrlObsrvtn"), 
                'Specification_revision__c' : component.get('v.specRevisionValue'),  
                'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                'Material__c' : component.get('v.selectedMaterialValue'),
                'Titan_Specification_Reference__c' : component.get('v.selectedLookUpRecordForTitanSpec.Id'),
                'Plating_Type__c' : component.get('v.selectedPlatingTypeValue'),
                'Required_test_PMC__c' : component.get('v.selectedRequiredTestValue'),
                'Optional_Test__c' : component.get('v.selectedvalues').toString(),
                'Chemical_Composition_Elements__c': component.get('v.selectedMaterialCompValue'),
                'Chemical_Composition_Elements_2__c': component.get('v.selectedMaterialCompValue2'),
                'Chemical_Composition_Elements_3__c': component.get('v.selectedMaterialCompValue3'),
                'Chemical_Composition_Elements_4__c': component.get('v.selectedMaterialCompValue4'),
                'Chemical_Composition_Elements_5__c': component.get('v.selectedMaterialCompValue5'),
                'Component_Name__c' : component.get('v.componentNameValue'),
                'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                'plater_Name_c' : component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                'Chemical_Composition_ElementsObservation__c': component.get('v.MaterialCompositionValue1'),
                'Chemical_Composition_ElementsObser1__c' : component.get('v.MaterialCompositionValue2'),
                'Chemical_Composition_ElementsObser2__c' : component.get('v.MaterialCompositionValue3'),
                'Chemical_Composition_ElementsObser3__c' : component.get('v.MaterialCompositionValue4'),
                'Chemical_Composition_ElementsObser4__c' : component.get('v.MaterialCompositionValue5'),
                'Chemical_Composition_ElementsResult__c' : component.get('v.MaterialCompositionResult1'),
                'Chemical_Composition_ElementsResult1__c' : component.get('v.MaterialCompositionResult2'),
                'Chemical_Composition_ElementsResult2__c' : component.get('v.MaterialCompositionResult3'),
                'Chemical_Composition_ElementsResult3__c' : component.get('v.MaterialCompositionResult4'),
                'Chemical_Composition_ElementsResult4__c' : component.get('v.MaterialCompositionResult5'),
                'Component_Accessories__c' : dataVal,
                'Component_Others__c'    : datavar1,
            };
        }
        var alltestParaMeterList=component.get('v.alltestParaMeterList');
        var addNewTestValueList=component.get('v.addNewTestValueList');
        var mandatoryTestValues=[];
        var newTestValues=[];
        if(addNewTestValueList!=undefined && addNewTestValueList.length!=0){
            for(var n in addNewTestValueList){
                if(addNewTestValueList[n].minValue==""){
                    addNewTestValueList[n].minValue=null;
                }
                if(addNewTestValueList[n].maxValue=="")
                    addNewTestValueList[n].maxValue=null;
            }
        }
        
        
        for(var i=0;i<alltestParaMeterList.length;i++){
            var datatemp={'sObject' : 'QC_MTL_TestResponse__c',
                          'QC_Test_Questions_Value__c' : alltestParaMeterList[i].qcMTLQuestionRecordId,
                          'User_Defined_Value__c' : alltestParaMeterList[i].userInput,
                          'Result__c' : alltestParaMeterList[i].testVerdict,
                          'QC_MTL_Test__c' : alltestParaMeterList[i].testRecordId,
                          'Name': alltestParaMeterList[i].testName,
                          'QC_MTL_Component_del__c': alltestParaMeterList[i].QCMTLComponent,
                          'Standard_Defined_Value__c' : alltestParaMeterList[i].standardDefinedValue,
                          'Minimum__c' :alltestParaMeterList[i].minValue,
                          'Maximum__c' : alltestParaMeterList[i].maxValue};
            mandatoryTestValues.push(datatemp);
        }
        for(var i=0;i<addNewTestValueList.length;i++){
            var datatemp1={'qcMTLQuestionRecordId':addNewTestValueList[i].qcMTLQuestionRecordId,
                           'userInput' : addNewTestValueList[i].userInput,
                           'testVerdict' : addNewTestValueList[i].testVerdict,
                           'testRecordId' : addNewTestValueList[i].testRecordId,
                           'standardDefinedValue' : addNewTestValueList[i].standardDefinedValue,
                           'testName' : addNewTestValueList[i].testName,
                           'QCMTLComponent' : addNewTestValueList[i].QCMTLComponent,
                           'minValue' : addNewTestValueList[i].minValue,
                           'maxValue' : addNewTestValueList[i].maxValue};
            newTestValues.push(datatemp1);
        }
        var optionalTest;
        if(component.get('v.generateTestParameter')){
            optionalTest=JSON.stringify(component.get('v.optionalTestValues'));
        }
        else{
            var lis=[];
            optionalTest=JSON.stringify(lis);
        }
        
        var regularTest;
        if(component.get('v.generateTestParameter')){
            regularTest=JSON.stringify(component.get('v.generateRegularTest'));
        }
        else{
            var lisr=[];
            regularTest=JSON.stringify(lisr);
        }
        
        var action=component.get('c.saveRecordMethod');
        action.setParams({
            'recordInfo' : data,
            'mandatoryTest' : mandatoryTestValues,
            'newTest' : JSON.stringify(newTestValues),
            'optionalTest' : optionalTest,
            'regularTest' : regularTest
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success Message',
                    message: 'Record Updated Successfully!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
                var result = response.getReturnValue();
                component.set('v.alltestParaMeterList',result.TestLists);
                component.set('v.generateRegularTest',result.regularTestLists);
                component.set('v.optionalTestValues',result.optionalTests);
                component.set('v.addNewTestValueList',[]);
                component.set('v.indexValue',result.TestLists.length);
                var fillerData=result.TestLists.filter(function(n){
                    return n.IsmandatoryTest==true;
                });
                component.set('v.indexofalternateTest',fillerData.length);
            }
        });
        $A.enqueueAction(action);
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
    getTestParameter : function(component,event,helper){
       //debugger;
        var action=component.get('c.getTestParameter');
        var wherecdtion=component.get('v.selectedLookUpRecordForTitanSpec');
        var sampleSize=component.get('v.SampleSizePlatingField');
        var recordId=component.get('v.referencedReportrecordObject.Id');
        action.setParams({
            'QCMtlComponentId': recordId,
            'titanspecNumber' : wherecdtion,
            'sampleSize' : parseInt(sampleSize),
            'DepartTName' : component.get('v.selectedDepartmentValue')
        });
        action.setCallback(this,function(response){
            if (response.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                var fillerData=result.filter(function (n){
                    return n.IsmandatoryTest==true;
                });
                component.set('v.indexValue',result.length);
                component.set('v.indexofalternateTest',fillerData.length);
                for(var x in result){
                    if(result[x]['testName'] != "Thickness"){
                        result[x]['userInput'] = 'Pass';
                    }
                }
                component.set('v.alltestParaMeterList',result); 
                /* var rdata=result;
                console.log(result);
                 
                var createNewTestData=[];
                if(!Number.isNaN(sampleSize)){
                    if(parseInt(sampleSize)>0){
                        for(var data in result){
                            for(var x=0;x<sampleSize;x++){
                                var newDate=rdata[data];
                                createNewTestData.push(newDate);
                            }
                        }
                        component.set('v.indexValue',createNewTestData.length);
                        component.set('v.alltestParaMeterList',createNewTestData);
                    }
                }*/
            }
        });
        
        $A.enqueueAction(action);
    },
    updateTestParameter : function(component,event,helper,alltestResponseValues){
        var data;
        var testType=component.get('v.parentTestingType');
        if(testType=='Plating'){
            data={
                'sObject' : 'QC_MTL_Component__c',
                'Id' : component.get('v.referencedReportrecordObject.Id'),
                'Department__c' : component.get('v.selectedDepartmentValue'),
                'Part_Name__c' : component.get('v.partName'),
                'Source__c' : component.get('v.sourceField'),
                'Model__c' : component.get('v.modelField'),
                'Docket_Number__c' : component.get('v.docketNumberField'),
                'Batch_Quantity__c' : component.get('v.batchQuantityField'),
                'Remarks__c' : component.get('v.PlatingRemarks'),
                'General_Observation__c' :component.get("v.genrlObsrvtn"),   
                'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                'Material__c' : component.get('v.selectedMaterialValue'),
                'Titan_Specification_Reference__c' : component.get('v.selectedLookUpRecordForTitanSpec.Id'),
                'Plating_Type__c' : component.get('v.selectedPlatingTypeValue'),
                'Required_Test__c' : component.get('v.selectedRequiredTestValue'),
                'Optional_Test__c' : component.get('v.selectedvalues').toString(),
                'Chemical_Composition_Elements__c': component.get('v.selectedMaterialCompValue'),
                'Chemical_Composition_Elements_2__c': component.get('v.selectedMaterialCompValue2'),
                'Chemical_Composition_Elements_3__c': component.get('v.selectedMaterialCompValue3'),
                'Chemical_Composition_Elements_4__c': component.get('v.selectedMaterialCompValue4'),
                'Chemical_Composition_Elements_5__c': component.get('v.selectedMaterialCompValue5'),
                'Component_Name__c' : component.get('v.componentNameValue'),
                'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                'Chemical_Composition_ElementsObservation__c': component.get('v.MaterialCompositionValue1'),
                'Chemical_Composition_ElementsObser1__c' : component.get('v.MaterialCompositionValue2'),
                'Chemical_Composition_ElementsObser2__c' : component.get('v.MaterialCompositionValue3'),
                'Chemical_Composition_ElementsObser3__c' : component.get('v.MaterialCompositionValue4'),
                'Chemical_Composition_ElementsObser4__c' : component.get('v.MaterialCompositionValue5'),
                'Chemical_Composition_ElementsResult__c' : component.get('v.MaterialCompositionResult1'),
                'Chemical_Composition_ElementsResult1__c' : component.get('v.MaterialCompositionResult2'),
                'Chemical_Composition_ElementsResult2__c' : component.get('v.MaterialCompositionResult3'),
                'Chemical_Composition_ElementsResult3__c' : component.get('v.MaterialCompositionResult4'),
                'Chemical_Composition_ElementsResult4__c' : component.get('v.MaterialCompositionResult5')
            };
        }
        if(testType=='Plating and Material Composition'){
            var dataVal;
            var datavar1;
            if(component.get("v.componentNameValue") =='Accessories' && component.get("v.componentAccValue") !=undefined){
                dataVal = component.get("v.componentAccValue");
            }else{
                dataVal=undefined;
            }
            if(component.get("v.componentNameValue") =='Others' && component.get("v.componentOtherValue") !=undefined){
                
                datavar1 = component.get("v.componentOtherValue");
            }else{
                datavar1=undefined;
            }
            data={
                'sObject' : 'QC_MTL_Component__c',
                'Id' : component.get('v.referencedReportrecordObject.Id'),
                'Department_PMC__c' : component.get('v.selectedDepartmentValue'),
                'Part_Name__c' : component.get('v.partName'),
                'Source__c' : component.get('v.sourceField'),
                'Model__c' : component.get('v.modelField'),
                'Docket_Number__c' : component.get('v.docketNumberField'),
                'Batch_Quantity__c' : component.get('v.batchQuantityField'),
                'Remarks__c' : component.get('v.PlatingRemarks'),
                'General_Observation__c' :component.get("v.genrlObsrvtn"),   
                'Sample_Size_Plating__c' : component.get('v.SampleSizePlatingField'),
                'Material__c' : component.get('v.selectedMaterialValue'),
                'Titan_Specification_Reference__c' : component.get('v.selectedLookUpRecordForTitanSpec.Id'),
                'Plating_Type__c' : component.get('v.selectedPlatingTypeValue'),
                'Required_test_PMC__c' : component.get('v.selectedRequiredTestValue'),
                'Optional_Test__c' : component.get('v.selectedvalues').toString(),
                'Chemical_Composition_Elements__c': component.get('v.selectedMaterialCompValue'),
                'Chemical_Composition_Elements_2__c': component.get('v.selectedMaterialCompValue2'),
                'Chemical_Composition_Elements_3__c': component.get('v.selectedMaterialCompValue3'),
                'Chemical_Composition_Elements_4__c': component.get('v.selectedMaterialCompValue4'),
                'Chemical_Composition_Elements_5__c': component.get('v.selectedMaterialCompValue5'),
                'Component_Name__c' : component.get('v.componentNameValue'),
                'Supplier_Name_New__c':component.get('v.mtlSelectedLookupRecForSuplrName').Id,
                'plater_Name__c':component.get('v.mtlSelectedLookupRecForPlaterName').Id,
                'Chemical_Composition_ElementsObservation__c': component.get('v.MaterialCompositionValue1'),
                'Chemical_Composition_ElementsObser1__c' : component.get('v.MaterialCompositionValue2'),
                'Chemical_Composition_ElementsObser2__c' : component.get('v.MaterialCompositionValue3'),
                'Chemical_Composition_ElementsObser3__c' : component.get('v.MaterialCompositionValue4'),
                'Chemical_Composition_ElementsObser4__c' : component.get('v.MaterialCompositionValue5'),
                'Chemical_Composition_ElementsResult__c' : component.get('v.MaterialCompositionResult1'),
                'Chemical_Composition_ElementsResult1__c' : component.get('v.MaterialCompositionResult2'),
                'Chemical_Composition_ElementsResult2__c' : component.get('v.MaterialCompositionResult3'),
                'Chemical_Composition_ElementsResult3__c' : component.get('v.MaterialCompositionResult4'),
                'Chemical_Composition_ElementsResult4__c' : component.get('v.MaterialCompositionResult5'),
                'Component_Accessories__c' : dataVal,
                'Component_Others__c'    : datavar1,
            };
        }
        var addNewTestValueList=component.get('v.addNewTestValueList');
        var action=component.get('c.updateTestParameter');
        action.setParams({
            'recordInfo' : data,
            'getUpdateRecords' : JSON.stringify(alltestResponseValues),
            'newTest' : JSON.stringify(addNewTestValueList),
            'optionalTest' : JSON.stringify(component.get('v.optionalTestValues')),
            'regularTest' : JSON.stringify(component.get('v.generateRegularTest')),
            'deletePreviousResponse' : component.get('v.allTestToBeDeletedList')
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success Message',
                    message: 'Record Updated Successfully!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'success',
                    mode: 'dismissible'
                });
                toastEvent.fire();
                var result = response.getReturnValue();
                component.set('v.alltestParaMeterList',result.TestLists);
                component.set('v.generateRegularTest',result.regularTestLists);
                component.set('v.optionalTestValues',result.optionalTests);
                component.set('v.addNewTestValueList',[]);
                component.set('v.indexValue',result.TestLists.length);
                var fillerData=result.TestLists.filter(function(n){
                    return n.IsmandatoryTest==true;
                });
                component.set('v.indexofalternateTest',fillerData.length);
            }
        });
        $A.enqueueAction(action);
    },
    fectchAllPlatingType : function(component,event,helper){
        var action=component.get('c.getPlatingtypeValues');
        action.setCallback(this,function(response){
            if (response.getState() == "SUCCESS"){
                var result=response.getReturnValue();
                component.set('v.platingPickList',result);
            }
        });
        $A.enqueueAction(action);
    },
    getRegularTestCustomSetting : function(component,event,helper){
        var partName=component.get('v.partName');
        var action=component.get('c.getRegularTestCSValues');
        action.setCallback(this,function(response){
           debugger;
            console.log('Test');
            if (response.getState() == "SUCCESS"){
                var result=response.getReturnValue();
                var testingcriteria=component.get('v.parentTestingType');
                var tempTCriteria;
                if(testingcriteria=='Plating'){
                    tempTCriteria='PL';
                }
                if(testingcriteria=='Plating and Material Composition'){
                    tempTCriteria='PMC';
                }
                component.set('v.listRegularTest',result);
                component.set('v.templistRegularTest',result);
                var regularTestCSValues=result;
                if(regularTestCSValues.length>0 && (component.get('v.selectedDepartmentValue')!=undefined || component.get('v.selectedDepartmentValue')!="") && (component.get('v.selectedRequiredTestValue')!=undefined || component.get('v.selectedRequiredTestValue')!="") ){
                    //alert(''+regularTestCSValues);
                    var templist;
                    for(var x=0;x<regularTestCSValues.length;x++){
                        var temp=regularTestCSValues[x].split(',');
                       debugger;
                        if(temp[0]==tempTCriteria && temp[1]==component.get('v.selectedDepartmentValue') && temp[2]==component.get('v.selectedRequiredTestValue')){
                            if(temp[3] == partName && partName == "Push Button"){
                                templist=regularTestCSValues[x];
                                break;
                            }
                            else if(temp[3] == partName && partName == "Decorative Ring"){
                                templist=regularTestCSValues[x];
                                break;
                            }
                                else if( partName != "Push Button" && partName != "Decorative Ring")
                                {
                                    templist=regularTestCSValues[x];
                                    break;
                                }
                        }
                    }
                    if(templist!=undefined){
                        var temp=templist.split(',');
                        var requiredtestList=[];
                        if(temp.length>2){
                            var i=3
                            if(partName == "Push Button" || partName == "Decorative Ring")
                                i++;
                            for(var x=i;x<temp.length;x++){
                                var dt;
                                if(partName == temp[3] && temp[3] == "Push Button" ){
                                    dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                                    requiredtestList.push(dt); 
                                }
                                else if(partName == temp[3] && temp[3] == "Decorative Ring" ){
                                    dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                                    requiredtestList.push(dt); 
                                }
                                    else if(partName != "Push Button" && partName != "Decorative Ring"){   
                                        dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                                        requiredtestList.push(dt); 
                                    }
                            }
                            component.set('v.generateRegularTest',requiredtestList);
                            //alert(''+requiredtestList);
                        }
                    }
                    
                }
            }
        });
        $A.enqueueAction(action);
    },
    validateTest : function(Listvalues){
        var valid=true;
        for(var index in Listvalues){
            if(Listvalues[index].testName==undefined || Listvalues[index].testName=="" || Listvalues[index].standardDefinedValue==undefined || Listvalues[index].standardDefinedValue=="" ){
                valid=false;
            }
        }
        return valid;
    },
    isHasTestParameters : function(component,event,helper){
        var isChecked = component.find("checkboxId").get("v.checked");
        var recordId=component.get('v.referencedReportrecordObject.Id');
        var testresponseaction=component.get("c.getOldTestResponseRecords");
        testresponseaction.setParams({
            'recordId': recordId
        });
        testresponseaction.setCallback(this,function(response){
            if (response.getState() == "SUCCESS"){
               debugger;
                var result=response.getReturnValue();
                
                if(result.length>0){
                    
                    
                    var data=result;
                    var optionaltest=data.filter(function(recod){
                        return recod.PlatingTestType=="Optional";
                    });
                    var regulartest=data.filter(function(recod){
                        return recod.PlatingTestType=="Regular";
                    });
                    var testparameter=data.filter(function(recod){
                        return recod.PlatingTestType!="Regular";
                    });
                    var testparameter1=testparameter.filter(function(recod){
                        return recod.PlatingTestType!="Optional";
                    });
                    component.set('v.optionalTestValues',optionaltest);
                    component.set('v.generateRegularTest',regulartest);
                    component.set('v.alltestParaMeterList',testparameter1);
                    var fillerData=testparameter1.filter(function(n){
                        return n.IsmandatoryTest==true;
                    });
                    component.set('v.indexofalternateTest',fillerData.length);
                    isChecked=true;
                    component.set('v.IsOldTestRecords',true);
                    component.find("checkboxId").set("v.checked",isChecked);
                    component.set('v.generateTestParameter',isChecked);
                    component.set('v.indexValue',testparameter1.length);
                    
                }
            }
            
        });
        $A.enqueueAction(testresponseaction);
    },
    generateRegularTest : function(component,event,helper){
        var regularTestCSValues=component.get('v.templistRegularTest');
        var testingcriteria=component.get('v.parentTestingType');
        var partName=component.get('v.partName');
        var tempTCriteria;
        if(testingcriteria=='Plating'){
            tempTCriteria='PL';
        }
        if(testingcriteria=='Plating and Material Composition'){
            tempTCriteria='PMC';
        }
        if(regularTestCSValues.length>0 && (component.get('v.selectedDepartmentValue')!=undefined || component.get('v.selectedDepartmentValue')!="") && (component.get('v.selectedRequiredTestValue')!=undefined || component.get('v.selectedRequiredTestValue')!="" ) ){
            //alert(''+regularTestCSValues);
            var templist;
            for(var x=0;x<regularTestCSValues.length;x++){
                var temp=regularTestCSValues[x].split(',');
                if(temp[0] == tempTCriteria && temp[1]==component.get('v.selectedDepartmentValue') && temp[2]==component.get('v.selectedRequiredTestValue')){
                    if(temp[3] == partName && partName == "Push Button"){
                        templist=regularTestCSValues[x];
                         break;
                    }
                    else if(temp[3] == partName && partName == "Decorative Ring"){
                        templist=regularTestCSValues[x];
                         break;
                    }
                    else if( partName != "Push Button" && partName != "Decorative Ring")
                    {
                        templist=regularTestCSValues[x];
                         break;
                    }
                }
            }
            if(templist!=undefined){
                var temp=templist.split(',');
                var requiredtestList=[];
                if(temp.length>2){
                    var i=3
                if(partName == "Push Button" || partName == "Decorative Ring")
                       i++;
                for(var x=i;x<temp.length;x++){
                    var dt;
                    if(partName == temp[3] && temp[3] == "Push Button" ){
                        dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                        requiredtestList.push(dt); 
                    }
                    else if(partName == temp[3] && temp[3] == "Decorative Ring" ){
                        dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                        requiredtestList.push(dt); 
                    }
                    else if(partName != "Push Button" && partName != "Decorative Ring"){   
                        dt={'userInput' : 'Pass','testVerdict' : '','testName' : temp[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Regular'};
                          requiredtestList.push(dt); 
                    }
                }
                    component.set('v.generateRegularTest',requiredtestList);
                    //alert(''+requiredtestList);
                }
            }
            
        }
        
    },
    deleteTestResponse : function(component,event,helper){
        var deleteAction=component.get('c.deleteTestResponse');
        deleteAction.setParams({
            'recordId' : component.get('v.referencedReportrecordObject.Id')
        });
        $A.enqueueAction(deleteAction);
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
    commonDelete : function(component,helper,listData,index){
        
        
        var dataToBeDel=listData[index];
        //data.push(dataList[dataIndx]);
        // alert('data##::: '+JSON.stringify(data));
        var updatedata=[];
        if(index !=undefined && index !=''){
            
            delete listData[index];
            for(var dat in listData){
                if(dat!=undefined)
                    updatedata.push(listData[dat]);
            }
        }
        if(dataToBeDel.QCMTLTestResponseId != undefined && dataToBeDel.QCMTLTestResponseId !=''){
            var data=component.get("v.allTestToBeDeletedList");
            data.push(dataToBeDel.QCMTLTestResponseId.toString());
            component.set("v.allTestToBeDeletedList",data);
        }
        return updatedata;
    },
    testName : function(list,index){
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
})