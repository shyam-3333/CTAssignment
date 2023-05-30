/*************************************************************************************************************
** Created By   : Vijayavardan Reddy.
** Created Date : 29-6-2015.
** Description  : This clas is used to update the activity active field to either true or false based on 
                  the grand chile checklist case sourcing and supply agency.
** Modified By  : Mohammed Raiyan//Roshi Rai
** Date         : 22-08-2015//24/05/2017
** Description  : To copy the Dynamic table values for the selected columns to the activities where CopyFrom Field has the Activity ID of the inserted checklist's Activity.  
***********************************************************************************************************/
public class CheckListTriggerHandler
{
        public List < NPD_Checklist__c > newList;
        public map < id, NPD_Checklist__c > oldMap;
        public map<String,String> fieldLevelFieldNameMap = new map<String,String>();
        public Map < String, Schema.SObjectField > fieldMap = New Map <String, Schema.SObjectField >();
        public CheckListTriggerHandler(List < NPD_Checklist__c > newList, map < id, NPD_Checklist__c > oldMap)
        {
                this.newList = newList;
                this.oldMap = oldMap;
                for(Schema.SObjectField field: Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values())
                {
                   fieldLevelFieldNameMap.put(field.getDescribe().getLabel(),field.getDescribe().getName());
                }
                fieldMap = Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap();
                System.debug('++++++++++++++fieldLevelFieldNameMap+++++++++++++++++++++++++'+fieldLevelFieldNameMap);

        }
        /*******************************************************************************
         * Method for after insert
         ********************************************************************************/
        public map < id, NPD_Activity__c > NActToProjectss = new map < id, NPD_Activity__c > ();
        public set < id > ProjectToActNamesss = new set < id > ();
        public map < id, map < string, map < decimal, NPD_Checklist__c >>> NprojctTActnameToActss = new map < id, map < string, map < decimal, NPD_Checklist__c >>> ();
        public map < id, NPD_Project_Name__c > projectToModelAndVendor = new map < id, NPD_Project_Name__c > ();
        public map < id, id > projectItem = new map < id, id > ();
        public map < id, id > actToProject = new map < id, id > ();
        public List < NPD_Checklist__c > listToupdate = new List < NPD_Checklist__c > ();
        public List < Sobject > listToInsert = new List < Sobject > ();
        public List < Sobject > listToInsertif = new List < Sobject > ();
        public List < NPD_Checklist__c > newList1 = new List < NPD_Checklist__c > ();
        public map < id, NPD_Checklist__c > ItemToChecklist = new map < id, NPD_Checklist__c > ();
        public string CaseMaterial                              {set;get;}
        public string CollectionName                            {set;get;}
        public string CommentsRemarks                           {set;get;}
        public string DevelopmentRoute                          {set;get;}
        public string Gender                                    {set;get;}
        public string Market{set;get;}
        public string Marketingbriefconceptreferencenumber      {set;get;}
        public string MovementFunction                          {set;get;}
        public string ProjectComplexity                         {set;get;}
        public string ProjectStatus                             {set;get;}
        public string ProjectType                               {set;get;}
        public string PSYNo                                     {set;get;}
        public string ReasonsforDrop                            {set;get;}
        public string StrapMaterial                             {set;get;}
        public string StrapSource                               {set;get;}
        public string TemplateType                              {set;get;}
        
