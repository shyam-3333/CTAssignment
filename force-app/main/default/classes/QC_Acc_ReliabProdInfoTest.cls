@isTest
public class QC_Acc_ReliabProdInfoTest {	
    static testMethod void myUnitTest() {
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'WLC';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
        QC_Access_Component__c obj1 = new QC_Access_Component__c();
        obj1.Report_Ref_Number__c = 'WLC/0021/19-20';
        insert obj1;
        
        QC_Access_Component__c obj2 = new QC_Access_Component__c();
        obj2.isConstructionTesting__c=true;
        obj2.Sample_Type__c='New';
        obj2.Sample_Category__c ='Wallets';
        obj2.Master__c = false;
       
        sObject referenceNoObj = obj1;
        QC_Acc_ReliabProdInfo.fetchConstructionData(obj1);
        QC_Acc_ReliabProdInfo.updateComponent(obj1.id,obj1);
        
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        QC_Acc_ReliabProdInfo.saveAndDisplayDetails(obj2,qcObj);
    }
    
    public static testMethod void testMethod2(){
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'WLC';
        custSettObj.Sequence_Number__c = '0022';
        insert custSettObj;
        
        QC_Access_Component__c obj1 = new QC_Access_Component__c();
        obj1.Report_Ref_Number__c = 'WL/0022/19-20[R1]';
        obj1.isReliabilityTesting__c=true;
        obj1.Sample_Type__c='New';
        obj1.Sample_Category__c ='Wallets';
        obj1.Master__c = false;
        insert obj1;
        
        
        QC_Access_Component__c obj2 = new QC_Access_Component__c();
        obj2.isReliabilityTesting__c =true;
        obj2.Sample_Type__c='New';
        obj2.Sample_Category__c ='Wallets';
        obj2.Master__c = false;
       
        sObject referenceNoObj = obj1;
        QC_Access_Component__c qcObj = (QC_Access_Component__c)referenceNoObj;
        QC_Acc_ReliabProdInfo.saveAndDisplayDetails(obj2,qcObj);
        
        
    }
    
}