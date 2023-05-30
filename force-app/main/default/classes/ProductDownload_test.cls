@isTest(seeAllData=true)
public class ProductDownload_test {
	@isTest
    public static void ProductDownload(){
           Account ac= new Account();
        ac.Name='Test';
        insert ac;
        
        Contact conNew = new Contact();
        conNew.Firstname = 'PeeWee';
        conNew.LastName = 'Herman';
        conNew.AccountId = ac.Id;
        conNew.Email='sachin.deshmukh@kvpcorp.com';
        insert conNew;
        
        RecordType rt = [select id, name from RecordType where name = 'Jewellery' limit 1]; 
        
        Product2 pObj = new Product2();
        pObj.Name = 'Gold Coin 24 Karat';
        pObj.IsActive = true;
        pObj.Product_Category__c = 'Titan';
        pObj.Sub_Category__c = 'Watches';
       // pObj.RecordTypeId = rt.id;
        insert pObj;
        
        Pricebook2  standardPB = new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        System.debug('----standardPB------>'+standardPB);
        
        PricebookEntry pbe = new PricebookEntry();
        
        pbe.Pricebook2Id = standardPB.Id;
        pbe.Product2Id = pObj.Id;
        pbe.UnitPrice = 10000;
        pbe.IsActive = true;
        pbe.UseStandardPrice = false;
        insert pbe;  
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName ='Proforma Invoice';
        opp.CloseDate = System.today();
        opp.AccountId = ac.id;
        insert opp;
        
        Quote q = new Quote();
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Pricebook2Id =standardPB.id;
        q.ContactId = conNew.id;
        insert q;
        
        ProductDownload_Helper pd = new ProductDownload_Helper();
    }
}