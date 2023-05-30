/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			12/03/2019   T01   0% code for ProdAsyncExecution
*/
@isTest(SeeAllData=true)
public class QuoteUpdateBatchClassTest {
    @isTest 
    public static void QuoteUpdateBatchMethod(){
        User u = new User();
        // u = [select Id from User  limit 1];
        u.firstName = 'vinoth';
        u.LastName = 'kumar';
        u.Alias = 'vino';
        u.Email = 'vinoth.kumar@kvpcorp.com';
        u.Username = 'vinoth.kumar@abc.com';
        u.CommunityNickname = 'vin';
        u.UserRole =[select id, name from UserRole where name like '%Mechanical%' limit 1];
        system.debug('user role:'+u.UserRole.name);
        u.ProfileId = [select id from Profile limit 1].id;
        u.EmailEncodingKey = 'UTF-8';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.LocaleSidKey = 'en_US';
        u.LanguageLocaleKey = 'en_US';
        u.CurrencyIsoCode = 'INR';
        insert u;
        
        Account acc = new Account();
        acc.name = 'Test Acc';
        acc.Delivery_Type__c = 'Export';
        acc.Industry = 'Aerospace & Defense';
        acc.Region_Picklist__c = 'South';
        acc.Company_Type__c = 'OEM';
        acc.Account_SAP_Id__c = 'abc';
        acc.Financial_Stability_Risk__c ='abc';
        acc.Payment_Structure_Collection_Risk__c = 'Low';
        acc.Country_Specific_Statutory_Risk__c = 'Low';
        acc.Service_Availability_Risk_Other_Countrie__c = 'Low';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.OwnerId = u.Id;
        opp.AccountId = acc.Id;
        opp.Name='Test_Opp';
        opp.Amount=10000;
        opp.Temp_amount__c = 10000;
        opp.Type='Repeat Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        opp.StageName = 'Quote Preparation';
        opp.Email__c = 'vinoth.kumar@kvpcorp.com';
        opp.Member1__c = u.Id;
        opp.Sub_Activities__c = 'Mail Confirmation';
        opp.Mail_Confirmation_Date__c = system.today();
        
        insert Opp;
         Quote q1 = new Quote();
        q1.Name = 'Test_Opp';
        q1.OpportunityID = opp.Id;
        q1.Total_Price_Qli__c = 24;
        q1.Pricebook2Id = Test.getStandardPricebookId();
        q1.Product_Sub_Category__c= 'Watches';
        q1.Product_Catagory__c='Sonata';
        q1.Indent_Created__c = true;
        q1.Product_for_Approval__c = 'Watches Gift Voucher';
        q1.Last_Created_Quote__c = false;
     //   q.RecordTypeId = QuoteRecordTypeId;
        insert q1;
        
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = opp.Id;
        q.Total_Price_Qli__c = 24;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.Product_Sub_Category__c= 'Watches';
        q.Product_Catagory__c='Sonata';
        q.Indent_Created__c = true;
        q.Product_for_Approval__c = 'Watches Gift Voucher';
        
     //   q.RecordTypeId = QuoteRecordTypeId;
        insert q;
        
        
        q.Last_Created_Quote__c = false;
        update q;
        
         Attachment a1 = new Attachment();
         a1.ParentID = q.ID;
        a1.IsPrivate = false;
         a1.Name = 'Indent.';   
         a1.Body = Blob.valueof('ABC');
         insert a1;
        //T01 uncommented
      //Database.executeBatch(new QuoteUpdateBatchClass(),1); 
    }
}