@isTest()
public class NPD_Exception_ReportOrgnl_Test {
    public static testMethod void testMethod1(){
        test.startTest();
        NPD_Project_Template__c  npdProjTemplate = NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert NpdProjTemplate;
        
        NPD_Project_Items__c npdProjItem = NPD_TestUtilityClass.getProjItemForStage('testActName','Project',npdProjTemplate.Id);
        insert npdProjItem;
        
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
        npdCollection.Name = 'Test Exp Collections';
        npdCollection.Collection_Name__c = 'Test Exp Collections';
        npdCollection.MarketingBrand__c = 'Sonata';
        insert npdCollection;
        
        NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='Marketing Brief/Concept Stage';
        npdProject.Model_No__c =    '9282';
        npdProject.Case_Material__c                  =    masterCase.ID;
        npdProject.Strap_Type__c                     =    masterST.ID;
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Project_Type__c                   =    'test porject Type';    
        
        npdProject.Project_Complexity__c             =    'Medium';
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
        
        NPD_Activity__c  npdActivity = NPD_TestUtilityClass.getNPDActivity('Activity');
        npdActivity.Name__c = 'New Movement Certification';
        npdActivity.Status__c = 'Completed';
        npdActivity.Planned_Lead_Time__c = 7;
        npdActivity.Actual_End_Date__c = System.today();
        npdActivity.NPD_Project_Name__c = npdProject.Id;
        npdActivity.Active__c = true;
        npdActivity.NPD_Collections__c = npdCollection.Id;
        insert npdActivity;
        
        NPD_Activity__c  npdActivity2 = NPD_TestUtilityClass.getNPDActivity('Activity');
        npdActivity2.Name__c = 'New Movement Certification';
        npdActivity2.Status__c = 'In Progress';
        npdActivity2.Planned_Lead_Time__c = 7;
        npdActivity2.Actual_End_Date__c = System.today();
        npdActivity2.NPD_Project_Name__c = npdProject.Id;
        npdActivity2.Function_Name__c    =    'Sourcing';
        npdActivity2.Active__c = true;
        npdActivity2.NPD_Collections__c = npdCollection.Id;
        insert npdActivity2;
        
        NPD_Email__c npdEmail = new NPD_Email__c();
        npdEmail.NPD_Project_Items__c = npdProjItem.Id;
        npdEmail.Name = 'Proto Design Input';
        npdEmail.NPD_Activity__c = npdActivity.Id;
        npdEmail.Act_Name__c = 'New Movement Certification';
        npdEmail.Type__c = 'Successor';             
        insert npdEmail;
        NPD_Exception_Report_ControllerOriginal ExpReport = new NPD_Exception_Report_ControllerOriginal();
       // ExpReport.selectBrand();
        test.stopTest();
    }
    
    public static testMethod void testMethod2(){
        test.startTest();
        NPD_Project_Template__c  npdProjTemplate = NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert NpdProjTemplate;
        
        NPD_Project_Items__c npdProjItem = NPD_TestUtilityClass.getProjItemForStage('testActName','Project',npdProjTemplate.Id);
        insert npdProjItem;
        
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
        npdCollection.Name = 'Test Exp Collections';
        npdCollection.Collection_Name__c = 'Test Exp Collections';
        npdCollection.MarketingBrand__c = 'Sonata';
        insert npdCollection;
        
        NPD_Project_Name__c npdProject = new NPD_Project_Name__c();
        npdProject.NPD_Collections__c = npdCollection.Id;
        npdProject.Name='Marketing Brief/Concept Stage';
        npdProject.Model_No__c =    '9282';
        npdProject.Case_Material__c                  =    masterCase.ID;
        npdProject.Strap_Type__c                     =    masterST.ID;
        npdProject.Strap_Material__c                 =    masterStrap.ID;
        npdProject.Project_Type__c                   =    'test porject Type';    
        npdProject.Project_Status__c                 =    'Ongoing';
        npdProject.Project_Complexity__c             =    'Medium';
        npdProject.Strap_Source__c                   =    'IND';
        insert npdProject;
        
        NPD_Activity__c  npdActivity = NPD_TestUtilityClass.getNPDActivity('Activity');
        npdActivity.Name__c = 'testActName';
        npdActivity.Status__c = 'Completed';
        //npdActivity.Planned_Lead_Time__c = 7;
        npdActivity.Actual_End_Date__c = System.today();
        npdActivity.NPD_Project_Name__c = npdProject.Id;
        npdActivity.Active__c = true;
        npdActivity.NPD_Collections__c = npdCollection.Id;
        insert npdActivity;
        
        NPD_Activity__c  npdActivity2 = NPD_TestUtilityClass.getNPDActivity('Activity');
        npdActivity2.Name__c = 'testActName';
        npdActivity2.Status__c = 'In Progress';
        npdActivity2.Planned_Lead_Time__c = 7;
        npdActivity2.Actual_End_Date__c = System.today();
        npdActivity2.NPD_Project_Name__c = npdProject.Id;
        npdActivity2.Function_Name__c    =    'Sourcing';
        npdActivity2.Active__c = true;
        npdActivity2.NPD_Collections__c = npdCollection.Id;
        insert npdActivity2;
        
        NPD_Email__c npdEmail = new NPD_Email__c();
        npdEmail.NPD_Project_Items__c = npdProjItem.Id;
        npdEmail.Name = 'Proto Design Input';
        npdEmail.NPD_Activity__c = npdActivity2.Id;
        npdEmail.Act_Name__c = 'testActName';
        npdEmail.Type__c = 'Successor';             
        insert npdEmail;
        NPD_Exception_Report_ControllerOriginal ExpReport = new NPD_Exception_Report_ControllerOriginal();
       // ExpReport.selectBrand();
        test.stopTest();
    }

}