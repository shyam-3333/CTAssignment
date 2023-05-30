/*
* Class Name   : TestOpportunityToFeedback
* Created By   : Madhushree H J
* Created Date : 19-08-2022
* Description  :this class is used to check the test coverage of OpportunityToFeedback class .
*/
@isTest
public class TestOpportunityToFeedback {
    @isTest
    public static void testDemo()
    {
       Recursivecheck.runOnce();
        
        Account acct = new Account();
        acct.Name = 'test';
        insert acct;
        
        Contact cc=new Contact();
        cc.FirstName='test';
        cc.LastName='class';
        cc.MobilePhone='1234567898';
        cc.Email='test@gmail.com';
        cc.Designation__c='test';
        cc.AccountId=acct.Id;
        insert cc;
         Contact con=new Contact();
        con.FirstName='test1';
        con.LastName='class';
        con.MobilePhone='1234567893';
        con.Email='madhushreehj@gmail.com';
        con.Designation__c='test';
        con.AccountId=acct.Id;
        insert con;
         Contact con1=new Contact();
        con1.FirstName='test2';
        con1.LastName='class';
        con1.MobilePhone='1234567893';
        con1.Email='madhushre@gmail.com';
        con1.Designation__c='test';
        con1.AccountId=acct.Id;
        insert con1;
        Contact con2=new Contact();
        con2.FirstName='test3';
        con2.LastName='kvp';
        con2.MobilePhone='1234567876';
        con2.Email='madhushreehj@gmail.com';
        con2.Designation__c='test';
        con2.AccountId=acct.Id;
        insert con2;
        Contact con3=new Contact();
        con3.FirstName='test4';
        con3.LastName='kvp';
        con3.MobilePhone='1234567876';
        con3.Email='madhushree.hj@gmail.com';
        con3.Designation__c='test';
        con3.AccountId=acct.Id;
        insert con3;
        Opportunity opp = new Opportunity();
        opp.Name = 'test';
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('MBA').getRecordTypeId();
       
        opp.AccountId = acct.ID;
        opp.CloseDate = system.today();
        opp.StageName = 'Under-Study';
        opp.RFQ_Received_Date_Date__c = system.today();
        opp.RFQ_Due_Date__c = system.today();  
        opp.Customer_Primary_Contact__c=cc.Id;
      
        opp.Amount=10000;
        opp.Type='Tools & Fixer';
        insert opp;
         
        opp.StageName ='Project Under Execution';
        Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = false;
        update opp;
       // Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = false;
        opp.Technical_Influencer__c=con.Id;
        update opp;
      //   Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = false;
        opp.Technical_Decision_Maker__c=con3.Id;
        update opp;
       //  Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = false;
        opp.Commercial_Decision_Maker__c=con1.Id;
        update opp;
        //Recursivecheck.isOpportunityToFeedbackAfterUpdateRecursive = false;
        opp.Commercial_Influencer__c=con2.id;
        update opp;
        
        Customer_Feedback__c feedback=new Customer_Feedback__c();
        
        
        feedback.Name=cc.Name;
        feedback.Phone__c=cc.phone;
        feedback.Email__c=cc.Email;
        feedback.FeedBack_Sent_Date__c=System.now();
        feedback.Feedback_Status__c='Sent';
        feedback.Designation__c=cc.Designation__c;
        feedback.Organization__c=acct.Name;
        
        insert feedback;
         Customer_Feedback__c feedback1=new Customer_Feedback__c();
        feedback1.Name=con.Name;
        feedback1.Phone__c=con.phone;
        feedback1.Email__c=con.Email;
        feedback1.FeedBack_Sent_Date__c=System.now();
        feedback1.Feedback_Status__c='Sent';
        feedback1.Designation__c=con.Designation__c;
        feedback1.Organization__c=acct.Name;
        
        insert feedback1;
        
       
    }
    
    
    
}