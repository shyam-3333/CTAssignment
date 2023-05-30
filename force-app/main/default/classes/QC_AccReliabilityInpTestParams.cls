public class QC_AccReliabilityInpTestParams {
    
     /*This method would help the user to save the Reliability's Input Parameter Data
     * 
     */
    @AuraEnabled
    public static List<WrapperClass> viewReliabInputParamQstn(String category){
       List<QC_Access_Questions__c> qcQstnLst= new List<QC_Access_Questions__c>();
        qcQstnLst=[SELECT ID,Name,Questions__c,Question_Type__c,Testing_Type__c,Category__c,onLoad__c,(SELECT ID,Option_Value__c,Question_Name__c FROM QC_Access_QuesOptions__r) FROM QC_Access_Questions__c WHERE 
                   RecordTypeId=:Schema.SObjectType.QC_Access_Questions__c.getRecordTypeInfosByName().get('Input Questions').getRecordTypeId() AND 
                   onLoad__c= TRUE AND Category__c =:category  AND Testing_Type__c = 'Common'];
        List<WrapperClass> wrapClassList=new List<WrapperClass>();
        WrapperClass wrpcls;
		List<WrapperClassOptions> lstOpp;
		WrapperClassOptions wopp;
        if(qcQstnLst.size()>0){
            for(QC_Access_Questions__c pass : qcQstnLst){
                wrpcls= new WrapperClass();
                wrpcls.label=pass.Questions__c;
                wrpcls.questionType=pass.Question_Type__c;
				wrpcls.qstnId=pass.Id;
                lstOpp = new list<WrapperClassOptions>();
                if(!pass.QC_Access_QuesOptions__r.isEmpty()){
                    for(QC_Access_QuesOption__c qaq  : pass.QC_Access_QuesOptions__r){
                        wopp = new WrapperClassOptions();
                        wopp.label = qaq.Option_Value__c;
                        wopp.value = qaq.Option_Value__c;
                        wopp.resId = qaq.Id;
                        wopp.selected = false;
                        lstOpp.add(wopp);
                    }
                }
                wrpcls.qstnOptionList=lstOpp;
                wrapClassList.add(wrpcls);
            }
        }
        if(wrapClassList.size()>0){
			System.debug('=====wrapClassList=====>>'+wrapClassList);
           return wrapClassList; 
        }
        
        return null;
        
    }//method ends
    
     public class WrapperClass{
        @AuraEnabled
        public String label{get;set;}
		@AuraEnabled
		public String qstnId {get;set;}
        @AuraEnabled
        public String questionType {get;set;}
        @AuraEnabled
        public List<WrapperClassOptions> qstnOptionList {get;set;}
    }
    
    public class WrapperClassOptions{
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public String value {get;set;}
        @AuraEnabled
        public String resId {get;set;}
        @AuraEnabled
        public boolean selected {get;set;}
       
    }
    
     @AuraEnabled
    public static List<WrapperTestClass> reliabTestParamWrapper(String category,String subCategory, String QestIdAndResponseIds){
        System.debug('------QestIdAndResponseIds---->>'+QestIdAndResponseIds);
        System.debug(':::category:::'+subCategory);
         System.debug(':::category:::'+category);
		//QestIdAndResponseIds  ex: qid_res1,res2,res3
		List<WrapperTestClass> wrpTestParamList= new List<WrapperTestClass>();
		List<QC_Access_Questions__c> qstnOptionList = new List<QC_Access_Questions__c>();
		Map<Id,QC_Access_Questions__c> qstnDetailMap = new Map<Id,QC_Access_Questions__c>();
		List<QC_Access_Condition__c> qcAccCondtnList = new List<QC_Access_Condition__c>();
		String respVal1;
        
		Set<Id> qstnOptionsId = new Set<Id>();
		Set<Id> qstnIdsSet = new Set<Id>();
			respVal1 =QestIdAndResponseIds.substring(QestIdAndResponseIds.indexOf('_')+1);
			System.debug('---respVal1----->>'+respVal1);
			List<Id> respIdList = new List<Id>();
			if(respVal1.contains(',')){
				respIdList.addAll(respVal1.split(','));
			}
			else{
				respIdList.add(respVal1);
			}
			System.debug('-----respIdList----->>'+respIdList);
			if(!respIdList.isEmpty()){
				for(QC_Access_QuesOption__c each : [SELECT ID,Name, Category__c,Question_Name__c,Sub_Category__c,Option_Value__c,QC_Questions__c FROM QC_Access_QuesOption__c WHERE ID IN :respIdList]){
					if(each.Question_Name__c.equalsIgnoreCase('Main Material')){
						System.debug('----Id----->>'+each.Id);
						qstnOptionsId.add(each.Id);
					}
					else{
						break;
					}
				}//for ends
			}//if ends
			System.debug('---qstnOptionsId------>>'+qstnOptionsId);
			if(!qstnOptionsId.isEmpty()){
				for(QC_Access_Condition__c each :[SELECT ID,NAME,Condition_Values__c,Question__c,Question_Options__c,Brand__c 	FROM QC_Access_Condition__c WHERE Question_Options__c IN :qstnOptionsId]){
					if(each.Question__c !=NULL){
						qstnIdsSet.add(each.Question__c);
					}
				}//for ends
			}//if ends
        	System.debug('::::qstnIdsSet size:::' +qstnIdsSet.size());
			System.debug('---qstnIdsSet----->>'+qstnIdsSet);
			if(qstnIdsSet.size()>0){
				for(QC_Access_Questions__c each :[SELECT ID,Name,Product_Specification__c,Acceptance_Criteria__c,Sub_Category__c,Category__c,Test_Name__c,Testing_Type__c FROM QC_Access_Questions__c WHERE ID IN : qstnIdsSet AND Testing_Type__c ='Reliability Testing' AND ((Sub_Category__c = :subCategory AND Category__c = :category) OR (Category__c = :category AND (Sub_Category__c =NULL OR Sub_Category__c='' ))) order By Test_Name__c]){
						qstnDetailMap.put(each.Id,each);
                    System.debug('::coming if category not null:::');
				}//for ends
				//for(QC_Access_Questions__c each : [SELECT ID,Name,Product_Specification__c,Acceptance_Criteria__c,Sub_Category__c,Category__c,Test_Name__c,Testing_Type__c FROM QC_Access_Questions__c WHERE ID IN : qstnIdsSet AND Testing_Type__c='Reliability Testing' AND Category__c = :category AND (Sub_Category__c =NULL OR Sub_Category__c='' )]){
				//qstnDetailMap.put(each.Id,each);
                 //System.debug(':::for sub categ null or blank::');   
			//}//for ends
			}//if ends
			
			
			System.debug('-----qstnDetailMap----->>>'+qstnDetailMap);
        	System.debug('::::qstnDetailMap size:::'+qstnDetailMap.size());
			
		
				
				WrapperTestClass wrpTestParam= new wrapperTestClass();
				if(!qstnDetailMap.isEmpty() && qstnDetailMap.keySet() != null){
                    string lastName = '';
					for(Id eachId : qstnDetailMap.keySet()){
                        wrpTestParam= new WrapperTestClass();
                        wrpTestParam.testName=qstnDetailMap.get(eachId).Test_Name__c;
                        if(lastName != qstnDetailMap.get(eachId).Test_Name__c){
                            wrpTestParam.testNameForDisplay=qstnDetailMap.get(eachId).Test_Name__c;
                            lastName = qstnDetailMap.get(eachId).Test_Name__c;
                        }else{
                            wrpTestParam.testNameForDisplay= '';
                        }
						wrpTestParam.testQuestId = eachId;
						wrpTestParam.productSpec=qstnDetailMap.get(eachId).Product_Specification__c;
						wrpTestParam.acceptanceCriteria=qstnDetailMap.get(eachId).Acceptance_Criteria__c;
						wrpTestParam.observation='';
						wrpTestParam.finalVerdict='None';
                        wrpTestParam.remarks = '';
						wrpTestParamList.add(wrpTestParam);
					}
				}
				System.debug('-----wrpTestParamList----->>'+wrpTestParamList);
        		System.debug(':::wrpTestParamList szie:::'+wrpTestParamList.size());
				
        if(wrpTestParamList.size()>0){
            return wrpTestParamList;
        }return null;
    }//method ends
    
     public class WrapperTestClass{
        @AuraEnabled
        public String testName{get;set;}
        @AuraEnabled
        public String testQuestId{get;set;}
        @AuraEnabled
        public String productSpec{get;set;}
        @AuraEnabled
        public String acceptanceCriteria{get;set;}
        @AuraEnabled
        public String observation{get;set;}
        @AuraEnabled
        public string finalVerdict{get;set;}
        @AuraEnabled
        public string remarks{get;set;}
		@AuraEnabled
        public string erroeMessage{get;set;}
        @AuraEnabled
        public String testNameForDisplay{get;set;}
        }
     
    //This method is helping us to save the Input Parameters value for Reliability/Reliability-ReSubmission.
   
   
    @AuraEnabled
    public static Void saveReliabInpRespData(String qaqrList,string operation){
        System.debug('====qaqrList===>>>'+qaqrList);
         List<SObject> newSObjectsList = convertJSONToListOfSObject(qaqrList);
         if(operation == 'insert'){
         	insert newSObjectsList;
         }
        if(operation == 'update'){
            String qcAccessComponentId = '';
            for(sObject obj :newSObjectsList){
                qcAccessComponentId = String.valueOf(obj.get('QC_Access_Component__c'));
                System.debug('====qcAccessComponentId===>>>'+qcAccessComponentId);
                
            }
            delete [select Id from QC_Access_QuesResponse__c where QC_Access_Component__c = :qcAccessComponentId];
             insert newSObjectsList;
        }
        
    }
    
    private static List<SObject> convertJSONToListOfSObject(String json) {
        System.debug('====json====>>'+json);
        object[] values = (object[])System.JSON.deserializeUntyped(json);
        //String recordTypeId = Schema.SObjectType.QC_Access_QuesResponse__c.getRecordTypeInfosByName().get('Input Type').getRecordTypeId();
        List<SObject> newSObjectsList = new List<SObject>();
        for (Object v : values) {
            Map<String, Object> m = (Map<String, Object>)v;
            System.debug('====mmm=====>>'+m);
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get((String)m.get('sobjectType'));
			System.debug('===targetType--==>>'+targetType);
            SObject o = targetType.newSObject();
			System.debug('===oooooo--==>>'+o);
            Map<String, Schema.SObjectField> fields = targetType.getDescribe().fields.getMap();
            System.debug('===fields--==>>'+fields);
            for (String fieldName : m.keySet()) {
                // Filter out any psuedo fields such as LastNameLocal
                Schema.SObjectField fi = fields.get(fieldName);
                System.debug('===fififi--==>>'+fi);
                if (fi != null) {
                    if (fi.getDescribe().isCreateable() && fi.getDescribe().isUpdateable()) {
                        o.put(fieldName, m.get(fieldName));
                        System.debug('===ooo111===>>'+o);
                        //o.put('recordTypeId', recordTypeId);
                        System.debug('===ooo232===>>'+o);
                    }
                }
            }

            newSObjectsList.add(o);
        }

        return newSObjectsList;
    }

  @AuraEnabled
	public static List<WrapQstnRespData> viewInpforReSubmission(sObject reportRefId){
        system.debug('------reportRefId-------'+reportRefId);
		QC_Access_Component__c qcCompObj = (QC_Access_Component__c)reportRefId;
		List<QC_Access_QuesResponse__c> qcAccRespList = new List<QC_Access_QuesResponse__c>();
		List<WrapQstnRespData> wrpQstnRespList = new List<WrapQstnRespData>();
		qcAccRespList = [SELECT Id,Name,Multiple_QuesResponseId__c,QC_Access_Component__c,QC_Access_Condition__c,QC_Access_Questions__c,
						Response_Values__c FROM QC_Access_QuesResponse__c WHERE QC_Access_Component__c =:qcCompObj.Id AND
						 RecordTypeId=:Schema.SObjectType.QC_Access_QuesResponse__c.getRecordTypeInfosByName().get('Input Type').getRecordTypeId()];
						
			System.debug('==qcAccRespList===>>'+qcAccRespList);
			Map<Id,Id> compQstnMap = new Map<Id,Id>();
			Map<Id,List<String>> qstnRespMap = new Map<Id,List<String>>();
			Map<Id,List<String>> qstnRespIdMap = new Map<Id,List<String>>();
			if(qcAccRespList.size()>0){
				for(QC_Access_QuesResponse__c accResObj : qcAccRespList){
                    List<String> responseValuesList = new List<String>();
					List<String> responseIdList = new List<String>();
					compQstnMap.put(accResObj.QC_Access_Component__c,accResObj.QC_Access_Questions__c);
					if((accResObj.QC_Access_Questions__c !=NULL && accResObj.Response_Values__c !=NULL)){
						if(accResObj.Response_Values__c.contains(',')){
							responseValuesList.addAll(accResObj.Response_Values__c.split(','));
								}
						else{
							responseValuesList.add(accResObj.Response_Values__c);
						}
                        if(accResObj.Multiple_QuesResponseId__c.contains(',')){
							responseIdList.addAll(accResObj.Multiple_QuesResponseId__c.split(','));
								}
						else{
							responseIdList.add(accResObj.Multiple_QuesResponseId__c);
						}

						qstnRespMap.put(accResObj.QC_Access_Questions__c,responseValuesList);
                        qstnRespIdMap.put(accResObj.QC_Access_Questions__c,responseIdList);
					}    
				}//for loop ends
			}//if ends (qcAccRespList.size()>0)
			System.debug('---===qstnRespMap---====>>'+qstnRespMap);
			System.debug('---===compQstnMap---====>>'+compQstnMap);
			WrapQstnRespData wrpObj;
			for(Id eachId : qstnRespMap.keySet()){
				wrpObj= new WrapQstnRespData();
				wrpObj.qstnLabel=eachId;
				wrpObj.respValList=qstnRespMap.get(eachId);
                wrpObj.respIdList = qstnRespIdMap.get(eachId);
				wrpQstnRespList.add(wrpObj);
			}
        if(wrpQstnRespList.size()>0){
           return wrpQstnRespList;	 
        }
				return null;					
	}
    //This Wrapper Class is related to viewInpforReSubmission method helping in returning the data in wrapper list to display.
	public class WrapQstnRespData{
        @AuraEnabled
        public String qstnLabel {get;set;}
        @AuraEnabled
        public List<String> respValList {get;set;}
        @AuraEnabled
        public List<String> respIdList {get;set;}
    }
    
    @AuraEnabled
    public static List<WrapTestParamClass> viewTestParamReSubmission(sObject reportRefId){
        System.debug('===reportRefId--->>'+reportRefId);
        List<WrapTestParamClass> wrapTestParamList = new List<WrapTestParamClass>();
        QC_Access_Component__c qcObj = (QC_Access_Component__c)reportRefId;
        List<QC_Access_QuesResponse__c> qcAccTestParamList=[SELECT ID,Name,Multiple_QuesResponseId__c,Response_Values__c,Observation__c,
                                                           Remarks__c,Verdict__c,QC_Access_Questions__r.Name,QC_Access_Questions__r.Test_Name__c,QC_Access_Questions__r.Product_Specification__c,QC_Access_Questions__r.Acceptance_Criteria__c FROM QC_Access_QuesResponse__c WHERE RecordTypeId=:Schema.SObjectType.QC_Access_QuesResponse__c.getRecordTypeInfosByName().get('Test Type').getRecordTypeId() AND
                                                            QC_Access_Component__c =:qcObj.Id];
        System.debug('----qcAccTestParamList---->>'+qcAccTestParamList.size());
        Map<Id,QC_Access_QuesResponse__c> testParamQcAccQstnMap = new Map<Id,QC_Access_QuesResponse__c>();//This map will hold the TestResp Id & QC_Access_QuesResponse__c;
        if(qcAccTestParamList.size()>0){
            for(QC_Access_QuesResponse__c qcAcc : qcAccTestParamList){
                	testParamQcAccQstnMap.put(qcAcc.Id , qcAcc);
                	
            }//for ends
        }// if ends (qcAccTestParamList.size()>0)
        System.debug('------testParamQcAccQstnMap---->>'+testParamQcAccQstnMap);
        WrapTestParamClass wrpObj;
        if(!testParamQcAccQstnMap.isEmpty()){
            String lastName='';
            for(Id eachId : testParamQcAccQstnMap.keySet()){
                wrpObj = new WrapTestParamClass();
                wrpObj.testParamQstnLabel = testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Test_Name__c;
                if(lastName != testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Test_Name__c){
                            wrpObj.testNameForDisplay=testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Test_Name__c;
                            lastName = testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Test_Name__c;
                        }else{
                            wrpObj.testNameForDisplay= '';
                        }
				wrpObj.testQuestId = testParamQcAccQstnMap.get(eachId).QC_Access_Questions__c;
                wrpObj.testParamProdSpec = testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Product_Specification__c;
                wrpObj.testParamAccep = testParamQcAccQstnMap.get(eachId).QC_Access_Questions__r.Acceptance_Criteria__c;
                wrpObj.testParamObservation =testParamQcAccQstnMap.get(eachId).Observation__c;
                wrpObj.testParamVerdict = testParamQcAccQstnMap.get(eachId).Verdict__c;
                if(wrpObj.testParamVerdict != 'Reject'){
                    wrpObj.isDesabled = true;
                }else{
                    wrpObj.isDesabled = false;
                }
                wrpObj.remarks = testParamQcAccQstnMap.get(eachId).Remarks__c;
                wrapTestParamList.add(wrpObj);
            }
        }System.debug('----wrapTestParamList---->>'+wrapTestParamList);
        if(wrapTestParamList.size() > 0){
            return wrapTestParamList;
        }
        return null;
        
        
    }//method ends
     
    public class WrapTestParamClass{
        @AuraEnabled
        public String testParamQstnLabel {get;set;}
        @AuraEnabled
        public String testParamProdSpec {get;set;}
        @AuraEnabled
        public String testParamAccep {get;set;}
        @AuraEnabled
        public String testParamObservation {get;set;}
        @AuraEnabled
        public String testParamVerdict {get;set;}
        @AuraEnabled
        public String remarks {get;set;}
        @AuraEnabled
        public String testQuestId{get;set;}
        @AuraEnabled
        public String testNameForDisplay{get;set;}
        @AuraEnabled
        public Boolean isDesabled{get;set;}

        
    }  
    
     @AuraEnabled
    public static list<QC_Access_Questions__c> saveAddTestParam(list<QC_Access_Questions__c> addTestRowList){
    	Set<Id> newQuesId = new Set<Id>();
        list<QC_Access_Questions__c> newQuesList = new list<QC_Access_Questions__c>();
       // List<QC_Access_Questions__c> questionsLst = (List<QC_Access_Questions__c>)addTestRowList;
        system.debug('------questionsLst----'+addTestRowList);
        
        system.debug('------questionsLst.Name----'+addTestRowList[0].Test_Name__c);
        system.debug('------questionsLst.Name----'+addTestRowList[0].Temp_Observation__c);
        system.debug('------questionsLst.Name----'+addTestRowList[0].Temp_Verdict__c);
       /* for(QC_Access_Questions__c var : addTestRowList){
            var.
        }*/
        if(addTestRowList.size()> 0){
            insert addTestRowList;
        }
       
        for(QC_Access_Questions__c qcAccQuesId : addTestRowList){
            newQuesId.add(qcAccQuesId.Id);
        }
        system.debug('----newQuesId------'+newQuesId);
        if(newQuesId != null) {
        	newQuesList = [SELECT Id,Test_Name__c,Temp_Observation__c,Temp_Verdict__c,Product_Specification__c,Acceptance_Criteria__c,Temp_Remarks__c FROM QC_Access_Questions__c WHERE Id IN :newQuesId ];
        }
        system.debug('------newQuesList-------'+newQuesList);
        return newQuesList;
        
    }

	

}//main class ends