@istest
public class QC_MTL_MaterialInfo_TestClass {
	@isTest
    public static void testMethodMaterialInfo(){
        User testuser = [select name, Id  FROM user LIMIT 1];
        system.runAs(testuser){
            QC_MTL_Component__c test = new QC_MTL_Component__c();
            test.Testing_Type__c = 'Raw Material';
            test.Material_Sample_Type__c = 'New';
            test.Report_Reference_Number__c = 'RM/0019/19-20';
            test.Record_Status__c = 'New';
            test.Sample_Size_Qty__c= 4;
            test.Document_Status__c = 'Draft';
            test.Sample_Received_From__c = 'sameer.ranjan@kvpcorp.com';
            insert test;
            QC_MTL_MaterialInfo.fetchMaterialData(test);
            QC_MTL_MaterialInfo.updateComponent(test.Id,test);
        }
            
    }
}