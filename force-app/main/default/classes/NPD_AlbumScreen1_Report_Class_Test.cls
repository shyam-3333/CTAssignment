@isTest()
public class NPD_AlbumScreen1_Report_Class_Test {
    public static testMethod void testMethod1(){
        test.startTest();
        NPD_Collections__c npdCollection = NPD_TestUtilityClass.getCollections();
        npdCollection.Name = 'Test Exp Collections';
        npdCollection.Collection_Name__c = 'Test Exp Collections';
        npdCollection.MarketingBrand__c = 'Titan';
        insert npdCollection;
        
        
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
        
       // NPD_Checklist__c checklistConcept = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        //checklistConcept.PSY_No__c = 'PSY101';
       // insert checklistConcept;
        NPD_Checklist__c checklist = new NPD_Checklist__c();
        checklist.PSY_No__c = 'PSY101';
        checklist.Supply_Agency__c = 'Case Plant';
        insert checklist;

        
        NPD_AlbumScreen1_Report_Class AlbumReport = new NPD_AlbumScreen1_Report_Class ();
        AlbumReport.displayModel();
       
        test.stopTest();
    }
}