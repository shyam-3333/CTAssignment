/*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01     Test class issue fixing
*/
@isTest
public class successorActivityNameTest {
    public static testMethod void methodOne() {
        Test.startTest();
        NPD_Project_Template__c oPrjctTemp = new NPD_Project_Template__c();
        oPrjctTemp.Name = 'Regular';
        oPrjctTemp.Active__c = TRUE;
        oPrjctTemp.Description__c = 'Testing';
        insert oPrjctTemp;
        NPD_Project_Items__c oPrjctItem = new NPD_Project_Items__c();
        oPrjctItem.Item_Type__c = 'Activity';
        oPrjctItem.Title__c = 'Proto Design Input';
        oPrjctItem.Titan_Sr_No__c = 'AR-01';
        oPrjctItem.Lead_Time__c = 2;
        oPrjctItem.Days_to_Complete__c = 2;
        oPrjctItem.Complexity__c = 'Medium';
        oPrjctItem.Project_Template__c = oPrjctTemp.id;
        oPrjctItem.Active__c = TRUE;
        insert oPrjctItem;
        npd_collections__c nc1 = new npd_collections__c();
        nc1.name = 'titan raga';
        nc1.Tentative_Launch_Month_Date__c = system.now().date();
        insert nc1;
        npd_project_name__c np1 = new npd_project_name__c();
        np1.name = 'Model titan123';
        np1.source__c = 'IDS';
        np1.Project_Complexity__c = 'Medium';
        np1.npd_collections__c = nc1.id;
        np1.newModelRefresh__c = 'false';
        insert np1;
        // parent stage Design 
        npd_stage__c ns1 = new npd_stage__c();
        ns1.name__c = 'design';
        ns1.position__c = 2;
        ns1.source__c = 'IDS';
        ns1.Complexity_Typess__c = 'medium';
        ns1.Planned_Lead_Time__c = 20;
        ns1.npd_collections__c = nc1.id;
        ns1.npd_project_name__c = np1.id;
        ns1.active__c = true;
        ns1.type__c = 'stage';
        ns1.active__c = true;
        insert ns1;
        // Design stage sub stage.
        npd_stage__c ns2 = new npd_stage__c();
        ns2.name__c = 'Proto Type Manufacturing';
        ns2.position__c = 1;
        ns2.source__c = 'IDS';
        ns2.Complexity_Typess__c = 'medium';
        ns2.Planned_Lead_Time__c = 20;
        ns2.npd_Stage__c = ns1.id;
        ns2.npd_collections__c = nc1.id;
        ns2.npd_project_name__c = np1.id;
        ns2.active__c = true;
        ns2.type__c = 'sub-stage';
        ns2.active__c = true;
        insert ns2;
        NPD_Activity__c oActivity = NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Proto Design Input';
        //<T01>Commented the below lines due to validation rule and modified Actual End Date in NPD_TestUtilityClass.getNPDActivity 
        /*oActivity.Actual_Start_Date__c = system.today();
        oActivity.Actual_End_Date__c = system.today().addDays(2);*/
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'Approved';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = ns2.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        //   oActivity.Active__c = true;
        oActivity.NPD_Project_Items__c = oPrjctItem.id;
        oActivity.NPD_Project_Name__c = np1.id;
        //   oActivity.NPD_User__c                                    =    masterBrand.id;
        //      oActivity.Checklist_Columns__c= 'Activity Reference,CollectionName,Vendor Name,No of Designs,Component,Status,Date of Completion,Remarks,Owner';
        //    oActivity.NPD_Activity__c=oActivity1.id;
        insert oActivity;
        NPD_Email__c email = new NPD_Email__c();
        email.Name = 'NPDEmail';
        email.NPD_Activity__c = oActivity.id;
        email.NPD_Project_Items__c = oPrjctItem.id;
        email.Type__c = 'Successor';
        insert email;
        successorActivityName sActivityName = new successorActivityName();
        sActivityName.activityId = oActivity.id;
        sActivityName.getlActivity();
        Test.StopTest();
    }
}