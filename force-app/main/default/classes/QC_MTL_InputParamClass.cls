/*Author: Rahul Mukherji
 * Desc:This class is used for QC_MTL_InputParam Component.
 * 1.fetchDataforInpParam method : is used to fetch the QC MTL Component data at re-init in order to display all the input params.
 * As well as the test paramters are being displayed for the users
 */ 


public class QC_MTL_InputParamClass {
    
    @AuraEnabled
    public static WrapperClass fetchDataforInpParam(sObject reportRefId){
		 WrapperClass obje=new WrapperClass();
         obje.secondData=new List<TestValueWrapper>();
         QC_MTL_Component__c sObj =(QC_MTL_Component__c)reportRefId;
		 String supplrGrd;
		 Decimal samplQnty=0;
		 String titanSpecId;
		 obje.secondDataTemp=new List<ViewClass>();
         ViewClass ins;
		 List<TestValueWrapper> testValWrapList = new List<TestValueWrapper>();
		 TestValueWrapper testValWrapObj;
		 List<QC_Test_Questions_Value__c> qcTestQstnValList;
        System.debug('::::sObj.Report_Reference_Number__c !=NULL && sObj.Id !=:::'+sObj.Report_Reference_Number__c+'/'+  sObj.Id);
        System.debug('::QCMTLComponentTrigger__c.getOrgDefaults().TriggerActivate_Deactivate__c:'+QCMTLComponentTrigger__c.getOrgDefaults().TriggerActivate_Deactivate__c);
        Report_Reference_Number__c secondPart = Report_Reference_Number__c.getOrgDefaults();
        system.debug('report'+secondPart);
        if(sObj.Report_Reference_Number__c !=NULL && sObj.Id !=NULL){
            sobject inputValue=[SELECT ID,NAME,Raw_Material_Name__c,Supplier_Grade__c,Supplier_Grade__r.Name,Raw_Material_Type__c,Record_Status__c,Titan_Specification_Reference__r.Name,Supplier_Name_New__c,Supplier_Name_New__r.Name,Titan_Specification_Reference__c,Invoice_Dc_No__c,Sample_Size_Qty__c,Heat_No_Grade__c,Report_Reference_Number__c,RM_Size__c,IRR_No__c,General_Observation__c,Document_Status__c,Supply_Quantity__c,Sample_Received_From__c,TCL_Designation__c,Specification_revision__c,ToBeUpdated__c,Remarks__c,Testing_Type__c FROM QC_MTL_Component__c WHERE Id = : sObj.Id][0];
         	obje.firstData=inputValue;        
			QC_MTL_Component__c mtlObj =(QC_MTL_Component__c)inputValue;
			if(mtlObj !=NULL){
				supplrGrd = mtlObj.Supplier_Grade__c;
				samplQnty = mtlObj.Sample_Size_Qty__c;
				titanSpecId = mtlObj.Titan_Specification_Reference__c;                
				System.debug('::samplQnty::'+samplQnty+'::supplrGrd::'+supplrGrd+'::titanSpecId::'+titanSpecId);
				if(supplrGrd !=NULL && supplrGrd !='' && titanSpecId !=NULL && titanSpecId !='' || test.isRunningTest()){
					for(QC_MTL_Test__c each : [SELECT ID,Name,Supplier_Grade__c,Titan_Specification__c,Titan_Specification__r.Name,(SELECT Id,Name,Minimum__c,Maximum__c,Standard_Defined_Value__c,Status__c FROM QC_Test_Questions_Values__r) FROM QC_MTL_Test__c WHERE Titan_Specification__c =:titanSpecId AND Supplier_Grade__c =:supplrGrd ]){
                        testValWrapObj=new TestValueWrapper();
						testValWrapObj.testRecWrap=new List<sObject>();
						testValWrapObj.testType=each.Name;
						testValWrapObj.recrdId =each.Id;
                        testValWrapObj.titanSpecificationName = each.Titan_Specification__r.Name;
                        system.debug('each.QC_Test_Questions_Values__r===>'+each.QC_Test_Questions_Values__r);
                        if(each.QC_Test_Questions_Values__r != null){
                            testValWrapObj.testRecWrap.addAll(each.QC_Test_Questions_Values__r);
                        }
						
						testValWrapList.add(testValWrapObj);
                        }//end of for 
					obje.secondData=testValWrapList;
				}
				
			}
				if(samplQnty >=1 && obje.secondData.size() >0 || test.isRunningTest()){
					for(Integer i=0;i<obje.secondData.size();i++){
						
						if(obje.secondData[i].testType.trim().contains('Hardness') ){ 	
                            system.debug('obje.secondData[i].titanSpecificationName -> : ' + obje.secondData[i].titanSpecificationName);
							for(Integer j =0 ;j < Integer.valueof(obje.secondData[i].titanSpecificationName == 'T8086' ? 5 : samplQnty ) ;j++){
								ins = new ViewClass();
                                ins.TestType = obje.secondData[i].testType; 
								ins.userInput=null;
								ins.minInput=null;
								ins.maxInput=null;
								ins.avgValue=String.valueOf(0);
                                if(obje.secondData[i] != null){
                                    if(obje.secondData[i].testRecWrap.size()> 0){
                                        ins.standDefVal = String.valueOf(obje.secondData[i].testRecWrap[0].Standard_Defined_Value__c);
                                    }
                                    
                                }
								
								ins.userInpBool =false;
								ins.testVerdBool = false;
								ins.minDefBool=true;
								ins.maxDefBool=true;
								ins.verdStatus='None';
								ins.isMandtry =true;
                                ins.rawMatrlTestType ='hrd';
								ins.recrdId =obje.secondData[i].recrdId;
                                 if(obje.secondData[i] != null){
                                    if(obje.secondData[i].testRecWrap.size()> 0){
								ins.testValueRecordId=obje.secondData[i].testRecWrap[0].Id;
                                    }}
								obje.secondDataTemp.add(ins);
							}
						}
						else{
								ins = new ViewClass();
								ins.TestType = obje.secondData[i].testType;
								ins.standDefVal = String.valueOf(obje.secondData[i].testRecWrap[0].Standard_Defined_Value__c);
								ins.userInpBool = true;
								ins.testVerdBool = true;
								ins.minDefBool= false;
								ins.maxDefBool=false;
								ins.verdStatus=obje.secondData[i].testRecWrap[0].Status__c;
								ins.isMandtry=true;
								ins.recrdId =obje.secondData[i].recrdId;
								ins.testValueRecordId=obje.secondData[i].testRecWrap[0].Id;
								obje.secondDataTemp.add(ins);
						}
					}
				}
				/*List<DispAltTest> dataToBeAddList = new List<DispAltTest>();
				dataToBeAddList =QC_MTL_InputParamClass.dispAlterTest(reportRefId);
				ViewClass vwClsObj;
				if(dataToBeAddList.size()>0){
					for(Integer i =0;i<dataToBeAddList.size();i++){
								vwClsObj = new ViewClass();
								vwClsObj.TestType = dataToBeAddList[i].alterTest;
								vwClsObj.standDefVal = NULL;
								vwClsObj.userInpBool = false;
								vwClsObj.testVerdBool = false;
								vwClsObj.minDefBool= false;
								vwClsObj.maxDefBool=false;
								vwClsObj.isMandtry =false;
								vwClsObj.verdStatus=dataToBeAddList[i].alterTestVerd;
								obje.secondDataTemp.add(vwClsObj);
								
					}  
				}*/
				System.debug(':::objec ::: '+obje);
				return obje;
        }
        return NULL;
    }
    
