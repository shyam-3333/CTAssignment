@isTest()
public class NPD_AlbumScreen2_Report_Class_Test {
    public static testMethod void testMethod1(){
        test.startTest();
        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'Test Exp Collections';
        npdCollection.Collection_Name__c = 'Test Exp Collections';
        npdCollection.MarketingBrand__c = 'Titan';
        insert npdCollection;
        
        NPD_Master__c  masterProduct = NPD_TestUtilityClass.getNPDMaster('Product Designer Name');
        masterProduct.SalesforceUser__c = UserInfo.getUserID();
        masterProduct.Name = 'Test PMG 1';
        insert masterProduct;
        
        NPD_Master__c  masterStrap= NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterStrap.SalesforceUser__c = UserInfo.getUserID();
        masterStrap.Name = 'Test PMG 1';
        insert masterStrap;
        
        NPD_Master__c  masterCase = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCase.SalesforceUser__c = UserInfo.getUserID();
        masterCase.Name = 'Test PMG 1';
        insert masterCase;
        
        NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='Marketing Brief/Concept Stage';
        npdProject.Model_No__c =    '9082';
        npdProject.Case_Material__c                  =    masterCase.ID;
       // npdProject.Strap_Type__r.Name                =    'Leather';
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
        
        
        NPD_Activity__c   activityConceptDesign = NPD_TestUtilityClass.getNPDActivity('Test');
        activityConceptDesign.name__c = 'Make or Buy and Model No. Allocation';
        activityConceptDesign.NPD_Collections__c = npdCollection.Id;
        activityConceptDesign.Planned_Lead_Time__c = 10;
        activityConceptDesign.Actual_Start_Date__c = System.Today();
        activityConceptDesign.Actual_End_Date__c = System.Today();
        activityConceptDesign.ISCM_Briefing_Date__c = System.Today();
        insert activityConceptDesign;
        
        NPD_Activity__c   activity = NPD_TestUtilityClass.getNPDActivity('Test');
        activity.name__c = 'Watch Deposition';
        activity.Model_Name__c = '9082';
        activity.NPD_Collections__c = npdCollection.Id;
        activity.Planned_Lead_Time__c = 10;
        activity.Actual_Start_Date__c = System.Today();
        activity.Actual_End_Date__c = System.Today();
        insert activity;
        
        NPD_Checklist__c checklistConcept = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklistConcept.Product_Designer_Name__c = masterProduct.Id;
        insert checklistConcept;
        
        NPD_Checklist__c checklist = new NPD_Checklist__c();
        checklist.Supply_Agency__c = null;
        checklist.Model_No__c = '9082';
        checklist.NPD_Activity_Chklist__c = activityConceptDesign.Id;
        insert checklist;
        
        NPD_AlbumScreen2_Report_Class AlbumReport = new NPD_AlbumScreen2_Report_Class();
        AlbumReport.searchModel = '9082';
        AlbumReport.displayModel();
       
        test.stopTest();
    }
}