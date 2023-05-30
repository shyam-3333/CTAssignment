@isTest
public class IndentGvExcelAttachmentControllerTest {
    @isTest
    public static void mymethod(){
        UserRole r1 = new UserRole(DeveloperName = 'MyCustomRole1', Name = 'My Role');
        insert r1;
        UserRole r2 = new UserRole(DeveloperName = 'MyCustomRole2', Name = 'My Role');
        insert r2;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000111@amamama.com',//<T02>
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            isActive = true,
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r1.Id
        );
        u.EmployeeNumber = '123456789';
        
        insert u;
        
        
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'lastss',
            Email = 'puser0s00@amamama.com',
            Username = 'puser00s0111@amamama.com',//<T02>
            CompanyName = 'TEST',
            Title = 'titles',
            Alias = 'aliass',
            isActive = true,
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = r2.Id,
            Payment_Tracker_L1_Approver__c =u.id 
            
        );
        u2.EmployeeNumber = '123456789D';
        insert u2;
        
        
        System.runAs(u2){
            Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Corporate').getRecordTypeId();
            Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
            Id quoteRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('Jewellery').getRecordTypeId();
            CheckValidation__c ck=new CheckValidation__c();
            ck.isChecked__c=false;
            insert ck;
            Account acc=new Account();
            acc.Name='Test';
            acc.GSTN_Number__c='1234';
            acc.Last_Billed_Month__c=System.today();
            acc.Customer_Category__c='Active ( Billed in 2020 )';
            acc.RecordTypeId=accountRecordTypeId;
            acc.CustomerSegment__c='Others';
            acc.Customer_Subsegment__c='Existing';
            acc.Pan_No__c='12345';
            acc.BillingState='Kolkata';
            acc.Region_Picklist__c='East';
            acc.Account_Type__c='Gold';
            acc.Type='Customer';
            acc.Date_of_establishment_of_company__c=System.today();
            //acc.Account_Oracle_ID_cbg__c =1234;
            acc.Account_Oracle_ID_cbg__c=1234;
            insert acc;
            
            Contact con=new Contact();
            con.LastName='Test';
            con.AccountId=acc.Id;
            con.MobilePhone='1234567890';
            con.Email='test@gmail.com';
            insert con;
            
            Opportunity opp=new Opportunity();
            opp.RecordTypeId=oppRecordTypeId;
            opp.Customer_category__c='New';
            opp.Product_name__c='test';
            opp.TotalOpportunityQuantity=100;
            opp.StageName='Quote_Preparation';
            opp.Name='test opp';
            opp.AccountId=acc.Id;
            opp.Region_Picklist__c='East';
            opp.Opportunity_Type__c='Milestone';
            opp.CloseDate=System.today();
            opp.RFQ_Reference1__c='test';
            opp.RFQ_Received_Date_Date__c=System.today();
            opp.LeadSource='Internet';
            opp.Account_Oracle_Id__c=Integer.valueOf(1234);
            insert opp;
            Id standardPB = Test.getStandardPricebookId();
            
            Quote qc=new Quote();
            qc.Name='Test';
            qc.ContactId = con.Id;
            qc.Recipient_Email_ID__c='test@gmail.com';
            qc.Product_for_Approval__c='Gift card/eGift card(QC)';
            qc.OpportunityId=opp.Id;
            //qc.AccountId='0017c00000z9WcQAAU';
            qc.RecordTypeId=quoteRecordTypeId;
            qc.Order_Type__c='Regular';
            qc.BillingState='Kolkata';
            qc.Indent_Button_Clicked__c=true;
            qc.Pricebook2Id =standardPB;//.id;
            
            insert qc;
            
            
            
            Quote_Items__c qt1 = new Quote_Items__c();
            qt1.Quote__c= qc.id;
            qt1.S_No__c = 1234;
            qt1.Unit_Price__c= 100;
            qt1.Quantity__c=1;
            
            insert qt1;
            
            Product2 pObj = new Product2();
            pObj.Name = 'Gold Coin 24 Karat';
            pObj.IsActive = true;
            pObj.Product_Category__c = 'Titan';
            pObj.Sub_Category__c = 'Watches';
            
            insert pObj;  
            
            PricebookEntry pbe = new PricebookEntry();
            
            pbe.Pricebook2Id = standardPB;//.Id;
            pbe.Product2Id = pObj.Id;
            pbe.UnitPrice = 10000;
            pbe.IsActive = true;
            pbe.UseStandardPrice = false;
            insert pbe; 
            
            QuoteLineItem qli = new QuoteLineItem();
            qli.QuoteId = qc.Id;
            qli.UnitPrice = 10000.00;
            qli.Quantity = 2;
            qli.PricebookEntryId =pbe.Id;
            
            insert qli;            
            
            Quote qcc=new Quote();
            qcc.Id=qc.Id;
            qcc.Indent_Submitted_Date__c=System.today();
            qcc.Payment_Tracker_Approval_Status__c='Pending';
            update qcc;
            
            Payment_Tracker__c pt=new Payment_Tracker__c();
            pt.Opportunity__c=opp.Id;
            pt.Amount_Recieved__c=123412;
            pt.Payment_Type__c='Advance';
            pt.Payment_Mode__c='Cheque';
            pt.Cheque_Date__c=System.today();
            pt.Cheque_No__c='12345';
            pt.Recipient_Bank__c='HSBC';
            insert pt;
            Payment_Tracker__c ptt=new Payment_Tracker__c();
            ptt.Id=pt.Id;
            ptt.Bank_Name__c='PNB';
            update ptt;
            
            Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
            app.setObjectId(ptt.id);
            Approval.ProcessResult result = Approval.process(app);
            GenerateIndentQueue.attachWordpdf(qc.ID, 'indentGV');
            PageReference pageRef = Page.IndentGvExcelAttachmentPage;
            Test.setCurrentPage(pageRef);
            // put the lead id as a parameter
            ApexPages.currentPage().getParameters().put('paymentId',qcc.Id);
            IndentGvExcelAttachmentController.attachPDFFromQuote(qcc.Id, ptt.Id, new List<Id>{u.Id}, '', 'Approved');
            ApexPages.StandardController sc = new ApexPages.StandardController(qcc);
            IndentGvExcelAttachmentController cas = New IndentGvExcelAttachmentController(sc);
            cas.fetchingDataForExcel();
            
        }
        
    }
    
    
}