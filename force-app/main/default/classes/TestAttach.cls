/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix changed test.starttest() & test.stoptest() position
*/
@isTest(SeeAllData=true)
private class TestAttach {
    
    static testMethod void myUnitTest() {
        
        User u = new User();
        u.Username ='testemail@test89.com';
        u.LastName = 'LastTestName89';
        u.Email = 'testemail@test.com';
        u.alias = 'testAl89';
        u.TimeZoneSidKey = 'America/New_York';
        u.LocaleSidKey = 'en_US';
        u.EmailEncodingKey = 'ISO-8859-1';
        u.LanguageLocaleKey = 'en_US';
        u.ProfileId = [select id from Profile where Name='RSM East Profile'].Id;
        insert u;
        
        
        Account ac= new Account();
        ac.Name='Test';
        ac.Account_Oracle_ID_cbg__c=1234;
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
        pObj.Product_Category__c = 'Gift card(QC)';
        pObj.Sub_Category__c = 'Watches';
        
        insert pObj;  
        
        Product2 pObj1 = new Product2();
        pObj1.Name = 'Tanishq EC eGift Card';
        pObj1.IsActive = true;
        pObj1.Product_Category__c = 'Gift card(QC)';
        pObj1.Sub_Category__c = 'Jewellery';
        
        insert pObj1; 
        
        
        Pricebook2  standardPB= new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        System.debug('----standardPB------>'+standardPB);
        
        PricebookEntry pbe = new PricebookEntry();
        
        pbe.Pricebook2Id = standardPB.Id;
        pbe.Product2Id = pObj.Id;
        pbe.UnitPrice = 10000;
        pbe.IsActive = true;
        // pbe.UseStandardPrice = false;
        insert pbe;  
        
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        Opportunity opp=new Opportunity();
        opp.RecordTypeId=oppRecordTypeId;
        opp.Customer_category__c='New';
        opp.Product_name__c='test';
        opp.TotalOpportunityQuantity=100;
        opp.StageName='Quote_Preparation';
        opp.Name='test opp';
        opp.AccountId=ac.Id;
        opp.Region_Picklist__c='East';
        opp.Opportunity_Type__c='Milestone';
        opp.CloseDate=System.today();
                opp.Priority__c='High';

        opp.RFQ_Reference1__c='test';
        opp.RFQ_Received_Date_Date__c=System.today();
        opp.LeadSource='Internet';
        opp.Account_Oracle_Id__c=1224;
        insert opp;
        
                            Id quoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();

        Test.startTest();//<T01>
        Quote q = new Quote();
        q.RecordTypeId = quoteRecordTypeId;
        q.OpportunityId = opp.Id;
        q.Order_Type__c='Regular';
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Recipient_Email_ID__c='test@gmail.com';
        q.Pricebook2Id =standardPB.id;
        q.ContactId = conNew.id;
         //q.Product_Catagory__c = 'Titan';
        q.Product_Catagory__c = 'EGift card(QC)';
        q.Product_for_Approval__c ='Gift card/eGift card(QC)';
        q.Approval_Status_Quote__c = 'Approved';
        insert q; 
        System.debug('Test Queue'+q);
        Payment_Tracker__c pt=new Payment_tracker__c();
        pt.Opportunity__c=q.OpportunityId;
        pt.Recipient_Bank__c='HSBC';
        insert pt;

        Attach.checkValidation(q.id);

        
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = q.Id;
        qli.Product2Id=pObj1.id;
        //qli.Product_Catagory__c='EGift card(QC)';
        qli.UnitPrice = 1000.00;
        qli.Discount_c__c=2;
        qli.Quantity = 2;
        qli.PricebookEntryId =pbe.Id;
        
        insert qli;
        
        Quote_Items__c qit= new Quote_Items__c();
        qit.Quote__c=q.id;
        
        insert qit;
                
        
        
        /*Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Submitting request for approval.');
        //req.setAction('Approve');
        req.setNextApproverIds(new Id[] {u.id});
        req.setObjectId(q.Id);
        
        Approval.ProcessResult resu = Approval.process(req);
        
        // Verify the result
        System.assert(resu.isSuccess());
        
        System.assertEquals('Pending', resu.getInstanceStatus(),'Instance Status'+resu.getInstanceStatus());
        system.debug('status for approval::'+resu.getInstanceStatus());
        List<Id> newWorkItemIds = resu.getNewWorkitemIds();
        system.debug('newWorkItemIds ::'+newWorkItemIds );
        
        Approval.ProcessWorkitemRequest req2 =  new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');
        req2.setNextApproverIds(new Id[] {u.Id});//UserInfo.getUserId()
        system.debug('req2::'+req2);
        // Use the ID from the newly created item to specify the item to be worked
        req2.setWorkitemId(newWorkItemIds.get(0));
        system.debug('req3::'+req2);
        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);
        
        // Verify the results
        System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
        
        System.assertEquals(  'Approved', result2.getInstanceStatus(),'Instance Status'+result2.getInstanceStatus());*/
        
        
        /*Quote qq = new Quote(); 
        qq.Id=q.Id;
        qq.Approval_Status_Quote__c='Approved';
        update qq;*/
         
        
        
         
        
        //Attach.checkValidation(q.id);
        
        
            Test.stopTest();    //<T01>
        
        Attach a = new Attach();
        Attach.attachWordpdf(q.Id, 'indentGV');
        system.debug('56555555555555555555555555 '+q.Id);
        Attach.attachWordpdf(q.Id, 'indent');
        //Attach.attachWordpdf(q.Id, 'ProformaInvoice');
        Attach.attachWordpdf(q.Id, 'ProformaGV');
        Attach.attachWordpdf(q.Id, 'Proformawatches');
        //Attach.attachWordpdf(q.Id, 'Indentwatches');
        //Attach.attachWordpdf(q.Id, 'IndentGC');
        //Attach.attachWordpdf(q.Id, 'QuotePECSA');
        //Attach.attachWordpdf(q.Id, 'NewButtonforQuotePricing');
        
        
        Attachment attach1 =new Attachment();      
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.ParentId = q.id;
        insert attach1;
        
        Attach at = new Attach();
        //  Attach.attachWordpdf(q.Id, 'PerformaGV'); 
        //List<Attachment> attachments=[select id, name from Attachment where parent.id=:q.id];
        
        // ApexPages.StandardController sc = new ApexPages.StandardController(q);
        
        PageReference pref = Page.NoteAttachment;
        pref.getParameters().put('id',q.id);
        pref.getParameters().put('Attch',attach1.id);
        
        Test.setCurrentPage(pref);
        
        Attach att=new Attach();
        
        Attach.emailAlertMethod(q.id);
        Attach.emailAlertMethodPdf(q.id);
        //Attach.checkValidation(q.id);

        
        
        
        
        
        
    }
    
