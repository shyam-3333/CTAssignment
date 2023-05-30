({ 
    
    saveData : function(component, event, helper) {
        var deptValue = component.get('v.selectedDepartmentValue');
        var reqTestValue = component.get('v.selectedRequiredTestValue');
       	var materialValue = component.get('v.selectedMaterialValue');
        var platingValue = component.get('v.selectedPlatingTypeValue');
        var testingType =component.get("v.parentTestingType");
        var titanSpecRef = component.get("v.selectedLookUpRecordForTitanSpec").Id;
        var supplierGrade = component.get("v.selectedLookUpRecordForSupplierGrd").Id;
        var rawMaterial = component.get("v.rawMaterial");
        var emailData = component.get("v.sampleRecvdFrom");
        var mtlEmail = component.find("mtlUserEmailId").get("v.value");
        var partName = component.get("v.partName");
        var model = component.get("v.modelField");
        var DCNo = component.get("v.docketNumberField");
        var invoiceNo = component.get("v.invoiceNo");
        var batchQty = component.get("v.batchQuantityField");
        var sampleSize = component.get("v.sampleSize");
        var sampleSizePlatingField = component.get("v.SampleSizePlatingField");
        var supplierName = component.get("v.mtlSelectedLookupRecForSuplrName").Id;
        var regExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
         var dataArr=[];
        var batchQuantityFieldString = component.get('v.batchQuantityField');
       
        
        if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (deptValue == undefined || deptValue == '' ||  deptValue == '--None--')){
            
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'fill the department picklist!!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        
        }else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && ((materialValue != undefined && platingValue == undefined) || (materialValue != '' && platingValue == ''))){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'fill the plating type picklist !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        }else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (partName == undefined  || partName == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the Component Name !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        }else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (model == undefined  || model == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the Model !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        }else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (DCNo == undefined  || DCNo == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the D.C No !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        }else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (batchQty == undefined  || batchQty == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the Batch Quantity !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        } else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (sampleSizePlatingField == undefined  || sampleSizePlatingField == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the Sample Size !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        } else if((testingType == 'Plating' || testingType == 'Plating and Material Composition') && (supplierName == undefined  || supplierName == '' )){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please fill the Supplier Name !',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        } else if(testingType == 'Raw Material' && (sampleSize ==undefined || sampleSize =='') ){
					
					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title : 'Error!',
						message: 'Please Fill the Sample Size!',
						messageTemplate: '',
						duration:' 5000',
						key: 'error_alt',
						type: 'error',
						mode: 'dismissible'
					});
					toastEvent.fire();	
        } else if(testingType == 'Raw Material' && (invoiceNo ==undefined || invoiceNo =='') ){
					
					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title : 'Error!',
						message: 'Please Fill the Invoice No/D.C No!',
						messageTemplate: '',
						duration:' 5000',
						key: 'error_alt',
						type: 'error',
						mode: 'dismissible'
					});
					toastEvent.fire();	
        }  else if(testingType == 'Raw Material' && (supplierName ==undefined || supplierName =='') ){
					
					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title : 'Error!',
						message: 'Please Select Supplier Name!',
						messageTemplate: '',
						duration:' 5000',
						key: 'error_alt',
						type: 'error',
						mode: 'dismissible'
					});
					toastEvent.fire();	
        }
            /*else if(testingType == 'Raw Material' && ((titanSpecRef == undefined || titanSpecRef == '') && (rawMaterial != '' && rawMaterial != undefined) && (supplierGrade != '' && supplierGrade != undefined))){
         	var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Fill the titan specification to proceed !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();
        }else if(testingType == 'Raw Material' && ((titanSpecRef != undefined && titanSpecRef != '') && (supplierGrade == '' || supplierGrade == undefined) && (rawMaterial != '' && rawMaterial != undefined))){
              var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Fill the supplier grade to proceed !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire();   
            
        }
		else if(testingType == 'Raw Material' && (rawMaterial !=undefined && rawMaterial !='') && (titanSpecRef ==undefined || titanSpecRef =='') && (supplierGrade =='' || supplierGrade ==undefined)){
					
					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title : 'Error!',
						message: 'Please select matching Titan Specification Reference and Supplier Grade value!!',
						messageTemplate: '',
						duration:' 5000',
						key: 'error_alt',
						type: 'error',
						mode: 'dismissible'
					});
					toastEvent.fire();	
        }*/
		else if(mtlEmail == undefined || mtlEmail == ''){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please enter MTL user email field !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire(); 
        }else if(emailData == undefined || emailData == ''){
            var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error!',
                    message: 'Please enter Sample email field !!',
                    messageTemplate: '',
                    duration:' 5000',
                    key: 'error_alt',
                    type: 'error',
                    mode: 'dismissible'
                });
                toastEvent.fire(); 
        }else if((emailData !=undefined && emailData !='') && !regExp.test(String(emailData).toLowerCase())){
                dataArr.push(emailData);
                var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                       title : 'Error Message',
                       message: 'Please Enter a valid email address !!',
                       messageTemplate: '',
                       duration:' 5000',
                       key: 'error_alt',
                       type: 'error',
                       mode: 'dismissible'
                   });
                   toastEvent.fire();
        }else if(component.get("v.sampleSize") < 1 ){
            var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Sample Size should be always greater than 0 !!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
               toastEvent.fire();
        }else if((mtlEmail !=undefined && mtlEmail !='') && !regExp.test(String(mtlEmail).toLowerCase())){
                dataArr.push(mtlEmail);
                var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                       title : 'Error Message',
                       message: 'Please Enter a valid email address !!',
                       messageTemplate: '',
                       duration:' 5000',
                       key: 'error_alt',
                       type: 'error',
                       mode: 'dismissible'
                   });
                   toastEvent.fire(); 
        }else if(helper.validationCheckStringHasSpeciNumber(batchQuantityFieldString)){
        debugger;
                var toastEvent = $A.get("e.force:showToast");
                       toastEvent.setParams({
                       title : 'Error Message',
                       message: 'Batch Quantity accepts only special characters and numbers',
                       messageTemplate: '',
                       duration:' 5000',
                       key: 'error_alt',
                       type: 'error',
                       mode: 'dismissible'
                   });
                   toastEvent.fire(); 
        } else{
            helper.saveData(component, event, helper);
        }
        
    },
    hideSpinner : function(component, event, helper){
        helper.hideSpinner(component, event, helper);
    },
    handleLookupComponentEvent : function(component, event, helper) {
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
           component.set("v.mtlSelectedLookUpRecForTitanSpec",selectedRecordFromEvent);
            //helper.setSuplrName(component,event,helper,selectedRecordFromEvent.Id);
        }
        if(customId == 'qcMTLPlaterNameId'){
           component.set("v.mtlSelectedLookupRecForPlaterName",selectedRecordFromEvent);
        }
        
    },
    doInit : function(component, event, helper){
        var testType=component.get('v.parentTestingType');
        helper.fetchPicklistValues(component, "Material__c", "Plating_Type__c");
        if(testType=='Plating'){
            helper.fetchPicklistValuesDepartmemt(component, "Department__c", "Required_Test__c"); 
        }else if(testType=='Plating and Material Composition'){
            helper.fetchPicklistValuesDepartmemt(component, "Department_PMC__c", "Required_test_PMC__c"); 
        }
        //helper.fetchPicklistValuesDepartmemt(component, "Department__c", "Required_Test__c");
        helper.getCustomSettingValues(component, event, helper);
        //helper.fetchChemicalCompPicklist(component, event, helper);
        helper.fetchReSubRecords(component, event, helper);
        helper.fetchOptionTestValue(component, event, helper);
        helper.getSuggestionValue(component, event, helper);
        helper.getSourcePickListValues(component, event, helper);
        helper.getPickListval(component,event,helper);
        helper.getComponentNamePickListValues(component, event, helper);
        var testingType =component.get("v.parentTestingType");
        if(testingType == 'Plating' || testingType == 'Plating and Material Composition'){
            component.set('v.sampleRecvdFrom','');
        }
        
    },
    onControllerFieldChange: function(component, event, helper) {
        var clearTitanSpec = component.find('lookupIdTitanPlating');
        if(clearTitanSpec!=undefined)
       clearTitanSpec.clearValue();
       // alert(event.getSource().get("v.value"));
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
    onControllerFieldChangeDepartment : function(component, event, helper){
         //alert(event.getSource().get("v.value"));
        // get the selected value
        component.set('v.multiSelectPickList',[]);
                var customSettingValues=component.get('v.optionalTestCustomSettingValues');
                var temp=[];
                var data;
                if(customSettingValues.length!=0 && component.get('v.selectedDepartmentValue')=='Other' ){
                    for(var x=0;x<customSettingValues.length;x++){
                        var dt=customSettingValues[x].split(',');
                        if(dt[0]=='PMC' && dt[1]=='Other'){
                            data=dt;
                            break;
                        }
                    }
                    if(data!=undefined){
                        for(var y=2;y<data.length;y++){
                        var templabel={'label' : data[y],'value' : data[y]};
                        temp.push(templabel);
                    }
                    component.set('v.multiSelectPickList',temp);
                    }
                    
                }
        
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
        var deptName=component.get('v.selectedDepartmentValue');
                if(deptName!=undefined && deptName.includes('Other')){
                    component.set('v.IfSelectedDeptOthers',true);
                }else{
                    component.set('v.IfSelectedDeptOthers',false);
                }
    },
    getSampleValue : function(component, event, helper){
        var testingcriteria=component.get('v.parentTestingType');
        var partName = component.get("v.partName");
        var tempTCriteria;
        if(testingcriteria=='Plating'){
            tempTCriteria='PL';
        }
        if(testingcriteria=='Plating and Material Composition'){
            tempTCriteria='PMC';
        }
        var res=component.get('v.allCustonSettingValues');
        for(var x=0;x<res.length;x++){
            var stringval=res[x].split('-');
            if(stringval[0]==tempTCriteria){
                 if(stringval[1]==component.get('v.selectedDepartmentValue') && stringval[2]==component.get('v.selectedRequiredTestValue'))
                	if( stringval[3] == 'Push' && partName == 'Push Button' )
                     	component.set('v.SampleSizePlatingField',stringval[4]);
                	else if( stringval[3] == 'Dec Ring' && partName == 'Decorative Ring')
                     	component.set('v.SampleSizePlatingField',stringval[4]);
                	else if( partName != 'Decorative Ring' && partName != 'Push Button')
                		component.set('v.SampleSizePlatingField',stringval[3]);
            }
        }
        var requiredTest=component.get('v.selectedRequiredTestValue');
     //   if(requiredTest=='Full Test' || requiredTest=='Stock Audit'){
     //       component.set('v.toggelOptionalTest',false); 
     //   }
     //   else{
     //    component.set('v.toggelOptionalTest',true);
         
     //   }
	component.set('v.multiSelectPickListValues',[]);
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
                    component.set('v.multiSelectPickList',temp);
                    }
                    else{
                      component.set('v.multiSelectPickList',[]);  
                    }
                    
                }
    },
    
    onchangePartName : function(component, event, helper){
        component.set("v.selectedRequiredTestValue",'');
        component.set("v.SampleSizePlatingField",'');
    },
    onchangePlatingType : function(component, event, helper){
        //qcMTLTitanSpecId
        var clearTitanSpec = component.find('lookupIdTitanPlating');
        if(clearTitanSpec!=undefined)
       clearTitanSpec.clearValue();
    },
    handleChange : function (component, event) {
        // This will contain an array of the "value" attribute of the selected options
        var selectedOptionValue = event.getParam("value");
       // alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
        var selectedValues=selectedOptionValue.toString();
        component.set('v.selectedOptionalTest',selectedValues);
    },
    onchangeAutoSuggestion : function(component, event, helper){
        var titanSpec={"sObjectType" :"QC_Access_Master__c",
                       "Id":"",
                       "Name":""};
        var supplrGrd={"sObjectType" :"Supplier_Grade__c",
                       "Id":"",
                       "Name":""}
        var data=document.getElementById("AutoSuggestion").value;
        component.set('v.rawMaterial',data);
		component.set("v.selectedLookUpRecordForTitanSpec", titanSpec );
        component.set("v.selectedLookUpRecordForSupplierGrd",supplrGrd);
			
    },
    onchangeSamplesize : function(component, event, helper){
        var samplesizevalue=component.get('v.sampleSize');
        var data=parseInt(samplesizevalue);
        //var id=event.currentTarget.id;
        if(data<=1){
             data=1;
        }
        component.set('v.sampleSize',data);
    },
    onChangePlatingSSize : function(component, event, helper){
        var samplesizevalue=component.get('v.SampleSizePlatingField');
        var data=parseInt(samplesizevalue);
        if(data<=0){
             data=0;
        }
		component.set('v.SampleSizePlatingField',data);        
    },
    onchangeRawMSize : function(component, event, helper){
        var samplesizevalue=component.get('v.RMSize');
        var data=parseInt(samplesizevalue);
        if(data<0){
             data=0;
        }
        component.set('v.RMSize',data);
    },
    onchangeSupplyQuantity : function(component, event, helper){
        var samplesizevalue=component.get('v.supplyQty');
        var data=parseInt(samplesizevalue);
        if(data<0){
             data=0;
        }
        component.set('v.supplyQty',data);
    },
    dispCompNamefield : function(component,event,helper){
        var dataVal = component.get("v.componentNameValue");
        debugger;
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
    },
    
})