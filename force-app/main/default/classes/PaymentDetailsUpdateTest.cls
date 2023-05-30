@isTest
//(seeAllData = true)
public class PaymentDetailsUpdateTest {
    public static testmethod void Test1(){
        
        Id CSRecordTypeId  = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        ID QuoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        CheckValidation__c check = CheckValidation__c.getInstance(UserInfo.getOrganizationId());
        check.isChecked__c = true;
        upsert check;
        
        Account acc = new Account();
        acc.name = 'Test Acc';
        acc.Delivery_Type__c = 'Export';
        acc.Industry = 'Aerospace & Defense';
        acc.Region_Picklist__c = 'South';
        acc.Company_Type__c = 'OEM';
        insert acc;
        
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name='Test_Opp';
        opp.Amount=10000;
        opp.Temp_amount__c = 10000;
        opp.Type='New Opportunity';
        opp.Region_Picklist__c = 'South';
        opp.CloseDate=System.Today();
        opp.StageName    =     'Requirement Analysis';
        opp.recordTypeId    =    CSRecordTypeId;
        insert opp;
        
        
        Quote q = new Quote();
        q.Name = 'Test_Opp';
        q.OpportunityID = opp.Id;
        q.Total_Price_Qli__c = 24;
        q.Pricebook2Id = Test.getStandardPricebookId();
        q.Product_Sub_Category__c= 'Watches';
        q.Product_Catagory__c='Sonata';
        q.RecordTypeId = QuoteRecordTypeId;
        insert q;

        
        Product2 objp = new Product2(Name = 'Test Product 1',Product_Category__c='Sonata',Sub_Category__c='Watches' );
        insert objp; 
        Pricebook2 pb2 = new Pricebook2(Name='TestPrice');
        insert pb2; 
        PricebookEntry pbe =new PricebookEntry(unitprice=0.01,Product2Id=objp.Id,Pricebook2Id=Test.getStandardPricebookId(),IsActive = true); 
        insert pbe;
        
        QuoteLineItem qi = new QuoteLineItem ();
        qi.quoteId = q.ID;
        qi.Quantity = 2;
        qi.UnitPrice = 12;
        qi.PricebookEntryId = pbe.id;
        qi.Product2Id= objp.id;
        Insert qi;
        
        Payment_Tracker__c track = new Payment_Tracker__c();
        track.Opportunity__c = opp.Id;
        track.Amount_Recieved__c = 10;
        track.Payment_Type__c = 'Advance';
        track.Payment_Mode__c = 'RTGS';
        track.RTGS_No__c = '126547T';
        track.Cheque_Date__c = system.today();

        system.debug('The value in test is: ' + track.Amount_Recieved__c +'.....'+opp.Amount);
        insert track;
        
              

        
        Payment_Tracker__History pr = new Payment_Tracker__History(ParentId = track.Id, Field = 'Payment_Type__c');
        insert pr;
        

        
        Test.StartTest();
        PaymentDetailsUpdate payment = new PaymentDetailsUpdate();  
        payment.fetchPaymentDetails();
        payment.calculateDateString(system.today(), 'T10:30:00.000Z');
        Test.stopTest();
        
        
    }
}