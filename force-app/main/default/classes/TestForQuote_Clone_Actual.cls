/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019    TO1       Test Class Issue Fixing
Test class : TestForQuote_Clone_Actual
*/
@isTest//(seeAllData=true)
public class TestForQuote_Clone_Actual 
{
    private static Id quoteRecID = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();//<TO1>
    static testMethod void DoSomeClone()
    {
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.name = 'QuoteTrigger';
        tt.Active__c = true;
        insert tt;
        
        RecordType rectId=[select id,name from RecordType where sobjecttype='Quote' and RecordType.name='Jewellery' limit 1];
        RecordType oppId=[select id,name from RecordType where sobjecttype='Opportunity' and RecordType.name='Jewellery' limit 1];
        RecordType proId=[select id,name from RecordType where sobjecttype='Product2' and RecordType.name='Jewellery' limit 1];
        
        //TriggerStatus__c tt = TriggerStatus__c.getInstance('QuoteTrigger');
        //tt.Active__c = false;
        //update tt;
        
        Account a=new Account();
        a.name='Different';
        insert a;
        Opportunity o = new Opportunity();
        o.Name = 'Test for Clone';
        o.AccountId=a.id;
        o.RecordTypeId=oppId.id;
        o.CloseDate = System.Today() + 10;
        o.Opportunity_Type__c = 'Dealer Incentive';
        o.StageName = 'Preliminary Opportunity';
        insert o;
        
        //Instantiate the Pricebook2 record with StandardPricebookId
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        Update standardPricebook;
        Pricebook2 pb = [select Id from Pricebook2 where IsStandard = true limit 1];
        
        Product2 p = new Product2(Name = 'Gift Card Voucher', isActive = true,Product_Category__c='Gold Coins' ,Sub_Category__c='Coin');
        insert p;
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pb.Id, Product2Id = p.Id, UnitPrice = 1, isActive = true);
        insert pbe;
        
        Quote q = new Quote();
        q.Name = 'Test for Clone';
        q.Approval_Status_Quote__c='Approved';
        q.OpportunityID = o.ID;
        q.Pricebook2Id=pb.id;
        q.RecordTypeId =quoteRecID;//<TO1>
        insert q;
        
        test.startTest();
        List<QuoteLineItem> qlilist = new List<QuoteLineItem>();
        
        
        QuoteLineItem qi = new QuoteLineItem();
        qi.QuoteId=q.id;
        qi.PricebookEntryId=pbe.id;
        qi.Quantity=2;
        qi.UnitPrice=2000;
        qi.Product2Id=p.id;
        
        qlilist.add(qi);
        
        QuoteLineItem qi1 = new QuoteLineItem();
        qi1.QuoteId=q.id;
        qi1.PricebookEntryId=pbe.id;
        qi1.Quantity=2;
        qi1.UnitPrice=2000;
        qi1.Product2Id=p.id;
        qlilist.add(qi1);
        insert qlilist;
        test.stopTest();
        
        
        
        List<QuoteLineItem> qlilist11=[select id from QuoteLineItem where QuoteId=:q.ID];
        
        ApexPages.CurrentPage().getParameters().Put('id',q.id);
        system.debug('q.Approval_Status_Quote__c==>'+q.Approval_Status_Quote__c);
        ApexPages.StandardController std = new ApexPages.StandardController(q);
        CloneQuote_Actual clone1 = new CloneQuote_Actual(std);
        
        //system.debug('qqqqqq==>'+([select Approval_Status_Quote__c from quote where id = :q.id limit 1]).Approval_Status_Quote__c);
        CloneQuote_Actual.onLoad(q.id);  
        MassDeleteQLI.fetchQLIs(q.id);
        list<MassDeleteQLI.wrapper> toClass = new list<MassDeleteQLI.wrapper>();
        for(QuoteLineItem qli :qlilist11){
            MassDeleteQLI.wrapper wrap = new MassDeleteQLI.wrapper();
            wrap.check = true;
            wrap.qli = qli;
            toClass.add(wrap);
        }
        MassDeleteQLI.deleteQli((string)JSON.serialize(toClass));
        list<quote> tempList = new list<quote>();
        tempList.add(q);
        new AssignStdPKtoQuote().assignPB(tempList);
    }
}