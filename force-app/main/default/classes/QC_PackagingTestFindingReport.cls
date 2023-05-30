/*
    Name: QC_PackagingTestFindingReport 
    Created By:Shamsher Singh
    Created Date: 06/02/2015
    Modified By:
    Last Modified Date:
    Description:Packaging report. All the test finding are displayed in the the report.
    Methods Used:
*/
public with sharing class QC_PackagingTestFindingReport {
    public QC_Components__c component            {get;set;}
     public User l1l2UserName                     {get;set;}         //checked by user and approved bu user
    public List<QC_Input_Data__c> quesResRecords {get;set;}     //List to hold the input parameters
    public List<QC_Test_Data__c> testParamRecords{get;set;}     //List to hold all the test findings 
    public ID recId     {get;set;}
    public List<DefinedParameters> packagingList{get;set;} 
    public List<DefinedTestParam> packagingTestParamList{get;set;}
    public class DefinedTestParam {
        public String testName{get;set;}
        public String specification{get;set;}
        public String acceptanceCritaria{get;set;}
        public String uUOM{get;set;}
        public String observation{get;set;}
        public String verdict{get;set;}     
        public String commentAndRemarks{get;set;}   //String variable to hold the test comments and remarks value    
    }
    public class DefinedParameters {
        public String inputParam{get;set;}
        public String value{get;set;}
    }
    public QC_PackagingTestFindingReport (){
        l1l2UserName            = new User();
        recId=Apexpages.currentpage().getParameters().get('id');
        component = new QC_Components__c();
        quesResRecords = new List<QC_Input_Data__c>();    
        testParamRecords = new List<QC_Test_Data__c>(); 
        packagingList = new List<DefinedParameters>();
        packagingTestParamList = new List<DefinedTestParam>();
        if(recId != null){
            try{
                component=[SELECT id,Owner.Name,Component_Status__c,Name__c,Parent__c,Final_Verdict__c,PSY_Reference__c,Sample_Category__c,Report_Ref_Number__c,Vendor__r.Name,Brand__r.Name,Sample_Date__c,model__c,Test_Back_Ground__c,Watch_variant__c,Sample_Department__c,SKU_Reference__c,No_Of_Sample_Received__c FROM QC_Components__c WHERE id =:recId ]; 
                System.debug('@@@@Component Details'+component);
            }catch(Exception e){
                System.debug('Exception in QL'+e);
            } 
            List<String> defindIP = new List<String>(); //Define the input parameters to be displayed in the report.
            //Define the test findings to be displayed in the report.
            //defindIP.add('SHOCK & BUMP TEST');
            //defindIP.add('ROLL TEST');
            //defindIP.add('DROP TEST');
            testParamRecords = [SELECT id,Name,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Acceptance_Criteria__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId ];
            //AND Condition_Ref__r.Question__r.Test_Name__c IN :defindIP
            System.debug('@@@@test records of the component'+testParamRecords);
            //Iterate through all the test fndings and add them into packagingTestParamList list to display in the page.
            for(QC_Test_Data__c testDat : testParamRecords){
                DefinedTestParam testParamObj   = new DefinedTestParam();
                testParamObj.testName           = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                testParamObj.specification      = testDat.Condition_Ref__r.Question__r.Specification__c;
                testParamObj.acceptanceCritaria = testDat.Condition_Ref__r.Question__r.Acceptance_Criteria__c;
                testParamObj.uUOM               = testDat.Condition_Ref__r.Question__r.UOM__c;
                testParamObj.observation        = testDat.Observation__c;
                testParamObj.verdict            = testDat.Conclusion__c;
                testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                packagingTestParamList.add(testParamObj);
            }//End of for block
            System.debug('packaging test parameter'+packagingTestParamList);
         }//End of if block
     }//End of constructor
}