@isTest
public class CustomLookUpControllerAccTest {
	@isTest
    public static void fetchLookUpValuesTest(){
        test.startTest();
        QC_Access_Master__c obj = new QC_Access_Master__c();
        obj.Name='Titan';
        obj.RecordTypeId =Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Brand Details').getRecordTypeId();
        obj.RecordTypeId =Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Vendor Details').getRecordTypeId();
       // obj.Titan_Specification_Reference__c='T8017BR';
        insert obj;
        QC_Access_Master__c objVendor = new QC_Access_Master__c();
        objVendor.Name='Test Vendor';
        objVendor.RecordTypeId =Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName().get('Vendor Details').getRecordTypeId();
       // obj.Titan_Specification_Reference__c='T8017BR';
        insert objVendor;
        //obj.RecordTypeId = Schema.SObjectType.QC_Access_Master__c.getRecordTypeInfosByName('Specification_Details').getRecordTypeId();
        QC_Access_Component__c qcComp=new QC_Access_Component__c();
        //qcComp.Name='Test';
        qcComp.Sample_Category__c ='Bags';
        qcComp.Document_Status__c ='Draft';
        qcComp.Final_Verdict__c='Accept';
        qcComp.No_Of_Sample_Received__c =3;
        qcComp.isConstructionTesting__c=true;
        qcComp.Vendor__c=objVendor.Id;
        qcComp.General_Observation__c ='Test';
        //insert qcComp;
        
        
        
        String searchKeyWord='QCC';
        String ObjectName= 'QC_Access_Component__c'; 
        String whereCondition='Sample_Category__c = \'' +qcComp.Sample_Category__c+'\'';
        QC_Access_Component__c q=new QC_Access_Component__c();
        //q.Report_Ref_Number__c='123';
        
       // insert q;
        
       
        customLookUpControllerAcc.fetchLookUpValues(searchKeyWord,ObjectName,whereCondition);
       
        test.stopTest();
        
        
      //  QC_Access_Questions__c q1=new QC_Access_Questions__c();
        
       // q=null;
        //customLookUpController.fetchQuestions();
    }

}