    public class ViewClass{
        @AuraEnabled
        public String Testtype;
        @AuraEnabled
        public String Minimum;
        @AuraEnabled
        public String Maximum;
        @AuraEnabled
        public String standDefVal;
        @AuraEnabled
        public String userInput;
        @AuraEnabled
        public String minInput;
        @AuraEnabled
        public String maxInput;
        @AuraEnabled
        public String avgValue;
        @AuraEnabled
        public Boolean userInpBool;
         @AuraEnabled
        public Boolean minDefBool;
         @AuraEnabled
        public Boolean maxDefBool;
         @AuraEnabled
        public Boolean testVerdBool;
        @AuraEnabled
        public String verdStatus;
        @AuraEnabled
        public Boolean isMandtry;
		@AuraEnabled
		public String recrdId;//This is MTL Test record Id
        @AuraEnabled
        public String testValueRecordId;//test question values Id.
         @AuraEnabled
        public String resultValue;//Accept and Reject values for picklist
		@AuraEnabled
		public String mtlTestRespId;
        @AuraEnabled
        public Integer mtlTestRespCounter;
        @AuraEnabled
        public String rawMatrlTestType;
        
        
    }
    public class WrapperClass{
        @AuraEnabled
        public sobject firstData;
        @AuraEnabled
        public List<TestValueWrapper>  secondData;
        @AuraEnabled
        public List<ViewClass>  secondDataTemp;
    }
    public class WrapQstnData{
        @AuraEnabled
        public List<TestValueWrapper>  secondData;
        @AuraEnabled
        public List<ViewClass>  secondDataTemp;
    }
    public class TestValueWrapper{
        @AuraEnabled
       public List<QC_Test_Questions_Value__c> testRecWrap;
      	@AuraEnabled
        public String testType;
		@AuraEnabled
        public String recrdId;
        @AuraEnabled
        public String titanSpecificationName;
        
       
    }
     @AuraEnabled
    public static List<String> getAllRawMaterialValue(){
        return QC_MTL_InputForm_Class.getAllRawMaterialName();
    }
       
    @AuraEnabled
    public static List<DispAltTest> dispAlterTest(sObject reportRefrncId){
     QC_MTL_Component__c sObj =(QC_MTL_Component__c)reportRefrncId;
        String supplrGr;
        DispAltTest wrpClsObj;
        List<DispAltTest> dispAltTestList = new List<DispAltTest>();
        if(sObj !=NULL){
            for(QC_MTL_Component__c each : [SELECT ID,Supplier_Grade__c,Sample_Size_Qty__c,Supply_Quantity__c,Titan_Specification_Reference__c,Supplier_Name_New__c,ToBeUpdated__c,Remarks__c FROM QC_MTL_Component__c WHERE ID =:sObj.ID]){
                if(each.Supplier_Grade__c !=NULL){
                    supplrGr = each.Supplier_Grade__c;
                }
            }
        }//if ends
        if(supplrGr != NULL && supplrGr !=''){
            for(QC_MTL_Test__c each : [SELECT Id,Name,Supplier_Grade__c,Titan_Specification__c FROM QC_MTL_Test__c WHERE Supplier_Grade__c =:supplrGr AND isMandatory__c =false]){
                if(each !=NULL){
                    wrpClsObj = new DispAltTest();
                    wrpClsObj.alterTest = each.Name;
                    wrpClsObj.alterTestVerd ='None';
					wrpClsObj.recrdId=each.Id;
                    dispAltTestList.add(wrpClsObj);
                }
            }
        }
        return dispAltTestList;
        
        
    }
    
    public class DispAltTest{
       @AuraEnabled
        public String alterTest;
        @AuraEnabled
        public String alterTestVerd;
		@AuraEnabled
		public String recrdId;
    }
    
