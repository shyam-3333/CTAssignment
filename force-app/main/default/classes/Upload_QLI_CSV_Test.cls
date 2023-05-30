@isTest(seeAllData=true)
public class Upload_QLI_CSV_Test {
    
    @isTest
    public static void UploadFunction(){
        Test.startTest();
        Account ac= new Account();
        ac.Name='Test';
        insert ac;
        
        Contact conNew = new Contact();
        conNew.Firstname = 'PeeWee';
        conNew.LastName = 'Herman';
        conNew.AccountId = ac.Id;
        conNew.Email='sachin.deshmukh@kvpcorp.com';
        insert conNew;
        
        Product2 pObj = new Product2();
        pObj.Name = 'Gold Coin 24 Karat';
        pObj.IsActive = true;
        pObj.Product_Category__c = 'Titan';
        pObj.Sub_Category__c = 'Watches';
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
        // q.ContactId = conNew.id;
        insert q;
        q.id=q.id;
        update q;
        PageReference pageRef = Page.Upload_QLI_CSV;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', q.id);
        Upload_QLI_CSV upl = new Upload_QLI_CSV();
       // upl.ImportCSVFile();
       upl.contentFile = blob.valueOf('Product Name,Product Id,Price Book Entry Id,UCP,Discount in %,Sales Price,Quant \n'+pObj.Name+','+pObj.id+','+pbe.id+','+'2000,2,2000,10');
       upl.ImportCSVFile();
       Test.stopTest(); 
    }
}