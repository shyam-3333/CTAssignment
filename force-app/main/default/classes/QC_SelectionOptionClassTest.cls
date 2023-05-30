@isTest
public class QC_SelectionOptionClassTest {
    @isTest static void fetchQcAccessCompDataTest(){
        List<QC_Access_Component__c> acList= new List<QC_Access_Component__c>();
        
        QC_Access_Component__c qc = new QC_Access_Component__c();
        
        qc.Sample_Type__c='';
        qc.isConstructionTesting__c=true;
        acList=[SELECT ID,Name,Document_Status__c,Record_Status__c, No_Of_Sample_Received__c,Construction_Refer_Number__r.Report_Ref_Number__c,Report_Ref_Number__c,Sample_Category__c,Sample_Received_Date__c,Sample_Received_From__c,
                Sample_Type__c,SKU_Reference__c,Sub_Category__c,isConstructionTesting__c,isReliabilityTesting__c,Vendor__c,Vendor__r.Name,Brand__c,Brand__r.Name,General_Observation__c FROM QC_Access_Component__c WHERE ID = :qc.ID];
        
        QC_SelectionOptionClass.fetchQcAccessCompData(qc.Report_Ref_Number__c);
        QC_SelectionOptionClass.getDependentOptionsImpl('QC_Access_Component__c','Record_Status__c','Record_Status__c');
        
        
        
        QC_Access_Component__c qc1 = new QC_Access_Component__c();
        // qc1.Name='Test';
        qc1.Sample_Type__c='';
        qc1.isConstructionTesting__c=true;
        //Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        //Passing record id 
        // req.setObjectId(qc1.id);        
        //Approval.ProcessResult result = Approval.process(req);
        // string approvalResult = result.getInstanceStatus();
        QC_SelectionOptionClass.fetchDocumentStatus(qc.id);
        //insert qc;
        QC_SelectionOptionClass.fetchDocStatusForConstr(qc.Id);
        
        insert qc;
        QC_SelectionOptionClass.submitForAppProcess(qc.id);
        QC_SelectionOptionClass.fetchConstrRefData(qc.Id);
        QC_SelectionOptionClass.savemasterReferedValue(qc.Id,true);
        QC_SelectionOptionClass.fetchMasterValue(qc.Id);
    }
    
}