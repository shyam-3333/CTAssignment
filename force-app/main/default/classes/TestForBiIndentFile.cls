/*Name                 : TestForBiIndentFile 
    Created By         : Suyog B Magar
    Email              : magarsuyog.b@kvpcorp.com
    Created Date       :
    Modified By        :
    Last Modified Date :
    Description        : Indent records created within 24 hours should be sent in  txt file format    */
@isTest
public class TestForBiIndentFile {
    Static testmethod void TestMethodForBiIndentFile(){
        Account acc=new account();
        acc.Name='naaaa ';
        acc.Region_Picklist__c='North';
        acc.Type='Customer';
        acc.BillingState='Karnataka';
        acc.GSTN_Number__c='HT123';
        acc.Date_of_establishment_of_company__c=system.today();
        acc.Last_Billed_Month__c=system.today();
        acc.Customer_Category__c='Active ( Billed in 2020 )';
        acc.CustomerSegment__c='others';
        acc.Customer_Subsegment__c='New';
        acc.Pan_No__c='ht12342';             
        String rtId = [select id from recordtype where developername='Corporate'  AND SobjectType = 'Account' LIMIT 1].id;
        acc.recordtypeid = rtId ;
        insert acc;
        
        Opportunity opp=new Opportunity();
            opp.AccountId=acc.Id;
            String rtIdOpp = [select id from recordtype where developername='Jewellery'  AND SobjectType = 'Opportunity' LIMIT 1].id;
            opp.recordtypeid = rtIdOpp;
            opp.StageName='RFQ Study';
            opp.Opportunity_Type__c='Sales Incentive';
            opp.Customer_category__c='New';
            opp.Product_name__c='Jewellery';
            
            opp.TotalOpportunityQuantity=2;
            opp.Name='Titan';
            opp.Type='Milestone';
            opp.Amount=100;
            opp.Region_Picklist__c='North';
            opp.CloseDate=system.today();
            opp.LeadSource='Internet';
            insert opp;
        
         contact c =new contact();
        c.FirstName='test1';
        c.LastName='test2';
        c.AccountId=acc.Id;
        c.MobilePhone='132566';
        c.Email='ms@gmail.com';
        insert c;
        
        
         Quote qt = new Quote();
         String rtIdQuote = [select id from recordtype where developername='Jewellery'  AND SobjectType = 'Quote' LIMIT 1].id;  
         qt.RecordTypeId=rtIdQuote;
         qt.Name = 'test Indent Quote';
         qt.ContactId=c.Id;
         qt.OpportunityID = opp.ID;
         qt.Indent_Created__c = True;
         qt.Product_for_Approval__c = 'GV/GC Valid on Gold Coin';
         qt.Indent_Created_Date__c=Date.newInstance(2022, 12, 25);
         qt.BI_Indent_Created_Date__c=DateTime.newInstance(2022, 12, 26, 16, 3, 3);
         qt.Order_Type__c='Custom';    
         insert qt;
         DateTime myDateTime = DateTime.newInstance(2022, 12, 25, 16, 3, 3);
         Test.setCreatedDate(qt.Id, myDateTime);
       
        
        BiIndentFile obj = new BiIndentFile();
            obj.fetch();
            
            obj.getCount();
       
        Test.StartTest();
		ScheduleBiIndentFile scheObj=new ScheduleBiIndentFile();
		String sch = '0 05 15 ? * * *';
		system.schedule('Test status Check', sch, scheObj );
        Test.stopTest();
    }
}