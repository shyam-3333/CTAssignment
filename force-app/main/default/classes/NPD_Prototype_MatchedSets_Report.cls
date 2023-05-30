global class NPD_Prototype_MatchedSets_Report {

    public List < selectoption >            npdBrandOption           {get;set;}
    public List < selectoption >            npdType                  {get;set;}                           // This List is used to capture report type like  etc
    public List < selectoption >            npdCollectionOption      {get;set;}
    public List < selectoption >            npdfiscalYearOption    {get;set;}
    public String                           selectedBrandName        {get;set;}
    public String                           selectedCollectionName   {get;set;}
    public String                           selectedType             {get;set;}
    public date fromDate                                             {get;set;}                             // collect date from visual force page (tentative launch from date)
    public date toDate                                               {get;set;}                             // collect date from visual force page (tentative launch from date)
    public boolean                          showProtoInProgress             {get;set;}
    public boolean                          showProtoDelivered               {get;set;}
    public map < String, npd_stage__c >     CollectionName;
    public string selectedYear {get;set;}
    public list<wrapperTable> lWrapperList {get;set;}
    public list<ComponentsWrapper> cmpWrap {get;set;}
    Map<String,list<NPD_Activity__c> >  mProjectToActivity {get;set;}
    map<String,Integer> mapcasereqdt = new map<String,Integer>();
    public NPD_Activity__c activityObj {get;set;}
    
    public list<ComponentsWrapper> sortedCompWrapList {get;set;}
    
    /*********************************** End Of Wrapper Class   ********************************************/
    /*********************************** Constructor start for initialization  *****************************/   
    public NPD_Prototype_MatchedSets_Report() {        
        lWrapperList = new List < wrapperTable> ();
        
        showProtoInProgress = false;
        
        selectedBrandName = 'None';
        selectedYear = 'None';
        selectReportType();
        selectBrand(); 
        selectCollection(); 
        selectYear();    
    }
    /*****************************   End of Constructor   *******************************************************/
    /**************************************** This method is used to select report type *******************************/
    public void selectReportType(){
        npdType = new List < selectoption > ();
        npdType.add(new selectoption('None', '--None--'));
        npdType.add(new selectoption('Proto In-Progress', 'Proto In-Progress'));
        
    }   
    /*************************************** End of selectReportType method  ***************************************************/
    /********************************* selectedType method is used to display and hide report type based on condition   **********************/
    public void selectedType() {  
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        
        if (selectedType == 'Proto In-Progress') {
            showProtoInProgress = true;
            
            
        }
        
    }
    /******************************* End of selectedType method    ***************************************/
    /**************************************** Start displayTable method   ********************************/
    public void displayTable(){
        if(selectedType == 'Proto In-Progress'){
            displayActivityTable();
        }
   
    }
/********************************************* End of displayTable ********************************************************************/
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
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c];   
                System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            }
           else if(fromDate != null && toDate != null  && selectedType == 'Proto In-Progress'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate ];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' && selectedYear == 'None'){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
           else if(fromDate != null && toDate != null && selectedType == 'Proto In-Progress'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
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
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:3' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
                else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:4' && selectedBrandName == 'All')
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
        
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
    public void selectYear() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        Map < String, String > fiscalMap = new Map < String, String > ();
        npdfiscalYearOption = new List < selectoption > ();
        Date strToday = System.Today().addmonths(0);
        Integer currentFiscalYear = Integer.valueof([SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year'
            AND StartDate <=: strToday AND EndDate >=: strToday
        ].FiscalYearSettings.Name);
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
    
    public void displayActivityTable() {
         if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        map < String, NPD_Activity__c > mActivityProtoDesignAED = new map < String, NPD_Activity__c > (); 
        map < String, NPD_Activity__c > mActivityProtoTechDrawingAED = new map < String, NPD_Activity__c > (); 
        list<NPD_Activity__c> actLst = new list<NPD_Activity__c>();
        mProjectToActivity = new Map<String,list<NPD_Activity__c> >();
        integer Assemblycount = 0;
        integer Dialcount = 0;
        integer Handcount = 0;
        integer leatherCount = 0;
        integer MetalstrapCount = 0;
        integer CrownCount = 0;
        integer WHFWCount = 0;
        integer ManufacturingCount = 0;
        integer dialProtoCount = 0;
        integer handsProtoCount = 0;
        integer leatherProtoCount = 0;
        integer metalStrapProtoCount = 0;
        integer crownProtoCount = 0;
        integer WHStrapProtoCount = 0;
        
        if (selectedCollectionName == 'All') {
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,Project_Owner__r.Name, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() order by NPD_Collections__r.Name];    
            
            actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Active__c, name__c,Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c IN ( 'Proto Design Input','Proto Tech.Drawing Release Request','Proto Design - Release','Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Submission by D&D for Approval')]; 
            for(NPD_Activity__c activityList: actLst){
                
                if(!mProjectToActivity.isEmpty() && mProjectToActivity.containskey(activityList.NPD_Project_Name__r.Name) && mProjectToActivity.get(activityList.NPD_Project_Name__r.Name) != null)
                {
                    mProjectToActivity.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                }
                else{
                    mProjectToActivity.put(activityList.NPD_Project_Name__r.Name,new List<NPD_Activity__c>{activityList});
                }                                       
            }
            
        }else{
            system.debug('-----selectedCollectionName----'+selectedCollectionName);
            lproject = [select id,Name,Brand1__c,Project_Owner__r.Name,NPD_Collections__c,NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName order by NPD_Collections__r.Name];    
            
            actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c,Active__c, Actual_Start_Date__c,Actual_End_Date__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN ( 'Proto Design Input','Proto Tech.Drawing Release Request','Proto Design - Release','Proto Case Assembly Request','Proto Manufacturing & Assembly','Proto Dial Request','Dial for Proto Mfg','Proto Hand Request','Hands for Proto Mfg','Proto Leather Strap Request','Leather Strap For Proto Mfg','Proto Metalstrap Request','Metal Strap for Proto Mfg','Proto Crown Request','Crown for Proto Mfg','Proto WH/FW Request','Proto - WH/FW/WH+Strap','Proto Submission by D&D for Approval')];
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
        
        for (NPD_Project_Name__c wProject : lproject) {
            system.debug('-----wProject----'+wProject);
            wrapperTable collectionTable = new wrapperTable();
            collectionTable.collection = wProject.NPD_Collections__r.Name;             
            collectionTable.brand     = wProject.Brand1__c;
            collectionTable.model = wProject.Name;
            collectionTable.owner = wProject.Project_Owner__r.Name;
            if(mProjectToActivity.size()>0 && mProjectToActivity.containskey(wProject.Name) && mProjectToActivity.get(wProject.Name)!=null){
                system.debug('-----mProjectToActivity.get(wProject.Name)----'+mProjectToActivity.get(wProject.Name));
                for(NPD_Activity__c activity : mProjectToActivity.get(wProject.Name)){
                    system.debug('-----activity----'+activity);
                    if(activity.name__c == 'Proto Case Assembly Request')
                    {
                        collectionTable.protoCaseReqED = activity.Actual_End_Date__c;
                        collectionTable.isProtoCaseAssemblyRequestActive = activity.Active__c;
                    }
                    if(activity.name__c == 'Proto Manufacturing & Assembly')
                    {
                        collectionTable.protoManfRecpED = activity.Actual_End_Date__c;
                        collectionTable.isProtoManufacturingAssemblyActive = activity.Active__c;
                    }
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
                    if(activity.name__c == 'Proto Case Assembly Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        Assemblycount  = Assemblycount + 1;     
                    }
                    if(activity.name__c == 'Proto Dial Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        Dialcount  = Dialcount + 1;     
                    }
                    if(activity.name__c == 'Proto Hand Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        Handcount  = Handcount + 1;     
                    }
                    if(activity.name__c == 'Proto Leather Strap Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        leatherCount  = leatherCount + 1;     
                    }  
                    if(activity.name__c == 'Proto Metalstrap Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        MetalstrapCount  = MetalstrapCount + 1;     
                    }  
                    if(activity.name__c == 'Proto Crown Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        CrownCount  = CrownCount + 1;     
                    } 
                    if(activity.name__c == 'Proto WH/FW Request' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        WHFWCount  = WHFWCount + 1;     
                    }
            //--------------------------------recpt activities------------------------------------------------//
                    if(activity.name__c == 'Proto Manufacturing & Assembly' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        ManufacturingCount  = ManufacturingCount + 1;     
                    }
                    if(activity.name__c == 'Dial for Proto Mfg' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        dialProtoCount  = dialProtoCount + 1;     
                    }
                    if(activity.name__c == 'Hands for Proto Mfg' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        handsProtoCount  = handsProtoCount + 1;     
                    }
                    if(activity.name__c == 'Leather Strap For Proto Mfg' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        leatherProtoCount  = leatherProtoCount + 1;     
                    }
                    if(activity.name__c == 'Metal Strap for Proto Mfg' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        metalStrapProtoCount  = metalStrapProtoCount + 1;     
                    }
                    if(activity.name__c == 'Crown for Proto Mfg' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        crownProtoCount  = crownProtoCount + 1;     
                    }
                    if(activity.name__c == 'Proto - WH/FW/WH+Strap' && activity.Actual_End_Date__c != null && activity.Active__c == true){
                        WHStrapProtoCount  = WHStrapProtoCount + 1;     
                    }
                }
                
            }
            //collectionTable.reqCount = count; 
            lWrapperList.add(collectionTable);
            //count = 0;
        }
        
        
        list<ComponentsWrapper> compWrapList = new list<ComponentsWrapper>();
        ComponentsWrapper compWrap = new ComponentsWrapper();
        compWrap.NoofSampleReq = Assemblycount;
        compWrap.NoofSamplereceipt = ManufacturingCount;
        compWrap.Priority = (Assemblycount - ManufacturingCount);
        compWrap.Component = 'Case Assembly';
        compWrapList.add(compWrap);
        
        ComponentsWrapper compWrap1 = new ComponentsWrapper();
        compWrap1.NoofSampleReq = Dialcount;
        compWrap1.NoofSamplereceipt = dialProtoCount;
        compWrap1.Priority = (Dialcount - dialProtoCount);
        compWrap1.Component = 'Dial';
        compWrapList.add(compWrap1);
        
        ComponentsWrapper compWrap2 = new ComponentsWrapper();
        compWrap2.NoofSampleReq = Handcount;
        compWrap2.NoofSamplereceipt = handsProtoCount;
        compWrap2.Priority = (Handcount - handsProtoCount);
        compWrap2.Component = 'Hands';
        compWrapList.add(compWrap2);
        
        ComponentsWrapper compWrap3 = new ComponentsWrapper();
        compWrap3.NoofSampleReq = leatherCount;
        compWrap3.NoofSamplereceipt = leatherProtoCount;
        compWrap3.Priority = (leatherCount - leatherProtoCount);
        compWrap3.Component = 'Leather Strap';
        compWrapList.add(compWrap3);
        
        ComponentsWrapper compWrap4 = new ComponentsWrapper();
        compWrap4.NoofSampleReq = MetalstrapCount;
        compWrap4.NoofSamplereceipt = metalStrapProtoCount;
        compWrap4.Priority = (MetalstrapCount - metalStrapProtoCount);
        compWrap4.Component = 'Metal Strap';
        compWrapList.add(compWrap4);
        
        ComponentsWrapper compWrap5 = new ComponentsWrapper();
        compWrap5.NoofSampleReq = CrownCount;
        compWrap5.NoofSamplereceipt = crownProtoCount;
        compWrap5.Priority = (CrownCount - crownProtoCount);
        compWrap5.Component = 'Crown';
        compWrapList.add(compWrap5);
        
        ComponentsWrapper compWrap6 = new ComponentsWrapper();
        compWrap6.NoofSampleReq = WHFWCount;
        compWrap6.NoofSamplereceipt = WHStrapProtoCount;
        compWrap6.Priority = (WHFWCount - WHStrapProtoCount);
        compWrap6.Component = 'WHStrap';
        compWrapList.add(compWrap6);
        system.debug('------------compWrapList----------------'+compWrapList);
        list<Integer> priorityList = new list<Integer>();
        map<Integer,list<ComponentsWrapper>> mapPriorityAndCompWrap = new map<Integer,list<ComponentsWrapper>>();
        sortedCompWrapList = new list<ComponentsWrapper>();
        for(ComponentsWrapper cw : compWrapList){
            if(mapPriorityAndCompWrap.containskey(cw.Priority)){
                mapPriorityAndCompWrap.get(cw.Priority).add(cw);
            }else{
                list<ComponentsWrapper> cl = new list<ComponentsWrapper>();
                cl.add(cw);
                mapPriorityAndCompWrap.put(cw.Priority,cl);
            }
            
        }
        for(Integer mapKey : mapPriorityAndCompWrap.keyset()){
            priorityList.add(mapKey);
        }
        
        priorityList.sort();
        
        
        for(Integer eachObj : priorityList){
            if(mapPriorityAndCompWrap.containskey(eachObj)){
                for(ComponentsWrapper eachCw : mapPriorityAndCompWrap.get(eachObj)){
                    sortedCompWrapList.add(eachCw);
                }
            
            }
        }
        
        
        
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
        public boolean active {get;set;}
        
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
        
        
    }
    
    global class ComponentsWrapper {
        global integer NoofSampleReq {get;set;}
        global integer NoofSamplereceipt {get;set;}
        global integer Priority {get;set;}
        global string Component {get;set;}


        global ComponentsWrapper(){
            NoofSampleReq = 0;
            NoofSamplereceipt = 0;
            Priority = 0;
            Component = null;
            
        }

    }
    
}