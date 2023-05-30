@isTest
public class ProposalToolSendEmailControllerTest {
    private static testMethod void testRetrieveAttachment()
    {  
        
        
        Proposal__c r  = new Proposal__c();
        //prop.Name = 'test';
        insert r; 
        
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = true;
        insert tt;
        
        
        
        ContentVersion cv = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = blob.valueof('Test Content Data'),
            IsMajorVersion = true
        );
        insert cv;
        
        ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=r.id;  
        //contentlink.ShareType= 'C';               
        contentlink.ContentDocumentId=documents[0].Id;
        contentlink.Visibility = 'AllUsers'; 
        insert contentlink;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:r.id];
        List<contentDocument> docList = ProposalToolSendEmailController.retrieveAttachment(r.Id);
        
        
        Contact con = new Contact(LastName = 'Test');
        List<Contact> conList = new List<Contact>();
        conList.add(con);
        insert conList;
        List<Contact> conT =ProposalToolSendEmailController.getContacts();
        List<Contact> conT2= ProposalToolSendEmailController.findByName('Test');
        
        
        ProposalToolSendEmailController.sendEmailApex(r.Id, new List<String>{conList[0].Id}, new List<String>{'test@gmail,com'}, 'subject', 'body', new List<String>{r.Id}, new List<String>{'test@gmail,com'});
        system.debug(docList);
        ProposalToolSendEmailController.fetchLookUpValues('Test','Contact',new List<sObject>{new Account()});
        //System.assertEquals(1,docList.size());
        
    }
}