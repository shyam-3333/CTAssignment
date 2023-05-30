@isTest
public class QCMTLComponentTriggerTestClass {
    @isTest
    public static void method1(){
        User testuser = [select name, Id  FROM user LIMIT 1];
        //List<QCMTLComponentTrigger__c> listTriggerTest = New List<QCMTLComponentTrigger__c>();
        //List<Report_Reference_Number__c>  listRRF = New List<Report_Reference_Number__c>();
        system.runAs(testuser)
        {
            QCMTLComponentTrigger__c testcustomtesting = New QCMTLComponentTrigger__c();
            //testcustomtesting.Name =  'QCMTLComponentTrigger';
            testcustomtesting.TriggerActivate_Deactivate__c = true;
           // listTriggerTest.add(testcustomtesting);
            insert testcustomtesting;
            Report_Reference_Number__c testcustomtestingreport = New Report_Reference_Number__c();
            testcustomtestingreport.MTL_Reference_Number__c=1;
            testcustomtestingreport.Plating_Material_Composition_RRFNumber__c=1;
            testcustomtestingreport.Plating_Report_Reference_Number__c=1;
            
            insert testcustomtestingreport;   
            
            QC_MTL_Component__c test = new QC_MTL_Component__c();
            test.Testing_Type__c = 'Raw Material';
            test.Heat_No_Grade__c = 'Hg1';
            test.Sample_Size_Qty__c	= 2;
            test.Material_Sample_Type__c = 'New';
            //test.Report_Reference_Number__c = '';
            system.debug('Test : '+test);
                insert test;
            System.debug('New record:' +test.Testing_Type__c +test.Material_Sample_Type__c +test.Report_Reference_Number__c);    
             QC_MTL_Component__c test1 = new QC_MTL_Component__c();
            //test.Id=null;
            test1.Testing_Type__c = 'Plating';
            test1.Material_Sample_Type__c = 'New';
            //test.Report_Reference_Number__c = 'PL/Customer Assurance/0017(a)/19-20';
            insert test1;
            System.debug('New record:' +test.Testing_Type__c +test.Material_Sample_Type__c +test.Report_Reference_Number__c);  
            //test.id=null;
            QC_MTL_Component__c test2 = new QC_MTL_Component__c();
            test2.Testing_Type__c = 'Plating and Material Composition';
            test2.Material_Sample_Type__c = 'New';
            //test.Report_Reference_Number__c = 'PMC/Module IQF/0019(a)/19-20';
            insert test2;
            QC_MTL_Component__c test3 = new QC_MTL_Component__c();
            test3.Testing_Type__c = 'Plating and Material Composition';
            test3.Material_Sample_Type__c = 'Re-Submission';
            test3.Report_Reference_Number__c = 'PMC/Module IQF/0019(a)/19-20';
            insert test3;

            
           // System.debug('New record:' +test.Testing_Type__c +test.Material_Sample_Type__c +test.Report_Reference_Number__c);    
            
            
        }
    }
}