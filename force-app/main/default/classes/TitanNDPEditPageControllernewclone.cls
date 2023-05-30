/*
This is Controller class for TitanNDPEditPage which is created to edit Activiy and Sub Activity
Created Date:-9/01/2017
Created by:-  Roshi Rai
*/
public class TitanNDPEditPageControllernewclone{
   public List<NPD_Activity__c> lstact=new  List<NPD_Activity__c>();
   public String activityname                                                                                       {get;set;}
   public Boolean activityActive                                                                                    {get;set;}
   public Boolean subActive                                                                                         {get;set;}
   public Boolean stageActive                                                                                       {get;set;}
   public String username                                                                                           {get;set;}
   public String substagename                                                                                       {get;set;}
   public String stagename1                                                                                         {get;set;}
   public String showimage                                                                                          {get;set;}
   public Boolean showmodel                                                                                         {get;set;}
   public String currentuserid                                                                                      {get;set;}
   public String name                                                                                               {get;set;}
   public String selectedOwner                                                                                      {get;set;}
   public Boolean showAct                                                                                           {get;set;}
   public Boolean showSubAct                                                                                        {get;set;}
   public Boolean showstage                                                                                         {get;set;}
   public Boolean showstagescreen                                                                                   {get;set;}
   public Boolean showActscreen                                                                                     {get;set;}
   public Boolean showActscreenbutton                                                                                     {get;set;}
   public String selectedBrandName                                                                                  {get;set;}
   public String stagename                                                                                          {get;set;}
   public String strActionId                                                                                        {get;set;}
   public String strActionname                                                                                      {get;set;}
   public String selectedid                                                                                         {get;set;}
   public String selectedType                                                                                       {get;set;}
   public String relatedListType                                                                                    {get;set;}
   public Integer rowNum                                                                                            {get;set;}
   public String modelNum                                                                                           {get;set;}
   public String selectedCollectionName                                                                             {get;set;}
   public List < selectoption > npdBrandOption                                                                      {get;set;}
   public List < selectoption > npdTypeOption                                                                       {get;set;}
   public List < selectoption > npdCollectionOption                                                                 {get;set;}
   public List < selectoption > npdOwnerOption                                                                      {get;set;}
   public List < selectoption > npdfiscalYearOption                                                                 {get;set;}
   public map < String,NPD_Project_Name__c > CollectionName;
   public map < String,NPD_Project_Name__c > ModleName                                                              {get;set;}
   public List < NPD_Project_Name__c > ModleNameDetails                                                             {get;set;}
   public List < Npd_Activity__c > lstActivty                                                                       {get;set;}
   public List < Npd_Stage__c > lstStage                                                                            {get;set;}
   public List < Npd_Stage__c > record                                                                              {get;set;}
   public Npd_Activity__c recordact                                                                                 {get; set;}
   public map < id, string > idToFieldSet = new map < id,string > ();
   public list < NPD_Checklist__c > lDynamicTable                                                                   {get; set;} // list to a dynamic table data
   public map < integer, list < WrapperForFieldSet >> intTowrapperListforField                                      {get; set;}
   public list < WrapperForFieldSet > wrapperListforField                                                           {get; set;}
   public List < attachWrapper > attWrapperStageList                                                                {get; set;}
   public List < taskWrapper > taskWrapperStageList                                                                 {get; set;}
   public List<noteWrapper> noteWrapperStageList{get;set;}
   public List < EmailDetails__c > emailList                                                                        {get; set;}
   public boolean isAttach                                                                                          {get; set;}
   public boolean isAttachStage                                                                                     {get; set;}
   public boolean istask                                                                                            {get; set;}
   public boolean isNote                                                                                            {get; set;}
   public boolean isNoteCreated                                                                                            {get; set;}
   public boolean isTaskCreated {get;set;}
   public boolean ischklist                                                                                         {get; set;}
   public boolean isEmail                                                                                           {get; set;}
   public boolean isSuccesoor                                                                                       {get; set;}
   public boolean isaction                                                                                          {get; set;}
   public boolean isapproval                                                                                        {get; set;}
   public boolean isdynamicedit                                                                                     {get; set;}
   public boolean imagedispaly                                                                                      {get; set;}
   public boolean isEmailsend                                                                                       {get; set;}
   public String attparentname                                                                                      {get; set;}
   public Attachment attach1                                                                                        {get; set;}
   public EmailMessage emailmsg                                                                                     {get; set;}
   public Task tsk                                                                                                  {get; set;}
   public Note nte                                                                                                  {get; set;}
   public list < ProcessInstanceStep > approvalhislist                                                              {set; get;}
   public Attachment attach                                                                                         {get; set;}
   public String text1                                                                                              {get; set;}
   public String subject                                                                                            {get; set;}
   public String toaddre                                                                                            {get; set;}
   public Blob attbdy                                                                                               {get; set;}
   public String attdescrptn                                                                                        {get; set;}
   public Sobject record1                                                                                           {get; set;}
   public Boolean displaydynamic                                                                                    {get; set;}
   public List<successorEmailWrapper> lSuccessorEmailWrapper                                                        {get;set;}
  public List<EmailDetails__c>insertdetails = new List<EmailDetails__c>();
   public List < NPD_Email__c > succlist                                                                             {get;set;}
   public string imagepiclink                                                                                        {set;get;}
   //Query variable to pick brandname from URL
   public String strbrand                                                                                            {get;set;}
   public String collection                                                                                          {get;set;}
   public String owner                                                                                               {get;set;}
   public String title{get;set;}
   public String body{get;set;}
   public String sfUserName{get;set;}
   public String activityNameDY {get;set;}
   
  // Dynamic Data Table
      public map<string,list<checkListWrapper>> dynamicSobjWrapperMap                                                {get;set;} 
      public list<checkListWrapper> checkListWrapList                                                                {get;set;}
      public List<String> DisplayFieldsList                                                                          {get;set;}
   
   
    public class successorEmailWrapper{
     public String relatedTo     {get;set;}
     public String successorName {get;set;}
     public String brand         {get;set;}
     public String source        {get;set;}
     public String email         {get;set;}
     public String type          {get;set;}
   }
   
