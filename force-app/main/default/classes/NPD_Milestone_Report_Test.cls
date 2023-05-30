@isTest()
public class NPD_Milestone_Report_Test{
    public static testMethod void testMethodTwo(){
		test.startTest();
        NPD_Master__c  masterBrand = NPD_TestUtilityClass.getNPDMaster('Brand');
        masterBrand.SalesforceUser__c = UserInfo.getUserID();
        masterBrand.Name = 'Test PMG 1';
        insert masterBrand;
        
       
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.SalesforceUser__c = UserInfo.getUserID();
        masterST.Name = 'Test PMG 1';
        insert masterST;
        
        NPD_Master__c  masterStrap= NPD_TestUtilityClass.getNPDMaster('Strap Material');
        masterStrap.SalesforceUser__c = UserInfo.getUserID();
        masterStrap.Name = 'Test PMG 1';
        insert masterStrap;
        
        NPD_Master__c  masterCase = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCase.SalesforceUser__c = UserInfo.getUserID();
        masterCase.Name = 'Test PMG 1';
        insert masterCase;
        
        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'demoAni';
        npdCollection.Collection_Name__c = 'demoAni';
        insert npdCollection;
        
        NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='50002';
        npdProject.Brand1__c = 'Titan';
        npdProject.Case_Material__c                  =    masterCase.ID;
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
		
		NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
		npdStage.NPD_Project_Name__c = npdProject.Id;
        npdStage.Brand1__c = 'Titan';
        npdStage.Planned_Start_Date__c  = System.Today();
        npdStage.Planned_End_Date__c = System.Today().addDays(3);
		npdStage.Actual_Start_Date__c = System.Today();
		npdStage.Actual_End_Date__c = System.Today();
		npdStage.Planned_Lead_Time__c = 3;
        insert npdStage;
		
		NPD_Stage__c npdStage1 = NPD_TestUtilityClass.getNPDStage('Concept Briefing to ISCM');
        npdStage1.NPD_Collections__c = npdCollection.Id;
		npdStage1.NPD_Project_Name__c = npdProject.Id;
        npdStage1.Brand1__c = 'Titan';
        npdStage1.Planned_Start_Date__c  = System.Today();
        npdStage1.Planned_End_Date__c = System.Today().addDays(3);
		npdStage1.Actual_Start_Date__c = System.Today();
		npdStage1.Actual_End_Date__c = System.Today();
		npdStage1.Planned_Lead_Time__c = 3;
        insert npdStage1;
		
		NPD_Stage__c npdStage2 = NPD_TestUtilityClass.getNPDStage('Proto Approval');
        npdStage2.NPD_Collections__c = npdCollection.Id;
		npdStage2.NPD_Project_Name__c = npdProject.Id;
        npdStage2.Brand1__c = 'Titan';
        npdStage2.Planned_Start_Date__c  = System.Today();
        npdStage2.Planned_End_Date__c = System.Today().addDays(3);
		npdStage2.Actual_Start_Date__c = System.Today();
		npdStage2.Actual_End_Date__c = System.Today();
		npdStage2.Planned_Lead_Time__c = 3;
        insert npdStage2;
		
		NPD_Stage__c npdStage3 = NPD_TestUtilityClass.getNPDStage('Watch BO Component Development');
        npdStage3.NPD_Collections__c = npdCollection.Id;
		npdStage3.NPD_Project_Name__c = npdProject.Id;
        npdStage3.Brand1__c = 'Titan';
        npdStage3.Planned_Start_Date__c  = System.Today();
        npdStage3.Planned_End_Date__c = System.Today().addDays(3);
		npdStage3.Actual_Start_Date__c = System.Today();
		npdStage3.Actual_End_Date__c = System.Today();
		npdStage3.Planned_Lead_Time__c = 3;
        insert npdStage3;
       
        NPD_Activity__c   activityConceptMake = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityConceptMake.name__c = 'Concept Design - IDS';
        activityConceptMake .NPD_Project_Name__c = npdProject.id;
        activityConceptMake.NPD_Collections__c = npdCollection.Id;
		activityConceptMake.Actual_Start_Date__c = System.Today();
        activityConceptMake.Actual_End_Date__c = System.Today();
		activityConceptMake.Planned_Lead_Time__c = 3;
        insert activityConceptMake;
		
		NPD_Activity__c   activityEngg = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityEngg.name__c = 'Engineering Design - IDS';
        activityEngg .NPD_Project_Name__c = npdProject.id;
        activityEngg.NPD_Collections__c = npdCollection.Id;
		activityEngg.Actual_Start_Date__c = System.Today();
        activityEngg.Actual_End_Date__c = System.Today();
		activityEngg.Planned_Lead_Time__c = 3;
        insert activityEngg;
		
		NPD_Activity__c   activityProto = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityProto.name__c = 'Proto Design Input';
        activityProto .NPD_Project_Name__c = npdProject.id;
        activityProto.NPD_Collections__c = npdCollection.Id;
		activityProto.Actual_Start_Date__c = System.Today();
        activityProto.Actual_End_Date__c = System.Today();
		activityProto.Planned_Lead_Time__c = 3;
        insert activityProto;
        
        NPD_Activity__c   activityCost = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityCost.name__c = 'Cost Estimation and Approval';
        activityCost .NPD_Project_Name__c = npdProject.id;
        activityCost.NPD_Collections__c = npdCollection.Id;
		activityCost.Actual_Start_Date__c = System.Today();
        activityCost.Actual_End_Date__c = System.Today();
		activityCost.Planned_Lead_Time__c = 3;
        insert activityCost;
        
        NPD_Activity__c   activityDesign = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign.name__c = 'Proto Design - Release';
        activityDesign .NPD_Project_Name__c = npdProject.id;
        activityDesign.NPD_Collections__c = npdCollection.Id;
		activityDesign.Actual_Start_Date__c = System.Today();
        activityDesign.Actual_End_Date__c = System.Today();
		activityDesign.Planned_Lead_Time__c = 3;
        insert activityDesign;
        
        NPD_Activity__c   activityManufct= NPD_TestUtilityClass.getNPDActivity('Activity');
        activityManufct.name__c = 'Proto Manufacturing & Assembly';
        activityManufct .NPD_Project_Name__c = npdProject.id;
        activityManufct.NPD_Collections__c = npdCollection.Id;
		activityManufct.Actual_Start_Date__c = System.Today();
        activityManufct.Actual_End_Date__c = System.Today();
		activityManufct.Planned_Lead_Time__c = 3;
        insert activityManufct;
        
        NPD_Activity__c   activityInput= NPD_TestUtilityClass.getNPDActivity('Activity');
        activityInput.name__c = 'Input - Final Product Design';
        activityInput .NPD_Project_Name__c = npdProject.id;
        activityInput.NPD_Collections__c = npdCollection.Id;
		activityInput.Actual_Start_Date__c = System.Today();
        activityInput.Actual_End_Date__c = System.Today();
		activityInput.Planned_Lead_Time__c = 3;
        insert activityInput;
        
        NPD_Activity__c   activityFinal= NPD_TestUtilityClass.getNPDActivity('Activity');
        activityFinal.name__c = 'Final Product Drawing Release';
        activityFinal .NPD_Project_Name__c = npdProject.id;
        activityFinal.NPD_Collections__c = npdCollection.Id;
		activityFinal.Actual_Start_Date__c = System.Today();
        activityFinal.Actual_End_Date__c = System.Today();
		activityFinal.Planned_Lead_Time__c = 3;
        insert activityFinal;
        
        NPD_Activity__c   activityWatch= NPD_TestUtilityClass.getNPDActivity('Activity');
        activityWatch.name__c = 'Watch Deposition';
        activityWatch .NPD_Project_Name__c = npdProject.id;
        activityWatch.NPD_Collections__c = npdCollection.Id;
		activityWatch.Actual_Start_Date__c = System.Today();
        activityWatch.Actual_End_Date__c = System.Today();
		activityWatch.Planned_Lead_Time__c = 3;
        insert activityWatch;
        
        NPD_Activity__c   activityProd = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityProd.name__c = 'Product Certification and Handing Over Note';
        activityProd .NPD_Project_Name__c = npdProject.id;
        activityProd.NPD_Collections__c = npdCollection.Id;
		activityProd.Actual_Start_Date__c = System.Today();
        activityProd.Actual_End_Date__c = System.Today();
		activityProd.Planned_Lead_Time__c = 3;
        insert activityProd;
        
        NPD_Activity__c   activityPlanned= NPD_TestUtilityClass.getNPDActivity('Activity');
        activityPlanned.name__c = 'Planned Order Loading';
        activityPlanned .NPD_Project_Name__c = npdProject.id;
        activityPlanned.NPD_Collections__c = npdCollection.Id;
		activityPlanned.Actual_Start_Date__c = System.Today();
        activityPlanned.Actual_End_Date__c = System.Today();
		activityPlanned.Planned_Lead_Time__c = 3;
        insert activityPlanned;
		
		NPD_Milestone_Report milestoneReport = new NPD_Milestone_Report  ();
        milestoneReport.selectedBrandName = 'Titan';
        milestoneReport.selectedCollectionName = 'demoAni';
        milestoneReport.selectedModelName = '50002';
        milestoneReport.toDate = null;
		milestoneReport.fromDate = null;
		milestoneReport.selectedYear = 'THIS_FISCAL_YEAR';
        milestoneReport.displayMilestoneTable();
        milestoneReport.selectBrand();
        milestoneReport.selectCollection();
        milestoneReport.selectModel();
        
		test.stopTest();
	}
}