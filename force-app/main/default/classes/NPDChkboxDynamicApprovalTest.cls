/*********************************************************************
   Class Name       : NPDChkboxDynamicApprovalTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPDChkboxDynamicApproval. 
   Created By       : Mohammed Raiyan
   Created Date     : 03/12/2015
   LastModifiedby   : Dheeraj Gangulli
   LastModifiedDate : 09/03/2016  
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Test Class Failure Fix 
*/
@isTest
public class NPDChkboxDynamicApprovalTest{

 public static testMethod void NPDChkboxDynamicApprovalTest() {
        
        List<NPD_Activity__c> insertList         = new list<NPD_Activity__c>();
        NPDChkboxDynamicApproval dynamicApproval = new NPDChkboxDynamicApproval();
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        //emailTemplate templateID   =  [SELECT ID FROM email 'NPD_Multi_Level_Approval_1st_Mail'];
        //insert templateID;
        
        UserRole ur                                            = new UserRole(Name = 'Dev head');
        
        user use                                               =    new user();        
        use.firstname                                          = 'fName';
        use.lastName                                           = 'lName';
        use.email                                              = 'mohammed.raiyan@kvpcorp.com';
        use.Username                                           = 'mohammed.raiyan123@kvpcorp.com';
        use.EmailEncodingKey                                   = 'ISO-8859-1';
        use.Alias                                              = 'mr';
        use.TimeZoneSidKey                                     = 'America/Los_Angeles';
        use.LocaleSidKey                                       = 'en_US';
        use.LanguageLocaleKey                                  = 'en_US';
        use.ProfileId                                          =  pf.id;
        use.UserRoleId                                         =  ur.id;
        
        insert use;
        List<npd_master__c> lstNPDMSTR = new List<npd_master__c>();//<T01>
        npd_master__c    nm1 = new npd_master__c ();
        nm1.name='balaji';
        nm1.type__c= 'owner';
        nm1.SalesforceUser__c =use.id;
        lstNPDMSTR.add(nm1);
        //insert nm1;
        
       npd_master__c    nm2 = new npd_master__c ();
        nm2.name='Duraisamy';
        nm2.type__c= 'owner';
        nm2.SalesforceUser__c =use.id;
        lstNPDMSTR.add(nm2);
        //insert nm2;
        
        npd_master__c    nm3 = new npd_master__c ();
        nm3.name='Shivakumar';
        nm3.type__c= 'owner';
        nm3.SalesforceUser__c =use.id;
        lstNPDMSTR.add(nm3);//<T01>
        insert lstNPDMSTR;
        
        
        NPD_Project_Name__c  oProjName                     =    new NPD_Project_Name__c();
        oProjName.Name                                     =    'Test ProjectName'; 
        oProjName.Strap_Source__c                          =    'OSD';      
        oProjName.Movement_Function__c                     =    'Gents';
        oProjName.Project_Complexity__c                    =    'Medium';
        oProjName.Development_Route__c                     =     'Component Route';
        
        insert oProjName;
        
        NPD_Stage__c marketStage                           =   NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
        marketStage.NPD_Project_Name__c                    =   oProjName.id;
        
        NPD_Stage__c concepStage                           =   NPD_TestUtilityClass.getNPDStage('Concept Finalization');
        concepStage.NPD_Project_Name__c                    =   oProjName.id;       
        insert concepStage; 
        
        NPD_Activity__c conceptSubmissionActivity          =   NPD_TestUtilityClass.getNPDActivity('Activity');        
        conceptSubmissionActivity.name__c                  =   'Concept submission and approval';
        conceptSubmissionActivity.NPD_Project_Name__c      =   oProjName.id;
        conceptSubmissionActivity.Source__c                =   'IDS';
        insertList.add(conceptSubmissionActivity);
        
        NPD_Activity__c protoSubActivity                   =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        protoSubActivity.name__c                           =  'Proto Submission by D&D for  Approval';
        protoSubActivity.NPD_Project_Name__c               =  oProjName.id;
        protoSubActivity.Source__c                         =   'IDS';
        insertList.add(protoSubActivity);
        
        NPD_Activity__c pricingProtoActivity               =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        pricingProtoActivity.name__c                       =  'Pricing Proto to PMG/Pricing release';
        pricingProtoActivity.NPD_Project_Name__c           =  oProjName.id;
        pricingProtoActivity.Source__c                     =   'IDS';
        insertList.add(pricingProtoActivity);
        
        NPD_Activity__c variantActivity                    =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        variantActivity.name__c                            =  'Variant wise Quantity Confirmation - Approved by SCG';
        variantActivity.NPD_Project_Name__c                =  oProjName.id;
        variantActivity.Source__c                          =   'IDS';
        insertList.add(variantActivity);
        
        NPD_Activity__c DummyActivity                      =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        DummyActivity.name__c                              =  'DummyActivity';
        DummyActivity.NPD_Project_Name__c                  =  oProjName.id;
        insertList.add(DummyActivity);
        
        NPD_Activity__c LeatherActivity                     =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        LeatherActivity.name__c                             =  'Leather Strap For Proto Mfg';
        LeatherActivity.NPD_Project_Name__c                 =  oProjName.id;
        LeatherActivity.Source__c                           =   'IDS';
        insertList.add(LeatherActivity);
        
        NPD_Activity__c dialForActivity                     =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        dialForActivity.name__c                             =  'Dial for Proto Mfg';
        dialForActivity.NPD_Project_Name__c                 =  oProjName.id;
        dialForActivity.Source__c                           =   'IDS';
        insertList.add(dialForActivity);
        
        NPD_Activity__c engineeActivity                     =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        engineeActivity.name__c                             =  'Engineering Design - IDS';
        engineeActivity.NPD_Project_Name__c                 =  oProjName.id;
        insertList.add(engineeActivity);
        
        NPD_Activity__c protDesActivity                     =  NPD_TestUtilityClass.getNPDActivity('Activity');        
        protDesActivity.name__c                             =  'Proto Design Input';
        protDesActivity.NPD_Project_Name__c                 =  oProjName.id;
        protDesActivity.Source__c                           =   'IDS';
        insertList.add(protDesActivity);
        
        NPD_Activity__c pbPmRelActivity                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        pbPmRelActivity.name__c                             =  'PB/PM Release , Approval  and Recipt - Optional';
        pbPmRelActivity.NPD_Project_Name__c                 =  oProjName.id;
        pbPmRelActivity.Source__c                           =   'IDS';
        insertList.add(pbPmRelActivity);
        
        NPD_Activity__c dialDraActivity                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        dialDraActivity.name__c                             =  'Dial Drawing Release and Recipt';
        dialDraActivity.NPD_Project_Name__c                 =  oProjName.id;
        dialDraActivity.Source__c                           =   'IDS';
        insertList.add(dialDraActivity);
        
        NPD_Activity__c briefinActivity                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        briefinActivity.name__c                             =  'Briefing to IDS';
        briefinActivity.NPD_Project_Name__c                 =  oProjName.id;
        briefinActivity.Brand1__c                           =  'Fastrack';
        briefinActivity.Source__c                           =   'IDS';
        insertList.add(briefinActivity);
        
        NPD_Activity__c briefinActivity2                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        briefinActivity2.name__c                             =  'Briefing to IDS';
        briefinActivity2.NPD_Project_Name__c                 =  oProjName.id;
        briefinActivity2.Source__c                           =   'IDS';
        briefinActivity2.Brand1__c                           =  'Nebula';
        insertList.add(briefinActivity2);
        
        NPD_Activity__c briefinActivity3                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        briefinActivity3.name__c                             =  'Briefing to IDS';
        briefinActivity3.NPD_Project_Name__c                 =  oProjName.id;
        briefinActivity3.Brand1__c                           =  'Sonata';
        briefinActivity3.Source__c                           =   'IDS';
        insertList.add(briefinActivity3);
        
        NPD_Activity__c costEstActivity                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        costEstActivity.name__c                             =  'Cost Estimation and Approval';
        costEstActivity.NPD_Project_Name__c                 =  oProjName.id;
        costEstActivity.Brand1__c                           =  'Fastrack';
        costEstActivity.Source__c                           =   'IDS';
        costEstActivity.Multi_Approvers__c                  =   'mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com';
        costEstActivity.Multilevel_Notification__c          =   'mohammed.raiyan@kvpcorp.com,!mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,!';
        insertList.add(costEstActivity);
        
        NPD_Activity__c costEstActivityMulti                     =  NPD_TestUtilityClass.getNPDActivity('Sub-Activity');        
        costEstActivityMulti.name__c                             =  'Cost Estimation and Approval';
        costEstActivityMulti.NPD_Project_Name__c                 =  oProjName.id;
        costEstActivityMulti.Brand1__c                           =  'Fastrack';
        costEstActivityMulti.Source__c                           =   'IDS';
        costEstActivityMulti.Multi_Approvers__c                  =   '';
        costEstActivityMulti.Multilevel_Notification__c          =   'mohammed.raiyan@kvpcorp.com,!mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,!';
        insertList.add(costEstActivityMulti);
     Test.StartTest();//<T01>
        insert insertList;

     List<NPD_Checklist__c> npdChechList = new List<NPD_Checklist__c>();
        NPD_Checklist__c check1                         = new NPD_Checklist__c(); 
        check1.NPD_Activity_Chklist__c                  = costEstActivity.id;
        check1.Multi_Approvers__c                       = 'mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com';
        check1.Multilevel_Notification__c               = 'mohammed.raiyan@kvpcorp.com,!mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,!';
        //insert check1;
        npdChechList.add(check1);
     
        NPD_Checklist__c check19                         = new NPD_Checklist__c(); 
        check19.NPD_Activity_Chklist__c                  = costEstActivity.id;
        check19.Multi_Approvers__c                       = 'mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com';
        check19.Multilevel_Notification__c               = '';
        //insert check19;
		npdChechList.add(check19);        
     
        NPD_Checklist__c check39                         = new NPD_Checklist__c(); 
        check39.NPD_Activity_Chklist__c                  = costEstActivityMulti.id;
        check39.Multi_Approvers__c                       = 'mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com';
        check39.Multilevel_Notification__c               = '';
        
        npdChechList.add(check39);
      	insert npdChechList;
        
        check1 = [SELECT id,NPD_Activity_Chklist__c,Multi_Approvers__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Multi_Approvers__c FROM NPD_Checklist__c WHERE id =:check1.id LIMIT 1];
        check1.NPD_Activity_Chklist__r.Multilevel_Notification__c = 'mohammed.raiyan@kvpcorp.com,!mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,!';
        check1.NPD_Activity_Chklist__r.Multi_Approvers__c = 'mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com,mohammed.raiyan@kvpcorp.com';
        update check1;
          
        NPDChkboxDynamicApproval.ApprovalDone(variantActivity.id);        
        dynamicApproval.ApprovalMethod(conceptSubmissionActivity.id,'submission');
        dynamicApproval.ApprovalMethod(protoSubActivity.id,'submission');
        dynamicApproval.ApprovalMethod(pricingProtoActivity.id,'Approved');
        dynamicApproval.ApprovalMethod(pricingProtoActivity.id,'submission');
        dynamicApproval.ApprovalMethod(conceptSubmissionActivity.id,'Approved');
        dynamicApproval.ApprovalMethod(pricingProtoActivity.id,'lol');
        dynamicApproval.ApprovalMethod(DummyActivity.id,'submission');
      
        NPDChkboxDynamicApproval.updateApprovers(insertList);
        for(NPD_Checklist__c  check2:[SELECT id,NPD_Activity_Chklist__c,Multi_Approvers__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Multi_Approvers__c FROM NPD_Checklist__c WHERE id =:check1.id LIMIT 1]){
            NPDChkboxDynamicApproval.MultiApprover(check2.id,'Submission');
            NPDChkboxDynamicApproval.MultiApprover(check2.id,'Approved');
            NPDChkboxDynamicApproval.MultiApprover(check2.id,'Rejected');
            NPDChkboxDynamicApproval.MultiApprover(check2.id,'Dropped');
            NPDChkboxDynamicApproval.MultiApprover(check2.id,'Re-Submit');
        }
        
        for(NPD_Checklist__c  check29:[SELECT id,NPD_Activity_Chklist__c,Multi_Approvers__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Multi_Approvers__c FROM NPD_Checklist__c WHERE id =:check19.id LIMIT 1]){
            
            NPDChkboxDynamicApproval.MultiApprover(check29.id,'Approved');
            
        }
        
        for(NPD_Checklist__c  check49:[SELECT id,NPD_Activity_Chklist__c,Multi_Approvers__c,Multilevel_Notification__c,NPD_Activity_Chklist__r.Multilevel_Notification__c,NPD_Activity_Chklist__r.Multi_Approvers__c FROM NPD_Checklist__c WHERE id =:check39.id LIMIT 1]){
            NPDChkboxDynamicApproval.MultiApprover(check49.id,'Approved');            
        }
       //NPDChkboxDynamicApproval.SendNotification(templateID.id,check1);
       Map<id,NPD_Activity__c> mapOld = new map<id,NPD_Activity__c>();
       mapOld.put(briefinActivity2.id,briefinActivity2);
       NPDApprovalHandler npdAprover = new NPDApprovalHandler();
       NPDApprovalHandler.getApproverOnBeforeUpdate(insertList,mapOld);
       Test.StopTest();//<T01>
    }
   
}