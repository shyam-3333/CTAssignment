/*********************************************************************
   Name             : NPD_Design_Team_Report
   Description      : This class is used to display the progress of the collections based on design managers
   Created By       : Anindwita
   Created Date     : 19/06/2018
*********************************************************************/
public class NPD_Design_Team_Report{
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public List < selectoption > npdSubStgActOption{get;set;}
    public List < selectoption > npdDsgnManagOption{get;set;}
    public String selectedBrandName {get;set;}
    public String selectedCollectionName {get;set;}
    public String selectedSubActName {get;set;}
    public String selectedDesgnManagName {get;set;}
    public list<String> All;
    public date fromDate {get;set;}  // collect date from visual force page (tentative launch from date)
    public date toDate {get;set;} 
    public map < String, npd_stage__c > CollectionName;
    public map<String,NPD_Master__c > designerNameMap;
    public list<wrapperTable> lWrapperList {get;set;}
    public list<wrapperTable> subStageWrapperList {get;set;}
    public boolean isDisplayTable {get;set;}
    public boolean isSubStageTable {get;set;}
    
    
    /****************************************constructor********************************************/
    public NPD_Design_Team_Report(){
        lWrapperList = new List < wrapperTable> ();
        subStageWrapperList = new List<wrapperTable>();
        selectedBrandName = 'None';
        isDisplayTable = false;
        isSubStageTable = false;
        selectBrand();
        selectDesignManag();
        selectCollection();
        selectSubStageAct(); 
         

    }
    
    /*************************************selectBrand***********************************************/
    
