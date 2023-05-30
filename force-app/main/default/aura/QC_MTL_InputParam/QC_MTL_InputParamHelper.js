({
	fetchDataAtInit : function(component,event,helper) {
        //alert('Called fetchDataAtInit method on init');
		var action =component.get("c.fetchDataforInpParam");
        action.setParams({"reportRefId" : component.get("v.referencedReportId")});
        action.setCallback(this,function(response)
        {
            var status = response.getState();
        	if(status == "SUCCESS"){
            	var result = response.getReturnValue();
                var selectedLookUpRefId ={};
                var supplrGrd = {};
                var suplrName = {};
                var pltrName = {};
                if(result.firstData.Titan_Specification_Reference__c !=undefined && result.firstData.Titan_Specification_Reference__c !=''){
                	selectedLookUpRefId ={'sObject' :'QC_Access_Master__c','Id' : result.firstData.Titan_Specification_Reference__c,'Name' :result.firstData.Titan_Specification_Reference__r.Name};
                }
                if(result.firstData.Supplier_Grade__c != undefined && result.firstData.Supplier_Grade__c !=''){
                    supplrGrd = {'sObject' :'Supplier_Grade__c', 'Id' :result.firstData.Supplier_Grade__c,'Name' : result.firstData.Supplier_Grade__r.Name};
                }
                if(result.firstData.Supplier_Name_New__c !=undefined && result.firstData.Supplier_Name_New__c !=''){
                    suplrName = {'sObject' :'QC_Access_Master__c', 'Id' :result.firstData.Supplier_Name_New__c,'Name' : result.firstData.Supplier_Name_New__r.Name};
                }
                if(result.firstData.plater_Name__c !=undefined && result.firstData.plater_Name__c !=''){
                    suplrName = {'sObject' :'QC_Access_Master__c', 'Id' :result.firstData.plater_Name__c,'Name' : result.firstData.plater_Name__r.Name};
                }
                //component.set("v.mtlSupplierName" ,result.firstData.Supplier_Name__c);
                component.set("v.mtlInvoiceNumb" ,result.firstData.Invoice_Dc_No__c);
                component.set("v.mtlHeatGrade" ,result.firstData.Heat_No_Grade__c);
                component.set("v.mtlSupplyQuantity" ,result.firstData.Supply_Quantity__c);
                component.set("v.mtlRawMaterialSize",result.firstData.RM_Size__c);
                component.set("v.mtlRawMaterialName",result.firstData.Raw_Material_Name__c);
                component.set("v.mtlSampleSize",result.firstData.Sample_Size_Qty__c);
                component.set("v.irrNo",result.firstData.IRR_No__c);
                component.set("v.genrlObsrvtn" ,result.firstData.General_Observation__c);
                component.set("v.PlatingRemarks" ,result.firstData.Remarks__c);
                /*var chkbxStatus = result.firstData.ToBeUpdated__c;
                if(chkbxStatus == true){
                    component.set("v.mtlTestRespData",true);
                }
                else{
                     component.set("v.mtlTestRespData",false);
                }*/
                component.set("v.referencedReportId",result.firstData.Report_Reference_Number__c);
                component.set("v.mtlTestingType" ,result.firstData.Testing_Type__c);              //new
                component.set("v.mtlSelectedLookUpRecForTitanSpec" ,selectedLookUpRefId);
                component.set("v.tclDesignation",result.firstData.TCL_Designation__c);
                component.set("v.specRevisionValue",result.firstData.Specification_revision__c);
                component.set("v.lookupValueIncrementerForTitanSpec",component.get("v.lookupValueIncrementerForTitanSpec")+1);
                component.set("v.lookupValueIncrementerForSupplrGrd",component.get("v.lookupValueIncrementerForSupplrGrd")+1);
                component.set("v.mtlSelectedLookUpRecordForSupplierGrd" ,supplrGrd);
                component.set("v.mtlSelectedLookupRecForSuplrName",suplrName);
                component.set("v.mtlSelectedLookupRecForPltrName",pltrName)
                component.set("v.lookupValueIncrmntrForSuplrName",component.get("v.lookupValueIncrmntrForSuplrName")+1);
                component.set("v.testParamList" ,result.secondDataTemp);
                component.set("v.testParamListSize" ,result.secondDataTemp.length);
                component.set("v.mtlCompId" ,result.firstData.Id);
                console.log('testParamList is ' +result.secondDataTemp.length);
                
             //   console.log('testParamList is ' + JSON.stringify(component.get("v.testParamList")));
                       
        	}
        });
        
        $A.enqueueAction(action);
       // this.fetchTestParam(component,event,helper);
	},
    fetchTestParam :function(component,event,helper){
        	//alert('-------sample size-------'+component.get("v.mtlSampleSize"));
        	
          /*  var action = component.get("c.fetchTestParam");
            action.setParams({"reportRefMtlComp" :component.get("v.referencedReportId") });
        
        action.setCallback(this,function(response)
         { 
             var state =response.getState();
             if(state ==="SUCCESS"){
                 var result = response.getReturnValue();
                 ,result);
                 
             }
                               
             }
              );*/
 
    },
    updateInputParam : function(component,event,helper){
        debugger;
      var rmName = component.get("v.mtlRawMaterialName");
      var suplrNm =  component.get("v.mtlSelectedLookupRecForSuplrName").Id;
      //var pltrNm =  component.get("v.mtlSelectedLookupRecForpltrName").Id;
      var invcNo =component.get("v.mtlInvoiceNumb");  
      var rmSz = component.get("v.mtlRawMaterialSize");
      var htGrdNo = component.get("v.mtlHeatGrade");
      var suplQnt = component.get("v.mtlSupplyQuantity");
      var irrNo = component.get("v.irrNo");
      var PlatingRemarks = component.get("v.PlatingRemarks");
      var genObsrvtn = component.find("genObsrvId").get("v.value");  
      var titanSpecId =component.get("v.mtlSelectedLookUpRecForTitanSpec").Id;
      var suplrGrdId = component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id;  
        var data ={'sObjectType' :'QC_MTL_Component__c',
                   'Raw_Material_Name__c':rmName,
                   'Supplier_Name__c':suplrNm,
                   'Invoice_Dc_No__c':invcNo,
                   'RM_Size__c':rmSz,
                   'Heat_No_Grade__c' :htGrdNo,
                   'IRR_No__c' : irrNo,
                   'General_Observation__c' : genObsrvtn,
                   'Supply_Quantity__c':suplQnt,
                   'Titan_Specification_Reference__c' :titanSpecId,
                   'Supplier_Grade__c':suplrGrdId,
                   'Supplier_Name_New__c':suplrNm,
                   //'Plater_Name__c' : pltrNm,
                   'Remarks__c' : PlatingRemarks,
                   'TCL_Designation__c' : component.get('v.tclDesignation'),
                   'Specification_revision__c' : component.get('v.specRevisionValue')
                  };
		var componentId =component.get("v.qCMtlComponentId");
            if(componentId != 'undefined' && componentId !=''){
                var action=component.get("c.updateMtlCompData");
                action.setParams({
                    "objData" : data,
                    "recId" : component.get("v.qCMtlComponentId")
                });
            } 
            action.setCallback(this,function(response)
                   {
                     var state= response.getState();
                       if(state =="SUCCESS"){
                           //alert('Success msg');
                           var result=response.getReturnValue();
                           /*if(result.ToBeUpdated__c == true){
                               component.set("v.mtlTestRespData",true);
                           }
                           else{
                              component.set("v.mtlTestRespData",true); 
                           }*/
                       }  
                                   
                    });
                 $A.enqueueAction(action);
            if(component.get("v.checkBoxVal")){
                //this.checkForTestRespData(component,event,helper);
                this.insrtTestParam(component,event,helper);
            }
        
    },
  	insrtTestParam : function(component,event,helper){
		var allRespDataList =[];
        var dataWithIdList =[];
        var testRespIdList =[];
		var testDataList = component.get("v.testParamList");
        var counterSize=component.get("v.internalSaveCounter");
        var mtlRespStatus =component.get("v.mtlTestRespData");//status to update or insert the tests.
		var componentId =component.get("v.qCMtlComponentId");
        var addRowDataList=component.get("v.testParametersLst");//all newly added test.
		if(testDataList.length >0){
			for(var i =0 ;i<testDataList.length;i++){
				if(testDataList[i].mtlTestRespId !=undefined && testDataList[i].mtlTestRespId !=''){
					var resp={'sObject': 'QC_MTL_TestResponse__c',
                      'Id': testDataList[i].mtlTestRespId,
                      'Name':testDataList[i].Testtype,
                      'Maximum__c':testDataList[i].maxInput,
                      'Minimum__c':testDataList[i].minInput,
                      'QC_MTL_Component_del__c':componentId,
                      'QC_MTL_Test__c':testDataList[i].recrdId,
                      'QC_Test_Questions_Value__c':testDataList[i].testValueRecordId,
                      'User_Defined_Value__c':testDataList[i].userInput,
                      //'Average_Value__c':testDataList[i].avgValue,
                      'Result__c':testDataList[i].verdStatus,
                      'Standard_Defined_Value__c' :testDataList[i].standDefVal
                      };
					  allRespDataList.push(resp);
				}
					else{
						var resp={'sObject': 'QC_MTL_TestResponse__c',
						  'Name':testDataList[i].Testtype,
						  'Maximum__c':testDataList[i].maxInput,
						  'Minimum__c':testDataList[i].minInput,
						  'QC_MTL_Component_del__c':componentId,
						  'QC_MTL_Test__c':testDataList[i].recrdId,
						  'QC_Test_Questions_Value__c':testDataList[i].testValueRecordId,
						  'User_Defined_Value__c':testDataList[i].userInput,
						 // 'Average_Value__c':testDataList[i].avgValue,
						  'Result__c':testDataList[i].verdStatus,
						  'Standard_Defined_Value__c' : testDataList[i].standDefVal   
						};
						allRespDataList.push(resp);
					}
			}
		}
		if(addRowDataList.length>0){
			for(var d=0;d<addRowDataList.length;d++){
				if((addRowDataList[d].Name !=undefined && addRowDataList[d].Name !='') && 
				   (addRowDataList[d].Standard_Defined_Value__c !=undefined && addRowDataList[d].Standard_Defined_Value__c !='')){
					var resp1={
						  'sObject': 'QC_MTL_TestResponse__c',
						  'Name':addRowDataList[d].Name,
						  'Standard_Defined_Value__c':addRowDataList[d].Standard_Defined_Value__c,	
						  'Maximum__c':addRowDataList[d].Maximum__c,
						  'Minimum__c':addRowDataList[d].Minimum__c,
						  'QC_MTL_Component_del__c':componentId,
						  'User_Defined_Value__c':addRowDataList[d].User_Defined_Value__c,
						 // 'Average_Value__c':addRowDataList[d].Average_Value__c,
						  'Result__c':addRowDataList[d].Result__c
						  };
				allRespDataList.push(resp1);
				}
			}
		}
		var action = component.get("c.dataUpdateInResp");
        action.setParams({"mtlRespList" : allRespDataList});
		action.setCallback(this,function(response){
            var state = response.getState();
            if(state =="SUCCESS"){
                var result =response.getReturnValue();
                /*for(var i =0; i < result.length ; i++){
                    var resp={'sObject': 'QC_MTL_TestResponse__c',
                              'Id': result[i].Id,       
                              'Name':result[i].Name,
                              'Maximum__c':result[i].Maximum__c,
                              'Minimum__c':result[i].Minimum__c,
                              'QC_MTL_Component_del__c':result[i].QC_MTL_Component_del__c,
                              'QC_MTL_Test__c':result[i].QC_MTL_Test__c,
                              'QC_Test_Questions_Value__c':result[i].QC_Test_Questions_Value__c,
                              'User_Defined_Value__c':result[i].User_Defined_Value__c,
                              'Average_Value__c':result[i].Average_Value__c,
                              'Result__c':result[i].Result__c,
                              'Standard_Defined_Value__c':result[i].Standard_Defined_Value__c        
                             };
                    dataWithIdList.push(resp);
                }*/
                component.set("v.testParamList",result);
                component.set("v.internalSaveCounter",component.get("v.internalSaveCounter")+1);
                component.set("v.dataListLen",result.length);
                component.set("v.testParamListSize",result.length);
                component.set("v.testParametersLst",testRespIdList);
            }
        });
		$A.enqueueAction(action);
       // this.deleteMtlResp(component,event,helper);
    },  
  
    deleteMtlResp : function(component,event,helper,delData,index){
        //alert('delData ::: '+JSON.stringify(delData));
        if(delData[index].mtlTestRespId !=undefined && delData[index].mtlTestRespId !=''){
            var dataList1=[{'sObject': 'QC_MTL_TestResponse__c',
                'Id':delData[index].mtlTestRespId
            }];
            var action=component.get("c.delMTLTestResp");
            action.setParams({"deltMtlResp":dataList1});
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state==="SUCCESS"){
                    var result=response.getReturnValue();
                    var testListParam=component.get("v.testParamList");
                    var newTestParam=testListParam.filter((n)=>{return n.mtlTestRespId!=result[0] });
                    component.set("v.testParamList",newTestParam);
                    component.set("v.testParamListSize",newTestParam.length);
                }
            });
            $A.enqueueAction(action);
        }else{
            var deleteintoView=delData.filter((each,ind)=>{return ind!=index});
            component.set("v.testParamList",deleteintoView);
            component.set("v.testParamListSize",deleteintoView.length);
        }
        /*var counter=component.get('v.delBckndDataCounter');
        var dataList =[];
        var data=component.get("v.delDataList");
        dataList.push(data);
        //alert('in delMtlRsp::: '+dataList);
        var dataList1 =component.get("v.delBackendDataLst");
        dataList.push(dataList1);
        //alert('updated Datalist:: '+dataList);
        if(counter >0 && dataList1.length >0){
            var action=component.get("c.delMTLTestResp");
            action.setParams({"deltMtlResp":dataList1});
            action.setCallback(this,function(response){
                var state=response.getState();
                if(state==="SUCCESS"){
                    var result=response.getReturnValue();
                }
            });
            $A.enqueueAction(action);
            
         }*/
    },
    genTestOnTitanSpecChange :function(component,event,helper){
        debugger;
      var status=component.find("genTestId").get("v.checked");
       component.set("v.checkBoxVal",status);
            if(status == true && (component.get("v.mtlRawMaterialName") =='' || component.get("v.mtlRawMaterialName") ==undefined) || ($A.util.isEmpty(component.get("v.mtlSelectedLookUpRecForTitanSpec").Id) || component.get("v.mtlSelectedLookUpRecForTitanSpec").Id ==undefined) || 
				(component.get("v.mtlInvoiceNumb")=='' || component.get("v.mtlInvoiceNumb")==undefined) || (component.get("v.mtlRawMaterialSize") =='' || component.get("v.mtlRawMaterialSize") ==undefined) || (component.get("v.mtlHeatGrade") =='' || component.get("v.mtlHeatGrade") ==undefined) || (component.get("v.mtlSupplyQuantity")=='' || component.get("v.mtlSupplyQuantity")==undefined) || 
				($A.util.isEmpty(component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id) || component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id ==undefined )){
                component.find("genTestId").set("v.checked",false);
                //component.set("v.viewTestToggle", false);
                component.set("v.checkBoxVal",false);
                var toastEvent = $A.get("e.force:showToast");
               	   toastEvent.setParams({
                   title : 'Error Message',
                   message: 'Please fill the mandatory fields and then Proceed!!',
                   messageTemplate: '',
                   duration:' 5000',
                   key: 'error_alt',
                   type: 'error',
                   mode: 'dismissible'
               });
               toastEvent.fire();
            }
       else if(status ==true && (component.get("v.mtlRawMaterialName") !='' && component.get("v.mtlRawMaterialName") !=undefined) && (component.get("v.mtlSelectedLookUpRecForTitanSpec").Id !='' && component.get("v.mtlSelectedLookUpRecForTitanSpec").Id !=undefined) &&
              (component.get("v.mtlInvoiceNumb") !='' && component.get("v.mtlInvoiceNumb") !=undefined) && (component.get("v.mtlRawMaterialSize") !='' && component.get("v.mtlRawMaterialSize") !=undefined) && (component.get("v.mtlHeatGrade") !='' && component.get("v.mtlHeatGrade") !=undefined ) && (component.get("v.mtlSupplyQuantity") !='' && component.get("v.mtlSupplyQuantity") !=undefined) && 
           (component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id !='' && component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id !=undefined)){
           
            component.set("v.viewTestToggle", true);
            var pushData =[];
            var rmName=component.get("v.mtlRawMaterialName");
            var titanSpec =component.get("v.mtlSelectedLookUpRecForTitanSpec").Id;
            //var suplrName =component.get("v.mtlSupplierName");
            var invcNumb= component.get("v.mtlInvoiceNumb");
            var rmSize =component.get("v.mtlRawMaterialSize");
            var heatGrd =component.get("v.mtlHeatGrade");
            var suplQnty = component.get("v.mtlSupplyQuantity");
            var suplrGrd =component.get("v.mtlSelectedLookUpRecordForSupplierGrd").Id;
            var smplSz = component.get("v.mtlSampleSize");
            //var mtlDataList = component.get("v.mtlResponseList");
            var reportRef = component.get("v.referencedReportId");
            var tstTyp = component.get("v.mtlTestingType");         //new
            var arrData=[rmName,titanSpec,invcNumb,rmSize,heatGrd,suplQnty,suplrGrd];
            if(arrData.length >0){
                if((titanSpec !=undefined && titanSpec !='') && (smplSz >0 && suplrGrd !=undefined && suplrGrd !='')){
                   	//alert('coming here when mtlresp list is 0');
                    var action = component.get("c.fetchTestParamOnCheckbox");
                    action.setParams({"reportRefNo" : reportRef,
                        			 "titanSpecRef" : titanSpec,
                                      "sampleSz" : smplSz,
                                      "supplrGrade" :suplrGrd,
                                      "testType" : tstTyp});  //new
                    action.setCallback(this,function(response){
                    var state= response.getState();
                    if(state ==="SUCCESS"){
                    	var result=response.getReturnValue();
                     	component.set("v.testParamList",result);
                     	component.set("v.testParamListSize",result.length);
                        let testSize = component.get("v.testParamList").length;
                       	//var counter = result.secondDataTemp.mtlTestRespCounter;
                        //alert('counter here is:::'+result.secondDataTemp[0].mtlTestRespCounter);
                        /*if(result.secondDataTemp[0].mtlTestRespCounter >0){
                           component.set("v.mtlTestRespData",true); 
                        }
                        else{
                           component.set("v.mtlTestRespData",false); 
                        }*/
                        
                      /* var secondDataCopy =result.secondDataTemp;
                       var testListCopy = secondDataCopy.filter(function(n){
                            return n.rawMatrlTestType =='hrd';
                        });
                        
                        for(var i =0;i <secondDataCopy.length;i++){
                            if(secondDataCopy[i].rawMatrlTestType =='hrd'){
                                delete secondDataCopy[i];
                            }
                        }
                        if(testListCopy.length >0){
                            for(var i =1;i <testListCopy.length;i++){
                                testListCopy[i].Testtype ='';
                                testListCopy[i].standDefVal='';
                            }
                        }
                        debugger;
                        for(var i =0;i <secondDataCopy.length;i++){
                            if(secondDataCopy[i] !=undefined){
                              testListCopy.push(secondDataCopy[i]);  
                            }
                        }*/
                       // component.set("v.testParamList",testListCopy);
                    }
                });   
            }
              $A.enqueueAction(action);
           }
            	
            }
        if(status ==false){
            component.set("v.viewTestToggle", false);
             component.set("v.isReadonly",false);
        }
    },
    
    fetchDataWithMtlResp : function(component,event,helper){
        alert('called fetchDataWithMtlResp on init');
        var action = component.get("c.fetchMtlRespData");
        action.setParams({'reportRefrId':component.get("v.referencedReportId"),
                          'mtlRspnsList' : component.get("v.mtlResponseList")});
        action.setCallback(this,function(response){
            if(response.getState =="SUCCESS"){
                var result =response.getReturnValue();
                var selectedLookUpRefId ={};
                var supplrGrd = {};
                if(result.compData.Titan_Specification_Reference__c !=undefined && result.compData.Titan_Specification_Reference__c !=''){
                	selectedLookUpRefId ={'sObject' :'QC_Access_Master__c','Id' : result.compData.Titan_Specification_Reference__c,'Name' :result.compData.Titan_Specification_Reference__r.Name};
                }
                if(result.compData.Supplier_Grade__c != undefined && result.compData.Supplier_Grade__c !=''){
                    supplrGrd = {'sObject' :'Supplier_Grade__c', 'Id' :result.compData.Supplier_Grade__c,'Name' : result.compData.Supplier_Grade__r.Name};
                }
                component.set("v.mtlSupplierName" ,result.compData.Supplier_Name__c);
                component.set("v.mtlInvoiceNumb" ,result.compData.Invoice_Dc_No__c);
                component.set("v.mtlHeatGrade" ,result.compData.Heat_No_Grade__c);
                component.set("v.mtlSupplyQuantity" ,result.compData.Supply_Quantity__c);
                component.set("v.mtlRawMaterialSize",result.compData.RM_Size__c);
                component.set("v.mtlRawMaterialName",result.compData.Raw_Material_Name__c);
                component.set("v.mtlSampleSize",result.compData.Sample_Size_Qty__c);
                component.set("v.mtlTestingType" ,result.compData.Testing_Type__c);              //new
                component.set("v.referencedReportId",result.compData.Report_Reference_Number__c);
                component.set("v.mtlSelectedLookUpRecForTitanSpec" ,selectedLookUpRefId);
                component.set("v.lookupValueIncrementerForTitanSpec",component.get("v.lookupValueIncrementerForTitanSpec")+1);
                component.set("v.lookupValueIncrementerForSupplrGrd",component.get("v.lookupValueIncrementerForSupplrGrd")+1);
                component.set("v.mtlSelectedLookUpRecordForSupplierGrd" ,supplrGrd);
                component.set("v.testParamList" ,result.mtlRespnsDataList);
                component.set("v.testParamListSize" ,result.mtlRespnsDataList.length);
                component.set("v.mtlCompId" ,result.compData.Id);
                console.log('testParamList is ' +result.mtlRespnsDataList.length);
            } 
        });
        $A.enqueueAction(action);
    },
    getSuggestionValue : function(component, event, helper){
        var availableTags;
        var action=component.get('c.getAllRawMaterialValue');
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
     createObjectData: function(component, event) {
        //get the testParametersLst from component and add(push) New Object to List  
        var RowItemList = component.get("v.testParametersLst");
        var componentId =component.get("v.qCMtlComponentId");
        RowItemList.push({
            'sobjectType': 'QC_MTL_TestResponse__c',
            'Name': '',
            'Standard_Defined_Value__c':'',
            'Minimum__c':'',
            'Maximum__c':'',
            'QC_Test_Questions_Value__r.Standard_Defined_Value__c': '',
            'User_Defined_Value__c':'',
            'QC_MTL_Component_del__c':componentId,
            'QC_MTL_Test__c':'',
            'QC_Test_Questions_Value__c':'',
           // 'Average_Value__c':'',
            'Result__c':''
            
        });
        // set the updated list to attribute (testParametersLst) again    
            component.set("v.testParametersLst", RowItemList);
    },
})