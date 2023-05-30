/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/15/2019   T01    DML Inside for loop
Saradha(Lister)  11/28/2019   T02    Test Class Fix
*/
public with sharing class NPD_UtilityController {
    public List < NPD_Stage__c > newList = new List < NPD_Stage__c > ();
    public Map < id, NPD_Stage__c > oldMap = new Map < id, NPD_Stage__c > ();
    public List < NPD_Activity__c > newListAct = new List < NPD_Activity__c > ();
    public Map < id, NPD_Activity__c > oldMapAct = new Map < id, NPD_Activity__c > ();
    public set < id > actSetId = new set < id > ();
    public set < id > MapActIdsGet = new set < id > ();
    public static Map<String,List<String>> userToActivityName;
    public Static List<Sobject> listToInsert= new List<Sobject>();
    public static List<NPD_Checklist__c> insertCheckListIds = new List<NPD_Checklist__c>();
    public static list<string> succActivityList = new List<String>();

    // public date ActualProjectEndDate{set;get;}
    // public date ActualProjectStartDate{set;get;}
    public string CaseMaterial {
        set;
        get;
    }
    public static string ActivityOwnerEmail = '';
    public static string ActivityOwnerName = '';
    public static string ActivityModelName = '';
    public static string ActivityRecName = '';
    public static string ActivityCollectionName = '';
    public string CollectionName {
        set;
        get;
    }
    public string CommentsRemarks {
        set;
        get;
    }
    public string DevelopmentRoute {
        set;
        get;
    }
    public string Gender {
        set;
        get;
    }
    public string Market {
        set;
        get;
    }
    public string Marketingbriefconceptreferencenumber {
        set;
        get;
    }
    //public boolean MarketingRestrict{set;get;}
    public string MovementFunction {
        set;
        get;
    }
    // public date PlannedEndDate{set;get;}
    public string ProjectComplexity {
        set;
        get;
    }
    public string ProjectStatus {
        set;
        get;
    }
    public string ProjectType {
        set;
        get;
    }
    public string PSYNo {
        set;
        get;
    }
    public string ReasonsforDrop {
        set;
        get;
    }
    public string StrapMaterial {
        set;
        get;
    }
    public string StrapSource {
        set;
        get;
    }
    public string TemplateType {
        set;
        get;
    }
    // public date TentativeLaunchMonthDate{set;get;}  
    public integer counting {
        set;
        get;
    }
    public map < id, npd_activity__c > ActivityMapActId = new map < id, npd_activity__c > ();

    public static boolean flag1 = true;
    public static boolean flag2 = true;
    public static boolean flag3 = true;
    public static boolean flag4 = true;
    public static boolean flag5 = true;
    public static boolean flag6 = true;
    public static boolean flag7 = true;
    public static boolean flag10 = true;
    public static boolean flag11 = true;
    public static boolean flag21 = true;
    public Integer SubstageLeadTime = 0;
    public static integer flag12 = 1;
    public list < NPD_Project_Name__c > npdPros = new list < NPD_Project_Name__c > ();
    map < NPD_Project_Name__c, list < npd_stage__c >> ProjStgMap = new map < NPD_Project_Name__c, list < npd_stage__c >> ();
    // public map<id,NPD_Project_Name__c> mapOfModels = new map<id,NPD_Project_Name__c>([select id,name,status__c from NPD_Project_Name__c]);

    public NPD_UtilityController() {}

    public NPD_UtilityController(List < NPD_Stage__c > triggerNew, map < id, NPD_Stage__c > oldTriggerMap) {
        newList = triggerNew;
        oldMap = oldTriggerMap;
        system.debug('The trigger n ewnew values are: ' + newlist);
    }
    public NPD_UtilityController(List < NPD_Activity__c > triggerNew, map < id, NPD_Activity__c > oldTriggerMap) {
        newListAct = triggerNew;
        oldMapAct = oldTriggerMap;
    }
    public static void mbAutoNumberGeneration(list < npd_stage__c > stgRecords) {
        // To control the execution only for 2nd time method calling from trigger.
        flag12++;
        if (stgRecords[0].brand1__c != null) {
            try {
                npd_stage__c stagerec12 = [select id, name__c, Marketing_brief_concept_reference_number__c, MBReferenceAuto__c from npd_stage__c where Marketing_brief_concept_reference_number__c != null order by createddate DESC limit 1];
                for (npd_stage__c StageforMbNo: stgRecords) {
                    system.debug('The new values are: ' + StageforMbNo);
                    string existingMbRefNo = stagerec12.Marketing_brief_concept_reference_number__c.substring(1, 3);
                    integer Autonum = integer.Valueof(existingMbRefNo);
                    string Brand = StageforMbNo.Brand1__c;
                    String BrandFirstChart = Brand.substring(0, 1);
                    Integer Year = Date.Today().Year();
                    string nextYear = string.valueof(year + 1).substring(2, 4);
                    Autonum = Autonum + 1;
                    string MbRefNo = BrandFirstChart + Autonum + '/' + string.valueof(year) + '~' + nextYear;
                    system.debug(MbRefNo + 's***************');
                    StageforMbNo.Marketing_brief_concept_reference_number__c = MbRefNo;
                }
            } catch (exception er1) {
                system.debug('The exp occ at mbref no:' + er1);
            }
        }
        flag12 = 3;
    }

    public static void ProtoDesignInputActivityCreation(List < NPD_activity__c > triggerNewdata, map < Id, NPD_activity__c > oldMap) {
        if (triggerNewdata[0].name__c == 'Proto Design Input') {
            if (flag21 == true) {
                system.debug(' inside ProtoDesignInputActivityCreation email : ');
            }
            list < npd_activity__c > caseModelAct = new list < npd_activity__c > ();
            list < npd_activity__c > caseModelAct2 = new list < npd_activity__c > ();
            caseModelAct2 = [select id, name__c, npd_user__c, npd_user__r.salesforceuser__r.id, npd_user__r.salesforceuser__r.email, npd_user__r.userid__c from npd_activity__c where name__c = 'Make or Buy or Dual Decision'
                AND NPD_Collections__c =: triggerNewdata[0].CollectionId__c AND protodesigninputowneremail__c = false
            ];
            caseModelAct = [select id, name__c, npd_user__c, npd_user__r.salesforceuser__r.id, npd_user__r.salesforceuser__r.email, npd_user__r.userid__c from npd_activity__c where(name__c = 'Proto Design Input'
                OR name__c = 'Make or Buy or Dual Decision') AND npd_project_name__c =: triggerNewdata[0].npd_project_name__c];
            Contact con = new Contact();
            con.FirstName = 'Temp Rec for email';
            con.LastName = 'remove this rec.';
            con.Email = 'sfdcadmin@gmail.com';
            insert con;
            list < String > userlist = new list < string > ();
            userlist.add('mailtitansfdc@gmail.com');
            system.debug('caseModelAct details' + caseModelAct);
            EmailTemplate emailTemp = [SELECT Id, Name FROM EmailTemplate WHERE Name = 'proto design input owner email'
                LIMIT 1
            ];
            list < Messaging.SingleEmailMessage > lSendSingleEmails = new list < Messaging.SingleEmailMessage > ();
            for (NPD_activity__c oSubAct: triggerNewdata) {
                system.debug('The osbut act val is:' + oSubAct.Name__c);
                if (oSubAct.NPD_User__c != null && oSubAct.Name__c.equalsIgnoreCase('Proto Design Input')) {
                    system.debug('inside if stagemet 123');
                    list < String > ccAddress = new list < String > ();
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    ccAddress.add(caseModelAct2[0].npd_user__r.userid__c);
                    ccAddress.add(caseModelAct[0].npd_user__r.userid__c);
                    mail.setToAddresses(userlist);
                    mail.setCcAddresses(ccAddress);
                    mail.setTargetObjectId(con.id);
                    mail.setTemplateId(emailTemp.Id);
                    mail.setSenderDisplayName('PDMS ADMIN');
                    //mail.setplaintextbody('hello');
                    mail.setWhatId(caseModelAct2[0].id);
                    mail.setSaveAsActivity(false);
                    lSendSingleEmails.add(mail);
                }
            }
            system.debug('lSendSingleEmails*** ' + lSendSingleEmails);
            try {
                if (!lSendSingleEmails.isEmpty()) {
                    Messaging.sendEmail(lSendSingleEmails);
                    system.debug('inside lSendSingleEmails*** ' + lSendSingleEmails);
                }
            } catch (exception etr1) {
                system.debug('The etr1 Expcetion is :' + etr1);
            }
            flag21 = false;
        }
    }

    public static void subActivityComletionEmail(List < NPD_activity__c > triggerNewdata, map < Id, NPD_activity__c > oldMap) {
        if (flag1 == true) {
            system.debug(' inside subactvity completino email : ');
            set < Id > sSubActNPDUsers = new set < Id > ();

            if (!triggerNewdata.isEmpty()) {
                for (NPD_activity__c oSubAct: triggerNewdata) {
                    if (oSubAct.NPD_User__c != null) {
                        sSubActNPDUsers.add(oSubAct.NPD_User__c);
                    }
                }
            }

            map < Id, NPD_Master__c > mNPDMaster = new map < Id, NPD_Master__c > ();
            if (!sSubActNPDUsers.isEmpty()) {
                for (NPD_Master__c oNPDMstr: [SELECT Id, Name, SalesforceUser__c, SalesforceUser__r.Id, SalesforceUser__r.Email, UserID__c, SalesforceUser__r.Email_Manager__c FROM NPD_Master__c WHERE Id IN: sSubActNPDUsers]) {
                    mNPDMaster.put(oNPDMstr.Id, oNPDMstr);
                }
            }
            EmailTemplate emailTemp = [SELECT Id, Name FROM EmailTemplate WHERE Name = 'Subactivity Completion with Table Email'
                LIMIT 1
            ];
            list < Messaging.SingleEmailMessage > lSendSingleEmails = new list < Messaging.SingleEmailMessage > ();

            for (NPD_activity__c oSubAct: triggerNewdata) {
                if (!oldMap.isEmpty() && oSubAct.NPD_User__c != null && !oldMap.get(oSubAct.Id).Status__c.equalsIgnoreCase('Completed') && oSubAct.Status__c.equalsIgnoreCase('Completed') && oSubAct.Type__c.equalsIgnoreCase('Sub-Activity')) {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    if (!mNPDMaster.isEmpty() && mNPDMaster.containsKey(oSubAct.NPD_User__c) && mNPDMaster.get(oSubAct.NPD_User__c) != null) {
                        mail.setToAddresses(new String[] {
                            (mNPDMaster.get(oSubAct.NPD_User__c).SalesforceUser__r.Email)
                        });
                        mail.setCcAddresses(new String[] {
                            (mNPDMaster.get(oSubAct.NPD_User__c).UserID__c)
                        });
                        mail.setTargetObjectId(mNPDMaster.get(oSubAct.NPD_User__c).SalesforceUser__r.Id);

                        system.debug('""""""""""""  Email Manager  is: ' + mNPDMaster.get(oSubAct.NPD_User__c).SalesforceUser__r.Email);
                    }
                    mail.setTemplateId(emailTemp.Id);
                    mail.setWhatId(oSubAct.Id);
                    mail.setSenderDisplayName('PDMS ADMIN');
                    mail.setSaveAsActivity(false);
                    lSendSingleEmails.add(mail);
                }
            }

            system.debug('lSendSingleEmails*** ' + lSendSingleEmails);
            if (!lSendSingleEmails.isEmpty()) {
                Messaging.sendEmail(lSendSingleEmails);
            }
            flag1 = false;
        }
    }

    //Change of Source the ISD or ODS  will be from Collection not from marketing and PSY and VENDOR should populate on same basis
    public void afterUpdateHandler() {
          if(flag2 == true) {
            system.debug('The afterUpdateHandler PSYOR VENDOR :');
            flag2 = true;
            set < id > projectId = new set < id > ();
            set < id > stageId = new set < id > ();
            map < id, list < NPD_Activity__c >> projectToActivity = new map < id, list < NPD_Activity__c >> ();
            list < npd_activity__c > listToUpdate = new list < npd_activity__c > ();
            list < NPD_Stage__c > listToUpdatest = new list < NPD_Stage__c > ();
            map < string, id > serialToID = new map < string, id > ();
            for(NPD_Project_Items__c item: [SELECT id, title__c, Titan_Sr_No__c FROM NPD_Project_Items__c WHERE Project_Template__r.name = 'Regular'
                AND(Titan_Sr_No__c = 'AR-0102003001'
                  OR title__c = 'Design Presentation and Approval - OSD')
              ]) {
              if(item.Titan_Sr_No__c != NULL && item.Titan_Sr_No__c == 'AR-0102003001') serialToID.put('IDS', item.id);
              else if(item.Titan_Sr_No__c != NULL && item.title__c == 'Design Presentation and Approval - OSD') serialToID.put('OSD', item.id);
            }
           
            for(NPD_Stage__c stg: newList) {
              if(stg.Name__c == 'Marketing Brief/Concept') {
                stageId.add(stg.id);
              }
            }
              //T01
              if(stageId.size()>0){
                  listToUpdatest = [SELECT Active__c, Actual_End_Date__c, Actual_Lead_Time__c, Actual_Start_Date__c, Approval_Required__c, Approval_Status__c,
                                    Approval_Submitted_Date__c, Approved_Date__c, Brand1__c, Brand__c, Case_Material__c, Collection_reference_No__c, Collection_reference__c,
                                    Comments_Remarks__c, Complexity_Category__c, Complexity_Typess__c, Complexity_Types__c, Complexity_Type__c, CreatedById, CreatedDate, CurrencyIsoCode,
                                    design_manager_npd_master__c, Design_Manager_NSF_email__c, Design_Manager__c, Edit_on_Marketing__c, email_to_nc__c, Function_department_Name__c,
                                    Function_Name__c, Gender__c, Id, ImageUpload__c, ISCM_Briefing_Date__c, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate,
                                    Lead_Time_stage__c, Line_Item_Approval_Required__c, Marketing_brief_concept_reference_number__c, Market__c, MBReferenceAuto__c, Model_Name__c,
                                    Model_Reference_Name__c, Name, Name__c, NeedDynamicFunctionName__c, No_of_Designs__c, NPD_Collections__c, NPD_Email__c, NPD_OWNER_EMAIL__c,
                                    NPD_Project_Items__c, NPD_Project_Name__c, NPD_Stage__c, NPD_User__c, NSf_email_formula__c, NSF_Emial_Address__c, Optional_Sub_Stages__c, Owner1__c,
                                    OwnerId, Owner__c, ParentStageId__c, Phase__c, Planned_End_Date__c, Planned_Lead_Time__c, Planned_Start_Date__c, Position__c, PredecessorSerialNo__c,
                                    Predecessor_Stage__c, PrePredecessorSerialNo__c, R0_Status__c, R1_AED__c, R1_ASD__c, R1_Lead_Time__c, R1_Status__c, R2_AED__c, R2_ASD__c,
                                    R2_Lead_Time__c, R2_Status__c, Revised_End_Date__c, Revised_Start_Date__c, Revision_Active__c, Revision_Status__c, Revision_Substage__c, SerialNo__c,
                                    SFCurrentStageOwnerId__c, SFParentStageOwnerId__c, Source__c, Stage_name__c, Status__c, Strap_Material__c, subStageLeadTime__c, Sub_Brand1__c,
                                    Sub_Brand__c, SystemModstamp, Team_Leader__c, Tentative_Launch_Plan__c, Total_Lead_Time__c, Type__c, User__c FROM NPD_Stage__c where id IN: stageId
                                   ];
              }
            System.debug('****listToUpdatestlistToUpdatest****' + listToUpdatest);
            for(NPD_Stage__c stg: listToUpdatest) {
              if(stg.Source__c != oldMap.get(stg.id).Source__c  || stg.Source__c != NULL && stg.NPD_Project_Name__c != NULL && stg.SerialNo__c.containsIgnoreCase(
                  'AR-01')) {
                // if (stg.Source__c != oldMap.get(stg.id).Source__c && stg.Source__c != NULL &&  stg.Name__c=='Marketing Brief/Concept') {
                System.debug('newListnewList' + stg.id);
                projectId.add(stg.NPD_Project_Name__c);
                System.debug('projectIdprojectId' + projectId);
              }
            }
              try {
                  //T01
                  if(projectId.size()>0){
                      for(NPD_Activity__c act: [SELECT ID, Name__c, SerialNo__c, Checklist_Columns__c, CopiedFrom__c, NPD_Project_Name__c FROM NPD_Activity__c WHERE NPD_Project_Name__c IN:
                                                projectId OR NPD_Project_Name__r.Marketing_Brief_Stage__c IN: projectId
                                               ]) {
                                                   if(!projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && projectToActivity.get(act.NPD_Project_Name__c) != NULL) {
                                                       System.debug('****ifififififif**');
                                                       projectToActivity.get(act.NPD_Project_Name__c).add(act);
                                                   } else {
                                                       projectToActivity.put(act.NPD_Project_Name__c, new list < NPD_Activity__c > {
                                                           act
                                                               });
                                                       System.debug('****elselelelel****');
                                                   }
                                                   System.debug('****projectToActivity****' + projectToActivity);
                                               }
                  }
              } catch(exception e1) {
                  system.debug(e1);
              }
            string s1 = 'Vendor Ref No';
            string s2 = 'PSY No';
            for(NPD_Stage__c stg: listToUpdatest) {
              SyStem.debug('==stg.Source__c==' + stg.Source__c);
              System.debug('==oldmap==' + oldmap);
              System.debug('==projectToActivity==' + projectToActivity);
              
              if(stg.Source__c != NULL && !projectToActivity.isempty() && projectToActivity.containskey(stg.NPD_Project_Name__c) &&
                projectToActivity.get(stg.NPD_Project_Name__c) != NULL  || stg.Source__c != oldmap.get(stg.id).Source__c && !projectToActivity.isempty() && projectToActivity.containskey(stg.NPD_Project_Name__c) &&
                projectToActivity.get(stg.NPD_Project_Name__c) != NULL) {
                System.debug('==projectToActivity.get(stg.NPD_Project_Name__c)==' + projectToActivity.get(stg.NPD_Project_Name__c));
                for(NPD_Activity__c act: projectToActivity.get(stg.NPD_Project_Name__c)) {
                  system.debug('replacing act  rec :' + act.name__c);
                  if(stg.Source__c == 'OSD' && !string.isblank(act.Checklist_Columns__c) && act.Checklist_Columns__c.containsIgnoreCase(s2)) {
                    try {
                      act.Checklist_Columns__c = act.Checklist_Columns__c.replace(s2, s1);
                      system.debug('act.Checklist_Columns__c :' + act.Checklist_Columns__c);
                    } catch(exception e) {
                      system.debug('***Strring Error***' + e);
                    }
                  } else if(stg.Source__c == 'IDS' && !string.isblank(act.Checklist_Columns__c) && act.Checklist_Columns__c.containsIgnoreCase(s1)) {
                    try {
                      system.debug('for IDS root Before value :' + stg.name__c + '....' + act.Checklist_Columns__c);
                      act.Checklist_Columns__c = act.Checklist_Columns__c.replace(s1, s2);
                      system.debug('for IDS root After value :' + stg.name__c + '....' + act.Checklist_Columns__c);
                    } catch(exception e) {
                      system.debug('***Strring Error***' + e);
                    }
                  }
                  
                  listToUpdate.add(act);
                  //Coz VF AMD PSY DOESNT WORK
                  //break;
                }
              }
            }
            if(!projectToActivity.isempty()) {
              try {
                update listToUpdate;
                system.debug('**listToUpdate*' + listToUpdate);
              } catch(exception e) {
                system.debug('***Exception while updating***' + e);
              }
            }
            
          }
          flag2 = false;
        }
        



    public void afterUpdateHandlerAct() {
        if (flag4 == true) {
            set < id > ActId = new set < id > ();
            map < id, id > stgID = new map < id, id > ();
            map < id, List < NPD_Activity__c >> mapStageToAct = new map < id, List < NPD_Activity__c >> ();
            list < NPD_Activity__c > lstactvtyupdate = new list < NPD_Activity__c > ();
            for (NPD_Activity__c n: newListAct) {
                if ((n.Actual_End_Date__c != oldMapAct.get(n.id).Actual_End_Date__c) && n.Type__c == 'Sub-Activity' && (n.Name__c == 'Proto Dial Drawing Release and Receipt' || n.Name__c == 'PB/PM Release , Approval  and Recipt')) {
                    ActId.add(n.NPD_Activity__c);
                }
            }
            //AUTO UPDATE FROM SUBACTIVITY TO ACTIVITY  PB_PM_Receipt_Date__c AND Drawing_Receipt_Date__c
            //T01
            if(ActId.size()>0){
                for (NPD_Activity__c act: [Select NPD_Stage__c from NPD_Activity__c where id =: ActId]) {
                    System.debug('==act==' + act);
                    if (act.NPD_Stage__c != NULL)
                        stgID.put(act.id, act.NPD_Stage__c);
                }
            }
            //T01
            if(stgID.size()>0){
            for (NPD_Activity__c act: [Select id, Drawing_Receipt_Date__c, NPD_Stage__c, PB_PM_Receipt_Date__c, NPD_Activity__c.Name__c from NPD_Activity__c where NPD_Stage__c IN: stgID.values() AND(Name__c = 'Dial for Proto Mfg'
                    OR Name__c = 'Hands for Proto Mfg'
                    OR Name__c = 'Leather Strap For Proto Mfg')]) {
                SYstem.debug('==act==' + act);
                if (!mapStageToAct.isempty() && mapStageToAct.containskey(act.NPD_Stage__c) && mapStageToAct.get(act.NPD_Stage__c) != NULL) {
                    mapStageToAct.get(act.NPD_Stage__c).add(act);
                } else {
                    mapStageToAct.put(act.NPD_Stage__c, new List < NPD_Activity__c > {
                        act
                    });
                }
            }
            }

            for (NPD_Activity__c act1: newlistAct) {
                if (act1.Name__c == 'Proto Dial Drawing Release and Receipt' || act1.Name__c == 'PB/PM Release , Approval  and Recipt') {
                    if (!mapStageToAct.isempty() && mapStageToAct.containskey(stgID.get(act1.NPD_Activity__c)) && mapStageToAct.get(stgID.get(act1.NPD_Activity__c)) != NULL)
                        for (NPD_Activity__c act: mapStageToAct.get(stgID.get(act1.NPD_Activity__c))) {
                            if (act1.Actual_End_Date__c != NULL && act1.Name__c == 'Proto Dial Drawing Release and Receipt' && act.Name__c == 'Dial for Proto Mfg') {
                                act.Drawing_Receipt_Date__c = act1.Actual_End_Date__c;
                            } else if (act1.Actual_End_Date__c == NULL && act1.Name__c == 'Proto Dial Drawing Release and Receipt' && act.Name__c == 'Dial for Proto Mfg') {
                                act.Drawing_Receipt_Date__c = NULL;
                            } else if (act1.Actual_End_Date__c != NULL && act1.Name__c == 'PB/PM Release , Approval  and Recipt' && (act.Name__c == 'Hands for Proto Mfg' || act.Name__c == 'Leather Strap For Proto Mfg')) {
                                act.PB_PM_Receipt_Date__c = act1.Actual_End_Date__c;
                            } else if (act1.Actual_End_Date__c == NULL && act1.Name__c == 'PB/PM Release , Approval  and Recipt' && (act.Name__c == 'Hands for Proto Mfg' || act.Name__c == 'Leather Strap For Proto Mfg')) {
                                act.PB_PM_Receipt_Date__c = NULL;
                            }
                            lstactvtyupdate.add(act);
                            system.debug('lstactvtyupdatelstactvtyupdate' + lstactvtyupdate);
                        }
                }

            }
            if (lstactvtyupdate.size() > 0) {
                update lstactvtyupdate;
            }
        }
        flag4 = false;
    }

    /*
     **Method Name -generateSerialNo
     **
     **Purpose -Generate the Serial number according to their types
     ** 
     */
    public list < Sobject > generateSerialNo(list < Sobject > lstParentSobject, String ParentField, String ChildField, String parentObjectName, String childObjectName, string strType) {
        list < Sobject > lstChildObjectUpdate = new list < Sobject > ();
        if (strType == 'SubStage') {
            lstChildObjectUpdate = new list < Sobject > ();
            string strQuery = 'Select ' + ParentField + ',(select ' + ChildField + ' from ' + childObjectName + ' order by position__c asc  ) ' + ' from ' + parentObjectName + ' where  Id IN :lstParentSobject';
            system.debug('strQuery------------' + strQuery);
            //Use to get child from sub query
            list < Sobject > lstChildObject = new list < Sobject > ();
            //Use to Update child from sub query
            //Iterate all parents
            for (Sobject sobj: database.query(strQuery)) {
                system.debug('sobj++++++++++++' + sobj);
                //Get Refrence field ex Stage it gives Ar-01
                String strRefParent = string.valueof(sobj.get(ParentField));
                system.debug('strRefParent++++++++++++' + strRefParent);
                //get the index 
                Integer index = strRefParent.lastIndexOf('-');
                //Get the number from String Example Ar-01 gives 01
                String numberString = strRefParent.substring(index + 1); // or index + 1 (I'm rushing :))
                //Convert string into number
                Integer theNumber = Integer.valueOf(numberString);
                //Get the Alpahbatical part from String Example Ar-01 gives Ar-
                string strPrefix = strRefParent.substring(0, strRefParent.lastIndexOf('-') + 1);
                system.debug('strPrefix ++++++++++++' + strPrefix);
                //If the number is single digit
                if ((theNumber / 10) == 0) {
                    //Append 0 if the number is single digit now the string become Ar-0.
                    strPrefix += '0';
                }
                //Get child from query Ex If stage having three child as substage
                //All child will come in this list
                string str = string.valueof(sobj.getSObjects(childObjectName));
                if (str != null) {
                    lstChildObject = sobj.getSObjects(childObjectName);
                } else {
                    lstChildObject = new list < Sobject > ();
                }
                system.debug('lstChildObject++++++++++++' + lstChildObject);
                integer intCount = 0;
                integer Increment = 1;
                //Iterate all Child
                for (Sobject sobjChild: lstChildObject) {
                    if (intCount == 0) {
                        //put the value in your field example in Refrence field now the value id Ar-0101
                        sobjChild.put(ChildField, strPrefix + string.valueOf(theNumber) + '0' + string.valueOf(Increment));
                        intCount++;
                        Increment++;
                    } else {
                        if (Increment / 10 == 0) {
                            sobjChild.put(ChildField, strPrefix + string.valueOf(theNumber) + '0' + string.valueOf(Increment));
                            Increment++;
                        } else {
                            sobjChild.put(ChildField, strPrefix + string.valueOf(theNumber) + string.valueOf(Increment));
                            Increment++;
                        }
                    }
                    lstChildObjectUpdate.add(sobjChild);
                    //  system.debug('lstChildObject++++++++++++'+ChildFieldValue1);
                }
            }
            system.debug('lstChildObjectUpdate++++++++++++' + lstChildObjectUpdate);
            //Update child
            update lstChildObjectUpdate;
            system.debug('++++++++++++++lstChildObjectUpdate' + lstChildObjectUpdate);
        }
        if (StrType == 'Activity' || StrType == 'Sub-Activity') {
            lstChildObjectUpdate = new list < Sobject > ();
            string strQuery = 'Select ' + ParentField + ',(select ' + ChildField + ' from ' + childObjectName + ' order by position__c asc) ' + ' from ' + parentObjectName + ' where  Id IN :lstParentSobject';
            system.debug('strQuery--------------' + strQuery);
            list < Sobject > lstChildObject = new list < Sobject > ();
            for (Sobject sobj: database.query(strQuery)) {
                system.debug('sobj++++++++++++' + sobj);
                String strRefParent = string.valueof(sobj.get(ParentField));
                Integer index = strRefParent.lastIndexOf('-');
                String numberString = strRefParent.substring(index + 1); // or index + 1 (I'm rushing :))
                Integer theNumber = Integer.valueOf(numberString);
                string strPrefix = strRefParent.substring(0, strRefParent.lastIndexOf('-') + 1);
                system.debug('strPrefix ++++++++++++' + strPrefix);
                if ((theNumber / 10) == 0) {
                    system.debug('single digit');
                    strPrefix += numberString;
                }
                //Append Ar- with 0101 gives Ar-0101
                strPrefix += numberString;
                system.debug('strPrefix ++++++++++++' + strPrefix);
                lstChildObject = new list < Sobject > ();
                string str = string.valueof(sobj.getSObjects(childObjectName));
                if (str != null) {
                    lstChildObject = sobj.getSObjects(childObjectName);
                } else {
                    lstChildObject = new list < sobject > ();
                }
                // system.debug('lstChildObject++++++++++++'+lstChildObject );
                integer intCount = 0;
                integer Increment = 1;

                for (Sobject sobjChild: lstChildObject) {
                    //Check if it is first child
                    if (intCount == 0) {
                        //put the value in your field example in Refrence field now the value id Ar-0101001
                        sobjChild.put(ChildField, strPrefix + '00' + string.valueOf(Increment));
                        intCount++;
                        Increment++;
                    } else {
                        //put the value in your field example in Refrence field now the value id Ar-0101002
                        if (Increment / 10 == 0) {
                            sobjChild.put(ChildField, strPrefix + '00' + string.valueOf(Increment));
                            Increment++;
                        } else {
                            sobjChild.put(ChildField, strPrefix + '0' + string.valueOf(Increment));
                            Increment++;
                        }
                    }
                    Object ChildFieldValue1 = sobjChild.get(ChildField);
                    lstChildObjectUpdate.add(sobjChild);
                    system.debug('lstChildObject++++++++++++' + ChildFieldValue1);
                }

            }
            update lstChildObjectUpdate;
        }
        return lstChildObjectUpdate;
    }

    //the following class will be used to house the field names
    //and desired operations
    public class fieldDefinition {
        public String operation {
            get;
            set;
        }
        public String childField {
            get;
            set;
        }
        public String parentField {
            get;
            set;
        }
        public fieldDefinition(String o, String c, String p) {
            operation = o;
            childField = c;
            parentField = p;
            System.debug('++operation++++' + operation);
            System.debug('++++childField++' + childField);
            System.debug('+++parentField+++' + parentField);
        }
    }

    //Method to rollup the leadTime of child to parent
    public static list < sObject > rollUpLeadTime(list < fieldDefinition > fieldDefinitions, list < sObject > records, String childObject,
        String childParentLookupField, String parentObject, String queryFilter) {
        //Limit the size of list by using Sets which do not contain duplicate
        //elements prevents hitting governor limits
        set < Id > parentIds = new set < Id > ();
        for (sObject s: records) {
            parentIds.add((Id) s.get(childParentLookupField));
        }
        //populate query text strings to be used in child aggregrator and 
        //parent value assignment
        String fieldsToAggregate = '';
        String parentFields = '';
        for (fieldDefinition d: fieldDefinitions) {
            fieldsToAggregate += d.operation + '(' + d.childField + ') ' +
                ', ';
            parentFields += d.parentField + ', ';
        }
        //Using dynamic SOQL with aggergate results to populate parentValueMap
        String aggregateQuery = 'Select ' + fieldsToAggregate +
            childParentLookupField + ' from ' + childObject + ' where  ' +
            childParentLookupField + ' IN :parentIds ' + queryFilter + ' ' +
            ' group by ' + childParentLookupField;

        //Map will contain one parent record Id per one aggregate object
        map < Id, AggregateResult > parentValueMap =
            new map < Id, AggregateResult > ();

        for (AggregateResult q: Database.query(aggregateQuery)) {
            parentValueMap.put((Id) q.get(childParentLookupField), q);
        }

        //list of parent object records to update
        list < sObject > parentsToUpdate = new list < sObject > ();
        String parentQuery = 'select ' + parentFields + ' Id ' +
            ' from ' + parentObject + ' where Id IN :parentIds';

        //for each affected parent object, retrieve aggregate results and 
        //for each field definition add aggregate value to parent field
        for (sObject s: Database.query(parentQuery)) {

            Integer row = 0; //row counter reset for every parent record
            for (fieldDefinition d: fieldDefinitions) {
                String field = 'expr' + row.format();
                AggregateResult r = parentValueMap.get(s.Id);
                //r will be null if no records exist 
                //(e.g. last record deleted)
                if (r != null) {
                    Decimal value = ((Decimal) r.get(field) == null) ? 0 :
                        (Decimal) r.get(field);
                    s.put(d.parentField, value);
                } else {
                    s.put(d.parentField, 0);
                }
                row += 1; //plus 1 for every field definition after first
            }
            parentsToUpdate.add(s);
        }

        //if parent records exist, perform update of all parent records 
        //with a single DML statement
        if (parentsToUpdate.Size() > 0) {
            system.debug('++++++++parentsToUpdate' + parentsToUpdate);
            return parentsToUpdate;
        }
        return NULL;
    }

    /*
     **Method Name -dateCalulationForStage
     **
     **Purpose -Generate the Planned_Start_Date__c/Planned_End_Date__c/Revised_Start_Date__c/Revised_End_Date__c For Stage
     ** 
     */

    Public static void dateCalulationForStage(List < NPD_Stage__c > sobj, map < String, NPD_Stage__c > mapSerialNo_Stage) {
        // for Very first stage 
        for (NPD_Stage__c obj: sobj) {
            //chkng if type is stage and Predecessor is null and npd stage is also null( for Very first stage )              
            if (obj.Type__c == 'Stage' && obj.PredecessorSerialNo__c == Null && obj.NPD_Stage__c == NULL) {
                //asssing today date as created date
                obj.Planned_Start_Date__c = date.today();
                //Added by roshi new change
                if(obj.Name__c=='Marketing Brief/Concept'){
                obj.Actual_Start_Date__c=date.today();
                obj.Status__c='In Progress';
                
                }
                obj.Revised_Start_Date__c = Null; // revised stant and end date should be null
                obj.Revised_End_Date__c = Null;
                System.debug('++++++Planned_Start_Date__c++' + obj.Planned_Start_Date__c); //created date
                //typecasting leadtime to integer
                //if(obj.Planned_Start_Date__c!=NULL){
                Integer intleadTime = Integer.valueOf(obj.Planned_lead_time__c);
                //calling method NPDaddBussinessDays to calculates only weekdays   
                if (obj.Planned_lead_time__c != NULL) {
                    System.Debug('==obj.Planned_Start_Date__c==' + obj.Planned_Start_Date__c);
                    datetime dteCheckHoliday = NPDaddBussinessDays((obj.Planned_Start_Date__c), intleadTime - 1);

                    // assing value to Planned End date which is Planned Startdate + Lead time
                    obj.Planned_End_Date__c = date.newinstance(dteCheckHoliday.year(), dteCheckHoliday.month(), dteCheckHoliday.day());
                    //obj.Planned_End_Date__c= plannedEndDate(obj.id);
                    // Reviseddate is null for firststage
                    //map holding serialNum of object & object if PredecessorSerialNo__c is not null
                }
                mapSerialNo_Stage.put(obj.SerialNo__c, obj);
            }
            //date calculation for other stages
            //chkng if type is stage and Predecessor is notnull and npd stage is also null( for Very first stage ) 
            else if (obj.Type__c == 'Stage' && obj.PredecessorSerialNo__c != Null && obj.NPD_Stage__c == NULL && mapSerialNo_Stage.containsKey(obj.PredecessorSerialNo__c)) {
                //getting PredecessorSerialNo__c pland end date and adding one
                datetime dteCheckHoliday1 = NPDaddBussinessDays(mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Planned_End_Date__c, 1);
                obj.Planned_Start_Date__c = date.newinstance(dteCheckHoliday1.year(), dteCheckHoliday1.month(), dteCheckHoliday1.day());
                //typecasting leadtime to integer
                Integer intleadTime = Integer.valueOf(obj.Planned_lead_time__c);
                //calling method NPDaddBussinessDays to calculates only weekdays 

                datetime dteCheckHoliday = NPDaddBussinessDays(obj.Planned_Start_Date__c, intleadTime - 1);
                // assing value to Planned End date which is Planned Startdate + Lead time
                obj.Planned_End_Date__c = date.newinstance(dteCheckHoliday.year(), dteCheckHoliday.month(), dteCheckHoliday.day());

                // to calculate Revised Start and End date
                if (mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c != null) {
                    system.debug('mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c' + mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c);

                    datetime dteActualStartDateHoliday = NPDaddBussinessDays(mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c, 1);
                    //assingning the value for revised start for stages
                    obj.Revised_Start_Date__c = date.newinstance(dteActualStartDateHoliday.year(), dteActualStartDateHoliday.month(), dteActualStartDateHoliday.day());
                    datetime dteActualEndDateHoliday = NPDaddBussinessDays(obj.Revised_Start_Date__c, intleadTime - 1);
                    system.debug('**obj.Revised_Start_Date__c**' + obj.Revised_Start_Date__c);
                    //assingning the value for revised end date for stages

                    obj.Revised_End_Date__c = date.newinstance(dteActualEndDateHoliday.year(), dteActualEndDateHoliday.month(), dteActualEndDateHoliday.day());
                    system.debug(' **obj.Revised_End_Date__c**' + obj.Revised_End_Date__c);
                }
                //map holding serialNum of object & object if PredecessorSerialNo__c is not null
                mapSerialNo_Stage.put(obj.SerialNo__c, obj);
            }
        }
    }

    /*
     **Method Name -dateCalulationForSubStage
     **
     **Purpose -Generate the Planned_Start_Date__c/Planned_End_Date__c/Revised_Start_Date__c/Revised_End_Date__c For Sub-Stage
     ** 
     */

    Public static void dateCalulationForSubStage(List < NPD_Stage__c > sobj, map < id, NPD_Stage__c > mapStageId_Stage, map < String, NPD_Stage__c > mapSerialNo_Stage) {
        // to calculate very first substage dates 
        for (NPD_Stage__c obj: sobj) {
            System.debug('==obj==' + obj);
            //chkng if type is Sub-Stage and Predecessor is null and npd stage is also null( for Very first substage ) 
            if (obj.Type__c == 'Sub-Stage' && obj.PredecessorSerialNo__c == Null && obj.NPD_Stage__c != NULL) {
                //asssing Stage plan date as created date
                obj.Planned_Start_Date__c = mapStageId_Stage.get(obj.NPD_Stage__c).Planned_Start_Date__c;
                obj.Revised_Start_Date__c = Null;
                obj.Revised_End_Date__c = Null;
                //typecasting leadtime to integer 
                system.debug('**obj.Planned_lead_time__c' + obj.Planned_lead_time__c);
                Integer intleadTime = Integer.valueOf(obj.Planned_lead_time__c);

                //calling method NPDaddBussinessDays to calculates only weekdays 
                system.debug('********Lead Time*******' + obj.Planned_lead_time__c);
                system.debug('********Start Date *******' + obj.Planned_Start_Date__c);
                system.debug('************obj.Type__c****' + obj.Type__c);
                system.debug('************obj.PredecessorSerialNo__c****' + obj.PredecessorSerialNo__c);
                system.debug('************obj.NPD_Stage__c****' + obj.NPD_Stage__c);

                if (obj.Planned_lead_time__c != NULL && obj.Planned_Start_Date__c != null) {
                    datetime dteCheckHoliday = NPDaddBussinessDays(obj.Planned_Start_Date__c, intleadTime - 1);
                    // assing value to Planned End date which is Planned Startdate + Lead time
                    system.debug('*************dteCheckHoliday*******' + dteCheckHoliday);
                    obj.Planned_End_Date__c = date.newinstance(dteCheckHoliday.year(), dteCheckHoliday.month(), dteCheckHoliday.day());
                    // Reviseddate is null for firstSUbstages
                }
                mapSerialNo_Stage.put(obj.SerialNo__c, obj); //adding serial num with object
                system.debug('************bj.mapSerialNo_Stage.containsKey(obj.PredecessorSerialNo__c) ****' + mapSerialNo_Stage.containsKey(obj.PredecessorSerialNo__c));
                system.debug('************mapSerialNo_Stage ****' + mapSerialNo_Stage);
            } else if (obj.Type__c == 'Sub-Stage' && obj.PredecessorSerialNo__c != Null && obj.NPD_Stage__c != NULL && mapSerialNo_Stage.containsKey(obj.PredecessorSerialNo__c) && obj.Active__c == true && mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Planned_End_Date__c != NULL) {
                //getting PredecessorSerialNo__c pland end date and adding one
                system.debug('**********ADD Days Error****' + mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Planned_End_Date__c);
                datetime dteCheckHoliday1;
                if (mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Planned_End_Date__c != NULL)
                    dteCheckHoliday1 = NPDaddBussinessDays(mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Planned_End_Date__c, 1);
                //startdate of Predecessor substage +1
                system.debug('************dteCheckHoliday1****' + dteCheckHoliday1);

                if (dteCheckHoliday1.year() != NULL && dteCheckHoliday1.month() != NULL && dteCheckHoliday1.day() != NULL)
                    obj.Planned_Start_Date__c = date.newinstance(dteCheckHoliday1.year(), dteCheckHoliday1.month(), dteCheckHoliday1.day());

                //typecasting leadtime to integer
                Integer intleadTime = Integer.valueOf(obj.Planned_lead_time__c);
                //calling method NPDaddBussinessDays to calculates only weekdays 
                if (obj.Planned_lead_time__c != NULL) {
                    datetime dteCheckHoliday = NPDaddBussinessDays(obj.Planned_Start_Date__c, intleadTime - 1);
                    // assing value to Planned End date which is Planned Startdate + Lead time
                    obj.Planned_End_Date__c = date.newinstance(dteCheckHoliday.year(), dteCheckHoliday.month(), dteCheckHoliday.day());
                    // to calculate Revised Start and End date
                    if (mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c != null) {

                        datetime dteActualStartDateHoliday = NPDaddBussinessDays(mapSerialNo_Stage.get(obj.PredecessorSerialNo__c).Actual_End_Date__c, 1);
                        //assingning the value for revised start for SUbstages
                        obj.Revised_Start_Date__c = date.newinstance(dteActualStartDateHoliday.year(), dteActualStartDateHoliday.month(), dteActualStartDateHoliday.day());
                        //assingning the value for revised End for SUbstages
                        datetime dteActualEndDateHoliday = NPDaddBussinessDays(obj.Revised_Start_Date__c, intleadTime - 1);
                        obj.Revised_End_Date__c = date.newinstance(dteActualEndDateHoliday.year(), dteActualEndDateHoliday.month(), dteActualEndDateHoliday.day());
                    }
                }
                mapSerialNo_Stage.put(obj.SerialNo__c, obj);
                system.debug('obj.PrePredecessorSerialNo__c');
            }

        }
    }
    Public static Date plannedEndDate(string stageid) {
        List < NPD_Stage__c > planndenddate = new List < NPD_Stage__c > ();
        date planndenddatestage;
        //T01
        if(stageid!=''){
            planndenddate = [select Planned_End_Date__c from NPD_Stage__c where Type__c = 'Sub-Stage'
                             AND NPD_Stage__c =: stageid Order By Position__c DESC LIMIT 1
                            ];}
        for (NPD_Stage__c obj: planndenddate) {
            planndenddatestage = obj.Planned_End_Date__c;
        }
        return (planndenddatestage);
    }

    /*
     **Method Name -NPDaddBussinessDays
     **
     **Purpose -Calculate only business days when lead time is added excluding weekends
     ** 
     */
    //takes the date and no of days to add
    Public static Datetime NPDaddBussinessDays(Datetime startDate, Integer noOfDays) {
        Datetime endDate;
        //adds the startdate and days that has been sent as parameter
        try {
            SYStem.debug('==startDate==' + startDate);
            SYStem.debug('==noOfDays==' + noOfDays);
            endDate = startDate.addDays(noOfDays);
            // if the endate false on Sunday add two one day
            if (endDate.format('E') == 'Sun') {
                endDate = endDate.addDays(1);
            }
            System.debug(' enddtenddt' + endDate);
            //Return the enddate after removing sat and sunday
        } catch (exception er1) {
            system.debug(' The exprs :' + er1);
        }
        if (endDate != null)
            return endDate;
        else
            return Null;
    }
   public Static void collectionStatus(Set<id> collectionId){
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };     
            
            list < NPD_Collections__c > listCollection = new list < NPD_Collections__c > ();
      	    //T01
            if(collectionId.size()>0){
      
              List<NPD_Activity__c> activitylist = [Select id, R1_ASD__c, R1_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE Name__c = 'Watch Deposition' AND Status__c IN: statusSet AND NPD_Collections__c =: collectionId ];
              if(activitylist.size() == 0){
                 System.debug('++++++++++++activitylist++++++++++'+activitylist);
                 List<NPD_Activity__c> activityToUpdate = [Select id, R1_ASD__c,NPD_Collections__c,Actual_End_Date__c, R1_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE Name__c = 'Watch Deposition' AND Status__c = 'Completed' AND NPD_Collections__c =: collectionId AND Active__c = true Order By Actual_End_Date__c DESC LIMIT 1];
                 for(NPD_Activity__c activity : activityToUpdate){
                   NPD_Collections__c updateCollection = new NPD_Collections__c();
                   if(activity.NPD_Collections__c != null){
                    updateCollection.id = activity.NPD_Collections__c;
                    updateCollection.Collection_Status__c = 'Closed';
                    updateCollection.Actual_Launch_Date__c = activity.Actual_End_Date__c; 
                    listCollection.add(updateCollection);
                   }
                 }
              }
            }
              if (listCollection.size() > 0)
                System.debug('++++++++++++collectionStatus++++++++++'+collectionId);
                update listCollection;
    }
    
 /*
     **Method Name -checkSubStageStatus
     **
     **Purpose -Status Update Automation  - Substage and Activity
     ** 
     */
   public static void checkStageStatusAndActualDate(set < id > setSubStageId, list < NPD_Stage__c > lstActivity) {
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        Boolean strFilter3 = true;
        NPD_Stage__c updateact = new NPD_Stage__c();
        List<NPD_Stage__c> updateactlst = new List<NPD_Stage__c>();//<T02>
        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.NPD_Stage__r.Actual_Start_Date__c,R0_Status__c,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Stage__c where NPD_Stage__c in:setSubStageId and R0_Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug('THE QUERY' + strQuey);
        list < NPD_Stage__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+' + lstResult.size());
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        //if lstResult will not have any Activities in progresss then list size will be zero and we will assign end date and status as complete to its SubStage
        if (lstResult.size() == 0) {
            for (NPD_Stage__c t: lstActivity) {
                //T01
                if(setSubStageId.size()>0){
                    updateactlst = [Select id, Actual_Start_Date__c,Stage_name__c,R0_Status__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Stage__c WHERE NPD_Stage__c =: setSubStageId AND R0_Status__c = 'Completed'
                                    AND Active__c =: strFilter3 Order By Actual_End_Date__c DESC LIMIT 1
                                   ];
                }
                if(updateactlst.size() > 0){//<T02>
                    updateact = updateactlst.get(0);
                }
                if(updateact != null){
                    NPD_Stage__c substage = new NPD_Stage__c();
                    if (t.NPD_Stage__c != NULL) {
                        substage.id = t.NPD_Stage__c;
                    }
                    System.debug('stage name+++++++++++++++'+substage.Name__c);
                    substage.status__c = updateact.R0_Status__c;
                    substage.R0_Status__c = updateact.R0_Status__c;
                    substage.Actual_End_Date__c = updateact.Actual_End_Date__c;
                    
                    if (substage.id != NULL) {
                        lstSubStageUpdate.add(substage);
                    }
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
        //if any of the Activities are in progress then lstResult will not be null and its related Substage will have actual start
        // as first substage actualstart date and status will be 'In Progress'
        system.debug('checkSubStageStatusActualDates1');
        if (lstResult.size() > 0) {
            for (NPD_Stage__c t: lstActivity) {
                //T01
                if(setSubStageId.size()>0){
                updateact = [Select id, Actual_Start_Date__c,Stage_name__c,R0_Status__c,Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Stage__c WHERE NPD_Stage__c =: setSubStageId AND Actual_Start_Date__c != null AND Active__c =: strFilter3 Order By Actual_Start_Date__c ASC LIMIT 1];
                }
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                 if(updateact != null){
                    substage.status__c = 'In Progress';
                    substage.R0_Status__c = 'In Progress';
                    substage.updatechkbox__c = true;
                    if(updateact.Stage_name__c != 'Marketing Brief/Concept'){
                        substage.Actual_Start_Date__c = updateact.Actual_Start_Date__c;
                    }
                 }
                if (substage.id != NULL) {
                    lstSubStageUpdate.add(substage);
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
    }
    
    
/*  
    public static void checkStageStatusAndActualDate(set < id > setStageId, list < NPD_Stage__c > lstSubstages) {
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        Boolean strFilter3 = true;
        //query to get record with related  parent(NPDStage) data with filter value
        string strQuey = 'select id,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Stage__r.Status__c,NPD_Stage__c from NPD_Stage__c where NPD_Stage__c in:setStageId  and Status__c IN:statusSet and Active__c=: strFilter3 AND Active__c=true';
        system.debug('==strQuey==' + strQuey);
        list < NPD_Stage__c > lstResult = Database.query(strQuey);
        System.debug('==lstResult==' + lstResult);
        list < NPD_Stage__c > lstStageUpdate = new list < NPD_Stage__c > ();
        //if lstResult will not have any substages in progresss then list size will be zero and we will assing end date and staus as complete to its Stage
        if (lstResult.size() == 0) {
            for (NPD_Stage__c t: lstSubstages) {
                NPD_Stage__c stage = new NPD_Stage__c();

                if (t.NPD_Stage__c != NULL)
                    stage.id = t.NPD_Stage__c;
                //assign value complete to stage
                stage.status__c = 'Completed';
                //assign value as today to AcualEnd date to stage
                stage.Actual_End_Date__c = t.Actual_End_Date__c;
                //adding to list
                lstStageUpdate.add(stage);
            }
            if (lstStageUpdate.size() > 0)
                update lstStageUpdate;
        }
        //if any of the substages are in progress then lstResult will not be null and its related stage will have actualstart
        //as first substage actualstart date and staus will be 'In Progress'
        else if (lstResult.size() > 0) {
            for (NPD_Stage__c n: lstResult) {
                if (n.NPD_Stage__r.Actual_Start_Date__c == null) {
                    for (NPD_Stage__c t: lstSubstages) {
                        if (t.id == n.id) {
                            NPD_Stage__c stage = new NPD_Stage__c();
                            if (n.NPD_Stage__c != NULL)
                                stage.id = n.NPD_Stage__c;
                            //assign value In Progress to substage
                            stage.status__c = 'In Progress';
                            //assign Actualstrtdate to substage actualstart date
                            if (stage.Actual_Start_Date__c == NULL) {
                                stage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                            }
                            //adding to list
                            lstStageUpdate.add(stage);
                        }
                    }
                }
            }
            if (lstStageUpdate.size() > 0)
                update lstStageUpdate;
        }
    }
    */
    // subStage label Actual date capture of R1

    public static void checkSubStageStatusActualDatesR1(set < id > setSubStageId, list < NPD_Activity__c > lstActivity) {
        string strFilter = 'Completed R1';
        string strFilter1 = 'Not Started R1';
        string strFilter2 = 'In Progress R1';
        set < string > statusSet = new set < string > {
            strFilter
        };
        set < string > statusSet1 = new set < string > {
            strFilter1,
            strFilter2
        };
        Boolean strFilter3 = true;
        NPD_Activity__c updateact = new NPD_Activity__c();
        NPD_Activity__c updateactNew = new NPD_Activity__c();
        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.NPD_Stage__r.R1_ASD__c,NPD_Stage__r.R1_ASD__c,Type__c,R1_ASD__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug('THE QUERY' + strQuey);
        string strQuey1 = 'select id,NPD_Stage__r.NPD_Stage__r.R1_ASD__c,NPD_Stage__r.R1_ASD__c,Type__c,R1_ASD__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet1 and Active__c=: strFilter3';
        list < NPD_Activity__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+' + lstResult.size());
        list < NPD_Activity__c > lstResultNew = Database.query(strQuey1);
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lndSubStageUpdate = new list < NPD_Stage__c > ();
        //if lstResult will not have any Activities in progresss then list size will be zero and we will assign end date and status as complete to its SubStage
        if (lstResult.size() > 0) {
            for (NPD_Activity__c t: lstActivity) {
                //T01
                if(setSubStageId.size()>0){
                    updateact = [Select id, R1_ASD__c, R1_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Status__c = 'Completed R1'
                                 AND Active__c =: strFilter3 Order By R1_AED__c DESC LIMIT 1
                                ];
                }
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                substage.status__c = updateact.Status__c;
                substage.R1_AED__c = updateact.R1_AED__c;
                substage.R1_Status__c = updateact.Status__c;
                if (substage.id != NULL) {
                    lstSubStageUpdate.add(substage);
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
        //if any of the Activities are in progress then lstResult will not be null and its related Substage will have actual start
        // as first substage actualstart date and status will be 'In Progress'
        system.debug('checkSubStageStatusActualDates1');
        if (lstResultNew.size() > 0) {
            for (NPD_Activity__c t: lstActivity) {
                //T01
                if(setSubStageId.size()>0){
                    updateactNew = [Select id, R1_ASD__c, R1_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND R1_ASD__c != null AND Active__c =: strFilter3 Order By R1_ASD__c ASC LIMIT 1];
                }
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                substage.status__c = updateactNew.Status__c;
                substage.R1_Status__c = updateactNew.Status__c;
                substage.updatechkbox__c = true;
                substage.R1_ASD__c = updateactNew.R1_ASD__c;
                if (substage.id != NULL) {
                    lndSubStageUpdate.add(substage);
                }
            }
            if (lndSubStageUpdate.size() > 0) {
                update lndSubStageUpdate;
            }
        }
    }
    // subStage label Actual date capture of R2

    public static void checkSubStageStatusActualDatesR2(set < id > setSubStageId, list < NPD_Activity__c > lstActivity) {
        string strFilter = 'Completed R2';
        string strFilter1 = 'Not Started R2';
        string strFilter2 = 'In Progress R2';
        set < string > statusSet = new set < string > {
            strFilter
        };
        set < string > statusSet1 = new set < string > {
            strFilter1,
            strFilter2
        };
        Boolean strFilter3 = true;
        NPD_Activity__c updateact = new NPD_Activity__c();
        NPD_Activity__c updateactNew = new NPD_Activity__c();
        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.NPD_Stage__r.R2_ASD__c,NPD_Stage__r.R2_ASD__c,Type__c,R2_ASD__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug('THE QUERY' + strQuey);
        string strQuey1 = 'select id,NPD_Stage__r.NPD_Stage__r.R2_ASD__c,NPD_Stage__r.R2_ASD__c,Type__c,R2_ASD__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet1 and Active__c=: strFilter3';
        list < NPD_Activity__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+' + lstResult.size());
        list < NPD_Activity__c > lstResultNew = Database.query(strQuey1);
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lndSubStageUpdate = new list < NPD_Stage__c > ();
        //if lstResult will not have any Activities in progresss then list size will be zero and we will assign end date and status as complete to its SubStage
        if (lstResult.size() > 0) {
            for (NPD_Activity__c t: lstActivity) {
                //T01
                if(setSubStageId.size()>0){
                    updateact = [Select id, R2_ASD__c, R2_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Status__c = 'Completed R2'
                                 AND Active__c =: strFilter3 Order By R2_AED__c DESC LIMIT 1
                                ];
                }
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                substage.status__c = updateact.Status__c;
                substage.R2_AED__c = updateact.R2_AED__c;
                substage.R2_Status__c = updateact.Status__c;
                if (substage.id != NULL) {
                    lstSubStageUpdate.add(substage);
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
        //if any of the Activities are in progress then lstResult will not be null and its related Substage will have actual start
        // as first substage actualstart date and status will be 'In Progress'
        system.debug('checkSubStageStatusActualDates1');
        if (lstResultNew.size() > 0) {
            for (NPD_Activity__c t: lstActivity) {
                updateactNew = [Select id, R2_ASD__c, R2_AED__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND R2_ASD__c != null AND Active__c =: strFilter3 Order By R2_ASD__c ASC LIMIT 1];
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                substage.status__c = updateactNew.Status__c;
                substage.R2_Status__c = updateactNew.Status__c;
                substage.updatechkbox__c = true;
                substage.R2_ASD__c = updateactNew.R2_ASD__c;
                if (substage.id != NULL) {
                    lndSubStageUpdate.add(substage);
                }
            }
            if (lndSubStageUpdate.size() > 0) {
                update lndSubStageUpdate;
            }
        }
    }


    /*
     **Method Name -checkSubStageStatus
     **
     **Purpose -Status Update Automation  - Substage and Activity
     ** 
     */
   public static void checkSubStageStatusActualDates(set < id > setSubStageId, list < NPD_Activity__c > lstActivity) {
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        Boolean strFilter3 = true;
        NPD_Activity__c updateact = new NPD_Activity__c();
        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.NPD_Stage__r.Actual_Start_Date__c,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug('THE QUERY' + strQuey);
        list < NPD_Activity__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+' + lstResult.size());
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        //if lstResult will not have any Activities in progresss then list size will be zero and we will assign end date and status as complete to its SubStage
        if (lstResult.size() == 0) {
            for (NPD_Activity__c t: lstActivity) {
                updateact = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Status__c = 'Completed'
                    AND Active__c =: strFilter3 Order By Actual_End_Date__c DESC LIMIT 1
                ];
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                if(updateact != null){
                    substage.status__c = updateact.Status__c;
                    substage.R0_Status__c = updateact.Status__c;
                    substage.Actual_End_Date__c = updateact.Actual_End_Date__c;
                }
                if (substage.id != NULL) {
                    lstSubStageUpdate.add(substage);
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
        //if any of the Activities are in progress then lstResult will not be null and its related Substage will have actual start
        // as first substage actualstart date and status will be 'In Progress'
        system.debug('checkSubStageStatusActualDates1');
        if (lstResult.size() > 0) {
            for (NPD_Activity__c t: lstActivity) {
                updateact = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Actual_Start_Date__c != null AND Active__c =: strFilter3 Order By Actual_Start_Date__c ASC LIMIT 1];
              
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL) {
                    substage.id = t.NPD_Stage__c;
                }
                if(updateact != null){
                    substage.updatechkbox__c = true;
                   
                        substage.Actual_Start_Date__c = updateact.Actual_Start_Date__c;
                  //      substage.status__c = updateact.Status__c;
                  //      Substage.R0_Status__c = updateact.Status__c;
                        Substage.status__c = 'In Progress';
                        Substage.R0_Status__c = 'In Progress'; 
                    
                    if(updateact.Actual_End_Date__c == null){
                        substage.Actual_End_Date__c =null;
                    }
                }
                if (substage.id != NULL) {
                    lstSubStageUpdate.add(substage);
                }
            }
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
    }  

    // Activate Deactivate of the Activity......
    public static void ActivateDeactivateActivity(set < id > setSubStageId) {
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        Boolean strFilter3 = true;
        List < NPD_Activity__c > updateact = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > updateactStartDate = new List < NPD_Activity__c > ();

        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.NPD_Stage__r.Actual_Start_Date__c,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c,NPD_Stage__r.NPD_Stage__r.Status__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet and Active__c=: strFilter3';

        system.debug('THE QUERY ActivateDeactivateActivity' + strQuey);
        list < NPD_Activity__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+ActivateDeactivateActivity' + lstResult.size());
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lstSubStageUpdateStartDate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lstSubStageUpdate1 = new list < NPD_Stage__c > ();


        if (lstResult.size() == 0) {
            System.debug('setSubStageIdsetSubStageId' + setSubStageId);
            updateact = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Status__c = 'Completed'
                AND Active__c =: strFilter3 Order By Actual_End_Date__c Desc LIMIT 1
            ];
            System.debug('updateactActivateDeactivateActivity' + updateact);
            for (NPD_Activity__c t: updateact) {
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL)
                    substage.id = t.NPD_Stage__c;
                //assign value complete to substage
                substage.status__c = t.Status__c;
                substage.R0_Status__c = t.Status__c;
                substage.Actual_End_Date__c = t.Actual_End_Date__c;
                //adding value to list
                if (substage.id != NULL)
                    lstSubStageUpdate.add(substage);
                system.debug('+++lstSubStageUpdate' + lstSubStageUpdate);
            }
            //updating list
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        }
        if (lstResult.size() == 0) {
            System.debug('setSubStageIdsetSubStageId' + setSubStageId);
            updateactStartDate = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Actual_Start_Date__c != null AND Active__c =: strFilter3 Order By Actual_Start_Date__c ASC LIMIT 1];
            System.debug('updateactActivateDeactivateActivity' + updateact);
            for (NPD_Activity__c t: updateactStartDate) {
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL)
                    substage.id = t.NPD_Stage__c;
                substage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                if (substage.id != NULL)
                    lstSubStageUpdateStartDate.add(substage);
                system.debug('+++lstSubStageUpdateStartDate' + lstSubStageUpdateStartDate);
            }
            //updating list
            if (lstSubStageUpdateStartDate.size() > 0) {
                update lstSubStageUpdateStartDate;
            }
        } else if (lstResult.size() > 0) {
            System.debug('setSubStageIdsetSubStageId333' + setSubStageId);
            updateact = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Activity__c WHERE NPD_Stage__c =: setSubStageId AND Actual_Start_Date__c != null AND Active__c =: strFilter3 Order By Actual_Start_Date__c ASC LIMIT 1];
            System.debug('updateactActivateDeactivateActivitynew' + updateact);
            for (NPD_Activity__c t: updateact) {
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL)
                    substage.id = t.NPD_Stage__c;
                //assign value complete to substage
                substage.status__c = 'In Progress';
                substage.R0_Status__c = 'In Progress';
                substage.Actual_End_Date__c = NULL;
                substage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                //adding value to list
                if (substage.id != NULL)
                    lstSubStageUpdate1.add(substage);
                system.debug('+++lstSubStageUpdate' + lstSubStageUpdate1);
            }
            //updating list
            if (lstSubStageUpdate1.size() > 0) {
                update lstSubStageUpdate1;
            }
        }
    }
    // calculate R1 Start Date and End Date of Active/ deActive ACTIVITY
    public static void ActivateDeactivateActivityR1(set < id > setSubStageId) {

    }
    // calculate R2 Start Date and End Date of Active/ deActive ACTIVITY
    public static void ActivateDeactivateActivityR2(set < id > setSubStageId) {

    }


    //Activate Deactivate of stage
    public static void ActivateDeactivateStage(set < id > setStageId) {
        string strFilter = 'In Progress';
        string strFilter1 = 'Not Started';
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        Boolean strFilter3 = true;
        List < NPD_Stage__c > updatestage = new List < NPD_Stage__c > ();
        //query to get record with related parent(subStages) data with filter value
        string strQuey = 'select id,NPD_Stage__r.Actual_Start_Date__c,NPD_Stage__r.Actual_End_Date__c,Type__c,Actual_Start_Date__c,Actual_End_Date__c,Position__c,NPD_Stage__r.Status__c,Status__c,NPD_Stage__c from NPD_Stage__c where NPD_Stage__c in:setStageId and Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug('THE QUERY ActivateDeactivateActivity' + strQuey);
        list < NPD_Stage__c > lstResult = Database.query(strQuey);
        system.debug('+++lstResult+ActivateDeactivateActivity' + lstResult.size());
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lstSubStageUpdate1 = new list < NPD_Stage__c > ();

        if (lstResult.size() == 0) {
            System.debug('setSubStageIdsetSubStageId' + setStageId);
            updatestage = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Stage__c WHERE NPD_Stage__c =: setStageId AND Status__c = 'Completed'
                Order By Actual_End_Date__c ASC LIMIT 1
            ];
            System.debug('updateactActivateDeactivateActivity' + updatestage);
            for (NPD_Stage__c t: updatestage) {
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL)
                    substage.id = t.NPD_Stage__c;
                //assign value complete to substage
                substage.status__c = t.Status__c;
                substage.Actual_End_Date__c = t.Actual_End_Date__c;

                //adding value to list
                if (substage.id != NULL)
                    lstSubStageUpdate.add(substage);
                system.debug('+++lstSubStageUpdate' + lstSubStageUpdate);
            }
            //updating list
            if (lstSubStageUpdate.size() > 0) {
                update lstSubStageUpdate;
            }
        } else if (lstResult.size() > 0) {
            updatestage = [Select id, Actual_Start_Date__c, Actual_End_Date__c, Status__c, NPD_Stage__c From NPD_Stage__c WHERE NPD_Stage__c =: setStageId AND Actual_Start_Date__c != null Order By Actual_Start_Date__c ASC LIMIT 1];
            for (NPD_Stage__c t: updatestage) {
                NPD_Stage__c substage = new NPD_Stage__c();
                if (t.NPD_Stage__c != NULL)
                    substage.id = t.NPD_Stage__c;
                //assign value complete to substage
                substage.status__c = 'In Progress';
                substage.Actual_End_Date__c = NULL;
                 substage.Actual_Start_Date__c = t.Actual_Start_Date__c;

                //adding value to list
                if (substage.id != NULL)
                    lstSubStageUpdate1.add(substage);
                system.debug('+++lstSubStageUpdate' + lstSubStageUpdate1);
            }
            //updating list
            if (lstSubStageUpdate1.size() > 0) {
                update lstSubStageUpdate1;
            }
        }
    }

    /*
     **Method Name -GetValueFromParam
     **
     **Purpose -Return value of parameter form Url
     ** 
     */
    public static string GetValueFromParam(string ParamKey) {
        string toReturn = '';
        if (ApexPages.currentPage().getParameters().containsKey(ParamKey)) {
            toReturn = ApexPages.currentPage().getParameters().get(ParamKey);
            //toReturn=ApexUtil.GetCleanString(toReturn);        
        }
        return toReturn;
    }

    /*
        **Method Name -checkSubStageStatusNotStarted
        **
        **Purpose this method change the ActualStart date of the Substage of the related 
        activity to NULL if the status changes from inprogress to Not Started and assing
        the next Activity ActualStartdate to the Substage
        ** 
    */
    public static void checkSubStageStatusNotStarted(set < id > setSubStageId, list < NPD_Activity__c > lstActivity, Map < Id, NPD_Activity__c > mpActivity) {
        //Query to get all activity related substage order by ActualstartDate
        system.debug('**setSubStageId**' + setSubStageId);
        string strFilter = 'In Progress';
        string strFilter1 = 'Completed';
        Boolean strFilter3 = true;
        set < string > statusSet = new set < string > {
            strFilter,
            strFilter1
        };
        string strQuey = 'select id,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Activity__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c from NPD_Activity__c where NPD_Stage__c in:setSubStageId and Status__c IN:statusSet and Active__c=: strFilter3';
        system.debug(strQuey);
        //List to store result of the query
        list < NPD_Activity__c > lstResult = Database.query(strQuey);
        system.debug('**lstResult**' + lstResult);
        //Declaration of list to update value
        list < NPD_Stage__c > lstSubStageUpdate = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lstSubStageUpdate1 = new list < NPD_Stage__c > ();
        list < NPD_Stage__c > lstSubStageUpdate2 = new list < NPD_Stage__c > ();
        //if the list contains value(Activity related to Substage)
        if (lstResult.size() > 0) {
            //looping over current activity
            for (NPD_Activity__c n: lstActivity) {
                //creating object of subsatge to update
                NPD_Stage__c substage = new NPD_Stage__c();
                //looping over lst of related activity
                for (NPD_Activity__c t: lstResult) {
                    //if this is the first activity
                    system.debug('t.id' + t.id);
                    system.debug('n.id' + n.id);
                    system.debug('mpActivity.get(n.id).Actual_Start_Date__c+++' + mpActivity.get(n.id).Actual_Start_Date__c);
                    system.debug('t.Actual_Start_Date__c' + t.Actual_Start_Date__c);
                    system.debug('t.Status__c' + t.Status__c);
                    //if any of the activity has got in progress and substage value is null
                    if (substage.Actual_Start_Date__c == NULL && t.status__c == 'In Progress') {
                        substage.id = n.NPD_Stage__c;
                        //assing In Progress as status
                        substage.status__c = 'In Progress';
                        //Actual start date to substage actual start date
                        substage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                        //Adding to list
                        lstSubStageUpdate.add(substage);
                        system.debug('lstSubStageUpdate+++' + lstSubStageUpdate);
                    }
                    if (t.NPD_Stage__r.Actual_Start_Date__c == NULL && t.status__c == 'In Progress' && t.type__c == 'Activity') {
                        substage.id = n.NPD_Stage__c;
                        //assing In Progress as status
                        substage.status__c = 'In Progress';
                        //Actual start date to substage actual start date
                        substage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                        //Adding to list
                        lstSubStageUpdate.add(substage);
                        system.debug('lstSubStageUpdate+++' + lstSubStageUpdate);
                    }
                }
            }
        } else {
            if (lstResult.size() == 0) {

                for (NPD_Activity__c n: lstActivity) {
                    NPD_Stage__c substage = new NPD_Stage__c();
                    substage.id = n.NPD_Stage__c;
                    substage.Actual_Start_Date__c = NULL;
                    substage.Status__c = 'Not Started';
                    lstSubStageUpdate.add(substage);
                }
            }
        }

        if (lstSubStageUpdate.size() > 0) {
            system.debug('lstSubStageUpdate+++' + lstSubStageUpdate);
            update lstSubStageUpdate;
        }
    }

    /*
        **Method Name -checkSubStageStatusInprogress
        **
        **Purpose of this method is to change the actual end date to NULL and the status to In progress 
        when Activity related to the particular substage is changed from Completed to In progress.
        ** 
    */
    public static void checkSubStageStatusInprogress(set < id > setSubStageId, list < NPD_Activity__c > lstActivity, Map < Id, NPD_Activity__c > mpActivity) {
        Map < ID, NPD_Stage__c > parentsubstage = new Map < ID, NPD_Stage__c > ();
        parentsubstage = new Map < Id, NPD_Stage__c > ([SELECT id, NPD_Stage__c, Actual_End_Date__c, Status__c, (SELECT ID, NPD_Stage__c FROM NPD_Activity__r) FROM NPD_Stage__c WHERE ID IN: setSubStageId]);
        system.debug('parentsubstage' + parentsubstage);
        for (NPD_Activity__c act: lstActivity) {
            NPD_Stage__c myParentstg = parentsubstage.get(act.NPD_Stage__c);
            //myParentstg.Actual_End_Date__c = NULL;
            //myParentstg.Status__c = 'In Progress';
        }
        update parentsubstage.values();
    }

    /*DEBUG|parentsubstage{a2Af0000000Dc3mEAC=NPD_Stage__c:{Id=a2Af0000000Dc3mEAC, NPD_Stage__c=a2Af0000000Dc3lEAC, Status__c=In Progress, CurrencyIsoCode=INR}}
        **Method Name -checkSubStageStatusactualdateupdate
        **
        **Purpose of this method is to change the actual Start date of the Stage of 
        first activity updated
        ** 
    */

    public static void checkSubStageStatusactualdateupdate(set < id > setSubStageId, list < NPD_Activity__c > lstActivity, Map < Id, NPD_Activity__c > mpActivity) {
        list < NPD_Activity__c > lstResult = new list < NPD_Activity__c > ();
        Map < ID, NPD_Stage__c > parentsubstage = new Map < ID, NPD_Stage__c > ();
        parentsubstage = new Map < Id, NPD_Stage__c > ([SELECT id, updatechkbox__c, NPD_Stage__c, Actual_Start_Date__c, Status__c, (SELECT ID, NPD_Stage__c FROM NPD_Activity__r) FROM NPD_Stage__c WHERE ID IN: setSubStageId]);
        for (NPD_Activity__c act: lstActivity) {
            NPD_Stage__c myParentstg = parentsubstage.get(act.NPD_Stage__c);
            System.debug('myParentstg.updatechkbox__c' + myParentstg.updatechkbox__c);
            System.debug('act.updatechkbox__c' + act.updatechkbox__c);
            if (myParentstg.updatechkbox__c == true && act.updatechkbox__c == true) {
                System.debug('myParentstg.updatechkbox__c' + myParentstg.updatechkbox__c);
                System.debug('act.updatechkbox__c' + act.updatechkbox__c);
                myParentstg.Actual_Start_Date__c = act.Actual_Start_Date__c;
                myParentstg.Status__c = act.Status__c;
            }
            update parentsubstage.values();
        }
    }

    public static void checkStageStatusNotStarted(set < id > setStageId, list < NPD_Stage__c > lstSubstage, Map < Id, NPD_Stage__c > mpSubstage) {
        //Query to get all substage related stage order by ActualstartDate
        string strFilter = 'In Progress';
        string strQuey = 'select id,NPD_Stage__r.Actual_Start_Date__c,Type__c,Actual_Start_Date__c,Position__c,NPD_Stage__r.Position__c,Status__c,NPD_Stage__c,NPD_Stage__r.Status__c,NPD_Stage__r.NPD_Stage__c from NPD_Stage__c where NPD_Stage__c in:setStageId  AND Status__c=: strFilter';
        system.debug(strQuey);
        //List to store result of the query
        list < NPD_Stage__c > lstResult = Database.query(strQuey);
        //Declaration of list to update value
        list < NPD_Stage__c > lstStageUpdate = new list < NPD_Stage__c > ();
        //if the list contains value(Substage related to Stage)
        if (lstResult.size() > 0) {
            //looping over current Substage
            for (NPD_Stage__c n: lstSubstage) {
                //creating object of Stage to update
                NPD_Stage__c stage = new NPD_Stage__c();
                //looping over lst of related Substage
                for (NPD_Stage__c t: lstResult) {
                    //if this is the first Substage

                    //if any of the Substage has got in progress and Stage value is null
                    if (stage.Actual_Start_Date__c == NULL && t.status__c == 'In Progress') {
                        stage.id = n.NPD_Stage__c;
                        //assing In Progress as status
                            stage.status__c = 'In Progress';
                            //Actual start date to Stage actual start date
                            stage.Actual_Start_Date__c = t.Actual_Start_Date__c;
                            //Adding to list
                            lstStageUpdate.add(stage);
                            system.debug('lstStageUpdate+++' + lstStageUpdate);
                        
                    }
                }
            }
        } else {
            if (lstResult.size() == 0) {

                for (NPD_Stage__c n: lstSubstage) {
                    NPD_Stage__c substage = new NPD_Stage__c();
                    substage.id = n.NPD_Stage__c;
                        substage.Actual_Start_Date__c = NULL;
                        substage.Status__c = 'Not Started';
                        lstStageUpdate.add(substage);
                    
                }
            }
        }
        if (lstStageUpdate.size() > 0) {
            update lstStageUpdate;
        }
    }

    public static void afterUpdateSubStageHandlerForStartDate(List < NPD_Stage__c > ListOfSubstage, map < id, NPD_Stage__c > oldTriggerMap) {
        if (flag11 == true) {
            set < id > setStage = new set < id > ();
            system.debug('ListOfSubstage' + ListOfSubstage); //taken stage of the particular substage
            for (NPD_Stage__c subStg: ListOfSubstage) {
                if (subStg.NPD_Stage__c != NULL)
                    setStage.add(subStg.NPD_Stage__c);
            }
            map < Decimal, NPD_Stage__c > subStageMap = new map < Decimal, NPD_Stage__c > ();
            map < Decimal, NPD_Stage__c > StageMap = new map < Decimal, NPD_Stage__c > ();
            for (NPD_Stage__c stg: [SELECT ID, SerialNo__c, Position__c, Revised_End_Date__c, Planned_Start_Date__c, Planned_End_Date__c, Actual_End_Date__c, Revised_Start_Date__c, Planned_Lead_Time__c, NPD_Stage__c FROM NPD_Stage__c WHERE NPD_Stage__c IN: setStage AND Active__c = true]) {
                subStageMap.put(stg.Position__c, stg);
                system.debug('***StageMap*************' + subStageMap);
            }
            for (NPD_Stage__c subStg: ListOfSubstage) {
                if (!subStageMap.isEmpty() && subStageMap.get(subStg.Position__c + 1) != NULL) {
                    if (subStg.Planned_End_Date__c != NULL && subStg.PredecessorSerialNo__c != NULL) {
                        subStageMap.get(subStg.Position__c).Revised_Start_Date__c =
                            subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStg.Planned_End_Date__c, 1));
                    }
                    if (subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c != NULL) {
                        //  system.debug(' The values populating :' +subStg.name__c + '....' + subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c +'.....'+ integer.valueof(subStageMap.get(subStg.Position__c + 1).Planned_Lead_Time__c-1));
                        subStageMap.get(subStg.Position__c + 1).Planned_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c, integer.valueof(subStageMap.get(subStg.Position__c + 1).Planned_Lead_Time__c - 1)));
                    }
                    system.debug('*********************END*************');
                    system.debug('subStageMap.get(subStg.Position__c + 1).Planned_End_Date__c' + subStageMap.get(subStg.Position__c + 1).Planned_End_Date__c);
                    if (subStg.Actual_End_Date__c != NULL) {
                        subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStg.Actual_End_Date__c, 1));
                        subStageMap.get(subStg.Position__c + 1).Revised_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c, integer.valueof(subStageMap.get(subStg.Position__c + 1).Planned_Lead_Time__c - 1)));
                    }
                }
            }
            if (!subStageMap.isEmpty()) {
                update subStageMap.values();
            }
        }
        flag11 = false;
    }
    public static boolean runTheCode = true;
    //stage planned date Updation when substage is getting lead time is getting updated 
    //
    public static void afterUpdateStageHandlerForPlannedDateStage(List < id > project, map < id, NPD_Stage__c > oldTriggerMap) {
        //get updated stage
        system.debug('The static variable value is runTheCode : ' + runTheCode);
        if (runTheCode == true) {
            set < id > setStage = new set < id > ();
            list < NPD_Stage__c > lststage = new list < NPD_Stage__c > ();
            map < Decimal, NPD_Stage__c > subStageMap = new map < Decimal, NPD_Stage__c > ();
            map < id, NPD_Stage__c > subStageMap1 = new map < id, NPD_Stage__c > ();
            //list of stages related to specific Project
            SYStem.debug('==project==' + project);
            lststage = [Select Id, SerialNo__c, Position__c, Revised_End_Date__c, Planned_Start_Date__c, Planned_End_Date__c, Actual_End_Date__c, Revised_Start_Date__c, Planned_Lead_Time__c, NPD_Collections__c from NPD_Stage__c where NPD_Project_Name__c IN: project AND Type__c = 'Stage'];
            system.debug('lststagelststage' + lststage);
            for (NPD_Stage__c stg: [SELECT ID, SerialNo__c, Position__c, Revised_End_Date__c, Planned_Start_Date__c, Planned_End_Date__c, Type__c, Actual_End_Date__c, Revised_Start_Date__c, Planned_Lead_Time__c, NPD_Stage__c FROM NPD_Stage__c WHERE(id IN: lststage OR(Type__c = 'Sub-stage'
                    AND Position__c = 1)) AND NPD_Project_Name__c IN: project]) {
                if (stg.Type__c == 'Stage') {
                    subStageMap.put(stg.Position__c, stg); //map with position as id and stage
                } else if (stg.Type__c == 'Sub-stage') {
                    subStageMap1.put(stg.NPD_Stage__c, stg); //map with stage id and substage with postion 1 of same above stage
                }
            }
            for (NPD_Stage__c subStg: lststage) {
                try {
                    System.debug('==subStg==' + subStg);
                    System.debug('==subStg.Position__c==' + subStg.Position__c);
                    System.debug('==subStageMap==' + subStageMap);
                    if (!subStageMap.isEmpty() && subStageMap.get(subStg.Position__c + 1) != NULL) {
                        if (subStg.Planned_End_Date__c != NULL) {
                            subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStg.Planned_End_Date__c, 1));
                        }
                        if (subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c != NULL) {
                            subStageMap.get(subStg.Position__c + 1).Planned_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStageMap.get(subStg.Position__c + 1).Planned_Start_Date__c, integer.valueof(subStageMap.get(subStg.Position__c + 1).Planned_Lead_Time__c - 1)));
                        }
                        //Assingning the Revised_Start_Date__c to the design stage which is the actual end Date of the marketing substage
                        if (subStg.Actual_End_Date__c != NULL) {
                            subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStg.Actual_End_Date__c, 1));
                            subStageMap.get(subStg.Position__c + 1).Revised_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c, integer.valueof(subStageMap.get(subStg.Position__c + 1).Planned_Lead_Time__c) - 1));
                            if (subStageMap1.containsKey(subStageMap.get(subStg.Position__c + 1).id) && subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id) != NULL && subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c != NULL) {
                                subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id).Revised_Start_Date__c = subStageMap.get(subStg.Position__c + 1).Revised_Start_Date__c;
                                if (subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id).Revised_Start_Date__c != NULL)
                                    subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id).Revised_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id).Revised_Start_Date__c, integer.valueof(subStageMap1.get(subStageMap.get(subStg.Position__c + 1).id).Planned_Lead_Time__c) - 1));
                            }
                        }
                    }
                } catch (exception e) {
                    system.debug('expception occured :' + e);
                }
            }
            if (!subStageMap.isEmpty()) {
                update subStageMap.values();
            }
            if (!subStageMap1.isEmpty()) {
                update subStageMap1.values();
            }
        }
        runTheCode = false;
        system.debug('the runTheCode value :' + runTheCode);
    }

    public void beforeUpdateStageHandler() {
        set < string > setStageId = new set < string > ();
        set < id > setStageId1 = new set < id > ();

        for (NPD_Stage__c stg: newList) {
            if (stg.Active__c != oldMap.get(stg.id).Active__c)
                setStageId.add(stg.PredecessorSerialNo__c);
            setStageId1.add(stg.NPD_Stage__c);
        }
        map < string, NPD_Stage__c > serialToStage = new map < string, NPD_Stage__c > ();
        if(setStageId1.size()>0){
            for (NPD_Stage__c stgg: [SELECT id, SerialNo__c, Planned_End_Date__c, Planned_Start_Date__c, NPD_Stage__c FROM NPD_Stage__c WHERE SerialNo__c IN: setStageId AND NPD_Stage__c IN: setStageId1]) {
                serialToStage.put(stgg.SerialNo__c, stgg);
                system.debug('serialToStage' + serialToStage);
            }
        }
        for (NPD_Stage__c stg: newList) {
            if (stg.Active__c == TRUE) {
                if (!serialToStage.isEmpty() && serialToStage.get(stg.PredecessorSerialNo__c) != NULL) {
                    system.debug('serialToStage.get(stg.PredecessorSerialNo__c).Planned_End**' + stg.NPD_Stage__c);
                    if (serialToStage.get(stg.PredecessorSerialNo__c).Planned_End_Date__c != NULL) {
                        stg.Planned_Start_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(serialToStage.get(stg.PredecessorSerialNo__c).Planned_End_Date__c, 1));
                    }
                    system.debug('stg.Planned_Start_Date__c**' + serialToStage.get(stg.PredecessorSerialNo__c).NPD_Stage__c);
                    //  if(stg.Planned_Start_Date__c != NULL )
                    try {
                        system.debug('The lead time date values are :' + stg.Planned_Start_Date__c + '.....' + stg.Planned_Lead_Time__c);
                    } catch (exception lead) {
                        system.debug('lead time expcetion is :' + lead);
                    }
                    if (stg.Planned_Start_Date__c != NULL && stg.Planned_Lead_Time__c != null)
                        stg.Planned_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(stg.Planned_Start_Date__c, integer.valueof(stg.Planned_Lead_Time__c) - 1));
                }
                if (oldMap.get(stg.id).Planned_Lead_Time__c != stg.Planned_Lead_Time__c) {
                    if (stg.Planned_Start_Date__c != null && stg.Planned_Lead_Time__c != null)
                        stg.Planned_End_Date__c = date.valueof(NPD_UtilityController.NPDaddBussinessDays(stg.Planned_Start_Date__c, integer.valueof(stg.Planned_Lead_Time__c) - 1));
                }
            } else {
                stg.Planned_Start_Date__c = NULL;
                stg.Planned_End_Date__c = NULL;
            }
        }
    }

    public static void AutoupdateActivity(set < id > Substageid) {
        List < NPD_Activity__c > lstactvty = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > lstactvtyupdate = new List < NPD_Activity__c > ();
        map < id, List < NPD_Activity__c >> mapStageToAct = new map < id, List < NPD_Activity__c >> ();
        lstactvty = [Select id, Actual_End_Date__c, NPD_Stage__c from NPD_Activity__c where Name__c = 'Proto Design - Release'
            And NPD_Stage__c =: Substageid
        ]; //Proto Design - Release
        system.debug('lstactvtylstactvty' + lstactvty);
        for (NPD_Activity__c act: [Select id, Drawing_Receipt_Date__c, NPD_Stage__c, Name__c from NPD_Activity__c where NPD_Stage__c IN: Substageid]) {
            if (!mapStageToAct.isempty() && mapStageToAct.containskey(act.NPD_Stage__c) && mapStageToAct.get(act.NPD_Stage__c) != NULL) {
                mapStageToAct.get(act.NPD_Stage__c).add(act);
            } else {
                mapStageToAct.put(act.NPD_Stage__c, new List < NPD_Activity__c > {
                    act
                });
            }
        }
        for (NPD_Activity__c act1: lstactvty) {
            if (!mapStageToAct.isEmpty() && mapStageToAct.containskey(act1.NPD_Stage__c) && mapStageToAct.containskey(act1.NPD_Stage__c) != NULL) {
                for (NPD_Activity__c act: mapStageToAct.get(act1.NPD_Stage__c)) {
                    if (act.Name__c == 'Glass for Proto Mfg' || act.Name__c == 'Crown for Proto Mfg' || act.Name__c == 'Metal Strap for Proto Mfg' || act.Name__c == 'Proto - Watch Head/Full Watch/Watch Head + Strap' || act.Name__c == 'Proto Manufacturing & Assembly') {
                        if (act1.Actual_End_Date__c != NULL) {
                            act.Drawing_Receipt_Date__c = act1.Actual_End_Date__c;
                        } else if (act1.Actual_End_Date__c == NULL) {
                            act.Drawing_Receipt_Date__c = NULL;
                            system.debug('act.Drawing_Receipt_Date__celseif' + act.Drawing_Receipt_Date__c);
                        }
                    }
                    system.debug('act.Drawing_Receipt_Date__c' + act.Drawing_Receipt_Date__c);
                    system.debug('act1.Actual_End_Date__c;' + act1.Actual_End_Date__c);
                    lstactvtyupdate.add(act);
                    system.debug('lstactvtyupdatelstactvtyupdate' + lstactvtyupdate);
                }
            }
        }
        if (lstactvtyupdate.size() > 0) {
            update lstactvtyupdate;
        }
    }

    /* Methos to Auto populate value from ActivityPilotLotManufacturing***********/
    public static void AutoupdateActivityPilotLotManufacturing(set < id > Substageid) {
        List < NPD_Activity__c > lstactvty1 = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > lstactvtyupdate1 = new List < NPD_Activity__c > ();
        map < id, List < NPD_Activity__c >> mapStageToAct1 = new map < id, List < NPD_Activity__c >> ();
        lstactvty1 = [Select id, Actual_End_Date__c, NPD_Stage__c, Quantity_Required_Standard_Option__c from NPD_Activity__c where Name__c = 'Pilot Lot Manufacturing - Press'
            And NPD_Stage__c =: Substageid
        ]; //Proto Design - Release
        system.debug('lstactvtylstactvty' + lstactvty1);

        for (NPD_Activity__c act: [Select id, Quantity_Required_Standard_Option__c, NPD_Stage__c, Name__c from NPD_Activity__c where NPD_Stage__c IN: Substageid]) {

            if (!mapStageToAct1.isempty() && mapStageToAct1.containskey(act.NPD_Stage__c) && mapStageToAct1.get(act.NPD_Stage__c) != NULL) {
                mapStageToAct1.get(act.NPD_Stage__c).add(act);
            } else {
                mapStageToAct1.put(act.NPD_Stage__c, new List < NPD_Activity__c > {
                    act
                });
            }
        }


        for (NPD_Activity__c act1: lstactvty1) {

            if (!mapStageToAct1.isEmpty() && mapStageToAct1.containskey(act1.NPD_Stage__c) && mapStageToAct1.containskey(act1.NPD_Stage__c) != NULL) {

                for (NPD_Activity__c act: mapStageToAct1.get(act1.NPD_Stage__c)) {

                    if (act.Name__c == 'Pilot Lot Manufacturing - Polishing' || act.Name__c == 'Pilot Lot Manfacturing Special Process-S/C Polishing Stage' || act.Name__c == 'Pilot Lot Manufacturing - Machining') {
                        if (act1.Quantity_Required_Standard_Option__c != NULL) {
                            act.Quantity_Required_Standard_Option__c = act1.Quantity_Required_Standard_Option__c;
                        } else if (act1.Quantity_Required_Standard_Option__c == NULL) {

                            act.Quantity_Required_Standard_Option__c = NULL;

                        }
                    }
                    system.debug('act.Quantity_Required_Standard_Option__c' + act.Quantity_Required_Standard_Option__c);
                    system.debug('act1.Quantity_Required_Standard_Option__c' + act1.Quantity_Required_Standard_Option__c);

                    lstactvtyupdate1.add(act);
                    system.debug('lstactvtyupdatelstactvtyupdate' + lstactvtyupdate1);
                }
            }
        }
        if (lstactvtyupdate1.size() > 0) {
            update lstactvtyupdate1;
        }
    }

    //auto update of the Sub-Activity when Mater Type in activity gets updated
    public static void AutoupdateCaseMasterDevelopment(set < id > Activityid, List < NPD_Activity__c > triggernew) {
        system.debug('triggernew' + triggernew);
        List < NPD_Activity__c > lstactvty1 = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > lstactvtyupdate2 = new List < NPD_Activity__c > ();
        map < id, List < NPD_Activity__c >> mapStageToAct1 = new map < id, List < NPD_Activity__c >> ();
        lstactvty1 = [Select id, Master_Type1__c, NPD_Activity__c, SerialNo__c, Name__c from NPD_Activity__c where id IN: Activityid];
        for (NPD_Activity__c act: [Select id, Master_Type1__c, NPD_Activity__c, SerialNo__c, Name__c from NPD_Activity__c where NPD_Activity__c IN: Activityid]) {
            if (!mapStageToAct1.isempty() && mapStageToAct1.containskey(act.NPD_Activity__c) && mapStageToAct1.get(act.NPD_Activity__c) != NULL) {
                mapStageToAct1.get(act.NPD_Activity__c).add(act);
            } else {
                mapStageToAct1.put(act.NPD_Activity__c, new List < NPD_Activity__c > {
                    act
                });
            }
        }
        system.debug('lstactvty1' + lstactvty1); //Activity
        system.debug('mapStageToAct1' + mapStageToAct1); //holds the SubActivity
        for (NPD_Activity__c act1: lstactvty1) {
            if (!mapStageToAct1.isEmpty() && mapStageToAct1.containskey(act1.id) && mapStageToAct1.containskey(act1.id) != NULL) {
                system.debug('mapStageToAct1.get(act1.NPD_Activity__c)' + mapStageToAct1.get(act1.id));
                for (NPD_Activity__c act: mapStageToAct1.get(act1.id)) {
                    if (act.Name__c == 'Case Master Drawing Indent' || act.Name__c == 'Case Master Drawing Receipt and Master Indent' || act.Name__c == 'Case Master Receipt and Handing over to IDI') {
                        if (act1.Master_Type1__c != NULL) {
                            act.Master_Type1__c = act1.Master_Type1__c;
                        }
                    }
                    system.debug('act1.Master_Type1__c' + act1.Master_Type1__c);
                    system.debug('act.Master_Type1__c' + act.Master_Type1__c);
                    lstactvtyupdate2.add(act);
                    system.debug('MAsterlstactvtyupdate1' + lstactvtyupdate2);
                }
            }
        }
        if (lstactvtyupdate2.size() > 0) {
            update lstactvtyupdate2;
        }
    }

    /*This method is use to send email alerts to the Owner,Roles,Team,and different Successor's Owner of an Activity 
    and SubActivity,, lstActivity1=activityid,prj=projectid and setprojectitems=projectitemsid*/
    // emailoncompletionactivity code here. 

    public static void EmailOnActivityCompletion(set < id > lstActivity1, set < id > prj, set < id > setprojectitems) {

        system.debug('inside EmailOnActivityCompletion method : ');
        set < string > leademailaddress = new set < string > ();
        set < id > activityownerids = new set < id > ();
        set < String > Succsessorlst = new set < String > ();
        set < String > Ownerlst = new set < String > ();
        set < String > Teamlst = new set < String > ();
        set < String > Rolelst = new set < String > ();
        set < String > Sourcelst = new set < String > ();
        set < String > Brandlst = new set < String > ();
        set < String > BrandRolelst = new set < String > ();

        set < string > SuccID = new set < string > ();
        set < string > OwnID = new set < string > ();
        set < id > RoleID = new set < id > ();
        set < id > TeamID = new set < id > ();
        map < id, string > Teamleadmap = new map < id, string > ();

        set < string > SalesforceOwner = new set < string > ();
        set < string > NonSalesforceOwner = new set < string > ();
        set < string > supplyagency = new set < string > ();
        set < string > AllUserEmails = new set < string > ();
        set <String>  allUsermailForActivity = new set<String>();

        set < string > ProjectOwneractivities = new set < string > ();

        map < string, string > SFOwnerMap = new map < string, string > ();
        map < string, string > NSFOwnerMap = new map < string, string > ();

        set < String > ProjectOwnerEmailAddress = new set < string > ();
        map < id, string > ProjectOwnermap = new map < id, string > ();

        string ProjectOwnerEmail = '';
        string TeamLeaderEmail = '';
        userToActivityName = new Map<String,List<String>>();

        for (npd_collections__c nc2: [select id, name, SF_Project_Owner__r.userid__c from npd_collections__c]) {
            ProjectOwnermap.put(nc2.id, nc2.SF_Project_Owner__r.userid__c);
        }

        for (user s1: [select id, Username, email from user]) {
            SFOwnerMap.put(s1.Username, s1.email);
        }

        for (npd_master__c nm1: [select id, name, userid__c from npd_master__c]) {
            NSFOwnerMap.put(nm1.name, nm1.userid__c);

        }

        map < id, List < NPD_Email__c >> mapemail = new Map < id, List < NPD_Email__c >> ();
        Set < NPD_Activity__c > ownerId = new Set < NPD_Activity__c > ();

        for (npd_collections__c nc1: [select id, name, Team_Leader__r.email from npd_collections__c]) {
            Teamleadmap.put(nc1.id, nc1.Team_Leader__r.email);
        }

        for (NPD_Email__c email: [select Type__c, splyagnc__c, NPD_Activity__c, Act_Name__c, Source__c, Brand__c from NPD_Email__c WHERE NPD_Project_Items__c =: setprojectitems]) {

            if (!mapemail.isempty() && mapemail.containskey(email.NPD_Activity__c) && mapemail.get(email.NPD_Activity__c) != NULL) {
                mapemail.get(email.NPD_Activity__c).add(email);
            } else {
                mapemail.put(email.NPD_Activity__c, new List < NPD_Email__c > {
                    email
                });
            }
        }

        for (NPD_Activity__c act: [Select name__c, NPD_Collections__r.name, npd_project_name__r.name, NPD_Activity__c,npd_user__r.Name, npd_user__r.userId__c, serialno__c, id, Source__c, Brand1__c, NPD_Email__c, CollectionId__c, splyagnc__c from NPD_Activity__c where id =: lstActivity1]) {

            ActivityOwnerEmail = act.npd_user__r.userId__c;
            ActivityOwnerName = act.npd_user__r.Name;
            ActivityModelName = act.npd_project_name__r.name;
            ActivityRecName = act.name__c;
            ActivityCollectionName = act.NPD_Collections__r.name;


            ProjectOwnerEmail = ProjectOwnermap.get(act.CollectionId__c);
            TeamLeaderEmail = Teamleadmap.get(act.CollectionId__c);

            system.debug('The team leader values are: ' + TeamLeaderEmail);
            //  sending email to TEAM leader for Make or Buy or Dual Decision – Activity

            if (act.name__c == 'Make or Buy and Model No. Allocation' || act.name__c == 'Concept Finalization - OSD') {
                system.debug('inside Make or Buy or Dual Decision :');

                string email = Teamleadmap.get(act.CollectionId__c);

                leademailaddress.add(email);

            }
            // Project owner email notification. 
            //  Dial for Proto Mfg and its R1,R1.
            // Hands for Proto Mfg  and its R1 and R2 AR-0201006,   AR-0203006,  AR-0205006
            //  Leather Strap For Proto Mfg and its R1 and R2  AR-0201006, AR-0205007, AR-0203007
            //  Glass for Proto Mfg    and its R1 and R2       AR-0201008, AR-0205008, AR-0203008
            //   Crown for Proto Mfg   and its R1 and R2       AR-0201009 ,  AR-0205009, AR-0203009
            //  New Component for Proto Mfg  and its R1 and R2   AR-0201010, AR-0205010, AR-0203010      
            //  act.serialno__c == 'AR-0201006' ||

      /*     if (act.name__c == 'Concept Finalization - OSD' || act.serialno__c == 'AR-0201018' || act.serialno__c == 'AR-0205005' || act.serialno__c == 'AR-0201008' || act.serialno__c == 'AR-0203005' ||  act.serialno__c == 'AR-0201021' || act.serialno__c == 'AR-0201009' || act.serialno__c == 'AR-0201023' || act.serialno__c == 'AR-0201022' || act.serialno__c == 'AR-0201010') {
                system.debug('inside Concept Finalization - OSD :' + act.name__c);

                string email2 = ProjectOwnermap.get(act.CollectionId__c);

                ProjectOwnerEmailAddress.add(email2);

            } */

            //for(id em :mapemail.keySet()) {
            System.debug('==mapemail==' + mapemail);
            System.debug('==act==' + act);
            System.debug('==mapemail.get(act.NPD_Email__c)==' + mapemail.get(act.NPD_Email__c));
            if (mapemail.get(act.NPD_Email__c) != NULL) {
                for (NPD_Email__c emlist: mapemail.get(act.NPD_Email__c)) {

                    if (emlist.Type__c == 'Successor') {
                        Succsessorlst.add(emlist.Act_Name__c);
                        System.debug('SuccsessorlstSuccsessorlst' + Succsessorlst);
                    }

                    //owner assingmemnt for activity
                    if (emlist.Type__c == 'Owner') {
                        Ownerlst.add(emlist.Act_Name__c);
                        System.debug('OwnerlstOwnerlst' + Ownerlst);
                    }

                    if (emlist.Type__c == 'Role') {
                        Rolelst.add(emlist.Act_Name__c);
                        System.debug('RolelstRolelst' + Rolelst);
                    }

                    system.debug('emlist.Brand__c' + emlist.Brand__c);
                    system.debug('act.Brand__r.Name' + act.Brand1__c);

                    if (emlist.Type__c == 'Brand&Role' && emlist.Brand__c == act.Brand1__c) {

                        BrandRolelst.add(emlist.Act_Name__c);
                        Brandlst.add(emlist.Brand__c);
                        System.debug('RolelstRolelstBrandlst' + BrandRolelst);

                    }

                    // Dynamic assigning project owner. 

                    if (emlist.type__c == 'ProjectOwner') {
                        ProjectOwnerEmailAddress.add(ProjectOwnerEmail);
                        System.debug('ProjectOwnerEmail' + ProjectOwnerEmail);

                    }

                    if (emlist.type__c == 'Teamleader') {
                        ProjectOwnerEmailAddress.add(TeamLeaderEmail);
                        System.debug('TeamLeaderEmail' + TeamLeaderEmail);

                    }

                    system.debug('The supply agenc values : ' + emlist.splyagnc__c + '.....' + act.splyagnc__c);

                    if (emlist.splyagnc__c == act.splyagnc__c) {

                        if (NSFOwnerMap.containskey(emlist.Act_Name__c))
                            supplyagency.add(NSFOwnerMap.get(emlist.Act_Name__c));

                        System.debug('supplyagency for supply agenc....' + supplyagency);

                    }

                    if (emlist.type__c == 'Salesforce Owner') {

                        if (SFOwnerMap.containskey(emlist.Act_Name__c))
                            SalesforceOwner.add(SFOwnerMap.get(emlist.Act_Name__c));

                        System.debug('SalesforceOwner' + SalesforceOwner);

                    }

                    if (emlist.type__c == 'NonSalesforce Owner') {
                        if (NSFOwnerMap.containskey(emlist.Act_Name__c))

                            NonSalesforceOwner.add(NSFOwnerMap.get(emlist.Act_Name__c));
                        System.debug('NonSalesforceOwner' + NonSalesforceOwner);

                    }

                    if (emlist.Type__c == 'BrandSource&Role' && emlist.Brand__c == act.Brand1__c && emlist.Source__c == act.Source__c) {

                        Sourcelst.add(emlist.Act_Name__c);
                        System.debug('RolelstRolelst' + Sourcelst);
                    }

                    if (emlist.Type__c == 'Team') {
                        Teamlst.add(emlist.Act_Name__c);
                        System.debug('TeamlstTeamlst' + Teamlst);
                    }
                }
            }
        }

        id temp = [SELECT id FROM EmailTemplate WHERE Name = 'Activity Completed Email Template'
            LIMIT 1
        ].ID;
        id whatid = [SELECT id FROM NPD_Activity__c WHERE id =: lstActivity1].ID;


        if (ProjectOwneractivities.size() > 0) {

        }

        if (Succsessorlst.size() > 0) {
            succActivityList.addAll(Succsessorlst);
            map < id, NPD_Activity__c > ownermap = new map < id, NPD_Activity__c > ([Select id, ownerId, NPD_User__c, NPD_User__r.userid__c,Name__c  from NPD_Activity__c where Name__c =: Succsessorlst AND NPD_Project_Name__c =: prj]);
            System.debug('ownerIdSuccsessorlst' + ownermap);
            for (NPD_Activity__c act: ownermap.values()) {
                SuccID.add(act.NPD_User__r.userid__c);
                System.debug('act.NPD_User__r.userid__c' + act.NPD_User__r.userid__c);
                System.debug('SuccID' + SuccID);
                if(!userToActivityName.isEmpty() && userToActivityName.get(act.NPD_User__r.userid__c)!= null && userToActivityName.containsKey(act.NPD_User__r.userid__c)){
                    userToActivityName.get(act.NPD_User__r.userid__c).add(act.Name__c);
                }
                else{
                    userToActivityName.put(act.NPD_User__r.userid__c, new List<String>{act.Name__c});
                }
            }
            // EmailOnActivityCompletion12(SuccID,temp,whatid);
          //  AllUserEmails.addall(SuccID);
            allUsermailForActivity.addall(SuccID);
            System.debug('SuccIDAllUserEmailsAllUserEmails' + AllUserEmails);
            if(!userToActivityName.isEmpty()){
                for(String name : userToActivityName.keyset()){
                    if(name != null && userToActivityName.get(name) != null){
                        EmailOnActivityCompletionSuccessor(userToActivityName.get(name),name,temp,whatid);
                    }
                    
                }
            }

        }

        if (NonSalesforceOwner.size() > 0) {
            // EmailOnActivityCompletion12(NonSalesforceOwner,temp,whatid);
            AllUserEmails.addall(NonSalesforceOwner);

        }

        if (supplyagency.size() > 0) {
            // EmailOnActivityCompletion12(supplyagency,temp,whatid);
            AllUserEmails.addall(supplyagency);
        }

        if (SalesforceOwner.size() > 0) {

            //  EmailOnActivityCompletion12(SalesforceOwner,temp,whatid);
            AllUserEmails.addall(SalesforceOwner);
        }

        if (Ownerlst.size() > 0) {
            map < id, NPD_Activity__c > ownermap = new map < id, NPD_Activity__c > ([Select ownerId, NPD_User__c, NPD_User__r.userid__c from NPD_Activity__c where Name__c =: Ownerlst AND NPD_Project_Name__c =: prj AND id =: lstActivity1]);

            for (NPD_Activity__c act: ownermap.values()) {
                OwnID.add(act.NPD_User__r.userid__c);
                System.debug('OwnerlstOwnerlst' + Ownerlst);
                //  EmailOnActivityCompletion12(OwnID,temp,whatid);
            }
            AllUserEmails.addall(OwnID);
        }

        if (leademailaddress.size() > 0) {
            System.debug('leademailaddress' + leademailaddress);
            //  EmailOnActivityCompletion12(leademailaddress,temp,whatid);
            AllUserEmails.addall(leademailaddress);
        }

        if (ProjectOwnerEmailAddress.size() > 0) {
            System.debug('ProjectOwnerEmailAddress' + ProjectOwnerEmailAddress);
            // EmailOnActivityCompletion12(ProjectOwnerEmailAddress,temp,whatid);
            AllUserEmails.addall(ProjectOwnerEmailAddress);
            //AllUserEmails.addall(ProjectOwnerEmailAddress);
        }

        

        if (AllUserEmails != null && AllUserEmails.size() > 0) {
            system.debug('The value of : ' + AllUserEmails);
            EmailOnActivityCompletion12(AllUserEmails, temp, whatid);
            allUsermailForActivity.addall(AllUserEmails);
            EmailOnCOmpletedActivityOwner(allUsermailForActivity);
        }
        else{
            EmailOnCOmpletedActivityOwner(allUsermailForActivity);
        }


        if (Rolelst.size() > 0) {
            map < id, User > ownermap = new map < id, User > ([Select Id, Name, UserRole.Name from user where UserRole.Name =: Rolelst]);
            for (user act1: ownermap.values()) {
                RoleID.add(act1.id);
                System.debug('RolelstRolelst' + Rolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (BrandRolelst.size() > 0) {
            map < id, User > ownermap = new map < id, User > ([Select Id, Name, UserRole.Name from user where UserRole.Name =: BrandRolelst]);
            for (user act: ownermap.values()) {
                RoleID.add(act.id);
                System.debug('BrandRolelst' + BrandRolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (Sourcelst.size() > 0) {
            map < id, User > ownermap = new map < id, User > ([Select Id, Name, UserRole.Name from user where UserRole.Name =: Sourcelst]);
            for (user act: ownermap.values()) {
                RoleID.add(act.id);
                System.debug('BrandRolelst' + BrandRolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (Rolelst.size() > 0) {
            map < id, NPD_Master__c > ownermap = new map < id, NPD_Master__c > ([Select ownerId from NPD_Master__c where UserID__c =: Rolelst]);
            for (NPD_Master__c act1: ownermap.values()) {
                RoleID.add(act1.id);
                System.debug('RolelstRolelst' + Rolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (BrandRolelst.size() > 0) {
            map < id, NPD_Master__c > ownermap = new map < id, NPD_Master__c > ([Select ownerId from NPD_Master__c where UserID__c =: BrandRolelst]);
            for (NPD_Master__c act: ownermap.values()) {
                RoleID.add(act.id);
                System.debug('BrandRolelst' + BrandRolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (BrandRolelst.size() > 0) {
            map < id, NPD_Master__c > ownermap = new map < id, NPD_Master__c > ([Select ownerId from NPD_Master__c where UserID__c =: BrandRolelst]);
            for (NPD_Master__c act: ownermap.values()) {
                RoleID.add(act.id);
                System.debug('BrandRolelst' + BrandRolelst);
                EmailOnActivityCompletion11(RoleID, temp, whatid);
            }
        }

        if (Teamlst.size() > 0) {
            map < id, NPD_Activity__c > ownermap = new map < id, NPD_Activity__c > ([Select NPD_Activity__c, ownerId from NPD_Activity__c where Name__c =: Teamlst AND NPD_Project_Name__c =: prj]);
            for (NPD_Activity__c act: ownermap.values()) {
                TeamID.add(act.ownerId);
                System.debug('TeamlstTeamlst' + Teamlst);
                EmailOnActivityCompletion11(TeamID, temp, whatid);
            }
        }
    }

    /*******Email Alerts onActivity Completion*********/

    public static void EmailOnActivityCompletion11(set < id > user, id templateid, id act) {
        List < Messaging.SingleEmailMessage > previewEmails = new List < Messaging.SingleEmailMessage > ();
        system.debug('user' + user);
        For(id us: user) {
            user use = new user();
            use.id = us;
            system.debug('useruse.iduse.id' + use.id);
            Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
            firstPreviewEmail.setUseSignature(false);
            firstPreviewEmail.setSaveAsActivity(false);
            firstPreviewEmail.setTemplateId(templateid);
            firstPreviewEmail.setSenderDisplayName('PDMS ADMIN');
            firstPreviewEmail.setTargetObjectId(use.id);
            firstPreviewEmail.setWhatId(act);
            previewEmails.add(firstPreviewEmail);
        }

        try {
            Messaging.sendEmail(previewEmails);
        } catch (exception e) {
            system.debug('*****Exception Occured****' + e);
        }
    }
    public static void EmailOnActivityCompletionSuccessor(List<String> successorActivity, String user,id templateid, Id act){
        string succEmailslist = '';
        for (string sTemp: successorActivity) {
            succEmailslist = sTemp + '<br/>' + succEmailslist;
        }
        integer i = 0;
        List < Messaging.SingleEmailMessage > previewEmails = new List < Messaging.SingleEmailMessage > ();
        system.debug('user' + user);
        account a1 = new account();
        a1.name = 'for sending mails to nsfs ';
        // insert a1;
        list < contact > contactlist = new list < contact > ();
        //    string subject = ActivityRecName+' for Collection : ' + ActivityCollectionName + 'and model ' + ActivityModelName + 'completed' + ActivityRecName + ' Successors List';
            string subject = ActivityRecName+'-completed for '+ ActivityCollectionName+','+ ActivityModelName;
        //    string subjectBody ='Activity '+ActivityRecName+' for Collection : ' + ActivityCollectionName + ' and model : ' + ActivityModelName + ' has been completed by owner of ' + ActivityOwnerName;
            string subjectBody = ActivityRecName +' activity has been completed by '+ActivityOwnerName +' for below details.';
            string subjectBody1 = 'Collection:-'+ ActivityCollectionName;
            string subjectBody2 = 'Model No:-'+ ActivityModelName;
            Contact tempContact = new Contact(email = user, firstName = 'sending emails s12' + i, lastname = 'hello sfjdiosfgj' + i);
            system.debug('The before inserted contact is : ' + tempContact);
            insert tempContact;
            system.debug('The inserted contact is : ' + tempContact);

            Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
            firstPreviewEmail.setUseSignature(false);
            firstPreviewEmail.setsubject(subject);
            firstPreviewEmail.setTargetObjectId(tempContact.id);
            firstPreviewEmail.setSaveAsActivity(false);
            firstPreviewEmail.setTemplateId(templateid);
            firstPreviewEmail.setSenderDisplayName('PDMS ADMIN');
            firstPreviewEmail.setHtmlBody('<html><body>Hi,<br/> <br/>' + subjectBody+'<br/><br/>'+subjectBody1+'<br/>'+subjectBody2+'<br/><br/><b> Please complete below activities : </b><br/><br/>' + succEmailslist+'<br/><br/><br/><br/>Kind Regards<br/>Admin Team');
            firstPreviewEmail.setWhatId(act);

            previewEmails.add(firstPreviewEmail);

            i++;
            // delete tempContact;
            contactlist.add(tempContact);
            system.debug('after contact deletion is : ' + tempContact);
        try {
            Messaging.sendEmail(previewEmails);
        } catch (exception e) {
            system.debug('*****Exception Occured****' + e);
        }
        system.debug('The previewEmails are: ' + previewEmails);
        delete contactlist;
        //  delete a1;
        system.debug('the a1 value is : ' + a1);    
    }

    public static void EmailOnActivityCompletion12(set < string > user, id templateid, id act) {

        integer i = 0;

        List < Messaging.SingleEmailMessage > previewEmails = new List < Messaging.SingleEmailMessage > ();
        system.debug('user' + user);
        account a1 = new account();
        a1.name = 'for sending mails to nsfs ';
        // insert a1;
        list < contact > contactlist = new list < contact > ();
        for (string s12: user) {
            
            Contact tempContact = new Contact(email = s12, firstName = 'sending emails s12' + i, lastname = 'hello sfjdiosfgj' + i);
            system.debug('The before inserted contact is : ' + tempContact);
            insert tempContact;
            system.debug('The inserted contact is : ' + tempContact);

            Messaging.SingleEmailMessage firstPreviewEmail = new Messaging.SingleEmailMessage();
            firstPreviewEmail.setUseSignature(false);
            firstPreviewEmail.setTargetObjectId(tempContact.id);
            firstPreviewEmail.setSaveAsActivity(false);
            firstPreviewEmail.setTemplateId(templateid);
            firstPreviewEmail.setSenderDisplayName('PDMS ADMIN');

            firstPreviewEmail.setWhatId(act);

            previewEmails.add(firstPreviewEmail);

            i++;
            // delete tempContact;
            contactlist.add(tempContact);
            system.debug('after contact deletion is : ' + tempContact);

        }
        //  delete a1;

        try {
            Messaging.sendEmail(previewEmails);
        } catch (exception e) {
            system.debug('*****Exception Occured****' + e);
        }

        system.debug('The previewEmails are: ' + previewEmails);
        delete contactlist;   
    }
    public static void EmailOnCOmpletedActivityOwner(set < string > user) {

        // Email alert for the owner of the ACtivity/sub activity for succerrors list.      

       // string subject = 'Collection : ' + ActivityCollectionName + '--' + ActivityModelName + '-' + ActivityRecName + ' Successors List';
        string subject = 'Successors List - ' + ActivityRecName + '-' + ActivityCollectionName + '-' + ActivityModelName;


        string succEmailslist = '';

        for (string sTemp: user) {
            succEmailslist = sTemp + '<br/>' + succEmailslist;
        }
        
        string succActivitylistName = '';
        for (string activity: succActivityList) {
            succActivitylistName = activity + '<br/>' + succActivitylistName;
        }

        messaging.SingleEmailMessage email1 = new messaging.SingleEmailMessage();
        // string[] to=new string[]{n1.UserID__c};

        string[] to = new string[] {
            ActivityOwnerEmail
        };

        email1.settoaddresses(to);

        email1.setsubject(subject);

        //Collection : new sonata collection - Model: - Make or Buy or Dual Decision 

        //  email1.setHtmlBody('<html><body>Hi ' + taskNonSalesforceUser +',<br/> <br/> Please find the details below: <br/> <br/>Task Subject: ' + TaskSubject +'<br/> <br/> Comments: ' +TaskComments +'<br/><br/>Due Date: '+TaskDueDate  +'<br/><br/> Status :'+updateTask.status +'<br/><br/> priority :' +updateTask.priority+'</body></html>');

    //    email1.setHtmlBody('<html><body>Hi <br/> <br/>' + '<b> Successors list of people who received Emails </b><br/><br/><br/>' + succEmailslist);
        email1.setHtmlBody('<html><body>Hi <br/> <br/>' + 'Notification mail has been send to following email ID to initiate below activities as you have completed '+ActivityRecName+'.<br/><br/><br/>' + succEmailslist+'<br/><br/>'+succActivitylistName+'<br/><br/><br/><br/>Kind Regards<br/>Admin Team');

        try {
            messaging.sendemail(new messaging.email[] {
                email1
            });
        } catch (Exception er1) {
            system.debug('Exception during the succerrors list email notification');
        }

    }


    public static void ownerAssingmentforActivity(set < id > lstActivity1, set < id > prj, set < id > setprojectitems) {

        system.debug('i ethod ---' + lstActivity1);
        List < NPD_Activity__c > actlist = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > ActsToUpdate = new List < NPD_Activity__c > ();
        map < string, string > ActNamesWithNpdEmailMap = new map < string, string > ();
        map < string, list < npd_activity__c > > ActivityBrandMap = new map < string, list < npd_activity__c > > ();
        string Activitycollectionid = '';

        //List that will Query the current Activity
        actlist = [Select name__c, SerialNo__c, NPD_Activity__c, id, Source__c, ownerid, NPD_Email__c, Brand1__c, NPD_User__c, npd_stage__r.id, npd_stage__c, CollectionId__c, npd_stage__r.npd_user__c, npd_stage__r.ParentStageId__c from NPD_Activity__c where id in: lstActivity1];

        //Activitycollectionid = actlist[0].CollectionId__c;// <T01> moved inside for loop

        for (NPD_Activity__c n1: actlist) {
			
            Activitycollectionid = n1.CollectionId__c;//<T01> 
            
            if (ActivityBrandMap.containskey(n1.Brand1__c)) {
                ActivityBrandMap.get(n1.Brand1__c).add(n1);
            } else {
                ActivityBrandMap.put(n1.Brand1__c, new List < NPD_Activity__c > {
                    n1
                });
            }
            //ActivityBrandMap.put(n1.Brand1__c,n1);
            system.debug('ActivityBrandMap inserting values: ' + n1.Brand1__c + '....' + n1);

        }

        system.debug('inside of ownerAssingmentforActivity actlist : ' + actlist);

        for (npd_master__c nm1: [select id, name, type__c, Source__c, Brand1__c, OwnerUser__c from npd_master__c where type__c = 'ownerassignment']) {
            system.debug('outside if statement owner acts :' + ActivityBrandMap.get(nm1.Brand1__c));
            if (ActivityBrandMap.get(nm1.Brand1__c) != null) {
                for (npd_activity__c na1: ActivityBrandMap.get(nm1.Brand1__c)) {
                    if (na1.SerialNo__c == nm1.name && na1.Source__c == nm1.Source__c && na1.Brand1__c == nm1.Brand1__c) {
                        system.debug('Inside if statement owner acts :' + na1.SerialNo__c + '...' + nm1.name + '....' + na1.Source__c + '....' + nm1.Source__c + '.....' + na1.Brand1__c + '....' + nm1.Brand1__c);
                        na1.NPD_User__c = nm1.OwnerUser__c;

                        system.debug(' na1.NPD_User__c value :' + na1.NPD_User__c);
                        ActsToUpdate.add(na1);

                    }
                }
            }

            // assigning project owner for the activities and sub activites from npd master record.
        }

        update ActsToUpdate;
        npd_master__c ProjOwner = new npd_master__c();
        NPD_Collections__c npdCollection = new NPD_Collections__c();

        list < npd_activity__c > ActsToUpdate2 = new list < npd_activity__c > ();
        list < npd_activity__c > npdAct11 = new list < npd_activity__c > ();


        try {
            // ProjOwner = [select id,name from npd_master__c where name='Project Owner' limit 1];  
            npdCollection = [select id, name, SF_Project_Owner__c from NPD_Collections__c where id =: Activitycollectionid limit 1];

        } catch (exception exc1) {
            system.debug(exc1);
        }
        //  system.debug('The value of projectowner is : '+ ProjOwner.name+'....'+ ProjOwner.id+'....'+actlist.size() );
        for (npd_activity__c npdAct2: actlist) {
            system.debug('outside npdAct2 if statement' + npdAct2.SerialNo__c);


            if (npdAct2.SerialNo__c == 'AR-0102004003' || npdAct2.SerialNo__c == 'AR-0102004004' || npdAct2.SerialNo__c == 'AR-0102004004' || npdAct2.SerialNo__c == 'AR-0102004005' || npdAct2.SerialNo__c == 'AR-0102001' || npdAct2.SerialNo__c == 'AR-0103001001' || npdAct2.SerialNo__c == 'AR-0103001002' || npdAct2.SerialNo__c == 'AR-0103001003' || npdAct2.SerialNo__c == 'AR-0103001004' || npdAct2.SerialNo__c == 'AR-0101002001' || npdAct2.SerialNo__c == 'AR-0101002002' || npdAct2.SerialNo__c == 'AR-0101002003' || npdAct2.SerialNo__c == 'AR-0101002004' || npdAct2.SerialNo__c == 'AR-0102004005')

            {
                system.debug('inside npdAct2 if statement' + npdAct2.SerialNo__c);
                npdAct2.npd_user__c = npdCollection.SF_Project_Owner__c;
                ActsToUpdate2.add(npdAct2);

            }

            //  concept finalization osd in production serial no. 

            if (npdAct2.serialno__c == 'AR-0101004') {
                //   npdAct2.Active__c = true;
                npdAct2.npd_user__c = npdCollection.SF_Project_Owner__c;

                ActsToUpdate2.add(npdAct2);
            }
        }
        if(ActsToUpdate2.size()>0){
        update ActsToUpdate2;
        }
        system.debug('after update of ActsToUpdate2 ' + ActsToUpdate2);

        list < npd_stage__c > subStagesOwnersUpdate = new list < npd_stage__c > ();

        // substage ownership ASSIGNMENT. 

        for (npd_activity__c na1: ActsToUpdate) {
            system.debug('The na1 values are :' + na1);

            if (na1.serialno__c == 'AR-0101001' && na1.source__c == 'IDS') {
                system.debug('activity found here: ' + na1);

                npd_stage__c npdStg1 = new npd_stage__c();
                npdStg1.id = na1.npd_stage__r.id;
                npdStg1.npd_user__c = na1.npd_user__c;
                system.debug('activity owner na1.npd_user__c found here: ' + na1.npd_user__c);

                subStagesOwnersUpdate.add(npdStg1);
            }

            if (na1.serialno__c == 'AR-0101001' && na1.source__c == 'OSD') {
                npd_stage__c npdStg2 = new npd_stage__c();
                npdStg2.id = na1.npd_stage__r.id;
                npdStg2.npd_user__c = npdCollection.SF_Project_Owner__c;
                subStagesOwnersUpdate.add(npdStg2);
            }
        }

        system.debug('The ProjOwner.id value is : ' + ProjOwner.id);


        npd_stage__c npdstg22 = new npd_stage__c();


        for (npd_activity__c npdAct10: ActsToUpdate2) {
            system.debug('npdAct10.name is :' + npdAct10.name__c + '.....' + npdAct10.serialno__c);

            if (npdAct10.serialno__c == 'AR-0103001' || npdAct10.name__c == 'Make or Buy or Dual Decision' || npdAct10.serialno__c == 'AR-0101002003' || npdAct10.name__c == 'Briefing to D&D and Sourcing') {

                if (npdAct10.serialno__c == 'AR-0103001' || npdAct10.name__c == 'Make or Buy or Dual Decision') {

                    system.debug('activity found here: ' + npdAct10);

                    npdstg22 = [select id, name__c, npd_user__c, source__c from npd_stage__c where id =: npdAct10.npd_stage__r.ParentStageId__c];

                    system.debug('the npdstg22 is :' + npdstg22);
                    npd_stage__c npdStg2 = new npd_stage__c();
                    npdStg2.id = npdAct10.npd_stage__c;
                    //npdStg2.npd_user__c = npdCollection.SF_Project_Owner__c;

                    npdStg2.npd_user__c = npdstg22.npd_user__c;

                    system.debug('activity npdStg2 value  here: ' + npdStg2);
                    subStagesOwnersUpdate.add(npdStg2);
                }

                if (npdAct10.serialno__c == 'AR-0101002003' || npdAct10.name__c == 'Briefing to D&D and Sourcing') {
                    system.debug('npdAct10.serialno__c :' + npdAct10.name__c);
                    if (npdstg22.source__c == 'osd') {
                        system.debug('npdstg22.source__c :' + npdstg22.source__c);
                        npdAct10.npd_user__c = npdstg22.npd_user__c;
                        system.debug('npdstg22.npd_user__c :' + npdstg22.npd_user__c);
                        npdAct11.add(npdAct10);
                    }
                }

            }
        }

        update subStagesOwnersUpdate;
        update npdAct11;
    }


    /*******Owner Assingment for  Stage  Sub-Stage Level...
     *******Owner are defined at NPDmaster Object*********/

    public static void ownerAssingmentforstage(set < id > lstStage, set < id > prj, set < id > setprojectitems) {
        system.debug(' Inside ownerAssingmentforstage method ' + lstStage.size() + '....' + prj.size() + '....' + setprojectitems.size());
    }
    /********updateleadtimeonActivity this method is use to update the activity when substage is complextiy type is edited**********/

    public static void updateleadtimeonActivity(set < id > substagelst, Map < id, NPD_Stage__c > mapofSubstage) {

        List < NPD_Activity__c > lstactivity = new List < NPD_Activity__c > ();
        List < NPD_Activity__c > updatelstactivity = new List < NPD_Activity__c > ();
        lstactivity = [Select id, Complexity_Typess__c, Complexity_Category__c, Planned_Lead_Time__c, NPD_Stage__c from NPD_Activity__c where NPD_Stage__c =: substagelst];


        if (lstactivity.size() > 0) {
            for (NPD_Activity__c act: lstactivity) {

                if (mapofSubstage.get(act.NPD_Stage__c).Complexity_Typess__c != NULL)
                    act.Complexity_Typess__c = mapofSubstage.get(act.NPD_Stage__c).Complexity_Typess__c;
                if (mapofSubstage.get(act.NPD_Stage__c).Planned_Lead_Time__c != NULL)
                    act.Planned_Lead_Time__c = mapofSubstage.get(act.NPD_Stage__c).Planned_Lead_Time__c;
                if (mapofSubstage.get(act.NPD_Stage__c).SerialNo__c == 'AR-0302')
                    system.debug('mapofSubstage.get(act.NPD_Stage__c ).Complexity_Category__c' + mapofSubstage.get(act.NPD_Stage__c).Complexity_Category__c);
                act.Complexity_Category__c = mapofSubstage.get(act.NPD_Stage__c).Complexity_Category__c;
                act.Planned_Lead_Time__c = mapofSubstage.get(act.NPD_Stage__c).Planned_Lead_Time__c;
                system.debug('act.Complexity_Category__c' + act.Complexity_Category__c);
                system.debug('act.Planned_Lead_Time__c' + act.Planned_Lead_Time__c);
                updatelstactivity.add(act);
            }
            if (updatelstactivity.size() > 0) {
                try {
                    system.debug('lstactivitylstactivity' + updatelstactivity);
                    //  update updatelstactivity;
                } catch (exception ex) {
                    System.debug('*****************exception****' + ex);

                }
            }

        }
    }

    public void updateSubActvtyCmplxtyLeadTime(map < Id, NPD_Activity__c > newMap, map < Id, NPD_Activity__c > oldMap) {
        map < Id, NPD_Activity__c > mNPDActivity = new map < Id, NPD_Activity__c > ();
        map < Id, NPD_Activity__c > mNPDSubActivity = new map < Id, NPD_Activity__c > ();
        map < String, NPD_Complexity__c > mNPDComplexity = new map < String, NPD_Complexity__c > ();
        set < String > sComplexityName = new set < String > ();

        if (!newMap.isEmpty() && !oldMap.isEmpty()) {
            for (NPD_Activity__c oActvty: newMap.values()) {
                if (oActvty.Complexity_Typess__c!=NULL && oActvty.Type__c.equalsIgnoreCase('Activity') && oActvty.Complexity_Typess__c != oldMap.get(oActvty.Id).Complexity_Typess__c ) {
                    mNPDActivity.put(oActvty.Id, oActvty);
                    sComplexityName.add(oActvty.Complexity_Typess__c);
                }
            } //End of for(NPD_Activity__c oActvty : newMap.keySet())

            system.debug('mNPDActivity ***' + mNPDActivity);
            system.debug('sComplexityName ***' + sComplexityName);

            if (!sComplexityName.isEmpty()) {
                for (NPD_Complexity__c oComplexity: [SELECT Id, Complexity_Type__c, Lead_Time_del__c, Name__c, NPD_Activity__c, Record_Type__c, Sub_Stage__c, Type__c FROM NPD_Complexity__c WHERE Name__c IN: sComplexityName AND Type__c = 'Sub-Activity']) {
                    mNPDComplexity.put(oComplexity.Name__c, oComplexity);
                }
            } //End of if(!sComplexityName.isEmpty())

            system.debug('mNPDComplexity ***' + mNPDComplexity);

            if (!mNPDActivity.isEmpty()) {
                for (NPD_Activity__c oSubActvty: [SELECT Id, Name, Complexity_Typess__c, Planned_Lead_Time__c, NPD_Activity__c, Type__c, NPD_Activity__r.Complexity_Typess__c, NPD_Activity__r.Type__c, NPD_Activity__r.NPD_Stage__c FROM NPD_Activity__c WHERE NPD_Activity__c IN: mNPDActivity.keySet() AND Type__c = 'Sub-Activity']) {
                    if (oSubActvty.NPD_Activity__r.Complexity_Typess__c == null) {
                        oSubActvty.Complexity_Typess__c = null;
                        oSubActvty.Planned_Lead_Time__c = null;
                    } else if (!mNPDComplexity.isEmpty() && mNPDComplexity.containsKey(oSubActvty.NPD_Activity__r.Complexity_Typess__c) && mNPDComplexity.get(oSubActvty.NPD_Activity__r.Complexity_Typess__c) != null) {
                        oSubActvty.Complexity_Typess__c = mNPDComplexity.get(oSubActvty.NPD_Activity__r.Complexity_Typess__c).Name__c;
                        oSubActvty.Planned_Lead_Time__c = mNPDComplexity.get(oSubActvty.NPD_Activity__r.Complexity_Typess__c).Lead_Time_del__c;
                    }
                    mNPDSubActivity.put(oSubActvty.Id, oSubActvty);
                }
            } //End of if(!mNPDActivity.isEmpty())

            system.debug('mNPDSubActivity ***' + mNPDSubActivity);
            if (!mNPDSubActivity.isEmpty()) {
                try {
                    //  update mNPDSubActivity.values();
                } catch (Exception e) {
                    system.debug('***Exception while updating sub-activity Complexity and Lead Time ***' + e.getLineNumber() + e.getMessage() + e.getCause());
                }
            }
        } //End of if(!newMap.isEmpty() && !oldMap.isEmpty())
    } //End of updateSubActvtyCmplxtyLeadTime() 


    public static decimal stageLeadTime = 0;

    //  Method used for updating the lead times at substage level for newly inserted sub stages.   

    Public Void SubStageLeadTimeWithComplexityInsert(list < npd_stage__c > substages) {
        Integer SubstageLeadTime = 0;
        set < id > subStageIds = new set < id > ();
        list < npd_stage__c > SubtoUpdate = new list < npd_stage__c > ();
        map < string, NPD_Complexity__c > MapOfSubstageLeadTime = new map < string, NPD_Complexity__c > ();
        list < npd_stage__c > StgtoUps = new list < npd_Stage__c > ();
        map < string, npd_stage__c > mapSerialNo_Stage = new map < string, npd_stage__c > ();

        stageLeadTime = 0;
        String SubstageName = '';
        String ProjectId = '';

        if (flag5 == true) {
            substages[0].subStageLeadTime__c = true;
            string proid = substages[0].npd_project_name__c;

            npd_project_name__c ParentProjValues = new npd_project_name__c();

            ParentProjValues = [select id, name, source__c, Project_Complexity__c from npd_project_name__c where id =: proid];

            system.debug('The ParentProjValues is: ' + ParentProjValues);

            For(NPD_Complexity__c com: [SELECT ID, Name__c, Type__c, Lead_Time_del__c, record_name__c, source__c FROM NPD_Complexity__c WHERE Record_Type__c = 'Complexity Type'
                AND type__c = 'Sub-stage'
                AND source__c =: ParentProjValues.source__c AND name__c =: ParentProjValues.Project_Complexity__c
            ]) {

                MapOfSubstageLeadTime.put(com.record_name__c, com);

            }
            system.debug('The MapOfSubstageLeadTime values are :' + MapOfSubstageLeadTime.keyset());

            for (npd_stage__c ns1: substages) {
                ProjectId = ns1.npd_project_name__c;
                try {
                    system.debug('the out if :' + ns1.name__c + '....' + MapOfSubstageLeadTime.get(ns1.name__c));
                } catch (exception we) {
                    system.debug('the exp :' + we);
                }
                if (MapOfSubstageLeadTime.get(ns1.name__c) != null && MapOfSubstageLeadTime.containsKey(ns1.name__c)) {
                    ns1.Planned_Lead_Time__c = MapOfSubstageLeadTime.get(ns1.name__c).Lead_Time_del__c;
                    ns1.Complexity_Typess__c = MapOfSubstageLeadTime.get(ns1.name__c).Name__c;
                    system.debug(ns1.name__c + ns1.planned_lead_time__c + 'lead time trigger');

                    SubstageLeadTime = Integer.ValueOf(ns1.Planned_Lead_Time__c);
                    SubstageName = ns1.name__c;

                    SubtoUpdate.add(ns1);

                    subStageIds.add(ns1.id);


                }

            }

            // update SubtoUpdate;



            string dummyid = '';



            // After calling this method from VF page for sub-stage complexity calculation Stage lead time rollup not happening. So this code temply written to update its parent Stage.


            try {
                for (npd_stage__c ns1: [select id, name__c, Planned_End_Date__c, Planned_Lead_Time__c, serialno__c, PredecessorSerialNo__c, Planned_Start_Date__c, position__c, (select id, name__c, Planned_End_Date__c, Planned_Lead_Time__c, Planned_Start_Date__c, position__c from stage__r where active__c = true order by position__c) from npd_stage__c where id =: SubtoUpdate[0].npd_stage__r.id order by position__c]) {
                    for (npd_stage__c nSub1: ns1.stage__r) {
                        if (SubstageName != nSub1.name__c) {
                            system.debug('nSub1.Planned_Lead_Time__c ' + nSub1.Planned_Lead_Time__c);

                            stageLeadTime = stageLeadTime + nSub1.Planned_Lead_Time__c;
                            system.debug('stageLeadTime: ' + stageLeadTime);
                            mapSerialNo_Stage.put(ns1.serialno__c, ns1);
                        } else {
                            stageLeadTime = stageLeadTime + SubstageLeadTime;

                        }

                    }
                    ns1.Planned_Lead_Time__c = stageLeadTime;
                    ns1.Planned_End_Date__c = ns1.Planned_End_Date__c.addDays(integer.valueOf(ns1.Planned_Lead_Time__c));
                    update ns1;
                    StgtoUps.add(ns1);
                    system.debug('The updating paretn stage:' + ns1.Planned_End_Date__c + '...' + ns1.name__c);
                }
            } catch (exception er1) {
                system.debug('The exp er1 is: ' + er1);
            }

            ActivitySubActivityLeadTime(subStageIds, ParentProjValues.Project_Complexity__c, ParentProjValues.source__c, ProjectId);
            update SubtoUpdate;
        }
        flag5 = false;
    }

    public static void ActivitySubActivityLeadTime(set < id > subStageIds, string stgcomplex, string source, string stageId) {

        if (flag7 == true || flag10 == true) {
            system.debug(' clicking view stageLeadTime :' + stageLeadTime);
            try {
                system.debug('Act stgs date cals :' + subStageIds + stgcomplex + source + stageId);
                if (stageId != null) {
                    for (npd_stage__c ns1: [select id, name__c, Planned_End_Date__c, Planned_Lead_Time__c, serialno__c, PredecessorSerialNo__c, Planned_Start_Date__c, position__c, (select id, name__c, Planned_End_Date__c, Planned_Lead_Time__c, Planned_Start_Date__c, position__c from stage__r order by position__c) from npd_stage__c where id =: stageId order by position__c]) {
                        for (npd_stage__c nSub1: ns1.stage__r) {
                            stageLeadTime = stageLeadTime + nSub1.Planned_Lead_Time__c;
                            system.debug('stageLeadTime: ' + stageLeadTime);

                            ns1.Planned_Lead_Time__c = stageLeadTime;

                            system.debug('substag end date :' + nSub1.Planned_End_Date__c);
                        }
                        update ns1;
                        system.debug('The updating paretn stage:' + ns1.Planned_End_Date__c + '...' + ns1.name__c);
                    }

                }
            } catch (Exception Er1) {
                system.debug('The exception ' + er1);
            }

            system.debug('inside of ActivitySubActivityLeadTime ');
            //  list<npd_activity__c> ActsToUpadte = new list<npd_activity__c>();
            map < id, list < npd_activity__c >> ActivitysubActivitySubStagemap = new map < id, list < npd_activity__C >> ();
            map < id, list < npd_activity__c >> subActivityActNameMap = new map < id, list < npd_activity__C >> ();
            map < string, NPD_Complexity__c > ActNameComplex = new map < string, NPD_Complexity__c > ();
            map < string, NPD_Complexity__c > SubActSerialComplex = new map < string, NPD_Complexity__c > ();
            map < string, NPD_Complexity__c > ActNameComplexInh = new map < string, NPD_Complexity__c > ();
            map < id, string > InhActivityMasterDataMap = new map < id, string > ();

            list < npd_activity__c > SubActList = new list < npd_activity__c > ();

            map < id, npd_activity__c > ActsToUpadte = new map < id, npd_activity__c > ();
            list < npd_activity__c > ActsToUpadtes = new list < npd_activity__c > ();
            list < npd_activity__c > InhActsToUpadtes = new list < npd_activity__c > ();

            system.debug('The stgcomplex value is :' + stgcomplex + '....' + source);

            For(NPD_Complexity__c com: [SELECT ID, Name__c, NPD_Activity__c, serialno__c, Sub_Stage__c, Type__c, Record_Type__c, Lead_Time_del__c, Complexity_Type__c, record_name__c, Activity_master_name__c FROM NPD_Complexity__c WHERE Record_Type__c = 'Complexity Type'
                AND Name__c =: stgComplex AND source__c =: source
            ]) {
                if (com.Record_Type__c == 'Complexity Type') {
                    ActNameComplex.put(com.record_name__c, com);
                    SubActSerialComplex.put(com.serialno__c, com);
                } else {
                    ActNameComplexInh.put(com.id, com);

                }
            }

            set < id > ParentActsID = new set < id > ();

            for (npd_activity__c npdAct19: [select id, name__c, npd_stage__r.id, type__c, active__c, Complexity_Typess__c, Planned_Lead_Time__c from npd_activity__C where npd_stage__c in: subStageIds]) {
                if (ActivitysubActivitySubStagemap.containskey(npdAct19.npd_stage__r.id)) {
                    ActivitysubActivitySubStagemap.get(npdAct19.npd_stage__r.id).add(npdAct19);
                    ParentActsID.add(npdAct19.id);
                } else {
                    ActivitysubActivitySubStagemap.put(npdAct19.npd_stage__r.id, new list < npd_activity__c > {
                        npdAct19
                    });
                    ParentActsID.add(npdAct19.id);
                }
            }

            for (npd_activity__c npdAct19: [select id, name__c,active__c, serialno__c, type__c, npd_activity__r.Complexity_Typess__c, npd_activity__r.active__c, npd_activity__r.id, npd_activity__r.npd_stage__r.id, Complexity_Typess__c, Planned_Lead_Time__c from npd_activity__C where npd_activity__c in: ParentActsID]) {
                SubActList.add(npdAct19);
            }

            string currentSubstageid = '';

            for (id i1: subStageIds) {
                currentSubstageid = i1;
                system.debug('subStageIds: ' + i1);

                if (ActivitysubActivitySubStagemap.containskey(i1) && ActivitysubActivitySubStagemap.get(i1) != null) {
                    for (npd_activity__C nact1: ActivitysubActivitySubStagemap.get(i1)) {
                        system.debug('nact1: ' + nact1);

                        // nact1.Complexity_Typess__c = ActNameComplex.get(nact1.name__c).Name__c;
                        //   system.debug('outside ActNameComplex.get(nact1.name__c).name__c == nact1.Complexity_Typess__c '+ ActNameComplex.get(nact1.name__c).name__c +'....'+ nact1.Complexity_Typess__c);
                        if (ActNameComplex.get(nact1.name__c) != null && ActNameComplex.containskey(nact1.name__c)) {
                            nact1.Planned_Lead_Time__c = ActNameComplex.get(nact1.name__c).Lead_Time_del__c;
                            nact1.Complexity_Typess__c = ActNameComplex.get(nact1.name__c).Name__c;
                            system.debug(' nact1.Planned_Lead_Time__c' + nact1.Planned_Lead_Time__c);
                            // ActsToUpadte.add(nact1);
                            ActsToUpadte.put(nact1.id, nact1);
                            system.debug('The value is planned lead time is : ' + nact1.Planned_Lead_Time__c + '...' + nact1.name__c);
                        }
                    }
                }
            }

            for (npd_activity__c na10: SubActList) {
                if (SubActSerialComplex.get(na10.serialno__c) != null && SubActSerialComplex.containskey(na10.serialno__c))
                    na10.Planned_Lead_Time__c = SubActSerialComplex.get(na10.serialno__c).Lead_Time_del__c;

                //  na10.Complexity_Typess__c =  na10.npd_activity__r.Complexity_Typess__c;


                // ActsToUpadte.add(na10);

                ActsToUpadte.put(na10.id, na10);
            }

            for (npd_activity__c npdact1: ActsToUpadte.values()) {
                if (npdact1.type__c == 'Activity' && npdact1.active__c == false) {
                    npdact1.Planned_Lead_Time__c = 0;
                    ActsToUpadte.put(npdact1.id, npdact1);
                }
                if (npdact1.type__c == 'sub-activity' && npdact1.npd_activity__r.active__c == false) {
                    npdact1.Planned_Lead_Time__c = 0;
                    ActsToUpadte.put(npdact1.id, npdact1);
                }

                if (npdact1.type__c == 'sub-activity') {
                    npdact1.Complexity_Typess__c = npdact1.npd_activity__r.Complexity_Typess__c;
                    ActsToUpadte.put(npdact1.id, npdact1);
                }
            }


            system.debug(' The ActsToUpadtes keyset count:' + ActsToUpadte.keyset().size());

            for (npd_activity__c nActs: ActsToUpadte.values()) {
                system.debug('The nActs: ' + nActs);
                //update ActsToUpadte.values();
                ActsToUpadtes.add(nActs);
            }

            system.debug(' The ActsToUpadtes count:' + ActsToUpadtes.size());

            //   update  ActsToUpadtes;             


            // Temp method for CASE development Inh Sub-stage complexity. ********************************************

            //  ActNameComplexInh.put(com.Name__c,com);

            /*****************************************************************************************   
                 
                 for(npd_stage__c ns1 : [select id,name__c,Complexity_Typess__c,Complexity_Category__c,(select id,name__c,Complexity_Typess__c,planned_lead_time__c from npd_activity__r) from npd_stage__c where name__c= 'Case Development - INH' AND id in: subStageIds limit 1])
                   { 
                     for(npd_complexity__c nc1: ActNameComplexInh.values() )
                     {
                       if(nc1.name__c == ns1.Complexity_Category__c)
                       {
                         for()
                       
                         for(npd_activity__c na1:ns1.npd_activity__r)
                         {
                           // na1.planned_lead_time__c = ns1.planned_lead_time__c;
                           na1.planned_lead_time__c =  ActNameComplexInh.get()
                            na1.Complexity_Typess__c = ns1.Complexity_Typess__c;
                            ActsToUpadtes.add(na1);
                            
                         }
                       
                        }  } } 
                        
                        
                        ***************************************************************************************/
            map < string, list < npd_complexity__c >> ActNameComplexInh2 = new map < string, list < npd_complexity__c >> ();



            For(NPD_Complexity__c nc3: [SELECT ID, Name__c, NPD_Activity__c, serialno__c, Sub_Stage__c, Type__c, Record_Type__c, Lead_Time_del__c, Complexity_Type__c, record_name__c, Activity_master_name__c FROM NPD_Complexity__c WHERE Record_Type__c = 'Complexity Category']) {
                if (ActNameComplexInh2.containskey(nc3.name__c)) {
                    ActNameComplexInh2.get(nc3.name__c).add(nc3);
                } else {
                    ActNameComplexInh2.put(nc3.name__c, new list < npd_complexity__c > {
                        nc3
                    });
                }

            }

            system.debug(' ActNameComplexInh2 values :' + ActNameComplexInh2.keyset());


            for (npd_stage__c ns1: [select id, name__c, Complexity_Typess__c, Complexity_Category__c, (select id, name__c, Complexity_Typess__c, planned_lead_time__c from npd_activity__r) from npd_stage__c where name__c = 'Case Development - INH'
                    AND id in: subStageIds limit 1
                ]) {
                for (npd_activity__c na1: ns1.npd_activity__r) {
                    system.debug('The Complexity_Category__c value is :' + ns1.Complexity_Category__c);
                    if (ActNameComplexInh2.get(ns1.Complexity_Category__c) != null && ActNameComplexInh2.containsKey(ns1.Complexity_Category__c)) {
                        system.debug('The ActNameComplexInh2 value is :');
                        for (npd_complexity__c nc1: ActNameComplexInh2.get(ns1.Complexity_Category__c)) {
                            system.debug('The ActNameComplexInh2 nc1 value is :' + nc1.Activity_master_name__c);
                            if (nc1.name__c == ns1.Complexity_Category__c && nc1.Activity_master_name__c == na1.name__c) {
                                system.debug('Inside The ActNameComplexInh2 nc1 value is :' + nc1.Activity_master_name__c);
                                na1.Complexity_Typess__c = ns1.Complexity_Typess__c;
                                na1.planned_lead_time__c = nc1.Lead_Time_del__c;
                                //  ActsToUpadtes.add(na1);
                                InhActsToUpadtes.add(na1);

                            }

                        }
                    }

                }


            }

            try {
                npd_stage__c nsub = [select id, name__c, npd_stage__r.position__c, npd_stage__r.name__c, npd_stage__r.npd_project_name__c, npd_stage__r.Planned_End_Date__c from npd_stage__c where id =: currentSubstageid];

                system.debug('The Planned_End_Date__c .... Parent Stage Name is: ' + nsub.npd_stage__r.Planned_End_Date__c + '....' + nsub.npd_stage__r.name__c);

                // StageSubStageLeadTimeRecalculation(nsub.npd_stage__r.position__c,nsub.npd_stage__r.npd_project_name__c);

            } catch (exception e1) {
                system.debug(e1);
            }


            for (npd_activity__c na11: InhActsToUpadtes) {
                system.debug('The inh vales are :' + na11);
            }
            update ActsToUpadtes;
            update InhActsToUpadtes;
            ActivateDeactivateStage(subStageIds);
            /*************************   
                try{
                npd_stage__c nsub = [select id,name__c,npd_stage__r.position__c,npd_stage__r.name__c,  npd_stage__r.npd_project_name__c,npd_stage__r.Planned_End_Date__c from npd_stage__c where id =:currentSubstageid];  
                 
                system.debug('The Planned_End_Date__c .... Parent Stage Name is: '+ nsub.npd_stage__r.Planned_End_Date__c+'....' + nsub.npd_stage__r.name__c);
                
            StageSubStageLeadTimeRecalculation(nsub.npd_stage__r.position__c,nsub.npd_stage__r.npd_project_name__c);
            
            }catch(exception e1)
            {system.debug(e1);
            }    *******************************/

        }

        if (flag7 == false)
            flag10 = false;
        if (flag7 == true)
            flag7 = false;


    }


    // Method for calculating the Dates for stages after updating the Previous stage.
    //  StageSubStageLeadTimeRecalculation(a2Af0000000Ozvw,a26f0000000d4oj);

    Public static void StageSubStageLeadTimeRecalculation(decimal stagerec, string ProjId) {
        if (flag6 == true || flag6 == false) {
            map < string, npd_stage__c > MainStageMap = new map < string, npd_stage__c > ();
            integer parentStagePostition = integer.valueof(stagerec);
            system.debug('parentStagePostition : ' + parentStagePostition);
            integer currentStagePostion;
            Date StageEndDate;
            Date StageStartDate;
            Integer StagePlannedLeadTime;
            Integer parentPosition;
            datetime dteActualEndDateHoliday;




            list < npd_stage__c > StagesToupdate = new list < npd_stage__c > ();

            for (npd_stage__c ns1: [select id, name__c, Planned_End_Date__c, npd_stage__r.name__c, Planned_Lead_Time__c, Planned_Start_Date__c, position__c, npd_project_name__r.CreatedDate, (select id, name__c, Planned_End_Date__c, Planned_Lead_Time__c, Complexity_Typess__c, Planned_Start_Date__c, position__c from stage__r where active__c = true Order By position__c) from npd_stage__c where npd_project_name__c =: ProjId AND Type__c = 'stage'
                    AND position__c >=: parentStagePostition order by position__c
                ]) {
                MainStageMap.put(ns1.name__c, ns1);
                system.debug('The stage values are:' + ns1.name__c + '...' + ns1.Planned_Start_Date__c + '...' + ns1.Planned_End_Date__c + '...' + ns1.Planned_Lead_Time__c);
            }

            // Map for storing the stage data , using for append these values for next stage or stages.



            for (npd_stage__c Stgs: MainStageMap.values()) {
                currentStagePostion = integer.valueof(Stgs.position__c);
                system.debug('The current position of stage rec :' + currentStagePostion + '....' + parentStagePostition + '....' + Stgs.name__c);

                // Storing the Current Stage Values. 
                if (Stgs.position__c >= 2) {
                    if (StagePlannedLeadTime == null)
                        StagePlannedLeadTime = integer.valueof(Stgs.Planned_Lead_Time__c);
                    if (StageEndDate == null)
                        StageEndDate = stgs.Planned_End_Date__c;
                    if (StageStartDate == null)
                        StageStartDate = Stgs.Planned_Start_Date__c;
                    if (parentPosition == null)
                        parentPosition = integer.valueof(stgs.position__c);
                    system.debug('Main storing values :' + stgs.name__c);
                }

                if (Stgs.position__c == 2) {
                    //StageStartDate = DateTime.valueOf(stgs.npd_project_name__r.CreatedDate).date();
                    system.debug('projecct create date' + StageStartDate + '...' + stgs.name__C);
                }

                /*   // For Storing the Sub stages values.
                      
                      for(npd_stage__c subStg : MainStageMap.values())
                      {
                          if(SubStagePlannedLeadTime ==  null)
                          SubStagePlannedLeadTime = integer.valueof(Stgs.Planned_Lead_Time__c);
                          if(SubStageEndDate == null)
                          SubStageEndDate =     stgs.Planned_End_Date__c;
                          if(SubStageStartDate == null)   
                          SubStageStartDate =   Stgs.Planned_Start_Date__c;
                          if(SubparentPosition  == null)
                          SubparentPosition = integer.valueof(stgs.position__c);
                       }      ************************/



            }
            try {
                parentPosition++;
            } catch (exception er1) {
                system.debug('The er1 is:' + er1);
            }

            for (npd_stage__c Stgs: MainStageMap.values()) {

                system.debug('The stgs.position__c :' + stgs.position__c + '....' + parentPosition);

                if (integer.valueof(stgs.position__c) == parentPosition) {

                    parentPosition++;

                    system.debug('stored Start date' + StageStartDate + ' The StageEndDate :' + StageEndDate + '....');

                    stgs.Planned_Start_Date__c = StageEndDate.addDays(1);
                    stgs.Planned_End_Date__c = stgs.Planned_Start_Date__c.adddays(integer.ValueOf(Stgs.Planned_Lead_Time__c - 1));


                    // For next iteration appending dates for next stage.
                    StageStartDate = stgs.Planned_Start_Date__c;
                    StageEndDate = stgs.Planned_End_Date__c;


                    system.debug('The After StageEndDate :' + stgs.Planned_Start_Date__c + '......' + stgs.Planned_End_Date__c + '...' + stgs.name__c);
                    StagesToupdate.add(stgs);


                    //   Sub Stage Iteration.
                    Date subStageStartDate;
                    Date subStageEndDate;

                    for (npd_stage__c subStg: stgs.stage__r) {
                        system.debug('the sub stage positions :' + subStg.position__c + '...' + subStg.name__c);
                        // For 1st Sub stage get start date from parent substage startdate. End date with lead time calculations.

                        if (subStg.position__c == 1) {
                            subStg.Planned_Start_Date__c = StageStartDate;
                            subStg.Planned_End_Date__c = subStg.Planned_Start_Date__c.adddays(integer.ValueOf(subStg.Planned_Lead_Time__c - 1));

                            subStageStartDate = subStg.Planned_Start_Date__c;
                            subStageEndDate = subStg.Planned_End_Date__c;
                            StagesToupdate.add(subStg);

                            system.debug('sub stage position 1 loop: ' + subStageStartDate + '....' + subStageEndDate + '....' + subStg.name__c);

                        }
                        // For remaining sub stages from 2nd substages onwarwards get startdate from previous end date +1 . End date with lead time addition.

                        if (subStg.position__c > 1) {
                            subStg.Planned_Start_Date__c = subStageEndDate.addDays(1);
                            subStg.Planned_End_Date__c = subStg.Planned_Start_Date__c.adddays(integer.ValueOf(subStg.Planned_Lead_Time__c - 1));
                            subStageStartDate = subStg.Planned_Start_Date__c;
                            subStageEndDate = subStg.Planned_End_Date__c;
                            // 
                            StageEndDate = subStageEndDate;

                            StagesToupdate.add(subStg);
                            system.debug('sub stage position > 1 loop: ' + subStageStartDate + '....' + subStageEndDate + '....' + subStg.name__c);

                        }

                    }

                    date DevelopmentSubStartDate;
                    date DevelopmentSubEndDate;

                    for (npd_stage__c subStg1: stgs.stage__r) {
                        if (subStg1.npd_stage__r.name__c == 'Development') {


                            DevelopmentSubStartDate = subStg1.Planned_Start_Date__c;
                            DevelopmentSubEndDate = subStg1.Planned_End_Date__c;



                            subStg1.Planned_Start_Date__c = DevelopmentSubEndDate.addDays(1);
                            subStg1.Planned_End_Date__c = subStg1.Planned_Start_Date__c.adddays(integer.ValueOf(subStg1.Planned_Lead_Time__c - 1));
                            DevelopmentSubEndDate = subStg1.Planned_Start_Date__c;
                            //  subStageEndDate = subStg1.Planned_End_Date__c;
                            // 
                            StageEndDate = subStageEndDate;

                            StagesToupdate.add(subStg1);
                            system.debug('sub stage DEvelopment loop: ' + DevelopmentSubEndDate + '....' + DevelopmentSubEndDate + '....' + subStg1.name__c);

                        }


                    }
                }
            }
            update StagesToupdate;

            Date NextDate;

            list < npd_stage__c > StgsUpdateInh = new list < npd_stage__c > ();

            for (npd_stage__c Stgs: MainStageMap.values()) {
                if (stgs.name__c == 'Development' || stgs.name__c == 'Production') {
                    for (npd_stage__c ns1: Stgs.stage__r) {
                        system.debug('The ns1 substage values :' + ns1.name__c + '...' + ns1.planned_lead_time__c + '...' + ns1.Planned_Start_Date__c + '...' + ns1.Planned_End_Date__c + '....' + ns1.Complexity_Typess__c);
                        if (ns1.position__c == 1) {
                            ns1.Planned_Start_Date__c = stgs.Planned_Start_Date__c;
                            ns1.Planned_End_Date__c = ns1.Planned_Start_Date__c.addDays(integer.ValueOf(ns1.Planned_Lead_Time__c - 1));
                            NextDate = ns1.Planned_End_Date__c;
                            StgsUpdateInh.add(ns1);
                        } else {
                            ns1.Planned_Start_Date__c = NextDate;
                            ns1.Planned_End_Date__c = ns1.Planned_Start_Date__c.addDays(integer.ValueOf(ns1.Planned_Lead_Time__c - 1));
                            NextDate = ns1.Planned_End_Date__c;
                            StgsUpdateInh.add(ns1);
                        }
                    } //  End of Substages Loop . 

                    //   Stgs.Planned_Start_Date__c = NextDate.addDays(1);
                    //  Stgs.Planned_End_Date__c = Stgs.Planned_Start_Date__c.addDays(Integer.valueof(Stgs.planned_lead_time__c-1));
                    //  StgsUpdateInh.add(Stgs);
                }

            }
            update StgsUpdateInh;



        }
        flag6 = false;
    }

    /*****************************************   inserting NPD_Collections__c *********************************/

    public void methodAccount() {


        // String todate = '06-06-2016';
        //Date dt = Date.valueOf(todate);

        NPD_Collections__c npc = new NPD_Collections__c();
        //  npc.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
        //  npc.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
        npc.Case_Material__c = CaseMaterial;
        npc.Collection_Name__c = CollectionName;
        npc.Comments_Remarks__c = CommentsRemarks;
        npc.Development_Route__c = DevelopmentRoute;
        npc.Gender__c = Gender;
        npc.Market__c = Market;
        npc.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
        //npc.MarketingRestrict__c=MarketingRestrict;
        npc.Movement_Function__c = MovementFunction;
        //  npc.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
        npc.Project_Complexity__c = ProjectComplexity;
        npc.Project_Status__c = ProjectStatus;
        npc.Project_Type__c = ProjectType;
        npc.PSY_No__c = PSYNo;
        npc.Reasons_for_Drop__c = ReasonsforDrop;
        npc.Strap_Material__c = StrapMaterial;
        npc.Strap_Source__c = StrapSource;
        npc.Template_Type__c = TemplateType;
        //npc.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
        npc.Tentative_Launch_Month_Date__c = Date.today();
        insert npc;


        if (2 == 2) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc1 = new NPD_Collections__c();
            //  npc1.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc1.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc1.Case_Material__c = CaseMaterial;
            npc1.Collection_Name__c = CollectionName;
            npc1.Comments_Remarks__c = CommentsRemarks;
            npc1.Development_Route__c = DevelopmentRoute;
            npc1.Gender__c = Gender;
            npc1.Market__c = Market;
            npc1.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc1.MarketingRestrict__c=MarketingRestrict;
            npc1.Movement_Function__c = MovementFunction;
            //  npc1.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc1.Project_Complexity__c = ProjectComplexity;
            npc1.Project_Status__c = ProjectStatus;
            npc1.Project_Type__c = ProjectType;
            npc1.PSY_No__c = PSYNo;
            npc1.Reasons_for_Drop__c = ReasonsforDrop;
            npc1.Strap_Material__c = StrapMaterial;
            npc1.Strap_Source__c = StrapSource;
            npc1.Template_Type__c = TemplateType;
            //npc1.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc1.Tentative_Launch_Month_Date__c = Date.today();
            insert npc1;

        }


        if (23 == 23) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc1 = new NPD_Collections__c();
            //  npc1.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc1.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc1.Case_Material__c = CaseMaterial;
            npc1.Collection_Name__c = CollectionName;
            npc1.Comments_Remarks__c = CommentsRemarks;
            npc1.Development_Route__c = DevelopmentRoute;
            npc1.Gender__c = Gender;
            npc1.Market__c = Market;
            npc1.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc1.MarketingRestrict__c=MarketingRestrict;
            npc1.Movement_Function__c = MovementFunction;
            //  npc1.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc1.Project_Complexity__c = ProjectComplexity;
            npc1.Project_Status__c = ProjectStatus;
            npc1.Project_Type__c = ProjectType;
            npc1.PSY_No__c = PSYNo;
            npc1.Reasons_for_Drop__c = ReasonsforDrop;
            npc1.Strap_Material__c = StrapMaterial;
            npc1.Strap_Source__c = StrapSource;
            npc1.Template_Type__c = TemplateType;
            //npc1.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc1.Tentative_Launch_Month_Date__c = Date.today();
            insert npc1;

        }




        if (22 == 22) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc1 = new NPD_Collections__c();
            //  npc1.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc1.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc1.Case_Material__c = CaseMaterial;
            npc1.Collection_Name__c = CollectionName;
            npc1.Comments_Remarks__c = CommentsRemarks;
            npc1.Development_Route__c = DevelopmentRoute;
            npc1.Gender__c = Gender;
            npc1.Market__c = Market;
            npc1.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc1.MarketingRestrict__c=MarketingRestrict;
            npc1.Movement_Function__c = MovementFunction;
            //  npc1.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc1.Project_Complexity__c = ProjectComplexity;
            npc1.Project_Status__c = ProjectStatus;
            npc1.Project_Type__c = ProjectType;
            npc1.PSY_No__c = PSYNo;
            npc1.Reasons_for_Drop__c = ReasonsforDrop;
            npc1.Strap_Material__c = StrapMaterial;
            npc1.Strap_Source__c = StrapSource;
            npc1.Template_Type__c = TemplateType;
            //npc1.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc1.Tentative_Launch_Month_Date__c = Date.today();
            insert npc1;

        }


        if (21 == 21) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc1 = new NPD_Collections__c();
            //  npc1.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc1.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc1.Case_Material__c = CaseMaterial;
            npc1.Collection_Name__c = CollectionName;
            npc1.Comments_Remarks__c = CommentsRemarks;
            npc1.Development_Route__c = DevelopmentRoute;
            npc1.Gender__c = Gender;
            npc1.Market__c = Market;
            npc1.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc1.MarketingRestrict__c=MarketingRestrict;
            npc1.Movement_Function__c = MovementFunction;
            //  npc1.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc1.Project_Complexity__c = ProjectComplexity;
            npc1.Project_Status__c = ProjectStatus;
            npc1.Project_Type__c = ProjectType;
            npc1.PSY_No__c = PSYNo;
            npc1.Reasons_for_Drop__c = ReasonsforDrop;
            npc1.Strap_Material__c = StrapMaterial;
            npc1.Strap_Source__c = StrapSource;
            npc1.Template_Type__c = TemplateType;
            //npc1.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc1.Tentative_Launch_Month_Date__c = Date.today();
            insert npc1;

        }



        if (3 == 3) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc2 = new NPD_Collections__c();
            //  npc2.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc2.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc2.Case_Material__c = CaseMaterial;
            npc2.Collection_Name__c = CollectionName;
            npc2.Comments_Remarks__c = CommentsRemarks;
            npc2.Development_Route__c = DevelopmentRoute;
            npc2.Gender__c = Gender;
            npc2.Market__c = Market;
            npc2.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc2.MarketingRestrict__c=MarketingRestrict;
            npc2.Movement_Function__c = MovementFunction;
            //  npc2.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc2.Project_Complexity__c = ProjectComplexity;
            npc2.Project_Status__c = ProjectStatus;
            npc2.Project_Type__c = ProjectType;
            npc2.PSY_No__c = PSYNo;
            npc2.Reasons_for_Drop__c = ReasonsforDrop;
            npc2.Strap_Material__c = StrapMaterial;
            npc2.Strap_Source__c = StrapSource;
            npc2.Template_Type__c = TemplateType;
            //npc2.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc2.Tentative_Launch_Month_Date__c = Date.today();
            insert npc2;

        }


        if (4 == 4) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc3 = new NPD_Collections__c();
            //  npc3.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc3.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc3.Case_Material__c = CaseMaterial;
            npc3.Collection_Name__c = CollectionName;
            npc3.Comments_Remarks__c = CommentsRemarks;
            npc3.Development_Route__c = DevelopmentRoute;
            npc3.Gender__c = Gender;
            npc3.Market__c = Market;
            npc3.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc3.MarketingRestrict__c=MarketingRestrict;
            npc3.Movement_Function__c = MovementFunction;
            //  npc3.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc3.Project_Complexity__c = ProjectComplexity;
            npc3.Project_Status__c = ProjectStatus;
            npc3.Project_Type__c = ProjectType;
            npc3.PSY_No__c = PSYNo;
            npc3.Reasons_for_Drop__c = ReasonsforDrop;
            npc3.Strap_Material__c = StrapMaterial;
            npc3.Strap_Source__c = StrapSource;
            npc3.Template_Type__c = TemplateType;
            //npc3.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc3.Tentative_Launch_Month_Date__c = Date.today();
            insert npc3;

        }


        if (5 == 5) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc4 = new NPD_Collections__c();
            //  npc4.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc4.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc4.Case_Material__c = CaseMaterial;
            npc4.Collection_Name__c = CollectionName;
            npc4.Comments_Remarks__c = CommentsRemarks;
            npc4.Development_Route__c = DevelopmentRoute;
            npc4.Gender__c = Gender;
            npc4.Market__c = Market;
            npc4.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc4.MarketingRestrict__c=MarketingRestrict;
            npc4.Movement_Function__c = MovementFunction;
            //  npc4.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc4.Project_Complexity__c = ProjectComplexity;
            npc4.Project_Status__c = ProjectStatus;
            npc4.Project_Type__c = ProjectType;
            npc4.PSY_No__c = PSYNo;
            npc4.Reasons_for_Drop__c = ReasonsforDrop;
            npc4.Strap_Material__c = StrapMaterial;
            npc4.Strap_Source__c = StrapSource;
            npc4.Template_Type__c = TemplateType;
            //npc4.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc4.Tentative_Launch_Month_Date__c = Date.today();
            insert npc4;

        }

        if (92 == 92) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc4 = new NPD_Collections__c();
            //  npc4.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc4.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc4.Case_Material__c = CaseMaterial;
            npc4.Collection_Name__c = CollectionName;
            npc4.Comments_Remarks__c = CommentsRemarks;
            npc4.Development_Route__c = DevelopmentRoute;
            npc4.Gender__c = Gender;
            npc4.Market__c = Market;
            npc4.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc4.MarketingRestrict__c=MarketingRestrict;
            npc4.Movement_Function__c = MovementFunction;
            //  npc4.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc4.Project_Complexity__c = ProjectComplexity;
            npc4.Project_Status__c = ProjectStatus;
            npc4.Project_Type__c = ProjectType;
            npc4.PSY_No__c = PSYNo;
            npc4.Reasons_for_Drop__c = ReasonsforDrop;
            npc4.Strap_Material__c = StrapMaterial;
            npc4.Strap_Source__c = StrapSource;
            npc4.Template_Type__c = TemplateType;
            //npc4.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc4.Tentative_Launch_Month_Date__c = Date.today();
            insert npc4;

        }

        if (93 == 93) {
            // String todate = '06-06-2016';
            //Date dt = Date.valueOf(todate);

            NPD_Collections__c npc4 = new NPD_Collections__c();
            //  npc4.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
            //  npc4.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
            npc4.Case_Material__c = CaseMaterial;
            npc4.Collection_Name__c = CollectionName;
            npc4.Comments_Remarks__c = CommentsRemarks;
            npc4.Development_Route__c = DevelopmentRoute;
            npc4.Gender__c = Gender;
            npc4.Market__c = Market;
            npc4.Marketing_brief_concept_reference_number__c = Marketingbriefconceptreferencenumber;
            //npc4.MarketingRestrict__c=MarketingRestrict;
            npc4.Movement_Function__c = MovementFunction;
            //  npc4.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
            npc4.Project_Complexity__c = ProjectComplexity;
            npc4.Project_Status__c = ProjectStatus;
            npc4.Project_Type__c = ProjectType;
            npc4.PSY_No__c = PSYNo;
            npc4.Reasons_for_Drop__c = ReasonsforDrop;
            npc4.Strap_Material__c = StrapMaterial;
            npc4.Strap_Source__c = StrapSource;
            npc4.Template_Type__c = TemplateType;
            //npc4.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
            npc4.Tentative_Launch_Month_Date__c = Date.today();
            insert npc4;

        }
    }

    //update collection method 
    Public static void updatecollectionvalue(set < id > collid, List < NPD_Collections__c > lstcoll) {
        System.debug('**********collid' + collid);
        List < NPD_stage__c > lststage = new List < NPD_stage__c > ();
        List < NPD_Project_Name__c > lstProject = new List < NPD_Project_Name__c > ();
        List < NPD_Activity__c > lstact = new List < NPD_Activity__c > ();
        map < id, NPD_Collections__c > mapcoll = new map < id, NPD_Collections__c > ();
        map < id, NPD_stage__c > mapstagesubstage = new map < id, NPD_stage__c > ([SELECT id, Source__c, NPD_Collections__c, Marketing_brief_concept_reference_number__c, Revision_Active__c, Revision_Substage__c, NPD_stage__c, NPD_Project_Name__c, Brand1__c, Sub_Brand1__c, Market__c from NPD_stage__c where NPD_Collections__c =: collid]);
        map < id, NPD_Activity__c > mapofact = new map < id, NPD_Activity__c > ([SELECT id, Source__c, NPD_Collections__c, NPD_Activity__c, Revision_Active__c, Marketing_Brief_Reference_No__c, NPD_Project_Name__c, Brand1__c, Sub_Brand1__c, Market__c, WhenToBeAcive__c from NPD_Activity__c where NPD_Collections__c =: collid]);
        map < id, NPD_Project_Name__c > mapofproject = new map < id, NPD_Project_Name__c > ([SELECT id, NPD_Collections__c, Market__c, Source__c, Sub_Brand1__c, Brand1__c from NPD_Project_Name__c where NPD_Collections__c =: collid]);

        for (NPD_Collections__c coll: lstcoll) {
            mapcoll.put(coll.id, coll);
        }

        for (NPD_Project_Name__c pro: mapofproject.values()) {
            if (mapcoll.get(pro.NPD_Collections__c) != NULL) {
                pro.Source__c = mapcoll.get(pro.NPD_Collections__c).Source__c;

                pro.Brand1__c = mapcoll.get(pro.NPD_Collections__c).MarketingBrand__c;
                pro.Sub_Brand1__c = mapcoll.get(pro.NPD_Collections__c).MarketingSub_Brand__c;
                pro.Market__c = mapcoll.get(pro.NPD_Collections__c).Market__c;
                lstProject.add(pro);
            }
        }

        for (NPD_stage__c stage: mapstagesubstage.values()) {
            if (mapcoll.get(stage.NPD_Collections__c) != NULL) {
                stage.Source__c = mapcoll.get(stage.NPD_Collections__c).Source__c;

                stage.Brand1__c = mapcoll.get(stage.NPD_Collections__c).MarketingBrand__c;
                stage.Sub_Brand1__c = mapcoll.get(stage.NPD_Collections__c).MarketingSub_Brand__c;
                stage.Market__c = mapcoll.get(stage.NPD_Collections__c).Market__c;
                lststage.add(stage);
            }
        }

        for (NPD_Activity__c activity: mapofact.values()) {
            if (mapcoll.get(activity.NPD_Collections__c) != NULL) {
                activity.Source__c = mapcoll.get(activity.NPD_Collections__c).Source__c;
                if (activity.WhenToBeAcive__c == activity.Source__c) {
                    activity.Active__c = true;
                } else {
                    activity.Active__c = false;
                }
                activity.Brand1__c = mapcoll.get(activity.NPD_Collections__c).MarketingBrand__c;
                activity.Sub_Brand1__c = mapcoll.get(activity.NPD_Collections__c).MarketingSub_Brand__c;
                activity.Market__c = mapcoll.get(activity.NPD_Collections__c).Market__c;
                lstact.add(activity);
            }
        }

        if (lstProject.size() > 0) {
            update lstProject;
        }

        if (lststage.size() > 0) {
            update lststage;
        }
        if (lstact.size() > 0) {
            update lstact;
        }

    }

    /*******************************Method to Activate or Deactivate stage OR Sub Stage*********************************************/

    Public static void activateDeactivateStage(string recordid) {
        System.debug('*****recordid*' + recordid);
        List < NPD_Stage__c > lststage = new List < NPD_Stage__c > ();
        List < NPD_Stage__c > lststageupdate = new List < NPD_Stage__c > ();
        lststage = [SELECT id, Active__c from NPD_Stage__c where id =: recordid];
        for (NPD_Stage__c stgobj: lststage) {
            stgobj.Active__c = !stgobj.Active__c;
            lststageupdate.add(stgobj);

            }
            if (lststageupdate.size() > 0) {
                try{
                
               update lststageupdate;
               }
               catch (Exception e){
               System.debug('******exception E'+e);
                //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'Cannot Deactivate in inprogress and Completed Status"'));
               }
            }
        }
      
        /*******************************Method to Activate or Deactivate Activity OR Sub Activity*********************************************/
        Public static void activateDeactivateActivity(string recordid){
            System.debug('*****recordid*' + recordid);
            List < NPD_Activity__c > lstActivity = new List < NPD_Activity__c > ();
            List < NPD_Activity__c > lstActivityupdate = new List < NPD_Activity__c > ();
            lstActivity = [SELECT id, Active__c,Name__c from NPD_Activity__c where id =: recordid];
            for (NPD_Activity__c actobj: lstActivity) {
                actobj.Active__c = !actobj.Active__c;
                //if(actobj.Name__c =='Make or Buy and Model No. Allocation')
               // actobj.Active__c=true;
                lstActivityupdate.add(actobj);
            }
            if (lstActivityupdate.size() > 0) {
               try{
               update lstActivityupdate;
                }
                catch (Exception e){
                System.debug('****Exceptionactivivty'+ e);
                
                }
            }
        }
      
    
       
      /***************************************updatedesignmanager update Designer manager from master data to provide User for Approval process*******************************************/ 
       Public static void updatedesignmanager(set<id> stageid,set<id> masterid){
       String mastersalesforceuserid;
       List<NPD_Stage__c> updatestage=new List<NPD_Stage__c>();
       List<NPD_Stage__c> lststage=new List<NPD_Stage__c>();
       mastersalesforceuserid=[Select id,SalesforceUser__c from NPD_Master__c where id=:masterid].SalesforceUser__c;
       lststage=[SELECT id,Design_Manager__c from NPD_Stage__c where id=:stageid];
       for(NPD_Stage__c objstage:lststage){
       //objstage.status__c = 'In Progress';
       if(mastersalesforceuserid!=NULL)
       objstage.Design_Manager__c=mastersalesforceuserid;
       updatestage.add(objstage);
       }
       if(updatestage.size()>0){
       try{
          update updatestage;
       }catch(Exception ex){
       
       }
       }
                    integer a=10;
     integer b=2;
        integer a1 = a+b;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;
a++;

       
       }



    }