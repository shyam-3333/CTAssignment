@isTest()
public class NPD_CaseDevelopmentINH_Report_Class_Test {
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
    
    NPD_Activity__c   activity2 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity2.name__c = 'CFT Scheduling - Case Development - INH';
        activity2.NPD_Collections__c = npdCollection.Id;
        activity2.NPD_Project_Name__c = npdProject2.Id;
        activity2.Planned_Lead_Time__c = 10;
        activity2.Actual_Start_Date__c = System.Today();
        activity2.Actual_End_Date__c = System.Today();
        insert activity2;
    
    NPD_Activity__c   activity3 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity3.name__c = 'Press Tool Drawing Release - Case Development - INH';
        activity3.NPD_Collections__c = npdCollection.Id;
        activity3.NPD_Project_Name__c = npdProject2.Id;
        activity3.Planned_Lead_Time__c = 10;
        activity3.Actual_Start_Date__c = System.Today();
        activity3.Actual_End_Date__c = System.Today();
        insert activity3;
    
    NPD_Activity__c   activity4 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity4.name__c = 'Press Tool Drawing Release - Case Development - INH';
        activity4.NPD_Collections__c = npdCollection.Id;
        activity4.NPD_Project_Name__c = npdProject2.Id;
        activity4.Planned_Lead_Time__c = 10;
        activity4.Actual_Start_Date__c = System.Today();
        activity4.Actual_End_Date__c = System.Today();
        insert activity4;
    
    NPD_Activity__c   activity5 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity5.name__c = 'Alternate option - Press Tool Drawing Release';
        activity5.NPD_Collections__c = npdCollection.Id;
        activity5.NPD_Project_Name__c = npdProject2.Id;
        activity5.Planned_Lead_Time__c = 10;
        activity5.Actual_Start_Date__c = System.Today();
        activity5.Actual_End_Date__c = System.Today();
        insert activity5;
    
    NPD_Activity__c   activity6 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity6.name__c = 'IMP Press Blank - Press Tool Drawing Release';
        activity6.NPD_Collections__c = npdCollection.Id;
        activity6.NPD_Project_Name__c = npdProject2.Id;
        activity6.Planned_Lead_Time__c = 10;
        activity6.Actual_Start_Date__c = System.Today();
        activity6.Actual_End_Date__c = System.Today();
        insert activity6;
    
    NPD_Activity__c   activity7 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity7.name__c = 'Press Tool Delivery - Case Development - INH';
        activity7.NPD_Collections__c = npdCollection.Id;
        activity7.NPD_Project_Name__c = npdProject2.Id;
        activity7.Planned_Lead_Time__c = 10;
        activity7.Actual_Start_Date__c = System.Today();
        activity7.Actual_End_Date__c = System.Today();
        insert activity7;
    
    NPD_Activity__c   activity8 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity8.name__c = 'Press Blank Trials - Case Development - INH';
        activity8.NPD_Collections__c = npdCollection.Id;
        activity8.NPD_Project_Name__c = npdProject2.Id;
        activity8.Planned_Lead_Time__c = 10;
        activity8.Actual_Start_Date__c = System.Today();
        activity8.Actual_End_Date__c = System.Today();
        insert activity8;
    
    NPD_Activity__c   activity9 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity9.name__c = 'Pilot Lot Manufacturing - Press - Case Development - INH';
        activity9.NPD_Collections__c = npdCollection.Id;
        activity9.NPD_Project_Name__c = npdProject2.Id;
        activity9.Planned_Lead_Time__c = 10;
        activity9.Actual_Start_Date__c = System.Today();
        activity9.Actual_End_Date__c = System.Today();
        insert activity9;
    
    NPD_Activity__c   activity10 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity10.name__c = 'Pilot Lot Manufacturing - Machining - Case Development - INH';
        activity10.NPD_Collections__c = npdCollection.Id;
        activity10.NPD_Project_Name__c = npdProject2.Id;
        activity10.Planned_Lead_Time__c = 10;
        activity10.Actual_Start_Date__c = System.Today();
        activity10.Actual_End_Date__c = System.Today();
        insert activity10;
    
    NPD_Activity__c   activity11 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity11.name__c = 'Pilot Lot Manufacturing - Polishing - Case Development - INH';
        activity11.NPD_Collections__c = npdCollection.Id;
        activity11.NPD_Project_Name__c = npdProject2.Id;
        activity11.Planned_Lead_Time__c = 10;
        activity11.Actual_Start_Date__c = System.Today();
        activity11.Actual_End_Date__c = System.Today();
        insert activity11;
    
