/*
*******************************************************************************************************************************************
ModifiedBy            Date         Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)	  Nov-28-2019	T01		Test Class Failure Fix Validation rule failure
*/
@isTest
public class SkinnNPD_PickListControllerTestClass {
    
    public static testmethod void testCollrollerMethod(){
        test.startTest();
     	 //<T01>created 5 users
        List<User> lstUsers = new List<User>();
        lstUsers = TestDataFactory.getUsers();
        List<Skinn_Model_Item__c> skinnModelRecords=new List<Skinn_Model_Item__c>();
        //Marketing Template
        Skinn_Model_Item__c skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Release of project brief by Marketing';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=1;
        skinnmodelRed.Serial_No__c='AR01';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to Fragrance house';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=97;
        skinnmodelRed.Order_No__c=2;
        skinnmodelRed.Serial_No__c='AR0101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to design house/ Agency for packaging material designs';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=3;
        skinnmodelRed.Serial_No__c='AR0102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of rendered image options for bottle & cap';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=4;
        skinnmodelRed.Serial_No__c='AR010101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of Fragrance samples- options';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=5;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=6;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=7;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=8;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=9;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Finalization of Bottle and cap design option';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=7;
        skinnmodelRed.Order_No__c=10;
        skinnmodelRed.Serial_No__c='AR010102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        //Project Template
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Sharing rendered images of bottle & cap with respective vendors';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=202;
        skinnmodelRed.Order_No__c=11;
        skinnmodelRed.Serial_No__c='AR02';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Recepit of bottle dwg';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=12;
        skinnmodelRed.Serial_No__c='AR0201';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='QA approval on bottle drawing';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='QA';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=13;
        skinnmodelRed.Serial_No__c='AR020101';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Artwork development for printing on bottle (both text & color pantone)';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=14;
        skinnmodelRed.Serial_No__c='AR020102';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed); 
        
