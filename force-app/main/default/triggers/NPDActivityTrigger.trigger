/* modified date : 03/09/2017
modified By : Sudama 
Note : modifyed code used to automate revision R1 R2 ASD AND AED. 
It is use to assign value as in progress when activity is ActualStartDate is not NULL 
and if the Status of the activity is Complate then Actual End date is assinged    */

/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/15/2019   T01	SOQL Inside for loop removal

*/

trigger NPDActivityTrigger on NPD_Activity__c(before update, after Update, before Insert, After Insert) {
    system.debug('activity trigger firing');
    public boolean check = false;

    try {
        // fetching Custom setting val.
        Npd_activity_trigger_controller__c cus1 = Npd_activity_trigger_controller__c.getInstance('stagetrigger');
        check = cus1.continueExecution__c;
    } catch (exception er1) {
        system.debug(er1);
    }
    if (check == false) {
        // trigger for after insert     
        if (Trigger.isAfter && Trigger.isInsert) {
            system.debug('before isnert activity');
            NPD_UtilityController.ProtoDesignInputActivityCreation(trigger.new, trigger.oldMap);
            
            
            set < id > activityidforOwner1 = new set < id > ();
            set < id > projectidowner1 = new set < id > ();
            set < id > setprojectitemsowner1 = new set < id > ();
            for (npd_activity__c n: trigger.new) {
                
                if ((n.brand1__c != NULL)) {
                    //if(n.brand1__c !=NULL || n.brand1__c !=  trigger.oldMap.get(n.id).brand1__c ){
                    system.debug('inside actvitiy trigger if stagement');
                    activityidforOwner1.add(n.id);
                    setprojectitemsowner1.add(n.NPD_Project_Items__c);
                    projectidowner1.add(n.NPD_Project_Name__c);
                }
            }
            System.debug('setprojectitemsowner outside if: ' + setprojectitemsowner1);
            System.debug('projectidowner outside if:' + projectidowner1);
            System.debug('activityidforOwner outside if:' + activityidforOwner1);
            if (activityidforOwner1.size() > 0 || projectidowner1.size() > 0 || setprojectitemsowner1.size() > 0) {
                System.debug('setprojectitemsowner1' + setprojectitemsowner1);
                System.debug('projectidowner1' + projectidowner1);
                NPD_UtilityController.ownerAssingmentforActivity(activityidforOwner1, projectidowner1, setprojectitemsowner1);
            }
        }
        
        
        
    }
    // trigger for before update        
    if (Trigger.isbefore && Trigger.isupdate) {
        list < NPD_Activity__c > completeActivities = new list < NPD_Activity__c > ();
        set < id > setActivityCompleteId = new set < Id > ();
        set < id > setActivityCompleteId1 = new set < Id > ();
        set < id > setprojectitems = new set < Id > ();
        set < id > projectid = new set < Id > ();
        set < id > attachmentid = new set < id > ();
        List < Attachment > lstattach = new List < Attachment > ();
        //assign approver according to the activity
        
        NPDApprovalHandler.getApproverOnBeforeUpdate(trigger.new, trigger.oldMap);
        set < id > setSubActivityCompleteId = new set < Id > ();
        set < id > setSubActivityR1CompleteId = new set < Id > ();
        set < id > setSubActivityR2CompleteId = new set < Id > ();
        
        List < NPD_Activity__c > userlist = new List < NPD_Activity__c > ();
        set<String> setActivitiesAndSubActivitiesNotToSendMail = new set<String>();
        setActivitiesAndSubActivitiesNotToSendMail.Add('Leather Strap - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Metal Bracelet - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Hands - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Crown - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('New Movement - Bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Special Component- bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('WH/FW/WH+Strap-Bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Pricing Proto to PMG/Pricing release');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Production Clearance');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Pilot Work Order request/ Pilot Work Order Creation/Pilot assembly Completion & Feedback/Feedback closure(CAPA)/Bulk assembly clearance/Bulk Work order release');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Watch Deposition');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Product Certification and Handing Over Note');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Planned Order Loading');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Case BO Components - Bulk Delivery');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Case Add on Components - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Bulk Delivery D&D - Requirement');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Press');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Machine Shop');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Polishing Shop');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Polishing Special Process');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Plating Shop');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Case Assembly Special Process');
        setActivitiesAndSubActivitiesNotToSendMail.Add('First Month Requirement - Case Assembly');
        setActivitiesAndSubActivitiesNotToSendMail.Add('BO Case - bulk');
        setActivitiesAndSubActivitiesNotToSendMail.Add('Dial - bulk');
        //<T01>
        // retrieving NPD_Stage__c records for the NPDActivity__c
        Set<id> setOfNPDStageNewIds = new Set<id>();
        for(NPD_Activity__c npdA: trigger.new){
            setOfNPDStageNewIds.add(npdA.npd_stage__c);
        }
        Map<id,NPD_Stage__c> mapOfNPD_Stage= new Map<id,NPD_Stage__c>([Select id, updatechkbox__c from NPD_stage__c where id in :setOfNPDStageNewIds]);
        //</T01>
        for (NPD_Activity__c n: trigger.new) {
            
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c) && (n.Actual_end_Date__c != trigger.oldMap.get(n.id).Actual_end_Date__c )){
                n.addError('Sorry! you dont have permission to update both dates at a time.');
            }
            if ((n.R1_ASD__c  != trigger.oldMap.get(n.id).R1_ASD__c ) && (n.R1_AED__c != trigger.oldMap.get(n.id).R1_AED__c )){
                n.addError('Sorry! you dont have permission to update both dates at a time.');
            }
            if ((n.R2_ASD__c  != trigger.oldMap.get(n.id).R2_ASD__c ) && (n.R2_AED__c != trigger.oldMap.get(n.id).R2_AED__c )){
                n.addError('Sorry! you dont have permission to update both dates at a time.');
            }
            if ((n.Active__c  != trigger.oldMap.get(n.id).Active__c ) && (n.Status__c == 'Completed'  || n.Status__c == 'Completed R1' || n.Status__c == 'Completed R2' || n.Status__c == 'In Progress' || n.Status__c == 'In Progress R1' || n.Status__c == 'In Progress R2')){
                n.addError('Sorry! you cant de-Active this record as status is changed');
            }
            if ((n.Revision_Status__c != trigger.oldMap.get(n.id).Revision_Status__c)) {
                if (n.Revision_Status__c == 'Activate R1' && n.Status_R0__c != 'Completed') {
                    n.addError('Please Complete R0 Activity before starting R1');
                }
                if (n.Revision_Status__c == 'Activate R2' && n.Status_R1__c != 'Completed R1') {
                    n.addError('Please Complete R1 Activity before starting R2');
                }
            }
            if ((n.Actual_end_Date__c != trigger.oldMap.get(n.id).Actual_end_Date__c)) {
                if (n.Actual_Start_Date__c != null && n.Actual_end_Date__c == null) {
                    n.Status__c = 'In Progress';
                    n.Status_R0__c = 'In Progress';
                }
                system.debug('######*******trigger.oldMap.get(n.id).Actual_end_Date__c-----------------'+trigger.oldMap.get(n.id).Actual_end_Date__c);
                system.debug('######*******(n.Actual_end_Date__c -----------------'+ n.Actual_end_Date__c );
            }
            if ((n.Approval_Status__c != trigger.oldMap.get(n.id).Approval_Status__c)) {
                if (n.Actual_Start_Date__c != null && n.Approval_Status__c == 'Approved' && n.Status__c == 'In Progress') {
                    n.Actual_end_Date__c = System.today();
                }
            }
            if ((n.R1_AED__c != trigger.oldMap.get(n.id).R1_AED__c)) {
                if (n.R1_ASD__c != null && n.R1_AED__c == null) {
                    n.Status__c = 'In Progress R1';
                    n.Status_R1__c = 'In Progress R1';
                }
            }
            if ((n.Approval_Status__c != trigger.oldMap.get(n.id).Approval_Status__c)) {
                if (n.R1_ASD__c != null && n.Approval_Status__c == 'Approved' && n.Status__c == 'In Progress R1') {
                    n.R1_AED__c = System.today();
                }
            }
            if ((n.R2_AED__c != trigger.oldMap.get(n.id).R2_AED__c)) {
                if (n.R2_ASD__c != null && n.R2_AED__c == null) {
                    n.Status__c = 'In Progress R2';
                    n.Status_R2__c = 'In Progress R2';
                }
            }
            if ((n.Approval_Status__c != trigger.oldMap.get(n.id).Approval_Status__c)) {
                if (n.R2_ASD__c != null && n.Approval_Status__c == 'Approved' && n.Status__c == 'In Progress R2') {
                    n.R2_AED__c = System.today();
                }                              
            }
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c )|| (n.Actual_Start_Date__c == trigger.oldMap.get(n.id).Actual_Start_Date__c)) {
                system.debug('The beffore action value is :' + n.status__c);
                if (n.Actual_Start_Date__c != null) {
                    n.Status__c = 'In Progress';
                    n.Status_R0__c = 'In Progress';
                }
                if (n.Actual_Start_Date__c != null && n.Actual_end_Date__c != null) {
                    n.Status__c = 'Completed';
                    n.Status_R0__c = 'Completed';
                }
                system.debug('######@@@@Actual_Start_Date__c-----------------'+trigger.oldMap.get(n.id).Actual_Start_Date__c); 
                system.debug('The After action value is :' + n.status__c);
            }
            // code added by sudama for auto R1, r2 inprogress if R1 start date is not null.
            if ((n.R1_ASD__c != trigger.oldMap.get(n.id).R1_ASD__c)) {
                system.debug('The beffore action value is :' + n.status__c);
                if (n.R1_ASD__c != null) {
                    n.Status__c = 'In Progress R1';
                    n.Status_R1__c = 'In Progress R1';
                    if(n.Approval_Required__c == true)
                        n.Approval_Status__c = 'None';
                }
                if (n.R1_ASD__c != null && n.R1_AED__c != null) {
                    n.Status__c = 'Completed R1';
                    n.Status_R1__c = 'Completed R1';
                }
                system.debug('The After action value is :' + n.status__c);
            }
            if ((n.R2_ASD__c != trigger.oldMap.get(n.id).R2_ASD__c)) {
                system.debug('The beffore action value is :' + n.status__c);
                if (n.R2_ASD__c != null) {
                    n.Status__c = 'In Progress R2';
                    n.Status_R2__c = 'In Progress R2';
                    if(n.Approval_Required__c == true)
                        n.Approval_Status__c = 'None';
                }
                if (n.R2_ASD__c != null && n.R2_AED__c != null) {
                    n.Status__c = 'Completed R2';
                    n.Status_R2__c = 'Completed R2';
                }
                system.debug('The After action value is :' + n.status__c);
            }
            
            // assinging value to status if actualstartdate is not null
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c) && n.Actual_Start_Date__c != NULL) {
                // n.Status__c ='In Progress';
                // <T01>
                // commented the inner for loop query and taking data from map created above the for loop.
                // List < NPD_Stage__c > lst = new List < NPD_Stage__c > ([Select id, updatechkbox__c from NPD_stage__c where id =: n.npd_stage__c]);

                if(mapOfNPD_Stage != null && mapOfNPD_Stage.containsKey(n.npd_stage__c)){
                    if(mapOfNPD_Stage.get(n.npd_stage__c) != null) {
                        if (mapOfNPD_Stage.get(n.npd_stage__c).updatechkbox__c == false && n.Type__c == 'Activity') {
                            n.updatechkbox__c = true;
                        }
                    }
                    /*   
                     * commented this loop and replaced with above logic
                     * for (NPD_Stage__c stage: lst) {
							if (stage.updatechkbox__c == false && n.Type__c == 'Activity') {
                            	n.updatechkbox__c = true;
                            }
                         }
					*/
                    //</T01>
                }
                
                System.debug('+++InProgress');
                system.debug('-----------**************-----------Actual_Start_Date__c-----------------'+trigger.oldMap.get(n.id).Actual_Start_Date__c);
                system.debug('-----------++++++++++++++-----------Actual_Start_Date__c-----------------'+n.Actual_Start_Date__c );                              
            }
            //assinging value to actualstartdate if status is 'Not Stated'
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c) && n.Actual_Start_Date__c == NULL) {
                n.Status__c = 'Not Started';
                n.Status_R0__c = 'Not Started';
            }
            // added by sudama is status is not Started then R1 ASD will be null.
            if ((n.R1_ASD__c != trigger.oldMap.get(n.id).R1_ASD__c) && n.R1_ASD__c == NULL) {
                n.Status__c = 'Not Started R1';
                n.Status_R1__c = 'Not Started R1';
            }
            // added by sudama is status is not Started then R2 ASD will be null.
            if ((n.R2_ASD__c != trigger.oldMap.get(n.id).R2_ASD__c) && n.R2_ASD__c == NULL) {
                n.Status__c = 'Not Started R2';
                n.Status_R2__c = 'Not Started R2';
            }
            if ((n.Status__c != trigger.oldMap.get(n.id).Status__c) && n.Status__c == 'In Progress') {
                // n.Actual_End_Date__c=NULL;    
            }
            // added by sudama assinging value to R1 status is 'Complete' is R1 AED is not null
            if ((n.R1_AED__c != trigger.oldMap.get(n.id).R1_AED__c) && n.Status__c != 'Completed R1' && n.R1_ASD__c != null && n.R1_AED__c != null) {
                if (n.name != null) {
                    setSubActivityR1CompleteId.add(n.id);
                }
                if (setSubActivityR1CompleteId.size() > 0) {
                    if (n.Approval_Required__c == TRUE && n.Approval_Status__c != 'Approved') {
                        n.addError('R1 Activity Cannot be completed as it is not been Approved Yet');
                    }else{
                        n.Status__c = 'Completed R1';
                        n.Status_R1__c = 'Completed R1';
                    }
                    
                }
            }
            // added by sudama assinging value to R2 status is 'Complete' if R2 AED is not null
            if ((n.R2_AED__c != trigger.oldMap.get(n.id).R2_AED__c) && n.Status__c != 'Completed R2' && n.R2_ASD__c != null && n.R2_AED__c != null) {
                if (n.name != null) {
                    setSubActivityR2CompleteId.add(n.id);
                }
                if (setSubActivityR2CompleteId.size() > 0) {
                    if (n.Approval_Required__c == TRUE && n.Approval_Status__c != 'Approved') {
                        n.addError('R2 Activity Cannot be completed as it is not been Approved Yet');
                    }else{
                        n.Status__c = 'Completed R2';
                        n.Status_R2__c = 'Completed R2';    
                    }
                    
                }
            }
            if ((n.Actual_End_Date__c != trigger.oldMap.get(n.id).Actual_End_Date__c) && n.Status__c != 'Completed' && n.Actual_Start_Date__c != null && n.Actual_End_Date__c != null) {
                System.debug('+++COMPLETE');
                if (n.name != null) {
                    setActivityCompleteId.add(n.id);
                    if(!setActivitiesAndSubActivitiesNotToSendMail.contains(n.Name__c)){
                        setActivityCompleteId1.add(n.id);
                        setprojectitems.add(n.NPD_Project_Items__c);
                        projectid.add(n.NPD_Project_Name__c);
                    }
                }
                if (n.name != null) {
                    setSubActivityCompleteId.add(n.id);
                }
                if (setActivityCompleteId.size() > 0) {
                    if (n.Approval_Required__c == TRUE && n.Approval_Status__c != 'Approved') {
                        system.debug('+++chkIFFFF++');
                        n.addError('Activity Cannot be completed as it is not been Approved Yet');
                    } else {
                        system.debug('+++chkIFFFFelse++');
                        // n.Actual_End_Date__c=date.today();
                        n.Case_Model_No_Allocation_date__c = date.today();
                    }
                }
                if (setSubActivityCompleteId.size() > 0) {
                    if (n.Approval_Required__c == TRUE && n.Approval_Status__c != 'Approved') {
                        system.debug('+++chkIFFFF++');
                        //    n.addError('SubActivity Cannot be completed as it is not been Approved Yet');
                        break;
                    } else {
                        system.debug('+++chkIFFFFelse++');
                        n.Status__c = 'Completed';
                        n.Status_R0__c = 'Completed';
                    }
                }
            }
        }
        
        if (setActivityCompleteId1.size() > 0 || projectid.size() > 0 || setprojectitems.size() > 0) {
            System.debug('setActivityCompleteId1LIST' + setActivityCompleteId1);
            System.debug('projectidprojectid' + projectid);
            
            
            
            NPD_UtilityController.EmailOnActivityCompletion(setActivityCompleteId1, projectid, setprojectitems);
        }
        for (NPD_Activity__c n: trigger.new) {
            if ((n.Status__c != trigger.oldMap.get(n.id).Status__c) && n.Status__c == 'Completed' && n.Type__c == 'Activity') {
                completeActivities.add(n);
                System.debug('++++++++++++++Sudama++++++++++++++++'+n.Status__c);
            }
        }
        if(completeActivities.size()>0){
            //   NPDSubactivity.NPDSubactivity(completeActivities);
        }
    }
    
    // trigger for after update
    if (Trigger.isafter && Trigger.isupdate) {
        /*this is use to capture the  related Substage id of Activity and and call method to calculate ActualEnd date,StartDate and Staus updates*/
        list < NPD_Activity__c > lstActiveActivity = new list < NPD_Activity__c > ();
        set < NPD_Activity__c > listActivityToNotify = new set < NPD_Activity__c > ();
        set < id > listActivityAutoPop = new set < id > ();
        set < id > listActivityAutoPop1 = new set < id > ();
        set < id > listActivityAutoPop2 = new set < id > ();
        set < id > listActivityAutoPop3 = new set < id > ();
        set < id > listsubstageAct = new set < id > ();
        set < id > activityidforOwner = new set < Id > ();
        set < id > setprojectitemsowner = new set < Id > ();
        set < id > projectidowner = new set < Id > ();
        List < Attachment > lstattach = new List < Attachment > ();
        set < id > substageidactdec = new set < id > ();
        set < id > substageidactdecR1 = new set < id > ();
        set < id > substageidactdecR2 = new set < id > ();
        set < id > setId = new set < id > ();
        //List<String> PredecessorSerialNo = new List<String>();   list to add predessessor serial number
        set < id > setIdR1 = new set < id > ();
        set < id > setIdR2 = new set < id > ();
        set < id > setIdcheck = new set < id > ();
        set < id > setIdcheckudate = new set < id > (); //update of actual start date
        set < id > setIdcheck1 = new set < id > ();
        set < id > attachmentid = new set < id > ();
        set <ID> collectionId   = new set<ID>();
        list < NPD_Activity__c > completeActivities = new list < NPD_Activity__c > ();
        set < id > setAct = new set < id > ();
        map < id, NPD_Activity__c > mapSubstageId_Activity = new map < id, NPD_Activity__c > ();
        system.debug('outside actvitiy trigger if stagement');
        for (NPD_Activity__c n: trigger.new) {
            if ((n.R1_ASD__c != trigger.oldMap.get(n.id).R1_ASD__c) && n.R1_ASD__c != null && (n.Type__c == 'Activity')) {
                setIdR1.add(n.npd_stage__c);
            }
            if ((n.R2_ASD__c != trigger.oldMap.get(n.id).R2_ASD__c) && n.R2_ASD__c != null && (n.Type__c == 'Activity')) {
                setIdR2.add(n.npd_stage__c);
            }
            //capturing related substage id
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c) && n.Actual_Start_Date__c != null && (n.Type__c == 'Activity')) {
                setId.add(n.npd_stage__c);
                setIdcheckudate.add(n.npd_stage__c);
                activityidforOwner.add(n.id);
                setprojectitemsowner.add(n.NPD_Project_Items__c);
                projectidowner.add(n.NPD_Project_Name__c);
                System.debug('activityidforOwner' + activityidforOwner);
                System.debug('setprojectitemsowner' + setprojectitemsowner);
                System.debug('projectidowner' + projectidowner);
            } //End of 
            if ((n.Actual_Start_Date__c != trigger.oldMap.get(n.id).Actual_Start_Date__c) && n.Actual_Start_Date__c != null && n.Type__c == 'Sub-Activity') {
                activityidforOwner.add(n.id);
                setprojectitemsowner.add(n.NPD_Project_Items__c);
                projectidowner.add(n.NPD_Project_Name__c);
                System.debug('activityidforOwner' + activityidforOwner);
                System.debug('setprojectitemsowner' + setprojectitemsowner);
                System.debug('projectidowner' + projectidowner);
            }
            if (n.Status__c != trigger.oldMap.get(n.id).Status__c && n.Status__c == 'Completed' && n.Type__c == 'Activity' && n.Name__c == 'Watch Deposition') {
                collectionId.add(n.NPD_Collections__c);
            }
            if ( n.Type__c == 'Activity' && (n.Status__c == 'Completed' || n.Status__c == 'In Progress') && (n.Status__c != trigger.oldMap.get(n.id).Status__c || n.Actual_End_Date__c != trigger.oldMap.get(n.id).Actual_End_Date__c)) {
                setId.add(n.npd_stage__c);
                //if(n.SerialNo__c != null){
                //  PredecessorSerialNo.add(n.SerialNo__c)
                //}
            }
            if ((n.Status__c == 'Completed R1' || n.Status__c == 'In Progress R1') && n.Type__c == 'Activity' && n.Status__c != trigger.oldMap.get(n.id).Status__c) {
                setIdR1.add(n.npd_stage__c);
            }
            if ( (n.Status__c == 'Completed R2' ||  n.Status__c == 'In Progress R2') && n.Type__c == 'Activity' && n.Status__c != trigger.oldMap.get(n.id).Status__c) {
                setIdR2.add(n.npd_stage__c);
            }
            //(ON Click OF Active/Deactive)To autoPopulate the status and the Actual End date if all activities are completed and any of the active activity is deactivated. 
            if (n.Active__c != trigger.oldMap.get(n.id).Active__c && n.Type__c == 'Activity') {
                substageidactdec.add(n.npd_stage__c);
            }
            if (n.Active__c != trigger.oldMap.get(n.id).Active__c && n.Type__c == 'Activity' && n.Revision_Active__c == True) {
                substageidactdecR1.add(n.npd_stage__c);
            }
            if (n.Active__c != trigger.oldMap.get(n.id).Active__c && n.Type__c == 'Activity' && n.Revision_Active__c == True) {
                substageidactdecR2.add(n.npd_stage__c);
            }
            if (trigger.newMap.get(n.id).Status__c != trigger.oldMap.get(n.id).Status__c && (trigger.newMap.get(n.id).Status__c == 'Not Started' && n.Type__c == 'Activity') || (trigger.oldMap.get(n.id).Status__c == 'In Progress' && n.Type__c == 'Activity')) {
                setIdcheck.add(n.npd_stage__c);
            }
            if ((trigger.newMap.get(n.id).Status__c != trigger.oldMap.get(n.id).Status__c) && trigger.newMap.get(n.id).Status__c == 'In Progress' && trigger.oldMap.get(n.id).Status__c == 'Completed' && n.Type__c == 'Activity') {
                setIdcheck1.add(n.npd_stage__c);
            }
            if ((n.Status__c != trigger.oldMap.get(n.id).Status__c) && n.Status__c == 'Completed') {
                listActivityToNotify.add(n);
            }
            ///AUTOUPDATEOF FIELDS
            if ((n.Actual_End_Date__c != trigger.oldMap.get(n.id).Actual_End_Date__c) && n.Type__c == 'Sub-Activity' && (n.Name__c == 'Proto Dial Drawing Release and Receipt' || n.Name__c == 'PB/PM Release , Approval  and Recipt')) {
                listActivityAutoPop.add(n.id);
                listsubstageAct.add(n.NPD_Activity__c);
            }
            if ((n.Actual_End_Date__c != trigger.oldMap.get(n.id).Actual_End_Date__c) && n.Type__c == 'Activity' && n.Name__c == 'Proto Design - Release') {
                listActivityAutoPop1.add(n.NPD_Stage__c);
            }
            //this for the Quantity required field at different activity need to be auto population
            if ((n.Quantity_Required_Standard_Option__c != NULL && n.Quantity_Required_Standard_Option__c != trigger.oldMap.get(n.id).Quantity_Required_Standard_Option__c) && n.Type__c == 'Activity' && n.Name__c == 'Pilot Lot Manufacturing - Press') {
                listActivityAutoPop2.add(n.NPD_Stage__c);
            }
            if ((n.Master_Type1__c != NULL && n.Master_Type1__c != trigger.oldMap.get(n.id).Master_Type1__c) && n.Type__c == 'Activity' && n.SerialNo__c == 'AR-0301004') {
                listActivityAutoPop3.add(n.id);
            }
        } //End of for(NPD_Activity__c n :trigger.new) 
        if(listActivityToNotify.size()>0){
            //   NPDSubactivity.sendNotificationMail(listActivityToNotify);
        }
        if (!setId.isEmpty()) {
            NPD_UtilityController.checkSubStageStatusActualDates(setId, trigger.new);
        }
        if (!setIdR1.isEmpty()) {
            NPD_UtilityController.checkSubStageStatusActualDatesR1(setIdR1, trigger.new);
        }
        if (!setIdR2.isEmpty()) {
            NPD_UtilityController.checkSubStageStatusActualDatesR2(setIdR2, trigger.new);
        }
        // collection Status
        if (!collectionId.isEmpty()) {
            NPD_UtilityController.collectionStatus(collectionId);
        }
        //Activate.....Deactivate
        if (!substageidactdec.isEmpty()) {
            NPD_UtilityController.ActivateDeactivateActivity(substageidactdec);
        }
        if (!substageidactdecR1.isEmpty()) {
            NPD_UtilityController.ActivateDeactivateActivityR1(substageidactdecR1);
        }
        if (!substageidactdecR2.isEmpty()) {
            NPD_UtilityController.ActivateDeactivateActivityR2(substageidactdecR2);
        }
        if (!setIdcheck.isEmpty()) {
            system.debug('**lstResult**');
            // NPD_UtilityController.checkSubStageStatusNotStarted(setIdcheck,trigger.new,Trigger.oldMap);   
        }
        //Storing the substage parent id if the activity status changes from completed to Inprogress
        if (!setIdcheck1.isEmpty()) {
            NPD_UtilityController.checkSubStageStatusInprogress(setIdcheck1, trigger.new, Trigger.oldMap);
        }
        //update of the ist updated activity
        if (!setIdcheckudate.isEmpty()) {
            NPD_UtilityController.checkSubStageStatusactualdateupdate(setIdcheckudate, trigger.new, Trigger.oldMap);
        }
        NPD_UtilityController handler = new NPD_UtilityController(trigger.new, trigger.oldmap);
        handler.afterUpdateHandlerAct();
        if (!listActivityAutoPop1.isEmpty()) {
            NPD_UtilityController.AutoupdateActivity(listActivityAutoPop1);
        }
        if (!listActivityAutoPop2.isEmpty()) {
            System.debug('listActivityAutoPop2' + listActivityAutoPop2);
            NPD_UtilityController.AutoupdateActivityPilotLotManufacturing(listActivityAutoPop2);
        }
        if (!listActivityAutoPop3.isEmpty()) {
            System.debug('listActivityAutoPop3' + listActivityAutoPop3);
            NPD_UtilityController.AutoupdateCaseMasterDevelopment(listActivityAutoPop3, trigger.new);
        }
        if (!trigger.newMap.isEmpty() && !trigger.oldMap.isEmpty()) {
            handler.updateSubActvtyCmplxtyLeadTime(trigger.newMap, trigger.oldMap);
        }
    }
    
    if (Trigger.isAfter && Trigger.isupdate) {
        
        
        set < id > activityidforOwner1 = new set < id > ();
        set < id > projectidowner1 = new set < id > ();
        set < id > setprojectitemsowner1 = new set < id > ();
        for (npd_activity__c n: trigger.new) {
            
            
            if(n.brand1__c !=  trigger.oldMap.get(n.id).brand1__c ){
                system.debug('inside actvitiy trigger if stagement');
                activityidforOwner1.add(n.id);
                setprojectitemsowner1.add(n.NPD_Project_Items__c);
                projectidowner1.add(n.NPD_Project_Name__c);
            }
        }
        System.debug('setprojectitemsowner outside if: ' + setprojectitemsowner1);
        System.debug('projectidowner outside if:' + projectidowner1);
        System.debug('activityidforOwner outside if:' + activityidforOwner1);
        if (activityidforOwner1.size() > 0 || projectidowner1.size() > 0 || setprojectitemsowner1.size() > 0) {
            System.debug('setprojectitemsowner1' + setprojectitemsowner1);
            System.debug('projectidowner1' + projectidowner1);
            NPD_UtilityController.ownerAssingmentforActivity(activityidforOwner1, projectidowner1, setprojectitemsowner1);
        }
    }
    
    
    
}