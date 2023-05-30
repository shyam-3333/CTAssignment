/*
    Name          : QC_TestFindingsReport 
    Created By    : Anand
    Created Date  : 5/13/2015
    Modified By: 
    Last Modified Date:
    Description:
    Methods Used:
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Praveen(Lister)  11/8/2019   T01     Test class issue fixing 
*/

public with sharing class QC_TestFindingsReport {
    public QC_Components__c component            {get;set;}         //Parent component
    public User l1l2UserName                     {get;set;}         //checked by user and approved bu user 
    public list<QC_TitanQualityControl.TestWrapper> testWrapModulelist {get;set;}   
    public ID recId{get;set;} 
    
    public class DefinedTestParam {
        public String uom{get;set;}                 //String variable to hold the test specification value
        public String testName{get;set;}            //String variable to hold the test name value
        public String specification{get;set;}       //String variable to hold the test specification value
        public String observation{get;set;}         //String variable to hold the test observation value
        public String verdict{get;set;}             //String variable to hold the test verdict value  
        public String commentAndRemarks{get;set;}   //Comments and remark value to capture in test finding      
        public String acceptCriteria {get;set;}     //AcceptCriteria only for Battery Component
        public String DeterminedVal {get;set;}      //DeterminedVal only for Batter Component
         
    }
    public List<DefinedTestParam> testParamList{get;set;}           //List to hold the Metal Strap test parameter
    public List<DefinedTestParam> batteryTestParamList{get;set;}
    public List<DefinedTestParam> batteryVisualInception{get;set;}
    public List<DefinedTestParam> batteryLeakage{get;set;}
    public List<DefinedTestParam> moduleGeneralObservation{get;set;}
    
    public QC_TestFindingsReport(){
      
      recId=Apexpages.currentpage().getParameters().get('id');
        l1l2UserName = new User();
       
        component = new QC_Components__c();  
        //testParamRecords = new List<QC_Test_Data__c>();  
        set<String> childId = new set<String>();
        testParamList   = new List<DefinedTestParam>(); 
        batteryTestParamList    = new List<DefinedTestParam>();
        batteryVisualInception  = new List<DefinedTestParam>();
        moduleGeneralObservation = new List<DefinedTestParam>();
        batteryLeakage          = new List<DefinedTestParam>();
        testWrapModulelist     = new list<QC_TitanQualityControl.testWrapper>();
        if(recId != null){        
            try{
                //Query the component details
                component = [SELECT id,Name__c,SKU_Reference__c,Parent__c,Parent__r.Report_Ref_Number__c,Final_Verdict__c,Owner.name,Report_Ref_Number__c,Watch_variant__c FROM QC_Components__c WHERE id =:recId ]; 
                System.debug('@@component@@'+component);
            }catch(Exception e){
                 ApexPages.addMessages(e) ; 
                System.debug('@@Error@@'+e);
            } 
            System.debug('parent value'+component.Parent__c+'--report ref no.---'+component.Report_Ref_Number__c+'parent rep. ref. no.'+component.Parent__r.Report_Ref_Number__c);
            
          //Retrieving the test parameters from TitanQualityControl page.
          QC_TitanQualityControl tqc = new QC_TitanQualityControl();
          //Passing QC_TitanQualityControl page parameters for page to retrieve data.
          tqc.comId = recId;
          tqc.comType = component.id != null ? component.Name__c : null;
          system.debug('**********tqc.comId : '+tqc.comId);
          system.debug('**********tqc.comType : '+tqc.comType);
          //Calling QC_TitanQualityControl initialize method to initialize the values
          //tqc.initialize(); <T01>
          tqc.displayTestParameter();
          system.debug('@@@@@@tqc.testWrapList'+tqc.testWrapList);
          //Assigning wrapperlist for Module
          if(component.Name__c == 'Module'){ 
              //testWrapModulelist.addAll(tqc.testWrapList);
              for(QC_TitanQualityControl.TestWrapper tw : tqc.testWrapList){
                 if(tw.Name !='General Observation'){
                     testWrapModulelist.add(tw);
                 }
              }
          }
          
          for(QC_TitanQualityControl.testWrapper  wrap : tqc.testWrapList){
            if(component.name__c != 'Battery' && component.Name__c != 'Module'){
                  DefinedTestParam testParamObj = new DefinedTestParam();
                    testParamObj.testName = wrap.name;
                    testParamObj.uom      = wrap.UOM;
                    testParamObj.specification = wrap.specification;
                    testParamObj.observation   = wrap.Observation;
                    testParamObj.verdict       = wrap.Conclusion;
                    testParamObj.commentAndRemarks = wrap.commentsandRemarks;
                    testParamObj.acceptCriteria  = wrap.acceptCriteria;
                    //testParamObj.DeterminedVal   = wrap.DeterminedVal;
                    testParamList.add(testParamObj);
              }else{
                 if(wrap.acceptCriteria == 'Leakage Test'){
                    DefinedTestParam testParamObj = new DefinedTestParam();
                      testParamObj.testName      = wrap.name;
                      testParamObj.uom           = wrap.UOM;
                      testParamObj.specification = wrap.specification;
                      testParamObj.observation   = wrap.Observation;
                      testParamObj.verdict       = wrap.Conclusion;
                      testParamObj.commentAndRemarks = wrap.commentsandRemarks;
                      testParamObj.acceptCriteria    = wrap.acceptCriteria;
                      testParamObj.DeterminedVal     = wrap.DeterminedVal;
                      batteryLeakage.add(testParamObj);
                 }
                 else if(wrap.Name =='General Observation'){
                    DefinedTestParam testParamObj = new DefinedTestParam();
                    testParamObj.testName  = wrap.name;
                    testParamObj.observation  = wrap.Observation;
                    testParamObj.verdict   = wrap.conclusion;
                    testParamObj.commentAndRemarks  = wrap.commentsandRemarks;
                    moduleGeneralObservation.add(testParamObj);
                 }
                 else{
                     if(wrap.Name == 'Visual Inspection'){
                         DefinedTestParam testParamObj = new DefinedTestParam();
                         testParamObj.testName = wrap.name;
                         testParamObj.verdict       = wrap.Conclusion;
                         testParamObj.commentAndRemarks = wrap.commentsandRemarks;
                         testParamObj.observation   = wrap.Observation;
                         batteryVisualInception.add(testParamObj);
                     }else{
                           DefinedTestParam testParamObj = new DefinedTestParam();
                         testParamObj.testName      = wrap.name;
                         testParamObj.uom           = wrap.UOM;
                         testParamObj.specification = wrap.specification;
                         testParamObj.observation   = wrap.Observation;
                         testParamObj.verdict       = wrap.Conclusion;
                         testParamObj.commentAndRemarks = wrap.commentsandRemarks;
                         testParamObj.acceptCriteria    = wrap.acceptCriteria;
                         testParamObj.DeterminedVal     = wrap.DeterminedVal;
                         batteryTestParamList.add(testParamObj);
                     }
                 }
              }//End of else
          }//End of for
            try{
                //Query the L1 and L2 approver name from user object.
                l1l2UserName = [SELECT id,Name,L1_Approver__r.Name,L2_Approver__r.Name FROM User WHERE Name =: component.Owner.Name];
            }catch(Exception e){
                 ApexPages.addMessages(e) ; 
                System.debug('Exception in user Query'+e);
            }
        }
        
            /* try{                  
                  testParamRecords = [SELECT id,Name,Comments_and_Remarks__c,Component_Name__c,Condition_Ref__r.Question__r.UOM__c,Condition_Ref__r.Question__r.Specification__c,Condition_Ref__r.Question__r.Test_Name__c,Component_Name__r.Name__c,Conclusion__c,Condition_Ref__c,Observation__c FROM QC_Test_Data__c WHERE Component_Name__c =: recId];
                }catch(Exception e){
                     ApexPages.addMessages(e) ; 
                    System.debug('Exception in test findings - leather strap'+e);
                }
                for(QC_Test_Data__c testDat : testParamRecords){
                    DefinedTestParam testParamObj = new DefinedTestParam();
                    testParamObj.testName = testDat.Condition_Ref__r.Question__r.Test_Name__c;
                    testParamObj.uom = testDat.Condition_Ref__r.Question__r.UOM__c;
                    testParamObj.specification = testDat.Condition_Ref__r.Question__r.Specification__c;
                    testParamObj.observation = testDat.Observation__c;
                    testParamObj.verdict = testDat.Conclusion__c;
                    testParamObj.commentAndRemarks  = testDat.Comments_and_Remarks__c;
                    testParamList.add(testParamObj);
                } */
        
      } //End of Contsturctor
}