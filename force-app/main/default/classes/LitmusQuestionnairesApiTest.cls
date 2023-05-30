@isTest
public class LitmusQuestionnairesApiTest {
    @testSetup
    Static void testDataPreparemethod()
    {
        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        Account acc = new Account();
        acc.RecordTypeId = accountRecordTypeId;
        acc.Name = 'Test Litmus Acc1';
        acc.Date_of_establishment_of_company__c = system.today();
        acc.Region_Picklist__c = 'North' ;
        acc.Type = 'Customer';
        acc.GSTN_Number__c = 'AWLPH1234567890' ;
        acc.Last_Billed_Month__c = system.today();
        acc.Customer_Category__c = 'Active ( Billed in 2020 )' ;
        acc.Channel__c = 'Education and training';
        acc.CustomerSegment__c = 'Education, Training';
        acc.Customer_Subsegment__c = 'New';
        acc.Pan_No__c = '09876';
        acc.BillingState = 'Karnataka';
        acc.CST_No__c = '123';
        acc.TIN_No__c = '123';
        Insert acc;
        
        Contact cont = new Contact();
        cont.FirstName = 'Mutturaj';
        cont.LastName = 'Heroor';
        cont.Email = 'hulakanteppa.h@kvpcorp.com';
        cont.MobilePhone = '8762921827';
        cont.AccountId = acc.Id;
        insert cont ;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Litmus Testing Opp';
        opp.StageName = 'Requirement Analysis' ;
        opp.Amount = 1000;
        opp.RecordTypeId = oppRecordTypeId;
        opp.Type = 'New Opportunity';
        opp.Region_Picklist__c = 'North';
        opp.CloseDate = system.today();
        opp.Opportunity_Type__c = 'Dealer Incentive' ;
        opp.RFQ_Reference1__c = 'test';
        opp.RFQ_Received_Date_Date__c = system.today() ;
        opp.LeadSource = 'Campaign';
        opp.Livelihood_Date_of_billing__c = system.today();
        insert opp;
        
        opp.StageName = 'RFQ_Study';
        update opp;
        
        Feedback__c fb = new Feedback__c();
        fb.Contact_name__c = cont.Name ;
        fb.Opportunity_Id__c = opp.Id;
        insert fb;
    }
 @isTest
    static void doPostPossitive() {
        LitmusQuestionnairesApi.ResponseWrapClass respo = new LitmusQuestionnairesApi.ResponseWrapClass();
        
        List<LitmusQuestionnairesApi.ratings> ratingRespoList= new List<LitmusQuestionnairesApi.ratings>();
        LitmusQuestionnairesApi.ratings  ratingRespo = new LitmusQuestionnairesApi.ratings();
        ratingRespo.question = 'How was your overall Exp';
        ratingRespo.rating = 'Excellent';
        ratingRespo.actual_rating = '9';
        ratingRespoList.add(ratingRespo);
        respo.tag_Opportunity_id = [Select Id From Opportunity where Name = 'Litmus Testing Opp' Limit 1].Id ;
        respo.ratings = ratingRespoList;
        respo.primary_rating = '25';
        respo.comment = 'Test comment';
        respo.note = 'Test Note';
        respo.project_name = 'Test Project' ;
        respo.responded_date = Datetime.newInstance(2020, 04, 1, 12, 0, 0);
        respo.request_date = Datetime.newInstance(2020, 04, 1, 13, 0, 0);
        respo.current_issue_status = 'In-Progress';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/QuestionnairesApi'; 
        req.httpMethod = 'POST';
        String myJSON = JSON.serialize(respo);
        req.requestBody = Blob.valueof(myJSON);
        RestContext.request = req;
        RestContext.response = res;
        test.startTest();
        LitmusQuestionnairesApi.doPost();
        test.stopTest();
        
        
    } 
    
}