    static testMethod void myUnitTest1() {
        
        
        
        Account ac= new Account();
        ac.Name='Test';
        ac.Account_Oracle_ID_cbg__c=1234;
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
        
        Pricebook2  standardPB= new Pricebook2();
        standardPB = [select id from Pricebook2 where isStandard=true limit 1];
        System.debug('----standardPB------>'+standardPB);
        
        PricebookEntry pbe = new PricebookEntry();
        
        pbe.Pricebook2Id = standardPB.Id;
        pbe.Product2Id = pObj.Id;
        pbe.UnitPrice = 10000;
        pbe.IsActive = true;
        // pbe.UseStandardPrice = false;
        insert pbe;  
        Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
        
        Opportunity opp=new Opportunity();
        opp.RecordTypeId=oppRecordTypeId;
        opp.Customer_category__c='New';
        opp.Product_name__c='test';
        opp.TotalOpportunityQuantity=100;
        opp.StageName='Quote_Preparation';
        opp.Name='test opp';
        opp.AccountId=ac.Id;
        opp.Region_Picklist__c='East';
        opp.Opportunity_Type__c='Milestone';
        opp.CloseDate=System.today();
                opp.Priority__c='High';

        opp.RFQ_Reference1__c='test';
        opp.RFQ_Received_Date_Date__c=System.today();
        opp.LeadSource='Internet';
        opp.Account_Oracle_Id__c=1234;
        insert opp;
        Test.startTest();
                    Id quoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();

        Quote q = new Quote(); 
        q.RecordTypeId=quoteRecordTypeId;
        q.OpportunityId = opp.Id;
        q.Name = 'Field';
        q.Email='test@gmail.com';
        q.Pricebook2Id =standardPB.id;
        q.ContactId = conNew.id;
        q.Product_Catagory__c = 'Gift card(QC)';
        q.Product_for_Approval__c = 'Gift card/eGift card(QC)';
        //q.Approval_Status_Quote__c = 'Approved';
       

        
        insert q;  
        
        Quote qq = new Quote(); 
        qq.Id=q.Id;
        //qq.Insti_ref__c='12';
        qq.Approval_Status_Quote__c='Approved';
        update qq;
        

        /*Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        app.setObjectId(q.id);
        Approval.ProcessResult result = Approval.process(app);
        //q.Approval_Status_Quote__c =result;
        Test.StartTest();
		//Call your class method
		Attach.checkValidation(q.id);
		Test.StopTest();*/
        
        
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = q.Id;
        qli.UnitPrice = 10000.00;
        qli.Quantity = 2;
        qli.PricebookEntryId =pbe.Id;
        
        insert qli;
        
        Quote_Items__c qit= new Quote_Items__c();
        qit.Quote__c=q.id;
        
        insert qit;
        Test.stopTest(); 
        Attach.emailAlertMethod(q.id);
        Attach.emailAlertMethodPdf(q.id);
        
        Attach a = new Attach();
        Attach.attachWordpdf(q.Id, 'Indentwatches');
        //Attach.attachWordpdf(qq.Id, 'indentGV');
        Attach.attachWordpdf(q.Id, 'IndentGC');
        // Attach.attachWordpdf(q.Id, 'indentGV');
        //Attach.attachWordpdf(q.Id, 'QuotePECSA');
        //Attach.attachWordpdf(q.Id, 'NewButtonforQuotePricing');
        
        
        Attachment attach1 =new Attachment();      
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.ParentId = q.id;
        // insert attach1;
        
        Attach at = new Attach();
        // Attach.attachWordpdf(q.Id, 'PerformaGV'); 
        //List<Attachment> attachments=[select id, name from Attachment where parent.id=:q.id];
        
        // ApexPages.StandardController sc = new ApexPages.StandardController(q);
        
        PageReference pref = Page.NoteAttachment;
        pref.getParameters().put('id',q.id);
        pref.getParameters().put('Attch',attach1.id);
        
        Test.setCurrentPage(pref);
        Attach att=new Attach();
        
    }
}