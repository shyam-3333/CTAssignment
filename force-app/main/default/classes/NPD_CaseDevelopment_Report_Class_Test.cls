@isTest()
public class NPD_CaseDevelopment_Report_Class_Test {
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
        

        NPD_Activity__c   activity = NPD_TestUtilityClass.getNPDActivity('Test');
        activity.name__c = 'Final Product Drawing Release';
        activity.NPD_Collections__c = npdCollection.Id;
        activity.NPD_Project_Name__c = npdProject2.Id;
        activity.Planned_Lead_Time__c = 10;
        activity.Actual_Start_Date__c = System.Today();
        activity.Actual_End_Date__c = System.Today();
        insert activity;
         
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Product Design');
        npdStage.NPD_Collections__c = npdCollection.Id;
        npdStage.NPD_Project_Name__c = npdProject2.Id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        
        NPD_Case_Dev_ProductDesign_Report CaseDevelReport = new NPD_Case_Dev_ProductDesign_Report();
        CaseDevelReport.selectedBrandName = 'ZOOP';
        CaseDevelReport.selectedModelName = '9876';
        CaseDevelReport.selectedCollectionName = 'Test Exp Collections';
        CaseDevelReport.displayTable();
       
        test.stopTest();
    }
    public static testMethod void testMethod2(){
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
        

        NPD_Activity__c   activity = NPD_TestUtilityClass.getNPDActivity('Test');
        activity.name__c = 'Final Product Drawing Release';
        activity.NPD_Collections__c = npdCollection.Id;
        activity.NPD_Project_Name__c = npdProject2.Id;
        activity.Planned_Lead_Time__c = 10;
        activity.Actual_Start_Date__c = System.Today();
        activity.Actual_End_Date__c = System.Today();
        insert activity;
         
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Product Design');
        npdStage.NPD_Collections__c = npdCollection.Id;
        npdStage.NPD_Project_Name__c = npdProject2.Id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        
        NPD_Case_Dev_ProductDesign_Report CaseDevelReport = new NPD_Case_Dev_ProductDesign_Report();
        CaseDevelReport.selectedBrandName = 'ZOOP';
        CaseDevelReport.selectedModelName = 'All';
        CaseDevelReport.selectedCollectionName = 'All';
        CaseDevelReport.displayTable();
       
        test.stopTest();
    }
}