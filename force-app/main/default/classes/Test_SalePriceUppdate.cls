/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix changed test.starttest() & test.stoptest() position
*/
@isTest(seeAllData=true)
public class Test_SalePriceUppdate
{
    public static testMethod void Salesuser()
    {
        
        
        List<Quote> quoteList= new List<Quote>();
        List<RecordType> lstreco = [select name,id from RecordType where Sobjecttype='Account' and name='Corporate'];
        RecordType rtd = [select id,Name from RecordType where SobjectType='Opportunity' and Name='Jewellery' Limit 1];
        RecordType Qtc=[select id,name from RecordType where sobjecttype='Quote' and name='Jewellery' limit 1 ]; 
        Account acc =new Account();
        acc.RecordTypeId= lstreco[0].Id;
        acc.Name='kvpcorp';
        acc.Date_of_establishment_of_company__c = System.today();
        acc.Type='Customer';
        acc.BillingState='Karnataka';
        acc.Channel__c='HNI';
        acc.Customer_Category__c='Prospect ( Never billed )';
        acc.CustomerSegment__c='HNI';
        acc.Customer_Subsegment__c='Existing';
        acc.GSTN_Number__c='123456789123456';
        acc.Last_Billed_Month__c=System.today();
        acc.Pan_No__c='1234ABCD';
        insert acc;
        Opportunity opp = new Opportunity();
        
        
        opp.recordTypeId=rtd.id;
        opp.Name = 'Test';
        opp.AccountId = acc.Id;
        opp.Type = 'New Opportunity';
        opp.RecordTypeId=rtd.id;
        opp.Region_Picklist__c='South';
        opp.Amount=5000000;
        opp.StageName = 'Quote_Preparation';
        opp.CloseDate=System.today();
        opp.Reason__c='Project Shelved';
        opp.Opportunity_Type__c='Sales Incentive';
        opp.Livelihood_Date_of_billing__c=System.today();
        insert opp;
        system.debug('opp values----------->'+opp);
        
        
        Product2 p2 = new Product2(Name = 'Anti-infectives 2007',Family = 'Best Practices',IsActive = true,Extra_Charges__c='true', Product_Category__c = 'Titan',Sub_Category__c = 'Watches');
        insert p2;
        
        Pricebook2 standardPB = [select id from Pricebook2 where isStandard=true];
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = standardPB.Id,Product2Id = p2.Id,UnitPrice = 10000,IsActive = true,UseStandardPrice = false);
        insert pbe; 
        test.starttest();//<T01>
        Quote q = new Quote(OpportunityId = opp.Id,Name = 'Field',Customization_Payment_Criteria__c='None',Sent_to_Approval__c = false,Is_Free_Of_Customization_Approved__c='Yes',Price_After_Discount__c = 98,Price_Before_Discount__c =100,
                            Pricebook2Id = standardPB.Id,RecordTypeId=Qtc.id,Quote_Parity_Value__c = 3); 
        quoteList.add(q);
        insert q;
        
        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id,UnitPrice = 10000.00,Sales_Price_c__c=1200,Quantity = 1,PricebookEntryId =pbe.Id, Product2id=p2.Id );
        insert qli;
        q.Approval_Status_Quote__c='Approval Required';
        q.RecordTypeId=Qtc.id;
        update q;
        
        Util_Common.triggerSet.remove('updateCurrencyName');
        Util_Common.triggerSet.remove('updateOppAmount');
        q.Approval_Status_Quote__c='Approved';
        q.Customization_Payment_Criteria__c='Free Of Cost';
        update q;
        
        Util_Common.triggerSet.remove('updateCurrencyName');
        Util_Common.triggerSet.remove('updateOppAmount');
        test.stoptest();//<T01>
        
        q.Is_Free_Of_Customization_Approved__c='Yes';
        update q;
        
        
        qli.Sales_Price_c__c=0;
        qli.UnitPrice=0;
        
        
        update qli;
        
        system.debug('### Final '+Limits.getDMLRows());
        system.debug('### Final L###'+Limits.getQueries());
        
        QuoteTriggerHandler2.updateComment(quoteList);
    }
    
    
}