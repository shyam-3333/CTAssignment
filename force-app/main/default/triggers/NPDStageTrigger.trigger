/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha(Lister)  11/14/2019   T01	DML Inside for loop
Saradha(Lister)  11/14/2019   T02    SOQL Inside for loop 

*/
trigger NPDStageTrigger on NPD_Stage__c (before insert,before update,after update,After insert) {
    
    public  boolean check = false;
    public boolean updateCheck = false;
    try{
        // fetching Custom setting.
        Npd_activity_trigger_controller__c cus1=  Npd_activity_trigger_controller__c.getInstance('stagetrigger');
        check = cus1.continueExecution__c;
    } catch(exception er1)
    {
        system.debug(er1);
    }
    public set<id> setStageIds=new set<id>(); 
    public set<id> masterid=new set<id>(); 
    public set<id> stageidmar=new set<id>(); 
    public map<id,NPD_Stage__c> mapStageId_Stage=new   map<id,NPD_Stage__c>();
    public map<String,NPD_Stage__c> mapSerialNo_Stage=new   map<String,NPD_Stage__c>();
    public map<String,NPD_Stage__c> mapSerialNo_StageGetEnd=new   map<String,NPD_Stage__c>();
    
    if(check == false)
    {  
        system.debug('outside of if statement 2222');
        if(Trigger.isAfter && Trigger.isUpdate)
        {
            set<id> substageId = new set<id>();
            list<npd_stage__c> nStgs = new list<npd_stage__c>();
            string stgcomplex= '';
            string source ='';
            string projectId ='';
            integer position;
            String StageId='';
            
            for(npd_stage__c ns2:trigger.new)
            {
                if(((ns2.Complexity_Typess__c != trigger.oldmap.get(ns2.id).Complexity_Typess__c) || (ns2.Complexity_Category__c != trigger.oldmap.get(ns2.id).Complexity_Category__c) )&& ns2.type__c == 'sub-stage' )
                {
                    substageId.add(ns2.id);
                    nStgs.add(ns2);
                }
                stgcomplex = ns2.Complexity_Typess__c;
                source =   ns2.source__c;
                projectId = ns2.npd_project_name__c;
                position = integer.valueof(ns2.position__c);
                StageId = ns2.npd_stage__c;
                system.debug('The stageId is: ' + StageId );
                system.debug('The planned lead time of substage: ' + ns2.planned_lead_time__c);
            }
            if(substageId.size()>0)
            {
                try{
                    system.debug('The trigger values :'+ substageId +'....'+ stgcomplex +'....'+ source+'...'+ StageId+'...'+position+'...'+projectId);
                    NPD_UtilityController.ActivitySubActivityLeadTime(substageId,stgcomplex,source,StageId);
                    NPD_UtilityController.StageSubStageLeadTimeRecalculation(position,projectId);
                }catch(exception test1){
                    system.debug('The test1 is :'+ test1);
                }
                system.debug('calling');
            }
        }
        for(npd_stage__c stage: trigger.new)
        {
            if(Trigger.isbefore && Trigger.isupdate)
            {
                if((stage.Active__c  != trigger.oldMap.get(stage.id).Active__c ) && (stage.Status__c == 'Completed'  || stage.Status__c == 'Completed R1' || stage.Status__c == 'Completed R2' || stage.Status__c == 'In Progress' || stage.Status__c == 'In Progress R1' || stage.Status__c == 'In Progress R2'))
                {
                    stage.addError('Sorry! you cant de-Active this record as status is changed');
                }
            }
        }   
        /*
set<string> inBrand = new set<string>();
set<string> inSubBrand = new set<String>();

for(npd_master__c inBrand1 : [select id,name,Brand__c,type__c  from npd_master__c where type__c ='Brand'])
{
inBrand.add(inBrand1.name);
}
for(npd_master__c inSubBrand1 : [select id,name,Brand__c,type__c  from npd_master__c where type__c ='Sub Brand'])
{
inSubBrand.add(inSubBrand1.name);
}
if(trigger.isbefore && (trigger.isinsert || Trigger.isupdate))
{
for(npd_stage__c npds : trigger.new)
{
if( npds.Brand1__c!= null && ! inBrand.contains(npds.Brand1__c))
npds.adderror ('This Brand is not in the NPD Master List');

if( npds.Sub_Brand1__c!=null && ! inSubBrand.contains(npds.Sub_Brand1__c))
npds.adderror ('This Sub Brand is not in the NPD Master List');
}
}     

*/
        
        //it is use to  parent ids of related stages and substages to calculate plannedstart,plannedenddate,revisedstart and revisedEnddate 
        
        if(Trigger.isbefore){
            if(Trigger.isinsert  ){ 
                for(NPD_Stage__c obj:trigger.new){
                    if(obj.Type__c=='Sub-Stage'){   
                        setStageIds.add(obj.NPD_Stage__c);
                        system.debug('setStageIds'+setStageIds);
                    }
                    if(obj.PredecessorSerialNo__c != null){
                        mapSerialNo_Stage.put(obj.SerialNo__c,obj);
                        system.debug('++++++mapSerialNo_Stage++'+mapSerialNo_Stage);
                    }
                    
                    /*  if(trigger.newMap.get(obj.id).Planned_End_Date__c !=NULL && trigger.newMap.get(obj.id).Planned_End_Date__c != trigger.oldMap.get(obj.id).Planned_End_Date__c && obj.Type__c=='Sub-Stage' )
{   
lststage4.add(obj.NPD_Stage__c);
}*/
                    
                    
                    
                    
                    
                } 
                //for very first stage  and other stages with predecessor(SerialNo__c) value
                if(setStageIds.size() == 0){
                    //passing list of current stage and SerialNo__c to find the(predecessor)
                    NPD_UtilityController.dateCalulationForStage(trigger.new,mapSerialNo_Stage);   
                }
                //for very first substage and subStages with Predecessor(SerialNo__c) value
                else{
                    //Query to fine the related stage of the substage
                    for(NPD_Stage__c n:[Select id,Planned_Start_Date__c,Planned_End_Date__c,NPD_Stage__c from NPD_Stage__c where id =: setStageIds  ]) {
                        mapStageId_Stage.put(n.id,n);
                    }
                    //passing list of current substage,realted Stage and SerialNo__c to find the(predecessor)
                    NPD_UtilityController.dateCalulationForSubStage(trigger.new,mapStageId_Stage,mapSerialNo_Stage);
                }
                
                /* if(lststage4.size()>0)
{
NPD_UtilityController.aftersubstagePlanneddateStage(trigger.new,mapStageId_Stage,mapSerialNo_Stage);
}*/
                
                
            }  
        }
        
        
        /*this is use to capture the  related Stage id of SubStage and and call method(checkStageStatusAndActualDate)to 
calculate ActualEnd date,StartDate and Staus updates*/
        
        if(Trigger.isAfter && Trigger.isupdate ){
            list<NPD_Stage__c >lstActiveActivity = new list<NPD_Stage__c >();
            list<NPD_Stage__c >lststage = new list<NPD_Stage__c >();
            set<id>setId = new set<id>();
            set<id>substageId = new set<id>();
            set<id> attachmentid =new set<id>();
            set<id>setIdNotStarted = new set<id>();
            set<id>stageidforplantdate = new set<id>();
            list<NPD_Stage__c >lststage2 = new list<NPD_Stage__c >();
            list<id>lststage3 = new list<id>();
            set<id>StageidforOwner = new set<Id>();
            set<id>setprojectitemsowner = new set<Id>(); 
            set<id>projectidowner = new set<Id>(); 
            List<Attachment> lstattach=new List<Attachment>();
            map<id, NPD_Stage__c>mapSubstageId_Activity = new map<id, NPD_Stage__c>();
            set<id> stageidactdec                    =   new set<id>();
            //<T02>
            List<NPD_Stage__c> listOfNPDStage = new List<NPD_Stage__c>([Select id,Revised_Start_Date__c,Revised_End_Date__c,NPD_Stage__c from NPD_Stage__c]);
            //<T02>
            for(NPD_Stage__c n :trigger.new){  
                
                if((trigger.newMap.get(n.id).Revised_Start_Date__c!=trigger.oldMap.get(n.id).Revised_Start_Date__c) && trigger.oldMap.get(n.id).PredecessorSerialNo__c == null && trigger.oldMap.get(n.id).NPD_Stage__c==NULL){
                    
                    //capturing related stage
                    for(NPD_Stage__c n1:listOfNPDStage) {//<T02> converted SOQL query to list
                        System.debug('n1.Revised_Start_Date__c'+ n1.Revised_Start_Date__c);
                        n1.Revised_Start_Date__c=NULL;
                        n1.Revised_End_Date__c=NULL;
                        lststage.add(n1);
                    }
                    /*<T01>
                    * commented here and added after for loop tag to avoid DML Statement inside loop
                    if(lststage.size()>0){
                    	update lststage;
                    }
					</T01>*/
                }
                
                if((trigger.newMap.get(n.id).Status__c =='In Progress'||trigger.newMap.get(n.id).Status__c == 'Completed') && n.Type__c=='Sub-Stage' && trigger.newMap.get(n.id).Status__c !=trigger.oldMap.get(n.id).Status__c){
                    //caturing related stage
                    System.debug('+++++++++++++ n.NPD_Stage__r.Name__c++++++++++++++'+ n.NPD_Stage__r.Name__c);
                    setId.add(n.NPD_Stage__c);   // By sudama
                    //NPD_UtilityController.checkStageStatusAndActualDate(setId,trigger.new); 
                }
                
                //(ON Click OF Active/Deactive)To autoPopulate the status and the Actual End date if all activities are completed and any of the active activity is deactivated. 
                
                if(n.Active__c!=trigger.oldMap.get(n.id).Active__c  && n.Type__c=='Sub-Stage') {
                    stageidactdec.add(n.npd_stage__c);
                }
                
                //Leadtime Assingment from Substage to activity level 
                /*  if(trigger.newMap.get(n.id).Actual_Start_Date__c!=trigger.oldMap.get(n.id).Actual_Start_Date__c  && n.Actual_Start_Date__c!= null && n.Type__c=='Stage' ){

StageidforOwner.add(n.id);
setprojectitemsowner.add(n.NPD_Project_Items__c); 
projectidowner.add(n.NPD_Project_Name__c);  
System.debug('StageidforOwner'+StageidforOwner);
System.debug('setprojectitemsowner'+setprojectitemsowner);
System.debug('projectidowner'+projectidowner);  


}*/
                
                
                /*    if(n.Approval_Status__c!=trigger.oldMap.get(n.id).Approval_Status__c && n.Approval_Status__c!=NULL && n.Approval_Status__c=='Pending' && n.Type__c=='Stage' && n.Name__c=='Marketing Brief/Concept'){


attachmentid.add(n.id);
lstattach=[select id,name from Attachment where ParentId IN: attachmentid];
System.debug('Please Upload the attacment before Approval Submission'+lstattach);
if(lstattach.size()<1){

n.adderror('Please Upload the attacment before Approval Submission');


}
}*/
                
                if(trigger.newMap.get(n.id).Actual_Start_Date__c!=trigger.oldMap.get(n.id).Actual_Start_Date__c  && n.Actual_Start_Date__c!= null && n.Type__c=='Sub-Stage' ){
                    
                    StageidforOwner.add(n.id);
                    setprojectitemsowner.add(n.NPD_Project_Items__c); 
                    projectidowner.add(n.NPD_Project_Name__c);  
                    System.debug('StageidforOwner'+StageidforOwner);
                    System.debug('setprojectitemsowner'+setprojectitemsowner);
                    System.debug('projectidowner'+projectidowner);  
                    
                }
                
                if((trigger.newMap.get(n.id).Actual_Start_Date__c!=trigger.oldMap.get(n.id).Actual_Start_Date__c) && n.Type__c=='Sub-Stage' && n.Stage_name__c != 'Marketing Brief/Concept'){
                    //caturing related stage                
                    setIdNotStarted.add(n.NPD_Stage__c);
                    system.debug('setIdNotStarted'+setIdNotStarted);
                    System.debug('+++++++++++++ n.NPD_Stage__r.Name__c++++++++++++++'+ n.NPD_Stage__r.Name__c);
                    
                    //NPD_UtilityController.checkStageStatusNotStarted(setId,trigger.new,Trigger.oldMap);
                }
                
                /*This is to  update  planned date and revised  date on update of the lead time on stage and substage level
lststage2 holds the substage id 
lststage3 holds the project id of related stage and substage
*/
                
                if((trigger.newMap.get(n.id).Planned_End_Date__c != trigger.oldMap.get(n.id).Planned_End_Date__c ) || (trigger.newMap.get(n.id).Actual_End_Date__c != trigger.oldMap.get(n.id).Actual_End_Date__c && trigger.newMap.get(n.id).Actual_End_Date__c != NULL) ){
                    lststage2.add(n);
                    lststage3.add(n.NPD_Project_Name__c);             
                    
                }
                
                
                /*** this is to update the Activity Planned Lead time and ComplexityType as per the  Complexity Type selected at the substage level***/
                
                
                if((n.Complexity_Typess__c != trigger.oldMap.get(n.id).Complexity_Typess__c ) && n.Complexity_Typess__c!= NULL && n.Type__c=='Sub-stage'){
                    //holding the substage id 
                    substageId.add(n.Id);    
                    mapSubstageId_Activity.put(n.id,n);
                } 
                
                //For updating the dynamic table column for the Sub-Activty 'Case/Model No Allocation' based on the source selected.
                if(n.source__c != trigger.oldmap.get(n.id).source__c || n.source__c!='NULL' || n.design_manager_npd_master__c!=NULL)
                {
                    //<T02>
                    updateCheck = true;
                    /*
					// commented and  added after for loop ends (Inside <T02> tag)
						NPD_UtilityController handler = new NPD_UtilityController(trigger.new,trigger.oldmap);
						System.debug('afterUpdateHandlerafterUpdateHandler');
						handler.afterUpdateHandler();
						*/
                    //<T02>
                }
            } 
            //for loop ends here
            //<T01>
            if(lststage.size()>0){
                update lststage;
            }
            //</T01>
            //<T02>
            if(updateCheck){
                NPD_UtilityController handler = new NPD_UtilityController(trigger.new,trigger.oldmap);
                System.debug('afterUpdateHandlerafterUpdateHandler');
                handler.afterUpdateHandler(); 
            }
            //</T02>
            
            if(!setId.isempty()){
                NPD_UtilityController.checkStageStatusAndActualDate(setId,trigger.new);  
            }
            
            if(!setIdNotStarted.isempty()){
                NPD_UtilityController.checkStageStatusNotStarted(setIdNotStarted,trigger.new,Trigger.oldMap); 
            }
            
            
            if(!lststage2.isempty()){
                NPD_UtilityController.afterUpdateSubStageHandlerForStartDate(lststage2,trigger.oldMap);
            }
            
            //Activate.....Deactivate
            if(!stageidactdec.isEmpty()){
                
                NPD_UtilityController.ActivateDeactivateStage(stageidactdec); 
            }
            
            
            System.debug('==lststage3=='+lststage3);
            //planned and revised date update of stage on change of lead time at substage level.
            if(lststage3 != null && lststage3.size()> 0 && !lststage3.isempty()){
                NPD_UtilityController.afterUpdateStageHandlerForPlannedDateStage(lststage3,trigger.oldMap);
                
            }   
            
            if(StageidforOwner.size()>0 || projectidowner.size()>0 || setprojectitemsowner.size()>0){
                
                System.debug('StageidforOwner'+StageidforOwner);
                System.debug('projectidowner'+projectidowner);
                
                NPD_UtilityController.ownerAssingmentforstage(StageidforOwner,projectidowner,setprojectitemsowner);
            }
            
            
            if(substageId.size()>0){
                System.debug('substageIdsubstageId'+substageId);
                NPD_UtilityController.updateleadtimeonActivity(substageid,mapSubstageId_Activity);
                
            }  
            
            //Added by roshi
            for (npd_stage__c n: trigger.new) {
                if (n.design_manager_npd_master__c!= NULL && n.Name__c == 'Marketing Brief/Concept') {
                    stageidmar.add(n.id);
                    masterid.add(n.design_manager_npd_master__c);
                    system.debug('masteridmasteridmasterid'+masterid);
                }
            } 
        }
        
        if(masterid.size()>0){
            if(NPDcheckRecursive.runOnce())
                NPD_UtilityController.updatedesignmanager(stageidmar,masterid);
        }
        
        
        
        if(Trigger.isbefore && Trigger.isupdate){
            NPD_UtilityController handler = new NPD_UtilityController(trigger.new,trigger.oldmap);
            system.debug('***getCpuTime()***'+Limits.getCpuTime());
            system.debug('***getDMLRows()***'+Limits.getDMLRows());
            system.debug('***getQueries()***'+Limits.getQueries());

            handler.beforeUpdateStageHandler();
            system.debug('***getCpuTime()***'+Limits.getCpuTime());
            system.debug('***getDMLRows()***'+Limits.getDMLRows());
            system.debug('***getQueries()***'+Limits.getQueries());
            system.debug('The stage trigger before update values: '+ trigger.new[0]);
            
            
            
        }
        
        
        
        
        
        if(trigger.isbefore && Trigger.isUpdate)
        {
            
            list<npd_stage__c> stagesMbNo = new list<npd_stage__c>();
            
            for(npd_stage__c ns12:trigger.new)
            {
                if(ns12.type__c =='stage')
                {
                    system.debug('The stage trigger before update values stage: '+ trigger.new[0]);
                    stagesMbNo.add(ns12);
                    
                }
            }
            
            if(stagesMbNo.size()>0)
                NPD_UtilityController.mbAutoNumberGeneration(stagesMbNo);
            
            
        }
        
        
        
        /*

if(Trigger.isafter && Trigger.isupdate){


for(npd_stage__c npdstage1:trigger.new)
{
if(npdstage1.type__c == 'stage' &&  npdstage1.active__c==false)
{
npd_stage__c oldstage=trigger.oldmap.get(npdstage1.id);
if(oldstage.active__c != npdstage1.active__c){

NPD_UtilityController.reCalculateDatesForActivateAndDeactivate(npdstage1);
}
}

if(npdstage1.type__c == 'Sub-stage' &&  npdstage1.active__c==false)
{
npd_stage__c oldstage=trigger.oldmap.get(npdstage1.id);
if(oldstage.active__c != npdstage1.active__c){

NPD_UtilityController.reCalculateDatesForDeactivateSubStage(npdstage1);
}
}


}
}       */
        
        
        
        
        /*    list<npd_activity__c> activityIds = new list<npd_activity__c>();
set<id> Stageids = new set<id>();
if(trigger.isbefore && trigger.isupdate)
{
for(npd_stage__c ns1: trigger.new)
{
Stageids.add(ns1.id);   
}

for(npd_activity__c na1: [select id,name__c,npd_stage__c,NPD_Project_Name__c  from npd_activity__c where npd_stage__c in : Stageids])
{
activityIds.add(na1);
}
update activityIds;

}   */
        // For owner assignment. 
        
        
        /************   
list<npd_activity__c> activityIds= new list<npd_activity__c>();
set<id> ProjIds = new set<id>();
if(trigger.isbefore && trigger.isupdate)
{
for(npd_stage__c ns1: trigger.new)
{
if(ns1.type__c== 'stage')
{
ProjIds.add(ns1.NPD_Project_Name__c);   
system.debug('ns1.NPD_Project_Name__c value' +ns1.NPD_Project_Name__c);
}
}

for(npd_activity__c na1: [select id,name__c,npd_stage__c,NPD_Project_Name__c  from npd_activity__c where NPD_Project_Name__c in : ProjIds])
{
activityIds.add(na1);
}
update activityIds;
system.debug('The size of activities : ' + activityIds.size());
}     *********/
        
        
        
        
        /************* 

list<npd_stage__c> substages = new list<npd_stage__c>();

system.debug('Outside isafter isinsert');

if(Trigger.isinsert)
{

system.debug('inside isafter isinsert');
for(npd_stage__c ns2:trigger.new)
{

system.debug('inside isafter isinsert for loop '+ ns2.name__c);
if( ns2.type__c == 'Sub-stage'  && (ns2.name__c != 'Concept Finalization'   || ns2.name__c != 'Concept Briefing to ISCM' ))
{
substages.add(ns2);
}
} } 


if(substages.size()>0)
{
NPD_UtilityController.SubStageLeadTimeWithComplexityInsert(substages);
system.debug('calling while inserting sub stages');

}
***************/
        
        /****************************   Temo commented code *************8
if(trigger.isafter && trigger.isupdate )
{

for(npd_stage__c npds1:trigger.new)
{
if(npds1.type__c == 'sub-stage')
{
npd_stage__c  OldStage = trigger.oldmap.get(npds1.id);

if( npds1.Planned_Lead_Time__c!= OldStage.Planned_Lead_Time__c)
{
try{
npd_stage__c ns1=[select id,name__c,ParentStageId__c,active__c  from npd_stage__c where NPD_Stage__c=:npds1.ParentStageId__c and type__c='sub-stage' and active__c =true order by position__c DESC limit 1];
if(ns1.active__c == true || ns1.name__c == 'Concept Finalization' || ns1.name__c == 'Concept Briefing to ISCM' )
{
ns1.active__c = false;
update ns1;
system.debug('The updating ns1 is: '+ ns1);
ns1.active__c = true;
update ns1;
system.debug('The updating after ns1 is: '+ ns1);
}
}  catch(exception e1)
{
system.debug(' The exception is :'+ e1);
}  
}    

}
}
}    ************************************************/
        
        /************************************************** 
if(trigger.isafter && trigger.isupdate)
{
for(npd_stage__c nStage1: trigger.new)
{
if(nStage1.Planned_End_Date__c != Trigger.OldMap.get(nStage1.id).Planned_End_Date__c)
NPD_UtilityController.StageSubStageLeadTimeRecalculation(nStage1, nStage1.npd_project_name__c);
system.debug('After calling method :');
}
}
************************************************************************/
        
    }
}