    NPD_Activity__c   activity12 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity12.name__c = 'Pilot Lot Manufacturing -Plating - Case Development - INH';
        activity12.NPD_Collections__c = npdCollection.Id;
        activity12.NPD_Project_Name__c = npdProject2.Id;
        activity12.Planned_Lead_Time__c = 10;
        activity12.Actual_Start_Date__c = System.Today();
        activity12.Actual_End_Date__c = System.Today();
        insert activity12;
    
    NPD_Activity__c   activity13 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity13.name__c = 'Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly';
        activity13.NPD_Collections__c = npdCollection.Id;
        activity13.NPD_Project_Name__c = npdProject2.Id;
        activity13.Planned_Lead_Time__c = 10;
        activity13.Actual_Start_Date__c = System.Today();
        activity13.Actual_End_Date__c = System.Today();
        insert activity13;
    
    NPD_Activity__c   activity14 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity14.name__c = 'Pilot Lot Manufacturing - Case Assembly - Case Development - INH';
        activity14.NPD_Collections__c = npdCollection.Id;
        activity14.NPD_Project_Name__c = npdProject2.Id;
        activity14.Planned_Lead_Time__c = 10;
        activity14.Actual_Start_Date__c = System.Today();
        activity14.Actual_End_Date__c = System.Today();
        insert activity14;
    
    NPD_Activity__c   activity15 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity15.name__c = 'Press Blank Trials - Case Development - INH';
        activity15.NPD_Collections__c = npdCollection.Id;
        activity15.NPD_Project_Name__c = npdProject2.Id;
        activity15.Planned_Lead_Time__c = 10;
        activity15.Actual_Start_Date__c = System.Today();
        activity15.Actual_End_Date__c = System.Today();
        insert activity15;
         
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Product Design');
        npdStage.NPD_Collections__c = npdCollection.Id;
		npdStage.NPD_Project_Name__c = npdProject2.Id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        
        NPD_Case_Devel_INH_Report  CaseDevelReport = new NPD_Case_Devel_INH_Report ();
        CaseDevelReport.selectedBrandName = 'ZOOP';
        CaseDevelReport.selectedModelName = '9876';
		CaseDevelReport.selectedFunctionName = 'All';
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
    
    NPD_Activity__c   activity2 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity2.name__c = 'CFT Scheduling - Case Development - INH';
        activity2.NPD_Collections__c = npdCollection.Id;
        activity2.NPD_Project_Name__c = npdProject2.Id;
        activity2.Planned_Lead_Time__c = 10;
        activity2.Actual_Start_Date__c = System.Today();
        activity2.Actual_End_Date__c = System.Today();
        insert activity2;
    
    NPD_Activity__c   activity3 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity3.name__c = 'Press Tool Drawing Release - Case Development - INH';
        activity3.NPD_Collections__c = npdCollection.Id;
        activity3.NPD_Project_Name__c = npdProject2.Id;
        activity3.Planned_Lead_Time__c = 10;
        activity3.Actual_Start_Date__c = System.Today();
        activity3.Actual_End_Date__c = System.Today();
        insert activity3;
    
    NPD_Activity__c   activity4 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity4.name__c = 'Press Tool Drawing Release - Case Development - INH';
        activity4.NPD_Collections__c = npdCollection.Id;
        activity4.NPD_Project_Name__c = npdProject2.Id;
        activity4.Planned_Lead_Time__c = 10;
        activity4.Actual_Start_Date__c = System.Today();
        activity4.Actual_End_Date__c = System.Today();
        insert activity4;
    
    NPD_Activity__c   activity5 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity5.name__c = 'Alternate option - Press Tool Drawing Release';
        activity5.NPD_Collections__c = npdCollection.Id;
        activity5.NPD_Project_Name__c = npdProject2.Id;
        activity5.Planned_Lead_Time__c = 10;
        activity5.Actual_Start_Date__c = System.Today();
        activity5.Actual_End_Date__c = System.Today();
        insert activity5;
    
    NPD_Activity__c   activity6 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity6.name__c = 'IMP Press Blank - Press Tool Drawing Release';
        activity6.NPD_Collections__c = npdCollection.Id;
        activity6.NPD_Project_Name__c = npdProject2.Id;
        activity6.Planned_Lead_Time__c = 10;
        activity6.Actual_Start_Date__c = System.Today();
        activity6.Actual_End_Date__c = System.Today();
        insert activity6;
    
