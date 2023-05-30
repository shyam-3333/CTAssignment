@isTest
private class SkinnCollectionTemplateTriggerTest {
    @isTest static void skinCollectionTest() {
        List<User> lstUsers = new List<User>();
        
        lstUsers = TestDataFactory.getUsers();
        user lstUserselec=TestDataFactory.getElectricalRoleUser();
        User lstUsersmech=TestDataFactory.getMechanicalRoleUser();
        
        Skinn_Model_Item__c skinModalItem = new Skinn_Model_Item__c();
        skinModalItem.No_of_Days__c = 10;
        skinModalItem.Type__c = 'Sub-Stage';
        skinModalItem.Assigned_Team__c = 'Fragrance Expert';
        Insert skinModalItem;
        
        Skinn_Model_Item__c skinModalItem1 = new Skinn_Model_Item__c();
        skinModalItem1.No_of_Days__c = 10;
        skinModalItem1.Type__c = 'Stage';
        skinModalItem1.Assigned_Team__c = 'Fragrance Expert';
        Insert skinModalItem1;
        
        Skinn_Model_Item__c skinModalItem2 = new Skinn_Model_Item__c();
        skinModalItem2.No_of_Days__c = 10;
        skinModalItem2.Type__c = 'Activity';
        skinModalItem2.Assigned_Team__c = 'Fragrance Expert';
        Insert skinModalItem2;
        
        Common_User__c commonUser = new Common_User__c();
        commonUser.Name = 'Fragrance Expert User 1';
        commonUser.User_Email__c = 'sfdcadmin@titan.co.in';
        commonUser.Team__c = lstUsers.get(1).Id;
        commonUser.Team_Name__c = 'Fragrance Expert';
        
        Insert commonUser;
        
        Common_User__c commonUser2 = new Common_User__c();
        commonUser2.Name = 'Marketing User 1';
        commonUser2.User_Email__c = 'sfdcadmin2@titan.co.in';
        commonUser2.Team__c = lstUsers.get(0).Id;
        commonUser2.Team_Name__c = 'Marketing User';
        
        Insert commonUser2;
        
        Common_User__c commonUser3 = new Common_User__c();
        commonUser3.Name = 'Marketing User 1';
        commonUser3.User_Email__c = 'sfdcadmin2@titan.co.in';
        commonUser3.Team__c = lstUsers.get(2).Id;
        commonUser3.Team_Name__c = 'NPD Packaging';
        
        Insert commonUser3;
        
        Skinn_NPD_Template__c skinNpdTemp = new Skinn_NPD_Template__c();
        skinNpdTemp.Name = 'Marketing New';
        Insert skinNpdTemp;
        
        Skinn_NPD_Template_Item__c skinNpdTemplate1 = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate1.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate1.Skinn_Model_Item__c = skinModalItem1.Id;
        skinNpdTemplate1.Order_No__c = 10;
        skinNpdTemplate1.Planned_Lead_Time__c = 5;
        skinNpdTemplate1.Approval_required__c = true;
        skinNpdTemplate1.Active__c = true;
        
        Insert skinNpdTemplate1;
        
        
        Skinn_NPD_Template_Item__c skinNpdTemplate2 = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate2.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate2.Skinn_Model_Item__c = skinModalItem.Id;
        skinNpdTemplate2.Order_No__c = 10;
        skinNpdTemplate2.Planned_Lead_Time__c = 5;
        skinNpdTemplate2.Approval_required__c = true;
        skinNpdTemplate2.Active__c = true;
        skinNpdTemplate2.Parent_Id__c = skinNpdTemplate1.Id;
        
        Insert skinNpdTemplate2;
        
        
        Skinn_NPD_Template_Item__c skinNpdTemplate = new Skinn_NPD_Template_Item__c();
        skinNpdTemplate.Skinn_NPD_Template__c = skinNpdTemp.Id;
        skinNpdTemplate.Skinn_Model_Item__c = skinModalItem2.Id;
        skinNpdTemplate.Order_No__c = 10;
        skinNpdTemplate.Planned_Lead_Time__c = 5;
        skinNpdTemplate.Approval_required__c = true;
        skinNpdTemplate.Active__c = true;
        skinNpdTemplate.Parent_Id__c = skinNpdTemplate2.Id;
        Insert skinNpdTemplate;
        
        
        Skinn_Collection__c skinnColl = new Skinn_Collection__c();
        skinnColl.Collection_Status__c = 'Open';
        skinnColl.Project_Status__c = 'Drop';
        skinnColl.Project_Lead__c = commonUser3.Id;
        skinnColl.Marketing_User__c = commonUser2.Id;
        skinnColl.Fragrance_User__c = commonUser.Id;
        skinnColl.Marketing_Template__c = skinNpdTemp.Id;
        skinnColl.Project_Template__c = skinNpdTemp.Id;
        
        Insert skinnColl;
        
        Skinn_Model__c skinModalMarketingStage = new Skinn_Model__c();
        skinModalMarketingStage.Name = 'MarketingStage';
        skinModalMarketingStage.Skinn_Collection__c = skinnColl.Id;
        
        Insert skinModalMarketingStage;
        
        Skinn_Model__c skinModal = new Skinn_Model__c();
        skinModal.Name = 'Modal1';
        skinModal.Skinn_Collection__c = skinnColl.Id;
        
        Insert skinModal;
        
        Skinn_Collection_Template__c skinCollectionTmp = new Skinn_Collection_Template__c();
        skinCollectionTmp.Skinn_Collection__c = skinnColl.Id; 
        skinCollectionTmp.Item_Names__c = skinModalItem.Id;
        skinCollectionTmp.Template_Name__c = skinNpdTemp.Id;
        skinCollectionTmp.Skinn_NPD_Template_Item__c = skinNpdTemplate.Id;
        skinCollectionTmp.Skinn_Model__c = skinModal.Id;
        skinCollectionTmp.Order_Number__c = 10;
        skinCollectionTmp.Active__c = true;
        skinCollectionTmp.Approval_Required__c = true;
        skinCollectionTmp.Actual_start_date__c = System.today()-2;
        skinCollectionTmp.Actual_End_date__c = System.today();
        skinCollectionTmp.Status__c = 'Not Started';
        skinCollectionTmp.R1_Start_Date__c = System.today(); 
        skinCollectionTmp.R1_Status__c = 'Not Started';
        skinCollectionTmp.R2_Start_Date__c = System.today();
        skinCollectionTmp.R2_Status__c = 'Not Started';
        skinCollectionTmp.R3_Start_Date__c = System.today();
        skinCollectionTmp.R3_Status__c = 'Not Started';
        skinCollectionTmp.R4_Start_Date__c = System.today();
        skinCollectionTmp.R4_Status__c = 'Not Started';
        skinCollectionTmp.R5_Start_Date__c = System.today();
        skinCollectionTmp.R5_Status__c = 'Not Started';
        skinCollectionTmp.R1_Status__c = 'Not Started';
        skinCollectionTmp.R2_Status__c = 'Not Started';
        skinCollectionTmp.R3_Status__c = 'Not Started';
        skinCollectionTmp.R4_Status__c = 'Not Started';
        skinCollectionTmp.R5_Status__c = 'Not Started';
        skinCollectionTmp.Type__c = 'Activity';
        
        Insert skinCollectionTmp;
        
        System.debug('ID1'+skinNpdTemp.Id);
        System.debug('ID2'+skinModalItem1.Id);
        System.debug('ID3'+skinModalItem.Id);
        System.debug('ID4'+skinModalItem2.Id);
        System.debug('ID5'+skinNpdTemplate1.Id);
        System.debug('ID6'+skinNpdTemplate2.Id);
        System.debug('ID7'+skinNpdTemplate.Id);
        System.debug('ID8'+skinnColl.Id);
        System.debug('ID9'+skinModal.Id);
        System.debug('ID10'+skinCollectionTmp.Id);
        System.debug('Date**** '+skinCollectionTmp.Actual_start_date__c);
        
        Skinn_Collection_Template__c skinCollectionTmpUpdate = new Skinn_Collection_Template__c();
        skinCollectionTmp.Active__c = true;
        skinCollectionTmp.Approval_Required__c = true;
        //skinCollectionTmp.Id = skinCollectionTmp.Id;
        skinCollectionTmp.Actual_start_date__c = System.today()-2;
        //skinCollectionTmp.Actual_End_date__c = System.today();
        Update skinCollectionTmp;
        
        Skinn_Collection_Template__c skinCollectionTmpUpdateAgnUpdate = new Skinn_Collection_Template__c();
        skinCollectionTmpUpdateAgnUpdate.R1_End_Date__c = System.today() + 2;
        skinCollectionTmpUpdateAgnUpdate.R2_End_Date__c = System.today() + 2;
        skinCollectionTmpUpdateAgnUpdate.R3_End_Date__c = System.today() + 2;
        skinCollectionTmpUpdateAgnUpdate.R4_End_Date__c = System.today() + 2;
        skinCollectionTmpUpdateAgnUpdate.R5_End_Date__c = System.today() + 2;
        skinCollectionTmp.R2_End_Date__c = System.today();
        skinCollectionTmpUpdateAgnUpdate.Id = skinCollectionTmp.Id;
        Update skinCollectionTmpUpdateAgnUpdate;
        
    }
}