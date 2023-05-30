@isTest

public class QC_Acc_QuestionDataTest {
    public static testMethod void testMethod1(){
       test.startTest();
      	
        list<QC_Access_Questions__c> qcTestList = new list<QC_Access_Questions__c>();
        Id recordTypeId = [Select Id from RecordType where Name= 'Input Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
        Id recordTypeIdTest = [Select Id from RecordType where Name= 'Test Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
        Id recordTypeResponseTest = [Select Id from RecordType where Name= 'Test Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
        Id recordTypeResponseInput = [Select Id from RecordType where Name= 'Input Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
        QC_Access_Questions__c qc= new QC_Access_Questions__c();
        qc.Question_Type__c='Free Text'; 
        qc.Category__c	='Belts';
        qc.Questions__c='Test1';
        qc.RecordTypeId = recordTypeId;
        qc.onLoad__c = True;
        qc.Testing_Type__c = 'Common';
        insert qc;
        
        
        String category =qc.Category__c;
        
        QC_Access_QuesOption__c quesOptions = new QC_Access_QuesOption__c();
        quesOptions.QC_Questions__c = qc.Id;
        quesOptions.Option_Value__c = 'leather';
        insert quesOptions;
        
        QC_Acc_QuestionData.fetchQuestions(category);
        
        QC_Access_Questions__c qc1= new QC_Access_Questions__c();
        qc1.Product_Specification__c='Free Text'; 
        qc1.Category__c	='Belts';
        qc1.Test_Name__c='testing thickness';
        qc1.RecordTypeId = recordTypeIdTest;
        qc1.Testing_Type__c = 'Construction Testing';
        qc1.Acceptance_Criteria__c = 'test accept'; 
        insert qc1;
        
        QC_Acc_QuestionData.testParamWrapper(qc1.Category__c);
        
        QC_Access_Component__c qcComp = new QC_Access_Component__c();
        insert qcComp;
        
        
        QC_Access_QuesResponse__c responseQc = new QC_Access_QuesResponse__c();
        responseQc.QC_Access_Component__c = qcComp.Id;
        responseQc.Observation__c = 'test';
        responseQc.QC_Access_Questions__c = qc.Id ; //'a28Z0000001HjiFIAS'
        responseQc.Verdict__c = 'Accept';
        responseQc.RecordTypeId = recordTypeResponseTest;
        //insert responseQc;
        
        
       
        String operation = 'insert';
        
        String json = '[{"sobjectType":"QC_Access_QuesResponse__c","QC_Access_Component__c":"'+qcComp.Id+'","Observation__c":"test","QC_Access_Questions__c":"'+qc.Id+'","Verdict__c":"Accept","RecordTypeId":"'+recordTypeResponseInput+'"}]';
        QC_Acc_QuestionData.saveAccInpRespData(json, operation);
        
        sObject referenceNoObj = qcComp;
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        QC_Access_QuesResponse__c responseQc1 = new QC_Access_QuesResponse__c();
        responseQc1.QC_Access_Component__c = qcComp.Id;
        responseQc1.QC_Access_Questions__c = qc.Id;
        responseQc1.Response_Values__c = 'Test';
        responseQc1.Multiple_QuesResponseId__c = 'a28Z0000001HjiF123';
        responseQc1.RecordTypeId = recordTypeResponseInput;
        insert responseQc1;
        QC_Acc_QuestionData.viewInpforReSubmission(qcComp);
        
        
        
        
        
        QC_Access_Questions__c qc2= new QC_Access_Questions__c();
        qc2.Product_Specification__c='Free Text'; 
        qc2.Test_Name__c='testing thickness';
        qc2.RecordTypeId = recordTypeIdTest;
        qc2.Acceptance_Criteria__c = 'test accept';
        qc2.Temp_Observation__c = 'test';
        qc2.Temp_Verdict__c = 'Accept';
        qcTestList.add(qc2);
        QC_Acc_QuestionData.saveAddTestParam(qcTestList);
        
        QC_Access_QuesResponse__c responseQc2 = new QC_Access_QuesResponse__c();
        responseQc2.QC_Access_Component__c = qcComp.Id;
        responseQc2.QC_Access_Questions__c = qc2.Id;
        responseQc2.Response_Values__c = 'Test';
        responseQc2.RecordTypeId = recordTypeResponseTest;
        responseQc2.Observation__c = 'Test';
        responseQc2.Verdict__c = 'Accept';
        insert responseQc2;
        QC_Acc_QuestionData.viewTestParamReSubmission(qcComp);
        //insert qc1;
        
        
      test.stopTest();
        
        
    } 
}