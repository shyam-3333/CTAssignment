@isTest
public with sharing class QC_TestHandlerCls {
    //
    public static list<QC_Question__c> getComponentQuestions(){
       id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
       list<QC_Question__c> questionList = new list<QC_Question__c>();
       for(integer i=1;i<=5;i++){
         QC_Question__c ques = new QC_Question__c(Question__c     = 'question'+i,
                                                  Component_Type__c='Full-Watch',
                                                  Order_Number__c = 10*i,
                                                  Onload__c       = false,
                                                  Type__c         = 'Picklist',
                                                  Comment_Required__c = true,
                                                  recordtypeid = rtid);
           if(i==2){
               ques.Component_Type__c  ='Module';
            }
          questionList.add(ques);  
       }
       
       for(integer i=1;i<=5;i++){
         QC_Question__c ques = new QC_Question__c(Question__c     = 'questionFT'+i,
                                                  Component_Type__c='Full-Watch',
                                                  Order_Number__c = 10*i,
                                                  Onload__c       = true,
                                                  Type__c         = 'Free Text',
                                                  recordtypeid = rtid);
           if(i==2){
               ques.Component_Type__c  ='Module';
            }
          questionList.add(ques);  
       }
        for(integer i=1;i<=5;i++){
         QC_Question__c ques = new QC_Question__c(Question__c     = 'questionMS'+i,
                                                  Component_Type__c='Full-Watch',
                                                  Order_Number__c = 10*i,
                                                  Onload__c       = true,
                                                  Type__c         = 'Multi-select',
                                                  recordtypeid = rtid);
            if(i==2){
               ques.Component_Type__c  ='Module';
            }
          questionList.add(ques);  
       }
       
       return questionList;
    }
    //Method for Test questions
    public static list<QC_Question__c> getTestQuestions(){
       id rtId = [select id from recordtype where developername='Test' and SobjectType='QC_Question__c'].id;
       list<QC_Question__c> questionList = new list<QC_Question__c>();
       for(integer i=1;i<=10;i++){
         QC_Question__c ques = new QC_Question__c(Test_Name__c = 'sample Test'+i,
                                                  Specification__c ='sample Sepcification'+i,
                                                  UOM__c = 'sample UOM'+i,
                                                  recordtypeid = rtid);
          questionList.add(ques);                    
       }
       QC_Question__c ques = new QC_Question__c(Test_Name__c = 'sample Test',Specification__c ='No Stoppage - During the test',UOM__c = 'sample UOM', recordtypeid = rtid);
       questionList.add(ques);
       ques = new QC_Question__c(Test_Name__c = 'sample Test',Specification__c ='No Stoppage',UOM__c = 'sample UOM', recordtypeid = rtid);
       questionList.add(ques);
       return questionList;
    }
    //Method for question's responses
    public static list<QC_Response__c> getQuesResponses(){
      list<QC_Response__c> responseList = new list<QC_Response__c>();
      for(integer i=1;i<=15;i++){
         QC_Response__c res = new QC_Response__c(Response__c ='sampleRes'+i,
                                                 Order_Number__c=10*i);
         responseList.add(res);
      }
      return responseList;
    }
    //Method for inserting individual component
    public static QC_Components__c getIndividComponent() {
    	QC_Components__c comp = new QC_Components__c(name__c='Full-Watch');
    	return comp;
    } 
     //Method for insertint parent components
	public static  list<QC_Components__c> getParentComponents() {
    	list<QC_Components__c> compParentList = new list<QC_Components__c>();
    	for(integer i=0;i<2;i++){
    		QC_Components__c qcParentComp = new QC_Components__c(Name__c = 'Full-Watch',master__c=true);
    		compParentList.add(qcParentComp);
    	}
    	return compParentList;
    }
    
   //Method for Questions Condition
	public static  list<QC_Condition__c> getQuestionConditions() {
		id rtId = [select id from recordtype where developername='Question_Condition' and SobjectType='QC_Condition__c'].id;
    	list<QC_Condition__c> quesCondList = new list<QC_Condition__c>();
    	for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Visible',onload__c=true);
    		quesCondList.add(qcondition);
    	}
    	for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Hidden',onload__c=true);
    		quesCondList.add(qcondition);
    	}
        for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Visible',onload__c=true);
    		quesCondList.add(qcondition);
    	}
    	for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Hidden',onload__c=true);
    		quesCondList.add(qcondition);
    	}
        for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Case',action__c='Visible',onload__c=true);
    		quesCondList.add(qcondition);
    	}
    	for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Case',action__c='Hidden',onload__c=true);
    		quesCondList.add(qcondition);
    	}
    	return quesCondList;
        
    }
    
    //Method for test Conditions
	public static  list<QC_Condition__c> getTestConditions() {
		id rtId = [select id from recordtype where developername='Test_Condition' and SobjectType='QC_Condition__c'].id;
    	list<QC_Condition__c> quesCondList = new list<QC_Condition__c>();
    	for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Visible',onload__c=true);
    		quesCondList.add(qcondition);
    	}
        for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Hidden',onload__c=true);
    		quesCondList.add(qcondition);
    	}
        for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Visible',onload__c=true);
    		quesCondList.add(qcondition);
    	}
        for(integer i=0;i<2;i++){
    		QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Hidden',onload__c=true);
    		quesCondList.add(qcondition);
    	}
    	return quesCondList;
    }
    
    //Method for test Picklist Condition
    public static  list<QC_Condition__c> getPicklistConditions() {
        id rtId = [select id from recordtype where developername='Picklist_Condition' and SobjectType='QC_Condition__c'].id;
        list<QC_Condition__c> quesCondList = new list<QC_Condition__c>();
        
        QC_Condition__c qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Visible',onload__c=true);
        quesCondList.add(qcondition);
        
        qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Full-Watch',action__c='Hidden',onload__c=true);
        quesCondList.add(qcondition);
        
        
        qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Visible',onload__c=true);
        quesCondList.add(qcondition);
        
        
        qcondition= new QC_Condition__c(recordtypeid = rtid,component_type__c='Module',action__c='Hidden',onload__c=true);
        quesCondList.add(qcondition);
        
        return quesCondList;
    }
     //Method for custom setting records
     public static list<QC_Component_Prefix__c> getCustomSetting(){
     	
	   	list<QC_Component_Prefix__c> custList = new list<QC_Component_Prefix__c>();
	   	custList.add(new QC_Component_Prefix__c(name = 'FW', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'WH', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'CA', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'LS', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'BT', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'PA', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'MS', sequence_Number__c = '1'));
	   	custList.add(new QC_Component_Prefix__c(name = 'FMA',sequence_Number__c = '1'));
	    custList.add(new QC_Component_Prefix__c(name = 'DL', sequence_Number__c = '1'));
	    
	    return custList;
   }
    
     
    public static list<QC_Input_Data__c> getParentInputParameters(){
    	list<QC_Input_Data__c> inputParamParentComp= new list<QC_Input_Data__c>();
    	inputParamParentComp.add(new QC_Input_Data__c());
    	return inputParamParentComp;
    }
    public static list<QC_Test_Data__c> getParentTestParameters(){
    	list<QC_Test_Data__c> testParamParentComp= new list<QC_Test_Data__c>();
    	testParamParentComp.add(new QC_Test_Data__c());
    	return testParamParentComp;
    }
    public static  list<QC_Components__c> getChildComponent() {
    	list<QC_Components__c> compChildList = new list<QC_Components__c>();
    	for(integer i=0;i<5;i++){
    		QC_Components__c qcchildComp = new QC_Components__c(Name__c = 'Case');
    		compChildList.add(qcchildComp);
    	}
    	return compChildList;
    }
     public static list<QC_Input_Data__c> getChildInputParameters(){
    	list<QC_Input_Data__c> inputParamChildComp= new list<QC_Input_Data__c>();
    	return inputParamChildComp;
    }
    public static list<QC_Test_Data__c> getChildTestParameters(){
    	list<QC_Test_Data__c> testParamChildComp= new list<QC_Test_Data__c>();
    	return testParamChildComp;
    }
}