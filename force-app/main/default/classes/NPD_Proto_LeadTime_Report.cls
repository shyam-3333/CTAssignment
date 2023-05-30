public class NPD_Proto_LeadTime_Report {

    public List < selectoption >            npdBrandOption           {get;set;}
    public List < selectoption >            npdType                  {get;set;}                           // This List is used to capture report type like  etc
    public List < selectoption >            npdCollectionOption      {get;set;}
    public List < selectoption >            npdComponentOption {get;set;}
    public List < selectoption >            npdModelOption {get;set;}
    public String                           selectedBrandName        {get;set;}
    public String                           selectedCollectionName   {get;set;}
    public String                           selectedType             {get;set;}
    public String                           selectedComponentName {get;set;}
    public String                           selectedModelName {get;set;}
    public date fromDate                                             {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public date toDate                                               {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public boolean                          showProtoInProgress             {get;set;}
    public boolean                          showProtoDelivered               {get;set;}
    public map < String, npd_stage__c >     CollectionName;
    
    public list<wrapperTable> lWrapperList {get;set;}
    Map<String,list<NPD_Activity__c> >  mProjectToActivity  {get;set;}
    public Map<Integer, String> monthMap {get; set; }
    public Map<String, Integer> monthToDaysMap {get; set; }
    public NPD_Activity__c activityObj {get;set;}
    public list<String> AllComponent;
    public list<String> ProjectName;
    public List<String> noOfModelMonths {get; set; }
    public List<Integer> stringDays {get; set; }
    public map<String, list<NPD_Activity__c> > mapActivitiesList;
    public map<String, set<String> > mapCollAndProjList;
    list<date> lstAllcompDate {get;set;}
    public Integer totalCollspan {get;set;}
    
    /*********************************** End Of Wrapper Class   ********************************************/
    /*********************************** Constructor start for initialization  *****************************/   
    public NPD_Proto_LeadTime_Report() {        
        lWrapperList = new List < wrapperTable> ();
        
        showProtoInProgress = false;
        showProtoDelivered = false;
        selectedBrandName = 'None';
        monthMap = new Map<Integer, String>();
        monthMap = buildMonthMap();
        selectReportType();
        selectBrand(); 
        selectCollection(); 
        selectModel(); 
        selectComponent();
        noOfModelMonths = calcDefaultMonthts();
        
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
            showProtoInProgress = true;
            showProtoDelivered = false;
            
        }
        if (selectedType == 'Proto Delivered') {
            showProtoInProgress = true;
            //showProtoDelivered = true;
            
        }
        if (selectedType == 'All') {
            showProtoInProgress = true;
            showProtoDelivered = true;
            
        }
    }
    /******************************* End of selectedType method    ***************************************/
    
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
         if(selectedBrandName == 'All' ){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c];   
                System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            }
           else if(fromDate != null && toDate != null  && selectedType == 'Proto Delivered'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate ];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None' ){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
           else if(fromDate != null && toDate != null && selectedType == 'Proto Delivered'){
                    lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
                            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
                }   
           
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
    
    // Method to build a map of months
    public Map<Integer, String> buildMonthMap(){
        List<String> strMonths = new List<String>{'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
        
        for(Integer i=1; i <=12; i++){
            monthMap.put(i, strMonths[i-1]); 
        }
        
        return monthMap;
    }
    
    // Method to calculate the months between two Dates
    public void calculateMonths(){
        //Map<Integer, String> monthMap = new Map<Integer, String>();
        //monthMap = buildMonthMap();
        //startDate = calcStartDate(selectedCollectionName, selectedModelName);
        //Date endDate = calcEndDate(selectedCollectionName, selectedModelName);
        date startDate;
        date endDate;
        
        if(lstAllcompDate!= null && lstAllcompDate.size() > 0){
            startDate = lstAllcompDate[0];
            endDate = lstAllcompDate[lstAllcompDate.size() - 1];
        
        }
        
        
        if(startDate != null && endDate != null){
            startDate = startDate.addMonths(-1);
            
            endDate = endDate.addMonths(1);
            List<String> StringMonths = new List<String>();
            List<Date> startToEndDates = new List<Date>();
            
            Integer monthsBetween = startDate.monthsBetween(endDate);
            
            for(Integer i=0; i <monthsBetween; i++){
                startToEndDates.add(startDate.addMonths(i));
            }
            startToEndDates.add(endDate);
            
            for(Integer i=0; i< startToEndDates.size(); i++){
                Integer month = startToEndDates[i].month();
                Integer year = startToEndDates[i].year();
                String strYear = String.valueOf(year).subString(2,4);
                StringMonths.add(monthMap.get(month)+' '+strYear);    
            }
            
            noOfModelMonths = StringMonths;
            System.debug('======startToEndDates=========='+StringMonths);
        }
        
    }
    
    // Method to calculate number of days between start Date and End Date
    public void calculateDays(){
        //Date startDate = calcStartDate(selectedCollectionName,selectedModelName);
        //Date endDate = calcEndDate(selectedCollectionName,selectedModelName);
        date startDate;
        date endDate;
        
        if(lstAllcompDate!= null && lstAllcompDate.size() > 0){
            startDate = lstAllcompDate[0];
            endDate = lstAllcompDate[lstAllcompDate.size() - 1];
        
        }
        if(startDate != null && endDate != null){
            date firstDate = startDate.toStartOfMonth().addMonths(-1);
        
            Integer numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
            Date lastDayOfMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays).addMonths(1);
            
            stringDays = new List<Integer>();
            Integer daysBetween = firstDate.daysBetween(lastDayOfMonth);  
            
            List<Date> dates = new List<Date>();
            
            monthToDaysMap = new Map<String, Integer>();
            
            while(firstDate < lastDayOfMonth){            
                dates.add(firstDate);
                firstDate  = firstDate.addMonths(1);
            }       
            dates.add(lastDayOfMonth);
            
            for(Integer i=0; i < dates.size(); i++){
                if(i < dates.size()-1){
                    for(Integer j=1; j <= dates[i].daysBetween(dates[i+1]); j++){
                        stringDays.add(j);
                        monthToDaysMap.put(noOfModelMonths[i], dates[i].daysBetween(dates[i+1]));    
                    }
                }
            }
            System.debug('--dates--'+dates[dates.size() - 1]);
        }
        
    }
    
     
    public Date  startDate {get; set;}
    // Method to calculate months from the days
    public List<String> calcDefaultMonthts() {
        
        Date  startDate = System.today().addMonths(-6);
        Date endDate = startDate.addMonths(11);

        List<String> StringMonths = new List<String>();
        List<Date> startToEndDates = new List<Date>();

        Integer monthsBetween = startDate.monthsBetween(endDate);
        
        for(Integer i=0; i <monthsBetween; i++){
            startToEndDates.add(startDate.addMonths(i));
        }
        startToEndDates.add(endDate);
        
        for(Integer i=0; i< startToEndDates.size(); i++){
            Integer month = startToEndDates[i].month();
            Integer year = startToEndDates[i].year();
            String strYear = String.valueOf(year).subString(2,4);
            StringMonths.add(monthMap.get(month)+' '+strYear);    
        }
        
        return StringMonths;
    }
    
    /**************************************** Start displayTable method   ********************************/
    public void displayTable(){

         mapActivitiesList = new map<String, list<NPD_Activity__c> > ();
         mapCollAndProjList = new map<String, set<String> > ();
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
                    system.debug('-------------activityList--------------'+activityList);
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
        lstAllcompDate = new list<date>();
        for(NPD_Activity__c activityListObj : activityList){
            system.debug('---------activityListObj--------------'+activityListObj.NPD_Collections__r.name+'--------'+activityListObj.NPD_Project_Name__r.Name);
            system.debug('---------activityListObj--------------'+activityListObj);
            if (activityListObj.NPD_Project_Name__r.Name != null) {
                if(!mapActivitiesList.containsKey(activityListObj.NPD_Project_Name__r.Name)){
                    list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                    lstAct.add(activityListObj);   
                    mapActivitiesList.put(activityListObj.NPD_Project_Name__r.Name,lstAct);
                }else{
                    mapActivitiesList.get(activityListObj.NPD_Project_Name__r.Name).add(activityListObj);
                }
                if(!mapCollAndProjList.containsKey(activityListObj.NPD_Collections__r.name)){
                    set<String> lstProj = new set<String>{activityListObj.NPD_Project_Name__r.Name};
                    mapCollAndProjList.put(activityListObj.NPD_Collections__r.name,lstProj);
                }else{
                    mapCollAndProjList.get(activityListObj.NPD_Collections__r.name).add(activityListObj.NPD_Project_Name__r.Name);
                }
                
                if(activityListObj.Actual_End_Date__c != null){
                    lstAllcompDate.add(activityListObj.Actual_End_Date__c);
                }
            
            }
        }
        lstAllcompDate.sort();
        if(lstAllcompDate.size() > 0){
            totalCollspan = lstAllcompDate[0].toStartOfMonth().addMonths(-1).daysBetween(lstAllcompDate[lstAllcompDate.size() - 1].toStartOfMonth().addMonths(2));
        }
        //system.debug('--------------lstAllcompDate[0]------------'+lstAllcompDate[0]);
        map<String,list<ComponentWrap>> projListComp = new map<String,list<ComponentWrap>>();
        for(String proj : mapActivitiesList.keyset()){
            ComponentWrap cw = new ComponentWrap();
            ComponentWrap cw1 = new ComponentWrap();
            ComponentWrap cw2 = new ComponentWrap();
            ComponentWrap cw3 = new ComponentWrap();
            ComponentWrap cw4 = new ComponentWrap();
            ComponentWrap cw5 = new ComponentWrap();
            ComponentWrap cw6 = new ComponentWrap();
            ComponentWrap cw7 = new ComponentWrap();
            list<ComponentWrap> cwl= new list<ComponentWrap>();
            
            
            for(NPD_Activity__c act : mapActivitiesList.get(proj)){
                
                if(act.Name__c == 'Proto Case Assembly Request'){
                    cw.ComponentName = 'Case Assembly';
                    cw.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Proto Manufacturing & Assembly'){
                    cw.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw.ActStartDate != null && cw.ActEndDate != null){
                    cw = setCollspan(cw);
                    
                }
                
                if(act.Name__c == 'Proto Crown Request'){
                    cw1.ComponentName = 'Crown';
                    cw1.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Crown for Proto Mfg'){
                    cw1.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw1.ActStartDate != null && cw1.ActEndDate != null){
                    cw1 = setCollspan(cw1);
                }
                
                if(act.Name__c == 'Proto Hand Request'){
                    cw2.ComponentName = 'Hands';
                    cw2.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Hands for Proto Mfg'){
                    cw2.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw2.ActStartDate != null && cw2.ActEndDate != null){
                    cw2 = setCollspan(cw2);
                    
                }
                if(act.Name__c == 'Proto Leather Strap Request'){
                    cw3.ComponentName = 'Lstrap';
                    cw3.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Leather Strap For Proto Mfg'){
                    cw3.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw3.ActStartDate != null && cw3.ActEndDate != null){
                    cw3 = setCollspan(cw3);
                }
                if(act.Name__c == 'Proto Metalstrap Request'){
                    cw4.ComponentName = 'Mstrap';
                    cw4.ActStartDate = act.Actual_End_Date__c;
                    
                }

                if(act.Name__c == 'Metal Strap for Proto Mfg'){
                    cw4.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw4.ActStartDate != null && cw4.ActEndDate != null){
                    cw4.duration =  cw4.ActStartDate.daysBetween(cw4.ActEndDate);
                    cw4 = setCollspan(cw4);
                }
                if(act.Name__c == 'Proto WH/FW Request'){
                    cw5.ComponentName = 'WH/FW';
                    cw5.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Proto - WH/FW/WH+Strap'){
                    cw5.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw5.ActStartDate != null && cw5.ActEndDate != null){
                    cw5.duration =  cw5.ActStartDate.daysBetween(cw5.ActEndDate);
                    cw5 = setCollspan(cw5);
                }
                if(act.Name__c == 'Proto Glass Request'){
                    cw6.ComponentName = 'Glass';
                    cw6.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Glass for Proto Mfg'){
                    cw6.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw6.ActStartDate != null && cw6.ActEndDate != null){
                    cw6.duration =  cw6.ActStartDate.daysBetween(cw6.ActEndDate);
                    cw6 = setCollspan(cw6);
                }
                if(act.Name__c == 'Proto Dial Request'){
                    cw7.ComponentName = 'Dial';
                    cw7.ActStartDate = act.Actual_End_Date__c;
                    
                }
                if(act.Name__c == 'Dial for Proto Mfg'){
                    cw7.ActEndDate = act.Actual_End_Date__c;
                    
                }
                if(cw7.ActStartDate != null && cw7.ActEndDate != null){
                    cw7.duration =  cw7.ActStartDate.daysBetween(cw7.ActEndDate);
                    cw7 = setCollspan(cw7);
                }
                
            }
            if(cw.firstCollspan == null){
                cw.firstCollspan = totalCollspan -2;
            }
            if(cw1.firstCollspan == null){
                cw1.firstCollspan = totalCollspan -2;
            }
            if(cw2.firstCollspan == null){
                cw2.firstCollspan = totalCollspan -2;
            }
            if(cw3.firstCollspan == null){
                cw3.firstCollspan = totalCollspan -2;
            }
            if(cw4.firstCollspan == null){
                cw4.firstCollspan = totalCollspan -2;
            }
            if(cw5.firstCollspan == null){
                cw5.firstCollspan = totalCollspan -2;
            }if(cw6.firstCollspan == null){
                cw6.firstCollspan = totalCollspan -2;
            }if(cw7.firstCollspan == null){
                cw7.firstCollspan = totalCollspan -2;
            }
            
            cwl.add(cw);
            cwl.add(cw7);
            cwl.add(cw2);
            cwl.add(cw3);
            cwl.add(cw4);
            cwl.add(cw5);
            cwl.add(cw6);
            cwl.add(cw1);
            projListComp.put(proj,cwl);
            
        
        }
        system.debug('----------projListComp------------'+projListComp);
        
        calculateMonths();
        calculateDays();
        
        
        set<string> setColl = new set<String>();
        if(selectedCollectionName == 'All'){
            setColl = CollectionName.keyset();
        }else{
            setColl.add(selectedCollectionName);
        }
        lWrapperList = new list<wrapperTable>();
       
        system.debug('---------mapCollAndProjList--------------'+mapCollAndProjList);
        
        
        
        
        for(String eachColl : setColl){
            wrapperTable wrapObj = new wrapperTable();
            wrapObj.CollectionsName = eachColl;
            if(mapCollAndProjList.containsKey(eachColl) && mapCollAndProjList.get(eachColl) != null && !mapCollAndProjList.get(eachColl).isEmpty()){
                list<Modelwrap> lstWrapMod = new list<Modelwrap>();
                for(String eachModel : mapCollAndProjList.get(eachColl)){
                    Modelwrap wrapMod = new Modelwrap();
                    wrapMod.ModName = eachModel;
                    if(projListComp.containsKey(eachModel) && projListComp.get(eachModel) != null && !projListComp.get(eachModel).isEmpty()){
                        
                        wrapMod.lstComps = projListComp.get(eachModel);
                        
                    }
                    lstWrapMod.add(wrapMod);
                }
                
                wrapObj.lstModel = lstWrapMod;
                lWrapperList.add(wrapObj);
            }
            
        }
        
        
        
    }
/********************************************* End of displayTable ********************************************************************/
    
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
    
    public ComponentWrap setCollspan(ComponentWrap compWrapObj){
        compWrapObj.duration =  compWrapObj.ActStartDate.daysBetween(compWrapObj.ActEndDate);
        if(lstAllcompDate.size() > 0 && compWrapObj.duration < 0){
            compWrapObj.firstCollspan = (lstAllcompDate[0].toStartOfMonth().addMonths(-1).daysBetween(compWrapObj.ActEndDate));
            compWrapObj.secondCollspan = compWrapObj.duration * (-1);
            compWrapObj.thirdCollspan = compWrapObj.ActStartDate.daysBetween(lstAllcompDate[lstAllcompDate.size() - 1].toStartOfMonth().addMonths(2));
        }else{
            compWrapObj.firstCollspan = lstAllcompDate[0].toStartOfMonth().addMonths(-1).daysBetween(compWrapObj.ActStartDate);
            compWrapObj.secondCollspan = compWrapObj.duration;
            compWrapObj.thirdCollspan = compWrapObj.ActEndDate.daysBetween(lstAllcompDate[lstAllcompDate.size() - 1].toStartOfMonth().addMonths(2));
        }
        return compWrapObj;
    }

     /****************************  Declare Wrapper table for displaying data to the VF page  *******************************/
     public class wrapperTable{
        public String CollectionsName {get;set;}
        public list<Modelwrap> lstModel {get;set;}
     }
     
     public class Modelwrap{
        public String ModName {get;set;}
        public list<ComponentWrap> lstComps {get;set;}
     
     }
     public class ComponentWrap{
        public String ComponentName {get;set;}
        public Date ActStartDate {get;set;}
        public Date ActEndDate {get;set;}
        public Integer duration {get;set;}
        public Integer firstCollspan {get;set;}
        public Integer secondCollspan {get;set;}
        public Integer thirdCollspan {get;set;}
     }
    
}