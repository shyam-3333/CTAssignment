@isTest
public class SelectComponentClassTest {
    
    @isTest public static void updateComponentTest(){
        List<QC_Access_Component__c> qc= new List<QC_Access_Component__c>();
        QC_Access_Component__c q = new QC_Access_Component__c();
        //String s='a2CZ0000001vcLd';
        insert q;
        qc.add(q);
        selectComponentClass.updateComponent(string.valueOf(q.id),q);
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'WLC';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
                
        QC_Access_Component__c Q1= new QC_Access_Component__c();
        String refNo = 'WLC';
        
        String yr = String.valueOf(System.today().year());
        yr = yr.substring(2,4);
        Integer value = Integer.valueOf(yr);
        Q1.isConstructionTesting__c=true;
        Q1.Sample_Type__c='New';
        Q1.Sample_Category__c ='Wallets';
        custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
        
       // Q1.Report_Ref_Number__c = 'a2CZ0000001vf26';
        Q1.Final_Verdict__c = 'Reject';
        
        //insert Q1;
        selectComponentClass.saveAndFetchDetails(Q1);
        Q1.Document_Status__c = 'Published';
      
        String refrenceNo = Q1.Id;
        selectComponentClass.fetchReSubmissionData(refrenceNo);
        
                
        
        
        
        
    }    
    public static testMethod void testMethod2(){
       test.startTest();
        
        QC_Accessories_Component_Prefix__c custSettObj1 = new QC_Accessories_Component_Prefix__c();
        custSettObj1.Name = 'CBAC';
        custSettObj1.Sequence_Number__c = '0002';
        insert custSettObj1;

        QC_Access_Component__c Q2= new QC_Access_Component__c();
        String refNo1 = 'CBAC';
        String yr1 = String.valueOf(System.today().year());
        yr1= yr1.substring(2,4);
        Integer value1 = Integer.valueOf(yr1);
        //Integer value1 = Integer.valueOf(yr1);
        
        //Q2.isConstructionTesting__c=true;
        Q2.Sample_Type__c='Competitor Products';
        Q2.Sample_Category__c ='Bags';
        custSettObj1= QC_Accessories_Component_Prefix__c.getValues(refNo1);

        selectComponentClass.saveAndFetchDetails(Q2);
        
        
        QC_Access_Component__c Q3= new QC_Access_Component__c();
       // Q2.Id = Q1.Id;
        sObject referenceNoObj = Q3;
        Q3.isConstructionTesting__c=true;
        Q3.Sample_Type__c='Re-Submission';
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
       // Q3.Report_Ref_Number__c = 'a2CZ0000001vf26';
        Q3.Sample_Category__c ='Wallets';
        Q2.Record_Status__c = 'Obsolete';
        //update Q1;
        selectComponentClass.saveReSubmissionData(Q3.Sample_Type__c,qcObj,Q3);  

       test.stopTest();
        
        // insert q1;
        
        
        
    }
    
}