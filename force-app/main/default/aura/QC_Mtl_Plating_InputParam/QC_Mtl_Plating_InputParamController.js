({
    doinit : function(component, event, helper) {
       //alert('Test');
       debugger;
        
       // let generateRegularTest1 = []; //{'userInput' : 'Pass'}
       // generateRegularTest1.push({'userInput' : 'Pass'});
     //   component.set('v.generateRegularTest', generateRegularTest1);
        
        helper.fetchOptionTestValue(component, event, helper);
        helper.fetchPicklistValues(component, "Material__c", "Plating_Type__c");
        //helper.fetchPicklistValuesDepartmemt(component, "Department__c", "Required_Test__c");
        helper.getCustomSettingValues(component, event, helper);
        helper.fetchChemicalCompPicklist(component, event, helper);
        var testType=component.get('v.parentTestingType');
       /* if(component.get('v.parentTestingType')=='Plating and Material Composition'){
           //var requiredTest=[{'label':'Analysis','value' : 'Analysis'}];
           // component.set('v.requiredTestPickList',requiredTest); 
            helper.fetchPicklistValuesDepartmemt(component, "Department_PMC__c", "Required_test_PMC__c");
        }
        else if(component.get('v.parentTestingType')=='Plating'){
              helper.fetchPicklistValuesDepartmemt(component, "Department__c", "Required_Test__c");
        }*/
        if(testType=='Plating'){
            helper.fetchPicklistValuesDepartmemt(component, "Department__c", "Required_Test__c"); 
        }else if(testType=='Plating and Material Composition'){
            helper.fetchPicklistValuesDepartmemt(component, "Department_PMC__c", "Required_test_PMC__c"); 
        }
        //helper.fetchRequiredTestRegularTest(component, "Required_Test__c", "Regular_Test__c");
        helper.getPickListval(component,event,helper);
        helper.fetchRecordInfo(component, event, helper);
        
        var deptName=component.get('v.selectedDepartmentValue');
        if(deptName!=undefined && deptName.includes('Other')){
            component.set('v.IfSelectedDeptOthers',true);
        }
        helper.getRegularTestCustomSetting(component, event, helper); 
        helper.isHasTestParameters(component, event, helper);
    },
    onControllerFieldChangeDepartment : function(component, event, helper){
        if(component.get('v.parentTestingType')!='Plating and Material Composition'){
            //alert(event.getSource().get("v.value"));
        // get the selected value
        component.set('v.SampleSizePlatingField','');
        var controllerValueKey = event.getSource().get("v.value");
        //alert("=====controllerValueKey==>>"+controllerValueKey);
        
        // get the map values   
        var Map = component.get("v.mapofDepartmentRequiredTestPickList");
        
        // check if selected value is not equal to None then call the helper function.
        // if controller field value is none then make dependent field value is none and disable field
        if (controllerValueKey != '--- None ---' && controllerValueKey != 'None' && controllerValueKey != '' )   {
            
            // get dependent values for controller field by using map[key].  
            // for i.e "India" is controllerValueKey so in the map give key Name for get map values like 
            // map['India'] = its return all dependent picklist values.
            var ListOfDependentFields = Map[controllerValueKey];
            helper.fetchRequiredTestValues(component, ListOfDependentFields);
            
        } else {
            var defaultVal = [{
                class: "optionClass",
                label: '--- None ---',
                value: ''
            }];
            component.set("v.requiredTestPickList", defaultVal);
        }
        }
    },
    onControllerFieldChange: function(component, event, helper) {
         var clearTitanSpec = component.find('lookupIdTitan');
        if(clearTitanSpec!=undefined)
       clearTitanSpec.clearValue();
        //alert(event.getSource().get("v.value"));
        // get the selected value
        var controllerValueKey = event.getSource().get("v.value");
        //alert("=====controllerValueKey==>>"+controllerValueKey);
        
        // get the map values   
        var Map = component.get("v.mapofMaterialPlatingPickList");
        
        // check if selected value is not equal to None then call the helper function.
        // if controller field value is none then make dependent field value is none and disable field
        if (controllerValueKey != '--- None ---' && controllerValueKey != 'None' && controllerValueKey != '' )   {
            
            // get dependent values for controller field by using map[key].  
            // for i.e "India" is controllerValueKey so in the map give key Name for get map values like 
            // map['India'] = its return all dependent picklist values.
            var ListOfDependentFields = Map[controllerValueKey];
            helper.fetchDepValues(component, ListOfDependentFields);
            
        } else {
            var defaultVal = [{
                class: "optionClass",
                label: '--- None ---',
                value: ''
            }];
            component.set("v.platingPickList", defaultVal);
        }
    },
    getSampleValue : function(component, event, helper) {
        debugger;
        var testingcriteria=component.get('v.parentTestingType');
        var partName=component.get('v.partName');
        var tempTCriteria;
        if(testingcriteria=='Plating'){
            tempTCriteria='PL';
        }
        if(testingcriteria=='Plating and Material Composition'){
            tempTCriteria='PMC';
        }
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
                        for(var y=j;y<data.length;y++){
                        var templabel={'label' : data[y],'value' : data[y]};
                        temp.push(templabel);
                    }
                    component.set('v.multiOptionalValues',temp);
                    }
                    else{
                      component.set('v.multiOptionalValues',[]);  
                    }
                    
                }
        var res=component.get('v.allCustonSettingValues');
        for(var x=0;x<res.length;x++){
            var stringval=res[x].split('-');
            if(stringval[0]==tempTCriteria){
                if(stringval[1]==component.get('v.selectedDepartmentValue') && stringval[2]==component.get('v.selectedRequiredTestValue')){
                	if( stringval[3] == 'Push' && partName == 'Push Button' )
                     	component.set('v.SampleSizePlatingField',stringval[4]);
                	else if( stringval[3] == 'Dec Ring' && partName == 'Decorative Ring')
                     	component.set('v.SampleSizePlatingField',stringval[4]);
                	else if( partName != 'Decorative Ring' && partName != 'Push Button')
                		component.set('v.SampleSizePlatingField',stringval[3]);
                }
            }
        }
        var requiredTest=component.get('v.selectedRequiredTestValue');
        if(requiredTest=='Full Test' || requiredTest=='Stock Audit'){
            component.set('v.toggelOptionalTest',false); 
        }
        else{
         component.set('v.toggelOptionalTest',true);   
        }
        component.set('v.selectedvalues',[]);
        var regularTestCSValues=component.get('v.listRegularTest');
        if(regularTestCSValues.length>0 && (component.get('v.selectedDepartmentValue')!=undefined || component.get('v.selectedDepartmentValue')!="") && (component.get('v.selectedRequiredTestValue')!=undefined || component.get('v.selectedRequiredTestValue')!="") ){
            
            var templist;
            for(var x=0;x<regularTestCSValues.length;x++){
               var temp=regularTestCSValues[x].split(',');
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
               debugger;
                component.set('v.generateRegularTest',requiredtestList);
               
            }
            }
            
        }
    },
    
    onchangePartName : function(component, event, helper){
        component.set("v.selectedRequiredTestValue",'');
        component.set("v.SampleSizePlatingField",'');
    },
    
    generateTestMethod : function(component,event,helper){
       debugger;
        //if(component.get('v.selectedDepartmentValue')!='Other'){
        component.set('v.IsOldTestRecords',false);
        var isChecked = component.find("checkboxId").get("v.checked");
        console.log(isChecked);
        var partNameId=component.find('partNameId');
        var departmentPickListId=component.find('departmentPickListId');
        var sourceFieldId=component.find('sourceFieldId');
        var modelFieldId=component.find('modelFieldId');
        var docketNumberFieldId=component.find('docketNumberFieldId');
        var batchQuantityId=component.find('batchQuantityId');
        var materialPickListId=component.find('materialPickListId');
        var platingPickListId=component.find('platingPickListId');
        var requiredTestPickListId=component.find('requiredTestPickListId');
        //var array=[partNameId,sourceFieldId,modelFieldId,batchQuantityId,docketNumberFieldId,departmentPickListId,materialPickListId,platingPickListId,requiredTestPickListId];
        var array=[departmentPickListId,materialPickListId,platingPickListId,requiredTestPickListId];

        var errorObject=['Please Fill All Field!!'];
        //array.forEach(function(item){
        //var tempevali={ $A.util.isEmpty(item.get('v.value')) : item.get('v.label')};   
        //});
       //debugger;
        for(var i=0;i<array.length;i++){
            if(array[i] != undefined)
            if(array[i].get('v.value') == undefined || array[i].get('v.value')==''){
                errorObject.push(array[i].get('v.label'));
            }
        }
        if($A.util.isEmpty(component.get('v.selectedLookUpRecordForTitanSpec')) || component.get('v.selectedLookUpRecordForTitanSpec')==undefined || component.get('v.selectedLookUpRecordForTitanSpec')=='' || component.get('v.selectedLookUpRecordForTitanSpec')=={}){
            errorObject.push('Titan Specification Reference');
        }
        if(errorObject.length==1){
            errorObject=[];
            component.set('v.generateTestParameter',isChecked);
          // //alert('--------isCheckd---------'+component.get('v.generateTestParameter'));
            if(component.get('v.generateTestParameter')){
                if(component.get('v.selectedDepartmentValue')!='Other'){
                   helper.getTestParameter(component,event,helper);
                helper.generateRegularTest(component,event,helper); 
                }
                var optionalTest=component.get('v.selectedvalues');
                var templist=[];
        var ishasMCValue=false;
        for(var x=0;x<optionalTest.length;x++){
            if(optionalTest[x]!="Material Composition"){
            var dt={'userInput' : 'Pass','testVerdict' : '','testName' : optionalTest[x],'testRecordId' : '' , 'standardDefinedValue' : 'as per standard T5003','PlatingTestType':'Optional'};
            templist.push(dt);
            }else{
                ishasMCValue=true;
            }
        }
                  
        component.set("v.optionalTesthaveMCValue",ishasMCValue);
        component.set('v.optionalTestValues',templist);
                var dep11=component.get('v.selectedDepartmentValue');
                var reqTest11 =component.get("v.selectedRequiredTestValue");
                if((dep11 =='Customer Assurance' || dep11 =='NPD' || dep11 =='IDI' || dep11 =='QC Appearance') && (reqTest11 =='Analysis')){
                    ishasMCValue = true;
                    component.set("v.optionalTesthaveMCValue",ishasMCValue);
                    
                }
            }
            if(component.find("checkboxId").get("v.checked")==false){
              //  if (confirm("All Test Parameter Will Be Deleted, Are You Sure?")) {
                    
                    helper.deleteTestResponse(component,event,helper);
                    
              //  } else {
               //     component.find("checkboxId").set("v.checked",true);
               //     component.set('v.generateTestParameter',true);
              //  }
            }
        }
        else{
            component.find("checkboxId").set("v.checked",false);
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning!',
                message: 'Please Fill ALL Fields!!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }
        component.set('v.errorMessage',errorObject);
     // }
    },
    addRow : function(component,event,helper){
        var copy=component.get('v.alltestParaMeterList');
        var addNewRawList=component.get('v.addNewTestValueList');
        var newRow={'qcMTLQuestionRecordId' : '',
                    'userInput' : 'Pass',
                    'testVerdict' : '',
                    'testRecordId' :'',
                    'standardDefinedValue' : '',
                    'testName' : '',
                    'addNewTestValueList' : component.get('v.referencedReportrecordObject.Id'),
                    'minValue' : '',
                    'maxValue' : ''};
        addNewRawList.push(newRow);
        // component.set('v.alltestParaMeterList',copy);
        component.set('v.addNewTestValueList',addNewRawList);
    },
    deleteRow : function(component,event,helper){
        var removeRaw=component.get('v.addNewTestValueList');
        var lastIndex=event.currentTarget.id;
        var updatedata=[];
        delete removeRaw[lastIndex];
        for(var dat in removeRaw){
            if(dat!=undefined)
                updatedata.push(removeRaw[dat]);
        }
        component.set('v.addNewTestValueList',updatedata);
    },
    saveMtlInputData : function(component,event,helper){
       //debugger;
       var alltestResponseValues=component.get('v.alltestParaMeterList');
       var optionalTest=component.get('v.optionalTestValues');
       var regularTest=component.get('v.generateRegularTest');
        var isHasId=alltestResponseValues.filter(function(Data){
           return  Data.QCMTLTestResponseId!='';
        });
        if(isHasId.length==0){
            isHasId=optionalTest.filter(function(Data){
                return  Data.testRecordId!='';
             });
        }
        if(isHasId.length==0){
            isHasId=regularTest.filter(function(Data){
                return  Data.testRecordId!='';
             });
        }
         
       /*var testvalidation=helper.validateTest(component.get('v.alltestParaMeterList'));
       var regularTestvalidation=helper.validateTest(component.get('v.generateRegularTest'));
       var optiontestvalidation=helper.validateTest(component.get('v.optionalTestValues'));
       var newTestValuesvalidation=helper.validateTest(component.get('v.addNewTestValueList'));
        if(!testvalidation || !regularTestvalidation || !optiontestvalidation || !newTestValuesvalidation){
           //alert('Fill all info');
        }
        else{*/
        var newTestValuesvalidation=helper.validateTest(component.get('v.addNewTestValueList'));
        if(!newTestValuesvalidation && newTestValuesvalidation.length!=0){
           var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Warning!',
                message: 'New test Name and Response Standard Value Not be empty!',
                messageTemplate: '',
                duration:' 5000',
                key: 'error_alt',
                type: 'error',
                mode: 'dismissible'
            });
            toastEvent.fire();
        }else{
           //debugger;
           if(isHasId.length==0){
                helper.saveRecord(component,event,helper);   
            }
            else{
                helper.updateTestParameter(component,event,helper,alltestResponseValues);
            } 
        }
    },
    handleChange : function(component,event,helper){
        var selectedOptionValue = event.getParam("value");
        var optionalTest=selectedOptionValue.toString().split(',');
        if(selectedOptionValue.toString()!="")
        component.set('v.selectedvalues',selectedOptionValue.toString().split(','));
    },
    onchangePlatingType :function(component,event,helper){
         var clearTitanSpec = component.find('lookupIdTitan');
        if(clearTitanSpec!=undefined)
       clearTitanSpec.clearValue();
    },
    deleteRow1 : function (component,event,helper){
       //debugger;
       var deleteIndex = event.currentTarget.id;
        //alert(deleteIndex);
        var optionaList = component.get('v.optionalTestValues');
        var regularList = component.get('v.generateRegularTest');
        var allTestList = component.get('v.alltestParaMeterList');
        if(deleteIndex.split(',').length>=2){
            if(deleteIndex.split(',')[1]=='Optional'){
                 var testData=helper.commonDelete(component,helper,optionaList,deleteIndex.split(',')[0])
            component.set('v.optionalTestValues',testData);
            }else{
                var testData=helper.commonDelete(component,helper,regularList,deleteIndex.split(',')[0])
            component.set('v.generateRegularTest',testData);
            }
           
        }
        else{
            var testData=helper.commonDelete(component,helper,allTestList,deleteIndex.split(',')[0])
            component.set('v.alltestParaMeterList',testData);
            component.set('v.indexValue',testData.length);
        }
     //   ifdeleteIndex<(){
            
      //  }
     // helper.commonDelete(component,event,helper,'');
    },
    handleLookupComponentEvent : function(component,event,helper){
       var selectedRecordFromEvent = event.getParam("recordByEvent");
        var customId = event.getParam("customId");
        if(customId == 'qcMTLTitanSpecId'){
            component.set("v.selectedLookUpRecordForTitanSpec",selectedRecordFromEvent);
            helper.setSpecificationRevision(component, event, helper,selectedRecordFromEvent.Id);
        }
        if(customId == 'qcMTLSupplierGradeId'){
            component.set("v.selectedLookUpRecordForSupplierGrd",selectedRecordFromEvent);
            helper.setTCLDesignation(component, event, helper,selectedRecordFromEvent.Id);
        }
        if(customId == 'brandId'){
            component.set("v.selectedLookUpRecordForBrand",selectedRecordFromEvent);
        }
        if(customId == 'qcMTLSuplrNameId'){
           component.set("v.mtlSelectedLookupRecForSuplrName",selectedRecordFromEvent);
            //helper.setSuplrName(component,event,helper,selectedRecordFromEvent.Id);
        } 
     },
    sampleSizeOnchangeMethod : function(component,event,helper){
        var sampleSize=component.get('v.SampleSizePlatingField');
        if(!(Number.isNaN(sampleSize) || parseInt(sampleSize)>1 )){
            component.set('v.SampleSizePlatingField',"1");
        }
    },
    dispCompNamefield : function(component,event,helper){
        var dataVal = component.get("v.componentNameValue");
       //debugger;
        if((dataVal !=undefined && dataVal !='') && (dataVal =='Accessories')){
            component.set("v.showAccessories",true);
            component.set("v.showOthers", false);
        }
        else if((dataVal !=undefined && dataVal !='') && (dataVal =='Others')){
            component.set("v.showOthers", true);
            component.set("v.showAccessories",false);
        }
            else{
                component.set("v.showOthers", false);
                component.set("v.showAccessories",false);
            }
    }
})