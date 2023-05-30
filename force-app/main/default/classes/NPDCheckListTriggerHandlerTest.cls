/*********************************************************************
   Class Name       : NPDCheckListTriggerHandlerTest 
   Type             : Test Class
   Description      : This test class covers code coverage of NPDCheckListTriggerHandler. 
   Created By       : Mohammed Raiyan
   Created Date     : 03/12/2015
   LastModifiedby   : Dheeraj Gangulli
   LastModifiedDate : 03/15/2015  
*********************************************************************/
@isTest
public class NPDCheckListTriggerHandlerTest {

 public static testMethod void NPDCheckListTriggerHandlerTest () {
          
        Test.StartTest(); 
        NPD_Master__c brand                         = new NPD_Master__c();
        brand.Type__c                               = 'Brand';
        brand.Name                                  = 'Titan';
        insert brand;
        
        
        NPD_Collections__c coll                     = new NPD_Collections__c ();
        coll.Collection_Name__c                                   = 'NPD Collection';
        coll.Tentative_Launch_Month_Date__c         = System.Today(); 
        insert coll;
        
        NPD_Project_Template__c template = NPD_TestUtilityClass.getProjectTemplate('Regular');        
        NPD_Project_Name__c  oProjName              =    new NPD_Project_Name__c();
        oProjName.Name                              =    'Test ProjectName'; 
        oProjName.Strap_Source__c                   =    'IND';      
        oProjName.Movement_Function__c              =    'Gents';
        oProjName.Project_Complexity__c             =    'Medium';  
        oProjName.Model_No__c                       = 'Test Model';
        oProjName.Vendor_Ref_No__c                  = 'Test Ref';
        oProjName.PSY_No__c                         = 'PSY - 10101';
        oProjName.Gender__c                         = 'Male';
        insert oProjName;
        list<NPD_Project_Items__c > projectItemInsert = new list<NPD_Project_Items__c >(); 
        
        NPD_Project_Items__c designNoTemplate         = NPD_TestUtilityClass.getProjItemForStage('Design No Allocation','Activity',template.id);
        projectItemInsert .add(designNoTemplate);
        NPD_Project_Items__c psyNumberTemplate        = NPD_TestUtilityClass.getProjItemForStage('PSY No Allocation','Activity',template.id);
        projectItemInsert.add(psyNumberTemplate); 
        NPD_Project_Items__c caseModelTemplate        = NPD_TestUtilityClass.getProjItemForStage('Case/Model No Allocation','Activity',template.id);
        projectItemInsert .add(caseModelTemplate);
        NPD_Project_Items__c pbPmTemplate             = NPD_TestUtilityClass.getProjItemForStage('PB/PM Release , Approval  and Recipt','Activity',template.id);
        projectItemInsert .add(pbPmTemplate);
        NPD_Project_Items__c conceptFinalTemplate     = NPD_TestUtilityClass.getProjItemForStage('Concept Finalization - OSD','Activity',template.id);
        projectItemInsert .add(conceptFinalTemplate);
        NPD_Project_Items__c productDesignerTemplate  = NPD_TestUtilityClass.getProjItemForStage('Product Designer Allocation - IDS','Activity',template.id);
        projectItemInsert .add(productDesignerTemplate);
        insert projectItemInsert;
        
        list<NPD_Activity__c> activityInsert = new list<NPD_Activity__c>();
        NPD_Activity__c designNoActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        designNoActivity.NPD_Project_Items__c         = designNoTemplate.id;
        designNoActivity.NPD_Project_Name__c          = oProjName.id;
        designNoActivity.name__c                      = 'Design No Allocation';
        activityInsert.add(designNoActivity);
        
        
       // list<NPD_Activity__c> activityInsert = new list<NPD_Activity__c>();
        
        
        NPD_Activity__c psyNumberActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        psyNumberActivity.NPD_Project_Items__c         = psyNumberTemplate.id;
        psyNumberActivity.name__c                      = 'PSY No Allocation';
        psyNumberActivity.NPD_Project_Name__c          = oProjName.id;
        psyNumberActivity.Brand1__c                    = 'Titan';
        activityInsert.add(psyNumberActivity);
        
        NPD_Activity__c caseModelActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        caseModelActivity.NPD_Project_Items__c         = caseModelTemplate.id;
        caseModelActivity.name__c                      = 'Case/Model No Allocation';
        caseModelActivity.NPD_Project_Name__c          = oProjName.id;
        activityInsert.add(caseModelActivity);
        
        NPD_Activity__c pbPmActivity                  = NPD_TestUtilityClass.getNPDActivity('Activity');
        pbPmActivity.NPD_Project_Items__c             = pbPmTemplate.id;
        pbPmActivity.name__c                          = 'PB/PM Release , Approval  and Recipt';
        pbPmActivity.NPD_Project_Name__c              = oProjName.id;
        activityInsert.add(pbPmActivity);
        
        NPD_Activity__c conceptFinalActivity          = NPD_TestUtilityClass.getNPDActivity('Activity');
        conceptFinalActivity.NPD_Project_Items__c     = conceptFinalTemplate.id;
        conceptFinalActivity.name__c                  = 'Concept Finalization - OSD';
        conceptFinalActivity.NPD_Project_Name__c      = oProjName.id;
        activityInsert.add(conceptFinalActivity);
        
        NPD_Activity__c   DummyActivity                = NPD_TestUtilityClass.getNPDActivity('Activity');
        DummyActivity.NPD_Project_Items__c             = productDesignerTemplate.id;
        DummyActivity.CopiedFrom__c                    = psyNumberTemplate.id;
        DummyActivity.NPD_Project_Name__c              = oProjName.id;
        DummyActivity.name__c                          = 'Dummy Activity';
        DummyActivity.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Auto_Generated__c                = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        activityInsert.add(DummyActivity);
        
        NPD_Activity__c   DummyActivity2                = NPD_TestUtilityClass.getNPDActivity('Activity');
        DummyActivity2.NPD_Project_Items__c             = productDesignerTemplate.id;
        DummyActivity2.CopiedFrom__c                    = psyNumberTemplate.id;
        DummyActivity2.NPD_Project_Name__c              = oProjName.id;
        DummyActivity2.name__c                          = 'Dummy Activity';
        DummyActivity2.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity2.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        
        activityInsert.add(DummyActivity2);
        
        NPD_Activity__c productDesignerActivity        = NPD_TestUtilityClass.getNPDActivity('Activity');
        productDesignerActivity.NPD_Project_Items__c   = productDesignerTemplate.id;
        productDesignerActivity.CopiedFrom__c          = designNoTemplate.id;
        productDesignerActivity.NPD_Project_Name__c    = oProjName.id;
        productDesignerActivity.name__c                = 'Product Designer Allocation - IDS';
        productDesignerActivity.Checklist_Columns__c   = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        productDesignerActivity.Columns_to_Copy__c     = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        
        activityInsert.add(productDesignerActivity);
        
        insert activityInsert;
        
        list<NPD_Checklist__c > listInsert = new list<NPD_Checklist__c>();
        
        
        NPD_Activity__c   dy              = new npd_activity__c();
        dy.NPD_Project_Items__c         = designNoTemplate.id;
        dy.NPD_Project_Name__c          = oProjName.id;
        dy.name__c                      = 'Concept Presentation to PMG - IDS';
        dy.SerialNo__c =   'AR-0103001001';
        dy.Approval_Status__c = 'Pending';
        dy.Auto_Generated__c = 'Gender , Desing No';
        dy.Brand1__c = 'Titan';
        insert dy;  
        
        
        
        
        NPD_Checklist__c check1                         = new NPD_Checklist__c(); 
        check1.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
        check1.Tag__c                             = 'upgrade';
        check1.model_no__c     =    'model9090';
        check1.Collection__c                             = coll.id; 
        check1.Vendor_Ref_No__c = 'Test Vendor';
        check1.npd_activity_chklist__c=dy.id;
        listInsert.add(check1);
        
        NPD_Checklist__c check01                         = new NPD_Checklist__c(); 
        check01.model_no__c     =    'model9090';
        check01.npd_activity_chklist__c=dy.id;
        check01.PSY_No__c = 'psy-1001';
        
        check01.Collection__c                             = coll.id; 
        check01.Vendor_Ref_No__c = 'Test Vendor';
        check01.Approval_Status__c = 'Test';
        check01.Tag__c                             = 'New';
        insert check01;
        
        
        
        
       // listInsert.add(check1);
        
        NPD_Checklist__c check2                         = new NPD_Checklist__c(); 
        check2.NPD_Activity_Chklist__c                  = caseModelActivity.id;              
        //check2.Collection__c                            = coll.id; 
        listInsert.add(check2);
        
        NPD_Checklist__c check3                         = new NPD_Checklist__c(); 
        check3.NPD_Activity_Chklist__c                  = pbPmActivity.id; 
       // check3.Collection__c                                   = coll.id; 
        listInsert.add(check3);
        
        NPD_Checklist__c check99                         = new NPD_Checklist__c(); 
        check99.NPD_Activity_Chklist__c                  = psyNumberActivity.id;   
        //check99.Collection__c                                   = coll.id;             
        listInsert.add(check99);
        
        
        NPD_Checklist__c check4                         = new NPD_Checklist__c(); 
        check4.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;  
       // check4.Collection__c                                   = coll.id;         
        listInsert.add(check4);     
        insert listInsert;
        listInsert.clear();
        
        NPD_Checklist__c check121                         = new NPD_Checklist__c(); 
        check121.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
       // check121.Collection__c                                   = coll.id; 
        listInsert.add(check121);
        
        NPD_Checklist__c check221                         = new NPD_Checklist__c(); 
        check221.NPD_Activity_Chklist__c                  = caseModelActivity.id;  
       // check221.Collection__c                                   = coll.id;             
        listInsert.add(check221);
        
        NPD_Checklist__c check321                         = new NPD_Checklist__c(); 
        check321.NPD_Activity_Chklist__c                  = pbPmActivity.id; 
        listInsert.add(check321);
        
        NPD_Checklist__c check921                         = new NPD_Checklist__c(); 
        check921.NPD_Activity_Chklist__c                  = psyNumberActivity.id;  
        //check921.Collection__c                                   = coll.id;              
        listInsert.add(check921);
        
        
        NPD_Checklist__c check421                         = new NPD_Checklist__c(); 
        check421.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;  
        //check421.Collection__c                                   = coll.id;         
        listInsert.add(check421);     
        insert listInsert;
        listInsert.clear();
        
        NPD_Checklist__c check                         = new NPD_Checklist__c(); 
        check.NPD_Activity_Chklist__c                  = designNoActivity.id;
       // check.Collection__c                                   = coll.id; 
        listInsert.add(check);
        
        
        
        NPD_Checklist__c check5                         = new NPD_Checklist__c(); 
        check5.NPD_Activity_Chklist__c                  = productDesignerActivity.id;   
       // check5.Collection__c                                   = coll.id;           
        listInsert.add(check5);  
        
        
        NPD_Checklist__c check10                         = new NPD_Checklist__c(); 
        check10.NPD_Activity_Chklist__c                  = DummyActivity.id;
        //check10.Collection__c                                   = coll.id; 
        listInsert.add(check10);
        insert listInsert;
        Test.StopTest();
        
        listInsert.clear(); 
        check.Cost__c                                   = 1000;
        update check;
        
        NPD_Checklist__c check6                         = new NPD_Checklist__c(); 
        check6.NPD_Activity_Chklist__c                  = DummyActivity.id;         
        listInsert.add(check6); 
        
        NPD_Checklist__c check15                        = new NPD_Checklist__c(); 
        check15.NPD_Activity_Chklist__c                  = DummyActivity2.id;       
        listInsert.add(check15);
        
        NPD_Checklist__c check7                         = new NPD_Checklist__c(); 
        check7.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
        check7.PSY_No__c                                = 'PSY-001';
        check7.Cost__c                                  = 500;        
        listInsert.add(check7);         
        
        
        NPD_Checklist__c check9                         = new NPD_Checklist__c(); 
        check9.NPD_Activity_Chklist__c                  = pbPmActivity.id;
        check9.PSY_No__c                                = 'PSY-001';
        check9.Cost__c                                  = 500;        
        listInsert.add(check9);
        
        NPD_Checklist__c check11                         = new NPD_Checklist__c(); 
        check11.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;
        check11.PSY_No__c                                = 'PSY-001';
        check11.Cost__c                                  = 500;        
        listInsert.add(check11);
        
        NPD_Checklist__c check21                         = new NPD_Checklist__c(); 
        check21.NPD_Activity_Chklist__c                  = designNoActivity.id;        
        check21.Cost__c                                  = 500;        
        listInsert.add(check21);
        
        
        
        
        NPD_Checklist__c check14                        = new NPD_Checklist__c(); 
        check14.NPD_Activity_Chklist__c                 = DummyActivity.id;       
        listInsert.add(check14);
        
        NPD_Checklist__c check19                        = new NPD_Checklist__c(); 
        check19.NPD_Activity_Chklist__c                 = DummyActivity2.id;       
        listInsert.add(check19);
        insert listInsert;
        delete check;
        
        NPD_Checklist__c check011                         = new NPD_Checklist__c(); 
        check011.Id = check01.Id;
        check011.Approval_Status__c ='Pending';
        update check011;
        
        NPD_Checklist__c check101                         = new NPD_Checklist__c(); 
        check101.model_no__c     =    'model9090';
        check101.npd_activity_chklist__c=dy.id;
        check101.Tag__c                             = 'New';
        check101.PSY_No__c = 'psy-1002';
        check101.Collection__c                             = coll.id; 
        check101.Vendor_Ref_No__c = 'Test Vendor';
        check101.Approval_Status__c = 'Approved';
        insert check101; 
        
        
        NPD_Activity__c   dy2              = new npd_activity__c();
        dy2.NPD_Project_Items__c         = designNoTemplate.id;
        dy2.NPD_Project_Name__c          = oProjName.id;
        dy2.name__c                      = 'PSY No Allocation';
        dy2.SerialNo__c =   'AR-0103001001';
        dy2.Approval_Status__c = 'Pending';
        dy2.Auto_Generated__c = 'Gender , Desing No';
        dy2.Brand1__c = 'Titan';
        insert dy2;  
        
        NPD_Checklist__c check105                         = new NPD_Checklist__c(); 
        check105.model_no__c     =    'model9090';
        check105.npd_activity_chklist__c=dy2.id;
        check105.Tag__c                             = 'New';
        check105.PSY_No__c = 'psy-1002';
        check105.Collection__c                             = coll.id; 
        check105.Vendor_Ref_No__c = 'Test Vendor';
        check105.Approval_Status__c = 'Approved';
        insert check105;
        
        CheckListTriggerHandler checkHandler = new CheckListTriggerHandler(new List<NPD_Checklist__c>{check105}, new map<id,NPD_Checklist__c>{check105.Id => check105});
        CheckListTriggerHandler.UpgradeOptionDynamicTable(check105);
       
    }

