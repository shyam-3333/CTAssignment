@isTest
public class QcAcc_DocStatus_Email_CommonCtrlTest {
    public static testMethod void testMethod1(){
        User testuser = [select name, Id  FROM user LIMIT 1];
        system.runAs(testuser)
        {
            test.startTest(); 
            Id recordTypeId = [Select Id from RecordType where Name= 'Input Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
            Id recordTypeIdTest = [Select Id from RecordType where Name= 'Test Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
            Id recordTypeResponseTest = [Select Id from RecordType where Name= 'Test Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
            Id recordTypeResponseInput = [Select Id from RecordType where Name= 'Input Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
            QC_Access_Questions__c qc= new QC_Access_Questions__c();
            
            QC_Accessories_Component_Prefix__c qcPrefix = new QC_Accessories_Component_Prefix__c();
            qcPrefix.Name = 'BEC';
            qcPrefix.Sequence_Number__c = '0031';
            insert qcPrefix;
            
            qc.Question_Type__c='Free Text'; 
            qc.Category__c  ='Belts';
            qc.Questions__c='Test1';
            qc.RecordTypeId = recordTypeId;
            qc.onLoad__c = True;
            qc.Testing_Type__c = 'Common';
            insert qc;
            
            
           // String category =qc.Category__c;
            
            QC_Access_QuesOption__c quesOptions = new QC_Access_QuesOption__c();
            quesOptions.QC_Questions__c = qc.Id;
            quesOptions.Option_Value__c = 'leather';
            insert quesOptions;
            
           // QC_Acc_QuestionData.fetchQuestions(category);
            
            QC_Access_Questions__c qc1= new QC_Access_Questions__c();
            qc1.Product_Specification__c='Free Text'; 
            qc1.Category__c ='Belts';
            qc1.Test_Name__c='testing thickness';
            qc1.RecordTypeId = recordTypeIdTest;
            qc1.Testing_Type__c = 'Construction Testing';
            qc1.Acceptance_Criteria__c = 'test accept'; 
            insert qc1;
            
           
            
            QC_Access_Component__c qcComp = new QC_Access_Component__c();
            qcComp.General_Observation__c= 'test';
            qcComp.Sub_Category__c='Single Sided';
            qcComp.isConstructionTesting__c=true;
            qcComp.Sample_Category__c ='Belts';
            qcComp.Sample_Type__c='New';
            qcComp.Report_Ref_Number__c='BEC/0031/19-20';
            qcComp.Document_Status__c = 'Draft';
            //qcComp.Id = 'a2CZ0000001vf6gMAA';
            insert qcComp;
            
            system.debug('----------qcComp-----------'+qcComp.Id);
           // PageReference pageRef = Page.QC_Acc_DocumentStatus_Email_CommonPage;
           // Test.setCurrentPageReference(pageRef);  
           // ApexPages.currentPage().getParameters().put('compId',qcComp.id);
            QcAcc_DocumentStatus_Email_CommonCtrl obj = new QcAcc_DocumentStatus_Email_CommonCtrl();
            obj.compId = qcComp.Id;
            obj.getqcAccCompObj();
            obj.switchTestingName = 'Construction Testing';
            test.stopTest();
            
            
        }
    }
    public static testMethod void testMethod2(){
        
        User testuser = [select name, Id  FROM user LIMIT 1];
        system.runAs(testuser)
        {
            test.startTest(); 
            Id recordTypeId = [Select Id from RecordType where Name= 'Input Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
            Id recordTypeIdTest = [Select Id from RecordType where Name= 'Test Questions' and SObjectType = 'QC_Access_Questions__c' limit 1].Id;
            Id recordTypeResponseTest = [Select Id from RecordType where Name= 'Test Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
            Id recordTypeResponseInput = [Select Id from RecordType where Name= 'Input Type' and SObjectType = 'QC_Access_QuesResponse__c' limit 1].Id;
            QC_Access_Questions__c qc= new QC_Access_Questions__c();
            list<QC_Access_Questions__c> qcTestList = new list<QC_Access_Questions__c>();
            
            QC_Accessories_Component_Prefix__c qcPrefix = new QC_Accessories_Component_Prefix__c();
            qcPrefix.Name = 'BE';
            qcPrefix.Sequence_Number__c = '0031';
            insert qcPrefix;
            
            qc.Question_Type__c='Free Text'; 
            qc.Category__c  ='Belts';
            qc.Questions__c='Test1';
            qc.RecordTypeId = recordTypeId;
            qc.onLoad__c = True;
            qc.Testing_Type__c = 'Common';
            insert qc;
            
            
           // String category =qc.Category__c;
            
            QC_Access_QuesOption__c quesOptions = new QC_Access_QuesOption__c();
            quesOptions.QC_Questions__c = qc.Id;
            quesOptions.Option_Value__c = 'leather';
            insert quesOptions;
            
           // QC_Acc_QuestionData.fetchQuestions(category);
            
            QC_Access_Questions__c qc1= new QC_Access_Questions__c();
            qc1.Product_Specification__c='Free Text'; 
            qc1.Category__c ='Belts';
            qc1.Test_Name__c='testing thickness';
            qc1.RecordTypeId = recordTypeIdTest;
            qc1.Testing_Type__c = 'Reliability Testing';
            qc1.Acceptance_Criteria__c = 'test accept'; 
            insert qc1;
            
           
            
            QC_Access_Component__c qcComp = new QC_Access_Component__c();
            qcComp.General_Observation__c= 'test';
            qcComp.Sub_Category__c='Single Sided';
            qcComp.isReliabilityTesting__c =true;
            qcComp.Sample_Category__c ='Belts';
            qcComp.Sample_Type__c='New';
            qcComp.Report_Ref_Number__c='BE/0031/19-20';
            qcComp.Document_Status__c = 'Draft';
            //qcComp.Id = 'a2CZ0000001vf6gMAA';
            insert qcComp;
            
            sObject referenceNoObj = qcComp;
            QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
            QC_Access_QuesResponse__c responseQc1 = new QC_Access_QuesResponse__c();
            responseQc1.QC_Access_Component__c = qcObj.Id;
            responseQc1.QC_Access_Questions__c = qc.Id;
            responseQc1.Response_Values__c = 'Test';
            responseQc1.Multiple_QuesResponseId__c = 'a28Z0000001HjiF123';
            responseQc1.RecordTypeId = recordTypeResponseInput;
            insert responseQc1;
            
            QC_Access_Questions__c qc2= new QC_Access_Questions__c();
            qc2.Product_Specification__c='Free Text'; 
            qc2.Test_Name__c='testing thickness';
            qc2.RecordTypeId = recordTypeIdTest;
            qc2.Acceptance_Criteria__c = 'test accept';
            qc2.Temp_Observation__c = 'test';
            qc2.Temp_Verdict__c = 'Accept';
            qcTestList.add(qc2);
            
            QC_Access_QuesResponse__c responseQc2 = new QC_Access_QuesResponse__c();
            responseQc2.QC_Access_Component__c = qcComp.Id;
            responseQc2.QC_Access_Questions__c = qc2.Id;
            responseQc2.Response_Values__c = 'Test';
            responseQc2.RecordTypeId = recordTypeResponseTest;
            responseQc2.Observation__c = 'Test';
            responseQc2.Verdict__c = 'Accept';
            insert responseQc2;
            
            system.debug('----------qcComp-----------'+qcComp.Id);
            QcAcc_DocumentStatus_Email_CommonCtrl obj = new QcAcc_DocumentStatus_Email_CommonCtrl();
            obj.compId = qcComp.Id;
            obj.getqcAccCompObj();
           
            obj.firstApprover = 'Admin';
            obj.secondApprover = 'Admin';
            obj.switchTestingName = 'Reliability Testing';
            test.stopTest();
            
            
        }
    }
}