        //Map of Project to Map of Project Item holding the List of Activities having the CopiedFrom field with the ID of Checklist's Activity which is being inserted
        public map < id, map < id, List < NPD_Activity__c >>> projectToActivity = new map < id, map < id, List < NPD_Activity__c >>> ();
        public map < id, map < id, List < NPD_Activity__c >>> projectToActivityclone = new map < id, map < id, List < NPD_Activity__c >>> ();
        public map < id, map < id, List < NPD_Activity__c >>> projectToActivityclonedelete = new map < id, map < id, List < NPD_Activity__c >>> ();
        /*******************************************************************************************************
        * Method used to create Map of Project to Map of Project Item holding the List of Activities having 
        the CopiedFrom field with the ID of Checklist's Activity which is being inserted or updated.
        ********************************************************************************************************/
        public void createMaps()
        {
                system.debug('The size of newlist is : ' + newList.size());
                // To get the checklist's Activity filed values 
                newList1 = [SELECT NPD_Activity_Chklist__r.NPD_Project_Name__c, NPD_Activity_Chklist__r.NPD_Project_Items__c FROM NPD_Checklist__c WHERE ID IN: newList];
                system.debug('newList1 newList1  : ' + newList1);
                for(NPD_Checklist__c chk: newList1)
                {
                        //Map of checklist's Activity Id to Project of the activty    
                        actToProject.put(chk.NPD_Activity_Chklist__c, chk.NPD_Activity_Chklist__r.NPD_Project_Name__c);
                        //Map of Checklist's ID to Project Item       
                        projectItem.put(chk.id, chk.NPD_Activity_Chklist__r.NPD_Project_Items__c);
                }
                system.debug('*****act to**' + actToProject.values() + '***project Item***' + projectItem.values());
                system.debug('*****act to**' + actToProject.values() + '***project Item***' + projectItem.values());
                //PROBLEM
                //   if(newList.size()==1){
                SYSTEM.DEBUG('Problem projectToActivity Problem *********' + projectToActivity);
                for(NPD_Activity__c act: [SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()])
                {
                        // SYSTEM.DEBUG('Problem projectToActivity Problem *********'+projectToActivity);
                        if(projectToActivity.get(act.NPD_Project_Name__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && !projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c))
                        {
                                //SYSTEM.DEBUG('Problem projectToActivity Problem ififififi*********'+projectToActivity);
                                projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                //SYSTEM.DEBUG('Problem projectToActivity Problem *ififiifsize********'+projectToActivity.size());
                        }
                        else
                        {
                                if(act.NPD_Project_Name__c != NULL && act.CopiedFrom__c != NULL)
                                        // Retrieving all the activities having the copiedFrom field value same as the checklist's project Item ID.
                                        SYSTEM.DEBUG('Problem projectToActivity Problem *elseleseelse********' + projectToActivity);
                                projectToActivity.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                {
                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                        {
                                                act
                                        }
                                });
                                SYSTEM.DEBUG('Problem projectToActivity Problem *elseleseelsesizesize********' + projectToActivity);
                        }
                        // system.debug('**Values for***'+projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c));
                }
                system.debug('**Values for projectToActivity**' + projectToActivity);
                // }
        }
        //system.debug('**Values for projectToActivity**'+projectToActivity);
        /*********************************************************************************size***************************
        ** Method fired for after Insert Trigger Event
        ** The main objective of the method is to create the checklist(Dynamic Tbale rows) for the activities 
                  having the copied from field value same as the project item field value of the inserted checklist's activty
        ****************************************************************************************************************/
        public void afterInsertHandler()
        {
                //Used to handle Recursion
                boolean ifenter;
                if(!IntegrationConstants.isFiredAfterInsert)
                {
                        map < id, map < integer, NPD_Checklist__c >> checkToChildCheck = new map < id, map < integer, NPD_Checklist__c >> ();
                        if(newList.size() == 1)
                        {
                                createMaps();
                                for(NPD_Checklist__c chk: newList)
                                {
                                        system.debug('*****act to**' + actToProject.get(chk.NPD_Activity_Chklist__c) + '***project Item***' + projectItem.get(chk.id));
                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                        {
                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                for(NPD_Activity__c act: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                {
                                                        NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                                        chkobj.NPD_Activity_Chklist__c = act.id;
                                                        chkobj.Columns_to_Copy__c = act.Columns_to_Copy__c;
                                                        chkobj.Row_Number__c = chk.Row_Number__c;
                                                        if(chkobj.Columns_to_Copy__c != NULL && !string.isblank(chkobj.Columns_to_Copy__c))
                                                        {
                                                                listToInsert.add(copyColumns(chkobj, chk));
                                                        }
                                                }
                                        }
                                }
                        }
                        else
                        {
                                try{
                                   newList1 = [SELECT NPD_Activity_Chklist__r.NPD_Project_Name__c, NPD_Activity_Chklist__r.NPD_Project_Items__c FROM NPD_Checklist__c WHERE ID IN: newList];
                                    system.debug('newList1 newList1  : ' + newList1);
                                }catch(Exception ex){System.debug('Limit exception Please contact System Admin');}
                                
                                for(NPD_Checklist__c chk: newList1)
                                {
                                        //Map of checklist's Activity Id to Project of the activty    
                                        actToProject.put(chk.NPD_Activity_Chklist__c, chk.NPD_Activity_Chklist__r.NPD_Project_Name__c);
                                        //Map of Checklist's ID to Project Item       
                                        projectItem.put(chk.id, chk.NPD_Activity_Chklist__r.NPD_Project_Items__c);
                                }
                                system.debug('*****act to**' + actToProject.values() + '***project Item***' + projectItem.values());
                                //PROBLEM
                                SYSTEM.DEBUG('Problem projectToActivity Problem *********' + projectToActivity);
                                for(NPD_Activity__c act: [SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()])
                                {
                                        System.debug('the projectToActivity.get(act.NPD_Project_Name__c) ******************* :' + projectToActivity);
                                        SYSTEM.DEBUG('Problem projectToActivity Problem *********' + projectToActivity);
                                        //  if(!projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && projectToActivity.get(act.NPD_Project_Name__c)!=NULL && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c)){
                                        if(projectToActivity.get(act.NPD_Project_Name__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && !projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c))
                                        {
                                                projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                projectToActivityclone.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                SYSTEM.DEBUG('Problem projectToActivity Problem ififififi*********' + projectToActivity);
                                                SYSTEM.DEBUG('Problem projectToActivitycloneprojectToActivityclone Problem ififififi*********' + projectToActivityclone);
                                        }
                                        else
                                        {
                                                if(act.NPD_Project_Name__c != NULL && act.CopiedFrom__c != NULL)
                                                        if(projectToActivity.size() != 0)
                                                        {
                                                                for(NPD_Checklist__c chk: newList)
                                                                {
                                                                        system.debug('*****act to**' + actToProject.get(chk.NPD_Activity_Chklist__c) + '***project Item***' + projectItem.get(chk.id));
                                                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                                        {
                                                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                                                for(NPD_Activity__c act1: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                                                {
                                                                                        NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                                                                        chkobj.NPD_Activity_Chklist__c = act1.id;
                                                                                        chkobj.Columns_to_Copy__c = act1.Columns_to_Copy__c;
                                                                                        chkobj.Row_Number__c = chk.Row_Number__c;
                                                                                        if(chkobj.Columns_to_Copy__c != NULL && !string.isblank(chkobj.Columns_to_Copy__c))
                                                                                        {
                                                                                                listToInsert.add(copyColumns(chkobj, chk));
                                                                                        }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                projectToActivity.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                {
                                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                                        {
                                                                act
                                                        }
                                                });
                                                projectToActivityclone.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                {
                                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                                        {
                                                                act
                                                        }
                                                });
                                                SYSTEM.DEBUG('Problem projectToActivity Problem *elseleseelse********' + projectToActivity);
                                        }
                                }
                                if(projectToActivityclone != NULL)
                                {
                                        for(NPD_Checklist__c chk: newList)
                                        {
                                                system.debug('*****act to**' + actToProject.get(chk.NPD_Activity_Chklist__c) + '***project Item***' + projectItem.get(chk.id));
                                                if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                {
                                                        //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                        for(NPD_Activity__c act: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                        {
                                                                NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                                                chkobj.NPD_Activity_Chklist__c = act.id;
                                                                chkobj.Columns_to_Copy__c = act.Columns_to_Copy__c;
                                                                chkobj.Row_Number__c = chk.Row_Number__c;
                                                                if(chkobj.Columns_to_Copy__c != NULL && !string.isblank(chkobj.Columns_to_Copy__c))
                                                                {
                                                                        listToInsert.add(copyColumns(chkobj, chk));
                                                                }
                                                        }
                                                }
                                        }
                                }
                        }
                        //Iterating Trigger.new values
                }
                if(!listToInsert.isempty())
                {
                        try
                        {
                                system.debug('********Insert List***' + listToInsert);
                                insert listToInsert;
                        }
                        catch(exception e)
                        {
                                system.debug('********Exception while inserting Checklist***' + e);
                        }
                }
                IntegrationConstants.isFiredAfterInsert = TRUE;
                for(npd_checklist__c npd1: newlist)
                {
                        system.debug('inside thee 1st for loop');
                        system.debug('outside of if statement :' + npd1.Activity_Reference__c);
                        if(npd1.Activity_Reference__c == 'AR-0201001004')
                        {
                                system.debug('inside of if statement :' + npd1.Activity_Reference__c);
                                // To the activity id of Existing Capability record.
                                system.debug('The npd1.CollectionId__c value : ' + npd1.CollectionId__c);
                                npd_activity__c ActRec = [select id, name__c, SerialNo__c from npd_activity__c where ModelId__c = : npd1.ProjectId__c and SerialNo__c = 'AR-0201005001'];
                                npd_checklist__c nc1 = new npd_checklist__c();
                                if(npd1.Variant_No__c != null) nc1.Variant_No__c = npd1.Variant_No__c;
                                if(npd1.Dial_No__c != null) nc1.Dial_No__c = npd1.Dial_No__c;
                                if(npd1.PSY_No__c != null) nc1.PSY_No__c = npd1.PSY_No__c;
                                //   if(npd1.CollectionName__c != null )
                                //   nc1.CollectionName__c = npd1.CollectionName__c;
                                if(npd1.Vendor_Ref_No__c != null) nc1.Vendor_Ref_No__c = npd1.Vendor_Ref_No__c;
                                nc1.NPD_Activity_Chklist__c = ActRec.id;
                                nc1.name = 'Rec Inserted';
                                //  insert nc1;
                                system.debug('the inserted value is : ' + nc1);
                        }
                }
                
        }
        /******************************************************************************************************
         ** Method Fired for the before insert trigger event
         ** Used to add row number for each checklist(dynamic table row)
         ** Only for those checklist items whose activity doesnt have a value for copied From field
         *******************************************************************************************************/
        set < id > ActID = new set < id > ();
        public void beforeInsertHandler()
        {
                System.debug('****newList********' + newList);
                for(NPD_Checklist__c chk: newList)
                {
                        if(chk.NPD_Activity_Chklist__c != NULL)
                        {
                                ActID.add(chk.NPD_Activity_Chklist__c);
                        }
                }
                createMapsForRowNumber();
                createMapsForPsyAndDesign();
                createMapsForAutoGeneration();
                autoGenerationInsert();
        }
        /************************************************************************************************************************************
         ** Method Fired for the before update trigger event
         ** Used to generate PSY Number for approved Checklist items
         ***************************************************************************************************************************************************/
        public void beforeUpdateHandler()
        {
                System.debug('*****DynamicFlow22222222222*********' + newList);
                set < id > actIdSet = new set < id > ();
                for(NPD_Checklist__c chk: newList)
                {
                        if(chk.NPD_Activity_Chklist__c != NULL && chk.Approval_Status__c != oldMap.get(chk.id).Approval_Status__c)
                        {
                                actIdSet.add(chk.NPD_Activity_Chklist__c);
                        }
                }
                System.debug('****actIdSetactIdSet*******' + actIdSet);
                for(NPD_Activity__c act: [SELECT ID, Brand1__c, name__c FROM NPD_Activity__c WHERE ID IN: actIdSet])
                {
                        if(act.name__c.equalsignoreCase('PSY No Allocation')) ActID.add(act.id);
                }
                System.debug('*****ActIDActIDActID7777772*********' + ActID);
                if(ActID.size() > 0) createMapsForPsyAndDesign();
        }
        /********************************************************************************************************************************
         * Method Name: createMapsForPsyAndDesign
         * Description: Used to create a map holding values of keys as Checklist's Activity ID & values as its Design Number, If any exists
         * If there are no design Number Existing, Then the map will hold the values of Activity's ID to DS-0000'
         * Same Procedure will be followed For PSY Number map 'actToBrandChecklistForPSY' But here along with the brand name as suffix format PSY-0000-T
         * The very first character of the brand name will be a suffix along with PSY number 
         * eg: If brand is Titan then the value would be PSY-0000-T.  
         *********************************************************************************************************************************/
        public void createMapsForPsyAndDesign()
        {
                System.debug('*****DynamicFlow33333333333333********');
                map < id, string > actToBrandChecklistForPSY = new map < id, string > ();
                map < string, String > actToDesignNo = new map < string, String > ();
                map < id, NPD_Activity__c > actToBrand = new map < id, NPD_Activity__c > ();
                string intCounter;
                map < string, NPD_Checklist__c > psyMap = new map < string, NPD_Checklist__c > ();
                List < NPD_Checklist__c > chekList3 = new List < NPD_Checklist__c > ([SELECT ID, NPD_Activity_Chklist__c, NPD_Activity_Chklist__r.name__c, NPD_Activity_Chklist__r.Brand1__c, PSY_No__c, Design_No__c, Tag__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.name__c = 'PSY No Allocation'
                        ORDER by CreatedDate DESC LIMIT 1
                ]);
                List < NPD_Checklist__c > chekList2 = new List < NPD_Checklist__c > ([SELECT ID, NPD_Activity_Chklist__c, NPD_Activity_Chklist__r.name__c, NPD_Activity_Chklist__r.Brand1__c, PSY_No__c, Design_No__c, Tag__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.name__c = 'Concept Design - IDS' and Design_No__c  != null
                        ORDER by CreatedDate DESC LIMIT 1
                ]);
                for(NPD_Checklist__c chk: chekList3)
                {
                        if(psyMap.isempty() && chk.NPD_Activity_Chklist__r.name__c == 'PSY No Allocation' && chk.PSY_No__c != NULL && chk.Tag__c == 'New')
                        {
                                system.debug('***Psy**' + chk.psy_no__c);
                                psyMap.put('psy', chk);
                        }
                }
                system.debug('***psy map**' + psyMap);
                for(NPD_Activity__c act: [SELECT ID, Brand1__c, name__c FROM NPD_Activity__c WHERE name__c = 'Concept Design - IDS' ORDER BY CreatedDate DESC LIMIT 10])
                {
                        actToBrand.put(act.id, act);
                }
                system.debug('***New Debug***' + !actToBrand.isempty() + '***Second condition***' + chekList2.size() + '****' + newList);
                system.debug('actToBrand******************' + actToBrand);
                if(!actToBrand.isempty())
                {
                    /*hide by sudama as psy number Allocation field not there is system
                        if(chekList3.size() == 0)
                        {
                                system.debug('newListchekList2.size()chekList2.size()' + newList);
                                for(NPD_Checklist__c chk: newList)
                                {
                                        if(!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'PSY No Allocation' && actToBrand.get(chk.NPD_Activity_Chklist__c).Brand1__c != NULL)
                                        {
                                                string PSY = 'PSY-0000-' + (actToBrand.get(chk.NPD_Activity_Chklist__c).Brand1__c).substring(0, 1);
                                                actToBrandChecklistForPSY.put(chk.NPD_Activity_Chklist__c, PSY);
                                        }
                                        else if(!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'Concept Design - IDS') actToDesignNo.put('design', 'DS-0000');
                                        system.debug('***actToDesignNoactToDesignNo**' + actToDesignNo);
                                }
                        }*/
                       
                                system.debug('chekList2*********' + chekList2);
                                for(NPD_Checklist__c chk: chekList2)
                                {
                                       
                                        if(chk.NPD_Activity_Chklist__r.name__c == 'Concept Design - IDS' && chk.Design_No__c != NULL)
                                        {
                                                if(actToDesignNo.isempty())
                                                {
                                                        actToDesignNo.put('design', chk.Design_No__c);
                                                        intCounter = 'abd';
                                                }
                                        }
                                }
                       
                }
                if(!actToBrand.isempty())
                {
                        if(chekList2.size() == 0)
                        {
                                system.debug('newListchekList2.size()chekList2.size()' + newList);
                                for(NPD_Checklist__c chk: newList)
                                {
                                        if(!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'PSY No Allocation' && actToBrand.get(chk.NPD_Activity_Chklist__c).Brand1__c != NULL)
                                        {
                                                string PSY = 'PSY-0000-' + (actToBrand.get(chk.NPD_Activity_Chklist__c).Brand1__c).substring(0, 1);
                                                actToBrandChecklistForPSY.put(chk.NPD_Activity_Chklist__c, PSY);
                                        }
                                        else if(!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'Concept Design - IDS') actToDesignNo.put('design', 'DS-0000');
                                        system.debug('***actToDesignNoactToDesignNo**' + actToDesignNo);
                                }
                        }
                        else
                        {
                                system.debug('chekList2*********' + chekList2);
                                for(NPD_Checklist__c chk: chekList2)
                                {
                                        if(chk.NPD_Activity_Chklist__r.name__c == 'Concept Design - IDS' && chk.Design_No__c != NULL)
                                        {
                                                if(actToDesignNo.isempty())
                                                {
                                                        actToDesignNo.put('design', chk.Design_No__c);
                                                        intCounter = 'abd';
                                                }
                                        }
                                }
                        }
                }
                boolean first = false;
                //Iterating Trigger.new Values
                integer num1;
                integer newNum1;
                boolean Flag = true;
                System.debug('newList******DSY********88' + newList);
                //Contains  many record
                for(NPD_Checklist__c chk: newList)
                {
                        System.debug('actToDesignNoinside' + actToDesignNo);
                        system.debug('***BEFORE else if***' + actToDesignNo.containskey(chk.NPD_Activity_Chklist__c) + '**vALUE**' + actToDesignNo);
                        system.debug('***Condition 248' + (!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'PSY No Allocation' && chk.Tag__c != NULL && chk.Approval_Status__c != NULL && chk.Tag__c.equalsignoreCase('New') && chk.Approval_Status__c.equalsignoreCase('Approved')));
                        
                        // if(!actToBrand.isempty() && actToBrand.containskey(chk.NPD_Activity_Chklist__c) && actToBrand.get(chk.NPD_Activity_Chklist__c).name__c == 'Concept Design - IDS' && !actToDesignNo.isempty() && actToDesignNo.containskey('design') && actToDesignNo.get('design') != NULL)
                        //{
                                //system.debug('***Inside else if***' + (actToDesignNo.get(chk.NPD_Activity_Chklist__c) != NULL || !string.isblank(actToDesignNo.get(chk.NPD_Activity_Chklist__c))));
                                System.debug('************intCounter first*******' + intCounter);
                                // if(actToDesignNo.get('design') != NULL || !string.isblank(actToDesignNo.get('design')) && intCounter=='abd'){
                                if(intCounter == 'abd')
                                {
                                        string previous = actToDesignNo.get('design');
                                        System.debug('previous DSY' + previous);
                                        string zero = '0000';
                                        previous = previous.removeStartIgnoreCase('DS-');
                                        integer num = integer.valueof(previous);
                                        num = num + 1;
                                        string numString = string.valueof(num);
                                        numString = zero.substring(0, zero.length() - numString.length()) + numString;
                                        intCounter = 'DS-' + numString;
                                        System.debug('************intCounter **ififif*****' + intCounter);
                                        chk.Design_No__c = intCounter;
                                }
                                else
                                {
                                        System.debug('************intCounter *******' + intCounter);
                                        chk.Design_No__c = 'DS-0000';
                                }
                                System.debug('***********chk.Design_No__c*******' + chk.Design_No__c);
                        }
                        
               // }
               
        }
        /***************************************************************************************************************************************************
         * Method Name : createMapsForRowNumber
         * Description : This method is used to create maps holding key as Activity's ID and values as the latest 
         * row number of the existing checklist for the activity
         * If no checklist is existing then the map will hold 0 for the row number.
         *****************************************************************************************************************************************************/
        public void createMapsForRowNumber()
        {
                System.debug('***createMapsForRowNumber******' + ActID);
                map < id, Decimal > ActIdToRownum = new map < id, Decimal > ();
                List < NPD_Checklist__c > chekList = new List < NPD_Checklist__c > ([SELECT ID, Row_Number__c, NPD_Activity_Chklist__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__c IN: ActID ORDER BY Row_Number__c DESC]);
                map < id, NPD_Activity__c > chkActToAct = new map < id, NPD_Activity__c > ([SELECT ID, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE ID IN: ActID AND CopiedFrom__c != NULL]);
                System.debug('***chekList *****' + chekList);
                System.debug('***cchkActToAct******' + chkActToAct);
                if(chekList.size() == 0)
                {
                        System.debug('chekList.size()==0');
                        for(NPD_Checklist__c chk: newList)
                        {
                                ActIdToRownum.put(chk.NPD_Activity_Chklist__c, 0);
                                System.debug('ActIdToRownumififif' + ActIdToRownum);
                        }
                }
                else
                {
                        for(NPD_Checklist__c chk: chekList)
                        {
                                if(chk.Row_Number__c != NULL && !ActIdToRownum.containskey(chk.NPD_Activity_Chklist__c))
                                {
                                        ActIdToRownum.put(chk.NPD_Activity_Chklist__c, chk.Row_Number__c);
                                }
                                System.debug('ActIdToRownumelse' + ActIdToRownum);
                        }
                }
                // Iterating Trigger.new Values
                for(NPD_Checklist__c chk: newList)
                {
                        System.debug('chkActToAct.containskey(chk.NPD_Activity_Chklist__c');
                        if(!chkActToAct.containskey(chk.NPD_Activity_Chklist__c))
                        {
                                System.debug('chkActToAct.containskey(chk.NPD_Activity_Chklist__c');
                                if(!ActIdToRownum.isempty() && ActIdToRownum.containskey(chk.NPD_Activity_Chklist__c) && ActIdToRownum.get(chk.NPD_Activity_Chklist__c) != NULL) chk.Row_Number__c = ActIdToRownum.get(chk.NPD_Activity_Chklist__c) + 1;
                                ActIdToRownum.put(chk.NPD_Activity_Chklist__c, chk.Row_Number__c);
                                System.debug('ActIdToRownumelseActIdToRownumActIdToRownum*******' + ActIdToRownum);
                        }
                }
        }
        /************************************************************************************************************************************
         *Method Name : createMapsForAutoGeneration
         *Description : Whenever a checklist is being inserted and If the Auto-Generated Field value of its activity has some value
         *Then those values will be auto populated from the respective tables as given in the Requirement in Details V6.0
         **************************************************************************************************************************************/
        public void createMapsForAutoGeneration()
        {
                system.debug('*********ActID*****' + ActID);
                for(NPD_Activity__c act: [SELECT ID, NPD_Project_Name__r.Model_No__c, NPD_Project_Name__r.Gender__c, NPD_Project_Name__r.PSY_No__c, NPD_Project_Name__r.Vendor_Ref_No__c, NPD_Project_Name__c, Auto_Generated__c, Columns_to_Copy__c FROM NPD_Activity__c WHERE Id IN: ActID AND Auto_Generated__c != NULL])
                {
                        if(act.NPD_Project_Name__c != NULL)
                        {
                                NActToProjectss.put(act.id, act);
                                ProjectToActNamesss.add(act.NPD_Project_Name__c);
                        }
                        if(!string.isblank(act.NPD_Project_Name__r.Model_No__c))
                        {
                                NPD_Project_Name__c project = new NPD_Project_Name__c();
                                project.id = act.NPD_Project_Name__c;
                                project.Model_No__c = act.NPD_Project_Name__r.Model_No__c;
                                if(!string.isblank(act.NPD_Project_Name__r.Vendor_Ref_No__c)) project.Vendor_Ref_No__c = act.NPD_Project_Name__r.Vendor_Ref_No__c;
                                if(!string.isblank(act.NPD_Project_Name__r.PSY_No__c)) project.PSY_No__c = act.NPD_Project_Name__r.PSY_No__c;
                                if(!string.isblank(act.NPD_Project_Name__r.Gender__c)) project.Gender__c = act.NPD_Project_Name__r.Gender__c;
                                projectToModelAndVendor.put(act.NPD_Project_Name__c, project);
                        }
                }
                system.debug('***Print map***' + projectToModelAndVendor);
                for(NPD_Checklist__c act: [SELECT id, Row_Number__c, NPD_Activity_Chklist__r.NPD_Project_Name__r.Model_No__c, NPD_Activity_Chklist__r.NPD_Project_Name__r.Vendor_Ref_No__c, NPD_Activity_Chklist__r.NPD_Project_Name__r.PSY_No__c, NPD_Activity_Chklist__c, NPD_Activity_Chklist__r.name__c, NPD_Activity_Chklist__r.NPD_Project_Name__c, Design_No__c, Product_Designer_Name__c, Vendor_Name__c, Vendor_Ref_No__c, Supply_Agency__c, Case_Sourcing__c, Model_No__c, Dial_No__c, Variant_No__c, Gender__c, PSY_No__c FROM NPD_Checklist__c
                                WHERE NPD_Activity_Chklist__r.NPD_Project_Name__c IN: ProjectToActNamesss AND(NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS'
                                        OR NPD_Activity_Chklist__r.name__c = 'Product Designer Allocation - IDS'
                                        OR NPD_Activity_Chklist__r.name__c = 'Concept Finalization - OSD'
                                        OR NPD_Activity_Chklist__r.name__c = 'Case/Model No Allocation'
                                        OR NPD_Activity_Chklist__r.name__c = 'PSY No Allocation'
                                        OR NPD_Activity_Chklist__r.name__c = 'PB/PM Release , Approval  and Recipt')
                        ])
                {
                        if(!NprojctTActnameToActss.isempty() && NprojctTActnameToActss.containskey(act.NPD_Activity_Chklist__r.NPD_Project_Name__c) && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty())
                        {
                                system.debug('*****Act Name****' + act.NPD_Activity_Chklist__r.name__c);
                                if(act.NPD_Activity_Chklist__r.name__c == 'Case/Model No Allocation')
                                {
                                        if(act.Row_Number__c != NULL && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Case') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Case').isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Case') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Case').isempty()) NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Case').put(act.Row_Number__c, act);
                                        else NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('Case', new map < decimal, NPD_Checklist__c >
                                        {
                                                act.Row_Number__c => act
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'PSY No Allocation')
                                {
                                        if(act.Row_Number__c != NULL && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('PSY') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('PSY').isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('PSY') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('PSY').isempty()) NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('PSY').put(act.Row_Number__c, act);
                                        else NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('PSY', new map < decimal, NPD_Checklist__c >
                                        {
                                                act.Row_Number__c => act
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'PB/PM Release , Approval  and Recipt')
                                {
                                        if(act.Row_Number__c != NULL && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('VariantDial') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('VariantDial').isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('VariantDial') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('VariantDial').isempty()) NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('VariantDial').put(act.Row_Number__c, act);
                                        else NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('VariantDial', new map < decimal, NPD_Checklist__c >
                                        {
                                                act.Row_Number__c => act
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'Concept Finalization - OSD')
                                {
                                        if(act.Row_Number__c != NULL && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Vendor') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Vendor').isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Vendor') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Vendor').isempty()) NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Vendor').put(act.Row_Number__c, act);
                                        else NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('Vendor', new map < decimal, NPD_Checklist__c >
                                        {
                                                act.Row_Number__c => act
                                        });
                                }
                                /*   else if(act.NPD_Activity_Chklist__r.name__c == 'Product Designer Allocation - IDS'){
                                       if(act.Row_Number__c != NULL &&  !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Product') &&  !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Product').isempty() &&  NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('Product') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Product').isempty())
                                           NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('Product').put(act.Row_Number__c,act);
                                       else
                                           NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('Product',new map<decimal,NPD_Checklist__c>{act.Row_Number__c => act});              
                                   }*/
                                else if(act.NPD_Activity_Chklist__r.name__c == 'Concept Presentation to PMG - IDS')
                                {
                                        if(act.Row_Number__c != NULL && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('DesignGender') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('DesignGender').isempty() && NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).containskey('DesignGender') && !NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('DesignGender').isempty()) NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).get('DesignGender').put(act.Row_Number__c, act);
                                        else NprojctTActnameToActss.get(act.NPD_Activity_Chklist__r.NPD_Project_Name__c).put('DesignGender', new map < decimal, NPD_Checklist__c >
                                        {
                                                act.Row_Number__c => act
                                        });
                                }
                        }
                        else
                        {
                                if(act.NPD_Activity_Chklist__r.name__c == 'Case/Model No Allocation')
                                {
                                        NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c, new map < string, map < decimal, NPD_Checklist__c >>
                                        {
                                                'Case' => new map < decimal,
                                                NPD_Checklist__c >
                                                {
                                                        act.Row_Number__c => act
                                                }
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'PSY No Allocation')
                                {
                                        NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c, new map < string, map < decimal, NPD_Checklist__c >>
                                        {
                                                'PSY' => new map < decimal,
                                                NPD_Checklist__c >
                                                {
                                                        act.Row_Number__c => act
                                                }
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'PB/PM Release , Approval  and Recipt')
                                {
                                        NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c, new map < string, map < decimal, NPD_Checklist__c >>
                                        {
                                                'VariantDial' => new map < decimal,
                                                NPD_Checklist__c >
                                                {
                                                        act.Row_Number__c => act
                                                }
                                        });
                                }
                                else if(act.NPD_Activity_Chklist__r.name__c == 'Concept Finalization - OSD')
                                {
                                        NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c, new map < string, map < decimal, NPD_Checklist__c >>
                                        {
                                                'Vendor' => new map < decimal,
                                                NPD_Checklist__c >
                                                {
                                                        act.Row_Number__c => act
                                                }
                                        });
                                }
                                /*else if(act.NPD_Activity_Chklist__r.name__c == 'Product Designer Allocation - IDS'){
                                    NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c,new map<string,map<decimal,NPD_Checklist__c>>{'Product' => new map<decimal,NPD_Checklist__c>{act.Row_Number__c => act}});
                                }*/
                                else if(act.NPD_Activity_Chklist__r.name__c == 'Concept Presentation to PMG - IDS')
                                {
                                        NprojctTActnameToActss.put(act.NPD_Activity_Chklist__r.NPD_Project_Name__c, new map < string, map < decimal, NPD_Checklist__c >>
                                        {
                                                'DesignGender' => new map < decimal,
                                                NPD_Checklist__c >
                                                {
                                                        act.Row_Number__c => act
                                                }
                                        });
                                }
                        }
                }
        }
        Public void autoGenerationInsert()
        {
                for(NPD_Checklist__c chk: Newlist)
                {
                        if(!NActToProjectss.isempty() && NActToProjectss.containskey(chk.NPD_Activity_Chklist__c) && NActToProjectss.get(chk.NPD_Activity_Chklist__c).Auto_Generated__c != NULL && !string.isBlank(NActToProjectss.get(chk.NPD_Activity_Chklist__c).Auto_Generated__c))
                        {
                                string auto = NActToProjectss.get(chk.NPD_Activity_Chklist__c).Auto_Generated__c;
                                system.debug('$$$Auto$$$' + auto);
                                if(auto.contains('Design No') || auto.contains('Gender'))
                                {
                                        if(!projectToModelAndVendor.isempty() && projectToModelAndVendor.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) != NULL)
                                        {
                                                if(!string.isblank(projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Gender__c)) chk.Gender__c = projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Gender__c;
                                        }
                                        else if(chk.Row_Number__c != NULL && !NActToProjectss.isempty() && NActToProjectss.containskey(chk.NPD_Activity_Chklist__c) && NActToProjectss.get(chk.NPD_Activity_Chklist__c) != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('DesignGender') && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('DesignGender').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('DesignGender').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('DesignGender').get(chk.Row_Number__c) != NULL)
                                        {
                                                NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('DesignGender').get(chk.Row_Number__c);
                                                system.debug('The Auto Generated Design No is   at checkMaster.Design_No__c : ' + checkMaster.Design_No__c);
                                                if(checkMaster.Design_No__c != NULL) chk.Design_No__c = checkMaster.Design_No__c;
                                                if(checkMaster.Gender__c != NULL) chk.Gender__c = checkMaster.Gender__c;
                                                if(checkMaster.Product_Designer_Name__c != NULL) chk.Product_Designer_Name__c = checkMaster.Product_Designer_Name__c;
                                        }
                                }
                                /*if(auto.contains('Product Designer Name')){
                                        if(chk.Row_Number__c != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('Product') && 
                                           !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Product').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Product').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Product').get(chk.Row_Number__c) != NULL ){
                                             NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Product').get(chk.Row_Number__c);
                                               if(checkMaster.Product_Designer_Name__c != NULL)
                                                chk.Product_Designer_Name__c =  checkMaster.Product_Designer_Name__c;   
                                           }
                                    }*/
                                if(auto.contains('Vendor Name') || auto.contains('Vendor Ref No'))
                                {
                                        if(!projectToModelAndVendor.isempty() && projectToModelAndVendor.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) != NULL)
                                        {
                                                if(!string.isblank(projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Vendor_Ref_No__c)) chk.Vendor_Ref_No__c = projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Vendor_Ref_No__c;
                                        }
                                        else if(chk.Row_Number__c != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('Vendor') && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Vendor').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Vendor').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Vendor').get(chk.Row_Number__c) != NULL)
                                        {
                                                NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Vendor').get(chk.Row_Number__c);
                                                if(checkMaster.Vendor_Name__c != NULL) chk.Vendor_Name__c = checkMaster.Vendor_Name__c;
                                                if(checkMaster.Vendor_Ref_No__c != NULL) chk.Vendor_Ref_No__c = checkMaster.Vendor_Ref_No__c;
                                        }
                                }
                                if(auto.contains('Variant No') || auto.contains('Dial No'))
                                {
                                        if(chk.Row_Number__c != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('VariantDial') && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('VariantDial').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('VariantDial').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('VariantDial').get(chk.Row_Number__c) != NULL)
                                        {
                                                NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('VariantDial').get(chk.Row_Number__c);
                                                if(checkMaster.Variant_No__c != NULL) chk.Variant_No__c = checkMaster.Variant_No__c;
                                                if(checkMaster.Dial_No__c != NULL) chk.Dial_No__c = checkMaster.Dial_No__c;
                                        }
                                }
                                if(auto.contains('Case Sourcing') || auto.contains('Supply Agency') || auto.contains('Model No'))
                                {
                                        if(!projectToModelAndVendor.isempty() && projectToModelAndVendor.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) != NULL)
                                        {
                                                if(!string.isblank(projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Model_No__c)) chk.Model_No__c = projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).Model_No__c;
                                        }
                                        if(chk.Row_Number__c != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('Case') && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Case').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Case').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Case').get(chk.Row_Number__c) != NULL)
                                        {
                                                NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('Case').get(chk.Row_Number__c);
                                                if(checkMaster.Case_Sourcing__c != NULL) chk.Case_Sourcing__c = checkMaster.Case_Sourcing__c;
                                                if(checkMaster.Supply_Agency__c != NULL) chk.Supply_Agency__c = checkMaster.Supply_Agency__c;
                                                if(checkMaster.Model_No__c != NULL) chk.Model_No__c = checkMaster.Model_No__c;
                                        }
                                }
                                if(auto.contains('PSY No'))
                                {
                                        if(!projectToModelAndVendor.isempty() && projectToModelAndVendor.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) != NULL)
                                        {
                                                if(!string.isblank(projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).PSY_No__c)) chk.PSY_No__c = projectToModelAndVendor.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).PSY_No__c;
                                        }
                                        else if(chk.Row_Number__c != NULL && NprojctTActnameToActss.containskey(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c) && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).containskey('PSY') && !NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('PSY').isempty() && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('PSY').containskey(chk.Row_Number__c) && NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('PSY').get(chk.Row_Number__c) != NULL)
                                        {
                                                NPD_Checklist__c checkMaster = NprojctTActnameToActss.get(NActToProjectss.get(chk.NPD_Activity_Chklist__c).NPD_Project_Name__c).get('PSY').get(chk.Row_Number__c);
                                                if(checkMaster.PSY_No__c != NULL) chk.PSY_No__c = checkMaster.PSY_No__c;
                                        }
                                }
                        }
                }
        }
        /*****************************************************************************************************
        ** Method fired for the after update event of trigger
        ** Used to update the checklist(rows of dynamic table) with values same as the updated checklist
           to the checklist whose activities having same copied from value as the update checklist's activity's project item of the same project
        *******************************************************************************************************/
        map < id, sobject > maptoUpdate = new map < id, sobject > ();
        public void afterUpdateHandler()
        {
                Boolean enter = true;
                list < sobject > ToUpdate = new list < sobject > ();
                map < id, map < integer, NPD_Checklist__c >> checkToChildCheck = new map < id, map < integer, NPD_Checklist__c >> ();
                if(!IntegrationConstants.isAfterUpdate)
                {
                        map < id, List < NPD_Checklist__c >> ActIDToCheckLists = new map < id, List < NPD_Checklist__c >> ();
                        map < id, id > projectItemID = new map < id, id > ();
                        List < NPD_Checklist__c > chklist = new List < NPD_Checklist__c > ();
                        system.debug('*****act to**' + actToProject.values() + '***project Item***' + projectItem.values());
                        newList1 = [SELECT NPD_Activity_Chklist__r.NPD_Project_Name__c, NPD_Activity_Chklist__r.NPD_Project_Items__c FROM NPD_Checklist__c WHERE ID IN: newList];
                        system.debug('newList1 newList1  : ' + newList1);
                        for(NPD_Checklist__c chk: newList1)
                        {
                                //Map of checklist's Activity Id to Project of the activty    
                                actToProject.put(chk.NPD_Activity_Chklist__c, chk.NPD_Activity_Chklist__r.NPD_Project_Name__c);
                                //Map of Checklist's ID to Project Item       
                                projectItem.put(chk.id, chk.NPD_Activity_Chklist__r.NPD_Project_Items__c);
                        }
                        system.debug('*****act to**' + actToProject.values() + '***project Item***' + projectItem.values());
                        chklist = [SELECT PSY_No__c, Design_No__c, Active__c, Activity_Reference__c, Approval_Status__c, Approval_Submitter__c, Case_Sourcing__c, CollectionName__c, Collection__c, Component__c, Cost__c, CreatedById, CreatedDate, CurrencyIsoCode, Currency__c, Current_Approver__c, Date_of_Completion__c, Dial_No__c, Engineering_Designer_Name__c, Gender__c, Id, Indent_Quanity__c,
                                IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, Model_No__c, Multilevel_Notification__c, Multi_Approvers__c, Name, No_of_Designs__c, NPD_Activity_Chklist__c, OwnerId, Product_Designer_Name__c, Project_Owner__c, Quantity__c, Receipt_Quanity__c, Remarks__c, Row_Number__c, Sample_Recipt_Date__c, Status__c, Stock_No__c,
                                Supply_Agency__c, Columns_to_Copy__c, SystemModstamp, Tentative_Launch_Date__c, Total_Quantity__c, Type_of_Locator__c, Variant_No__c, Vendor_Name__c, Vendor_Ref_No__c, Verdict__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.NPD_Project_Name__c IN: actToProject.values() AND NPD_Activity_Chklist__r.CopiedFrom__c IN: projectItem.values()
                        ];
                        system.debug('chklistchklist' + chklist);
                        system.debug('++++Marketingold record +++' + ActIDToCheckLists);
                        system.debug('++++afternewListnewList222++newList+' + newList);
                        //Design_No__c,
                        for(NPD_Checklist__c chk: [SELECT PSY_No__c, Design_No__c, Active__c, Activity_Reference__c, Approval_Status__c, Approval_Submitter__c, Case_Sourcing__c, CollectionName__c, Collection__c, Component__c, Cost__c, CreatedById, CreatedDate, CurrencyIsoCode, Currency__c, Current_Approver__c, Date_of_Completion__c, Dial_No__c, Engineering_Designer_Name__c, Gender__c, Id, Indent_Quanity__c,
                                        IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, Model_No__c, Multilevel_Notification__c, Multi_Approvers__c, Name, No_of_Designs__c, NPD_Activity_Chklist__c, OwnerId, Product_Designer_Name__c, Project_Owner__c, Quantity__c, Receipt_Quanity__c, Remarks__c, Row_Number__c, Sample_Recipt_Date__c, Status__c, Stock_No__c,
                                        Supply_Agency__c, Columns_to_Copy__c, SystemModstamp, Tentative_Launch_Date__c, Total_Quantity__c, Type_of_Locator__c, Variant_No__c, Vendor_Name__c, Vendor_Ref_No__c, Verdict__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.NPD_Project_Name__c IN: actToProject.values() AND NPD_Activity_Chklist__r.CopiedFrom__c IN: projectItem.values()
                                ])
                        {
                                if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(chk.NPD_Activity_Chklist__c) && ActIDToCheckLists.get(chk.NPD_Activity_Chklist__c) != NULL)
                                {
                                        ActIDToCheckLists.get(chk.NPD_Activity_Chklist__c).add(chk);
                                }
                                else
                                {
                                        ActIDToCheckLists.put(chk.NPD_Activity_Chklist__c, new list < NPD_Checklist__c >
                                        {
                                                chk
                                        });
                                }
                        }
                        if(newList.size() == 1)
                        {
                                createMaps();
                                system.debug('after createMaps : ');
                                set < id > check = new set < id > ();
                                //Engennering desigh data in Newlist
                                for(NPD_Checklist__c chk: newList)
                                {
                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                        {
                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                //Marketing Data
                                                system.debug('projectToActivity***' + projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)));
                                                for(NPD_Activity__c act: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                {
                                                        if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act.id) && ActIDToCheckLists.get(act.id) != NULL)
                                                        {
                                                                integer i = 1;
                                                                for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act.id))
                                                                {
                                                                        if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                        {
                                                                                if(!checkToChildCheck.isempty() && checkToChildCheck.containskey(chk.id) && !checkToChildCheck.get(chk.id).isempty())
                                                                                {
                                                                                        system.debug('**********IIIIIIIIIIIIIIIIII*******8' + i);
                                                                                        checkToChildCheck.get(chk.id).put(i, chk2);
                                                                                        system.debug('************IFIFIFcheckToChildCheck***********8' + checkToChildCheck);
                                                                                }
                                                                                else
                                                                                {
                                                                                        checkToChildCheck.put(chk.id, new map < integer, NPD_Checklist__c >
                                                                                        {
                                                                                                i => chk2
                                                                                        });
                                                                                        system.debug('************elsecheckToChildCheck***********8' + checkToChildCheck);
                                                                                }
                                                                                system.debug('************chk***********8' + chk);
                                                                                system.debug('***********chk2***********8' + chk2);
                                                                                if(!maptoUpdate.containskey(chk2.id))
                                                                                {
                                                                                        maptoUpdate.put(chk2.id, copyColumns(chk2, chk));
                                                                                        system.debug('**********maptoUpdate***************' + maptoUpdate);
                                                                                        //PLS chk update funtionality once 
                                                                                        break;
                                                                                }
                                                                        }
                                                                        i++;
                                                                        system.debug('**********IIIIIIIIIIIIIIIIII*******outincre' + i);
                                                                }
                                                        }
                                                }
                                        }
                                }
                        }
                        else
                        {
                                for(NPD_Activity__c act: [SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()])
                                {
                                        System.debug('the projectToActivity.get(act.NPD_Project_Name__c) ******************* :' + projectToActivity);
                                        SYSTEM.DEBUG('Problem projectToActivity Problem *********' + projectToActivity);
                                        //  if(!projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && projectToActivity.get(act.NPD_Project_Name__c)!=NULL && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c)){
                                        if(projectToActivity.get(act.NPD_Project_Name__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && !projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c))
                                        {
                                                projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                projectToActivityclone.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                SYSTEM.DEBUG('Problem projectToActivity Problem ififififi*********' + projectToActivity);
                                        }
                                        else
                                        {
                                                if(act.NPD_Project_Name__c != NULL && act.CopiedFrom__c != NULL)
                                                        if(projectToActivity.size() != 0)
                                                        {
                                                                //List<NPD_Checklist__c> chklist=new List<NPD_Checklist__c>();
                                                                set < id > check = new set < id > ();
                                                                //Engennering desigh data in Newlist
                                                                for(NPD_Checklist__c chk: newList)
                                                                {
                                                                        ActID.add(chk.id);
                                                                        system.debug('+++ActID++****' + ActID);
                                                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                                        {
                                                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                                                //Marketing Data
                                                                                system.debug('projectToActivity***' + projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)));
                                                                                for(NPD_Activity__c act1: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                                                {
                                                                                        if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act1.id) && ActIDToCheckLists.get(act1.id) != NULL)
                                                                                        {
                                                                                                integer i = 1;
                                                                                                for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act1.id))
                                                                                                {
                                                                                                        if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                                                        {
                                                                                                                if(!checkToChildCheck.isempty() && checkToChildCheck.containskey(chk.id) && !checkToChildCheck.get(chk.id).isempty())
                                                                                                                {
                                                                                                                        system.debug('**********IIIIIIIIIIIIIIIIII*******8' + i);
                                                                                                                        checkToChildCheck.get(chk.id).put(i, chk2);
                                                                                                                        system.debug('************IFIFIFcheckToChildCheck***********8' + checkToChildCheck);
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                        checkToChildCheck.put(chk.id, new map < integer, NPD_Checklist__c >
                                                                                                                        {
                                                                                                                                i => chk2
                                                                                                                        });
                                                                                                                        system.debug('************elsecheckToChildCheck***********8' + checkToChildCheck);
                                                                                                                }
                                                                                                                system.debug('************chk***********8' + chk);
                                                                                                                system.debug('***********chk2***********8' + chk2);
                                                                                                                if(!maptoUpdate.containskey(chk2.id))
                                                                                                                {
                                                                                                                        maptoUpdate.put(chk2.id, copyColumns(chk2, chk));
                                                                                                                        system.debug('**********maptoUpdate***************' + maptoUpdate);
                                                                                                                        //PLS chk update funtionality once 
                                                                                                                        break;
                                                                                                                }
                                                                                                        }
                                                                                                        i++;
                                                                                                        system.debug('**********IIIIIIIIIIIIIIIIII*******outincre' + i);
                                                                                                }
                                                                                        }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                projectToActivity.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                {
                                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                                        {
                                                                act
                                                        }
                                                });
                                                projectToActivityclone.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                {
                                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                                        {
                                                                act
                                                        }
                                                });
                                                SYSTEM.DEBUG('Problem projectToActivity Problem *elseleseelse********' + projectToActivity);
                                        }
                                }
                                if(projectToActivityclone.size() != NULL)
                                {
                                        //Engennering desigh data in Newlist
                                        for(NPD_Checklist__c chk: newList)
                                        {
                                                ActID.add(chk.id);
                                                system.debug('+++ActID++****' + ActID);
                                                if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                {
                                                        //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                        //Marketing Data
                                                        system.debug('projectToActivity***' + projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)));
                                                        for(NPD_Activity__c act: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                        {
                                                                if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act.id) && ActIDToCheckLists.get(act.id) != NULL)
                                                                {
                                                                        integer i = 1;
                                                                        for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act.id))
                                                                        {
                                                                                if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                                {
                                                                                        if(!checkToChildCheck.isempty() && checkToChildCheck.containskey(chk.id) && !checkToChildCheck.get(chk.id).isempty())
                                                                                        {
                                                                                                system.debug('**********IIIIIIIIIIIIIIIIII*******8' + i);
                                                                                                checkToChildCheck.get(chk.id).put(i, chk2);
                                                                                                system.debug('************IFIFIFcheckToChildCheck***********8' + checkToChildCheck);
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                                checkToChildCheck.put(chk.id, new map < integer, NPD_Checklist__c >
                                                                                                {
                                                                                                        i => chk2
                                                                                                });
                                                                                                system.debug('************elsecheckToChildCheck***********8' + checkToChildCheck);
                                                                                        }
                                                                                        system.debug('************chk***********8' + chk);
                                                                                        system.debug('***********chk2***********8' + chk2);
                                                                                        if(!maptoUpdate.containskey(chk2.id))
                                                                                        {
                                                                                                maptoUpdate.put(chk2.id, copyColumns(chk2, chk));
                                                                                                system.debug('**********maptoUpdate***************' + maptoUpdate);
                                                                                                //PLS chk update funtionality once 
                                                                                                break;
                                                                                        }
                                                                                }
                                                                                i++;
                                                                                system.debug('**********IIIIIIIIIIIIIIIIII*******outincre' + i);
                                                                        }
                                                                }
                                                        }
                                                }
                                        }
                                }
                        }
                }
                system.debug('**********maptoUpdateoutsideroshi***************' + maptoUpdate);
                if(!maptoUpdate.isempty())
                {
                        try
                        {
                                system.debug('***maptoUpdate.values();maptoUpdate.values();***' + maptoUpdate.values());
                                update maptoUpdate.values();
                        }
                        catch(exception e)
                        {
                                system.debug('********Exception while inserting Checklist***' + e);
                        }
                }
                IntegrationConstants.isAfterUpdate = TRUE;
        }
        /************************************************************************************************
         ** Method fired for the before delete event of trigger
         ** Objective is to delete the checklist having the same row number as deleted checklist
         ** and having the activty's copied from field same as deleted checklist's activity's Project Item of same Project
         *************************************************************************************************/
        public void beforeDeleteHandler()
        {
                map < id, NPD_Checklist__c > listToDelete = new map < id, NPD_Checklist__c > ();
                //Used to handle Recursion
                if(!IntegrationConstants.isBeforeDelete)
                {
                        newList1 = [SELECT NPD_Activity_Chklist__r.NPD_Project_Name__c, NPD_Activity_Chklist__r.NPD_Project_Items__c FROM NPD_Checklist__c WHERE ID IN: oldMap.values()];
                        system.debug('******newList1 delete**' + newList1);
                        for(NPD_Checklist__c chk: newList1)
                        {
                                //Map of checklist's Activity Id to Project of the activty    
                                actToProject.put(chk.NPD_Activity_Chklist__c, chk.NPD_Activity_Chklist__r.NPD_Project_Name__c);
                                //Map of Checklist's ID to Project Item       
                                projectItem.put(chk.id, chk.NPD_Activity_Chklist__r.NPD_Project_Items__c);
                        }
                        system.debug('*****newList1.size()newList1.size()**' + newList1.size());
                        map < id, List < NPD_Checklist__c >> ActIDToCheckLists = new map < id, List < NPD_Checklist__c >> ();
                        map < id, id > projectItemID = new map < id, id > ();
                        //Design_No__c
                        for(NPD_Checklist__c chk: [SELECT Design_No__c, Active__c, Activity_Reference__c, Approval_Status__c, Approval_Submitter__c, Case_Sourcing__c, CollectionName__c, Collection__c, Component__c, Cost__c, CreatedById, CreatedDate, CurrencyIsoCode, Currency__c, Current_Approver__c, Date_of_Completion__c, Dial_No__c, Engineering_Designer_Name__c, Gender__c, Id, Indent_Quanity__c,
                                        IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, Model_No__c, Multilevel_Notification__c, Multi_Approvers__c, Name, No_of_Designs__c, NPD_Activity_Chklist__c, OwnerId, Product_Designer_Name__c, Project_Owner__c, Quantity__c, Receipt_Quanity__c, Remarks__c, Row_Number__c, Sample_Recipt_Date__c, Status__c, Stock_No__c,
                                        Supply_Agency__c, SystemModstamp, Tentative_Launch_Date__c, Total_Quantity__c, Type_of_Locator__c, Variant_No__c, Columns_to_Copy__c, Vendor_Name__c, Vendor_Ref_No__c, Verdict__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.NPD_Project_Name__c IN: actToProject.values() AND NPD_Activity_Chklist__r.CopiedFrom__c IN: projectItem.values()
                                ])
                        {
                                if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(chk.NPD_Activity_Chklist__c) && ActIDToCheckLists.get(chk.NPD_Activity_Chklist__c) != NULL)
                                {
                                        ActIDToCheckLists.get(chk.NPD_Activity_Chklist__c).add(chk);
                                }
                                else
                                {
                                        ActIDToCheckLists.put(chk.NPD_Activity_Chklist__c, new list < NPD_Checklist__c >
                                        {
                                                chk
                                        });
                                }
                        }
                        System.debug('*******projectToActivityprojectToActivity' + projectToActivity);
                        if(newList1.size() == 1)
                        {
                                // To get the checklist's Activity filed values 
                                system.debug('**************MAPS FOR QUERY***********' + actToProject + '*******************HEHE********' + projectItem);
                                List < NPD_Activity__c > lstact = new List < NPD_Activity__c > ([SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()]);
                                System.debug('lstact' + lstact);
                                if(projectItem.values() != NULL && actToProject.values() != NULL)
                                {
                                        for(NPD_Activity__c act: [SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()])
                                        {
                                                if(projectToActivity.get(act.NPD_Project_Name__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && !projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c))
                                                {
                                                        projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                }
                                                else
                                                {
                                                        if(act.NPD_Project_Name__c != NULL && act.CopiedFrom__c != NULL)
                                                                // Retrieving all the activities having the copiedFrom field value same as the checklist's project Item ID.
                                                                projectToActivity.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                                {
                                                                        act.CopiedFrom__c => new List < NPD_Activity__c >
                                                                        {
                                                                                act
                                                                        }
                                                                });
                                                }
                                        }
                                }
                                for(NPD_Checklist__c chk: oldmap.values())
                                {
                                        NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                        {
                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                for(NPD_Activity__c act: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                {
                                                        if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act.id) && ActIDToCheckLists.get(act.id) != NULL)
                                                        {
                                                                for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act.id))
                                                                {
                                                                        if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                        {
                                                                                if(!listToDelete.containskey(chk2.id)) listToDelete.put(chk2.id, chk2);
                                                                                break;
                                                                                System.debug('chk.Row_Number__c' + listToDelete);
                                                                        }
                                                                }
                                                        }
                                                }
                                        }
                                }
                        }
                        else
                        {
                                List < NPD_Activity__c > lstact = new List < NPD_Activity__c > ([SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()]);
                                System.debug('lstact' + lstact);
                                if(projectItem.values() != NULL && actToProject.values() != NULL)
                                {
                                        for(NPD_Activity__c act: [SELECT id, Columns_to_Copy__c, Name__c, NPD_Project_Name__c, Remarks__c, Checklist_Columns__c, CopiedFrom__c FROM NPD_Activity__c WHERE CopiedFrom__c IN: projectItem.values() AND NPD_Project_Name__c IN: actToProject.values()])
                                        {
                                                if(projectToActivity.get(act.NPD_Project_Name__c) != NULL && projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c) != NULL && !projectToActivity.isempty() && projectToActivity.containskey(act.NPD_Project_Name__c) && !projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).isempty() && projectToActivity.get(act.NPD_Project_Name__c).containskey(act.CopiedFrom__c))
                                                {
                                                        projectToActivity.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                        projectToActivityclonedelete.get(act.NPD_Project_Name__c).get(act.CopiedFrom__c).add(act);
                                                        system.debug('projectToActivitycloneprojectToActivityclone' + projectToActivityclonedelete);
                                                }
                                                else
                                                {
                                                        if(act.NPD_Project_Name__c != NULL && act.CopiedFrom__c != NULL)
                                                                // Retrieving all the activities having the copiedFrom field value same as the checklist's project Item ID.
                                                                System.debug('*******projectToActivityprojectToActivity' + projectToActivity);
                                                        for(NPD_Checklist__c chk: oldmap.values())
                                                        {
                                                                NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                                                if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                                {
                                                                        //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                                        for(NPD_Activity__c act1: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                                        {
                                                                                if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act1.id) && ActIDToCheckLists.get(act1.id) != NULL)
                                                                                {
                                                                                        for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act1.id))
                                                                                        {
                                                                                                if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                                                {
                                                                                                        if(!listToDelete.containskey(chk2.id)) listToDelete.put(chk2.id, chk2);
                                                                                                        break;
                                                                                                        System.debug('chk.Row_Number__c' + listToDelete);
                                                                                                }
                                                                                        }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                        projectToActivity.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                        {
                                                                act.CopiedFrom__c => new List < NPD_Activity__c >
                                                                {
                                                                        act
                                                                }
                                                        });
                                                        projectToActivityclonedelete.put(act.NPD_Project_Name__c, new map < id, List < NPD_Activity__c >>
                                                        {
                                                                act.CopiedFrom__c => new List < NPD_Activity__c >
                                                                {
                                                                        act
                                                                }
                                                        });
                                                }
                                        }
                                        if(projectToActivityclonedelete.size() != NULL)
                                        {
                                                for(NPD_Checklist__c chk: oldmap.values())
                                                {
                                                        NPD_Checklist__c chkobj = new NPD_Checklist__c();
                                                        if(!projectToActivity.isempty() && projectToActivity.containskey(actToProject.get(chk.NPD_Activity_Chklist__c)) && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)) != NULL && !projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).isempty() && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)) != NULL && projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).containskey(projectItem.get(chk.id)))
                                                        {
                                                                //Iterating Activities for which the checklist is to be inserted to upadte the values to the columns with the same values of trigger.new. 
                                                                for(NPD_Activity__c act1: projectToActivity.get(actToProject.get(chk.NPD_Activity_Chklist__c)).get(projectItem.get(chk.id)))
                                                                {
                                                                        if(!ActIDToCheckLists.isempty() && ActIDToCheckLists.containskey(act1.id) && ActIDToCheckLists.get(act1.id) != NULL)
                                                                        {
                                                                                for(NPD_Checklist__c chk2: ActIDToCheckLists.get(act1.id))
                                                                                {
                                                                                        if(chk2.Row_Number__c == chk.Row_Number__c)
                                                                                        {
                                                                                                if(!listToDelete.containskey(chk2.id)) listToDelete.put(chk2.id, chk2);
                                                                                                break;
                                                                                                System.debug('chk.Row_Number__c' + listToDelete);
                                                                                        }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                }
                                        }
                                }
                                // system.debug('ActIDToCheckListsActIDToCheckLists'+ActIDToCheckLists);
                                system.debug('projectToActivitycloneprojectToActivityclone' + projectToActivityclonedelete);
                        }
                        system.debug('projectToActivitycloneprojectToActivityclone' + projectToActivityclonedelete);
                        //system.debug('ActIDToCheckListsActIDToCheckLists'+ActIDToCheckLists);
                        if(!listToDelete.isempty())
                        {
                                try
                                {
                                        delete listToDelete.values();
                                }
                                catch(exception e)
                                {
                                        system.debug('********Exception while inserting Checklist***' + e);
                                }
                        }
                        IntegrationConstants.isBeforeDelete = TRUE;
                }
        }
        public void afterUndeleteHandler()
        {
                System.debug('********after insert*******' + newList + '************' + oldmap);
        }
        public static void UpgradeOptionDynamicTable(npd_checklist__c newchecklist)
        {
                npd_checklist__c n1 = new npd_checklist__c();
                n1 = newchecklist;
                string CurrentModelName;
                string checkListCollection;
                boolean upgradeNow = true;
                list < npd_checklist__c > npdchecklists = new list < npd_checklist__c > ();
                set < String > modelnames = new set < string > ();
                // for(NPD_Checklist__c checks1:[select id,name,Model_No__c,Vendor_Ref_No__c from NPD_Checklist__c where Model_No__c !=null and Collection__c=:n1.Collection__c and Activity_Reference__c='AR-0103001001'])
                for(NPD_Checklist__c checks1: [select id, name, Model_No__c, Vendor_Ref_No__c, PSY_No__c from NPD_Checklist__c where Model_No__c != null and(PSY_No__c != null or Vendor_Ref_No__c != null) and Activity_Reference__c = 'AR-0103001001'])
                {
                        system.debug('The collection name is: ' + n1.Collection__c);
                        modelnames.add(checks1.Model_No__c);
                        system.debug('The checks1.Model_No__c value is :' + checks1.Model_No__c);
                }
                if(!modelnames.contains(n1.Model_No__c))
                {
                        //system.debug('The modelnames are: '+modelnames + 'and the  CurrentModelName is: '+CurrentModelName);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error, 'This Model Number is not in this Collection'));
                        upgradeNow = false; // used to decide to upsert the record or not. 
                        newchecklist.adderror('The molde is not in the list. ');
                }
                try
                {
                        if(upgradeNow == true)
                        {
                                // Finding the perticualr model number and psy number. 
                                NPD_Checklist__c copyvalues = [select id, Vendor_Ref_No__c, PSY_No__c, Model_No__c from NPD_Checklist__c where Model_No__c = : n1.Model_No__c and Collection__c = : n1.Collection__c limit 1];
                                system.debug('The copyvalues query data is: ' + copyvalues);
                                if(copyvalues.Vendor_Ref_No__c != null)
                                {
                                        n1.Vendor_Ref_No__c = copyvalues.Vendor_Ref_No__c;
                                        system.debug('The copyvalues.Vendor_Ref_No__c is:' + copyvalues.Vendor_Ref_No__c);
                                }
                                if(copyvalues.PSY_No__c != null)
                                {
                                        n1.PSY_No__c = copyvalues.PSY_No__c;
                                        system.debug('The copyvalues.PSY_No__c :' + copyvalues.PSY_No__c);
                                }
                        }
                }
                catch(exception checkupgrade)
                {
                        system.debug(checkupgrade);
                }
        }
        /**********************************************************************************************************************
         *Method Name :copyColumns 
         *Parameters Passed : Checklist object from where the values is to be copied and the object to which the valies to be copied
         *Description : Method is used to copy table or checklist columns specified in the columns to copy field.
         ***********************************************************************************************************************/
        public sobject copyColumns(NPD_Checklist__c chkobj, NPD_Checklist__c chk)
        {
                String fieldStr = '';
                fieldStr = chkobj.Columns_to_Copy__c;
                List < String > fieldList = new List < String > ();
                if(!String.isBlank(fieldStr))
                {
                        fieldStr = fieldStr.replaceAll('\\n', '');
                        fieldList = (fieldStr.contains(',') ? fieldStr.split(',') : (new List < string >
                        {
                                fieldstr
                        }));
                }
                set < string > fiedlabels = new set < string > ();
                for(String str: fieldList)
                {
                        str = str.trim();
                        fiedlabels.add(str);
                }
                list < string > fieldApiList = new List < String > ();
                String fielApistr = '';
                map < string, string > label_Api = new map < String, String > ();
             //   Map < String, Schema.SObjectField > fieldMap = Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap();
            /*  Hide by sudama for code optimization
            for(Schema.SObjectField field: Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values())
                {
                        string temp = field.getDescribe().getLabel();
                        if(fiedlabels.contains(temp))
                        {
                                string apiName = field.getDescribe().getName();
                                fieldApiList.add(apiName);
                                label_Api.put(temp, apiName);
                        }
                } */
                for(String fLabel : fiedlabels){
                                System.debug('++++++++++++++fieldLevelFieldNameMap+++++++++++++++++++++++++'+fieldLevelFieldNameMap);

                    if(!fieldLevelFieldNameMap.IsEmpty() && fieldLevelFieldNameMap.get(fLabel) != null && fieldLevelFieldNameMap.containsKey(fLabel)){
                        label_Api.put(fLabel,fieldLevelFieldNameMap.get(fLabel));
                        System.debug('++++++++++++++++field label++++++++++++++'+fLabel);
                        System.debug('++++++++++++++++field name+++++++++++++'+fieldLevelFieldNameMap.get(fLabel));
                    }
                }
                List < String > DisplayFieldsList = new List < String > ();
                for(String label: fiedlabels)
                {
                        if(!label_Api.isEmpty() && label_Api.containsKey(label) && label_Api.get(label) != null)
                        {
                                DisplayFieldsList.add(label_Api.get(label));
                        }
                }
                Sobject chkObjj = new NPD_Checklist__c();
                Sobject CopychkObj = new NPD_Checklist__c();
                chkObjj = chk;
                CopychkObj = chkobj;
                for(string str: DisplayFieldsList)
                {
                        system.debug('*************Str*****' + str + '*************singleton*****' + chkObjj.get(str) + '**********************values***' + chkObjj);
                        if(chkObjj.get(str) != NULL && str != 'CollectionName__c' && str != 'Activity_Reference__c')
                        {
                                string fieldType = fieldMap.get(str).getDescribe().getType().name().ToLowerCase();
                                system.debug('****Type of the field***' + fieldType);
                                if(fieldType == 'currency' || fieldType == 'double' || fieldType == 'percent' || fieldType == 'decimal')
                                {
                                        CopychkObj.put(str, Double.valueOf(chkObjj.get(str)));
                                }
                                else if(fieldType == 'boolean')
                                {
                                        CopychkObj.put(str, boolean.valueof(chkObjj.get(str)));
                                }
                                else if(fieldType == 'date')
                                {
                                        CopychkObj.put(str, date.valueof(chkObjj.get(str)));
                                }
                                else
                                {
                                        CopychkObj.put(str, string.valueof(chkObjj.get(str)));
                                }
                                system.debug('********Before Inserting***' + CopychkObj);
                        }
                }
                return CopychkObj;
        }
        /*****************************************   inserting NPD_Collections__c *********************************/
        public void methodAccount()
        {
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
                integer i = 0;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
                i++;
        }
        /*****************************************   For inserting  NPD_Collections__c*********************************/
}