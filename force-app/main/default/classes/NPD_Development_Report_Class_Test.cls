@isTest()
public class NPD_Development_Report_Class_Test {
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
        
      /*  NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='Marketing Brief/Concept Stage';
        npdProject.Model_No__c =    '9082';
        npdProject.Case_Material__c                  =    masterCase.ID;
       // npdProject.Strap_Type__r.Name                =    'Leather';
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;*/
        
        NPD_Project_Name__c npdProject2 = new NPD_Project_Name__c();
        npdProject2.NPD_Collections__c = npdCollection.Id;
        npdProject2.Name='9876';
        //npdProject.Model_No__c =    '9082';
        npdProject2.Case_Material__c                  =    masterCase.ID;
       // npdProject.Strap_Type__r.Name                =    'Leather';
        npdProject2.Strap_Material__c                 =    masterStrap.ID;
        npdProject2.Strap_Source__c                   =    'IND';
        insert npdProject2;
        
        
        NPD_Activity__c   activityConceptDesign = NPD_TestUtilityClass.getNPDActivity('Test');
        activityConceptDesign.name__c = 'Proto Submission by D&D for Approval';
        activityConceptDesign.NPD_Collections__c = npdCollection.Id;
        activityConceptDesign.NPD_Project_Name__c = npdProject2.Id;
        activityConceptDesign.Planned_Lead_Time__c = 10;
        activityConceptDesign.Approval_Status__c = 'Approved';
        activityConceptDesign.Actual_Start_Date__c = System.Today();
        activityConceptDesign.Actual_End_Date__c = System.Today();
        insert activityConceptDesign;
        
        NPD_Activity__c   activity = NPD_TestUtilityClass.getNPDActivity('Test');
        activity.name__c = 'Watch Deposition';
        activity.NPD_Collections__c = npdCollection.Id;
        activity.NPD_Project_Name__c = npdProject2.Id;
        activity.Planned_Lead_Time__c = 10;
        activity.Actual_Start_Date__c = System.Today();
        activity.Actual_End_Date__c = System.Today();
        insert activity;
        
        NPD_Activity__c   activity2 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity2.name__c = 'Planned Order Loading';
        activity2.NPD_Collections__c = npdCollection.Id;
        activity2.NPD_Project_Name__c = npdProject2.Id;
        activity2.Planned_Lead_Time__c = 10;
        activity2.Actual_Start_Date__c = System.Today();
        activity2.Actual_End_Date__c = System.Today();
        insert activity2;
        
        NPD_Activity__c   activity3 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity3.name__c = 'Input - Final Product Design';
        activity3.NPD_Collections__c = npdCollection.Id;
        activity3.NPD_Project_Name__c = npdProject2.Id;
        activity3.Planned_Lead_Time__c = 10;
        activity3.Actual_Start_Date__c = System.Today();
        activity3.Actual_End_Date__c = System.Today();
        insert activity3;
        
        NPD_Activity__c   activity4 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity4.name__c = 'Product Certification and Handing Over Note';
        activity4.NPD_Collections__c = npdCollection.Id;
        activity4.NPD_Project_Name__c = npdProject2.Id;
        activity4.Planned_Lead_Time__c = 10;
        activity4.Actual_Start_Date__c = System.Today();
        activity4.Actual_End_Date__c = System.Today();
        insert activity4;
        
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        
        NPD_Development_Controller DevelReport = new NPD_Development_Controller();
        DevelReport.selectedBrandName = 'ZOOP';
        DevelReport.fromDate = null;
        DevelReport.toDate = null;
        DevelReport.selectedCollectionName = 'Test Exp Collections';
        DevelReport.displayTableDev();
        DevelReport.selectedCollectionName = 'All';
        DevelReport.displayTableDev();
       
        test.stopTest();
    }
}