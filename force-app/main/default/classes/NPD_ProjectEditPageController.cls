global class NPD_ProjectEditPageController{

    public String stage { get; set; }
 
    public string  imagepiclink    {set;get;}  // For holding the image url of user uploading image in project object.    
    public boolean event{get;set;}
    public NPD_Project_Name__c currProjRec {get;set;} 
    public List<NPD_Project_Name__c> projectnameList =new List<NPD_Project_Name__c>();    
    public string projId{get;set;} 
    public NPD_Activity__c ActivityList{get;set;}
    public List<NPD_Checklist__c> chkecklist=new List<NPD_Checklist__c>();
    public String casesource; 
    public String splyagnc;
    public String Combinecasesupply;
    Boolean Inactive ;
    Boolean active;
    public boolean con { get; set; }
    public String imageURL{get;set;}
    public string strTemp='';
    Public List<SelectOption>lstSelectedValue{get;set;}
     public List<SelectOption> options{get;set;}
    List<NPD_Project_Items__c>   stageItemList              =   new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c>   subStageItemList           =   new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c>   activityItemList           =   new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c>   subActivityItemList        =   new List<NPD_Project_Items__c>();
    public List<NPD_Stage__c>    stageList                  =   new  List<NPD_Stage__c> ();
    public map<id,List<NPD_Stage__c>> subStagemap           =   new map<id,List<NPD_Stage__c>>();
    public List<NPD_Stage__c> subStagelst                   =   new List<NPD_Stage__c>();
    public List<NPD_Activity__c> activitylst                =   new List<NPD_Activity__c>();
    public List<NPD_Stage__c> updatesubStagelst             =   new List<NPD_Stage__c>();
    public map<id,NPD_Activity__c> updateActivitymap        =   new map<id,NPD_Activity__c>();
    public Attachment attch{ get { if (attch == null) 
                                      attch = new Attachment (); 
                                      return attch; 
                                  } 
                             set;}
    
  /* For Inserting new npd_collection */   
     public string CaseMaterial{set;get;}
    public string CollectionName{set;get;}
    public string CommentsRemarks{set;get;}
    public string DevelopmentRoute{set;get;}
    public string Gender{set;get;}
    public string Market{set;get;}
    public string Marketingbriefconceptreferencenumber{set;get;}
    //public boolean MarketingRestrict{set;get;}
    public string MovementFunction{set;get;}
   // public date PlannedEndDate{set;get;}
    public string ProjectComplexity{set;get;}
    public string ProjectStatus{set;get;}
    public string ProjectType{set;get;}
    public string PSYNo{set;get;}
    public string ReasonsforDrop{set;get;}
    public string StrapMaterial{set;get;}
    public string StrapSource{set;get;}
    public string TemplateType{set;get;}
  
  
    public list<selectoption> SelectedMovementlist{set;get;}

    public list<selectoption> allmovementlist {set;get;}

    public list<NPD_Master__c> momfun;
    
    public set<string> momentString = new set<String>();
    
    
  
    public NPD_ProjectEditPageController(){
    
    
    /*
    
    allmovementlist= new list<selectoption>();
    SelectedMovementlist = new list<selectoption>();
    options = new List<SelectOption>();
    momfun = [SElECT Name,id FROM NPD_Master__c WHERE Type__c= 'Movement/Function' order by name];

    for (NPD_Master__c  moment : momfun) {
            momentString.add(moment.Name);
    }
  
    for (string  m1 : momentString) {
        allmovementlist.add(new SelectOption(m1, m1)); 
             
    }
    
    */
         
         
    
        options = new List<SelectOption>();
        lstSelectedValue= new List<SelectOption>();
        momentfuntionvalue();
        event=false;
        projId = apexpages.currentPage().getParameters().get('proID');
        system.debug('projId'+projId ); 
        currProjRec =new NPD_Project_Name__c ();
        //Planned_Project_End_Date1__c
        if(!String.isBlank(projId)) {
            currProjRec = [SELECT id,Marketing_brief_concept_reference_number__c,Model_No__c,PSY_No__c,Vendor_Ref_No__c,Project_Type__c,Project_Complexity__c,Project_Category__c,Source__c,Planned_Project_End_Date1__c,
            Actual_Project_Start_Date__c,Actual_Project_End_Date__c,Actual_Project_Lead_Time__c,Planned_Project_Lead_Time__c,Tentative_Launch_Month_Date__c,Brand__c,Sub_Brand__c,Brand1__c,
            Case_Material__c,Case_Source__c,NPD_Collections__c,Development_Route__c,Gender__c,Market__c,Strap_Source__c,Strap_Material__c,Strap_Type__c,Project_Owner__c,Project_Status__c,Reasons_for_Drop__c,
            Comments_Remarks__c,ImageUpload__c,Momentfuntionvalue__c from NPD_Project_Name__c  WHERE id=:projId LIMIT 1]; 
        }
        
        
    allmovementlist= new list<selectoption>();
    SelectedMovementlist = new list<selectoption>();
    options = new List<SelectOption>();
    momfun = [SElECT Name,id FROM NPD_Master__c WHERE Type__c= 'Movement/Function' order by name];

      
      
      list<string> Tempright11 = new list<string>();
      set<string> Tempright12 = new set<string>();

     if(currProjRec.Momentfuntionvalue__c != null)      
      {
       string  mytrim11= currProjRec.Momentfuntionvalue__c.trim();
      
         Tempright11 = mytrim11.split(',');
       
      } 
      Tempright12.addall(Tempright11);
    
    for (NPD_Master__c  moment : momfun) {
           if(! Tempright12.contains(moment.name))
            momentString.add(moment.Name);
    }
  
    for (string  m1 : momentString) {
        allmovementlist.add(new SelectOption(m1, m1)); 
             
    }
    
           
    
    
        
        
        
    /*  *************************************
      string mytrim = '';
      
      set<string> Tempright1 = new set<string>();
      
      if(currProjRec.Momentfuntionvalue__c != null)      
      {
         mytrim= currProjRec.Momentfuntionvalue__c.trim();
         list<string> Tempright = new list<string>();
         
         
         
         Tempright1.addall(Tempright);
        
         Tempright = mytrim.split(',');
        
         momentString.removeall(Tempright1);
        
         
      } 
      
      for(string s2:Tempright1)
      {
        selectoption op2= new selectoption(s2,s2);
        SelectedMovementlist.add(op2);
    }
     
*/   
        /***********************************************************  Modified code for displaying image at top-left of page ***************************/               
                
                // used to display the image at Top-Left of page.               
                NPD_Project_Name__c  UserImage=[SELECT id,ImageUpload__c FROM NPD_Project_Name__c  WHERE id =: projId LIMIT 1];
                
                if(UserImage != null && UserImage.ImageUpload__c !=null && UserImage.ImageUpload__c!='')
                    {
                    string  imageurl=UserImage.ImageUpload__c;

                if(imageurl !=null || imageurl !='')
                {

                integer x=imageurl.indexof('https');
               
	// Update by ranjani to overcome the Substring(-1) index error during deployment
	                if(x!=-1)
                    {
                      integer y=imageurl.indexof('"',x);
                	  imagepiclink= imageurl.substring(x,y);   
                    }
                     
                }
                }
                
/***********************************************************  End of Modified code for displaying image at top-left of page ***************************/ 
        
        
    }
    
    Public void EditRec(){
        
        
      string mytrim = '';
      
      set<string> Tempright1 = new set<string>();
      system.debug('The currProjRec.Momentfuntionvalue__c value : ' +currProjRec.Momentfuntionvalue__c);
      if(currProjRec.Momentfuntionvalue__c != null)      
      {
         mytrim= currProjRec.Momentfuntionvalue__c.trim();
         list<string> Tempright = new list<string>();
         
        system.debug('The size of momentString is : '+momentString); 
         

        
         Tempright = mytrim.split(',');
        
         Tempright1.addall(Tempright);
        
         momentString.removeall(Tempright1);
         
        system.debug('The size of momentString after is : '+momentString);
        system.debug('The size of Tempright1 is: '+Tempright1);
        
         
      } 
      
      for(string s2:Tempright1)
      {
        selectoption op2= new selectoption(s2,s2);
        SelectedMovementlist.add(op2);
    }
        
        event=true;
    }
    
    Public void Cancle(){
        event=false;
    }

    Public void SaveProject(){
            try{
            system.debug('Inside try method for SelectedMovementlist :'+SelectedMovementlist);
             for(SelectOption eachOption:SelectedMovementlist){
           
            system.debug('****strTemp1***'+strTemp);
            if(strTemp.length()>0){
                strTemp=strTemp+','+String.ValueOF(eachOption.getValue());
            }else{
                strTemp=String.ValueOF(eachOption.getValue());
                system.debug('inside strTemp value : '+strTemp);
            }
        }  
        
                 System.debug('MovementFunction'+MovementFunction);
              //  currProjRec.Momentfuntionvalue__c=MovementFunction;
              system.debug('the inside try of strTemp :'+strTemp);
              currProjRec.Momentfuntionvalue__c=strTemp;
              
                update currProjRec;
                event=false;
                ActiveInactive();
               }
                
                catch(exception ex){
                System.debug('***********exception*******'+ex);    
              }
            
          }
            
            
 
        
    
    
    /*******Method to activate and deactivate stages and activity as per the activity matrix**************/
    
  Public void ActiveInactive(){
    
    chkecklist=[SELECT Case_Sourcing__c,Model_No__c,Supply_Agency__c FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__r.Name__c =:'Case/Model No Allocation' AND Model_No__c =: currProjRec.Model_No__c limit 1 ]; 
        for(NPD_Checklist__c check :chkecklist){
            casesource=check.Case_Sourcing__c+'_';
            splyagnc=check.Supply_Agency__c ;
            Combinecasesupply=casesource+splyagnc;  
        }
        
        List<NPD_Project_Items__c>   stageItemList              =   new List<NPD_Project_Items__c>();
        List<NPD_Project_Items__c>   subStageItemList           =   new List<NPD_Project_Items__c>();
        List<NPD_Project_Items__c>   activityItemList           =   new List<NPD_Project_Items__c>();
        List<NPD_Project_Items__c>   subActivityItemList        =   new List<NPD_Project_Items__c>();
        
        List<NPD_Stage__c> stageList                            =   new List<NPD_Stage__c>(); 
        List<NPD_Stage__c> subStageList                         =   new List<NPD_Stage__c>();   
        List<NPD_Activity__c> activityList                      =   new List<NPD_Activity__c>(); 
        List<NPD_Activity__c> subActivityList                   =   new List<NPD_Activity__c>();   
        map<id,id> ProjectItem_StageActivity                    =   new map<id,id>();
        
        if(!String.isBlank(currProjRec.Project_Type__c)) {
            
            for(NPD_Project_Items__c pojItem : [Select n.Revision_Substage__c,n.PrePredecessor__c,n.User__r.id,n.User__c,n.NPD_User__c,n.Revision_Active__c,n.Mandatory_Fields__c,n.Auto_Generated__c,n.Phase__c,n.WhenToBeAcive__c, n.Total_Lead_Time__c,n.Development_Component_Route__c, n.Title__c, n.Titan_Sr_No__c, n.Titan_SNo_Predecessor__c, n.SystemModstamp, n.Successor__c, n.Successor_Item_Alerts__c, n.Source__c, n.Project_Template__c, n.Predecessor__c, n.Position__c, n.Parent_Id__c, n.OwnerId, n.Name, n.Line_Item_Approval_Required__c, n.Lead_Time__c, n.LastModifiedDate, n.LastModifiedById, n.LastActivityDate, n.Item_Type__c, n.Item_Number_Predecessor__c, n.IsDeleted, n.Initial_Submission_Email_TemplateID__c, n.Id, n.Email_on_Completion__c, n.Department__c, n.Days_to_Complete__c, n.CurrencyIsoCode, n.CreatedDate, n.CreatedById, n.Copy_CheckList_Items__c, n.Complexity__c, n.Complexity_Type__c, n.Complexity_Category__c, n.Columns_to_Copy__c,n.Development_WH_Full_watch_Route__c, n.Checklist_Columns__c, n.Attachment_Req__c, n.Approvers__c, n.Approval_Req__c, n.Approval_Email_TemplateID__c, n.Active__c From NPD_Project_Items__c n where Project_Template__r.name = : currProjRec.Project_Type__c  order By position__c asc]){
                
                if(pojItem.Item_Type__c=='Sub-Stage' && pojItem.Title__c=='Case Development - INH') {
                    subStageItemList.add(pojItem);
                } else if(pojItem.Item_Type__c=='Activity') {
                    activityItemList.add(pojItem);
                }
                
            }
        }
 
     
     //selects the particular Substage 
            subStagelst =[Select id,Name__c,Type__c,NPD_Project_Name__c,Tentative_Launch_Plan__c,Brand1__c,Sub_Brand1__c,NPD_Collections__c,Market__c,Model_Name__c,Marketing_brief_concept_reference_number__c from NPD_Stage__c  where NPD_Project_Name__c=:projId AND Name__c='Case Development - INH'];
            System.debug('StageSubstageList'+subStagelst );
            
    //To activate or Deactivate Substage on basis of Development Route and Case-Sourcing and Supply Agency. 
            
           for(NPD_Project_Items__c item : subStageItemList) {             
                for(NPD_Stage__c substage : subStagelst){
                
                  if(currProjRec.Development_Route__c=='Component Route' ){
                    if(item.Development_Component_Route__c!=NULL ){
                        string strallcom=item.Development_Component_Route__c;
                        System.debug('strallcomstrallcom'+strallcom);
                        for(String str : strallcom.split(',')){
                          System.debug('iditem '+item.id);
                         System.debug('str str '+str );
                          System.debug('Combinecasesupply'+Combinecasesupply);
                            if(Combinecasesupply==str){                               
                                active=true;  
                            }
                            else{
                                Inactive=false;                               
                            }    
                        }
                        
                        if(active==true){
                            item.Active__c=true;
                            active=false;
                            System.debug('insideif');
                            
                        }
                        else{
                            item.Active__c=false;
                            System.debug('insideifelse');
                        }
                    }
                    
                    else if(item.Revision_Substage__c==true){
                        item.Active__c=false;
                    }
                    else{
                    
                     item.Active__c=true;
                    }
                    
                }
                
                
                
                    if(currProjRec.Development_Route__c=='Development-WH/Full watch Route' ){
                    
                    if(item.Development_WH_Full_watch_Route__c!=NULL ){
                        string strAllWh=item.Development_WH_Full_watch_Route__c;
                        for(String str : strAllWh.split(',')){ 
                            if(Combinecasesupply==str){
                                
                                active=true;
                            }
                            else {
                                Inactive=false;
                                
                            }
                        }
                        
                        if(active==true   && item.Title__c=='Case Development - INH'){
                            item.Active__c=true;
                            
                            
                        }
                        else {
                            item.Active__c=false;
                        }
                    }
                    else{
                        item.Active__c=false;
                    }
                }
                
                substage.Active__c                  =   item.Active__c;
                updatesubStagelst.add(substage);     
         }
        
         
       }
       
       
       
       
       if(updatesubStagelst.size()>0){
       system.debug('updatesubStagelstbefore'+updatesubStagelst);
       update updatesubStagelst;
       updatesubStagelst.clear();
       system.debug('updatesubStagelstafter'+updatesubStagelst);
       }
       
            //selects the particular Activity
            activitylst =[Select id,Name__c,Type__c,NPD_Project_Name__c,Active__c from NPD_Activity__c where NPD_Project_Name__c=:projId AND Type__c='Activity' AND (NPD_Stage__r.NPD_Stage__r.Name__c='Development' OR NPD_Stage__r.NPD_Stage__r.Name__c='Production')];
            System.debug('activityItemList'+activityItemList.size());
            System.debug('activityItemList'+activityItemList);
            System.debug('activitylstsize'+activitylst.size());
            System.debug('activitylstsize'+activitylst);
             
             
             
            
       
        for(NPD_Project_Items__c item : activityItemList) {      
          
          for(NPD_Activity__c activity : activitylst ){
          
          
          if(activity.Name__c==item.Title__c){
           
             if(currProjRec.Development_Route__c=='Component Route'){
                    if(item.Development_Component_Route__c!=NULL){
                        string strallcom=item.Development_Component_Route__c; 
                       
                        for(String str : strallcom.split(',')){
                            if(Combinecasesupply==str){                               
                                active=true;  
                            }
                            else{
                                Inactive=false;                               
                            }    
                        }
                        
                        if(active==true){
                            item.Active__c=true;
                            active=false;
                            
                        }
                        else{
                            item.Active__c=false;
                        }
                    }
                    else{
                        item.Active__c=true;
                    }
                }
                
                
                 if(currProjRec.Development_Route__c=='Development-WH/Full watch Route'){
                    
                    if(item.Development_WH_Full_watch_Route__c!=NULL){
                     
                        string strAllWh=item.Development_WH_Full_watch_Route__c;
                        for(String str : strAllWh.split(',')){ 
                            if(Combinecasesupply==str){
                                
                                active=true;
                            }
                            else {
                                Inactive=false;
                                
                            }
                        }
                        
                        if(active==true){
                            item.Active__c=true;
                            active=false;
                            
                        }
                        else{
                            item.Active__c=false;
                        }
                    }
                    
                    else{
                   
                    item.Active__c=true;
                    }
                }
                
                
                 activity.Active__c     =   item.Active__c;
                 
                 updateActivitymap.put(activity.id,activity);     
                          
                }
                }
                
               } 
               system.debug('updateActivitymap'+updateActivitymap);
                if(!updateActivitymap.isEmpty()){
                
                try{
                  update updateActivitymap.values();  
                  
                  }
                  
                  catch(exception ex)
                  {
                  system.debug('*****exception while updating******'+ex);
                  }
                  }
          
   
     }
     
     
     
     public pagereference upload(){ 
     
attch.ParentId     = projId ;
attch.Name         = attch.name;
 
 try { 
    insert attch; 
    con = true;
    imageURL='/servlet/servlet.FileDownload?file=';
        List< Attachment> attList=[select name from Attachment where
                                        name=:attch.name  and id=:attch.id];
      string id;
      
        if(attList.size()>0)
        {
          imageURL=imageURL+attList[0].id;
               id=attList[0].id;   
          
          currProjRec.ImageUpload__c='<img src="https://na20.salesforce.com/servlet/servlet.FileDownload?file='+attList[0].id+'"></img>';         
          
        }

    } catch (DMLException e) { 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file')); 
    } finally { 
    attch.body = null; // clears the viewstate 
    attch = new Attachment(); 
    } 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully')); 
    SaveProject();
    
    pagereference p= new pagereference('https://na20.salesforce.com/apex/NPD_ProjectEditPage?proID='+projId);
    return p;
    
    } 
    
    /************Method to get the Value for MomentFuntion from Master Object**********/
    public void momentfuntionvalue(){
    NPD_Master__c  [] momfun = [SElECT Name,id FROM NPD_Master__c WHERE Type__c= 'Movement/Function' ORDER By Name ASC];
    options = new List<SelectOption>();
    for (NPD_Master__c  moment : momfun) {
        options.add(new SelectOption( moment.Name, moment.Name)); 
             
             
             
         }


     } 
     
     public void methodAccount()
    {
    
    
     // String todate = '06-06-2016';
        //Date dt = Date.valueOf(todate);
        
        NPD_Collections__c npc= new NPD_Collections__c();
    //  npc.Actual_Project_End_Date__c=Date.valueOf(ActualProjectEndDate);
    //  npc.Actual_Project_Start_Date__c=Date.valueOf(ActualProjectStartDate);
        npc.Case_Material__c=CaseMaterial;
        npc.Collection_Name__c=CollectionName;
        npc.Comments_Remarks__c=CommentsRemarks;
        npc.Development_Route__c=DevelopmentRoute;
        npc.Gender__c=Gender;
        npc.Market__c=Market;
        npc.Marketing_brief_concept_reference_number__c=Marketingbriefconceptreferencenumber;
        //npc.MarketingRestrict__c=MarketingRestrict;
        npc.Movement_Function__c=MovementFunction;
    //  npc.Planned_End_Date__c=Date.valueOf(PlannedEndDate);
        npc.Project_Complexity__c=ProjectComplexity;
        npc.Project_Status__c=ProjectStatus;
        npc.Project_Type__c=ProjectType;
        npc.PSY_No__c=PSYNo;
        npc.Reasons_for_Drop__c=ReasonsforDrop;
        npc.Strap_Material__c=StrapMaterial;
        npc.Strap_Source__c=StrapSource;
        npc.Template_Type__c=TemplateType;
        //npc.Tentative_Launch_Month_Date__c=Date.valueOf(TentativeLaunchMonthDate);
        npc.Tentative_Launch_Month_Date__c=Date.today();
        insert npc;
     
    
    
    }
    
    /*****************************************   For inserting  NPD_Collections__c*********************************/
     
     }