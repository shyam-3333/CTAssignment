@isTest
public class SkinnModelTriggerHandlerTest {
	@isTest static void skinTest() {
        test.startTest();
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn NPD User'].Id,
            FirstName = 'Fragrance',
            LastName = 'Expert',
            Email = 'sfdcadmin1@kvpcorp.com',
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
        User u1 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Project Lead'].Id,
            FirstName = 'Marketing',
            LastName = 'User',
            Email = 'sfdcadmin12@kvpcorp.com',
            Username = 'MarketingUser@titan.com',
            CompanyName = 'TEST2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u1;
        User u2 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn QA User'].Id,
            FirstName = 'Marketing',
            LastName = 'User',
            Email = 'sfdcadmin123@kvpcorp.com',
            Username = 'MarketingUser1@titan.com',
            CompanyName = 'TEST2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u2;
        
        User u3 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Sourcing User'].Id,
            FirstName = 'Marketing',
            LastName = 'User',
            Email = 'sfdcadmin1234@kvpcorp.com',
            Username = 'MarketingUser12@titan.com',
            CompanyName = 'TEST2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u3;
        
        User u4 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Marketing User'].Id,
            FirstName = 'Marketing',
            LastName = 'User',
            Email = 'sfdcadmin12345@kvpcorp.com',
            Username = 'MarketingUser123@titan.com',
            CompanyName = 'TEST2',
            Title = 'title2',
            Alias = 'alias2',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        
        Insert u4;

        User u5 = new User(
                    ProfileId = [SELECT Id FROM Profile WHERE Name = 'Skinn Fragrance Expert'].Id,
                    FirstName = 'Marketing',
                    LastName = 'User',
                    Email = 'sfdcadmin55672324@kvpcorp.com',
                    Username = 'MarketingUser1234@titan.com',
                    CompanyName = 'TEST2',
                    Title = 'title2',
                    Alias = 'alias2',
                    TimeZoneSidKey = 'America/Los_Angeles',
                    EmailEncodingKey = 'UTF-8',
                    LanguageLocaleKey = 'en_US',
                    LocaleSidKey = 'en_US'
                );
                
        Insert u5;
        
        Skinn_Model_Item__c skinModalItem = new Skinn_Model_Item__c();
        skinModalItem.Planned_Lead_Time__c = 10;
        skinModalItem.Order_No__c = 1;
        skinModalItem.Type__c = 'Stage';
        skinModalItem.Assigned_Team__c = 'Fragrance Expert';
        Insert skinModalItem;
        
        Common_User__c fragranceExpertUser = new Common_User__c();
        fragranceExpertUser.Name = 'Fragrance Expert User 1';
        fragranceExpertUser.User_Email__c = 'sfdcadmin@titan.co.in';
        fragranceExpertUser.Team__c = u5.Id;
        fragranceExpertUser.Team_Name__c = 'Fragrance Expert';
        
        Insert fragranceExpertUser;
        
        Common_User__c marketingUser = new Common_User__c();
        marketingUser.Name = 'Marketing User 1';
        marketingUser.User_Email__c = 'sfdcadmin2@titan.co.in';
        marketingUser.Team__c = u4.Id;
        marketingUser.Team_Name__c = 'Marketing User';
        
        Insert marketingUser;
        
        Common_User__c NPDpackagingUser = new Common_User__c();
        NPDpackagingUser.Name = 'NPD Packaging 1';
        NPDpackagingUser.User_Email__c = 'NPDpackagingUser@titan.co.in';
        NPDpackagingUser.Team__c = u.Id;
        NPDpackagingUser.Team_Name__c = 'NPD Packaging';
        
        Insert NPDpackagingUser;
        
        Common_User__c QAUser = new Common_User__c();
        QAUser.Name = 'QA User 1';
        QAUser.User_Email__c = 'QAUser@titan.co.in';
        QAUser.Team__c = u2.Id;
        QAUser.Team_Name__c = 'QA';
        
        Insert QAUser;
        
        Common_User__c SourcingUser = new Common_User__c();
        SourcingUser.Name = 'Sourcing User 1';
        SourcingUser.User_Email__c = 'SourcingUser@titan.co.in';
        SourcingUser.Team__c = u3.Id;
        SourcingUser.Team_Name__c = 'Sourcing';
        
        Insert SourcingUser;
        
        Skinn_NPD_Template__c skinNpdTemp = new Skinn_NPD_Template__c();
        skinNpdTemp.Name = 'Marketing New';
        skinNpdTemp.Active__c = true;
        Insert skinNpdTemp;
        
        List<Skinn_NPD_Template_Item__c> listprocess = new List<Skinn_NPD_Template_Item__c>();
        Skinn_NPD_Template_Item__c skinNpdTemplate = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate.Order_No__c = 1;
        skinNpdTemplate.Type__c = 'Stage';
        skinNpdTemplate.Planned_Lead_Time__c = 5;
        skinNpdTemplate.Approval_required__c = true;
        skinNpdTemplate.Active__c = true;
        listprocess.add(skinNpdTemplate);
        
        Skinn_NPD_Template_Item__c skinNpdTemplate1 = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate1.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate1.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate1.Order_No__c = 2;
        skinNpdTemplate1.Type__c = 'Stage';
        skinNpdTemplate1.Planned_Lead_Time__c = 5;
        skinNpdTemplate1.Approval_required__c = true;
        skinNpdTemplate1.Active__c = true;
        listprocess.add(skinNpdTemplate1);
        
        Skinn_NPD_Template_Item__c skinNpdTemplate2 = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate2.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate2.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate2.Order_No__c = 2;
        skinNpdTemplate2.Type__c = 'Sub-Stage';
        skinNpdTemplate2.Planned_Lead_Time__c = 5;
        skinNpdTemplate2.Approval_required__c = true;
        skinNpdTemplate2.Active__c = true;
        listprocess.add(skinNpdTemplate2);
        
        Skinn_NPD_Template_Item__c skinNpdTemplate3 = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate3.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate3.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate3.Order_No__c = 3;
        skinNpdTemplate3.Type__c = 'Activity';
        skinNpdTemplate3.Planned_Lead_Time__c = 5;
        skinNpdTemplate3.Approval_required__c = true;
        skinNpdTemplate3.Active__c = true;
        listprocess.add(skinNpdTemplate3);
        
        Insert listprocess;
        
        skinNpdTemplate1.Parent_Id__c = skinNpdTemplate.id;
        skinNpdTemplate2.Parent_Id__c = skinNpdTemplate1.Id;
        skinNpdTemplate3.Parent_Id__c = skinNpdTemplate2.id;
        update listprocess;
        
        Skinn_Triggers_Activation__c insertCustomSetting = new Skinn_Triggers_Activation__c();
        insertCustomSetting.Skinn_Collection_Trigger__c = true;
        insertCustomSetting.Skinn_Model_Trigger__c = true;
        insert insertCustomSetting;
        
        Marketing_Stage_Launch_Date__c customSettinginertformarketing = new Marketing_Stage_Launch_Date__c();
        customSettinginertformarketing.Lead_Time__c = 665;
        customSettinginertformarketing.Process_Name__c = 'Gate approval of Fragrance';
        insert customSettinginertformarketing;
        
        Skinn_Collection__c skinnColl = new Skinn_Collection__c();
        skinnColl.Collection_Status__c = 'Open';
        skinnColl.Project_Status__c = 'Drop';
        skinnColl.Project_Lead__c = NPDpackagingUser.Id;
        skinnColl.Marketing_User__c = marketingUser.Id;
        skinnColl.Fragrance_User__c = fragranceExpertUser.Id;
        skinnColl.NPD_Packaging_User__c = NPDpackagingUser.Id;
        skinnColl.QA_User__c = QAUser.Id;
        skinnColl.Sourcing_User__c = SourcingUser.Id;
        skinnColl.Marketing_Template__c = skinNpdTemp.Id;
        skinnColl.Project_Template__c = skinNpdTemp.Id;
        CheckRecursive.skinnCollectionTriggerFlag = false;
        Insert skinnColl;
        
        Skinn_Model__c insertModelRecord = new Skinn_Model__c();
        insertModelRecord.Skinn_Collection__c = skinnColl.Id;
        insertModelRecord.Name = 'TestModel';
        CheckRecursive.skinnModelTriggerFlag = true;
        insert insertModelRecord;
        test.stopTest();
    }
}