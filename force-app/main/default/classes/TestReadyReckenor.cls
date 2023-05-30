@isTest
public class TestReadyReckenor {
    private static testMethod void testRetrieveAttachment()
    {  
        
        
        Ready_Reckoner__c r=new Ready_Reckoner__c();
        r.Start_Date__c = date.newinstance(datetime.now().year(), datetime.now().month(),datetime.now().day());
        r.End_Date__c = date.newinstance(datetime.now().year(), datetime.now().month(),datetime.now().day());
        r.Type__c = 'Wearables';
        insert r; 
        
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = true;
        insert tt;
        
        /*Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=r.id;
        insert attach;*/
        
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
        List<contentDocument> docList = ReadyReckenor.retrieveAttachment(r.Id);
        
       
        Contact con = new Contact(LastName = 'Test');
        List<Contact> conList = new List<Contact>();
        conList.add(con);
        insert conList;
        List<Contact> conT =ReadyReckenor.getContacts();
        List<Contact> conT2= ReadyReckenor.findByName('Test');
        
        
        ReadyReckenor.sendEmailApex(r.Id, new List<String>{conList[0].Id}, new List<String>{'test@gmail,com'}, 'subject', 'body', new List<String>{r.Id}, 'Email');
        system.debug(docList);
        //System.assertEquals(1,docList.size());
        
    }
    
    
}