    public void selectBrand() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        if(!subStageWrapperList.isEmpty()){
            subStageWrapperList.clear();
        }
        npdBrandOption = new List < selectoption > ();
        npdBrandOption.add(new selectoption('None', '--None--'));
        npdBrandOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Type__c = 'Brand' order by Name]) {
            npdBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
    
    /**************************************selectCollection**********************************************/
    
    
    public void selectCollection() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        if(!subStageWrapperList.isEmpty()){
            subStageWrapperList.clear();
        }
        npdCollectionOption = new List < selectoption > ();
        CollectionName = new map < String, npd_stage__c > ();
        List<String> collectionNamesLst = new list<String>();
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        npdCollectionOption.add(new selectoption('All', 'All'));
        
        if(selectedBrandName == 'All' && fromDate == null && toDate == null ){
            if(selectedDesgnManagName == 'None'){
                lstage = [select id, name__c,design_manager_npd_master__r.Name, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage']; 
            }else{
                lstage = [select id, name__c,design_manager_npd_master__r.Name, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND design_manager_npd_master__r.Name = :selectedDesgnManagName AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];  
            }
        }else if(selectedBrandName == 'All' && fromDate != null && toDate != null ){
            if(selectedDesgnManagName == 'None'){
                lstage = [select id, name__c, brand1__c, npd_collections__r.Tentative_Launch_Month_Date__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            }else{
                lstage = [select id, name__c, brand1__c, npd_collections__r.Tentative_Launch_Month_Date__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND design_manager_npd_master__r.Name = :selectedDesgnManagName AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            }
        }else if(selectedBrandName != 'All' && selectedBrandName != 'None' && fromDate == null && toDate == null ){
            if(selectedDesgnManagName == 'None'){
                lstage = [select id, name__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c,design_manager_npd_master__r.Name, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage']; 
            }else{
                lstage = [select id, name__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c,design_manager_npd_master__r.Name, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND design_manager_npd_master__r.Name = :selectedDesgnManagName AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            }
        }else if(selectedBrandName != 'All' && selectedBrandName != 'None' && fromDate != null && toDate != null ){
            if(selectedDesgnManagName == 'None'){
                lstage = [select id, name__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            }else{
                lstage = [select id, name__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName AND npd_collections__r.Project_Status__c ='Ongoing' AND name__c = 'Marketing Brief/Concept' AND design_manager_npd_master__r.Name = :selectedDesgnManagName AND NPD_Project_Name__r.Name ='Marketing Brief/Concept Stage'];
            }
        }
        
        for (npd_stage__c stage: lstage) {
            if (stage.npd_collections__r.Name != null) {
                CollectionName.put(stage.npd_collections__r.Name, stage);
            }
            //system.debug('+++++++++++++++CollectionName+++++++++++++' + CollectionName.values());   
        }
        system.debug('+++++++++++++++CollectionName+++++++++++++' + CollectionName.values());
        for (String name: CollectionName.keyset()) {
            collectionNamesLst.add(name);
        }
        collectionNamesLst.sort();
        
        for(String Names : collectionNamesLst){
            npdCollectionOption.add(new selectoption(Names, Names));
        }
    
    }
    
    /************************************selectSubStageAct************************************************/
    
    public void selectSubStageAct () {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        if(!subStageWrapperList.isEmpty()){
            subStageWrapperList.clear();
        }
        npdSubStgActOption = new list <selectoption> ();
        All = new list<String> {'Concept Design - IDS','Concept Presentation to PMG - IDS','Engineering Design - IDS','PB/PM Release , Approval and Recipt','Proto Dial Drawing Release and Receipt'};
        npdSubStgActOption.add(new selectoption('None', '--None--'));
        npdSubStgActOption.add(new selectoption('All', 'All'));
        npdSubStgActOption.add(new selectoption('Concept Finalization', 'Concept Finalization')); //sub-stage
        npdSubStgActOption.add(new selectoption('Concept Design - IDS', 'Concept Design - IDS'));
        npdSubStgActOption.add(new selectoption('Concept Presentation to PMG - IDS', 'Concept Presentation to PMG - IDS'));
        npdSubStgActOption.add(new selectoption('Engineering Design - IDS', 'Engineering Design - IDS'));
        npdSubStgActOption.add(new selectoption('PB/PM Release , Approval and Recipt', 'PB/PM Release , Approval and Recipt'));
        npdSubStgActOption.add(new selectoption('Proto Dial Drawing Release and Receipt', 'Proto Dial Drawing Release and Receipt'));
    }
    
    /**********************************selectDesignManag**************************************************/
    
    public void selectDesignManag() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        if(!subStageWrapperList.isEmpty()){
            subStageWrapperList.clear();
        }
        //designerNameMap = new map<String,NPD_Master__c >();
        npdDsgnManagOption = new List < selectoption > ();
        npdDsgnManagOption.add(new selectoption('None', '--None--'));
        //npdDsgnManagOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where type__c='Product Designer Name' order by Name]) {
            npdDsgnManagOption.add(new selectoption(master.name, master.Name));
            //designerNameMap.put(master.Name,master);
        }
    }
    
    /**************************************displayStageActTable*****************************************/
    
    public void displayStageActTable() {
        isSubStageTable = false;
        boolean isConceptAndEnggActivity = false;
        isDisplayTable = false;
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        if(!subStageWrapperList.isEmpty()){
            subStageWrapperList.clear();
        }
       // map<String, npd_stage__c > mapConceptStage = new map<String, npd_stage__c >();
        Map<String,list<NPD_Activity__c> >  mProjectToActivity = new Map<String,list<NPD_Activity__c> >();
        map < String, list<NPD_Activity__c> > mapCollectionToActivity = new map < String, list<NPD_Activity__c> > ();  //this map is used to fetch the data of all the activity from marketing breif stage(project name) which is not to be consider from other created projects as it is common but hided from the PDMS VF page
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        list<NPD_Activity__c> actLst = new list<NPD_Activity__c>();
        list < NPD_Activity__c > stageActLst    = new List < NPD_Activity__c > ();
        list<npd_stage__c> stageLst = new list<npd_stage__c>();
        system.debug('----------All--------'+All);
        
        if (selectedCollectionName == 'All' ) {
            //isDisplayTable = true;
            system.debug('----------CollectionName--------'+CollectionName);
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() order by NPD_Collections__r.Name];    
            
            if(selectedSubActName == 'All'){
                isSubStageTable = true;
                stageLst = [select id, name__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Concept Finalization' AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                isDisplayTable = true;
                actLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ('Concept Design - IDS','Concept Presentation to PMG - IDS','Engineering Design - IDS','PB/PM Release , Approval and Recipt','Proto Dial Drawing Release and Receipt') AND NPD_Project_Name__r.Name != 'Marketing Brief/Concept Stage'];
                
                stageActLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ('Concept Design - IDS','Concept Presentation to PMG - IDS','Engineering Design - IDS') AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                

                system.debug('----------lproject--------'+lproject);
            }else if(selectedSubActName == 'Concept Finalization'){
                isSubStageTable = true; 
                stageLst = [select id, name__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Concept Finalization' AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                isDisplayTable = false; 
            }else{
                
                isDisplayTable = true;
                actLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = :selectedSubActName AND NPD_Project_Name__r.Name != 'Marketing Brief/Concept Stage'];
                isSubStageTable = false;   
                
                stageActLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = :selectedSubActName AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                
            }
            
        }else{
            lproject = [select id,Name,Brand1__c,Project_Owner__r.Name,NPD_Collections__c,NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName order by NPD_Collections__r.Name];    
            //isSubStageTable = true;
            stageLst = [select id, name__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Concept Finalization' AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
            
            if(selectedSubActName == 'All'){
                isDisplayTable = true;
                actLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ('Concept Design - IDS','Concept Presentation to PMG - IDS','Engineering Design - IDS','PB/PM Release , Approval and Recipt','Proto Dial Drawing Release and Receipt') AND NPD_Project_Name__r.Name != 'Marketing Brief/Concept Stage']; 

                stageActLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ('Concept Design - IDS','Concept Presentation to PMG - IDS','Engineering Design - IDS') AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                
                isSubStageTable = true;
            }else if(selectedSubActName == 'Concept Finalization'){
                isSubStageTable = true; 
                stageLst = [select id, name__c,Actual_Start_Date__c,Actual_End_Date__c,Status__c, npd_collections__r.Tentative_Launch_Month_Date__c, brand1__c, design_manager_npd_master__r.Name,Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Concept Finalization' AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                isDisplayTable = false;             
            }else{
                isDisplayTable = true;
                actLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = :selectedSubActName AND NPD_Project_Name__r.Name != 'Marketing Brief/Concept Stage'];
                
                stageActLst = [Select id, NPD_Collections__r.name,  NPD_Project_Name__r.Name, NPD_Project_Name__r.Brand1__c,name__c, Status__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = :selectedSubActName AND NPD_Project_Name__r.Name = 'Marketing Brief/Concept Stage'];
                
                isSubStageTable = false;
                
            }
            
            system.debug('--------isDisplayTable(else)----------'+isDisplayTable);
            system.debug('--------isSubStageTable----------'+isSubStageTable);
            //isSubStageTable = true;
        }
            system.debug('--------isDisplayTableoutside(else)----------'+isDisplayTable);
            system.debug('--------isSubStageTable----------'+isSubStageTable);
        if(!actLst.isEmpty()){
            for(NPD_Activity__c activityList : actLst){
                        
                if(!mProjectToActivity.isEmpty() && mProjectToActivity.containskey(activityList.NPD_Project_Name__r.Name) && mProjectToActivity.get(activityList.NPD_Project_Name__r.Name) != null)
                {
                    mProjectToActivity.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                }
                else{
                    mProjectToActivity.put(activityList.NPD_Project_Name__r.Name,new List<NPD_Activity__c>{activityList});
                } 
            } 
        }
        if(!stageActLst.isEmpty()){
            for (NPD_Activity__c activityList: stageActLst) {
                if (!mapCollectionToActivity.isEmpty() && mapCollectionToActivity.containskey(activityList.NPD_Collections__r.Name) && mapCollectionToActivity.get(activityList.NPD_Collections__r.name) != null) {
                    mapCollectionToActivity.get(activityList.NPD_Collections__r.name).add(activityList);
                }else{
                    mapCollectionToActivity.put(activityList.NPD_Collections__r.name,new List<NPD_Activity__c>{activityList});
                }
            }
        }
        
        for (NPD_Project_Name__c wProject : lproject){
            if(mProjectToActivity.size()>0 && mProjectToActivity.containskey(wProject.Name) && mProjectToActivity.get(wProject.Name)!=null){
                for(NPD_Activity__c activity : mProjectToActivity.get(wProject.Name)){
                    wrapperTable collectionTable = new wrapperTable();
                    collectionTable.brand = activity.NPD_Project_Name__r.Brand1__c;
                    collectionTable.collection = activity.NPD_Collections__r.Name;   
                    if(CollectionName.containsKey(activity.NPD_Collections__r.Name) && CollectionName.get(activity.NPD_Collections__r.Name) != null && CollectionName.get(activity.NPD_Collections__r.Name).design_manager_npd_master__r.Name != null){
                        collectionTable.designManager = CollectionName.get(activity.NPD_Collections__r.Name).design_manager_npd_master__r.Name;
                    }
                    if(CollectionName.containsKey(activity.NPD_Collections__r.Name) && CollectionName.get(activity.NPD_Collections__r.Name) != null && CollectionName.get(activity.NPD_Collections__r.Name).npd_collections__r.Tentative_Launch_Month_Date__c != null){
                        collectionTable.launchMonth = CollectionName.get(activity.NPD_Collections__r.Name).npd_collections__r.Tentative_Launch_Month_Date__c;
                    }
                    collectionTable.caseNo = activity.NPD_Project_Name__r.Name;
                    
                    if((activity.name__c == 'Concept Design - IDS' || activity.name__c == 'Concept Presentation to PMG - IDS' || activity.name__c == 'Engineering Design - IDS') && mapCollectionToActivity.containsKey(activity.NPD_Collections__r.Name) && mapCollectionToActivity.get(activity.NPD_Collections__r.Name) != null){
                        for(NPD_Activity__c act : mapCollectionToActivity.get(activity.NPD_Collections__r.Name)){
                            if(act.name__c == activity.name__c){
                                
                                collectionTable.subStageacitvityName = act.name__c ;
                                collectionTable.startDate = act.Actual_Start_Date__c;
                                collectionTable.endDate = act.Actual_End_Date__c;
                                collectionTable.status = act.Status__c;
                            }
                        }
                            
                        }else{
                            collectionTable.subStageacitvityName = activity.name__c ;
                            collectionTable.startDate = activity.Actual_Start_Date__c;
                            collectionTable.endDate = activity.Actual_End_Date__c;
                            collectionTable.status = activity.Status__c;
                        }
                        
                    //}
                    lWrapperList.add(collectionTable);
                }
            }
        }   
        
        //this for loop is used to display the stage values in the table
        for(npd_stage__c Substage : stageLst){
            wrapperTable collectionTable = new wrapperTable();
            collectionTable.brand = Substage.Brand1__c;
            collectionTable.collection = Substage.NPD_Collections__r.Name;   
            if(CollectionName.containsKey(Substage.NPD_Collections__r.Name) && CollectionName.get(Substage.NPD_Collections__r.Name) != null && CollectionName.get(Substage.NPD_Collections__r.Name).design_manager_npd_master__r.Name != null){
                collectionTable.designManager = CollectionName.get(Substage.NPD_Collections__r.Name).design_manager_npd_master__r.Name;
            }
            if(CollectionName.containsKey(Substage.NPD_Collections__r.Name) && CollectionName.get(Substage.NPD_Collections__r.Name) != null && CollectionName.get(Substage.NPD_Collections__r.Name).npd_collections__r.Tentative_Launch_Month_Date__c != null){
                collectionTable.launchMonth = CollectionName.get(Substage.NPD_Collections__r.Name).npd_collections__r.Tentative_Launch_Month_Date__c;
            }
            
            collectionTable.subStageacitvityName = Substage.name__c ;
            collectionTable.startDate = Substage.Actual_Start_Date__c;
            collectionTable.endDate = Substage.Actual_End_Date__c;
            collectionTable.status = Substage.Status__c;
            subStageWrapperList.add(collectionTable);
        }
        
            
    }
    
    /****************************  Declare Wrapper table for displaying data to the VF page  *******************************/
    public class wrapperTable{
        public String brand {get;set;}
        public String collection {get;set;}
        public String designManager {get;set;}
        public Date launchMonth {get;set;}
        public String caseNo {get;set;} //this is used to assign the model no
        public String subStageacitvityName {get;set;}
        public  Date startDate {get;set;}
        public  Date endDate {get;set;}
        public  String status {get;set;}
        
    }
    
}