    //Cloned by Dheeraj
    public static testMethod void NPDCheckListTriggerHandlerTest2 () {
          
        Test.StartTest(); 
        NPD_Master__c brand                         = new NPD_Master__c();
        brand.Type__c                               = 'Brand';
        brand.Name                                  = 'Titan';
        insert brand;
        
        
        NPD_Collections__c coll                     = new NPD_Collections__c ();
        coll.Collection_Name__c                                   = 'NPD Collection';
        coll.Tentative_Launch_Month_Date__c         = System.Today(); 
        insert coll;
        
        NPD_Project_Template__c template = NPD_TestUtilityClass.getProjectTemplate('Regular');        
        NPD_Project_Name__c  oProjName              =    new NPD_Project_Name__c();
        oProjName.Name                              =    'DesignGender'; 
        oProjName.Strap_Source__c                   =    'IND';      
        oProjName.Movement_Function__c              =    'Gents';
        oProjName.Project_Complexity__c             =    'Medium';  
        oProjName.Model_No__c                       = 'Test Model';
        oProjName.Vendor_Ref_No__c                  = 'Test Ref';
        oProjName.PSY_No__c                         = 'PSY - 10101';
        oProjName.Gender__c                         = 'Male';
        insert oProjName;
        list<NPD_Project_Items__c > projectItemInsert = new list<NPD_Project_Items__c >(); 
        
        NPD_Project_Items__c designNoTemplate         = NPD_TestUtilityClass.getProjItemForStage('Design No Allocation','Activity',template.id);
        projectItemInsert .add(designNoTemplate);
        NPD_Project_Items__c psyNumberTemplate        = NPD_TestUtilityClass.getProjItemForStage('PSY No Allocation','Activity',template.id);
        projectItemInsert.add(psyNumberTemplate); 
        NPD_Project_Items__c caseModelTemplate        = NPD_TestUtilityClass.getProjItemForStage('Case/Model No Allocation','Activity',template.id);
        projectItemInsert .add(caseModelTemplate);
        NPD_Project_Items__c pbPmTemplate             = NPD_TestUtilityClass.getProjItemForStage('PB/PM Release , Approval  and Recipt','Activity',template.id);
        projectItemInsert .add(pbPmTemplate);
        NPD_Project_Items__c conceptFinalTemplate     = NPD_TestUtilityClass.getProjItemForStage('Concept Finalization - OSD','Activity',template.id);
        projectItemInsert .add(conceptFinalTemplate);
        NPD_Project_Items__c productDesignerTemplate  = NPD_TestUtilityClass.getProjItemForStage('Product Designer Allocation - IDS','Activity',template.id);
        projectItemInsert .add(productDesignerTemplate);
        insert projectItemInsert;
        
        list<NPD_Activity__c> activityInsert = new list<NPD_Activity__c>();
        NPD_Activity__c designNoActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        designNoActivity.NPD_Project_Items__c         = designNoTemplate.id;
        designNoActivity.NPD_Project_Name__c          = oProjName.id;
        designNoActivity.name__c                      = 'Design No Allocation';
        activityInsert.add(designNoActivity);
        
        
       // list<NPD_Activity__c> activityInsert = new list<NPD_Activity__c>();
        
        
        NPD_Activity__c psyNumberActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        psyNumberActivity.NPD_Project_Items__c         = psyNumberTemplate.id;
        psyNumberActivity.name__c                      = 'PSY No Allocation';
        psyNumberActivity.NPD_Project_Name__c          = oProjName.id;
        psyNumberActivity.Brand1__c                    = 'Titan';
        activityInsert.add(psyNumberActivity);
        
        NPD_Activity__c caseModelActivity              = NPD_TestUtilityClass.getNPDActivity('Activity');
        caseModelActivity.NPD_Project_Items__c         = caseModelTemplate.id;
        caseModelActivity.name__c                      = 'Case/Model No Allocation';
        caseModelActivity.NPD_Project_Name__c          = oProjName.id;
        activityInsert.add(caseModelActivity);
        
        NPD_Activity__c pbPmActivity                  = NPD_TestUtilityClass.getNPDActivity('Activity');
        pbPmActivity.NPD_Project_Items__c             = pbPmTemplate.id;
        pbPmActivity.name__c                          = 'PB/PM Release , Approval  and Recipt';
        pbPmActivity.NPD_Project_Name__c              = oProjName.id;
        activityInsert.add(pbPmActivity);
        
        NPD_Activity__c conceptFinalActivity          = NPD_TestUtilityClass.getNPDActivity('Activity');
        conceptFinalActivity.NPD_Project_Items__c     = conceptFinalTemplate.id;
        conceptFinalActivity.name__c                  = 'Concept Finalization - OSD';
        conceptFinalActivity.NPD_Project_Name__c      = oProjName.id;
        activityInsert.add(conceptFinalActivity);
        
        NPD_Activity__c   DummyActivity                = NPD_TestUtilityClass.getNPDActivity('Activity');
        DummyActivity.NPD_Project_Items__c             = productDesignerTemplate.id;
        DummyActivity.CopiedFrom__c                    = psyNumberTemplate.id;
        DummyActivity.NPD_Project_Name__c              = oProjName.id;
        DummyActivity.name__c                          = 'Dummy Activity';
        DummyActivity.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity.Auto_Generated__c                = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        activityInsert.add(DummyActivity);
        
        NPD_Activity__c   DummyActivity2                = NPD_TestUtilityClass.getNPDActivity('Activity');
        DummyActivity2.NPD_Project_Items__c             = productDesignerTemplate.id;
        DummyActivity2.CopiedFrom__c                    = psyNumberTemplate.id;
        DummyActivity2.NPD_Project_Name__c              = oProjName.id;
        DummyActivity2.name__c                          = 'Dummy Activity';
        DummyActivity2.Checklist_Columns__c             = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        DummyActivity2.Columns_to_Copy__c               = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        
        activityInsert.add(DummyActivity2);
        
        NPD_Activity__c productDesignerActivity        = NPD_TestUtilityClass.getNPDActivity('Activity');
        productDesignerActivity.NPD_Project_Items__c   = productDesignerTemplate.id;
        productDesignerActivity.CopiedFrom__c          = designNoTemplate.id;
        productDesignerActivity.NPD_Project_Name__c    = oProjName.id;
        productDesignerActivity.name__c                = 'Product Designer Allocation - IDS';
        productDesignerActivity.Checklist_Columns__c   = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        productDesignerActivity.Columns_to_Copy__c     = 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
        
        activityInsert.add(productDesignerActivity);
        
        insert activityInsert;
        
        list<NPD_Checklist__c > listInsert = new list<NPD_Checklist__c>();
        
        
        NPD_Activity__c   dy              = new npd_activity__c();
        dy.NPD_Project_Items__c         = designNoTemplate.id;
        dy.NPD_Project_Name__c          = oProjName.id;
        dy.name__c                      = 'Concept Design - IDS';
        dy.SerialNo__c =   'AR-0103001001';
        dy.Approval_Status__c = 'Pending';
        dy.Auto_Generated__c = 'Gender , Desing No';
        dy.Brand1__c = 'Titan';
        insert dy;  
        
        
        
        
        NPD_Checklist__c check1                         = new NPD_Checklist__c(); 
        check1.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
        check1.Tag__c                             = 'upgrade';
        check1.model_no__c     =    'model9090';
        check1.Collection__c                             = coll.id; 
        check1.Vendor_Ref_No__c = 'Test Vendor';
        check1.npd_activity_chklist__c=dy.id;
        listInsert.add(check1);
        
        NPD_Checklist__c check01                         = new NPD_Checklist__c(); 
        check01.model_no__c     =    'model9090';
        check01.Design_No__c = 'DS-1989';
        check01.npd_activity_chklist__c = dy.id;
        check01.PSY_No__c = 'psy-1001';        
        check01.Collection__c                             = coll.id; 
        check01.Vendor_Ref_No__c = 'Test Vendor';
        check01.Approval_Status__c = 'Test';
        check01.Tag__c                             = 'New';
        check01.Row_Number__c = 1;
        insert check01;
                        
        
       // listInsert.add(check1);
        
        NPD_Checklist__c check2                         = new NPD_Checklist__c(); 
        check2.NPD_Activity_Chklist__c                  = caseModelActivity.id;              
        //check2.Collection__c                            = coll.id; 
        listInsert.add(check2);
        
        NPD_Checklist__c check3                         = new NPD_Checklist__c(); 
        check3.NPD_Activity_Chklist__c                  = pbPmActivity.id; 
       // check3.Collection__c                                   = coll.id; 
        listInsert.add(check3);
        
        NPD_Checklist__c check99                         = new NPD_Checklist__c(); 
        check99.NPD_Activity_Chklist__c                  = psyNumberActivity.id;   
        //check99.Collection__c                                   = coll.id;             
        listInsert.add(check99);
        
        
        NPD_Checklist__c check4                         = new NPD_Checklist__c(); 
        check4.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;  
       // check4.Collection__c                                   = coll.id;         
        listInsert.add(check4);     
        insert listInsert;
        listInsert.clear();
        
        NPD_Checklist__c check121                         = new NPD_Checklist__c(); 
        check121.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
       // check121.Collection__c                                   = coll.id; 
        listInsert.add(check121);
        
        NPD_Checklist__c check221                         = new NPD_Checklist__c(); 
        check221.NPD_Activity_Chklist__c                  = caseModelActivity.id;  
       // check221.Collection__c                                   = coll.id;             
        listInsert.add(check221);
        
        NPD_Checklist__c check321                         = new NPD_Checklist__c(); 
        check321.NPD_Activity_Chklist__c                  = pbPmActivity.id; 
        listInsert.add(check321);
        
        NPD_Checklist__c check921                         = new NPD_Checklist__c(); 
        check921.NPD_Activity_Chklist__c                  = psyNumberActivity.id;  
        //check921.Collection__c                                   = coll.id;              
        listInsert.add(check921);
        
        
        NPD_Checklist__c check421                         = new NPD_Checklist__c(); 
        check421.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;  
        //check421.Collection__c                                   = coll.id;         
        listInsert.add(check421);     
        insert listInsert;
        listInsert.clear();
        
        NPD_Checklist__c check                         = new NPD_Checklist__c(); 
        check.NPD_Activity_Chklist__c                  = designNoActivity.id;
       // check.Collection__c                                   = coll.id; 
        listInsert.add(check);
        
        
        
        NPD_Checklist__c check5                         = new NPD_Checklist__c(); 
        check5.NPD_Activity_Chklist__c                  = productDesignerActivity.id;   
       // check5.Collection__c                                   = coll.id;           
        listInsert.add(check5);  
        
        
        NPD_Checklist__c check10                         = new NPD_Checklist__c(); 
        check10.NPD_Activity_Chklist__c                  = DummyActivity.id;
        //check10.Collection__c                                   = coll.id; 
        listInsert.add(check10);
        insert listInsert;
        Test.StopTest();
        
        listInsert.clear(); 
        check.Cost__c                                   = 1000;
        update check;
        
        NPD_Checklist__c check6                         = new NPD_Checklist__c(); 
        check6.NPD_Activity_Chklist__c                  = DummyActivity.id;         
        listInsert.add(check6); 
        
        NPD_Checklist__c check15                        = new NPD_Checklist__c(); 
        check15.NPD_Activity_Chklist__c                  = DummyActivity2.id;       
        listInsert.add(check15);
        
        NPD_Checklist__c check7                         = new NPD_Checklist__c(); 
        check7.NPD_Activity_Chklist__c                  = psyNumberActivity.id;
        check7.PSY_No__c                                = 'PSY-001';
        check7.Cost__c                                  = 500;        
        listInsert.add(check7);         
        
        
        NPD_Checklist__c check9                         = new NPD_Checklist__c(); 
        check9.NPD_Activity_Chklist__c                  = pbPmActivity.id;
        check9.PSY_No__c                                = 'PSY-001';
        check9.Cost__c                                  = 500;        
        listInsert.add(check9);
        
        NPD_Checklist__c check11                         = new NPD_Checklist__c(); 
        check11.NPD_Activity_Chklist__c                  = conceptFinalActivity.id;
        check11.PSY_No__c                                = 'PSY-001';
        check11.Cost__c                                  = 500;        
        listInsert.add(check11);
        
        NPD_Checklist__c check21                         = new NPD_Checklist__c(); 
        check21.NPD_Activity_Chklist__c                  = designNoActivity.id;        
        check21.Cost__c                                  = 500;        
        listInsert.add(check21);
        
        
        
        
        NPD_Checklist__c check14                        = new NPD_Checklist__c(); 
        check14.NPD_Activity_Chklist__c                 = DummyActivity.id;       
        listInsert.add(check14);
        
        NPD_Checklist__c check19                        = new NPD_Checklist__c(); 
        check19.NPD_Activity_Chklist__c                 = DummyActivity2.id;       
        listInsert.add(check19);
        insert listInsert;
        delete check;
        
        NPD_Checklist__c check011                         = new NPD_Checklist__c(); 
        check011.Id = check01.Id;
        check011.Approval_Status__c ='Pending';
        update check011;
        
        NPD_Checklist__c check101                         = new NPD_Checklist__c(); 
        check101.model_no__c     =    'model9090';
        check101.npd_activity_chklist__c=dy.id;
        check101.Tag__c                             = 'New';
        check101.PSY_No__c = 'psy-1002';
        check101.Collection__c                             = coll.id; 
        check101.Vendor_Ref_No__c = 'Test Vendor';
        check101.Approval_Status__c = 'Approved';
        insert check101; 
        
        
        NPD_Activity__c   dy2              = new npd_activity__c();
        dy2.NPD_Project_Items__c         = designNoTemplate.id;
        dy2.NPD_Project_Name__c          = oProjName.id;
        dy2.name__c                      = 'PSY No Allocation';
        dy2.SerialNo__c =   'AR-0103001001';
        dy2.Approval_Status__c = 'Pending';
        dy2.Auto_Generated__c = 'Gender , Desing No';
        dy2.Brand1__c = 'Titan';
        insert dy2;  
        
        NPD_Checklist__c check105                         = new NPD_Checklist__c(); 
        check105.model_no__c     =    'model9090';
        check105.npd_activity_chklist__c=dy2.id;
        check105.Tag__c                             = 'New';
        check105.PSY_No__c = 'psy-1002';
        check105.Collection__c                             = coll.id; 
        check105.Vendor_Ref_No__c = 'Test Vendor';
        check105.Approval_Status__c = 'Approved';
        insert check105;
        
        CheckListTriggerHandler checkHandler = new CheckListTriggerHandler(new List<NPD_Checklist__c>{check105}, new map<id,NPD_Checklist__c>{check105.Id => check105});
        
        
        
        /************************  For testing the create new project ************************/
        
        //String todate = '06/06/2016';
        //Date dt = Date.valueOf(todate);
        
       
        checkHandler.methodAccount();
        
        
    //  string CaseMaterial='CaseMaterial';
        
        // inserting the temp record.
        
        NPD_Collections__c nc1234= new NPD_Collections__c();
        
        
        
        //nc1234.Actual_Project_End_Date__c=dt;
        //nc1234.Actual_Project_Start_Date__c=dt;
        nc1234.Case_Material__c='silver';
        nc1234.Collection_Name__c='testing';
        nc1234.Comments_Remarks__c='testing';
        nc1234.Development_Route__c='testing';
        nc1234.Gender__c='testing';
        nc1234.Market__c='testing';
        nc1234.Marketing_brief_concept_reference_number__c='testing';
    //  nc1234.MarketingRestrict__c=true;
        nc1234.Movement_Function__c='testing';
        //nc1234.Planned_End_Date__c=dt;
        nc1234.Project_Complexity__c='testing';
        nc1234.Project_Status__c='testing';
        nc1234.Project_Type__c='testing';
        nc1234.PSY_No__c='testing';
        nc1234.Reasons_for_Drop__c='testing';
        nc1234.Strap_Material__c='testing';
        nc1234.Strap_Source__c='testing';
        nc1234.Template_Type__c='testing';
        nc1234.Tentative_Launch_Month_Date__c=Date.today();
        
        insert nc1234;
        
        
        
        CheckListTriggerHandler.UpgradeOptionDynamicTable(check105);
        checkHandler.afterUndeleteHandler();
        
     
     
     
        
     
     
        
    }
    
    
    public static Testmethod Void testinginsertdata()
    {
       
    
    }
    /*
    public static TestMethod void afterUpdateHandlerTest(){
        Test.StartTest();
        
        NPD_Project_Template__c template = NPD_TestUtilityClass.getProjectTemplate('Regular'); 
        insert template;
        
        NPD_Project_Items__c designNoTemplate = NPD_TestUtilityClass.getProjItemForStage('Design No Allocation','Activity',template.id);
        insert designNoTemplate;
        
        //Inserting into collection object
        NPD_Collections__c coll                     = new NPD_Collections__c ();
        coll.Collection_Name__c                     = 'NPD Collection';
        coll.Tentative_Launch_Month_Date__c         = System.Today(); 
        insert coll;
        
        //Inserting into collection object
        NPD_Project_Name__c  oProjName              = new NPD_Project_Name__c();
        oProjName.Name                              = 'DesignGender'; 
        oProjName.Strap_Source__c                   = 'IND';      
        oProjName.Movement_Function__c              = 'Gents';
        oProjName.Project_Complexity__c             = 'Medium';  
        oProjName.Model_No__c                       = 'Test Model';
        oProjName.Vendor_Ref_No__c                  = 'Test Ref';
        oProjName.PSY_No__c                         = 'PSY - 10101';
        oProjName.Gender__c                         = 'Male';
        insert oProjName;
        
        //Inserting into activity object
        NPD_Activity__c   act              = new npd_activity__c();
        act.NPD_Project_Items__c           = designNoTemplate.id;
        act.NPD_Project_Name__c            = oProjName.id;
        act.name__c                        = 'Concept Design - IDS';
        act.SerialNo__c                    = 'AR-0103001001';
        act.Approval_Status__c             = 'Pending';
        act.Auto_Generated__c              = 'Gender , Desing No';
        act.Brand1__c                      = 'Titan';
        act.CopiedFrom__c                  = designNoTemplate.id;
        insert act;
        
        
        //Inserting into checklist object.
        NPD_Checklist__c check            = new NPD_Checklist__c(); 
        check.model_no__c                 = 'model9090';
        check.Design_No__c                = 'DS-1989';
        check.npd_activity_chklist__c     =  act.id;
        check.PSY_No__c                   = 'psy-1001';        
        check.Collection__c               = coll.id; 
        check.Vendor_Ref_No__c            = 'Test Vendor';
        check.Approval_Status__c          = 'Test';
        check.Tag__c                = 'New';
        check.Row_Number__c               = 1;
        insert check;
        
        update check;
        Test.StopTest();
    } 
    */
}