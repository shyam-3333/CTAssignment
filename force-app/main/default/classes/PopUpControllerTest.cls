/*********************************************************************
   Class Name       : PopUpControllerTest
   Type             : Test Class
   Description      : This test class covers code coverage of PopUpController. 
   Created By       : Keyur Modi
   Created Date     : 7/12/2015
   LastModifiedby   : Dheeraj Gangulli
   LastModifiedDate : 04/03/2016  
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister) 	11/27/2019   T01   Test Class Failure Fix 
*/
@isTest
private Class PopUpControllerTest{
     static testMethod void test() { 
     
     Test.StartTest();
        PopUpController pcontrlr = new PopUpController();
       
        pcontrlr.strComCat = '34';
        pcontrlr.Model = '34';  
        pcontrlr.subBrand= 'brand';
        pcontrlr.Brand='brand';
        pcontrlr.PSY='123fff';
        pcontrlr.SRC='Case Plant';
        pcontrlr.VEN='456tfry';
        pcontrlr.SUPAGENCY='Make';
        pcontrlr.strCheklistName = 'Make';
        pcontrlr.numLeadTime = null;
        pcontrlr.strLeadTime = null;
        pcontrlr.strPIRecName = null;
        pcontrlr.strCopyTableName = '';
        //pcontrlr.complexityList = '';
        pcontrlr.strComplexity='';
        ApexPages.currentPage().getParameters().put('comType','Medium');
        ApexPages.currentPage().getParameters().put('title','Case Development - INH');
        ApexPages.currentPage().getParameters().put('type','Activity');        
        ApexPages.currentPage().getParameters().put('BrandComponent','test');
        ApexPages.currentPage().getParameters().put('brandValue','');
        ApexPages.currentPage().getParameters().put('SubBrandComponent','test');
        ApexPages.currentPage().getParameters().put('ActivityName','Case Development - INH');

        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.Type__c = 'Brand';
        insert masterCM; 
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.Brand__c=   masterCM.Id;
        insert masterST;       
       
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
      
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
     
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Case Development - INH','Activity',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Sub-stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c = 0;
        oStage2.Position__c        = 1;
        oStage2.SerialNo__c        =    'AR-0101';
        oStage2.Planned_Lead_Time__c = 10;
        oStage2.Planned_End_Date__c =     System.today().addYears(1);
        oStage2.Phase__c = 'Design';
        oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
        oStage2.No_of_Designs__c = 2;
        insert oStage2;
        
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Case Development - INH';
        oActivity.Actual_Start_Date__c = (system.today() -2);//<T01>
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage2.Id;
        oActivity.NPD_Project_Items__c = oProjItem.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        // oActivity.NPD_Project_Name__c =projName.id ;
        insert oActivity;

        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklist.NPD_Activity_Chklist__c =  oActivity.Id;
        checklist.Model_No__c = '34';
        checklist.Supply_Agency__c= 'Case Plant';
        checklist.PSY_No__c= '123fff';
        checklist.Case_Sourcing__c= 'Make';
        checklist.Vendor_Ref_No__c = '456tfry';
        insert checklist;
        
        NPD_Complexity__c complexinst     = new NPD_Complexity__c();
        complexinst.Name__c               = 'Medium';
        complexinst.Record_Type__c        = 'Complexity Category';
        complexinst.NPD_Activity__c       =  oProjItem.Id;
        complexinst.Sub_Stage__c          =  oProjItem.Id;
        complexinst.Type__c               =  'Activity';
        insert complexinst;

        NPD_Complexity__c complexinst1     = new NPD_Complexity__c();
        complexinst1.Complexity_Type__c    = complexinst.Id;
        complexinst1.Record_Type__c        = 'Complexity Category';
        complexinst1.NPD_Activity__c       =  oProjItem.Id;
        complexinst1.Sub_Stage__c          =  oProjItem.Id;
        complexinst1.Type__c               =  'Sub-Stage';
        insert complexinst1; 
        
        NPD_Complexity__c complexinst3     = new NPD_Complexity__c();
        complexinst3.Name__c                  = 'Simple';
        complexinst3.Record_Type__c        = 'Complexity Category';
        complexinst3.NPD_Activity__c       =  oProjItem.Id;
        complexinst3.Sub_Stage__c          =  oProjItem.Id;
        complexinst3.Type__c               =  'Sub-Stage';
        insert complexinst3;
        
        NPD_Complexity__c complexinst4     = new NPD_Complexity__c();
        complexinst4.Name__c               = 'Simple';
        complexinst4.Record_Type__c        = 'Complexity Category';        
        complexinst4.Type__c               =  'Activity';
        insert complexinst4;
 
        PopUpController.ModelWrapper Wrapper1 = new PopUpController.ModelWrapper(checklist);
        PopUpController.SubBrandWrapper Wrapper2 = new PopUpController.SubBrandWrapper(masterST);
        PopUpController.BrandWrapper Wrapper3 = new PopUpController.BrandWrapper(masterCM);
        PopUpController.complexWrapper Wrapper4 = new PopUpController.complexWrapper (complexinst);
        PopUpController.complexWrapper Wrapper5 = new PopUpController.complexWrapper (complexinst4);
 
        pcontrlr.getcomplexityValues();
        pcontrlr.getcomplexityTypeValues();
        pcontrlr.getBrandValues();
        pcontrlr.getSubBrandValues();
        pcontrlr.getModelValues();
        pcontrlr.doComplexitySelection();
        pcontrlr.doModelSelection();
        pcontrlr.doBrandSelection();
        pcontrlr.doSubBrandSelection();
        
     Test.StopTest();
 }
     
     static testMethod void test2() { 
     
     Test.StartTest();
        PopUpController pcontrlr = new PopUpController();
            
        ApexPages.currentPage().getParameters().put('comType','Medium');
        ApexPages.currentPage().getParameters().put('title','Case Development - INH');       
        ApexPages.currentPage().getParameters().put('type','Sub-Stage');
        ApexPages.currentPage().getParameters().put('SubBrandComponent','test');
        ApexPages.currentPage().getParameters().put('brandValue','Strap Material');
        ApexPages.currentPage().getParameters().put('ActivityName','Case Development - INH'); 
        pcontrlr.strCheklistName = 'Make';

        NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM.Type__c = 'Brand';
        insert masterCM;
        
        NPD_Master__c  masterCM1 = NPD_TestUtilityClass.getNPDMaster('Case Material');
        masterCM1.Type__c = 'TaskOwner';
        insert masterCM1; 
        
        NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
        masterST.Brand__c=   masterCM.Id;
        insert masterST;       
       
        NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
        insert masterSM;
      
        NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
        insert oProjTemp; 
     
        NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Case Development - INH','Sub-Stage',oProjTemp.Id);
        insert oProjItem;
        
        NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
        insert oCollection;
        
        NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        oStage1.Type__c                      =    'Stage';
        insert oStage1;
        
        NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
        oStage2.Actual_Start_Date__c                           =    System.today();
        oStage2.Type__c                                        =    'Sub-stage';
        oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
        oStage2.Market__c                                      =    'Domestic';
        oStage2.Status__c                                      =    'In Progress';
        oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
        oStage2.NPD_Stage__c                                   =    oStage1.Id;
        oStage2.Planned_Start_Date__c                          =    System.today();
        oStage2.Total_Lead_Time__c = 0;
        oStage2.Position__c        = 1;
        oStage2.SerialNo__c        =    'AR-0101';
        oStage2.Planned_Lead_Time__c = 10;
        oStage2.Planned_End_Date__c =     System.today().addYears(1);
        oStage2.Phase__c = 'Design';
        oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
        oStage2.No_of_Designs__c = 2;
        
        insert oStage2;
        
        NPD_Activity__c oActivity            =    NPD_TestUtilityClass.getNPDActivity('Activity');
        oActivity.Name__c = 'Case Development - INH';
        oActivity.Actual_Start_Date__c =  (system.today() -2);//<T01>
        oActivity.Planned_Lead_Time__c = 10;
        oActivity.Status__c = 'In Progress';
        oActivity.No_of_Designs__c = 2;
        oActivity.Approval_Status__c = 'None';
        oActivity.Market__c = 'Domestic';
        oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
        oActivity.Approval_Required__c = true;
        oActivity.NPD_Stage__c = oStage2.Id;
        oActivity.NPD_Project_Items__c = oProjItem.Id;
        oActivity.Position__c = 1;
        oActivity.SerialNo__c = 'AR-0101001';
        oActivity.Active__c = true;
        
        insert oActivity;

        NPD_Checklist__c checklist = NPD_TestUtilityClass.getChecklist('Make','Case Plant');
        checklist.NPD_Activity_Chklist__c =  oActivity.Id;
        checklist.Model_No__c = '34';
        checklist.Supply_Agency__c= 'Case Plant';
        checklist.PSY_No__c= '123fff';
        checklist.Case_Sourcing__c= 'Make';
        checklist.Vendor_Ref_No__c = '456tfry';
        insert checklist;
        
        NPD_Complexity__c complexinst     = new NPD_Complexity__c();
        complexinst.Name__c               = 'Medium';
        complexinst.Record_Type__c        = 'Complexity Category';
        complexinst.NPD_Activity__c       =  oProjItem.Id;
        complexinst.Sub_Stage__c          =  oProjItem.Id;
        complexinst.Type__c               =  'Sub-Stage';
        insert complexinst;
        
        NPD_Complexity__c complexinst1     = new NPD_Complexity__c();
        complexinst1.Name__c               = 'Medium';
        complexinst1.Record_Type__c        = 'Complexity Type';
        complexinst1.NPD_Activity__c       =  oProjItem.Id;
        complexinst1.Sub_Stage__c          =  oProjItem.Id;
        complexinst1.Type__c               =  'Sub-Stage';
        insert complexinst1;
                
        PopUpController.ModelWrapper Wrapper1 = new PopUpController.ModelWrapper(checklist);
        PopUpController.SubBrandWrapper Wrapper2 = new PopUpController.SubBrandWrapper(masterST);
        PopUpController.BrandWrapper Wrapper3 = new PopUpController.BrandWrapper(masterCM);
        PopUpController.complexWrapper Wrapper4 = new PopUpController.complexWrapper(complexinst);
        PopUpController.UserWrapper wrapper5 = new PopUpController.UserWrapper(masterCM1);
        
        pcontrlr.getcomplexityValues();
        pcontrlr.getcomplexityTypeValues();
        pcontrlr.getBrandValues();
        pcontrlr.getSubBrandValues();
        pcontrlr.getModelValues();
        pcontrlr.doComplexitySelection();
        pcontrlr.doModelSelection();
        pcontrlr.doBrandSelection();
        pcontrlr.doSubBrandSelection();
        pcontrlr.getUserValues();
        pcontrlr.doUserSelection();
        
        ApexPages.currentPage().getParameters().put('actId',oActivity.Id);    
        pcontrlr.strComCat =  '34';  
        pcontrlr.getModelValues();
        pcontrlr.getcomplexityTypeValues();
        pcontrlr.doModelSelection();
     Test.StopTest();
   }
  
}