        insert skinnModelRecords;
        Skinn_NPD_Template__c templateRecord=new Skinn_NPD_Template__c(Name='Marketing Temp',Active__c=true);
        Skinn_NPD_Template__c templateRecord2=new Skinn_NPD_Template__c(Name='Project Temp',Active__c=true);
        insert templateRecord;
        insert templateRecord2;
        List<Skinn_NPD_Template_Item__c> listJunctionRecords=new List<Skinn_NPD_Template_Item__c>();
        integer i=0;
        for(Skinn_Model_Item__c each:skinnModelRecords ){
            if(i<10){
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord.Id));   
            }else{
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord2.Id));  
            }
            i++;
        }
        insert listJunctionRecords;
        
        listJunctionRecords[1].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[2].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[3].Parent_Id__c=listJunctionRecords[1].Id;
        listJunctionRecords[4].Parent_Id__c=listJunctionRecords[3].Id;
        listJunctionRecords[5].Parent_Id__c=listJunctionRecords[2].Id;
        listJunctionRecords[6].Parent_Id__c=listJunctionRecords[5].Id;
        listJunctionRecords[7].Parent_Id__c=listJunctionRecords[6].Id;
        listJunctionRecords[8].Parent_Id__c=listJunctionRecords[7].Id;
        listJunctionRecords[9].Parent_Id__c=listJunctionRecords[8].Id;
        listJunctionRecords[10].Parent_Id__c=listJunctionRecords[0].Id;
        update listJunctionRecords;
        
        List<Common_User__c> Users=new List<Common_User__c>();
        Users.add(new Common_User__c(Name='Marketing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Marketing User',Team__c=lstUsers.get(0).Id));
        Users.add(new Common_User__c(Name='Fragrance User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Fragrance Expert',Team__c=lstUsers.get(1).Id));
        Users.add(new Common_User__c(Name='NPD User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='NPD Packaging',Team__c=lstUsers.get(2).Id));
        Users.add(new Common_User__c(Name='QA User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='QA',Team__c=lstUsers.get(3).Id));
        Users.add(new Common_User__c(Name='Sourcing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Sourcing',Team__c=lstUsers.get(4).Id));
        insert Users;
        
        List<Skinn_Collection__c> collectionRecords=new List<Skinn_Collection__c>();
        Skinn_Collection__c ColleactionRecord1=new Skinn_Collection__c(Name='CollectionName',Collection_Status__c='Open',Market__c='Marketing',Marketing_User__c=Users[0].Id,Fragrance_User__c=Users[1].Id,NPD_Packaging_User__c=Users[2].Id,QA_User__c=Users[3].Id,Sourcing_User__c=Users[4].Id);
        ColleactionRecord1.Marketing_Template__c=templateRecord.Id;
        ColleactionRecord1.Project_Template__c=templateRecord2.Id;
        ColleactionRecord1.Marketing_User__c=Users[0].Id;
        ColleactionRecord1.Fragrance_User__c=Users[1].Id;
        ColleactionRecord1.NPD_Packaging_User__c=Users[2].Id;
        ColleactionRecord1.QA_User__c=Users[3].Id;
        ColleactionRecord1.Sourcing_User__c=Users[4].Id;
        ColleactionRecord1.Project_Lead__c=Users[2].Id;
        collectionRecords.add(ColleactionRecord1);
        insert collectionRecords;
        SkinnNPD_PickListController.getSelectOwner();
        SkinnNPD_PickListController.getTaskuser();
        SkinnNPD_PickListController.getselectType();
        SkinnNPD_PickListController.getNameValues();
        SkinnNPD_PickListController.fetchModelNames(collectionRecords[0].Id);
         list<Skinn_Model__c> MartetingStagelist=[SELECT Id FROM Skinn_Model__c where Skinn_Collection__c=:collectionRecords[0].Id and name='MarketingStage'];
        // Error fix by Ranjani n-Lister (List out out of bounds)
        system.debug('MartetingStagelist'+MartetingStagelist);
        if(MartetingStagelist!=null && !MartetingStagelist.isempty())
        {
            Skinn_Model__c MartetingStageId = MartetingStagelist[0];
        SkinnNPD_PickListController.fetchMSStageItems(collectionRecords[0].Id,templateRecord.Id,Users[0].Id,MartetingStageId.Id);
        
        List<Skinn_Collection_Template__c> records=[Select Id,Skinn_Model__c,Actual_start_date__c,
                                                    Actual_Lead_Time__c,Actual_End_date__c,planned_Start_Date__c,planned_End_Date__c,
                                                    planned_Lead_Time__c,Status__c,Comments_Remarks__c,R1_Start_Date__c,R1_End_Date__c,
                                                    R2_Start_Date__c,R2_End_Date__c,R3_Start_Date__c,R3_End_Date__c,
                                                    R4_Start_Date__c,R4_End_Date__c,R5_Start_Date__c,R5_End_Date__c,
                                                    Skinn_NPD_Template_Item__r.Parent_Id__c,Skinn_NPD_Template_Item__c,Active__c,Order_Number__c,
                                                    Revision_status__c,Skinn_Collection__r.Name,Item_Names__r.Parent_Id__c,Responsibly__r.Team__c,Responsibly__c From Skinn_Collection_Template__c where Skinn_Collection__c=:collectionRecords[0].Id and Skinn_Model__c=:MartetingStageId.id limit 100];
        Skinn_Collection_Template__c order5Record=new Skinn_Collection_Template__c();
        Skinn_Collection_Template__c order4Record=new Skinn_Collection_Template__c();
        Skinn_Collection_Template__c order6Record=new Skinn_Collection_Template__c();
        for(Skinn_Collection_Template__c each:records){
            if(each.Order_Number__c==5){
                order5Record=each;
            }
            if(each.Order_Number__c==6){
                order6Record=each;
            }
            if(each.Order_Number__c==4){
                order4Record=each;
            }
        }
        order5Record.Actual_start_date__c=system.today();
        String recordString=JSON.serialize(order5Record);
        List<String> listRecord=new List<String> ();
        listRecord.add(recordString);    
        SkinnNPD_PickListController.saveStageActRecord(listRecord,collectionRecords[0].Id,Users[1].Id,MartetingStageId.id);
        order6Record.Actual_start_date__c=system.today();
        recordString=JSON.serialize(order6Record);
        listRecord=new List<String> ();
        listRecord.add(recordString);  
        SkinnNPD_PickListController.saveStageActRecord(listRecord,collectionRecords[0].Id,Users[1].Id,MartetingStageId.id);
        order5Record.Actual_End_date__c=system.today();
        recordString=JSON.serialize(order5Record);
        listRecord=new List<String> ();
        listRecord.add(recordString);  
        SkinnNPD_PickListController.saveStageActRecord(listRecord,collectionRecords[0].Id,Users[1].Id,MartetingStageId.id);
        
        SkinnNPD_PickListController.deactivateCollectionTemp(order4Record.Id,Users[0].Id,collectionRecords[0].Id,templateRecord.Id,MartetingStageId.id);
        
        SkinnNPD_PickListController.emailNotification(order5Record.Id);
        SkinnNPD_PickListController.successorInfoMethod(order5Record.Id,collectionRecords[0].Id);
      
        Task taskSobject=new Task();
        taskSobject.WhatId=order5Record.Id;
        taskSobject.User_Info__c=Users[1].Id;
        taskSobject.ActivityDate=system.today();
        taskSobject.Status='In Progress';
        taskSobject.Priority='Hight';
        taskSobject.Subject='Cold calls';
        SkinnNPD_PickListController.addTaskMethodCall(taskSobject);
        Note NoteObject=new Note();
        NoteObject.ParentId=order5Record.Id;
        NoteObject.Title='Test';
        SkinnNPD_PickListController.addNoteMethod(NoteObject);
        SkinnNPD_PickListController.submitForAppProcess(order5Record.Id);
        
        test.stopTest();
          }
    }
    
    public static testmethod void testCollrollerMethod1(){
        test.startTest();
        //<T01>
        List<User> lstUsers = new List<User>();
        lstUsers = TestDataFactory.getUsers();
        /* User u = new User(
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
insert u;*/
        List<Skinn_Model_Item__c> skinnModelRecords=new List<Skinn_Model_Item__c>();
        //Marketing Template
        Skinn_Model_Item__c skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Release of project brief by Marketing';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=1;
        skinnmodelRed.Serial_No__c='AR01';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to Fragrance house';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=97;
        skinnmodelRed.Order_No__c=2;
        skinnmodelRed.Serial_No__c='AR0101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Brief to design house/ Agency for packaging material designs';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=3;
        skinnmodelRed.Serial_No__c='AR0102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of rendered image options for bottle & cap';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=4;
        skinnmodelRed.Serial_No__c='AR010101';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Receipt of Fragrance samples- options';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=5;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=6;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=7;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=8;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Evaluation of fragrance samples';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Fragrance Expert';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=45;
        skinnmodelRed.Order_No__c=9;
        skinnmodelRed.Serial_No__c='AR010201';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Finalization of Bottle and cap design option';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=7;
        skinnmodelRed.Order_No__c=10;
        skinnmodelRed.Serial_No__c='AR010102';
        skinnmodelRed.TemplateType__c='Marketing Temp';
        skinnModelRecords.add(skinnmodelRed);
        //Project Template
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Sharing rendered images of bottle & cap with respective vendors';
        skinnmodelRed.Type__c='Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=202;
        skinnmodelRed.Order_No__c=11;
        skinnmodelRed.Serial_No__c='AR02';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Recepit of bottle dwg';
        skinnmodelRed.Type__c='Sub-Stage';
        skinnmodelRed.Assigned_Team__c='NPD Packaging';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=195;
        skinnmodelRed.Order_No__c=12;
        skinnmodelRed.Serial_No__c='AR0201';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='QA approval on bottle drawing';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='QA';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=188;
        skinnmodelRed.Order_No__c=13;
        skinnmodelRed.Serial_No__c='AR020101';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed);
        
        skinnmodelRed=new Skinn_Model_Item__c();
        skinnmodelRed.Item_Name__c='Artwork development for printing on bottle (both text & color pantone)';
        skinnmodelRed.Type__c='Activity';
        skinnmodelRed.Assigned_Team__c='Marketing User';
        skinnmodelRed.Approval_required__c=false;
        skinnmodelRed.Planned_Lead_Time__c=90;
        skinnmodelRed.Order_No__c=14;
        skinnmodelRed.Serial_No__c='AR020102';
        skinnmodelRed.TemplateType__c='Project Temp';
        skinnModelRecords.add(skinnmodelRed); 
        
        insert skinnModelRecords;
        Skinn_NPD_Template__c templateRecord=new Skinn_NPD_Template__c(Name='Marketing Temp',Active__c=true);
        Skinn_NPD_Template__c templateRecord2=new Skinn_NPD_Template__c(Name='Project Temp',Active__c=true);
        insert templateRecord;
        insert templateRecord2;
        List<Skinn_NPD_Template_Item__c> listJunctionRecords=new List<Skinn_NPD_Template_Item__c>();
        integer i=0;
        for(Skinn_Model_Item__c each:skinnModelRecords ){
            if(i<10){
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord.Id));   
            }else{
                listJunctionRecords.add(new Skinn_NPD_Template_Item__c(Active__c=true,Order_No__c=each.Order_No__c,Planned_Lead_Time__c=each.Planned_Lead_Time__c,Skinn_Model_Item__c=each.Id,Skinn_NPD_Template__c=templateRecord2.Id));  
            }
            i++;
        }
        insert listJunctionRecords;
        
        listJunctionRecords[1].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[2].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[3].Parent_Id__c=listJunctionRecords[1].Id;
        listJunctionRecords[4].Parent_Id__c=listJunctionRecords[3].Id;
        listJunctionRecords[5].Parent_Id__c=listJunctionRecords[2].Id;
        listJunctionRecords[6].Parent_Id__c=listJunctionRecords[5].Id;
        listJunctionRecords[7].Parent_Id__c=listJunctionRecords[6].Id;
        listJunctionRecords[8].Parent_Id__c=listJunctionRecords[7].Id;
        listJunctionRecords[9].Parent_Id__c=listJunctionRecords[8].Id;
        listJunctionRecords[10].Parent_Id__c=listJunctionRecords[0].Id;
        listJunctionRecords[11].Parent_Id__c=listJunctionRecords[10].Id;
        listJunctionRecords[12].Parent_Id__c=listJunctionRecords[11].Id;
        listJunctionRecords[13].Parent_Id__c=listJunctionRecords[12].Id;
        update listJunctionRecords;
        
        List<Common_User__c> Users=new List<Common_User__c>();
        Users.add(new Common_User__c(Name='Marketing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Marketing User',Team__c=lstUsers.get(0).Id));
        Users.add(new Common_User__c(Name='Fragrance User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Fragrance Expert',Team__c=lstUsers.get(1).Id));
        Users.add(new Common_User__c(Name='NPD User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='NPD Packaging',Team__c=lstUsers.get(2).Id));
        Users.add(new Common_User__c(Name='QA User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='QA',Team__c=lstUsers.get(3).Id));
        Users.add(new Common_User__c(Name='Sourcing User 1',User_Email__c='sameer.ranjan@kvpcorp.com',Team_Name__c='Sourcing',Team__c=lstUsers.get(4).Id));
        insert Users;
        
        List<Skinn_Collection__c> collectionRecords=new List<Skinn_Collection__c>();
        Skinn_Collection__c ColleactionRecord1=new Skinn_Collection__c(Name='CollectionName',Collection_Status__c='Open',Market__c='Marketing',Marketing_User__c=Users[0].Id,Fragrance_User__c=Users[1].Id,NPD_Packaging_User__c=Users[2].Id,QA_User__c=Users[3].Id,Sourcing_User__c=Users[4].Id);
        ColleactionRecord1.Marketing_Template__c=templateRecord.Id;
        ColleactionRecord1.Project_Template__c=templateRecord2.Id;
        ColleactionRecord1.Marketing_User__c=Users[0].Id;
        ColleactionRecord1.Fragrance_User__c=Users[1].Id;
        ColleactionRecord1.NPD_Packaging_User__c=Users[2].Id;
        ColleactionRecord1.QA_User__c=Users[3].Id;
        ColleactionRecord1.Sourcing_User__c=Users[4].Id;
        ColleactionRecord1.Project_Lead__c=Users[2].Id;
        collectionRecords.add(ColleactionRecord1);
        insert collectionRecords;
        list<Skinn_Model__c> MartetingStagelist=[SELECT Id FROM Skinn_Model__c where Skinn_Collection__c=:collectionRecords[0].Id and name='MarketingStage'];
        //Skinn_Model__c MartetingStageId=[SELECT Id FROM Skinn_Model__c where Skinn_Collection__c=:collectionRecords[0].Id and name='MarketingStage'][0];
        Skinn_Model__c createNewModel=new Skinn_Model__c(Name='Test',Skinn_Collection__c=collectionRecords[0].Id);
        insert createNewModel;
         // Error fix by Ranjani n-Lister (List out out of bounds)
        if(MartetingStagelist!=null && !MartetingStagelist.isempty())
        {
            Skinn_Model__c MartetingStageId = MartetingStagelist[0];
        List<Skinn_Collection_Template__c> records=[Select Id,Skinn_Model__c,Actual_start_date__c,
                                                    Actual_Lead_Time__c,Actual_End_date__c,planned_Start_Date__c,planned_End_Date__c,
                                                    planned_Lead_Time__c,Status__c,Comments_Remarks__c,R1_Start_Date__c,R1_End_Date__c,
                                                    R2_Start_Date__c,R2_End_Date__c,R3_Start_Date__c,R3_End_Date__c,
                                                    R4_Start_Date__c,R4_End_Date__c,R5_Start_Date__c,R5_End_Date__c,
                                                    Skinn_NPD_Template_Item__r.Parent_Id__c,Skinn_NPD_Template_Item__c,Active__c,Order_Number__c,
                                                    Revision_status__c,Skinn_Collection__r.Name,Item_Names__r.Parent_Id__c,Responsibly__r.Team__c,Responsibly__c From Skinn_Collection_Template__c where Skinn_Collection__c=:collectionRecords[0].Id and (Skinn_Model__c=:MartetingStageId.id or Skinn_Model__c=:createNewModel.Id ) limit 100];
        Skinn_Collection_Template__c order5Record=new Skinn_Collection_Template__c();
        Skinn_Collection_Template__c order4Record=new Skinn_Collection_Template__c();
        Skinn_Collection_Template__c order6Record=new Skinn_Collection_Template__c();
        Skinn_Collection_Template__c order13Record=new Skinn_Collection_Template__c();
        for(Skinn_Collection_Template__c each:records){
            if(each.Order_Number__c==5){
                order5Record=each;
            }
            if(each.Order_Number__c==6){
                order6Record=each;
            }
            if(each.Order_Number__c==4){
                order4Record=each;
            }
            if(each.Order_Number__c==13){
                order13Record=each;
            }
        }
        Task taskSobject=new Task();
        taskSobject.WhatId=order5Record.Id;
        taskSobject.User_Info__c=Users[1].Id;
        taskSobject.ActivityDate=system.today();
        SkinnNPD_PickListController.addTaskMethodCall(taskSobject);
        Note NoteObject1=new Note();
        NoteObject1.ParentId=order5Record.Id;
        SkinnNPD_PickListController.addNoteMethod(NoteObject1);
        SkinnNPD_PickListController.emailAlert('sameer.ranjan@kvpcorp.com','Test','Test','Test');
        SkinnNPD_PickListController.afterUpdateMethodCall(order13Record);
        SkinnNPD_PickListController.checkResponsiblyUser('String','String');
        String attfile='{"filename":"Screenshot (7).png","baseDate":"NULL","contentType":"image/png"}';
        SkinnNPD_PickListController.saveAttcFile(attfile,order13Record.Id);
        attfile='{"filename":"Screenshot (7).png","baseDate":"NULL":"image/png"}';
        SkinnNPD_PickListController.saveAttcFile(attfile,order13Record.Id);
        test.stopTest();
        }
    }
}