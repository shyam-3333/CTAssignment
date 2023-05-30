@isTest
public class reliabilityNewDataTest {
    
    @isTest public static void updateComponentTest(){
        List<QC_Access_Component__c> qc= new List<QC_Access_Component__c>();
        QC_Access_Component__c q = new QC_Access_Component__c();
        insert q;
        qc.add(q);
        ReliabilityNewData.updateComponent(string.valueOf(q.id),q);
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'WL';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
                
        QC_Access_Component__c Q1= new QC_Access_Component__c();
        String refNo = 'WL';
        Q1.Sample_Type__c='New';
        Q1.Sample_Category__c ='Wallets';
        Q1.isReliabilityTesting__c = true;
        custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
        Q1.Final_Verdict__c = 'Reject';
        
        
        ReliabilityNewData.saveNewReliabilityData(Q1);
        Q1.Document_Status__c = 'Published';
      
        String refrenceNo = Q1.Id;
        ReliabilityNewData.fetchReSubmissionData(refrenceNo);
        
                
        
        
        
        
    }    
    public static testMethod void testMethod2(){
       test.startTest();
        
        QC_Accessories_Component_Prefix__c custSettObj1 = new QC_Accessories_Component_Prefix__c();
        custSettObj1.Name = 'CBA';
        custSettObj1.Sequence_Number__c = '0002';
        insert custSettObj1;

        QC_Access_Component__c Q2= new QC_Access_Component__c();
        String refNo1 = 'CBA';
        
        
        Q2.isReliabilityTesting__c=true;
        Q2.Sample_Type__c='Competitor Products';
        Q2.Sample_Category__c ='Bags';
        custSettObj1= QC_Accessories_Component_Prefix__c.getValues(refNo1);

        ReliabilityNewData.saveNewReliabilityData(Q2);
        
        
        QC_Access_Component__c Q3= new QC_Access_Component__c();
        sObject referenceNoObj = Q3;
        Q3.isConstructionTesting__c=true;
        Q3.Sample_Type__c='Re-Submission';
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        Q3.Sample_Category__c ='Wallets';
        Q2.Record_Status__c = 'Obsolete';
        //update Q1;
        ReliabilityNewData.saveReliabReSubData(Q3.Sample_Type__c,qcObj,Q3);  

       test.stopTest();
        
        
        
        
        
    }
    

}