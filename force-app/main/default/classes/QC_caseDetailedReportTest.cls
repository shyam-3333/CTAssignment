/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seealldata=true)
private class QC_caseDetailedReportTest{
    static QC_Components__c  comp;
    static list<QC_Input_Data__c> inputList;
    
   
    
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        comp = new QC_Components__c(name__c='Case',Watch_variant__c='fastrack');
        insert comp;
        //Inserting Input parameters questions
        
        id rtId = [select id from recordtype where developername='Question' and SobjectType='QC_Question__c'].id;
        List<ProcessInstance > lstProcessInstance = [SELECT Id, ProcessDefinitionID,CreatedDate ,(Select  OriginalActorId,CreatedDate FROM Steps ORDER BY CreatedDate DESC )
                                    FROM ProcessInstance WHERE TargetObjectId = :comp.id ORDER BY CreatedDate DESC];
        
        list<user> l1l2UserName  = [select Name from user ];
        
       QC_Question__c ques = new QC_Question__c(Question__c= 'Material',Component_Type__c='Case',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert ques;
       
       QC_Question__c quesBR = new QC_Question__c(Question__c= 'BR Fitting',Component_Type__c='Case',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesBR;
       
       QC_Question__c quesBC = new QC_Question__c(Question__c     = 'BC Fitting',Component_Type__c='Case',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesBC;
       
       QC_Question__c quesGlass = new QC_Question__c(Question__c     = 'Glass Fitting',Component_Type__c='Case',Order_Number__c = 10,Onload__c= false,Type__c= 'Picklist',Comment_Required__c = true,recordtypeid = rtid);
       insert quesGlass;   
       
       //inserting question responses
       QC_Response__c res = new QC_Response__c(Question__c =ques.id ,Response__c ='Material',Order_Number__c=10);        
        insert res;
        
        //Insert input parameters
        inputList = new list<QC_Input_Data__c>();
        QC_Input_Data__c inputMaterial = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =ques.id,Value__c='Ceramic');
     inputList.add(inputMaterial);
     
     QC_Input_Data__c inputBC = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesBC.id,Value__c='Hook');
     inputList.add(inputBC);
     
     QC_Input_Data__c inputBR = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesBR.id,Value__c='Snap');
     inputList.add(inputBR);
     
     QC_Input_Data__c inputGlass = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesBR.id,Value__c='Gasket');
     inputList.add(inputGlass);
     insert inputList;
     
     QC_Input_Data__c sample = new QC_Input_Data__c(Component_No__c=comp.id,Question__c =quesBR.id,Value__c='Gasket');
     insert sample;
     
     //Insert Condition record
     QC_Condition__c condition = new QC_Condition__c(Question__c=ques.id,Response__c=res.id);
     insert condition;
     
     //Insert test parameter record
     QC_Test_Data__c testList = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Accept',isManual__c=true);
     insert testList;
     
     QC_Test_Data__c testList1 = new QC_Test_Data__c(Condition_Ref__c=condition.id,Component_Name__c=comp.id,Observation__c='shkfbkhsb',Conclusion__c='Reject',isManual__c=false);
     insert testList1;
     
        PageReference pageRef = Page.QC_CaseReport;
        Test.setCurrentPageReference(pageRef);  
        ApexPages.currentPage().getParameters().put('id',comp.id);
        
        QC_caseDetailedReport qcCaseRep       = new QC_caseDetailedReport();
        qcCaseRep.firstActorName = 'avik';
        qcCaseRep.secondActorName = 'anin';
        
        QC_caseDetailedReport.DefinedParameters  dp   = new QC_caseDetailedReport.DefinedParameters();
        dp.color       = 'Red';
        dp.inputParam     = 'input param';
        dp.value       = 'value';
        QC_caseDetailedReport.DefinedTestParam  dtp    = new QC_caseDetailedReport.DefinedTestParam();
        dtp.observation    = 'onservation';
        dtp.uom        = 'uom';
        dtp.specification  = 'specification';
        dtp.testName    = 'Material Chemical Composition - Screw';
        dtp.verdict      = 'Accept';
    }
}