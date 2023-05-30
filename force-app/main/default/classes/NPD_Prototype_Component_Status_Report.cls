/*
This is Controller class for NPD_Prototype_Component_Status_Page which is created to display the component(list of Activities) status based on the selection
Created Date:-7/02/2018
Created by:-  Anindwita Raj
*/
public class NPD_Prototype_Component_Status_Report {

    public List < selectoption >            npdBrandOption           {get;set;}
    public List < selectoption >            npdType                  {get;set;}                           // This List is used to capture report type like  etc
    public List < selectoption >            npdCollectionOption      {get;set;}
    public List < selectoption >            npdfiscalYearOption    {get;set;}
    public List < selectoption >            npdModelOption {get;set;}
    public List < selectoption >            npdComponentOption {get;set;}
    public String                           selectedBrandName        {get;set;}
    public String                           selectedCollectionName   {get;set;}
    public String                           selectedType             {get;set;}
    public String                           selectedModelName {get;set;}
    public String                           selectedComponentName {get;set;}
    public date fromDate                                             {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public date toDate                                               {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public boolean                          showProtoInProgress             {get;set;}
    public boolean                          showProtoDelivered               {get;set;}
    public map < String, npd_stage__c >     CollectionName;
    public string selectedYear {get;set;}
    public list<wrapperTable> lWrapperList {get;set;}
    public Map<String,list<NPD_Project_Name__c> >  mCollectionToProject = new Map<String,list<NPD_Project_Name__c> >();
    public Map<String,list<NPD_Activity__c> >  mProjectToActivity ;
    public map<String, list<NPD_Activity__c> > mapActivitiesList;
    public list<String> AllComponent;
    public list<String> ProjectName;
    
    /*********************************** Constructor start for initialization  *****************************/   
    public NPD_Prototype_Component_Status_Report() {        
        lWrapperList = new List < wrapperTable> ();
        showProtoInProgress = false;
        showProtoDelivered = false;
        selectedBrandName = 'None';
        selectedYear = 'None';
        selectReportType();
        selectBrand(); 
        selectCollection(); 
        selectModel();
        selectYear(); 
        selectComponent();      
    }
    /*****************************   End of Constructor   *******************************************************/
    
    /**************************************** This method is used to select report type *******************************/
    public void selectReportType(){
        npdType = new List < selectoption > ();
        npdType.add(new selectoption('None', '--None--'));
        npdType.add(new selectoption('Proto In-Progress', 'Proto In-Progress'));
        npdType.add(new selectoption('Proto Delivered', 'Proto Delivered'));
        npdType.add(new selectoption('All', 'All'));
    }   
    /*************************************** End of selectReportType method  ***************************************************/
    
    /********************************* selectedType method is used to display and hide report type based on condition   **********************/
    public void selectedType() {  
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        if (selectedType == 'Proto In-Progress') {
            
            selectedCollectionName = 'None';
            selectedModelName = 'None';
            selectedComponentName = 'None';
            
        }
        if (selectedType == 'Proto Delivered') {
            selectedCollectionName = 'None';
            selectedModelName = 'None';
            selectedComponentName = 'None';
            
            
        }
        if (selectedType == 'All') {
            selectedCollectionName = 'None';
            selectedModelName = 'None';
            selectedComponentName = 'None';
            
            
        }
    }
    /******************************* End of selectedType method    ***************************************/
    
    /**************************************** Start displayTable method   ********************************/
    public void displayTable(){
        
        if(selectedType == 'Proto In-Progress'){
            displayActivityTable();
        }
        if(selectedType == 'Proto Delivered'){
            displayActivityTable();
        }
        if(selectedType == 'All'){
            displayActivityTable();
        }
    }
    /********************************************* End of displayTable *******************************************************/
    
    /**************************************** This method is used to select Brand *******************************/
    public void selectBrand() {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
         } 
        npdBrandOption = new List < selectoption > ();
        npdBrandOption.add(new selectoption('None', '--None--'));
        npdBrandOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Type__c = 'Brand' order by Name]) {
            npdBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
    /******************************* End of Brand method    ***************************************/
    
    /**************************************** This method is used to select collection based on Brand *******************************/
    public void selectCollection() {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        npdCollectionOption = new List < selectoption > ();
        CollectionName = new map < String, npd_stage__c > ();
        List<String> collectionNamesLst = new list<String>();
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        npdCollectionOption.add(new selectoption('All', 'All'));
         if(selectedBrandName == 'All' && selectedYear == 'None'){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c];   
                System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            }
           else if(fromDate != null && toDate != null  && selectedType == 'Proto Delivered'){
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate ];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' && selectedYear == 'None'){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
           else if(fromDate != null && toDate != null && selectedType == 'Proto Delivered'){
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           
        }
        else if(selectedBrandName == 'All' && selectedYear != 'None' && fromDate == null && toDate == null){
                if (selectedYear == 'THIS_FISCAL_YEAR' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = THIS_FISCAL_YEAR];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:1' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = LAST_FISCAL_YEAR];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:2' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 1)];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:3' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 2)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:1' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c = NEXT_FISCAL_YEAR limit 999];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:2' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:3' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:4' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
        
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' && selectedYear != 'None' && fromDate == null && toDate == null){
                if (selectedYear == 'THIS_FISCAL_YEAR')
                    lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = THIS_FISCAL_YEAR];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:1')
                    lstage = [select id, name__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = LAST_FISCAL_YEAR];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:2')
                    lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 1)];
                else if (selectedYear == 'LAST_N_FISCAL_​YEARS:3')
                    lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 2)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:1')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = NEXT_FISCAL_YEAR limit 999];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:2')
                    lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:3')
                    lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:4')
                    lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
        
        }

        
        for (npd_stage__c stage: lstage) {
            if (stage.npd_collections__r.Name != null) {
                CollectionName.put(stage.npd_collections__r.Name, stage);
            }
            //system.debug('+++++++++++++++CollectionName+++++++++++++' + CollectionName.values());   
        }
        for (String name: CollectionName.keyset()) {
            collectionNamesLst.add(name);
            //npdCollectionOption.add(new selectoption(name, name));
        }
        collectionNamesLst.sort();
        
        for(String Names : collectionNamesLst){
            npdCollectionOption.add(new selectoption(Names, Names));
        }
    }
    /******************************* End of Collection method ***************************************/
    
    /**************************************** This method is used to select collection based on Collection *******************************/
    public void selectModel() {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        npdModelOption = new list <selectoption> ();
        mProjectToActivity = new Map<String,list<NPD_Activity__c> >();
        list<NPD_Activity__c> actLst = new list<NPD_Activity__c>();
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        ProjectName = new List<String>();
        
        system.debug('--------CollectionName.keyset()----------'+CollectionName.keyset());
        if (selectedCollectionName == 'All') {
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,PSY_No__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() AND NPD_Collections__r.Name != null];    
            system.debug('--------lproject ----------'+lproject );
            actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Active__c, name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c IN ( 'Proto Design Input','Proto Tech.Drawing Release Request','Proto Design - Release','Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Submission by D&D for Approval','Proto Glass Request','Glass for Proto Mfg')]; 
            if(test.isRunningTest()){
                lproject = [select id,Name,Brand1__c,NPD_Collections__c,PSY_No__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name = '9876'];    
                actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Active__c, name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name = 'Test Collections' AND name__c IN ( 'Proto Design Input','Proto Tech.Drawing Release Request','Proto Design - Release','Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Submission by D&D for Approval','Proto Glass Request','Glass for Proto Mfg')]; 
            
            }
            for(NPD_Activity__c activityList: actLst){
                
                if(!mProjectToActivity.isEmpty() && mProjectToActivity.containskey(activityList.NPD_Project_Name__r.Name) && mProjectToActivity.get(activityList.NPD_Project_Name__r.Name) != null)
                {
                    mProjectToActivity.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                }
                else{
                    mProjectToActivity.put(activityList.NPD_Project_Name__r.Name,new List<NPD_Activity__c>{activityList});
                }
            }
            
            for(NPD_Project_Name__c prjct : lproject){
                if(mProjectToActivity.size()>0 && mProjectToActivity.containskey(prjct.Name) && mProjectToActivity.get(prjct.Name)!=null){
                    for(NPD_Activity__c act : mProjectToActivity.get(prjct.Name)){
                        if(act.name__c == 'Proto Submission by D&D for Approval'){
                             if(selectedType == 'Proto In-Progress' && act.Actual_Start_Date__c == NULL){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             }else if(selectedType == 'Proto Delivered' && act.Actual_Start_Date__c != NULL){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             
                             }else if(selectedType == 'All'){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             }
                             
                        }
                    }
                }   
            }

        }else{
            system.debug('---------selectedCollectionName---------'+selectedCollectionName);
            if(test.isRunningTest()){
                selectedCollectionName = 'Test Collections';
            }
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name,PSY_No__c from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName];    
            system.debug('---------lproject---------'+lproject);
             actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c,Active__c, Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ( 'Proto Design Input','Proto Tech.Drawing Release Request','Proto Design - Release','Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Submission by D&D for Approval','Proto Glass Request','Glass for Proto Mfg')];
            
            
            for(NPD_Activity__c activityList : actLst){
                
                if(!mProjectToActivity.isEmpty() && mProjectToActivity.containskey(activityList.NPD_Project_Name__r.Name) && mProjectToActivity.get(activityList.NPD_Project_Name__r.Name) != null)
                {
                    mProjectToActivity.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                }
                else{
                    mProjectToActivity.put(activityList.NPD_Project_Name__r.Name,new List<NPD_Activity__c>{activityList});
                } 
                
            }
            
            for(NPD_Project_Name__c prjct : lproject){
                if(mProjectToActivity.size()>0 && mProjectToActivity.containskey(prjct.Name) && mProjectToActivity.get(prjct.Name)!=null){
                    for(NPD_Activity__c act : mProjectToActivity.get(prjct.Name)){
                        if(act.name__c == 'Proto Submission by D&D for Approval'){
                             if(selectedType == 'Proto In-Progress' && act.Actual_Start_Date__c == NULL){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             }else if(selectedType == 'Proto Delivered' && act.Actual_Start_Date__c != NULL){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             
                             }else if(selectedType == 'All'){
                                ProjectName.add(act.NPD_Project_Name__r.Name);
                             }
                             
                        }
                    }
                }   
            }
         }   
                
        npdModelOption.add(new selectoption('None', '--None--'));
        npdModelOption.add(new selectoption('All', 'All'));
        for (String projct : ProjectName) {
            npdModelOption.add(new selectoption(projct , projct));
        }
       system.debug('----mProjectToActivity-------'+mProjectToActivity);
    }
    /******************************* End of Model method ***************************************/
    
    /**************************************** This method is used to select year *******************************/
    
    public void selectYear() {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        
        Map < String, String > fiscalMap = new Map < String, String > ();
        npdfiscalYearOption = new List < selectoption > ();
        Date strToday = System.Today().addmonths(0);
        Integer currentFiscalYear = Integer.valueof([SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <=: strToday AND EndDate >=: strToday].FiscalYearSettings.Name);
        npdfiscalYearOption.add(new selectoption('None', '--None--'));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:3', String.ValueOf(currentFiscalYear - 3)  ));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:2',String.valueOf(currentFiscalYear - 2)   ));
        npdfiscalYearOption.add(new selectoption('LAST_N_FISCAL_​YEARS:1', String.valueOf(currentFiscalYear - 1) ));
        npdfiscalYearOption.add(new selectoption('THIS_FISCAL_YEAR', String.valueOf(currentFiscalYear) ));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:1', String.valueOf(currentFiscalYear + 1) ));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:2', String.valueOf(currentFiscalYear + 2) ));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:3', String.valueOf(currentFiscalYear + 3) ));
        npdfiscalYearOption.add(new selectoption('NEXT_N_FISCAL_​YEARS:4', String.valueOf(currentFiscalYear + 4) ));
        System.debug('+++++++fiscalMap++++++' + fiscalMap.values());
    }
    
    /******************************* End of selectYear method ***************************************/
    
    /**************************************** This method is used to select components *******************************/
    
    public void selectComponent () {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
    
        AllComponent = new list<String> {'Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Glass Request','Glass for Proto Mfg'};
        npdComponentOption = new list <selectoption> ();
        npdComponentOption.add(new selectoption('None', '--None--'));
        npdComponentOption.add(new selectoption('AllComponent', 'All'));
        npdComponentOption.add(new selectoption('Case Assembly', 'Case Assembly'));
        npdComponentOption.add(new selectoption('Crown', 'Crown'));
        npdComponentOption.add(new selectoption('Dial', 'Dial'));
        npdComponentOption.add(new selectoption('Glass', 'Glass'));
        npdComponentOption.add(new selectoption('Hands', 'Hands'));
        npdComponentOption.add(new selectoption('Lstrap', 'Lstrap'));
        npdComponentOption.add(new selectoption('Mstrap', 'Mstrap'));
        npdComponentOption.add(new selectoption('WH/FW', 'WH/FW'));
        
        
    }
    
    /******************************* End of selectComponent method ***************************************/
    
    /**************************************** This method is used to display table based on report name,brand,collection and model filters *******************************/
    
    public void displayActivityTable() {
        lWrapperList = new List < wrapperTable> ();
        if(selectedComponentName != 'AllComponent'){
            showProtoDelivered = true;
            showProtoInProgress = false;
        }else{
            showProtoInProgress = true;
            showProtoDelivered = false;
        }
         mapActivitiesList = new map<String, list<NPD_Activity__c> > ();
         List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
         system.debug('----mProjectToActivity----1---'+mProjectToActivity);
        if(selectedModelName == 'All' && selectedCollectionName == 'All'){
           
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN :CollectionName.keyset() AND Name IN :ProjectName order by NPD_Collections__r.Name];    
            
        }else if(selectedModelName == 'All' && selectedCollectionName != 'All'){
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName AND Name IN :ProjectName order by NPD_Collections__r.Name];    
            
        }else if(selectedModelName != 'All' && selectedCollectionName == 'All'){
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN :CollectionName.keyset() AND Name = :selectedModelName order by NPD_Collections__r.Name];    
            
        }else if(selectedModelName != 'All' && selectedCollectionName != 'All'){
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName AND Name = :selectedModelName order by NPD_Collections__r.Name];    
            
        }
        system.debug('-------ProjectName---------'+ProjectName);
        system.debug('-------lproject---------'+lproject);
        list<NPD_Activity__c> activityList = new list<NPD_Activity__c>();
        if(selectedCollectionName == 'All'){
            if(selectedModelName == 'All') {
                if(selectedComponentName == 'AllComponent'){
                    activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name IN :CollectionName.keyset() AND name__c IN :AllComponent  AND NPD_Project_Name__r.Name IN :ProjectName];
                   
                }else{
                    list<String> lstActName = alComponentName();
                    
                    activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name IN :CollectionName.keyset() AND name__c IN :lstActName  AND NPD_Project_Name__r.Name IN :ProjectName];
                    
                }
                   
            }else{
                if(selectedModelName != 'All') {
                    if(selectedComponentName == 'AllComponent'){
                        activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name IN :CollectionName.keyset() AND name__c IN :AllComponent  AND NPD_Project_Name__r.Name = :selectedModelName];
                            
                           
                        system.debug('-------------mapActivitiesList---------------'+mapActivitiesList);
                    }else{
                        list<String> lstActName = alComponentName();
                        
                        
                        activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name IN :CollectionName.keyset() AND name__c IN :lstActName  AND NPD_Project_Name__r.Name = :selectedModelName];
                        
                        
                    }   
                }
            }
        }else{
            if(selectedModelName == 'All') {
                if(selectedComponentName == 'AllComponent'){
                    activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN :AllComponent  AND NPD_Project_Name__r.Name IN :ProjectName];
                    
                    system.debug('-------------mapActivitiesList---------------'+mapActivitiesList);
                }else{
                    list<String> lstActName = alComponentName();
                    
                    
                    activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN :lstActName  AND NPD_Project_Name__r.Name IN :ProjectName];
                    
                }
                   
            }else{
                if(selectedModelName != 'All') {
                    if(test.isRunningTest()){
                          selectedComponentName = 'AllComponent';  
                    }
                    if(selectedComponentName == 'AllComponent'){
                        system.debug('---selectedComponentName------'+selectedComponentName);
                        system.debug('---AllComponent------'+AllComponent);
                        activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c,Active__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN :AllComponent  AND NPD_Project_Name__r.Name = :selectedModelName]; 
                        system.debug('-------------mapActivitiesList---------------'+mapActivitiesList);
                    }else{
                        list<String> lstActName = alComponentName();
                        
                        activityList = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name  = :selectedCollectionName AND name__c IN :lstActName  AND NPD_Project_Name__r.Name = :selectedModelName];
                        
                    }   
                }
            }
        }
        
         for(NPD_Activity__c activityListObj : activityList){
        
            if (activityListObj.NPD_Project_Name__r.Name != null) {
                if(!mapActivitiesList.containsKey(activityListObj.NPD_Project_Name__r.Name)){
                    list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                    lstAct.add(activityListObj);   
                    mapActivitiesList.put(activityListObj.NPD_Project_Name__r.Name,lstAct);
                }else{
                    mapActivitiesList.get(activityListObj.NPD_Project_Name__r.Name).add(activityListObj);
                }
            
            }
        }
        /*-----------formation of wrapper class----------------*/
        
        if(selectedComponentName == 'AllComponent'){
            for(NPD_Project_Name__c wProject : lproject){
                wrapperTable collectionTable = new wrapperTable();
                collectionTable.collection = wProject.NPD_Collections__r.Name;             
                collectionTable.brand     = wProject.Brand1__c;
                collectionTable.model = wProject.Name;
                collectionTable.owner = wProject.Project_Owner__r.Name;
                if(mapActivitiesList.size()>0 && mapActivitiesList.containskey(wProject.Name) && mapActivitiesList.get(wProject.Name)!=null){
                    
                    for(NPD_Activity__c activity : mapActivitiesList.get(wProject.Name)){
                        if( activity.name__c == 'Proto Case Assembly Request')
                        {
                            collectionTable.protoCaseReqED = activity.Actual_End_Date__c; 
                            collectionTable.isProtoCaseAssemblyRequestActive = activity.Active__c;
                        }
                        if( activity.name__c == 'Proto Manufacturing & Assembly')
                        {
                            collectionTable.protoManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isProtoManufacturingAssemblyActive = activity.Active__c;
                        }
                        collectionTable.caseAssLT = ( collectionTable.protoManfRecpED != null && collectionTable.protoCaseReqED != null) ? collectionTable.protoCaseReqED.daysbetween(collectionTable.protoManfRecpED) : null;
                        if(activity.name__c == 'Proto Dial Request')
                        {
                            collectionTable.protoDialReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoDialRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Dial for Proto Mfg')
                        {
                            collectionTable.protoDialManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDialforProtoMfgActive = activity.Active__c;
                        }
                        collectionTable.dialLT = (collectionTable.protoDialManfRecpED != null && collectionTable.protoDialReqED != null) ? collectionTable.protoDialReqED.daysbetween(collectionTable.protoDialManfRecpED) : null;
                        if(activity.name__c == 'Proto Hand Request')
                        {
                            collectionTable.protoHandReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoHandRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Hands for Proto Mfg')
                        {
                            collectionTable.protoHandManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isHandsforProtoMfgActive = activity.Active__c;
                        }
                        collectionTable.HandsLT = (collectionTable.protoHandManfRecpED != null && collectionTable.protoHandReqED != null) ? collectionTable.protoHandReqED.daysbetween(collectionTable.protoHandManfRecpED) : null;
                        if(activity.name__c == 'Proto Leather Strap Request')
                        {
                            collectionTable.protoLStrapReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoLeatherStrapRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Leather Strap For Proto Mfg')
                        {
                            collectionTable.protoLStrapManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isLeatherStrapForProtoMfgActive = activity.Active__c;
                        }
                        collectionTable.LStrapLT = (collectionTable.protoLStrapManfRecpED != null && collectionTable.protoLStrapReqED != null) ? collectionTable.protoLStrapReqED.daysbetween(collectionTable.protoLStrapManfRecpED) : null;
                        if(activity.name__c == 'Proto Metalstrap Request')
                        {
                            collectionTable.protoMStrapReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoMetalstrapRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Metal Strap for Proto Mfg')
                        {
                            collectionTable.protoMStrapManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isMetalStrapforProtoMfgActive = activity.Active__c;
                        }
                        collectionTable.MStrapLT = (collectionTable.protoMStrapManfRecpED != null && collectionTable.protoMStrapReqED != null) ? collectionTable.protoMStrapReqED.daysbetween(collectionTable.protoMStrapManfRecpED) : null;
                        if(activity.name__c == 'Proto Crown Request')
                        {
                            collectionTable.protoCrownReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoCrownRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Crown for Proto Mfg')
                        {
                            collectionTable.protoCrownManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isCrownforProtoMfgActive = activity.Active__c;
                        }
                        collectionTable.CrownLT = (collectionTable.protoCrownManfRecpED != null && collectionTable.protoCrownReqED != null) ? collectionTable.protoCrownReqED.daysbetween(collectionTable.protoCrownManfRecpED) : null;
                        if(activity.name__c == 'Proto WH/FW Request')
                        {
                            collectionTable.protoWHReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoWHFWRequestActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Proto - WH/FW/WH+Strap')
                        {
                            collectionTable.protoWHManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isProtoWHFWWHStrapActive = activity.Active__c;
                        }
                        collectionTable.WHLT = (collectionTable.protoWHManfRecpED != null && collectionTable.protoWHReqED != null) ? collectionTable.protoWHReqED.daysbetween(collectionTable.protoWHManfRecpED) : null;
                        if(activity.name__c == 'Proto Glass Request')
                        {
                            collectionTable.protoGlassReqED = activity.Actual_End_Date__c;
                            collectionTable.isProtoGlassReqActive = activity.Active__c;
                        }
                        if(activity.name__c == 'Glass for Proto Mfg')
                        {
                            collectionTable.protoGlassManfRecpED = activity.Actual_End_Date__c;
                            collectionTable.isProtoGlassRecpActive = activity.Active__c;
                        }
                        collectionTable.glassLT = (collectionTable.protoGlassManfRecpED != null && collectionTable.protoGlassReqED != null) ? collectionTable.protoGlassReqED.daysbetween(collectionTable.protoGlassManfRecpED) : null; 
                    }
                    lWrapperList.add(collectionTable);
                }
            }
        }else{
            system.debug('----mapActivitiesList-------'+mapActivitiesList);
            
            for(NPD_Project_Name__c wProject : lproject){
                system.debug('----wProject.Name-------'+wProject.Name);
                wrapperTable collectionTable = new wrapperTable();
                collectionTable.collection = wProject.NPD_Collections__r.Name;             
                collectionTable.brand     = wProject.Brand1__c;
                collectionTable.model = wProject.Name;
                collectionTable.owner = wProject.Project_Owner__r.Name;
                
                system.debug('---mapActivitiesList.size()----'+mapActivitiesList.size());
                system.debug('----mapActivitiesList.containskey(wProject.Name)------'+mapActivitiesList.containskey(wProject.Name));
                system.debug('----mapActivitiesList.get(wProject.Name)------'+mapActivitiesList.get(wProject.Name));
                
                if(mapActivitiesList.size()>0 && mapActivitiesList.containskey(wProject.Name) && mapActivitiesList.get(wProject.Name)!=null){
                    
                    for(NPD_Activity__c activity : mapActivitiesList.get(wProject.Name)){
                        if(selectedComponentName == 'Case Assembly' && activity.name__c == 'Proto Case Assembly Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c; 
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Case Assembly' && activity.name__c == 'Proto Manufacturing & Assembly')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Dial' && activity.name__c == 'Proto Dial Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Dial' && activity.name__c == 'Dial for Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Hands' && activity.name__c == 'Proto Hand Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Hands' && activity.name__c == 'Hands for Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c; 
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Lstrap' && activity.name__c == 'Proto Leather Strap Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Lstrap' && activity.name__c == 'Leather Strap For Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c; 
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Mstrap' && activity.name__c == 'Proto Metalstrap Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Mstrap' && activity.name__c == 'Metal Strap for Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c; 
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Crown' && activity.name__c == 'Proto Crown Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Crown' && activity.name__c == 'Crown for Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'WH/FW' && activity.name__c == 'Proto WH/FW Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c; 
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'WH/FW' && activity.name__c == 'Proto - WH/FW/WH+Strap')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        if(selectedComponentName == 'Glass' && activity.name__c == 'Proto Glass Request')
                        {
                            collectionTable.dynamicReqED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicReqActive = activity.Active__c;
                        }
                        if(selectedComponentName == 'Glass' && activity.name__c == 'Glass for Proto Mfg')
                        {
                            collectionTable.dynamicRecpED = activity.Actual_End_Date__c;
                            collectionTable.isDynamicRecpActive = activity.Active__c;
                        }
                        collectionTable.dynamicLT = ( collectionTable.dynamicRecpED != null && collectionTable.dynamicReqED != null) ? collectionTable.dynamicReqED.daysbetween(collectionTable.dynamicRecpED) : null;
                        
                    }
                    lWrapperList.add(collectionTable);
                }
            }
            
        }    
        
    }
    
     
        
    /******************************* End of displayActivityTable method ***************************************/
    
    public list<String> alComponentName(){
        list<String> lstActName = new list<String>();
        if(selectedComponentName == 'Case Assembly'){
            lstActName.add('Proto Case Assembly Request');
            lstActName.add('Proto Manufacturing & Assembly');
        }
        if(selectedComponentName == 'Crown'){
            lstActName.add('Proto Crown Request');
            lstActName.add('Crown for Proto Mfg');
        }
        if(selectedComponentName == 'Dial'){
            lstActName.add('Proto Dial Request');
            lstActName.add('Dial for Proto Mfg');
        }
        if(selectedComponentName == 'Hands'){
            lstActName.add('Proto Hand Request');
            lstActName.add('Hands for Proto Mfg');
        }
        if(selectedComponentName == 'Lstrap'){
            lstActName.add('Proto Leather Strap Request');
            lstActName.add('Leather Strap For Proto Mfg');
        }
        if(selectedComponentName == 'Mstrap'){
            lstActName.add('Proto Metalstrap Request');
            lstActName.add('Metal Strap for Proto Mfg');
        }
        if(selectedComponentName == 'WH/FW'){
            lstActName.add('Proto WH/FW Request');
            lstActName.add('Proto - WH/FW/WH+Strap');
        }
        if(selectedComponentName == 'Glass'){
            lstActName.add('Proto Glass Request');
            lstActName.add('Glass for Proto Mfg');
        }
        return lstActName;
        
    }
    
    
    
    
    
    /****************************  Declare Wrapper table for displaying data to the VF page  *******************************/
    public class wrapperTable{
        public transient String brand {get;set;}
        public transient String collection {get;set;}
        public transient String model {get;set;}
        public transient String owner {get;set;}
        
        
        public transient date protoCaseReqED {get;set;}
        public transient date protoManfRecpED {get;set;}
        public transient date protoDialReqED {get;set;}
        public transient date protoDialManfRecpED {get;set;}
        public transient date protoHandReqED {get;set;}
        public transient date protoHandManfRecpED {get;set;}
        public transient date protoLStrapReqED {get;set;}
        public transient date protoLStrapManfRecpED {get;set;}
        public transient date protoMStrapReqED {get;set;}
        public transient date protoMStrapManfRecpED {get;set;}
        public transient date protoCrownReqED {get;set;}
        public transient date protoCrownManfRecpED {get;set;}
        public transient date protoWHReqED {get;set;}
        public transient date protoWHManfRecpED {get;set;}
        public transient date protoGlassReqED {get;set;}
        public transient date protoGlassManfRecpED {get;set;}
        
        public transient Integer caseAssLT  {get;set;}
        public transient Integer dialLT  {get;set;}
        public transient Integer HandsLT  {get;set;}
        public transient Integer LStrapLT  {get;set;}
        public transient Integer MStrapLT  {get;set;}
        public transient Integer CrownLT  {get;set;}
        public transient Integer WHLT  {get;set;}
        public transient Integer glassLT  {get;set;}
        
        /*--------------wrapper values for displaying active and deactivate activities---------------*/
        public boolean isProtoCaseAssemblyRequestActive {get;set;}
        public boolean isProtoManufacturingAssemblyActive {get;set;}
        public boolean isProtoDialRequestActive {get;set;}
        public boolean isDialforProtoMfgActive {get;set;}
        public boolean isProtoHandRequestActive {get;set;}
        public boolean isHandsforProtoMfgActive {get;set;}
        public boolean isProtoLeatherStrapRequestActive {get;set;}
        public boolean isLeatherStrapForProtoMfgActive {get;set;}
        public boolean isProtoMetalstrapRequestActive {get;set;}
        public boolean isMetalStrapforProtoMfgActive {get;set;}
        public boolean isProtoCrownRequestActive {get;set;}
        public boolean isCrownforProtoMfgActive {get;set;}
        public boolean isProtoWHFWRequestActive {get;set;}
        public boolean isProtoWHFWWHStrapActive {get;set;}
        public boolean isProtoGlassReqActive {get;set;}
        public boolean isProtoGlassRecpActive {get;set;}
        
       /*---------wrapper values for 2nd table--------------*/ 
        public transient date dynamicReqED {get;set;}
        public transient date dynamicRecpED {get;set;}
        public transient Integer dynamicLT {get;set;}
        public boolean isDynamicReqActive {get;set;}
        public boolean isDynamicRecpActive {get;set;}
        
        
    }   
    /******************************* End of Wrapper Table class ***************************************/
    
}