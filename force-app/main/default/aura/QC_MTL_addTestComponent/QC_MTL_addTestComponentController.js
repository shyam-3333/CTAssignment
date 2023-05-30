({
  addRow : function(component, event, helper){
      //Execute the AddRowEvent Lightning Event 
      alert('firing addrow');
      component.getEvent("AddRowEvent").fire();
      
  },
   
  deleteRow : function(component, event, helper){
      //Execute the DeleteRowEvent Lightning Event and pass the deleted Row Index to Event attribute
      var rowIndexVal = component.get("v.rowIndex");
      component.getEvent("DeleteRowEvent").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
  },
    /*passTestData :function(component,event,helper){
         var sendData=[];
        alert('calling passTestData');
        
        if((component.get("v.QCquestionsTestParam.Name") !='' && component.get("v.QCquestionsTestParam.Name") !='undefined') &&
           (component.get("v.QCquestionsTestParam.QC_Test_Questions_Value__r.Standard_Defined_Value__c")!='' && component.get("v.QCquestionsTestParam.QC_Test_Questions_Value__r.Standard_Defined_Value__c")!=undefined) &&
          (component.get("v.QCquestionsTestParam.Result__c")!='' && component.get("v.QCquestionsTestParam.Result__c")!=undefined && component.get("v.QCquestionsTestParam.Result__c")!='None')){
           alert('@@@QCquestionsTestParam.Name::: '+component.get("v.QCquestionsTestParam.Name")+'::::component.get("v.QC_Test_Questions_Value__r.Standard_Defined_Value__c")'+component.get("v.QC_Test_Questions_Value__r.Standard_Defined_Value__c"));
            var dataList;
            var componentId =component.get("v.mtlCompId");
            console.log('###componentId:::'+componentId);
            dataList =component.get("v.QCquestionsTestParam");
            
                   var resp={'sObject': 'QC_MTL_TestResponse__c',
                      'Name':component.get("v.QCquestionsTestParam.Name"),
                      'Maximum__c':component.get("v.QCquestionsTestParam.Maximum__c"),
                      'Minimum__c':component.get("v.QCquestionsTestParam.Minimum__c"),
                      'QC_MTL_Component_del__c':componentId,
                      'QC_MTL_Test__c':'',
                      'QC_Test_Questions_Value__c':'',
                      'Standard_Defined_Value__c':component.get("v.QCquestionsTestParam.QC_Test_Questions_Value__r.Standard_Defined_Value__c"),      
                      'User_Defined_Value__c':component.get("v.QCquestionsTestParam.User_Defined_Value__c"),
                      'Average_Value__c':component.get("v.QCquestionsTestParam.Average_Value__c"),
                      'Result__c':component.get("v.QCquestionsTestParam.Result__c")
                      };
                    sendData.push(resp);
        }
        if((component.get("v.QCquestionsTestParam.Name") !='' && component.get("v.QCquestionsTestParam.Name") !='undefined') &&
            (component.get("v.QCquestionsTestParam.QC_Test_Questions_Value__r.Standard_Defined_Value__c") =='' || component.get("v.QCquestionsTestParam.QC_Test_Questions_Value__r.Standard_Defined_Value__c") == undefined)){
            	 var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please fill in some values in Standard Defined Value field in order to save this test with this record!!',
                   messageTemplate: '',
                   duration:' 7000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
               toastEvent.fire();   
            
            }
        if(sendData.length >0){
            //alert('Event fired!!');
            var evntData=component.getEvent("addRowTestData");
            alert('evntData::: '+evntData+'#### '+JSON.stringify(sendData));
            evntData.setParams({"addRowDataList":JSON.stringify(sendData)});
            evntData.fire();
        }
    },*/
   
})