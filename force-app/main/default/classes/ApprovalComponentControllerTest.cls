@isTest
public class ApprovalComponentControllerTest {
    public static testMethod void testMethod1(){
        
        User testuser = [select name, Id  FROM user LIMIT 1];
        system.runAs(testuser){
            Test.StartTest();  
            
            QC_Access_Component__c obj1 = new QC_Access_Component__c();
            insert obj1;
            
            Approval.ProcessSubmitRequest [] requestList = new Approval.ProcessSubmitRequest []{};
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setObjectId(obj1.Id);
            Approval.ProcessResult result = Approval.process(req1);
            
            ApprovalComponentController.getApprovalData(obj1.Id);
            ApprovalComponentController.getProcessHistory(obj1.Id); 
            test.StopTest();
        }
        
    }
}