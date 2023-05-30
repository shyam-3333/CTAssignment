/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/27/2019   T01    Test Class fix 
*/
@isTest()
public class NPD_Prototype_Tracking_Report_Test{
    public static testMethod void testMethodTwo(){
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
        npdCollection.Name = 'Test Collections';
        npdCollection.Collection_Name__c = 'Test Collections';
        insert npdCollection;
        
         NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='9876';
        npdProject.Brand1__c = 'Titan';
        npdProject.Case_Material__c                  =    masterCase.ID;
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
       
        NPD_Activity__c   activityConceptMake = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityConceptMake.name__c = 'Proto Design Input';
        activityConceptMake .NPD_Project_Name__c = npdProject.id;
        activityConceptMake.NPD_Collections__c = npdCollection.Id;
        activityConceptMake.Actual_End_Date__c = System.Today();
        insert activityConceptMake;
        
        NPD_Activity__c   activityDial = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDial.name__c = 'Proto Tech.Drawing Release Request';
        activityDial.NPD_Collections__c = npdCollection.Id;
        activityDial.NPD_Project_Name__c = npdProject.id; 
        activityDial.Actual_End_Date__c = System.Today();
        insert activityDial;
        
        NPD_Activity__c   activityDrawing = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDrawing.name__c = 'Proto Design - Release';
        activityDrawing.NPD_Collections__c = npdCollection.Id;
        activityDrawing.NPD_Project_Name__c = npdProject.id;
        activityDrawing.Actual_End_Date__c = System.Today();
        insert activityDrawing;
        
         NPD_Activity__c   activityProtoDesign = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityProtoDesign.name__c = 'Proto Case Assembly Request';
        activityProtoDesign.NPD_Collections__c = npdCollection.Id;
        activityProtoDesign.NPD_Project_Name__c = npdProject.id;
        activityProtoDesign.Actual_End_Date__c = System.Today();
        insert activityProtoDesign;
        
         NPD_Activity__c   activityProtoManufacturing = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityProtoManufacturing.name__c = 'Proto Manufacturing & Assembly';
        activityProtoManufacturing.NPD_Collections__c = npdCollection.Id;
        activityProtoManufacturing.NPD_Project_Name__c = npdProject.id;
        activityProtoManufacturing.Actual_End_Date__c = System.Today();
        insert activityProtoManufacturing;
        
        NPD_Activity__c   activityDrawingRelease = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDrawingRelease.name__c = 'Proto Dial Request';
        activityDrawingRelease.NPD_Collections__c = npdCollection.Id;
        activityDrawingRelease.NPD_Project_Name__c = npdProject.id;
        activityDrawingRelease.Actual_End_Date__c = System.Today();
        insert activityDrawingRelease;
        
          NPD_Activity__c   activityFinalRelease = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityFinalRelease.name__c = 'Proto Hand Request';
        activityFinalRelease.NPD_Collections__c = npdCollection.Id;
        activityFinalRelease.NPD_Project_Name__c = npdProject.id;
        activityFinalRelease.Actual_End_Date__c = System.Today();
        insert activityFinalRelease;
        
           NPD_Activity__c   activityProtoMfg = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityProtoMfg.name__c = 'Dial for Proto Mfg';
        activityProtoMfg.NPD_Collections__c = npdCollection.Id;
        activityProtoMfg.NPD_Project_Name__c = npdProject.id;
        activityProtoMfg.Actual_End_Date__c = System.Today();
        insert activityProtoMfg;
        
        NPD_Activity__c   activityOrderLoading = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityOrderLoading.name__c = 'Hands for Proto Mfg';
        activityOrderLoading.NPD_Collections__c = npdCollection.Id;
        activityOrderLoading.NPD_Project_Name__c = npdProject.id;
        activityOrderLoading.Actual_End_Date__c = System.Today();
        insert activityOrderLoading;
        
        NPD_Activity__c   activityWatchDeposition = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityWatchDeposition.name__c = 'Proto Leather Strap Request';
        activityWatchDeposition.NPD_Collections__c = npdCollection.Id;
        activityWatchDeposition.NPD_Project_Name__c = npdProject.id;
        activityWatchDeposition.Actual_End_Date__c = System.Today();
		insert activityWatchDeposition;
                
        NPD_Activity__c   activityConcept = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityConcept.name__c = 'Leather Strap For Proto Mfg';
        activityConcept.NPD_Collections__c = npdCollection.Id;
        activityConcept.NPD_Project_Name__c = npdProject.id;
        activityConcept.Actual_End_Date__c = System.Today(); 
        insert activityConcept;
        
        
        NPD_Activity__c   activityDesign = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign.name__c = 'Proto Metalstrap Request';
        activityDesign.NPD_Project_Name__c = npdProject.id;
        activityDesign.NPD_Collections__c = npdCollection.Id;
        activityDesign.Actual_End_Date__c = System.Today();
        insert activityDesign;
        
        NPD_Activity__c   activityDesign1 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign1.name__c = 'Metal Strap for Proto Mfg';
        activityDesign1 .NPD_Project_Name__c = npdProject.id;
        activityDesign1.NPD_Collections__c = npdCollection.Id;
        activityDesign1 .Actual_End_Date__c = System.Today();
        insert activityDesign1;
        
        NPD_Activity__c   activityDesign2 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign2.name__c = 'Proto Crown Request';
        activityDesign2.NPD_Project_Name__c = npdProject.id;
        activityDesign2.NPD_Collections__c = npdCollection.Id;
        activityDesign2.Actual_End_Date__c = System.Today();
        insert activityDesign2;
        
        NPD_Activity__c   activityDesign3 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign3.name__c = 'Crown for Proto Mfg';
        activityDesign3.NPD_Project_Name__c = npdProject.id;
        activityDesign3.NPD_Collections__c = npdCollection.Id;
        activityDesign3.Actual_End_Date__c = System.Today();
        insert activityDesign3;
        
        NPD_Activity__c   activityDesign4 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign4.name__c = 'Proto WH/FW Request';
        activityDesign4.NPD_Project_Name__c = npdProject.id;
        activityDesign4.NPD_Collections__c = npdCollection.Id;
        activityDesign4.Actual_End_Date__c = System.Today();
        insert activityDesign4;
        
        NPD_Activity__c   activityDesign5 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign5.name__c = 'Proto - WH/FW/WH+Strap';
        activityDesign5.NPD_Project_Name__c = npdProject.id;
        activityDesign5.NPD_Collections__c = npdCollection.Id;
        activityDesign5.Actual_End_Date__c = System.Today();
        insert activityDesign5;
        

        NPD_Activity__c   activityDesign6 = NPD_TestUtilityClass.getNPDActivity('Activity');
        activityDesign6.name__c = 'Proto Submission by D&D for Approval';
        activityDesign6.NPD_Project_Name__c = npdProject.id;
        activityDesign6.NPD_Collections__c = npdCollection.Id;
        activityDesign6.Actual_Start_Date__c = (System.Today()-2);//<T01> Validation rule AED can't be lesser than ASD
        insert activityDesign6;


        test.startTest(); 
        
       //Setting of report type = Proto In-Progress
       NPD_Prototype_Tracking_Report npdPrototypeReportInProgress = new NPD_Prototype_Tracking_Report();
        npdPrototypeReportInProgress.selectedType = 'Proto In-Progress';
        npdPrototypeReportInProgress.selectedBrandName = 'Titan';
        npdPrototypeReportInProgress.selectedYear = 'THIS_FISCAL_YEAR';
        npdPrototypeReportInProgress.selectedCollectionName = 'Test Collections';
        
        npdPrototypeReportInProgress.selectedType();
        npdPrototypeReportInProgress.selectCollection(); 
        npdPrototypeReportInProgress.displayTable();
        
        npdPrototypeReportInProgress.selectedCollectionName = 'All';
        npdPrototypeReportInProgress.displayTable();
        
        test.stopTest();
    }
}