@isTest()
public class NPD_Design_Team_Report_test {
    public static testMethod void testMethod1(){
        test.startTest();
        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'test project owner';
        npdCollection.Collection_Name__c = 'test project owner';
        npdCollection.MarketingBrand__c = 'Titan';
        npdCollection.Project_Status__c = 'Ongoing';
        npdCollection.Tentative_Launch_Month_Date__c = system.today();
        insert npdCollection;
        
        NPD_Master__c  masterProduct = NPD_TestUtilityClass.getNPDMaster('Product Designer Name');
        masterProduct.SalesforceUser__c = UserInfo.getUserID();
        masterProduct.Name = 'Anand Yogi';
        insert masterProduct;
        
         
        NPD_Master__c  masterStrap= NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterStrap.SalesforceUser__c = UserInfo.getUserID();
        masterStrap.Name = 'Test PMG 1';
        insert masterStrap;
        
        NPD_Master__c  masterCase = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCase.SalesforceUser__c = UserInfo.getUserID();
        masterCase.Name = 'Test PMG 1';
        insert masterCase;
        
        
        NPD_Project_Name__c npdProject2 = new NPD_Project_Name__c();
        npdProject2.NPD_Collections__c = npdCollection.Id;
        npdProject2.Name = 'test project owner';        
        npdProject2.Case_Material__c                  =    masterCase.ID;
        npdProject2.Strap_Material__c                 =    masterStrap.ID;
        npdProject2.Strap_Source__c                   =    'IND';
        insert npdProject2;
        
        NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name = 'Marketing Brief/Concept Stage';        
        npdProject.Case_Material__c                  =    masterCase.ID;
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
        
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
        npdStage.brand1__c = 'Titan';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        npdStage.design_manager_npd_master__c = masterProduct.Id;
        npdStage.NPD_Project_Name__c = npdProject.Id;
        insert npdStage;
        
        NPD_Stage__c npdStage1 = NPD_TestUtilityClass.getNPDStage('Concept Finalization');
        npdStage1.NPD_Collections__c = npdCollection.Id;
        npdStage1.Approval_Submitted_Date__c  = System.Today();
        npdStage1.Approved_Date__c = System.Today();
        npdStage1.Actual_Start_Date__c = System.Today();
        npdStage1.Actual_End_Date__c = System.Today();
        npdStage1.NPD_Project_Name__c = npdProject.Id;
        insert npdStage1;
        
        NPD_Activity__c   activity = NPD_TestUtilityClass.getNPDActivity('Activity');
        activity.name__c = 'Concept Design - IDS';
        activity.NPD_Collections__c = npdCollection.Id;
        activity.NPD_Project_Name__c = npdProject2.Id;
        activity.Planned_Lead_Time__c = 10;
        activity.Actual_Start_Date__c = System.Today();
        activity.Actual_End_Date__c = System.Today();
        insert activity;
        
        NPD_Activity__c   activity1 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activity1.name__c = 'Concept Presentation to PMG - IDS';
        activity1.NPD_Collections__c = npdCollection.Id;
        activity1.NPD_Project_Name__c = npdProject2.Id;
        activity1.Planned_Lead_Time__c = 10;
        activity1.Actual_Start_Date__c = System.Today();
        activity1.Actual_End_Date__c = System.Today();
        insert activity1;
        
        NPD_Activity__c   activity2 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activity2.name__c = 'Engineering Design - IDS';
        activity2.NPD_Collections__c = npdCollection.Id;
        activity2.NPD_Project_Name__c = npdProject2.Id;
        activity2.Planned_Lead_Time__c = 10;
        activity2.Actual_Start_Date__c = System.Today();
        activity2.Actual_End_Date__c = System.Today();
        insert activity2;
        
        NPD_Activity__c   activity3 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activity3.name__c = 'PB/PM Release , Approval and Recipt';
        activity3.NPD_Collections__c = npdCollection.Id;
        activity3.NPD_Project_Name__c = npdProject2.Id;
        activity3.Planned_Lead_Time__c = 10;
        activity3.Actual_Start_Date__c = System.Today();
        activity3.Actual_End_Date__c = System.Today();
        insert activity3;
        
        NPD_Activity__c   activity4 = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activity4.name__c = 'Proto Dial Drawing Release and Receipt';
        activity4.NPD_Collections__c = npdCollection.Id;
        activity4.NPD_Project_Name__c = npdProject2.Id;
        activity4.Planned_Lead_Time__c = 10;
        activity4.Actual_Start_Date__c = System.Today();
        activity4.Actual_End_Date__c = System.Today();
        insert activity4; 
        
        NPD_Design_Team_Report  DesignReport = new NPD_Design_Team_Report ();
        DesignReport.selectedBrandName = 'Titan';
        DesignReport.selectedCollectionName = 'test project owner';
        DesignReport.selectedSubActName = 'All';
        DesignReport.selectedDesgnManagName = 'None';
        DesignReport.toDate = Null;
        DesignReport.fromDate = Null;
        DesignReport.selectBrand();
        DesignReport.selectCollection();
        DesignReport.selectSubStageAct();
        DesignReport.selectDesignManag();
        DesignReport.displayStageActTable();
        
        DesignReport.selectedBrandName = 'Titan';
        DesignReport.selectedCollectionName = 'test project owner';
        DesignReport.selectedSubActName = 'Concept Finalization';
        DesignReport.selectedDesgnManagName = 'Anand Yogi';
        DesignReport.toDate = Null;
        DesignReport.fromDate = Null;
        DesignReport.selectBrand();
        DesignReport.selectCollection();
        DesignReport.selectSubStageAct();
        DesignReport.selectDesignManag();
        DesignReport.displayStageActTable();
        test.stopTest();
    }
}