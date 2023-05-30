@isTest()
public class NPD_OverallNpStatus_Report_Class_Test {
    public static testMethod void testMethod1(){
        test.startTest();
        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'Test Exp Collections';
        npdCollection.Collection_Name__c = 'Test Exp Collections';
        npdCollection.MarketingBrand__c = 'Titan';
        insert npdCollection;
        
        NPD_Activity__c   activity9 = NPD_TestUtilityClass.getNPDActivity('Test');
        activity9.name__c = 'Pilot Lot Manufacturing - Press - Case Development - INH';
        activity9.NPD_Collections__c = npdCollection.Id;
        //activity9.NPD_Project_Name__c = npdProject2.Id;
        activity9.Planned_Lead_Time__c = 10;
        activity9.Actual_Start_Date__c = System.Today();
        activity9.Actual_End_Date__c = System.Today();
        insert activity9;
        
        NPD_Master__c  masterProduct = NPD_TestUtilityClass.getNPDMaster('Product Designer Name');
        masterProduct.SalesforceUser__c = UserInfo.getUserID();
        masterProduct.Name = 'Test PMG 1';
        insert masterProduct;
		
		NPD_Stage__c npdStage = NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        npdStage.NPD_Collections__c = npdCollection.Id;
        //npdStage.Brand1__c = 'ZOOP';
        npdStage.Approval_Submitted_Date__c  = System.Today();
        npdStage.Approved_Date__c = System.Today();
        insert npdStage;
		
		
		NPD_Checklist__c checklist = new NPD_Checklist__c();
        checklist.Supply_Agency__c = 'Case Plant';
        checklist.Case_Sourcing__c  = 'Make';
        checklist.NPD_Activity_Chklist__c  = activity9.Id;
        insert checklist;
		
		NPD_Checklist__c checklist2 = new NPD_Checklist__c();
        checklist2.Supply_Agency__c = 'INDG';
        checklist2.Case_Sourcing__c  = 'Buy';
        checklist2.NPD_Activity_Chklist__c  = activity9.Id;
        insert checklist2;
		
		NPD_Checklist__c checklist3 = new NPD_Checklist__c();
        checklist3.Supply_Agency__c = 'CBE Plant';
       checklist3.NPD_Activity_Chklist__c  = activity9.Id;
        insert checklist3;
		
		NPD_Checklist__c checklist4 = new NPD_Checklist__c();
        checklist4.Supply_Agency__c = 'Nebula Mfg';
       checklist4.NPD_Activity_Chklist__c  = activity9.Id;
        insert checklist4;
		
		NPD_Overall_NP_Status_Report  OverAllStatusReport = new NPD_Overall_NP_Status_Report ();
		OverAllStatusReport.selectedBrandName = 'All';
        OverAllStatusReport.selectedCollectionName = 'Test Exp Collections';
        OverAllStatusReport.totalCount();
		
		test.stopTest();
    }
}