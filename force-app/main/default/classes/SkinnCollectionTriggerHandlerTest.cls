/*
*******************************************************************************************************************************************
ModifiedBy            Date         Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)	  Nov-28-2019	T01		Test Class Failure Fix Validation rule failure
*/
@isTest
private class SkinnCollectionTriggerHandlerTest {
    @isTest static void skinTest() {
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn NPD User'].Id,
            FirstName = 'Fragrance',
            LastName = 'Expert',
            Email = 'sfdcadmin@kvpcorp.com',
            Username = 'FragranceExpert@titan.com',
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u;
        
        User uf = new User(//<T01> created user
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Fragrance Expert'].Id,
            FirstName = 'Fragrance',
            LastName = 'Expert',
            Email = 'sfdcadmin@kvpcorp.com',
            Username = 'FragranceExpert1@titan.com',
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert uf;
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Marketing User'].Id,
            FirstName = 'Marketing',
            LastName = 'User',
            Email = 'sfdcadmin2@kvpcorp.com',
            Username = 'MarketingUser@titan.com',
            CompanyName = 'TEST2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u2;
        
        Skinn_Model_Item__c skinModalItem = new Skinn_Model_Item__c();
        skinModalItem.No_of_Days__c = 10;
        skinModalItem.Type__c = 'Stage';
        skinModalItem.Assigned_Team__c = 'Fragrance Expert';
        Insert skinModalItem;
        
        Common_User__c commonUser = new Common_User__c();
        commonUser.Name = 'Fragrance Expert User 1';
        commonUser.User_Email__c = 'sfdcadmin@titan.co.in';
        commonUser.Team__c = uf.Id;//<T01>
        commonUser.Team_Name__c = 'Fragrance Expert';
        
        Insert commonUser;
        
        Common_User__c commonUser3 = new Common_User__c();//<T01>
        commonUser3.Name = 'Skinn NPD User';
        commonUser3.User_Email__c = 'sfdcadmin@titan.co.in';
        commonUser3.Team__c = u.Id;
        commonUser3.Team_Name__c = 'NPD Packaging';
        
        Insert commonUser3;
        
        Common_User__c commonUser2 = new Common_User__c();
        commonUser2.Name = 'Marketing User 1';
        commonUser2.User_Email__c = 'sfdcadmin2@titan.co.in';
        commonUser2.Team__c = u2.Id;
        commonUser2.Team_Name__c = 'Marketing User';
        
        Insert commonUser2;
        
        Skinn_NPD_Template__c skinNpdTemp = new Skinn_NPD_Template__c();
        skinNpdTemp.Name = 'Marketing New';
        Insert skinNpdTemp;
        
        
        Skinn_NPD_Template_Item__c skinNpdTemplate = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate.Order_No__c = 10;
        skinNpdTemplate.Planned_Lead_Time__c = 5;
        skinNpdTemplate.Approval_required__c = true;
        skinNpdTemplate.Active__c = true;
        
        Insert skinNpdTemplate;
        
        Skinn_Collection__c skinnColl = new Skinn_Collection__c();
        skinnColl.Collection_Status__c = 'Open';
        skinnColl.Project_Status__c = 'Drop';
        skinnColl.Project_Lead__c = commonUser3.Id;//<T01>
        skinnColl.Marketing_User__c = commonUser2.Id;
        skinnColl.Fragrance_User__c = commonUser.Id;
        skinnColl.Marketing_Template__c = skinNpdTemp.Id;
        skinnColl.Project_Template__c = skinNpdTemp.Id;
        
        Insert skinnColl;
        
        Skinn_Model__c skinModal = new Skinn_Model__c();
        skinModal.Name = 'Modal1';
        skinModal.Skinn_Collection__c = skinnColl.Id;
        
        Insert skinModal;
        
    }
}