/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/8/2019           Setup > Email Administration > Deliverability to update the Access Level to All Email.
*/
@isTest(seeAllData=true)
private class TestReplyLead {
    public static User objUser = TestDataFactory.getElectricalRoleUser(); //<T01>
        public static User objUser1 = TestDataFactory.getMechanicalRoleUser();
    static testMethod void myUnitTest() {
        List<user> lstuser = [Select u.Region__c, u.IsActive, u.Id From User u where IsActive =true];
        
        system.runAs(lstuser[0]){    
            boolean bool=true;
            Account acc= new Account();
            acc.Name='Test';
            insert acc;
            System.debug('----Account ------>'+acc);
            contact con = new contact();
            con.LastName='madan';
            con.Email='madan@gmail.com';
            con.MobilePhone='8907371571';
            con.AccountId=acc.Id;
            insert con;
            System.debug('----contact ------>'+con);
            Product2 pObj = new Product2();
            pObj.Name = 'Gold Coin 24 Karat';
            pObj.IsActive = true;
            insert pObj;
            Pricebook2  standardPB= new Pricebook2();
            standardPB = [select id from Pricebook2 where isStandard=true];
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = standardPB.Id;
            pbe.Product2Id = pObj.Id;
            pbe.UnitPrice = 10000;
            pbe.IsActive = true;
            insert pbe;
            RecordType lstreco = [select name,id from RecordType where Sobjecttype='Opportunity' and name = 'Jewellery' limit 1];   
            RecordType p=[select id,name from RecordType where sobjectType='Quote' and name='Jewellery' limit 1];
            Opportunity opp = new Opportunity();
            opp.Name = 'Test';
            opp.StageName ='Proforma Invoice';
            opp.CloseDate = System.today();
            opp.AccountId=acc.Id;
            opp.Type='ABC';
            opp.Region_Picklist__c='South';
            opp.Amount=100.00;
            opp.Region_Picklist__c='South';
            opp.RecordTypeId= lstreco.Id;
            //opp.Member1__c=lstuser[0].Id;
            //opp.Member1__c=lstuser[0].Id;
            if(objUser1 != null){
                opp.Member1__c = objUser1.id;
            }
            if(objUser!=null)
                opp.Member2__c =objUser.Id;
            insert opp;
            Quote q = new Quote();
            q.OpportunityId=opp.Id;
            q.Name = 'Field';
            q.RecordTypeId=p.id;
            q.Pricebook2Id =standardPB.id;
            q.ContactId = con.id;
            q.Email = 'abc@gmail.com';
            q.Phone = '1234';
            insert q;
            Case ca = new Case();
            ca.Case_Name__c='madan';
            ca.ContactId=con.Id;
            ca.AccountId=acc.Id;
            ca.Type='abc';
            ca.Status='New';
            ca.Origin='abcd';
            insert ca;
            Task t = new Task();
            t.Status='ABC';
            t.Priority='XYZ';
            t.Subject='Email: test';
            t.OwnerId=lstuser[0].Id;
            insert t;
            
            Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
            email1.setToAddresses(new String[] { 'admin.newer@gmail.com' });
            email1.setSubject('Email Received');
            email1.setPlainTextBody('Email Received By Recepient');
            List<Messaging.SendEmailResult> results1 = 
                Messaging.sendEmail(new Messaging.Email[] { email1 });
            
            Attachment att = new Attachment();
            att.Name ='Indent.';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            att.body= Blob.valueOf('Test');
            att.ParentId = ca.id;
            insert att;
            
            
            att.name='Indent.';
            update att;
            ApexPages.currentPage().getParameters().put('retURl',q.Id);
            ApexPages.currentPage().getParameters().put('attid',att.Id);   
            ApexPages.StandardController controller = new ApexPages.StandardController(t);
            ReplyLead rpylead = new ReplyLead(controller);
            rpylead.sendReply();
            rpylead.redirectQuotePage();
            rpylead.getjsonDescriptionData();
            rpylead.doCancel();
            //rpylead.upload();
            rpylead.doAttachment();
            att.name='Indent GV.';
            update att;
            ApexPages.currentPage().getParameters().put('retURl',q.Id);
            ApexPages.currentPage().getParameters().put('attid',att.Id);   
            ApexPages.StandardController econtroller = new ApexPages.StandardController(t);
            ReplyLead rpylead1 = new ReplyLead(econtroller);
            rpylead1.sendReply();
            rpylead1.redirectQuotePage();
            rpylead1.getjsonDescriptionData();
            rpylead1.doCancel();
            //rpylead.upload();
            rpylead.doAttachment();
            att.name='Indent GC.';
            update att;        
            ApexPages.currentPage().getParameters().put('retURl',q.Id);
            ApexPages.currentPage().getParameters().put('attid',att.Id);   
            ApexPages.StandardController rcontroller = new ApexPages.StandardController(t);
            ReplyLead rpyleade = new ReplyLead(rcontroller);
            
            
            
            rpyleade.doCancel();
            //rpylead.upload();
            rpyleade.doAttachment();
            rpyleade.getjsonDescriptionData();
            rpyleade.sendReply();
            rpyleade.redirectQuotePage();
            
            
        }
    }
    
    
    
}