    NPD_Activity__c   activity7 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity7.name__c = 'Press Tool Delivery - Case Development - INH';
        activity7.NPD_Collections__c = npdCollection.Id;
        activity7.NPD_Project_Name__c = npdProject2.Id;
        activity7.Planned_Lead_Time__c = 10;
        activity7.Actual_Start_Date__c = System.Today();
        activity7.Actual_End_Date__c = System.Today();
        insert activity7;
    
    NPD_Activity__c   activity8 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity8.name__c = 'Press Blank Trials - Case Development - INH';
        activity8.NPD_Collections__c = npdCollection.Id;
        activity8.NPD_Project_Name__c = npdProject2.Id;
        activity8.Planned_Lead_Time__c = 10;
        activity8.Actual_Start_Date__c = System.Today();
        activity8.Actual_End_Date__c = System.Today();
        insert activity8;
    
    NPD_Activity__c   activity9 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity9.name__c = 'Pilot Lot Manufacturing - Press - Case Development - INH';
        activity9.NPD_Collections__c = npdCollection.Id;
        activity9.NPD_Project_Name__c = npdProject2.Id;
        activity9.Planned_Lead_Time__c = 10;
        activity9.Actual_Start_Date__c = System.Today();
        activity9.Actual_End_Date__c = System.Today();
        insert activity9;
    
    NPD_Activity__c   activity10 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity10.name__c = 'Pilot Lot Manufacturing - Machining - Case Development - INH';
        activity10.NPD_Collections__c = npdCollection.Id;
        activity10.NPD_Project_Name__c = npdProject2.Id;
        activity10.Planned_Lead_Time__c = 10;
        activity10.Actual_Start_Date__c = System.Today();
        activity10.Actual_End_Date__c = System.Today();
        insert activity10;
    
    NPD_Activity__c   activity11 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity11.name__c = 'Pilot Lot Manufacturing - Polishing - Case Development - INH';
        activity11.NPD_Collections__c = npdCollection.Id;
        activity11.NPD_Project_Name__c = npdProject2.Id;
        activity11.Planned_Lead_Time__c = 10;
        activity11.Actual_Start_Date__c = System.Today();
        activity11.Actual_End_Date__c = System.Today();
        insert activity11;
    
    NPD_Activity__c   activity12 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity12.name__c = 'Pilot Lot Manufacturing -Plating - Case Development - INH';
        activity12.NPD_Collections__c = npdCollection.Id;
        activity12.NPD_Project_Name__c = npdProject2.Id;
        activity12.Planned_Lead_Time__c = 10;
        activity12.Actual_Start_Date__c = System.Today();
        activity12.Actual_End_Date__c = System.Today();
        insert activity12;
    
    NPD_Activity__c   activity13 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity13.name__c = 'Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly';
        activity13.NPD_Collections__c = npdCollection.Id;
        activity13.NPD_Project_Name__c = npdProject2.Id;
        activity13.Planned_Lead_Time__c = 10;
        activity13.Actual_Start_Date__c = System.Today();
        activity13.Actual_End_Date__c = System.Today();
        insert activity13;
    
    NPD_Activity__c   activity14 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity14.name__c = 'Pilot Lot Manufacturing - Case Assembly - Case Development - INH';
        activity14.NPD_Collections__c = npdCollection.Id;
        activity14.NPD_Project_Name__c = npdProject2.Id;
        activity14.Planned_Lead_Time__c = 10;
        activity14.Actual_Start_Date__c = System.Today();
        activity14.Actual_End_Date__c = System.Today();
        insert activity14;
    
    NPD_Activity__c   activity15 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity15.name__c = 'Press Blank Trials - Case Development - INH';
        activity15.NPD_Collections__c = npdCollection.Id;
        activity15.NPD_Project_Name__c = npdProject2.Id;
        activity15.Planned_Lead_Time__c = 10;
        activity15.Actual_Start_Date__c = System.Today();
        activity15.Actual_End_Date__c = System.Today();
        insert activity15;
         
        NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Product Design');
        npdStage.NPD_Collections__c = npdCollection.Id;
		npdStage.NPD_Project_Name__c = npdProject2.Id;
        npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
        
        
        NPD_Case_Devel_INH_Report  CaseDevelReport = new NPD_Case_Devel_INH_Report ();
        CaseDevelReport.selectedBrandName = 'ZOOP';
        CaseDevelReport.selectedModelName = '9876';
		CaseDevelReport.selectedFunctionName = 'Press Blank Trials - Case Development - INH';
        CaseDevelReport.selectedCollectionName = 'Test Exp Collections';
        CaseDevelReport.displayTable();
       
        test.stopTest();
     }
}