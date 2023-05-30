/*      
@Name                  TestOppFeedbackReceivedNotification
@Author                Gauri
@Version               1.0
@CreatedDate           16/9/2022
@UsedBy                
@Description           To test the email notification to opportunity owner and team members when the feedback status is received
@Changes
UserId           | Author-Email                    | Date      | Comment
=================|====================================|===========|=========
|  |    |
*/
@isTest
public class TestOppFeedbackReceivedNotification {
    /* @Description Test setup mehtod to create test data
@return void
*/
    @TestSetup
    public static void testData()
    {
        List<User> UsersToBeCreated = new List<User>();//List to store the users (admin, team members(to be linked in MBA opportunity))
        
        //Create Admin user
        User AdminUser = TitanFeedbackTestUtility.createUser(TitanFeedbackTestUtility.generateRandomUserName(), 'System Administrator');
        UsersToBeCreated.add(AdminUser);
        
        //Create TeamMember user
        User teamMemberUser = TitanFeedbackTestUtility.createUser(TitanFeedbackTestUtility.generateRandomUserName(), 'Team member');
        UsersToBeCreated.add(teamMemberUser);
        
        //Create Team Leader user
        User teamLeadUser = TitanFeedbackTestUtility.createUser(TitanFeedbackTestUtility.generateRandomUserName(), 'Team Leader');
        UsersToBeCreated.add(teamLeadUser) ;
        
        if(!UsersToBeCreated.isEmpty())
        {
            insert UsersToBeCreated;
        }
        
        //Create Account record
        Account acc = TitanFeedbackTestUtility.createAccount('TestAccount', false);
        insert acc;
        
        //Create contact record
        Contact con = TitanFeedbackTestUtility.createContact('Test Con', acc.id, false);
        insert con;
        
        //Create opportunity record to be referred as parent opportunity in the MBA opportuntiy record
        Opportunity ParentOpp = new Opportunity();
        ParentOpp.RecordTypeId=Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Preliminary_Type').getRecordTypeId();
        ParentOpp.name='ParentTestOpp';
        ParentOpp.AccountId = acc.id;
        ParentOpp.Customer_Primary_Contact__c = con.id;
        ParentOpp.Mechanical_Lead__c = teamLeadUser.id;
        ParentOpp.Mechanical_2__c = teamMemberUser.id;
        ParentOpp.StageName='Preliminary Opportunity';
        ParentOpp.CloseDate = system.today();
        ParentOpp.StageName = 'Under-Study';
        ParentOpp.RFQ_Received_Date_Date__c = system.today();
        ParentOpp.RFQ_Due_Date__c = system.today();  
        ParentOpp.Amount=10000;
        insert ParentOpp;
        
        //Create MBA opportunity
        Opportunity opp = new Opportunity();
        opp.Parent_Opportunity__c=ParentOpp.id;
        opp.name = 'OppTest';
        opp.AccountId = acc.id;
        opp.Customer_Primary_Contact__c = con.id;
        opp.Mechanical_Lead__c = teamLeadUser.id;
        opp.Mechanical_2__c = teamMemberUser.id;
        opp=TitanFeedbackTestUtility.createOpportunity(opp, false);
        System.runAs(AdminUser){
            insert opp;
            opp.StageName ='Project Closed';
            update opp;
        }
        
        //Create Customer feedback record (record type = Closed Won Feedback)
        Customer_Feedback__c feedback=new Customer_Feedback__c();
        feedback.RecordTypeId = Schema.SObjectType.Customer_Feedback__c.getRecordTypeInfosByDeveloperName().get('Closed_Won_Feedback').getRecordTypeId();
        feedback.Name=con.Name;
        feedback.Phone__c=con.phone;
        feedback.Email__c=con.Email;
        feedback.FeedBack_Sent_Date__c=System.now();
        feedback.Feedback_Status__c='Sent';
        feedback.Designation__c=con.Designation__c;
        feedback.Organization__c=acc.Name;
        feedback.Contact_Name__c=con.id;
        feedback.Opportunity__c=opp.id;
        insert feedback;
    }
    
    /* @Description Method to test the send email notification to opportunity owner and team members
@return void
*/
    @isTest
    public static void sendFeebackReceivedNotificationTest()
    {
       
        
        Opportunity opp = [select id from opportunity where name='OppTest'];
        
        
        Customer_Feedback__c feedback = [select id,Feedback_Status__c from Customer_Feedback__c where Opportunity__c=:opp.id];
        Test.startTest();
        feedback.Feedback_Status__c = 'Received';
        update feedback;
        //System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
        List<OpportunityFeedbackReceivedNotification.EmailPayload> emplList = new List<OpportunityFeedbackReceivedNotification.EmailPayload>();
        OpportunityFeedbackReceivedNotification.EmailPayload eml = new OpportunityFeedbackReceivedNotification.EmailPayload();
        eml.emailSubject = 'Feedback';
        eml.emailBody = 'Test Titan Feedback';
        eml.emailList = 'test@titan.com';
        emplList.add(eml);
        
        //Test the apex class methods using test data 
        Recursivecheck.runOnce();
        OpportunityFeedbackReceivedNotification.sendFeebackReceivedNotification(emplList);
        OpportunityFeedbackReceivedNotification.getToEmails(new List<String>{'test@titan.com'});
        
        Test.stopTest();
    }
}