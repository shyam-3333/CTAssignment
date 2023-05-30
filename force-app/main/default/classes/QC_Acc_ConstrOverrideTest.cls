@isTest
public class QC_Acc_ConstrOverrideTest {
    
    
    @isTest static void fetchConstructionDataTest(){
        
        List<QC_Access_Component__c> qcList= new List<QC_Access_Component__c>();
        String refNo;
        String yr = String.valueOf(System.today().year());
        yr= yr.substring(2,4);
        Integer value=Integer.valueOf(yr);
        
        QC_Access_Component__c qc = new QC_Access_Component__c();
        qc.Sample_Type__c='';
        qc.isConstructionTesting__c=true;
        Map<String, Schema.SObjectType> global_describe = Schema.getGlobalDescribe();
		// Map<String, Schema.SObjectField> object_fields_map = global_describe.get('QC_Access_Component__c').getDescribe().;
        qcList.add(qc);
        insert qcList;
        QC_Acc_ConstrOverride.fetchConstructionData(qc);

        QC_Accessories_Component_Prefix__c custSettObj= QC_Accessories_Component_Prefix__c.getValues(refNo);
        QC_Acc_ConstrOverride.saveAndDisplayDetails(qc);
        QC_Acc_ConstrOverride.updateComponent(qc.Id,qc);
        
        QC_Access_Component__c qc1 = new QC_Access_Component__c();
        qc1.Sample_Type__c = 'New';
        qc1.isConstructionTesting__c = true;
        
        
        QC_Acc_ConstrOverride.saveAndUpdateRecord(qc1,qc);
        
    }
}