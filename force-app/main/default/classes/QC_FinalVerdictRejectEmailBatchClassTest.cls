@isTest
public class QC_FinalVerdictRejectEmailBatchClassTest {
       @testSetup static void methodName() {
     TriggerExecutionController__c tt1 = new TriggerExecutionController__c();
        tt1.Name = 'Qc_Component_Lightning_Trigger';
        tt1.TriggerIsActive__c = false;
        insert tt1;
        
}
    @isTest public static void testemail(){
         Test.StartTest();
        //TriggerExecutionController__c value = TriggerExecutionController__c.getInstance('Qc_Component_Lightning_Trigger');
//value.TriggerIsActive__c = false;
//update value;
//update tempList;
//value.TriggerIsActive__c = true;
//update value;
        
        QC_Components__c comp = new QC_Components__c();
        comp.Name__c = 'Case1';
        comp.Report_Ref_Number__c = 'FW/0282/19-2';
        comp.Final_Verdict__c = 'Reject';
        comp.Published_Date__c = Date.newInstance(2022, 7, 26);
        comp.Document_Status__c = 'Published';
        comp.Component_Status__c = 'Active';
        comp.Sample_Received_From__c = 'vinoth.kumar@kvpcorp.com';
        comp.Model__c = '8686SS';
        comp.Sample_Department__c = 'Brand Team';
        comp.No_Of_Sample_Received__c = 1;
        comp.ChildComponentName__c = 'Dial';
        comp.Sample_Date__c = Date.newInstance(2022, 6, 26);
        insert comp;
        
        
        QC_FinalVerdictRejectEmailBatchClass bc = new QC_FinalVerdictRejectEmailBatchClass();
        database.executebatch(bc);
        
        QC_FinalVerdictRejectEmailSchedulerClass sch = new QC_FinalVerdictRejectEmailSchedulerClass();
        String CT = '0 0 7 * * ?';
        system.schedule('Product re-order email daily by 7PM', CT, sch);
        Test.stopTest();
    }
}