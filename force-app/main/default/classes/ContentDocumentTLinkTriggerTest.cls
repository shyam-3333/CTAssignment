@isTest
public class ContentDocumentTLinkTriggerTest {
    
    @isTest static void testCover(){
        profile pr = [select id from profile where name = 'SO East Profile'];
        user intgUser = new user(firstname = 'testFirstName',
                                 lastname = 'testLastName',
                                 profileid = pr.id,
                                 email = 'testuser@testclass.com',
                                 Username = 'testfirst.lastname@testclass.com',
                                 Alias = 'TfTl',
                                 CommunityNickname = 'test' ,
                                 TimeZoneSidKey = 'America/New_York', 
                                 LocaleSidKey = 'en_US', 
                                 EmailEncodingKey = 'UTF-8',
                                 LanguageLocaleKey = 'en_US'
                                );
        insert intgUser;
        
        System.runAs(intgUser){
            Ready_Reckoner__c r=new Ready_Reckoner__c();
            r.Start_Date__c = date.newinstance(datetime.now().year(), datetime.now().month(),datetime.now().day());
            r.End_Date__c = date.newinstance(datetime.now().year(), datetime.now().month(),datetime.now().day());
            r.Type__c = 'Wearables';
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
        }
    }
}