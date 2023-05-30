@isTest
private class TitanTriggerTest{

    static testMethod void myUnitTest() {
         
        Account newacc = new Account(Name = 'test12');
        insert newacc;
        Standard_Terms_of_Titan__c st = new Standard_Terms_of_Titan__c(Name = 'test');
        insert st;
        
        id Recordtype=[select name from Recordtype where Sobjecttype=:'Opportunity' and name=:'Jewellery' limit 1].id;
       List<Opportunity> opp1=new List<Opportunity>{new Opportunity(Recordtypeid=Recordtype,Name = 'Opp Test',Type = 'New Opportunity',Project_Type__c = 'Domestic',AccountId = newacc.Id,CloseDate = System.today(),
        Priority_set_by_Customer__c = 'High',Opportunity_Type__c = 'Jewellery',Expected_Machine_Dispatch_Date__c = System.today(),StageName = 'Proforma Invoice',Approval_Status__c='Approval Required')};
       insert opp1;
       
       Product2 p2= new Product2(Name = 'test product', family = 'Services');
       insert p2;
         Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body');
        Attachment newattachment=new Attachment(Name='Validated.',body=bodyBlob1,parentId=opp1[0].id);
         try{
        insert  newattachment;
                }
        catch(Exception e){}
   // Pricebook2 pb= [SELECT Id, Name from Pricebook2 WHERE isStandard=true limit 1];

   // PricebookEntry pbe = new PricebookEntry(pricebook2id=pb.id,Product2Id=p2.id,unitprice=500.0,UseStandardPrice = False,isActive=true);
   //  insert pbe;
    id Rcdtype=[select name from Recordtype where Sobjecttype=:'Quote' and name=:'Jewellery' limit 1].id;  
        Contact ct = new Contact();
    Quote q = new Quote();
    q.RecordTypeId=Rcdtype;
    q.Name = 'Quote test';
        //q.ContactId = ct.id;
      
    q.OpportunityId = opp1[0].id;
    
  //  q.Pricebook2id = pb.id; 
    Insert q;
        
        TitanTrigger tt=new TitanTrigger();
        tt.test1();
    
    }
}