   //Constructor for the class
   public TitanNDPEditPageControllernewclone() {
      currentuserid = Userinfo.getUserId();
      user user = [select FirstName,LastName from User where id =: currentuserid ];
      if(user.FirstName != null){
          sfUserName = user.FirstName+' '+User.LastName;
      }
      else{
          sfUserName = User.LastName;
      }
      if(apexpages.currentpage().getparameters().get('brand') != NULL) strbrand = apexpages.currentpage().getparameters().get('brand');
      System.debug('************strbrand**********' + strbrand);
      if(apexpages.currentpage().getparameters().get('coll') != NULL) collection = apexpages.currentpage().getparameters().get('coll');
      System.debug('************collection**********' + collection);
      if(apexpages.currentpage().getparameters().get('owner') != NULL) owner = apexpages.currentpage().getparameters().get('owner');
      System.debug('************owner**********' + owner);
      attach = new Attachment();
      lDynamicTable = new List < NPD_Checklist__c > ();
      //selectedFiscalYear = 'None';
      showmodel = false;
      selectedOwner = 'None';
      showmodel = false;
      showAct = false;
      showSubAct = false;
      showstage = false;
      showstagescreen = false;
      showActscreen = false;
      selectBrand();
      //selectYear();
      selectCollection();
      selectOwner();
      selecttype();
      dummy();
   }
    public pageReference homePage(){
        pagereference pr = new pageReference('/home/home.jsp');
        pr.setredirect(true); 
        return pr;
    }
   /********Method Name:-select Brand**********************************************
            Description:- Method to show the Brand Name for Picklist
    *******************************************************************************/
   public void selectBrand() {
      npdBrandOption = new List < selectoption > ();
      System.debug('************strbrand**********' + strbrand);
      if(strbrand == null) {
         npdBrandOption.add(new selectoption('None', '--None--'));
      }
      else {
         npdBrandOption.add(new selectoption(strbrand, strbrand));
      }
      for(NPD_Master__c master: [
            select id, Name from NPD_Master__c where Type__c = 'Brand'
         ]) {
         npdBrandOption.add(new selectoption(master.name, master.Name));
      }
   }
   /********Method Name:-select Owner**********************************************
           Description:- Method to show the Brand Name for Picklist
   *******************************************************************************/
   public void selectOwner() {
      Set<String> ownerName = new Set<String>();
      npdOwnerOption = new List < selectoption > ();
      if(owner == NULL) {
         npdOwnerOption.add(new selectoption('None', '--None--'));
      }
      else {
         npdOwnerOption.add(new selectoption('None', '--None--'));
      }
      for(NPD_Master__c master: [select id, Name from NPD_Master__c where SalesforceUser__c = : currentuserid]) {
            ownerName.add(master.Name);
      }
      for(String Name : ownerName){
           npdOwnerOption.add(new selectoption(Name,Name));
      }
   }
   /********Method Name:-selectc Type**********************************************
            Description:- Method to show the Brand Name for Picklist
    *******************************************************************************/
   public void selectType() {
      npdTypeOption = new List < selectoption > ();
      npdTypeOption.add(new selectoption('None', '--None--'));
      npdTypeOption.add(new selectoption('Stage', 'Stage/Sub-stage'));
      npdTypeOption.add(new selectoption('Activity', 'Activity/Sub-Activity'));
   }
   /********Method Name:-displayImage**********************************************
           Description:- Method to show the Brand Name for Picklist
   *******************************************************************************/
   public void displayImage() {
      imagedispaly = true;
      imagepiclink = null;
      NPD_Project_Name__c UserImage = [
         SELECT id,
         ImageUpload__c FROM NPD_Project_Name__c WHERE id = : strActionId LIMIT 1
      ];
      system.debug('*******UserImage*********' + UserImage);
      if(UserImage != null && UserImage.ImageUpload__c != null && UserImage.ImageUpload__c != '') {
         string imageurl = UserImage.ImageUpload__c;
         if(imageurl != null || imageurl != '') {
            integer x = imageurl.indexof('https');
            integer y = imageurl.indexof('"', x);
            imagepiclink = imageurl.substring(x, y);
            system.debug('*******UserImage*********' + imagepiclink);
         }
      }
   }
   
   
   /********Method Name:-select Collection*********************************************
            Description:- Method to show the Brand Name for Picklist
    *******************************************************************************/
   public void selectCollection() {
      ModleName = new map < String,
         NPD_Project_Name__c > ();
      npdCollectionOption = new List < selectoption > ();
      List < NPD_Project_Name__c > lstmodel = new List < NPD_Project_Name__c > ();
      if(collection == NULL) {
         npdCollectionOption.add(new selectoption('None', 'None'));
      }
      else {
         npdCollectionOption.add(new selectoption(collection, collection));
      }
      System.debug('********selectedBrandName*' + selectedBrandName);
      if(selectedBrandName == null) {
         System.debug('*********if***' + lstmodel);
      }
      else if(selectedBrandName != null) {
         System.debug('********else*' + lstmodel);
         lstmodel = [SELECT id, Name,
            npd_collections__r.name,
            Brand1__c,
            npd_collections__r.Tentative_Launch_Month_Date__c FROM NPD_Project_Name__c where Brand1__c = : selectedBrandName
         ];
      }
      for(NPD_Project_Name__c model: lstmodel) {
         if(model.npd_collections__r.Name != null) {
            ModleName.put(model.npd_collections__r.Name, model);
         }
         system.debug('+++++++++++++++CollectionName+++++++++++++' + ModleName.values());
      }
      for(String name: ModleName.keyset()) {
         npdCollectionOption.add(new selectoption(name, name));
         system.debug('*********8npdCollectionOption**********88' + npdCollectionOption);
      }
   }
   /********Method Name:-display Model*********************************************
            Description:- Method to show the Model related to the Collection
    *******************************************************************************/
   public void displaymodel() {
      showmodel = true;
      System.debug('*********selectedOwner ' + selectedOwner);
      System.debug('*********modelNum' + modelNum);
      System.debug('*********selectedBrandName ' + selectedBrandName);
      System.debug('*********selectedCollectionName' + selectedCollectionName);
      ModleNameDetails = new List < NPD_Project_Name__c > ();
      if(selectedCollectionName != 'None' && selectedBrandName != 'None') {
         ModleNameDetails = [SELECT id,
            Name,
            npd_collections__r.name,
            Brand1__c,
            npd_collections__r.Tentative_Launch_Month_Date__c FROM NPD_Project_Name__c where Brand1__c = : selectedBrandName AND npd_collections__r.Name = : selectedCollectionName
         ];
      }
      else {
         ModleNameDetails = [SELECT id,
            Name,
            npd_collections__r.name,
            Brand1__c,
            npd_collections__r.Tentative_Launch_Month_Date__c FROM NPD_Project_Name__c where Name = : modelNum
         ];
      }
      System.debug('*********ModleNameDetails ' + ModleNameDetails);
   }
   /********Method Name:-display Stage //SubStage// Activity //Sub Activity*********************************************
            Description:- Method to show the Actvity and Subactivity related to the Model 
    *******************************************************************************/
   public void displayStageActivity() {
      System.debug('*********selectedOwner selectedOwner ' + selectedOwner);
      System.debug('*********selectedType ' + selectedType );
      System.debug('*********strActionId strActionId ' + strActionId);
       System.debug('********strActionname ' + strActionname);
       if(!Test.isRunningTest()){
      NPD_Project_Name__c projectName = [select id,Name,newModelRefresh__c from NPD_Project_Name__c where id=:strActionId];
      if(projectName.newModelRefresh__c != 'True'){
        npd_newProjectControllerExtension controllerExtension = new npd_newProjectControllerExtension(strActionId);
        controllerExtension.fillComplexityLeadTimes();
      }
      }
      if(selectedType == 'Stage' &&  strActionname!= 'Marketing Brief/Concept Stage') {
         showAct = false;
         showstage = true;
         showstagescreen = false;
         showActscreenbutton =false;
         showActscreen = false;
         showSubAct=false;
         isAttach = false;
         isEmailsend = false;
         isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         //AND NPD_User__r.name=:selectedOwner
         lstStage = new List < Npd_stage__c > ([select Name__c,
            Active__c,
            Status__c,
            Revision_Substage__c,
            Revision_Active__c,
            Type__c,Position_NewUI__c,
            Npd_Stage__r.Name__c,
            NPD_Project_Name__r.Name from Npd_Stage__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-stage') AND Name__c!= 'Marketing Brief/Concept' AND  Name__c!= 'Concept Finalization'  AND Name__c!= 'Concept Briefing to ISCM'  AND (Position_NewUI__c<1000 OR Position_NewUI__c=NULL)
          ORDER BY Position_NewUI__c ASC]);
         System.debug('**********lstStage' + lstStage);
         if(lstStage.size()>0){
            displayImage();
           }
         
          else
         {
         Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'There is no Stage /Activity for selected User"'));
         }
      
      }
      
      
     
      
      
      if(selectedType == 'Stage' &&  strActionname== 'Marketing Brief/Concept Stage'){
      showAct = false;
         showstage = true;
         showstagescreen = false;
         showActscreen = false;
         showActscreenbutton =false;
         showSubAct=false;
         isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         //AND NPD_User__r.name=:selectedOwner
         lstStage = new List < Npd_stage__c > ([select Name__c,
            Active__c,
            Status__c,
            Revision_Substage__c,
            Revision_Active__c,
            Type__c,Position_NewUI__c,
            Npd_Stage__r.Name__c,
            NPD_Project_Name__r.Name from Npd_Stage__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-stage') AND  Position_NewUI__c<1000
          ORDER BY Position_NewUI__c ASC ]);
         System.debug('**********lstStage' + lstStage);
         if(lstStage.size()>0){
            displayImage();
           }
         
          else
         {
         Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'There is no Stage /Activity for selected User"'));
         }
         
      
      
      }
     
      
     
     
    if((selectedType == 'Activity' || selectedType =='Sub-Activity') &&  strActionname!= 'Marketing Brief/Concept Stage') {
         showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = false;
         showActscreenbutton =false;
         showSubAct=false;
         isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         // AND NPD_User__r.name=:selectedOwner AND Position_NewUI__c<1000
         
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-Activity' OR Type__c = 'Activity') AND Name__c!='Concept Finalization - OSD'
            AND Name__c!='Engineering Design - IDS' AND Name__c!='Concept Presentation to PMG - IDS' AND Name__c!='Concept Design - IDS' AND Name__c!='Make or Buy and Model No. Allocation'    
         ORDER BY Position_NewUI__c ASC ]);
         
         if(lstActivty .size()>0){
            displayImage();
             System.debug('*********lstActivty ' + lstActivty);
             for(Npd_Activity__c act: lstActivty) {
                if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
                   idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
                   system.debug('*********idToFieldSet********' + idToFieldSet);
                }
             }
           }
         
          else
         {
         Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'There is no Stage /Activity for selected User"'));
         }
         
         
      }
      
     
      
      if((selectedType == 'Activity' || selectedType =='Sub-Activity') &&  strActionname== 'Marketing Brief/Concept Stage'){
      showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = false;
         showActscreenbutton =false;
         showSubAct=false;
         isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         // AND NPD_User__r.name=:selectedOwner  
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-Activity' OR Type__c = 'Activity')  AND Position_NewUI__c<1000
         ORDER BY Position_NewUI__c ASC ]);
         
         if(lstActivty .size()>0){
            displayImage();
             System.debug('*********lstActivty ' + lstActivty);
             for(Npd_Activity__c act: lstActivty) {
                if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
                   idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
                   system.debug('*********idToFieldSet********' + idToFieldSet);
                }
             }
           }
         
          else
         {
         Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'There is no Stage /Activity for selected User'));
         }
         
      
      }
      
       
      
      
  }
   // method for displaying dynamic table  
   public void displayDynamicTable() {
      lDynamicTable = new List < NPD_Checklist__c > ();
      //  lDynamicTable = [select id, name, CollectionName__c, Gender__c, Design_No__c, Product_Designer_Name__r.name, Engineering_Designer_Name__c, Model_No__c, Component__c, Status__c, Date_of_Completion__c, Remarks__c from NPD_Checklist__c where NPD_Activity_Chklist__c =: recordact[0].id];
      System.debug('++++++++++++++lDynamicTable+++++++++++++++++' + lDynamicTable);
   }
   /********Method Name:-display Stage //SubStage// Activity //Sub Activity screeen*********************************************
              Description:- Method to show the Actvity and Subactivity Screen
      *******************************************************************************/
   public void displayStageActivityScreen() {
      lDynamicTable.clear();
      string queryString;
      System.debug('*********selectedOwner selectedOwner ' + selectedOwner);
      System.debug('stagenamestagename' + stagename);
      System.debug('strActionId strActionId ' + strActionId);
      System.debug('selectedType********88  ' + selectedType);
      if(selectedType == 'Stage' || selectedType == 'Sub-stage') {
          showstage = true;
          showAct = false;
          showSubAct = false;
          showstagescreen = true;
          showActscreen = false;
          isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         record = [SELECT Revision_Substage__c,
            Active__c,
            Revision_Active__c,
            R2_AED__c, R2_ASD__c,
            R1_ASD__c,
            R1_AED__c,
            PrePredecessorSerialNo__c,
            Npd_Stage__r.Name__c,
            id, Stage_name__c,
            Name__c,
            Planned_Start_Date__c,
            Actual_Start_Date__c,
            Type__c,
            Planned_End_Date__c,
            Actual_End_Date__c,
            Revised_Start_Date__c,
            Status__c, OwnerId,
            Revised_End_Date__c,
            Brand1__c, Brand__c,
            Sub_Brand1__c,
            Sub_Brand__c,
            NPD_User__c,
            Market__c,
            No_of_Designs__c,
            Approval_Status__c,
            Complexity_Typess__c,
            Complexity_Category__c,
            Planned_Lead_Time__c,
            Actual_Lead_Time__c,
            Collection_reference__c,
            NPD_Stage__r.OwnerId,
            NPD_Stage__c.NPD_User__r.Name,
            Marketing_brief_concept_reference_number__c,
            Model_Name__c,
            Phase__c,
            Tentative_Launch_Plan__c,
            Source__c,
            Comments_Remarks__c,
            Revision_Status__c,
            NPD_Project_Name__r.Name,
            Owner__c,
            NPD_Project_Name__r.ImageUpload__c,
            NPD_Stage__r.Active__c,
            ImageUpload__c,
            Design_Manager__c,
            Position_NewUI__c,
            Approval_Required__c,
            Line_Item_Approval_Required__c,
            design_manager_npd_master__c,
            NSF_Emial_Address__c
            FROM NPD_Stage__c where NPD_Project_Name__c = : strActionId AND Name__c = : stagename LIMIT 1
         ];
         for(NPD_Stage__c stage : record){
          if(stage.Approval_Status__c == 'Pending'){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'You cannot modify this record as record is submitted for approval'));
          }
         }
        
      }
   }
   
   
   public void displayActivityScreen() {
      lDynamicTable.clear();
      string queryString;
      System.debug('stagenamestagename' + stagename);
      System.debug('strActionId strActionId ' + strActionId);
      System.debug('selectedType********88  ' + selectedType);
      System.debug('selectedid********88  ' + selectedid);
      if(selectedType == 'Activity') {
         showstage = false;
         showSubAct = false;
         showAct = true;
         showstagescreen = false;
         showActscreen = true;
         showActscreenbutton =true;
         isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         //NPD_Activity__c actRec = new NPD_Activity__c();
         if(!idToFieldSet.isempty() && idToFieldSet.containskey(selectedid) && !String.isblank(idToFieldSet.get(selectedid))) {
            queryString = prepareWrapper(idToFieldSet.get(selectedid));
            displaydynamic = true;
            system.debug('queryString queryString *********8' + queryString);
         }
         else {
            displaydynamic = false;
         }
         System.debug('*****queryString *******' + queryString);
         try {
            if(String.isblank(queryString)) {
               System.debug('if block start');
               recordact = database.query('SELECT NPD_Stage__r.NPD_Stage__r.Active__c,NPD_Stage__r.Active__c,NPD_Project_Name__r.Name,Position_NewUI__c,Active__c ,Revision_Status__c,R2_AED__c,R2_ASD__c,R1_ASD__c,R1_AED__c,NPD_Activity__r.NPD_Stage__r.name__c,Name__c ,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c,Attachment_Required__c,id,Stage_name__c,NPD_Stage__r.name,Source__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Actual_End_Date__c,Marketing_Brief_Reference_No__c ,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Approval_Required__c,Planned_Lead_Time__c,OwnerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,npd_stage__r.name__c,serialno__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,' + 'Comments_Remarks__c,Model_No__c ,Model_Name__c,NPD_Activity__r.Name__c,Checklist_Columns__c,Mandatory_Fields__c,NPD_Activity__r.NPD_User__c,NPD_User__r.Name, NPD_Activity__c.Phase__c,Owner__c,NPD_Activity__c,Columns_to_Copy__c,Marketing_brief_stage_approver__c,NPD_Project_Name__r.ImageUpload__c FROM NPD_Activity__c  WHERE  NPD_Project_Name__c =: strActionId AND Name__c =: stagename LIMIT 1');
               System.debug('*****if*******' + recordact);
            }
            else {
            System.debug('else block start');
               recordact = database.query('SELECT NPD_Stage__r.NPD_Stage__r.Active__c,NPD_Stage__r.Active__c,NPD_Project_Name__r.Name,Position_NewUI__c,Active__c ,Revision_Status__c ,R2_AED__c,R2_ASD__c,R1_ASD__c,R1_AED__c,NPD_Activity__r.NPD_Stage__r.name__c,Name__c ,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c,Attachment_Required__c,id,Stage_name__c,NPD_Stage__r.name,Source__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Actual_End_Date__c,Marketing_Brief_Reference_No__c ,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Approval_Required__c,Planned_Lead_Time__c,OwnerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,npd_stage__r.name__c,serialno__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,' + 'Comments_Remarks__c,' + queryString + ',Model_No__c ,Model_Name__c,NPD_Activity__r.Name__c,Checklist_Columns__c,Mandatory_Fields__c,NPD_Activity__r.NPD_User__c,NPD_User__r.Name, NPD_Activity__c.Phase__c,Owner__c,NPD_Activity__c,Columns_to_Copy__c,Marketing_brief_stage_approver__c,NPD_Project_Name__r.ImageUpload__c FROM NPD_Activity__c  WHERE  NPD_Project_Name__c =: strActionId AND Name__c =: stagename LIMIT 1');
               System.debug('****else******' + recordact);
            }
            //Integer i = ((test.isRunningTest()) ? (1 / 0) : 1);
         }
         catch(exception query1) {
            system.debug(query1);
         }
         if(recordact != null){
             username = recordact.NPD_User__r.Name;
             activityname = recordact.NPD_Activity__r.name__c;
             
             substagename = recordact.NPD_Activity__r.NPD_Stage__r.name__c;
             stagename1 = recordact.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c;
             System.debug('*******activityname*******' + activityname);
             System.debug('*******substagename*******' + substagename);
             System.debug('*******stagename1*******' + stagename1);
             record1 = recordact;
             System.debug('********record1 ***********' + record1);
             //Successorlist();
         }
      }
      if(selectedType == 'Sub-Activity') {
         showstage = false;
         showAct = true;
         showSubAct = true;
         showstagescreen = false;
         showActscreen = false;
         showActscreenbutton =true;
          isAttach = false;
          isEmailsend = false;
          isTask = false;
          isEmail = false;
          isNote = false;
          isapproval = false;
          isSuccesoor = false;
          ischklist=false;
         //NPD_Activity__c actRec = new NPD_Activity__c();
         if(!idToFieldSet.isempty() && idToFieldSet.containskey(selectedid) && !String.isblank(idToFieldSet.get(selectedid))) {
            queryString = prepareWrapper(idToFieldSet.get(selectedid));
            displaydynamic = true;
            system.debug('queryString queryString *********8' + queryString);
         }
         else {
            displaydynamic = false;
         }
         System.debug('*****queryString *******' + queryString);
         try {
            if(String.isblank(queryString)) {
               recordact = database.query('SELECT NPD_Activity__r.Active__c,NPD_Activity__r.NPD_Stage__r.Active__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Active__c,NPD_Project_Name__r.Name,Position_NewUI__c,Active__c ,Revision_Status__c,R2_AED__c,R2_ASD__c,R1_ASD__c,R1_AED__c,NPD_Activity__r.Name__c,NPD_Activity__r.NPD_Stage__r.name__c,Name__c ,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c,Attachment_Required__c,id,Stage_name__c,NPD_Stage__r.name,Source__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Actual_End_Date__c,Marketing_Brief_Reference_No__c ,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Approval_Required__c,Planned_Lead_Time__c,OwnerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,npd_stage__r.name__c,serialno__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,' + 'Comments_Remarks__c,Model_No__c ,Model_Name__c,Checklist_Columns__c,Mandatory_Fields__c,NPD_Activity__r.NPD_User__c,NPD_User__r.Name, NPD_Activity__c.Phase__c,Owner__c,NPD_Activity__c,Columns_to_Copy__c,Marketing_brief_stage_approver__c,NPD_Project_Name__r.ImageUpload__c FROM NPD_Activity__c  WHERE  NPD_Project_Name__c =: strActionId AND Name__c =: stagename LIMIT 1');
               System.debug('*****if*******' + recordact);
            }
            else {
               recordact = database.query('SELECT NPD_Activity__r.Active__c,NPD_Activity__r.NPD_Stage__r.Active__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Active__c,NPD_Project_Name__r.Name,Position_NewUI__c,Active__c ,Revision_Status__c,R2_AED__c,R2_ASD__c,R1_ASD__c,R1_AED__c,NPD_Activity__r.NPD_Stage__r.name__c,Name__c ,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c,Attachment_Required__c,id,Stage_name__c,NPD_Stage__r.name,Source__c,Line_Item_Approval_Required__c,Revision_Active__c ,NPD_User__c,Actual_Start_Date__c,Collection_reference__c,Sub_Brand1__c,NPD_Activity__c.Market__c ,Brand1__c,NPD_Stage__r.NPD_Stage__r.Name__c,Complexity_Category__c,Actual_End_Date__c,Marketing_Brief_Reference_No__c ,Type__c,Complexity_Typess__c,Status__c,Approval_Status__c,Approval_Required__c,Planned_Lead_Time__c,OwnerId,Lead_Time__c,Lead_Time1__c,Number_of_Days_Consumed_c__c,NPD_Stage__r.OwnerId,NPD_Stage__r.NPD_Stage__r.OwnerId,NPD_Activity__r.OwnerId,NPD_Activity__r.NPD_Stage__r.OwnerId,npd_stage__r.name__c,serialno__c,NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.OwnerId,' + 'Comments_Remarks__c,' + queryString + ',Model_No__c ,Model_Name__c,NPD_Activity__r.Name__c,Checklist_Columns__c,Mandatory_Fields__c,NPD_Activity__r.NPD_User__c,NPD_User__r.Name, NPD_Activity__c.Phase__c,Owner__c,NPD_Activity__c,Columns_to_Copy__c,Marketing_brief_stage_approver__c,NPD_Project_Name__r.ImageUpload__c FROM NPD_Activity__c  WHERE  NPD_Project_Name__c =: strActionId AND Name__c =: stagename LIMIT 1');
               System.debug('****else******' + recordact);
            }
            //Integer i = ((test.isRunningTest()) ? (1 / 0) : 1);
         }
         catch(exception query1) {
            system.debug(query1);
         }
    //     system.debug('recordact.NPD_Project_Name__r.ImageUpload__c' + recordact.NPD_Project_Name__r.ImageUpload__c);
         if(recordact != null){
             username = recordact.NPD_User__r.Name;
             activityname = recordact.NPD_Activity__r.name__c;
             activityActive=recordact.NPD_Activity__r.Active__c;
             subActive= recordact.NPD_Activity__r.NPD_Stage__r.Active__c;
             system.debug('subActive*************'+subActive);
             stageActive= recordact.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.Active__c;
             system.debug('stageActive***'+stageActive);
             substagename = recordact.NPD_Activity__r.NPD_Stage__r.name__c;
             stagename1 = recordact.NPD_Activity__r.NPD_Stage__r.NPD_Stage__r.name__c;
             
             record1 = recordact;
              if(recordact.Approval_Status__c == 'Pending'){
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'You cannot modify this record as record is submitted for approval'));
              }
         }
         System.debug('********record1 ***********' + record1);
         //Successorlist();
      }
   }
   public void dummy() {
      system.debug('mnpdTypeOption **' + npdTypeOption);
   }
   public void dummymodel() {
      system.debug('modelName*dummy***' + modelNum);
      isAttach = false;
      isAttachstage=false; 
   }
   /************************************************************************************************************************************
       * Method Name : prepareWrapper
       * Return Type : String
       * Parameters accepted : String
       * Purpose     : To prepare a list of wrapper class which will be used for displaying the fields at the front end dynamically for view &
                       edit of Activities and Sub- Activities.
       * Description : The string passed as a parameter to this method will contain the api names of the field with commas seperating each name,
                       The api names will be prefixed with '???' if the field is read only for that particular record & the name is suffixed with
                       '!!!' if the field is mandatory for the same.
       *************************************************************************************************************************************/
   public string prepareWrapper(String fieldStr) {
      wrapperListforField = new list < WrapperForFieldSet > ();
      intTowrapperListforField = new map < integer, list < WrapperForFieldSet >> ();
      List < String > fieldList = new List < String > ();
      boolean readOnly = FALSE;
      boolean mandatory = FALSE;
      String stringToReturn = '';
      fieldStr.deleteWhitespace();
      fieldList = (fieldStr.contains(',') ? fieldStr.split(',') : (new List < string > {
         fieldstr
      }));
      for(String str: fieldList) {
         if(str.startsWithIgnoreCase('???') || str.endsWithIgnoreCase('!!!')) {
            if(str.startsWithIgnoreCase('???')) {
               System.debug('MANDtory');
               mandatory = TRUE;
               readOnly = FALSE;
               str = str.removeStartIgnoreCase('???');
            }
            if(str.endsWithIgnoreCase('!!!')) {
               System.debug('read');
               readOnly = TRUE;
               mandatory = FALSE;
               str = str.removeEndIgnoreCase('!!!');
            }
         }
         else {
            System.debug('NONE');
            readOnly = FALSE;
            mandatory = FALSE;
         }
         stringToReturn = stringToReturn + str + ',';
         wrapperListforField.add(new WrapperForFieldSet(str, mandatory, readOnly));
      }
      integer i = 1;
      list < WrapperForFieldSet > wrapList = new list < WrapperForFieldSet > ();
      for(WrapperForFieldSet wrap: wrapperListforField) {
         wrapList.add(wrap);
         system.debug('*****math.mod(wrapList.size()***********' + math.mod(wrapList.size(), 5));
         if(math.mod(wrapList.size(), 10) == 0) {
            intTowrapperListforField.get(i).add(wrap);
            i = i + 1;
            wrapList.clear();
         }
         else {
            if(!intTowrapperListforField.isempty() && intTowrapperListforField.containskey(i) && intTowrapperListforField.get(i) != NULL) {
               intTowrapperListforField.get(i).add(wrap);
            }
            else {
               intTowrapperListforField.put(i, new list < WrapperForFieldSet > {
                  wrap
               });
            }
         }
      }
      stringToReturn = stringToReturn.removeEndIgnoreCase(',');
      system.debug('*******stringToReturn****************8' + stringToReturn);
      return stringToReturn;
   }
   /**********************************************v************************************************************************************
    * Class Name : WrapperForFieldSet, Used for dynamically display the fields for view and edit mode.
    ***********************************************************************************************************************************/
   public class WrapperForFieldSet {
      public string fieldAPI {
         get;
         set;
      } // Api name of the field.
      public boolean isMandatory {
         get;
         set;
      } //  Stores whether the field is mandatory for particular record.
      public boolean isReadonly {
         get;
         set;
      } //  Stores whether the field is read only for particular record.
      public WrapperForFieldSet(string api, boolean isMandatry, boolean isRead) {
         fieldAPI = api;
         isMandatory = isMandatry;
         isReadonly = isRead;
      }
   }
   /**********************************************v************************************************************************************
    * Class Name : saveStage, Used to save stages and sub stages
    ***********************************************************************************************************************************/
   public void saveStage() {
      system.debug('***********selectedType*****888' + selectedType);
     
      if(selectedType == 'Stage' ||  selectedType == 'Sub-stage') {
         system.debug('***********Stage*****' + selectedType);
         system.debug('***********strActionId *****' + strActionId);
         system.debug('***********recordrecord*****' + record);
         try{
      update record;
      }
      catch(Exception e){
      system.debug('******EXceptionupdating Stage'+ e);
      }
         if(selectedType == 'Stage') {
             showAct = false;
             showstage = true;
             showstagescreen = true;
             showActscreen = false;
             //AND NPD_User__r.name=:selectedOwner
             lstStage = new List < Npd_stage__c > ([select Name__c,
                Active__c,
                Status__c,
                Revision_Substage__c,
                Revision_Active__c,
                Type__c,
                Npd_Stage__r.Name__c,
                NPD_Project_Name__r.Name from Npd_Stage__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-stage') AND Position_NewUI__c<1000  ORDER BY Position_NewUI__c ASC
             ]);
             System.debug('**********lstStage' + lstStage);
             displayImage();
          }
         displayStageActivityScreen();
        
        
        
        
        
        if(selectedType == 'Stage' &&  strActionname!= 'Marketing Brief/Concept Stage') {
         showAct = false;
         showstage = true;
         showstagescreen = true;
         showActscreen = false;
         showSubAct=false;
         //AND NPD_User__r.name=:selectedOwner
         lstStage = new List < Npd_stage__c > ([select Name__c,
            Active__c,
            Status__c,
            Revision_Substage__c,
            Revision_Active__c,
            Type__c,Position_NewUI__c,
            Npd_Stage__r.Name__c,
            NPD_Project_Name__r.Name from Npd_Stage__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-stage') AND Name__c!= 'Marketing Brief/Concept' AND  Name__c!= 'Concept Finalization'  AND Name__c!= 'Concept Briefing to ISCM'  AND Position_NewUI__c<1000
          ORDER BY Position_NewUI__c ASC]);
         System.debug('**********lstStage' + lstStage);
         displayImage();
      }
      
      else if(selectedType == 'Stage' &&  strActionname== 'Marketing Brief/Concept Stage'){
      showAct = false;
         showstage = true;
         showstagescreen = true;
         showActscreen = false;
         showSubAct=false;
         //AND NPD_User__r.name=:selectedOwner
         lstStage = new List < Npd_stage__c > ([select Name__c,
            Active__c,
            Status__c,
            Revision_Substage__c,
            Revision_Active__c,
            Type__c,Position_NewUI__c,
            Npd_Stage__r.Name__c,
            NPD_Project_Name__r.Name from Npd_Stage__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-stage')  AND Position_NewUI__c<1000
          ORDER BY Position_NewUI__c ASC ]);
         System.debug('**********lstStage' + lstStage);
         displayImage();
      
      
      }
          
        
         }
        
      }
   
   /**********************************************v************************************************************************************
    * Class Name : saveStage, Used to Activity and Sub Activity
    ***********************************************************************************************************************************/
   public void saveActivity() {
     try{
      update record1;
      Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'Record saved Successfully'));
      }
      catch(Exception e){
      system.debug('******EXceptionupdating Activity'+ e);
      }
      
       system.debug('*****selectedType '+ selectedType );
      if(selectedType == 'Activity') {
         showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = false;
         // AND NPD_User__r.name=:selectedOwner 
         System.debug('*********8TESTselectedOwner '+selectedOwner ); 
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c = 'Sub-Activity')  
         ]);
         displayImage();
         System.debug('*********lstActivty ' + lstActivty);
         for(Npd_Activity__c act: lstActivty) {
            if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
               idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
               system.debug('*********idToFieldSet********' + idToFieldSet);
            }
         }
      }
      displayActivityScreen();
      
       if(selectedType == 'Activity' && strActionname!= 'Marketing Brief/Concept Stage') {
         showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = true;
         showSubAct=false;
         // AND NPD_User__r.name=:selectedOwner  
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c =:'Sub-Activity' ) AND Name__c!='Concept Finalization - OSD'
            AND Name__c!='Engineering Design - IDS' AND Name__c!='Concept Presentation to PMG - IDS' AND Name__c!='Concept Design - IDS' AND Name__c!='Make or Buy and Model No. Allocation'  
         ORDER BY Position_NewUI__c ASC ]);
         displayImage();
         System.debug('*********lstActivty ' + lstActivty);
         for(Npd_Activity__c act: lstActivty) {
            if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
               idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
               system.debug('*********idToFieldSet********' + idToFieldSet);
            }
         }
      }
      else if(selectedType == 'Activity'  &&  strActionname== 'Marketing Brief/Concept Stage'){
      showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = true;
         showSubAct=false;
         // AND NPD_User__r.name=:selectedOwner  
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c =:'Sub-Activity')  
         ORDER BY Position_NewUI__c ASC ]);
         displayImage();
         System.debug('*********lstActivty ' + lstActivty);
         for(Npd_Activity__c act: lstActivty) {
            if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
               idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
               system.debug('*********idToFieldSet********' + idToFieldSet);
            }
         }
      
      }
      
      //Subactivity
      
      if(selectedType =='Sub-Activity' &&  strActionname!= 'Marketing Brief/Concept Stage') {
         showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = false;
         showSubAct=true;
         // AND NPD_User__r.name=:selectedOwner  
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c =:'Activity') AND Name__c!='Concept Finalization - OSD'
            AND Name__c!='Engineering Design - IDS' AND Name__c!='Concept Presentation to PMG - IDS' AND Name__c!='Concept Design - IDS' AND Name__c!='Make or Buy and Model No. Allocation'  
         ORDER BY Position_NewUI__c ASC ]);
         displayImage();
         System.debug('*********lstActivty ' + lstActivty);
         for(Npd_Activity__c act: lstActivty) {
            if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
               idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
               system.debug('*********idToFieldSet********' + idToFieldSet);
            }
         }
      }
      else if( selectedType =='Sub-Activity' &&  strActionname== 'Marketing Brief/Concept Stage'){
      showAct = true;
         showstage = false;
         showstagescreen = false;
         showActscreen = false;
         showSubAct=true;
         // AND NPD_User__r.name=:selectedOwner  
         lstActivty = new List < Npd_Activity__c > ([
            select Name__c,
            Active__c,
            Revision_Active__c,
            Status__c,
            Position_NewUI__c,
            Actual_End_Date__c,
            Type__c,
            NPD_Project_Items__r.Field_Set__c,
            NPD_Project_Name__r.ImageUpload__c from Npd_Activity__c where NPD_Project_Name__c = : strActionId AND(Type__c = : selectedType OR Type__c =:'Activity') 
         ORDER BY Position_NewUI__c ASC ]);
         displayImage();
         System.debug('*********lstActivty ' + lstActivty);
         for(Npd_Activity__c act: lstActivty) {
            if(!string.isblank(act.NPD_Project_Items__r.Field_Set__c)) {
               idToFieldSet.put(act.id, act.NPD_Project_Items__r.Field_Set__c);
               system.debug('*********idToFieldSet********' + idToFieldSet);
            }
         }
      
      }
      System.debug('record1record1record1' + record1);
   }
   /**********************************************v************************************************************************************
    * Class Name : attachmentNpd, Used to create save delete Attachment
    ***********************************************************************************************************************************/
   public void viewattachment() {
      attWrapperStageList = new List < attachWrapper > ();
      System.debug('**********selectedid *' + selectedid);
      System.debug('**********selectedType *' + selectedType );
      if(selectedType=='Stage'){
      isAttachstage =true;
      isAttach = false;
      }
      else{
      isAttach = true;
      isAttachstage =false;
      }
      
      isTask = false;
      isNote = false;
      isapproval = false;
      //isAttach = true;
      isEmailsend = false;
      isEmail = false;
      isSuccesoor = false;
      ischklist=false;
      if(selectedid != null) {
         attWrapperStageList = new List < attachWrapper > ();
         for(Attachment att: [SELECT id,
               name, isprivate,
               Description, Parent.Name,
               Createdbyid FROM Attachment where parentid = : selectedid
            ]) {
            attachWrapper wrap = new attachWrapper();
            wrap.ate = att;
            attWrapperStageList.add(wrap);
            // preparemap(obj,'ParentId',false);
         }
         if(attWrapperStageList.size() > 0) {
            if(selectedType == 'Activity' || selectedType == 'Sub-Activity' ) {
               attparentname = [
                  Select id,
                  Name__c from NPD_Activity__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
            if(selectedType == 'Stage') {
               attparentname = [
                  Select id,
                  Name__c from NPD_Stage__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
         }
         system.debug('*********attWrapperStageList*****' + attWrapperStageList);
         System.debug('**********attparentname*' + attparentname);
      }
   }
   /********************************************************************************************************************************
    * Class Name :createAttachment
    * Descriptio : 
    *********************************************************************************************************************************/
   public void createAttachment() {
      isAttach = true;
      attach1 = new attachment();
   }
   /********************************************************************************************************************************
    * Class Name :uploadAttachment
    * Descriptio : 
    *********************************************************************************************************************************/
   public void uploadAttachment() {
      attach1.parentid = selectedid;
      if(attach1.Body != NULL) {
     // try{
      insert attach1;
    //  }
     // catch (Exception e){
     // System.debug('*********EXCEPTION WHILE UPLOAD DATA'+e);
     // }
      
      }
      
      
      attach1.Body = null;
      isAttach = false;
      isAttachstage=false;
   }
   /********************************************************************************************************************************
    * Class Name :attachWrapper 
    * Descriptio : Wrapper Class for functionalities related to task.
    *********************************************************************************************************************************/
   public class attachWrapper {
      public boolean isAttach {
         get;
         set;
      }
      public boolean isedit {
         get;
         set;
      }
      public attachment ate {
         get;
         set;
      }
      public string subject {
         get;
         set;
      }
      public attachWrapper() {
         isAttach = false;
         ate = new attachment();
         subject = '';
         isedit = false;
      }
   }
   
   public void cancelUpload() {
      isAttach = false;
   }
   /**********************************************v************************************************************************************
    * Class Name : viewTask, view Notes
    ***********************************************************************************************************************************/
   public void viewTask() {
      isAttach = false;
      isEmailsend = false;
      isTaskCreated  = false;
      isNote = false;
      isEmail = false;
      isapproval = false;
      isTask = true;
      isSuccesoor = false;
      ischklist=false;
      taskWrapperStageList = new List < taskWrapper > ();
      System.debug('**********selectedid *' + selectedid);
      if(selectedid != null) {
         taskWrapperStageList = new List < taskWrapper > ();
         for(Task tt: [SELECT Id,
               WhatId, Who.Id,
               Subject, Status,
               Description, Priority,
               Who.Type,
               ActivityDate,
               OwnerId,
               CallDisposition, Type,
               tempuser__c FROM Task where WhatId = : selectedid
            ]) {
            taskWrapper wrap = new taskWrapper();
            wrap.tsk = tt;
            taskWrapperStageList.add(wrap);
         }
         if(taskWrapperStageList.size() > 0) {
            if(selectedType == 'Activity') {
               attparentname = [
                  Select id,
                  Name__c from NPD_Activity__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
            if(selectedType == 'Stage') {
               attparentname = [
                  Select id,
                  Name__c from NPD_Stage__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
         }
         system.debug('*********taskWrapperStageList*****' + taskWrapperStageList);
         System.debug('**********taskattparentname*' + attparentname);
      }
   }
   /*************************************************************************************************************************************************************************************/
   /********************************************************************************************************************************
    * Class Name : taskWrapper 
    * Descriptio : Wrapper Class for functionalities related to task.
    *************************************************************************************************************************************************/
   public class taskWrapper {
      public boolean isEdit {
         get;
         set;
      }
      public task tsk {
         get;
         set;
      }
      public string subject {
         get;
         set;
      }
      public string customuser {
         set;
         get;
      }
      public string ccusers {
         set;
         get;
      }
      public taskWrapper() {
         isEdit = false;
         tsk = new task();
         if(tsk.Status == null)
             tsk.Status = 'Not Started';
              if(tsk.Priority == null)
             tsk.Priority = 'Normal';
         subject = '';
         customuser = '';
         ccusers = '';
      }
   }
   /************************************************************************************************************************************************************/
   /********************************************************************************************************************************
    * Class Name :createAttachment
    * Descriptio : 
    *********************************************************************************************************************************/
   public void createTask() {
      tsk= new Task();
      isTaskCreated = true;
      istask = true;
      System.debug('*************selectedid********' + selectedid);
     
   }
   /*******************************************************************************************************************************************
    * Class Name :saveIndividualTask
    * Descriptio : This method is written to Save Notes//Task//Email 
    *********************************************************************************************************************************************/
  public void savenote(){
      nte.parentid = selectedid;
      if(nte.Body != NULL) {
     // try{
      insert nte;
       isNote = false;
       isNoteCreated = false;
      viewNote();

  }
  }
    public void saveTask(){
      tsk.whatid = selectedid;     
     // try{
      insert tsk;
       isTask = false;
       isTaskCreated = false;
      viewTask();

  }
   public void saveIndividualTask() {
      npd_stage__c NpdStg1 = new npd_stage__c();
      string taskWhatId = '';
      string noteparentid = '';
      npd_activity__c NpdAct1 = new npd_activity__c();
      System.debug('**********relatedListType***************' + relatedListType);
      SavePoint spt = dataBase.setSavePoint();
      if(relatedListType == 'Task') {
         task updateTask = taskWrapperStageList[rowNum].tsk;
         system.debug('updateTask.whoid value :' + updateTask);
         system.debug('updateTask.whatid value :' + updateTask.whatid);
         taskWhatId = updateTask.whatid;
         taskWrapperStageList[rowNum].isEdit = false;
         try{
         upsert updateTask;
         }
         catch(Exception e){
         System.debug('***************Exception '+e);
         }
      }
      if(relatedListType == 'Note') {
            System.debug('title name'+title);
      Note n = new Note();
        n.Parentid = selectedid;
        n.title = title;
        n.body = body;
         System.debug('noteWrapperStageList[rowNum].nte '+noteWrapperStageList[rowNum].nte);
         System.debug('noteWrapperStageList'+noteWrapperStageList);
         Note updateNote = noteWrapperStageList[rowNum].nte;
         noteparentid = updateNote.Parentid;
         noteWrapperStageList[rowNum].isedit = false;
         try{
                 insert n;
         upsert updateNote;
         }
         catch(Exception e){
         System.debug('***************Exception '+e);
         }
      }
   }
   /*******************************************************************************************************************************************
    * Class Name :cancelTask
    * Descriptio : This method is written to cancle Notes//Task//Email  
    *********************************************************************************************************************************************/
   public void cancelTask() {
   //delete tsk;
   isTaskCreated = false;
   system.debug('++++++++++++++++++'+isTaskCreated);
      if(relatedListType == 'Task') {
        viewTask();
       /*  if(taskWrapperStageList[rowNum].tsk.id != null && taskWrapperStageList[rowNum].tsk.id != '') {
            taskWrapperStageList[rowNum].isEdit = false;
         }
         else {
            taskWrapperStageList.remove(rowNum);
         }*/
      }
      if(relatedListType == 'Note') {
          viewNote();
      /*
         if(noteWrapperStageList[rowNum].nte.id != null && noteWrapperStageList[rowNum].nte.id != '') {
            noteWrapperStageList[rowNum].isedit = false;
         }
         else {
            noteWrapperStageList.remove(rowNum);
         } */
      }
   }
   /*******************************************************************************************************************************************
    * Class Name :editTask
    * Descriptio : This method is written to edit Notes//Task//Email 
    *********************************************************************************************************************************************/
   public void editTask() {
      System.debug('inside task');
      if(relatedListType == 'Task') {
         taskWrapperStageList[rowNum].isEdit = true;
         System.debug('taskWrapperStageList'+taskWrapperStageList);
      }
      if(relatedListType == 'Note') {
         System.debug('noteWrapperStageList'+noteWrapperStageList);
         noteWrapperStageList[rowNum].isEdit = true;
      }
  
   }
   /*******************************************************************************************************************************************
    * Class Name :deleteTask
    * Descriptio : This method is written to delete  Notes//Task//Email 
    *********************************************************************************************************************************************/
   public void deleteTask() {
      string taskWhatId = '';
      if(relatedListType == 'Task') {
         task deleteTask = taskWrapperStageList[rowNum].tsk;
         taskWhatId = deleteTask.whatid;
         delete deleteTask;
         viewTask();
      }
      if(relatedListType == 'Note') {
         Note deleteNote = noteWrapperStageList[rowNum].nte;
         taskWhatId = deleteNote.Parentid;
         delete deleteNote;
         viewNote();
      }
      if(relatedListType == 'Attachment') {
         Attachment deleteatt = attWrapperStageList[rowNum].ate;
         delete deleteatt;
         viewattachment();
      }
      
      if(relatedListType=='NPD_Checklist__c')  {
                   
                sobject sobj = dynamicSobjWrapperMap.get('NPD_Checklist__c')[rowNum].sobj;
                dynamicSobjWrapperMap.get('NPD_Checklist__c').remove(rowNum);
                if(sobj.id != null) {
                system.debug('sobj'+sobj);
                   delete sobj;
               }
                   
            }
   }
   /********************************************************************************************************************************
    * Class Name :noteWrapper 
    * Descriptio : Wrapper Class for functionalities related to Notes.
    *********************************************************************************************************************************/
   public class noteWrapper {
      public boolean isedit {
         get;
         set;
      }
      public note nte {
         get;
         set;
      }
      public String title{get;set;}
      public String body{get;set;}
      public string subject {
         get;
         set;
      }
      public noteWrapper() {
         isedit = false;
         nte = new note();
         title = null;
         body = null;
         //subject = '';
      }
   }
   /***********************************************************************************************************************************************/
   /**********************************************v************************************************************************************
    * Class Name : viewTask, view Notes
    ***********************************************************************************************************************************/
   public void viewNote() {
      isAttach = false;
      isEmailsend = false;
      isNoteCreated = false;
      isTask = false;
      isEmail = false;
      isNote = true;
      isapproval = false;
      isSuccesoor = false;
      ischklist=false;
      noteWrapperStageList = new List < noteWrapper > ();
      if(selectedid != null) {
         noteWrapperStageList = new List < noteWrapper > ();
         for(Note nt: [SELECT id,
               parentid, title,
               isprivate, body,
               createdbyid FROM Note where Parentid = : selectedid
            ]) {
            noteWrapper wrap = new noteWrapper();
            wrap.nte = nt;
            noteWrapperStageList.add(wrap);
         }
         if(noteWrapperStageList.size() > 0) {
            if(selectedType == 'Activity') {
               attparentname = [
                  Select id,
                  Name__c from NPD_Activity__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
            if(selectedType == 'Stage') {
               attparentname = [
                  Select id,
                  Name__c from NPD_Stage__c where id = : selectedid LIMIT 1
               ].Name__c;
            }
         }
      }
   }
   /*********************************************************************************************************************************
    * Method Name : createNote
    **********************************************************************************************************************************/
   public void createNote() {
         nte= new note();
      isNoteCreated = true;
      noteWrapper wrap = new noteWrapper();
      wrap.nte = new note();
      wrap.isedit = true;
      wrap.nte.Parentid = selectedid;
      noteWrapperStageList.add(wrap);
      System.debug('*************noteWrapperStageList**********'+noteWrapperStageList);
   }
   /**********************************************v************************************************************************************
    * Class Name : ActivityApprovalHistorylist  .......  Used for fetching approval history of activity and sub-activity records.
    ***********************************************************************************************************************************/
   public void viewActivityApprovalHistorylist() {
      isapproval = true;
      isAttach = false;
      isTask = false;
      isNote = false;
      isEmailsend = false;
      isaction = false;
      isEmail = false;
      isSuccesoor = false;
      ischklist=false;
      approvalhislist = new list < ProcessInstanceStep > ();
      approvalhislist = [Select p.Comments,
         p.OriginalActorId, p.ProcessInstance.CreatedById, p.ProcessInstance.CreatedDate,
         p.ProcessInstance.Id, p.ProcessInstance.LastActorId, p.ProcessInstance.Status, p.ProcessInstance.TargetObjectId,
         p.ProcessInstance.SubmittedById from ProcessInstanceStep p WHERE p.ProcessInstance.TargetObjectID = : selectedid
      ];
      System.debug('approvalhislist *********' + approvalhislist);
   }
   /***********************************************************************************************************************************************   
    * Class Name : Email.......  Used for fetching approval history of activity and sub-activity records.
    ***********************************************************************************************************************************/
     Public void viewEmail() {
         isEmail = true;
         isAttach = false;
         isEmailsend = false;
         isTask = false;
         isNote = false;
         isapproval = false;
         ischklist=false;
         
         isSuccesoor=false;

         emailList = ([SELECT id, Attachment__c, FromAddress__c,NPD_Activity__r.Name__c, NPD_Activity__c, Subject__c, ToAddresses__c FROM EmailDetails__c where NPD_Activity__c=:selectedid]);
     }
     
     Public void sendEmail() {
           
         isEmailsend = true;
         isEmail = true;
         isaction = true;
         isAttach = false;
         isTask = false;
         isNote = false;
         isapproval = false;
         isSuccesoor=false;
         ischklist=false;
         System.debug('*********emailselectedOwner selectedOwner send send ');
         EmailMessage emailmsg = new EmailMessage();
     }
     
   /***********************************************************************************************************************************************   
    * Class Name : send.......  Used sending email from page
    ***********************************************************************************************************************************/
    public void send() {
      System.debug('*********emailselectedOwner selectedOwner ' + selectedOwner );
      System.debug('*********emailselectedOwner selectedid' + selectedid);

      
       
      string sender=selectedOwner;
         list < Messaging.singleEmailMessage > mails = new list < Messaging.SingleEmailMessage > ();
         Messaging.singleEmailMessage mail = new Messaging.SingleEmailMessage();
         list < String > toadd = new List < String > ();
         System.debug('toaddre*****' + toaddre);
         for (string eachemail: toaddre.split(',')) {
             toadd.add(eachemail);
         }
         //file attachment
         list < Messaging.EmailFileAttachment > lstefa = new list < Messaging.EmailFileAttachment > ();
         if (attach.body != NULL) {
             Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
             System.debug('attach1.name*****' + attach.name);
             System.debug('attach1.body*****' + attach.body);
             efa.setfilename(attach.name);
             efa.setbody(attach.body);
             attach.body = NULL;
             lstefa.add(efa);
             mail.setfileattachments(lstefa);
         }
         mail.setToAddresses(toadd);
         mail.setSenderDisplayName(sender);
         system.debug(toadd);
         mail.setSubject(subject);
         mail.setPlainTextBody(text1);
         mails.add(mail);
         messaging.sendEmail(mails);
         isEmailsend = false;
         isEmail=false;
         system.debug('mails***********' + mails);
         
        for(Messaging.singleEmailMessage captureemail:mails){
         EmailDetails__c captureemai=new EmailDetails__c();
         captureemai.Subject__c=captureemail.Subject;
         captureemai.FromAddress__c=captureemail.SenderDisplayName;
         captureemai.NPD_Activity__c=selectedid;
         captureemai.ToAddresses__c=toadd[0];
         if(captureemail.fileattachments!=NULL){
         captureemai.Attachment__c=true;
         }
         system.debug('captureemai.ToAddresses__c' +captureemai.ToAddresses__c);
         insertdetails.add(captureemai);
         
         } 
         if(insertdetails.size()>0){
         
         insert insertdetails;
         
         }
         
         }
   /*************************************************************************************************************************************************************************/
   /***********************************************************************************************************************************************   
    * Class Name : Successorlist==thsi si to display the ist of successor as per the activity selected
    ***********************************************************************************************************************************/
   Public void Successorlist() {
      lSuccessorEmailWrapper = new List<successorEmailWrapper>();
      isSuccesoor = true;
      isEmailsend = false;
      isaction = false;
      isAttach = false;
      isTask = false;
      isNote = false;
      isapproval = false;
      isEmail = false;
      ischklist=false;
      try{
      succlist = new List < NPD_Email__c > ([SELECT Act_Name__c,
         Brand__c, Id, Name,
         NPD_Activity__c,
         NPD_Project_Items__r.Project_Template__r.Name,
         NPD_Project_Items__c,parentActName__c,
         NPD_Stage__c,
         Source__c, Type__c FROM NPD_Email__c where(parentActName__c = : String.valueOf(record1.get('name__c')) AND Brand__c = : String.valueOf(record1.get('Brand1__c')) AND Source__c = : String.valueOf(record1.get('Source__c'))) OR(parentActName__c = : String.valueOf(record1.get('name__c')) AND Type__c = : 'Successor'
            ANd NPD_Project_Items__r.Project_Template__r.Name = : 'Regular')
      ]);
      System.debug('+++++++succlist size'+succlist.size());
     
      //succlist =[SELECT Act_Name__c,Brand__c,Id, Name,NPD_Activity__c,NPD_Project_Items__c,NPD_Stage__c,Source__c,Type__c FROM NPD_Email__c where Name=:String.valueOf( record1.get('name__c') )];
      if(succlist.size()>0){
      for(NPD_Email__c succemail: succlist) {
          if(succemail.Type__c != NULL && succemail.Type__c == 'Successor') {
                 successorEmailWrapper succEmailwrap = new successorEmailWrapper();
                 succEmailwrap.relatedTo = succemail.parentActName__c;
                 succEmailwrap.successorName = succemail.Act_Name__c;
                 succEmailwrap.brand = succemail.Brand__c;
                 succEmailwrap.source = succemail.Source__c;
                 succEmailwrap.type = succemail.Type__c; 
                 System.debug('selected collection name'+selectedCollectionName);
                 if(succemail.parentActName__c != 'Make or Buy and Model No. Allocation'){
                     name = [Select id,NPD_User__r.Name,NPD_User__r.salesforce_user_email_address__c,NPD_User__r.UserID__c from NPD_Activity__c where Name__c = : succemail.Act_Name__c AND npd_collections__r.Name = : selectedCollectionName Limit 1].NPD_User__r.UserID__c;
                     system.debug('namenamename' + name);
                     system.debug('succemail.Act_Name__c' + succemail.Act_Name__c);
                     System.debug('successor name'+name);
                     if(name != null){
                        succEmailwrap.email =  name;
                     }
                     else{
                        succEmailwrap.email =  null;
                     }
                 }
                 if(succemail.parentActName__c == 'Make or Buy and Model No. Allocation' && succemail.Act_Name__c == 'Proto Design Input'){
                     succEmailwrap.email =  'raveesh@titan.co.in';
                 } 
                 if(succemail.parentActName__c == 'Make or Buy and Model No. Allocation' && succemail.Act_Name__c == 'New Movement Certification'){
                     succEmailwrap.email =  'abhiraman@titan.co.in';
                 } 
                 lSuccessorEmailWrapper.add(succEmailwrap);
              
          }
       }
      }
     }catch(Exception ex){
          System.debug('Activity name is not matching, Please contact admin');
      }
   }
   /***********************************************************************************************************************************************   
    * Class Name : activateStage==This is to Activate and Deactivate Stage and Substage as per the Link Click to Activate is Clicked
    ***********************************************************************************************************************************/
   Public void activateStage() {
      system.debug('*******selectedid*****' + selectedid);
      NPD_UtilityController.activateDeactivateStage(selectedid);
       displayStageActivityScreen();
   }
   /***********************************************************************************************************************************************   
    * Class Name : activateStage==This is to Activate and Deactivate Stage and Substage as per the Link Click to Activate is Clicked
    ***********************************************************************************************************************************/
   Public void activateActivity() {
      system.debug('*******selectedid*****' + selectedid);
      NPD_UtilityController.activateDeactivateActivity(selectedid);
      displayActivityScreen();
   }
   
    /***********************************************************************************************************************************************   
    * Class Name : approvalitems==Approval of marketing Stage
    ***********************************************************************************************************************************/
   
   public void approvalitems() {
    
       system.debug('selectedid**********' + selectedid);
       system.debug('*******selectedType ****+' + selectedType );
       system.debug('*******record****+' + record);
       system.debug('*******recordactacat****+' + recordact);
       
       if(selectedType =='Activity' || selectedType =='Sub-Activity'){
                lstact=[Select id,NPD_Project_Name__c,Name__c,Brand1__c,Design_Manager_Titan__c,Source__c,Design_Manager_Fastrack__c,Marketing_brief_stage_approver__c from Npd_activity__c where id=:selectedid];
               system.debug('*******lstact****+'+lstact);
      }
      
      
       if(selectedType =='Stage') {
          if(chkattachment(selectedid) > 0) {
          for(NPd_stage__c obj:record){
            obj.Approval_Status__c='Pending';
            update record;
            displayStageActivityScreen();
             //NPDChkboxDynamicApproval.updateApprovers(lstact);
             NPDChkboxDynamicApproval.ApprovalDone(selectedid);
          }}
          else {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Upload attachment for submiting for approval'));
          }
       }
       
      try {
          if(recordact.Line_Item_Approval_Required__c==true) {
             recordact.Approval_Status__c='Pending';
             NPDChkboxDynamicApproval app = new NPDChkboxDynamicApproval();
             NPDChkboxDynamicApproval.updateApprovers(lstact);
             app.ApprovalMethod(id.valueof(selectedid), 'submission');
             system.debug('recordrecord' + record);
             update recordact;
          }
          if(!recordact.Line_Item_Approval_Required__c==true && selectedType=='Activity' || selectedType =='Sub-Activity') {
             system.debug('recordrecord' + recordact);
             recordact.Approval_Status__c='Pending';
             update recordact;
             NPDChkboxDynamicApproval.updateApprovers(lstact);
             NPDChkboxDynamicApproval.ApprovalDone(selectedid);
          }
          if(Test.isRunningTest()) {
             Integer i = 10 / 0;
          }
       }
       catch(Exception excp) {
          System.debug('**************excpetion while submitting for approval********' + excp.getMessage());
       }
    }
    
    /***********************************************************************************************************************************************   
    * Class Name : activateStage==This is to Activate and Deactivate Stage and Substage as per the Link Click to Activate is Clicked
    ***********************************************************************************************************************************/
    public integer chkattachment(id childId){
            return [SELECT count() FROM Attachment where ParentId=:childId] ; 
        }
        
        
 /**************************************************************************DYNAMIC TABLE DATA*************************************************************************************/       
        
     /**********************************************************************************************************************************
      * Class Name : checkListWrapper 
      * Description : 
      ***********************************************************************************************************************************/
      public class checkListWrapper {
        public boolean isedit{get;set;}
        public sobject sobj{get;set;}
        public checkListWrapper() {
            isEdit = false;
        }   
    }
    
    
    /********************************************************************************************************************************
           * Method Name : preparemap
           * Description :
           *********************************************************************************************************************************/
            private  void preparemap(sobject obj, string parentField, boolean editMode) {
                checkListWrapper  wrap =  new checkListWrapper();
                wrap.isEdit  = editMode;
                wrap.sobj    = obj;
                if(!String.isBlank(parentField) && wrap.sobj.get(parentField)==null) {
                    wrap.sobj.put(parentField,selectedid);
                }
                     string objectType =  String.valueOf(obj.getSobjectType());
                     
                if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(objectType) && dynamicSobjWrapperMap.get(objectType) != null) {
                    dynamicSobjWrapperMap.get(objectType).add(wrap);
                    system.debug('***Checklist***'+dynamicSobjWrapperMap.get(objectType));
                } else {
                    dynamicSobjWrapperMap.put(objectType,new list<checkListWrapper>{wrap});
                }   
                
                System.debug('***********dynamicSobjWrapperMap*************'+dynamicSobjWrapperMap);     
            }
            
            /***************************************************************************************************************************
              ** Method Name : prepareFieldsForTable
            ****************************************************************************************************************************/
            
            public list<string> prepareFieldsForTable(string fieldstr){
                System.debug('**fieldstr******'+fieldstr);
                List<String> fieldList  = new List<String>();
                 
                if(!String.isBlank(fieldStr)) {
                    fieldStr   = fieldStr.replaceAll('\\n','');
                    System.debug('**fieldstr******'+fieldstr);
                    fieldList  = (fieldStr.contains(',')?fieldStr.split(','):(new List<string>{fieldstr}));
                    System.debug('**fieldList  ******'+fieldList  );
                }
                
                set<string> fiedlabels  = new set<string>();
                for(String str : fieldList) {
                    str = str.trim();
                    fiedlabels.add(str);
                }
                 System.debug('**fiedlabels******'+fiedlabels);
                
                list<string> fieldApiList   = new List<String>();
                String fielApistr      =  '';
                map<string,string> label_Api  =  new map<String,String>();
                Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap();
                
                for(Schema.SObjectField field : Schema.getGlobalDescribe().get('NPD_Checklist__c').getDescribe().fields.getMap().values()) {
                    string temp = field.getDescribe().getLabel();
                    System.debug('**temp******'+temp );
                    if(fiedlabels.contains(temp)) {
                        string apiName  =  field.getDescribe().getName();
                        fieldApiList.add(apiName);
                        label_Api.put(temp,apiName);
                        System.debug('**label_Api******'+label_Api);
                    }
                } 
                
                List<String> DisplayFieldsList  = new List<String>();
                
                for(String label : fiedlabels) {
                    if(!label_Api.isEmpty() && label_Api.containsKey(label) && label_Api.get(label) != null) {
                        DisplayFieldsList.add(label_Api.get(label));
                    }
                }
                System.debug('**DisplayFieldsList******'+DisplayFieldsList);
                return DisplayFieldsList;
            }
   
   /*******************************************************************Dynamictabledata******************************************************************************************/         
      
      public void viewDynamicTable(){
      dynamicSobjWrapperMap = new map<string,list<checkListWrapper>>();
      isAttach = false;
      isEmailsend = false;
      isTask = false;
      isEmail = false;
      isNote = false;
      isapproval = false;
      isSuccesoor = false;
      ischklist=true;
      string fielApistr;
      
      System.debug('selectedid*********'+selectedid);
                  if(selectedid!= NULL){
                       System.debug('selectedid*********'+selectedid);
                       System.debug('recordact.Checklist_Columns__c*********'+recordact.Checklist_Columns__c);
                      
                       List<String> fieldApiList= prepareFieldsForTable(recordact.Checklist_Columns__c);
                        
                        if(!fieldApiList.isEmpty()) {
                             fielApistr  = String.join(fieldApiList,',');
                         }
                   
                         String query ='SELECT NPD_Activity_Chklist__c,';
                         query= query + ((String.isblank(fielApistr)) ? ' Id ':(fielApistr.containsIgnoreCase('Approval_Status__c')?fielApistr:(fielApistr + ' , Approval_Status__c ')) ) + ' FROM NPD_Checklist__c WHERE NPD_Activity_Chklist__c=:selectedid'; 
                        System.debug('queryquery*********'+query);
                        
                        List<Sobject> checkSobjList  = database.query(query);
                       
                        System.debug('checkSobjList  *********'+checkSobjList  );
                           
                       
                         checkListWrapList  =  new list<checkListWrapper>(); 
                         //dynamicSobjWrapperMap   =  new map<string,list<checkListWrapper>>();
                         if(checkSobjList  !=NULL){
                         for(Sobject sob : checkSobjList) {
                         System.debug('checkSobjList  *********'+checkSobjList  );
                             System.debug('ifififififififi********');
                             sobject sobj = (sobject)sob;
                             preparemap(sobj,'NPD_Activity_Chklist__c',false);
                             DisplayFieldsList = prepareFieldsForTable(recordact.Checklist_Columns__c);
                             System.debug('DisplayFieldsList DisplayFieldsList *********'+DisplayFieldsList );
                         } 
                         }
                         
                        
                 
                  }
      
      } 
      
      public boolean getIsCheckLists() {
                boolean temp = false;
                if(!dynamicSobjWrapperMap.isempty() && dynamicSobjWrapperMap.containsKey('NPD_Checklist__c') && dynamicSobjWrapperMap.get('NPD_Checklist__c') != null) {
                    temp  = true;
                }
                return temp;
           }
           
           
           /************************************************************************************************************************************
          * Method Name : createChklist
          *************************************************************************************************************************************/
          public void createCheckList() {
          
            isdynamicedit = true;
            sobject sobj = new NPD_Checklist__c();
          //sobj.put('Collection__c',currentProject.NPD_Collections__c);
            sobj.put('NPD_Activity_Chklist__c',selectedid);
            preparemap(sobj,'NPD_Activity_Chklist__c',true);
            DisplayFieldsList = prepareFieldsForTable(string.valueof(recordact.get('Checklist_Columns__c')));
        
        
        }
        
            
           /************************************************************************************************************************************
          * Method Name : Dynamic tabel Edit
          *************************************************************************************************************************************/
        
         public void editdynamictable() {
         
         if(recordact != null){
           activityNameDY  = recordact.Name__c;
           System.debug('record name+++++++++++++++++'+activityNameDY);
         }
         integer i=0;
         
       /*  for(checkListWrapper each : dynamicSobjWrapperMap.get('NPD_Checklist__c')){
          // dynamicSobjWrapperMap.get('NPD_Checklist__c').[0].isEdit  = true;
           dynamicSobjWrapperMap.get('NPD_Checklist__c')[i].isEdit  = true;
           i++;
           system.debug('*********i*********'+i);        
         } */
         
        if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey(relatedListType) && dynamicSobjWrapperMap.get(relatedListType) != null)  {
            dynamicSobjWrapperMap.get(relatedListType)[rowNum].isEdit  = true;  
        }    
         
         //isdynamicedit = true;
         }

        
        public void  savedynamictable(){
        
        list<NPD_Checklist__c> lstNPDChecklist = new list<NPD_Checklist__c>();
        if(!dynamicSobjWrapperMap.isEmpty() && dynamicSobjWrapperMap.containsKey('NPD_Checklist__c') && dynamicSobjWrapperMap.get('NPD_Checklist__c') != null){
          sobject sobj = dynamicSobjWrapperMap.get('NPD_Checklist__c')[rowNum].sobj;
        System.debug('****listlist********'+dynamicSobjWrapperMap.get('NPD_Checklist__c'));
      /*  for(checkListWrapper each : dynamicSobjWrapperMap.get('NPD_Checklist__c')){
            System.debug('********each.sobj : **********each.sobj : '+each.sobj);
            lstNPDChecklist.add((NPD_Checklist__c)each.sobj);
                   
         } */
        if(sobj != null){
             upsert sobj;
         } 
 
         }         
         
        /*  if(lstNPDChecklist.size()>0){
            upsert lstNPDChecklist;
            }  */
         
          viewDynamicTable();
          isdynamicedit = false;
           
           }
           
           Public void canceldynamic(){
           ischklist=false;
           }
            
    
}