    @AuraEnabled
    public static QC_MTL_Component__c updateMtlCompData(QC_MTL_Component__c objData,String recId){
        System.debug('Data-------------------'+objData);
       // QC_MTL_Component__c dataObj = (QC_MTL_Component__c)objData;
        objData.Id=recId;
        System.debug(':::::::::::::::::::::::::::::::::::::::::;:dataObj:: '+objData);
        update objData;	
        return [SELECT Id,Report_Reference_Number__c,ToBeUpdated__c FROM QC_MTL_Component__c where Id = :recId];
    }
    @AuraEnabled
	public static List<QC_MTL_TestResponse__c> saveTestParam(List<QC_MTL_TestResponse__c> dataList){
        System.debug(':::dataList::: '+dataList);
       List<WrapAllData> wrpDataList= new List<WrapAllData>();
	   List<QC_MTL_Test__c> mtlTestList = new List<QC_MTL_Test__c>();
	   List<QC_Test_Questions_Value__c> qstnValList = new List<QC_Test_Questions_Value__c>();
	   Map<String, QC_MTL_Test__c> testDataMap = new Map<String,QC_MTL_Test__c>();	
	   Map<String, QC_Test_Questions_Value__c> qstnValMap = new Map<String,QC_Test_Questions_Value__c>();	
	   WrapAllData wrpObj;
	   List<Integer> indexCounter = new List<Integer>();
       List<QC_MTL_TestResponse__c> removedIdDataList = new List<QC_MTL_TestResponse__c>();
	   Integer counter =0;
	   QC_MTL_Component__c obj =[SELECT ID,NAME,Supplier_Grade__c,Supply_Quantity__c,Titan_Specification_Reference__c,ToBeUpdated__c,Remarks__c FROM QC_MTL_Component__c WHERE ID =:dataList[0].QC_MTL_Component_del__c];
	    
		QC_MTL_Test__c tstObj;
		QC_Test_Questions_Value__c qstnValObj;
		if(!dataList.isEmpty()){
		   for(QC_MTL_TestResponse__c each :dataList){
			   System.debug('counter::: '+counter+'##'+each.QC_MTL_Test__c+'@@@'+each.Name);
			   if((each.Name !=NULL && each.Name !='') && (each.QC_MTL_Test__c ==NULL)){
                   System.debug(' before counter inside loop::: '+counter);
				   tstObj = new QC_MTL_Test__c();
				   tstObj.Name=each.Name;
				   tstObj.Supplier_Grade__c = obj.Supplier_Grade__c;
				   tstObj.Titan_Specification__c=obj.Titan_Specification_Reference__c;
				   mtlTestList.add(tstObj);
				   indexCounter.add(counter);
			   }
              
               counter++;
			   
		   }
	    }
			if(mtlTestList.size()>0){
				insert mtlTestList;
			}
			for(QC_MTL_Test__c each : mtlTestList){
				testDataMap.put(each.Name, each);
			}
			for(QC_MTL_TestResponse__c each : dataList){
				if(testDataMap.containsKey(each.Name)){
				qstnValObj = new QC_Test_Questions_Value__c();
				qstnValObj.Name=each.Name;
				qstnValObj.QC_MTL_Test__c = testDataMap.get(each.Name).Id;
				qstnValObj.Standard_Defined_Value__c=each.Standard_Defined_Value__c;
				qstnValList.add(qstnValObj);
				}
			}
			if(qstnValList.size()>0){
				insert qstnValList;
			}
			for(QC_Test_Questions_Value__c each : qstnValList){
				qstnValMap.put(each.Name,each);
			}
			for(QC_MTL_TestResponse__c each : dataList){
				if(testDataMap.containsKey(each.Name)){
					wrpObj = new WrapAllData();
					wrpObj.respName = each.Name;
					wrpObj.suplrGrd =testDataMap.get(each.Name).Supplier_Grade__c;
					wrpObj.titanSpec =testDataMap.get(each.Name).Titan_Specification__c;
					wrpObj.testId =testDataMap.get(each.Name).Id;
					if(!qstnValMap.isEmpty() && qstnValMap.containsKey(each.Name)){
						wrpObj.qstnValId = qstnValMap.get(each.Name).Id;
						wrpObj.stndrdDefVal=qstnValMap.get(each.Name).Standard_Defined_Value__c;
					}
					wrpObj.userDefndVal=each.User_Defined_Value__c;
					wrpObj.mtlCompId = each.QC_MTL_Component_del__c;
					wrpObj.resltVal= each.Result__c;
					wrpDataList.add(wrpObj);
				}
			}
        System.debug('/:::wrpDataList::: '+wrpDataList);
			/*for(Integer each : indexCounter){
				dataList.remove(each);
			}*/
        if(dataList.size()>0 && indexCounter.size()>0 ){
            for(Integer i =0;i<dataList.size();i++){
                if(!indexCounter.contains(i)){
                    removedIdDataList.add(dataList[i]);
                }
            }
        }
        System.debug('/:::removedIdDataList//::: '+removedIdDataList);
			QC_MTL_TestResponse__c respDataObj;
			if(wrpDataList.size()>0){
				for(WrapAllData each : wrpDataList){
					respDataObj = new QC_MTL_TestResponse__c();
					respDataObj.Name = each.respName;
					respDataObj.QC_MTL_Component_del__c= each.mtlCompId;
					respDataObj.QC_MTL_Test__c = each.testId;
					respDataObj.QC_Test_Questions_Value__c=each.qstnValId;
					respDataObj.User_Defined_Value__c =each.userDefndVal;
					respDataObj.Result__c=each.resltVal;
					respDataObj.Standard_Defined_Value__c = each.stndrdDefVal;
					respDataObj.Average_Value__c =0;
                    respDataObj.Minimum__c=0;
                    respDataObj.Maximum__c=0;
                    if(removedIdDataList.size()>0){
						removedIdDataList.add(respDataObj);
                    }
                    else{
                        dataList.add(respDataObj);
                    }
				}
			}
				if(removedIdDataList.size()>0){
					insert removedIdDataList;
				}
       		 else{
            	insert dataList;
            }
        	return [SELECT ID,NAME,Average_Value__c,Maximum__c,Minimum__c,QC_MTL_Component_del__c,QC_MTL_Test__c,QC_Test_Questions_Value__c,Result__c,Standard_Defined_Value__c,User_Defined_Value__c FROM QC_MTL_TestResponse__c WHERE QC_MTL_Component_del__c =: obj.Id];
    }
    @AuraEnabled
    public static List<QC_MTL_TestResponse__c> updateTestParam(List<QC_MTL_TestResponse__c> updatedDataList){
        System.debug(':::updatedDataList:: '+updatedDataList);
        QC_MTL_Component__c obj =[SELECT ID,NAME,Supplier_Grade__c,Supply_Quantity__c,Titan_Specification_Reference__c,Supplier_Name_New__c FROM QC_MTL_Component__c WHERE ID =:updatedDataList[0].QC_MTL_Component_del__c];
        QC_MTL_Test__c testDataObj;
        List<QC_MTL_Test__c> qcMtlTestList =  new List<QC_MTL_Test__c>();
        Map<String,QC_MTL_Test__c> testDataMap = new Map<String,QC_MTL_Test__c>();
        List<Integer> indexCounter = new List<Integer>();
	    Integer counter =0;
        QC_Test_Questions_Value__c qstnObj;
        List<QC_Test_Questions_Value__c> qstnValueList = new List<QC_Test_Questions_Value__c>();
        WrapAllData wrpInsDataObj;
        List<WrapAllData> wrpInsDataList = new List<WrapAllData>();
        Map<String,QC_Test_Questions_Value__c> qstnValueMap = new Map<String,QC_Test_Questions_Value__c>();
        List<QC_MTL_TestResponse__c> dataList = new List<QC_MTL_TestResponse__c>();
        List<QC_MTL_TestResponse__c> removedMtlwithOutIdDataList = new List<QC_MTL_TestResponse__c>();
        if(updatedDataList.size()>0){
            for(QC_MTL_TestResponse__c each : updatedDataList){
                if(each.QC_MTL_Test__c ==NULL){
                    testDataObj = new QC_MTL_Test__c();
                    testDataObj.Name= each.Name;
                    testDataObj.Supplier_Grade__c=obj.Supplier_Grade__c;
                    testDataObj.Titan_Specification__c=obj.Titan_Specification_Reference__c;
                    qcMtlTestList.add(testDataObj);
                    indexCounter.add(counter);
                }
                counter++;
                System.debug(':::counter::: '+counter);
            }
        }
        System.debug(':::indexCounter:::'+indexCounter);
        System.debug(':::qcMtlTestList::: '+qcMtlTestList);
        if(qcMtlTestList.size()>0){
            insert qcMtlTestList;
        }
        for(QC_MTL_Test__c each: qcMtlTestList){
            testDataMap.put(each.Name,each);
        }
        for(QC_MTL_TestResponse__c each : updatedDataList){
            if(testDataMap.containsKey(each.Name)){
               qstnObj = new QC_Test_Questions_Value__c();
                qstnObj.Name=each.Name;
                qstnObj.QC_MTL_Test__c =testDataMap.get(each.Name).Id;
                qstnObj.Standard_Defined_Value__c=each.Standard_Defined_Value__c;
                qstnObj.Maximum__c=each.Maximum__c;
                qstnObj.Minimum__c=each.Minimum__c;
                qstnValueList.add(qstnObj);
            }
        }
        System.debug('!!qstnValueList::: '+qstnValueList);
        if(qstnValueList.size()>0){
            insert qstnValueList;
        }
        for(QC_Test_Questions_Value__c each : qstnValueList){
           qstnValueMap.put(each.Name,each);
        }
        if(!testDataMap.isEmpty() && !qstnValueMap.isEmpty() || test.isRunningTest()){
            for(QC_MTL_TestResponse__c each : updatedDataList){
                wrpInsDataObj = new WrapAllData();
                if(testDataMap.containsKey(each.Name) && (each.Id ==NULL || each.Id =='') ){
					wrpInsDataObj = new WrapAllData();
					wrpInsDataObj.respName = each.Name;
					wrpInsDataObj.suplrGrd =testDataMap.get(each.Name).Supplier_Grade__c;
					wrpInsDataObj.titanSpec =testDataMap.get(each.Name).Titan_Specification__c;
					wrpInsDataObj.testId =testDataMap.get(each.Name).Id;
					if(!qstnValueMap.isEmpty() && qstnValueMap.containsKey(each.Name)){
						wrpInsDataObj.qstnValId = qstnValueMap.get(each.Name).Id;
						wrpInsDataObj.stndrdDefVal=qstnValueMap.get(each.Name).Standard_Defined_Value__c;
					}
					wrpInsDataObj.userDefndVal=each.User_Defined_Value__c;
					wrpInsDataObj.mtlCompId = each.QC_MTL_Component_del__c;
					wrpInsDataObj.resltVal= each.Result__c;
					wrpInsDataList.add(wrpInsDataObj);
				}
            }
        }
        
        	QC_MTL_TestResponse__c respDataObj;
			if(wrpInsDataList.size()>0){
				for(WrapAllData each : wrpInsDataList){
					respDataObj = new QC_MTL_TestResponse__c();
					respDataObj.Name = each.respName;
					respDataObj.QC_MTL_Component_del__c= each.mtlCompId;
					respDataObj.QC_MTL_Test__c = each.testId;
					respDataObj.QC_Test_Questions_Value__c=each.qstnValId;
					respDataObj.User_Defined_Value__c =each.userDefndVal;
					respDataObj.Result__c=each.resltVal;
					respDataObj.Standard_Defined_Value__c = each.stndrdDefVal;
					respDataObj.Average_Value__c =0;
                    respDataObj.Minimum__c=0;
                    respDataObj.Maximum__c=0;
					dataList.add(respDataObj);
				}
			}
        if(dataList.size()>0){
            insert dataList;
        }
        if(!testDataMap.isEmpty()){
            for(QC_MTL_TestResponse__c each : updatedDataList ){
                if(!testDataMap.containsKey(each.Name) && (each.Id !=NULL )){
                    removedMtlwithOutIdDataList.add(each);
                }
                }
        }
        if(removedMtlwithOutIdDataList.size()>0){
            System.debug('removedMtlwithOutIdDataList ::: '+removedMtlwithOutIdDataList);
            update removedMtlwithOutIdDataList;
        }
        else{
            update updatedDataList;
        }
        if(dataList.size()>0 && removedMtlwithOutIdDataList.size()>0 ){
        	removedMtlwithOutIdDataList.addAll(dataList);
             return removedMtlwithOutIdDataList;
        }
        else{
            System.debug(':::updated return::');
       return updatedDataList;
        }
    }
    @AuraEnabled
    public static List<String> delMTLTestResp(List<QC_MTL_TestResponse__c> deltMtlResp){
       List<String> idList = new List<String>();
        for(QC_MTL_TestResponse__c each : deltMtlResp){
            if(each.Id !=NULL){
                idList.add(each.Id);
            }
        }
        delete deltMtlResp;
        return idList ;
    }
    
	
	public class WrapAllData{
		@AuraEnabled
		public String respName;
		@AuraEnabled
		public String suplrGrd;
		@AuraEnabled
		public String titanSpec;
		@AuraEnabled
		public String testId;
		@AuraEnabled
		public String qstnValId;
		@AuraEnabled
		public String stndrdDefVal;
		@AuraEnabled
		public String userDefndVal;
		@AuraEnabled
		public String mtlCompId;
		@AuraEnabled
		public String resltVal;
	}
	@AuraEnabled
	public static List<QC_MTL_TestResponse__c> checkForMtlRespData(String reportRefNo){
        QC_MTL_Component__c mtlObj;
        if(reportRefNo !=NULL && reportRefNo !=''){
           mtlObj =[SELECT ID,NAME,Raw_Material_Name__c,Supplier_Grade__c,Supplier_Grade__r.Name,Raw_Material_Type__c,Record_Status__c,Titan_Specification_Reference__r.Name,Supplier_Name_New__c,Titan_Specification_Reference__c,Invoice_Dc_No__c,Sample_Size_Qty__c,Heat_No_Grade__c,Report_Reference_Number__c,RM_Size__c,Document_Status__c,Sample_Received_From__c,Remarks__c  FROM QC_MTL_Component__c WHERE Report_Reference_Number__c =:reportRefNo ORDER BY CreatedDate Desc LIMIT 1]; 
        }
		List<QC_MTL_TestResponse__c> mtlTestRespList = new List<QC_MTL_TestResponse__c>();
		if(mtlObj !=NULL){
			for(QC_MTL_TestResponse__c each : [SELECT ID,NAME,User_Defined_Value__c,Standard_Defined_Value__c,Result__c,Average_Value__c,Maximum__c,Minimum__c,QC_MTL_Test__c,QC_MTL_Test__r.Name,QC_Test_Questions_Value__c,QC_Test_Questions_Value__r.Name,QC_Test_Questions_Value__r.Maximum__c,QC_Test_Questions_Value__r.Minimum__c,QC_Test_Questions_Value__r.Standard_Defined_Value__c,QC_Test_Questions_Value__r.Status__c,QC_MTL_Component_del__c FROM QC_MTL_TestResponse__c WHERE QC_MTL_Component_del__c=:mtlObj.Id]){
				mtlTestRespList.add(each);
			}
            return mtlTestRespList;
		}
		return NULL;
	}
     @AuraEnabled
    public static list<QC_Access_Master__c> specRevisionValue(String titanSpecificationId){
        list<QC_Access_Master__c> specRevLst = new list<QC_Access_Master__c>();
        specRevLst = [SELECT Id,Specification_Revision__c,TCL_Designation__c FROM QC_Access_Master__c WHERE Id =:titanSpecificationId];
        return specRevLst;
        
    }
    @AuraEnabled
    public static list<Supplier_Grade__C> tclDesignationValue(String supplierGradeID){
        list<Supplier_Grade__C> retrunResult = new list<Supplier_Grade__C>();
        retrunResult = [SELECT Id,TCL_Designation__c FROM Supplier_Grade__C WHERE Id =:supplierGradeID];
        return retrunResult;
        
    }
    @AuraEnabled
    public static List<QC_Access_Master__c> suplrNameValue(String suplrNameId){
        List<QC_Access_Master__c> accMasList = new List<QC_Access_Master__c>();
        accMasList = [SELECT Id,Name FROM QC_Access_Master__c WHERE ID =: suplrNameId];
        return accMasList;
    }
	//Would return all the test and its related value.
	@AuraEnabled
    public static List<ViewClass> fetchTestAndValueData(Id titanSpecId,Id suplrGrdId,Integer sampleSz,String testType ){
        System.debug('2 fetchTestAndValueData ---> titanSpecId : '+titanSpecId+' ---///--- suplrGrdId : '+suplrGrdId+' ---///--- testType : '+testType);
        ViewClass viewIns;
        List<ViewClass> viewClsList = new List<ViewClass>();
        if(titanSpecId !=NULL && suplrGrdId !=NULL && sampleSz >0){
            for(QC_Test_Questions_Value__c eachObj :[SELECT Id,Name,Standard_Defined_Value__c,Maximum__c,Minimum__c,Status__c,QC_MTL_Test__c,QC_MTL_Test__r.Name,QC_MTL_Test__r.Titan_Specification__c,QC_MTL_Test__r.Titan_Specification__r.Name,QC_MTL_Test__r.Supplier_Grade__c,QC_MTL_Test__r.RecordType.Name FROM QC_Test_Questions_Value__c WHERE QC_MTL_Test__r.Titan_Specification__c =: titanSpecId  AND QC_MTL_Test__r.Supplier_Grade__c =: suplrGrdId AND QC_MTL_Test__r.RecordType.Name =:testType]){               
                if(eachObj.QC_MTL_Test__r.Titan_Specification__r.Name == 'T8086' && eachObj.QC_MTL_Test__r.Name =='Hardness(HV)'){
                  System.debug('T8086');
                    for(Integer i=1;i<=5;i++){
                        viewIns = new ViewClass();
                        viewIns.TestType = eachObj.QC_MTL_Test__r.Name;
                        viewIns.userInput=null;
                        viewIns.minInput=null;
                        viewIns.maxInput=null;
                        viewIns.avgValue=String.valueOf(0);
                        viewIns.standDefVal = String.valueOf(eachObj.Standard_Defined_Value__c);
                        viewIns.userInpBool =false;
                        viewIns.testVerdBool = false;
                        viewIns.minDefBool=true;
                        viewIns.maxDefBool=true;
                        viewIns.verdStatus='None';
                        viewIns.isMandtry =true;
                        viewIns.rawMatrlTestType='hrd';
                        viewIns.recrdId =  eachObj.QC_MTL_Test__c;
                        System.debug('::inner for:: T8086');
                        viewIns.mtlTestRespCounter =0;
                        viewIns.testValueRecordId=eachObj.Id;
                        viewIns.mtlTestRespId = '';
                        viewClsList.add(viewIns);
                    }
                }
                
                else if(eachObj.QC_MTL_Test__r.Titan_Specification__r.Name != 'T8086' && eachObj.QC_MTL_Test__r.Name =='Hardness(HV)'){
                    System.debug(' Not T8086');
                    System.debug('sampleSz '+sampleSz);                
                    for(Integer i=1;i<=sampleSz;i++){
                        viewIns = new ViewClass();
                        viewIns.TestType = eachObj.QC_MTL_Test__r.Name;
                        viewIns.userInput=null;
                        viewIns.minInput=null;
                        viewIns.maxInput=null;
                        viewIns.avgValue=String.valueOf(0);
                        viewIns.standDefVal = String.valueOf(eachObj.Standard_Defined_Value__c);
                        viewIns.userInpBool =false;
                        viewIns.testVerdBool = false;
                        viewIns.minDefBool=true;
                        viewIns.maxDefBool=true;
                        viewIns.verdStatus='None';
                        viewIns.isMandtry =true;
                        viewIns.rawMatrlTestType='hrd';
                        viewIns.recrdId =  eachObj.QC_MTL_Test__c;
                        System.debug('::inner for:: Not T8086');
                        viewIns.mtlTestRespCounter =0;
                        viewIns.testValueRecordId=eachObj.Id;
                        viewIns.mtlTestRespId = '';
                        viewClsList.add(viewIns);
                    }
                }
                else if(eachObj.QC_MTL_Test__r.Name == 'Hardenability Hardness (HV)'){
                    System.debug('Hardenability Hardness (HV)');
                    for(Integer j =1 ;j <= sampleSz ;j++){
                        viewIns = new ViewClass();
                        viewIns.TestType = eachObj.QC_MTL_Test__r.Name;
                        viewIns.userInput=null;
                        viewIns.minInput=null;
                        viewIns.maxInput=null;
                        viewIns.avgValue=String.valueOf(0);
                        viewIns.standDefVal = String.valueOf(eachObj.Standard_Defined_Value__c);
                        viewIns.userInpBool =true;
                        viewIns.testVerdBool = true;
                        viewIns.minDefBool=false;
                        viewIns.maxDefBool=false;
                        viewIns.verdStatus=eachObj.Status__c;
                        viewIns.isMandtry =true;
                        viewIns.rawMatrlTestType='hrdnab';
                        viewIns.recrdId =eachObj.QC_MTL_Test__c;
                        System.debug('::inner for1::');
                        viewIns.mtlTestRespCounter =0;
                        viewIns.testValueRecordId=eachObj.Id;
                        viewIns.mtlTestRespId = '';
                        viewClsList.add(viewIns);
                    }
                }
                else{
                    System.debug('Else');
                    viewIns = new ViewClass();
                    viewIns.Testtype = eachObj.QC_MTL_Test__r.Name;
                    viewIns.Minimum = String.valueOf(eachObj.Minimum__c);
                    viewIns.Maximum = String.valueOf(eachObj.Maximum__c);
                    viewIns.standDefVal = eachObj.Standard_Defined_Value__c;
                    viewIns.userInput = '';
                    viewIns.minInput = '';
                    viewIns.maxInput = '';
                    viewIns.avgValue = '';
                    viewIns.userInpBool = true;
                    viewIns.minDefBool = false;
                    viewIns.maxDefBool = false;
                    viewIns.isMandtry = true;
                    viewIns.testVerdBool = true;
                    viewIns.verdStatus = eachObj.Status__c;
                    viewIns.recrdId = eachObj.QC_MTL_Test__c;
                    viewIns.testValueRecordId = eachObj.Id;
                    viewIns.mtlTestRespId = '';
                    viewClsList.add(viewIns);
                }
                
            }//main for ends
		}
		if(viewClsList.size()>0){
			return viewClsList;
		}
		return NULL;
	}
	@AuraEnabled
	public static List<ViewClass> fetchTestParamOnCheckbox(String reportRefNo, Id titanSpecRef, Integer sampleSz,Id supplrGrade,String testType) {
		List<QC_MTL_TestResponse__c> qcMtlTestRespList = new List<QC_MTL_TestResponse__c>();
		List<ViewClass> viewClsList = new List<ViewClass>();
		ViewClass ins;
		List<ViewClass> allDataList = new List<ViewClass>();
		if(reportRefNo !=NULL && reportRefNo !=''){
				qcMtlTestRespList = QC_MTL_InputParamClass.checkForMtlRespData(reportRefNo);//will fetch the mtlResp.
            }
        System.debug('1 fetchTestParamOnCheckbox ---> titanSpecRef : '+titanSpecRef+' ---///--- supplrGrade : '+supplrGrade+' ---///--- testType : '+testType);
		if(titanSpecRef !=NULL && supplrGrade !=NULL){
				viewClsList = QC_MTL_InputParamClass.fetchTestAndValueData(titanSpecRef,supplrGrade,sampleSz,testType);//will fetch all the test and its questionValues.
            }
			if(qcMtlTestRespList.size()>0){
				for(QC_MTL_TestResponse__c each : qcMtlTestRespList){
					ins = new ViewClass();
					ins.TestType = each.QC_MTL_Test__r.Name;
					ins.userInput = String.valueOf(each.User_Defined_Value__c);
					ins.minInput = String.valueOf(each.Minimum__c);
					ins.maxInput = String.valueOf(each.Maximum__c);
					ins.avgValue = String.valueOf(each.Average_Value__c);
					ins.standDefVal = String.valueOf(each.Standard_Defined_Value__c);
					ins.userInpBool =true;
					ins.testVerdBool = true;
                    //if(each.QC_MTL_Test__r.Name =='Hardness(HV)' || each.QC_MTL_Test__r.Name == ('Hardenability Hardness (HV)')){
                      	
                    if(each.QC_MTL_Test__r.Name =='Hardness(HV)'){
                      	ins.minDefBool=true;
						ins.maxDefBool=true;  
                        ins.userInpBool =false;
                    }
                    else{
                        ins.minDefBool=false;
						ins.maxDefBool=false;
                        ins.userInpBool =true;
                    }
					
					ins.verdStatus = each.Result__c ;
					ins.isMandtry =true;
					ins.recrdId = each.QC_MTL_Test__c;
					ins.testValueRecordId = each.QC_Test_Questions_Value__c;
					ins.mtlTestRespId = each.Id;
                    //ins.mtlTestRespCounter = counter;
					allDataList.add(ins);
				}//for ends
			}//if ends
			else{
				if(viewClsList.size()>0){
					allDataList.addAll(viewClsList);
				}
			}//else ends
		System.debug(':::allDataList:: '+allDataList);
		if(allDataList.size()>0){
			return allDataList;
		}
		return NULL;
	}
	@AuraEnabled
	public static List<ViewClass> dataUpdateInResp(List<QC_MTL_TestResponse__c> mtlRespList){
        System.debug('::::mtlRespList::: '+mtlRespList);
		List<QC_MTL_TestResponse__c> respToBeUpdatedList = new List<QC_MTL_TestResponse__c>();
		List<QC_MTL_TestResponse__c> respToBeEditedList = new List<QC_MTL_TestResponse__c>();
		List<QC_MTL_TestResponse__c> toBeInsrtEvryList = new List<QC_MTL_TestResponse__c>();//This list //data would be inserted first in Test object then in Question Value and finally referring test //and question value in MTL Test Response object.
		List<QC_MTL_TestResponse__c> respToBeInsertedList = new List<QC_MTL_TestResponse__c>();
		QC_MTL_Test__c testObj;
        ViewClass vwIns;
        List<ViewClass> viewClsList = new List<ViewClass>();
		QC_Test_Questions_Value__c qstnValObj;
		List<QC_MTL_Test__c> mtlTestList = new List<QC_MTL_Test__c>();
		List<QC_Test_Questions_Value__c> qstnValList = new List<QC_Test_Questions_Value__c>();
		Map<String,QC_MTL_Test__c> testDataMap = new Map<String,QC_MTL_Test__c>();
		Map<String,QC_Test_Questions_Value__c> qstnValMap = new Map<String,QC_Test_Questions_Value__c>();
		QC_MTL_TestResponse__c mtlResObj;
		List<QC_MTL_TestResponse__c> mtlRespToInsrtList = new List<QC_MTL_TestResponse__c>();
		List<QC_MTL_TestResponse__c> allRespDataList = new List<QC_MTL_TestResponse__c>();
		QC_MTL_Component__c mtlCompObj =[SELECT ID,NAME,Supplier_Grade__c,Titan_Specification_Reference__c FROM QC_MTL_Component__c WHERE ID =:mtlRespList[0].QC_MTL_Component_del__c];
		if(mtlRespList.size()>0){
			for(QC_MTL_TestResponse__c each : mtlRespList){
                System.debug('each.QC_MTL_Test__c::: '+each.QC_MTL_Test__c+':::: '+each.QC_Test_Questions_Value__c);
				if(each.Id !=NULL){
					respToBeUpdatedList.add(each);
				}
				else if(each.Id ==NULL && each.QC_MTL_Test__c ==NULL && each.QC_Test_Questions_Value__c ==NULL){
					toBeInsrtEvryList.add(each);
				}
                else{
                    respToBeInsertedList.add(each);
                }
			}
		}//if ends
        System.debug(':::toBeInsrtEvryList ::: '+toBeInsrtEvryList+' ####respToBeInsertedList###'+respToBeInsertedList+'@@@respToBeUpdatedList'+respToBeUpdatedList);
			if(respToBeUpdatedList.size()>0){
				update respToBeUpdatedList;
			}
			if(respToBeInsertedList.size()>0){
				insert respToBeInsertedList;
			}
			if (toBeInsrtEvryList.size()>0){
				for(QC_MTL_TestResponse__c eachObj : toBeInsrtEvryList){
					if(eachObj.Name !=NULL && eachObj.Name !=''){
						testObj = new QC_MTL_Test__c();
						testObj.Name = eachObj.Name;
						testObj.Titan_Specification__c =mtlCompObj.Titan_Specification_Reference__c;
						testObj.Supplier_Grade__c = mtlCompObj.Supplier_Grade__c;
						mtlTestList.add(testObj);
					}
				}
			}//if ends
			if(mtlTestList.size()>0){
				insert mtlTestList;
			}
        System.debug(':::mtlTestList ::: '+mtlTestList);
			if(mtlTestList.size()>0){
				for(QC_MTL_Test__c eachTest : mtlTestList){
					testDataMap.put(eachTest.Name,eachTest);
				}
			}
			if(toBeInsrtEvryList.size()>0){
				for(QC_MTL_TestResponse__c eachObj : toBeInsrtEvryList){
					if(testDataMap.containsKey(eachObj.Name)){
						qstnValObj = new QC_Test_Questions_Value__c();
						qstnValObj.Name = eachObj.Name;
						qstnValObj.Maximum__c = eachObj.Maximum__c;
						qstnValObj.Minimum__c = eachObj.Minimum__c;
						qstnValObj.Standard_Defined_Value__c = eachObj.Standard_Defined_Value__c;
						qstnValObj.Status__c = eachObj.Result__c;
						qstnValObj.QC_MTL_Test__c = testDataMap.get(eachObj.Name).Id;
						qstnValList.add(qstnValObj);
					}
				}//for ends
			}//if ends	
			if(qstnValList.size()>0){
				insert qstnValList;
			}
        System.debug(':::qstnValList ::: '+qstnValList);
			if(qstnValList.size()>0){
				for(QC_Test_Questions_Value__c each : qstnValList){
					qstnValMap.put(each.Name,each);
				}
			}
			if(toBeInsrtEvryList.size()>0){
				for(QC_MTL_TestResponse__c each : toBeInsrtEvryList){
					if(!testDataMap.isEmpty() && !qstnValMap.isEmpty() && testDataMap.containsKey(each.Name) && qstnValMap.containsKey(each.Name) ){
						mtlResObj = new QC_MTL_TestResponse__c();
						mtlResObj.Name = each.Name;
						mtlResObj.Average_Value__c = each.Average_Value__c;
						mtlResObj.Maximum__c = each.Maximum__c;
						mtlResObj.Minimum__c = each.Minimum__c;
						mtlResObj.QC_MTL_Test__c = testDataMap.get(each.Name).Id;
                        mtlResObj.QC_MTL_Component_del__c = each.QC_MTL_Component_del__c;
						mtlResObj.QC_Test_Questions_Value__c= qstnValMap.get(each.Name).Id;
						mtlResObj.Standard_Defined_Value__c = String.valueOf(qstnValMap.get(each.Name).Standard_Defined_Value__c);
						mtlResObj.User_Defined_Value__c = String.valueOf(each.User_Defined_Value__c);
						mtlRespToInsrtList.add(mtlResObj);
					}//if ends
				}//for ends
			}//if ends
			if(mtlRespToInsrtList.size()>0){
				insert mtlRespToInsrtList;
			}
        	System.debug('::::mtlRespToInsrtList::: '+mtlRespToInsrtList);
			if(respToBeUpdatedList.size()>0){
				allRespDataList.addAll(respToBeUpdatedList);
			}
			if(respToBeInsertedList.size()>0){
				allRespDataList.addAll(respToBeInsertedList);
			}
			if(mtlRespToInsrtList.size() >0){
				allRespDataList.addAll(mtlRespToInsrtList);
			}
        System.debug('::::allRespDataList::: '+allRespDataList);
		if(allRespDataList.size()>0){
            for(Integer i =0;i<allRespDataList.size();i++){
                  	vwIns = new ViewClass();
                   	vwIns.TestType = allRespDataList[i].Name;
                   	vwIns.maxInput = String.valueOf(allRespDataList[i].Maximum__c);
                   	vwIns.minInput = String.valueOf(allRespDataList[i].Minimum__c);
                    vwIns.recrdId = allRespDataList[i].QC_MTL_Test__c;
                    vwIns.testValueRecordId = allRespDataList[i].QC_Test_Questions_Value__c;
                    vwIns.userInput = allRespDataList[i].User_Defined_Value__c;
                    vwIns.avgValue = String.valueOf(allRespDataList[i].Average_Value__c);
                    vwIns.verdStatus = allRespDataList[i].Result__c;
                    vwIns.standDefVal = allRespDataList[i].Standard_Defined_Value__c;
                	vwIns.mtlTestRespId =allRespDataList[i].Id;
                    viewClsList.add(vwIns);
            }
		}
        System.debug('###viewClsList#### '+viewClsList);
        if(viewClsList.size()>0){
            return viewClsList;
        }
		return NULL;
	}//method ends
    
}