public class Npd_Insert_New_Act_Rec_Controller {

 public npd_activity__c obj{get;set;}
 public list<selectoption> collections{set;get;}
 
  public list<selectoption> ProjectName{set;get;}
 public list<selectoption> Stage{set;get;}
 public list<selectoption> substage{set;get;}
 public list<selectoption> Activity{set;get;}
 
 public string selectedCollection{set;get;}
 public string selectedProjectName{set;get;}
 public string selectedStage{set;get;}
 public string selectedubstage{Set;get;}
 public string SelectedActivity{set;get;}
 

 
    public Npd_Insert_New_Act_Rec_Controller (ApexPages.StandardController sc){
        //Instead of instanciating a new object, use the existing record from the Standard Controller
        obj = (npd_activity__c)sc.getRecord();
        system.debug('The test class val is: ' + obj);
        
        
        
         
         
        //Allocating memory for the slectLists. 
         
         collections = new list<selectoption>();
      ProjectName= new list<selectoption>();
      Stage= new list<selectoption>();
      substage= new list<selectoption>();
      Activity = new list<selectoption>();
     
     
     // Fetching all collections:
     collections.add(new SelectOption('None','None'));
     ProjectName.add(new SelectOption('None','None'));
     Stage.add(new SelectOption('None','None'));
     substage.add(new SelectOption('None','None'));
     Activity.add(new SelectOption('None','None'));

     for(npd_collections__c nc1:[select id,name from npd_collections__c ])
      {
        collections.add(new SelectOption(nc1.id,nc1.name));
      } 
       
      } 
       
    
       
       
    
    
   

    //Alternatively, if there is no extra logic in customSave, you could remove this, and call
    //The StandardController's save method instead.
    public PageReference save(){
        upsert obj Id;
        return null;
    }
    
    public void callmeth()
    {  
      
      // Fetching all Project names which are under the current selected collection from the FrontEnd page.
       ProjectName.clear();
       ProjectName.add(new SelectOption('None','None'));
       if(selectedCollection !=null && selectedCollection !='None')
       {
         for(npd_project_name__c np1:[select id,name from npd_project_name__c where NPD_Collections__c=:selectedCollection])
         {
           ProjectName.add(new selectoption(np1.id,np1.name));
         }
       }
       Stage.clear();
       Stage.add(new SelectOption('None','None'));
       // Fetching all stages pertaining to the selectd project name from the VF page.
       if(selectedProjectName!=null  && selectedProjectName!='None')
       {
         for(npd_stage__c nStg: [select id,name__c from npd_stage__c where Type__c ='stage' AND NPD_Project_Name__c=:selectedProjectName])
         {
            Stage.add(new selectOption(nStg.id,nStg.name__c));
         }
       }
       
       substage.clear();
       substage.add(new SelectOption('None','None'));
        // Fetching all sub-stages pertaining to the selectd project name from the VF page.
       if(selectedStage!= null && selectedStage!='None')
       {
        for(npd_stage__c nSubStg: [select id,name__c from npd_stage__c where Type__c ='Sub-stage' AND npd_stage__c=:selectedStage])
         {
            substage.add(new selectOption(nSubStg.id,nSubStg.name__c));
         }
       }
       
       
       
       Activity.clear();
       Activity.add(new SelectOption('None','None'));
       // Fetching all ACtivities  pertaining to the selectd sub-stage name from the VF page.
      if(selectedubstage!= null && selectedubstage!='None')
       {
        for(npd_Activity__c nAct: [select id,name__c from npd_Activity__c where Type__c ='Activity' AND npd_stage__c=:selectedubstage])
         {
            Activity.add(new selectOption(nAct.id,nAct.name__c));
         }
       }
       
       if(selectedProjectName!=null && selectedProjectName!='None')
       obj.NPD_Project_Name__c =selectedProjectName;
       if(selectedCollection!=null && selectedCollection!='None')
        obj.NPD_Collections__c = selectedCollection;
        if(selectedubstage!=null && selectedubstage!='None')
        obj.NPD_Stage__c = selectedubstage;
        if(SelectedActivity!=null && SelectedActivity!='None')
        {
        obj.NPD_Activity__c = SelectedActivity;
        obj.type__c = 'Sub-Activity';
        }
        else
        {
         obj.type__c = 'Activity';
        }
        
      }
      
      public void SaveRecord()
      {
      
      list<npd_activity__c> actslist = new list<npd_activity__c>();
      list<npd_activity__c> actslistToUpdate = new list<npd_activity__c>();

     
        if(obj!=null)
        {
          if(obj.position__c != null)
            {
               if(obj.type__c =='Activity')
                 {
                   for(npd_activity__c na1:[select id,name__c,position__c from npd_activity__c  where npd_stage__c=:selectedubstage])
                     {
                        actslist.add(na1);
                     }
                     
                     integer tempPosition = integer.ValueOf(obj.position__c);
                     
                    if( integer.valueof(actslist.size())+1 >= obj.position__c)
                      {
                        for(npd_activity__c nact2:actslist)
                          {
                            if(nact2.position__c == tempPosition )
                              {  
                                system.debug('inside previous position ++: '+nact2.position__c +' .. Act name: '+ nact2.name__c);
                                 nact2.position__c = nact2.position__c +1;
                                 tempPosition++;
                                 system.debug('inside position ++: '+nact2.position__c +' .. Act name: '+ nact2.name__c);
                                 actslistToUpdate.add(nact2);
                              }
                          
                          }
                      }
                   }
                   
                   
                   
                   // Position interchaing for sub-activity.
                   
                    if(obj.type__c =='sub-Activity')
                 {
                   for(npd_activity__c na1:[select id,name__c,position__c from npd_activity__c  where npd_activity__c=:SelectedActivity])
                     {
                        actslist.add(na1);
                     }
                     
                     integer tempPosition = integer.ValueOf(obj.position__c);
                     
                    if( integer.valueof(actslist.size())+1 >= obj.position__c)
                      {
                        for(npd_activity__c nact2:actslist)
                          {
                            if(nact2.position__c == tempPosition )
                              {  
                                system.debug('inside previous position ++: '+nact2.position__c +' .. Act name: '+ nact2.name__c);
                                 nact2.position__c = nact2.position__c +1;
                                 tempPosition++;
                                 system.debug('inside position ++: '+nact2.position__c +' .. Act name: '+ nact2.name__c);
                                 actslistToUpdate.add(nact2);
                              }
                          
                          }
                      }
                   }
                   
              }        
        insert obj;
        update actslistToUpdate;
      }
}
}