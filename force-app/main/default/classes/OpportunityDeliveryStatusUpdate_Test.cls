/*
    Created By    : Mohit Dwivedi.
    Created  Date : 31/1/2018.
    Purpose       : This test class is for Opportunity Stage change to order close if opp amount is equal to amount recieved and update close date same as delivery tracker date.     
*/

@isTest
public class OpportunityDeliveryStatusUpdate_Test{
    public static testmethod void chechTest(){
        system.test.starttest();
        RecordType rt = [select Id,name from RecordType where Name ='Jewellery' and SobjectType = 'Opportunity'];
        
        Account acc = new Account();
        acc.name = 'Umesh Mor';
        acc.Type = 'Customer';  
        acc.Industry = 'Automotive';
        acc.Region_Picklist__c= 'North';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Mohit Test';
        opp.recordtypeId= rt.id;
        opp.Account= acc;
        opp.Type = 'New Opportunity';
        opp.StageName='Payment/Delivery';
        opp.Amount= 1000;
        opp.Delivery_Status__c='Partially done';
        opp.Payment_Status__c='None';
        opp.closeDate= System.today()-1;
        //opp.Amount_Recieved__c = 1000;
        opp.PO_No__c='123';
        opp.PO_Date__c= system.today();
        opp.PO_Reference__c = '12324';
        
        Insert opp;
        /********
        //define the standart price for the product
        Id pricebookId = Test.getStandardPricebookId();
        
        Product2 pr = new Product2();
        pr.Name='Test';
        pr.Product_Category__c = 'sonata';
        pr.Sub_Category__c= 'Pendant';  
        insert pr;
        
        CheckValidation__c chv = new CheckValidation__c();
        chv.isChecked__c= false;
        insert chv;
        *****/
        /***
        RecordType rt1 = [select Id,name from RecordType where Name ='Jewellery' and SobjectType = 'Quote'];
        Quote qt = new Quote();
        qt.Name='Test';
        qt.Opportunity=opp;
        //qt.Opportunity= opp;
        qt.OpportunityId=opp.id;
        qt.Pricebook2Id = pricebookId;
        qt.recordtypeId= rt1.id;
        Insert qt;
        
        Pricebook2 pb = new pricebook2(name='test');
        insert pb;
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = pr.Id,UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        
        ****/
        
        /***
        //List<QuoteLineItem> qitem = new List<QuoteLineItem>();
                QuoteLineItem qli = new QuoteLineItem();
                qli.UnitPrice=123456;
                qli.Quantity=34;
                qli.QuoteId=qt.id;
                qli.PricebookEntryId = standardPrice.id;
                qli.Product2Id= pr.Id;
                insert  qli;
        ***************/
       /*** 
        Payment_Tracker__c Pt = new Payment_Tracker__c();
        Pt.Opportunity__c = opp.id;
        Pt.Amount_Recieved__c = 1000;
        Pt.Payment_Type__c ='Balance';
        insert Pt;
        
        Delivery_Details_Tracker__c ddt = new Delivery_Details_Tracker__c();
        ddt.Opportunity__c = opp.id;
        //ddt.recordtypeId= rt.id;
        ddt.Date__c =System.today();
        insert ddt; 
        system.test.stoptest();
        Attachment attach=new Attachment();     
        attach.Name='%Invoice.png%';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=opp.id;
        insert attach;
        
        opp.id= opp.id;
        Opp.Delivery_Status__c='Completed';
        opp.Payment_Status__c= 'Completed';
        update opp;
       ****/
    }
    
}