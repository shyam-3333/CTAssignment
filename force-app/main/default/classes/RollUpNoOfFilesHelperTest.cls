@IsTest
public class RollUpNoOfFilesHelperTest {

     static testMethod void validateHelloWorld()
    {
        TriggerStatus__c tt = new TriggerStatus__c();
        tt.Name = 'RollUpNoOfFiles';
        tt.Active__c = true;
        insert tt;
         TriggerStatus__c tt1 = new TriggerStatus__c();
        tt1.Name = 'TestTrigger';
        tt1.Active__c = true;
        insert tt1;
         Opportunity o = new Opportunity();
        o.Name = 'Test for Clone';
        o.CloseDate = System.Today() + 10;
        o.StageName = 'Preliminary Opportunity';
        insert o;
        Blob beforeblob=Blob.valueOf('Unit Test Attachment Body');

        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData =beforeblob;          
        insert cv;         

        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];


        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=o.id;
        contentlink.ShareType= 'V';
        contentlink.LinkedEntityId = o.Id; 
        contentlink.ContentDocumentId=testcontent.ContentDocumentId;
        contentlink.Visibility = 'AllUsers'; 
        insert contentlink;
        list<contentDocument> con = [select id from contentDocument];
        delete con;
         }
}