@isTest
public class QC_Acc_Construction_pdfCtrlTest {
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
            qc.Category__c	='Belts';
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
            qc1.Category__c	='Belts';
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
            //qcComp.Id = 'a2CZ0000001vf6gMAA';
            insert qcComp;
            
            system.debug('----------qcComp-----------'+qcComp.Id);
            PageReference pageRef = Page.QC_Acc_DocumentStatus_Email_CommonPage;
            Test.setCurrentPageReference(pageRef);  
            ApexPages.currentPage().getParameters().put('compId',qcComp.id);
            QC_Acc_Construction_pdfCtrl obj = new QC_Acc_Construction_pdfCtrl();
           
            
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
            
            QC_Accessories_Component_Prefix__c qcPrefix = new QC_Accessories_Component_Prefix__c();
            qcPrefix.Name = 'BE';
            qcPrefix.Sequence_Number__c = '0031';
            insert qcPrefix;
            
            qc.Question_Type__c='Free Text'; 
            qc.Category__c	='Belts';
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
            qc1.Category__c	='Belts';
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
            //qcComp.Id = 'a2CZ0000001vf6gMAA';
            insert qcComp;
            
            system.debug('----------qcComp-----------'+qcComp.Id);
            PageReference pageRef = Page.QC_Acc_DocumentStatus_Email_CommonPage;
            Test.setCurrentPageReference(pageRef);  
            ApexPages.currentPage().getParameters().put('compId',qcComp.id);
            QC_Acc_Construction_pdfCtrl obj = new QC_Acc_Construction_pdfCtrl();
           
            obj.firstApprover = 'Admin';
            obj.secondApprover = 'Admin';
            test.stopTest();
            
            
        }
    }
}