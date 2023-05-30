@isTest()
public class NPD_Collection_Report_Test{
    public static testMethod void testMethodTwo(){
        NPD_Master__c  masterBrand = NPD_TestUtilityClass.getNPDMaster('Brand');
        masterBrand.SalesforceUser__c = UserInfo.getUserID();
        masterBrand.Name = 'Test PMG 1';
        insert masterBrand;
        
        NPD_Master__c  masterProduct = NPD_TestUtilityClass.getNPDMaster('Product Designer Name');
        masterProduct.SalesforceUser__c = UserInfo.getUserID();
        masterProduct.Name = 'Test PMG 1';
        insert masterProduct;
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
        
         NPD_Project_Name__c npdProject = NPD_TestUtilityClass.getProjName(masterCase.Id, 'Marketing Brief/Concept Stage', masterCase.Id, 'Test Dev Route', masterST.Id,masterStrap.Id);
            npdProject.NPD_Collections__c = npdCollection.Id;
            insert npdProject;
       
        NPD_Activity__c   activityConceptMake = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityConceptMake.name__c = 'Make or Buy or Dual Decision';
        activityConceptMake.NPD_Collections__c = npdCollection.Id;
        activityConceptMake.Planned_Lead_Time__c = 10;
        activityConceptMake.Actual_Start_Date__c = System.Today();
        activityConceptMake.Actual_End_Date__c = System.Today();
        activityConceptMake.ISCM_Briefing_Date__c = System.Today();
        insert activityConceptMake;
        
        NPD_Activity__c   activityDial = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityDial.name__c = 'Dial blank release/proto drg release';
        activityDial.NPD_Collections__c = npdCollection.Id;
        activityDial.Planned_Lead_Time__c = 10;
        activityDial.NPD_Project_Name__c = npdProject.id;
        activityDial.Actual_Start_Date__c = System.Today();
        activityDial.Actual_End_Date__c = System.Today();
        activityDial.ISCM_Briefing_Date__c = System.Today();
        insert activityDial;
        
        NPD_Activity__c   activityDrawing = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityDrawing.name__c = '2D Drawing/3D Model Release/Approval';
        activityDrawing.NPD_Collections__c = npdCollection.Id;
        activityDrawing.NPD_Project_Name__c = npdProject.id;
        activityDrawing.Planned_Lead_Time__c = 10;
        activityDrawing.Actual_Start_Date__c = System.Today();
        activityDrawing.Actual_End_Date__c = System.Today();
        activityDrawing.ISCM_Briefing_Date__c = System.Today();
        insert activityDrawing;
        
         NPD_Activity__c   activityProtoDesign = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityProtoDesign.name__c = 'Proto Design - Release';
        activityProtoDesign.NPD_Collections__c = npdCollection.Id;
        activityProtoDesign.NPD_Project_Name__c = npdProject.id;
        activityProtoDesign.Planned_Lead_Time__c = 10;
        activityProtoDesign.Actual_Start_Date__c = System.Today();
        activityProtoDesign.Actual_End_Date__c = System.Today();
        activityProtoDesign.ISCM_Briefing_Date__c = System.Today();
        insert activityProtoDesign;
        
         NPD_Activity__c   activityProtoManufacturing = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityProtoManufacturing.name__c = 'Proto Manufacturing & Assembly';
        activityProtoManufacturing.NPD_Collections__c = npdCollection.Id;
        activityProtoManufacturing.NPD_Project_Name__c = npdProject.id;
        activityProtoManufacturing.Planned_Lead_Time__c = 10;
        activityProtoManufacturing.Actual_Start_Date__c = System.Today();
        activityProtoManufacturing.Actual_End_Date__c = System.Today();
        activityProtoManufacturing.ISCM_Briefing_Date__c = System.Today();
        insert activityProtoManufacturing;
        
        NPD_Activity__c   activityDrawingRelease = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityDrawingRelease.name__c = 'Final Product Drawing Release';
        activityDrawingRelease.NPD_Collections__c = npdCollection.Id;
        activityDrawingRelease.NPD_Project_Name__c = npdProject.id;
        activityDrawingRelease.Planned_Lead_Time__c = 10;
        activityDrawingRelease.Actual_Start_Date__c = System.Today();
        activityDrawingRelease.Actual_End_Date__c = System.Today();
        activityDrawingRelease.ISCM_Briefing_Date__c = System.Today();
        insert activityDrawingRelease;
        
          NPD_Activity__c   activityFinalRelease = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityFinalRelease.name__c = 'Input - Final Product Design';
        activityFinalRelease.NPD_Collections__c = npdCollection.Id;
        activityFinalRelease.NPD_Project_Name__c = npdProject.id;
        activityFinalRelease.Planned_Lead_Time__c = 10;
        activityFinalRelease.Actual_Start_Date__c = System.Today();
        activityFinalRelease.Actual_End_Date__c = System.Today();
        activityFinalRelease.ISCM_Briefing_Date__c = System.Today();
        insert activityFinalRelease;
        
           NPD_Activity__c   activityProtoMfg = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityProtoMfg.name__c = 'Dial for Proto Mfg';
        activityProtoMfg.NPD_Collections__c = npdCollection.Id;
        activityProtoMfg.NPD_Project_Name__c = npdProject.id;
        activityProtoMfg.Planned_Lead_Time__c = 10;
        activityProtoMfg.Actual_Start_Date__c = System.Today();
        activityProtoMfg.Actual_End_Date__c = System.Today();
        activityProtoMfg.ISCM_Briefing_Date__c = System.Today();
        insert activityProtoMfg;
        
           NPD_Activity__c   activityOrderLoading = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityOrderLoading.name__c = 'Planned Order Loading';
        activityOrderLoading.NPD_Collections__c = npdCollection.Id;
        activityOrderLoading.NPD_Project_Name__c = npdProject.id;
        activityOrderLoading.Planned_Lead_Time__c = 10;
        activityOrderLoading.Actual_Start_Date__c = System.Today();
        activityOrderLoading.Actual_End_Date__c = System.Today();
        activityOrderLoading.ISCM_Briefing_Date__c = System.Today();
        insert activityOrderLoading;
        
        NPD_Activity__c   activityWatchDeposition = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityWatchDeposition.name__c = 'Watch Deposition';
        activityWatchDeposition.NPD_Collections__c = npdCollection.Id;
        activityWatchDeposition.NPD_Project_Name__c = npdProject.id;
        activityWatchDeposition.Planned_Lead_Time__c = 10;
        activityWatchDeposition.Actual_Start_Date__c = System.Today();
        activityWatchDeposition.Actual_End_Date__c = System.Today();
        activityWatchDeposition.ISCM_Briefing_Date__c = System.Today();
        insert activityWatchDeposition;
                
        NPD_Activity__c   activityConcept = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityConcept.name__c = 'Concept Presentation to PMG - IDS';
        activityConcept.NPD_Collections__c = npdCollection.Id;
        activityConcept.Planned_Lead_Time__c = 10;
        activityConcept.Actual_Start_Date__c = System.Today();
        activityConcept.Actual_End_Date__c = System.Today();
        activityConcept.ISCM_Briefing_Date__c = System.Today();
        insert activityConcept;
        
        
        NPD_Activity__c   activityDesign = NPD_TestUtilityClass.getNPDActivity('Sub-Activity');
        activityDesign.name__c = 'Engineering Design - IDS';
        activityDesign.NPD_Collections__c = npdCollection.Id;
        insert activityDesign;

        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
        activityDial.NPD_Project_Name__c = npdProject.id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
          NPD_Stage__c npdStage1 = NPD_TestUtilityClass.getNPDStage('Watch BO Component Development');
        npdStage1.NPD_Collections__c = npdCollection.Id;
        npdStage1.NPD_Project_Name__c = npdProject.id;
        npdStage1.Brand1__c = 'ZOOP';
        npdStage1.Approval_Submitted_Date__c  = System.Today();
        npdStage1.Approved_Date__c = System.Today();
        insert npdStage1;
        
         //Setup for DESIGN     
       NPD_Checklist__c checklistConcept = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklistConcept.NPD_Activity_Chklist__c = activityDial.Id;
        checklistConcept.Design_No__c = 'Test Concept Number';
        checklistConcept.Product_Designer_Name__c = masterProduct.Id;
        insert checklistConcept;
        
        NPD_Checklist__c checklistDesign = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklistDesign.NPD_Activity_Chklist__c = activityDial.Id;
        checklistDesign.Design_No__c = 'Test Design Number';
        checklistDesign.Product_Designer_Name__c = masterProduct.Id;
        
        insert checklistDesign;
        
       //Setting of report type = UpStream
       NPD_Collection_Report npdCollectionReportUpStream = new NPD_Collection_Report();
 /*     npdCollectionReportUpStream .SelectedType = 'Design';
       npdCollectionReportUpStream.selectedType();
       npdCollectionReportUpStream.selectCollection(); 
       npdCollectionReportUpStream.selectedCollectionName = 'Test Collections';
       npdCollectionReportUpStream.displayTable();
               npdCollectionReportUpStream.selectCollection(); 
        npdCollectionReportUpStream.selectedType();
        npdCollectionReportUpStream.selectCollection(); 
        npdCollectionReportUpStream.displayTable();
        
        npdCollectionReportUpStream.selectedCollectionName = 'All';
        npdCollectionReportUpStream.displayTable();  */
        
        npdCollectionReportUpStream.selectedType = 'Design';
        npdCollectionReportUpStream.selectedCollectionType = 'ALL';
        npdCollectionReportUpStream.selectedBrandName = 'ZOOP';
        npdCollectionReportUpStream.selectedFiscalYear = 'THIS_FISCAL_YEAR';
        npdCollectionReportUpStream.npdDesignManagerName = 'Test PMG 1';
        npdCollectionReportUpStream.selectedCollectionName = 'Test Collections';
        
        npdCollectionReportUpStream.selectedType();
        npdCollectionReportUpStream.selectCollection(); 
        npdCollectionReportUpStream.displayTable();
        
        npdCollectionReportUpStream.selectedCollectionName = 'All';
        npdCollectionReportUpStream.displayTable();
        npdCollectionReportUpStream.newcollectionReportExc();
        npdCollectionReportUpStream.ClickToDownload();
    }
    public static testMethod void testMethoOne(){
        
        NPD_Master__c  masterBrand = NPD_TestUtilityClass.getNPDMaster('Brand');
        masterBrand.SalesforceUser__c = UserInfo.getUserID();
        masterBrand.Name = 'Test PMG 1';
        insert masterBrand;
        
        NPD_Master__c  masterProduct = NPD_TestUtilityClass.getNPDMaster('Product Designer Name');
        masterProduct.SalesforceUser__c = UserInfo.getUserID();
        masterProduct.Name = 'Test PMG 1';
        insert masterProduct;
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
            npdProject.Name='Marketing Brief/Concept Stage';
            npdProject.Model_No__c =    '6232';
            npdProject.Case_Material__c                  =    masterCase.ID;
            npdProject.Strap_Type__c                     =    masterST.ID;
            npdProject.Strap_Material__c                 =    masterStrap.ID;
            npdProject.Project_Type__c                   =    'porject Type';    
            npdProject.Movement_Function__c              =    'Gents';
            npdProject.Project_Complexity__c             =    'Medium';
            npdProject.Strap_Source__c                   =    'IND';
            insert npdProject;
        
    
        NPD_Activity__c   activityConceptMake = NPD_TestUtilityClass.getNPDActivity('Test');
        activityConceptMake.name__c = 'Make or Buy or Dual Decision';
        activityConceptMake.NPD_Collections__c = npdCollection.Id;
        activityConceptMake.Planned_Lead_Time__c = 10;
        activityConceptMake.Actual_Start_Date__c = System.Today();
        activityConceptMake.Actual_End_Date__c = System.Today();
        activityConceptMake.ISCM_Briefing_Date__c = System.Today();
        insert activityConceptMake;
        
        NPD_Activity__c   activityDial = NPD_TestUtilityClass.getNPDActivity('Test');
        activityDial.name__c = 'Dial blank release/proto drg release';
        activityDial.NPD_Collections__c = npdCollection.Id;
        activityDial.Planned_Lead_Time__c = 10;
        activityDial.Actual_Start_Date__c = System.Today();
        activityDial.Actual_End_Date__c = System.Today();
        activityDial.ISCM_Briefing_Date__c = System.Today();
        insert activityDial;
        
        NPD_Activity__c   activityDrawing = NPD_TestUtilityClass.getNPDActivity('Test');
        activityDrawing.name__c = '2D Drawing/3D Model Release/Approval';
        activityDrawing.NPD_Collections__c = npdCollection.Id;
        activityDrawing.Planned_Lead_Time__c = 10;
        activityDrawing.Actual_Start_Date__c = System.Today();
        activityDrawing.Actual_End_Date__c = System.Today();
        activityDrawing.ISCM_Briefing_Date__c = System.Today();
        insert activityDrawing;
        
        NPD_Activity__c   activityConcept = NPD_TestUtilityClass.getNPDActivity('Test');
        activityConcept.name__c = 'Concept Presentation to PMG - IDS';
        activityConcept.NPD_Collections__c = npdCollection.Id;
        activityConcept.Planned_Lead_Time__c = 10;
        activityConcept.Actual_Start_Date__c = System.Today();
        activityConcept.Actual_End_Date__c = System.Today();
        activityConcept.ISCM_Briefing_Date__c = System.Today();
        insert activityConcept;
        
        NPD_Activity__c   activityConceptDesign = NPD_TestUtilityClass.getNPDActivity('Test');
        activityConceptDesign.name__c = 'Concept Design - IDS';
        activityConceptDesign.NPD_Collections__c = npdCollection.Id;
        activityConceptDesign.Planned_Lead_Time__c = 10;
        activityConceptDesign.Actual_Start_Date__c = System.Today();
        activityConceptDesign.Actual_End_Date__c = System.Today();
        activityConceptDesign.ISCM_Briefing_Date__c = System.Today();
        insert activityConceptDesign;
        
        
        NPD_Activity__c   activityDesign = NPD_TestUtilityClass.getNPDActivity('Test');
        activityDesign.name__c = 'Engineering Design - IDS';
        activityDesign.NPD_Collections__c = npdCollection.Id;
        insert activityDesign;
        
        NPD_Checklist__c checklistConcept = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklistConcept.NPD_Activity_Chklist__c = activityConcept.Id;
        checklistConcept.Design_No__c = 'Test Concept Number';
        checklistConcept.Product_Designer_Name__c = masterProduct.Id;
        insert checklistConcept;
        
        NPD_Checklist__c checklistDesign = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklistDesign.NPD_Activity_Chklist__c = activityDesign.Id;
        checklistDesign.Design_No__c = 'Test Design Number';
        checklistDesign.Product_Designer_Name__c = masterProduct.Id;
        insert checklistDesign;
        
        
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
                activityDial.NPD_Project_Name__c = npdProject.id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        //Setting of report type = UpStream
        NPD_Collection_Report npdCollectionReportUpStream = new NPD_Collection_Report();
        
        npdCollectionReportUpStream.selectedType = 'Upstream';
        npdCollectionReportUpStream.selectedCollectionType = 'ALL';
        npdCollectionReportUpStream.selectedBrandName = 'ZOOP';
        npdCollectionReportUpStream.selectedFiscalYear = 'THIS_FISCAL_YEAR';
        npdCollectionReportUpStream.npdDesignManagerName = 'Test PMG 1';
        npdCollectionReportUpStream.selectedCollectionName = 'Test Collections';
        
        npdCollectionReportUpStream.selectedType();
        npdCollectionReportUpStream.selectCollection(); 
        npdCollectionReportUpStream.displayTable();
        
        npdCollectionReportUpStream.selectedCollectionName = 'All';
        npdCollectionReportUpStream.displayTable();
       
      
    }
    public static testMethod void testMethothree(){
                NPD_Collection_Report npdCollectionReportUpStream = new NPD_Collection_Report();
                npdCollectionReportUpStream.selectedFiscalYear = 'THIS_FISCAL_YEAR'; 
                npdCollectionReportUpStream.selectedFiscalYear = 'LAST_N_FISCAL_YEARS:1';        
                npdCollectionReportUpStream.selectedFiscalYear = 'LAST_N_FISCAL_YEARS:2';        
                npdCollectionReportUpStream.selectedFiscalYear = 'LAST_N_FISCAL_YEARS:3';
                npdCollectionReportUpStream.selectedFiscalYear = 'NEXT_N_FISCAL_YEARS:1';          
                npdCollectionReportUpStream.selectedFiscalYear = 'NEXT_N_FISCAL_YEARS:2';          
                npdCollectionReportUpStream.selectedFiscalYear = 'NEXT_N_FISCAL_YEARS:3';          

                npdCollectionReportUpStream.selectCollection();  
    }
}//end of test class.