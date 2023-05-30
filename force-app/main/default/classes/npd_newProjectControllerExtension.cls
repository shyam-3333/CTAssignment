/******************


******************/

public class npd_newProjectControllerExtension
{
 
  public set<id> subStageIds;
  public string stgcomplex;
  public string source;
  public string stageId;
  public string projId;
  public map<string,Date> StageStartDateMap = new map<string,Date>();
  public map<string,Date> StageEndDateMap = new map<string,Date>();
  public  Date startdate ;
  public  Date EndDate ; 
  public string collectionid;
 public npd_newProjectControllerExtension(){}
 public npd_newProjectControllerExtension(String projectId){
      projId = projectId;
  }
  
    public void fillComplexityLeadTimes()
    {
    
      boolean check = false;
    
    try{
    // fetching Custom setting.
    Npd_activity_trigger_controller__c cus1=  Npd_activity_trigger_controller__c.getInstance('stagetrigger');
 check = cus1.continueExecution__c;
    } catch(exception er1)
    {
    system.debug(er1);
    }
    

   if(check == false)
    {  
      //  Npd_activity_trigger_controller__c cus1=  Npd_activity_trigger_controller__c.getInstance('stagetrigger');
      //  cus1.continueExecution__c = true;
     //   update cus1;
     
       Npd_activity_trigger_controller__c  cus1 = [select id,continueExecution__c  from Npd_activity_trigger_controller__c where name='stagetrigger'];
       cus1.continueExecution__c = true;
        update cus1;
     
    
    }
    
      list<npd_Stage__c> StgsToupdate = new list<npd_stage__c>();
    
      subStageIds = new set<id>();
      if(projId == null){
          projId= ApexPages.currentPage().getParameters().get('projid');
          system.debug('The projid is:' + projid);
      }   
      npd_project_name__c nProject = [select id,name,Source__c,Project_Complexity__c,npd_collections__c,newModelRefresh__c from npd_project_name__c where id=:projId];
       collectionid  = nProject.npd_collections__c;
      nProject.newModelRefresh__c ='true';
      update nProject;
        
      map<string,NPD_Complexity__c> StgNameComplex = new map<string,NPD_Complexity__c>();   
        
         For(NPD_Complexity__c com:[SELECT ID,Name__c,NPD_Activity__c,serialno__c,Sub_Stage__c,Type__c,Record_Type__c,Lead_Time_del__c,Complexity_Type__c,record_name__c,Activity_master_name__c FROM NPD_Complexity__c WHERE  Record_Type__c ='Complexity Type' AND Name__c=:nProject.Project_Complexity__c AND source__c=:nProject.Source__c])
        {
          if(com.Record_Type__c == 'Complexity Type')
          {
          StgNameComplex.put(com.record_name__c,com);
        
          }
          
        }         

     /*   

       for(npd_Stage__c ns1:[select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c ,(select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c from stage__r) from npd_stage__c where npd_project_name__c=:projId AND name__c!='Marketing Brief/Concept' AND Active__c = true])
        {
        
        
        
        for(npd_Stage__c sub1:ns1.stage__r)
           {
          
           
           system.debug('The substage names are: ' +sub1.name__c );
             if(StgNameComplex != null &&  StgNameComplex.containsKey(sub1.name__c) && StgNameComplex.get(sub1.name__c)!=null)
             {
             sub1.Complexity_Typess__c = nProject.Project_Complexity__c;
             
             sub1.Planned_Lead_Time__c = StgNameComplex.get(sub1.name__c).Lead_Time_del__c;
             
             update sub1;
 
             }
          
           } 
        }
        
        */
        
        //  Updating Parent Stages. *******************************************
        
        
        for(npd_Stage__c ns1:[select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c,Planned_End_Date__c,Planned_Start_Date__c, (select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c from stage__r where active__c = true order by position__c ) from npd_stage__c where npd_project_name__c=:projId AND name__c!='Marketing Brief/Concept' AND Active__c = true  order by position__c])
        {
           decimal StageLeadTime = 0;
        system.debug('The StageLeadTime above for loop: ' +StageLeadTime);
        for(npd_Stage__c sub1:ns1.stage__r)
           {
            if(StgNameComplex != null &&  StgNameComplex.containsKey(sub1.name__c) && StgNameComplex.get(sub1.name__c)!=null)
             { 
             StageLeadTime = StageLeadTime + StgNameComplex.get(sub1.name__c).Lead_Time_del__c;
             system.debug('The StageLeadTime inside for loop: ' +StageLeadTime);
             }
           } 
           
           ns1.Planned_Lead_Time__c = StageLeadTime;
           //ns1.Planned_Start_Date__c = system.today();
           
           update ns1;
           system.debug('The StageLeadTime at updating: ' +StageLeadTime);
           StageLeadTime =0;
        }
        
        
        
        
        
        
        
         for(npd_Stage__c ns1:[select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c,Planned_End_Date__c,Planned_Start_Date__c,position__c,(select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c,position__c,Planned_End_Date__c,Planned_Start_Date__c from stage__r where active__c = true order by position__c ) from npd_stage__c where npd_project_name__c=:projId AND name__c!='Marketing Brief/Concept' AND Active__c = true AND type__c ='stage' order by position__c])
        {
        
         
          
          Date Stgstartdate ;
          Date StgEndDate ; 
          
                 
        for(npd_Stage__c sub1:ns1.stage__r)
           {
          
           
           system.debug('The substage names are: ' +sub1.name__c +sub1.position__c+'...'+ns1.position__c);
             if(StgNameComplex != null &&  StgNameComplex.containsKey(sub1.name__c) && StgNameComplex.get(sub1.name__c)!=null)
             {
             sub1.Complexity_Typess__c = nProject.Project_Complexity__c;
             
             sub1.Planned_Lead_Time__c = StgNameComplex.get(sub1.name__c).Lead_Time_del__c;
             
             if(sub1.position__c == 1 && ns1.position__c == 2)
             {
             sub1.Planned_Start_Date__c = system.today();
             system.debug('The If startdate is system.today:' + sub1.Planned_Start_Date__c);
             }
             else
             {
             sub1.Planned_Start_Date__c = startdate;
             system.debug('The else startdate is :' + startdate);
             }
             
             // For stage Start Date. 
            
              system.debug('The outside  startdate is :' + startdate+sub1.Planned_Lead_Time__c);
             sub1.Planned_End_Date__c = sub1.Planned_Start_Date__c.addDays(Integer.valueof(sub1.Planned_Lead_Time__c));
             
             
             
             startdate = sub1.Planned_End_Date__c.addDays(1);
             
             datetime dteCheckHoliday=NPD_UtilityController.NPDaddBussinessDays(startdate,0);
             
             startdate =  dteCheckHoliday.date();
             
             // datetime dteCheckHoliday=NPD_UtilityController.NPDaddBussinessDays(startdate,1);
             
             
             update sub1;
             
             
             // Stage End Date. 
             if(StgEndDate == null)
              StgEndDate=startdate;
             
             subStageIds.add(sub1.id);
 
             }
          
           }
             
        
          //  StageStartDateMap.put(ns1.name__c,Stgstartdate);
          //  StageEndDateMap.put(ns1.name__c,StgEndDate);
             
            Stgstartdate = null;
            StgEndDate = null; 
           
        }
        
        
         for(npd_Stage__c ns1:[select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c,Planned_End_Date__c,Planned_Start_Date__c,position__c,(select id,name__c,Planned_Lead_Time__c,Complexity_Typess__c,position__c,Planned_End_Date__c,Planned_Start_Date__c from stage__r where active__c = true order by position__c ) from npd_stage__c where npd_project_name__c=:projId AND name__c!='Marketing Brief/Concept' AND Active__c = true AND type__c ='stage' order by position__c])
        { 
          for(npd_stage__c nSub:ns1.stage__r)
          {
           if(ns1.position__c == 2)
           {
           if(nSub.position__c == 1)
           StageStartDateMap.put(ns1.name__c,nSub.Planned_Start_Date__c);
           
           if(nSub.position__c == 2)
          StageEndDateMap.put(ns1.name__c,nSub.Planned_End_Date__c);
         
           
           
          }
          // for development stage.
          if(ns1.position__c == 3)
           {
           if(nSub.position__c == 1)
           StageStartDateMap.put(ns1.name__c,nSub.Planned_Start_Date__c);
           
           if(nSub.position__c == 3)
            StageEndDateMap.put(ns1.name__c,nSub.Planned_End_Date__c);
           
           
          }
          
          
          // for production stage.
          if(ns1.position__c == 4)
           {
           if(nSub.position__c == 1)
           {
           StageStartDateMap.put(ns1.name__c,nSub.Planned_Start_Date__c);
           StageEndDateMap.put(ns1.name__c,nSub.Planned_End_Date__c);
           
          
           
           }
          }
          
          
         }
         
          //  Itterating stage records.
          
          ns1.Planned_Start_Date__c = StageStartDateMap.get(ns1.name__c);
          ns1.Planned_End_Date__c = StageEndDateMap.get(ns1.name__c);
          StgsToupdate.add(ns1);
        }
        
        
        
        
        
        
        update StgsToupdate;
        
        
      
           
       
       system.debug('the substage ids set:' + subStageIds+nProject.Project_Complexity__c+nProject.Source__c+stageId);
       
      NPD_UtilityController.ActivitySubActivityLeadTime(subStageIds,nProject.Project_Complexity__c,nProject.Source__c,stageId);

    
      // Updating stages,substages dates with marekting stage dates .
      
        list<npd_stage__c> StgstoUpdate2 =new list<npd_stage__c>();
      
       system.debug('The collection id is; ' + collectionid+'.... ' +projId);
       
       
       
       list<npd_stage__c> marketStg = [select id,name__c,planned_start_date__c,planned_end_date__c,actual_start_date__c,actual_end_date__c from npd_stage__c where NPD_Collections__c=:collectionid  AND NPD_Project_Name__r.name='Marketing Brief/Concept Stage'];
       
       for(npd_stage__c ns1:[select id,name__c,planned_start_date__c,planned_end_date__c,actual_start_date__c,actual_end_date__c from npd_stage__c where npd_project_name__c =:projId])
         {    
           for(npd_stage__c mark1:marketStg)
            {
              if(ns1.name__c =='Marketing Brief/Concept' && mark1.name__c =='Marketing Brief/Concept')
              {
              ns1.planned_start_date__c = mark1.planned_start_date__c;
              ns1.planned_end_date__c  = mark1.planned_end_date__c;
              ns1.actual_start_date__c  = mark1.actual_start_date__c;
              ns1.actual_end_date__c   = mark1.actual_end_date__c;
               }
               
             if(ns1.name__c =='Concept Finalization' && mark1.name__c =='Concept Finalization')
             {
              ns1.planned_start_date__c = mark1.planned_start_date__c;
              ns1.planned_end_date__c  = mark1.planned_end_date__c;
              ns1.actual_start_date__c  = mark1.actual_start_date__c;
              ns1.actual_end_date__c   = mark1.actual_end_date__c;
              }
              
             if(ns1.name__c =='Concept  Briefing to ISCM' && mark1.name__c =='Concept  Briefing to ISCM')
             {
              ns1.planned_start_date__c = mark1.planned_start_date__c;
              ns1.planned_end_date__c  = mark1.planned_end_date__c;
              ns1.actual_start_date__c  = mark1.actual_start_date__c;
              ns1.actual_end_date__c   = mark1.actual_end_date__c;
             }
            }
            
             StgstoUpdate2.add(ns1);
         
         }
    
       update StgstoUpdate2;
    
       Npd_activity_trigger_controller__c  cus2 = [select id,continueExecution__c  from Npd_activity_trigger_controller__c where name='stagetrigger'];
       cus2.continueExecution__c = false;
        update cus2;
        
      
    //  return new PageReference('https://na20.salesforce.com/'+nProject.NPD_Collections__c).setRedirect(true); 
    
    
   // return new PageReference(System.URL.getSalesforceBaseURL()+'/'+'npd_newProjectControllerExtensionVFpage?projId='+currProjRec.id).setRedirect(true); 
    
//    return new PageReference(System.URL.getSalesforceBaseURL()+'/'+'apex/NPD_DetailView_Page?projId='+nProject.id).setRedirect(true); 
   
 // sudama    return new PageReference('https://cs71.salesforce.com/apex/NPD_DetailView_Page?proID='+nProject.id).setRedirect(true); 
  
      
      // return null;
    }
  
}