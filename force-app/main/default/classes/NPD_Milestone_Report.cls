/*
    Name        : NPD_Milestone_Report
    Created By  : Anindwita Raj
    Created Date: 25/4/2018
    Description : This report is used to capture and display all the data at milestone level for easier clarity on where the collection or model is.
*/

public class NPD_Milestone_Report {
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public List < selectoption > npdModelOption {get;set;}
    public List < selectoption > npdfiscalYearOption {get;set;}
    public String selectedBrandName {get;set;}
    public String selectedCollectionName {get;set;}
    public String selectedModelName {get;set;}
    public date fromDate {get;set;}  // collect date from visual force page (tentative lunch from date)
    public date toDate {get;set;}  
    public string selectedYear {get;set;}
    public list<wrapperProject> lWrapperList {get;set;}
    public Boolean isDisplayTable {get;set;}
    
    public map < String, npd_stage__c > CollectionName;
    Map<String,list<NPD_Project_Name__c> >  mCollectionToProject = new Map<String,list<NPD_Project_Name__c> >();
    Map<String,list<NPD_Activity__c> >  mProjectToActivity = new Map<String,list<NPD_Activity__c> >();
    Map<String,list<npd_stage__c> >  mProjectToStage = new Map<String,list<npd_stage__c> >();
    
  
    public NPD_Milestone_Report(){
        lWrapperList = new List < wrapperProject> ();
        selectedBrandName = 'None';
        selectedYear = 'None';
        isDisplayTable = false;
        selectBrand();
        selectCollection();
        selectModel();    
        selectYear();   

    }
  
    public void selectBrand() {
        
        npdBrandOption = new List < selectoption > ();
        npdBrandOption.add(new selectoption('None', '--None--'));
        npdBrandOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Type__c = 'Brand' order by Name]) {
            npdBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
  
    public void selectCollection() {
        npdCollectionOption = new List < selectoption > ();
        CollectionName = new map < String, npd_stage__c > ();
        List<String> collectionNamesLst = new list<String>();
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        npdCollectionOption.add(new selectoption('All', 'All'));
        if(selectedBrandName == 'All' && fromDate == null && toDate == null && selectedYear == 'None'){
            lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c]; 
        }else if(selectedBrandName == 'All' && fromDate != null && toDate != null && selectedYear == 'None'){
            lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate ];
        }else if(selectedBrandName != 'All' && selectedBrandName != 'None' && fromDate == null && toDate == null && selectedYear == 'None'){
            lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName]; 
        }else if(selectedBrandName != 'All' && selectedBrandName != 'None' && fromDate != null && toDate != null && selectedYear == 'None'){
            lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
        }else if(selectedBrandName == 'All' && selectedYear != 'None' && fromDate == null && toDate == null){
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
            if (selectedYear == 'THIS_FISCAL_YEAR'){
                lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = THIS_FISCAL_YEAR];
            }else if (selectedYear == 'LAST_N_FISCAL_​YEARS:1'){
                lstage = [select id, name__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = LAST_FISCAL_YEAR];
            }else if (selectedYear == 'LAST_N_FISCAL_​YEARS:2'){
                lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 1)];
            }else if (selectedYear == 'LAST_N_FISCAL_​YEARS:3'){
                lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c >= LAST_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c < LAST_N_FISCAL_YEARS: 2)];
            }else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:1'){
                lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND npd_collections__r.Tentative_Launch_Month_Date__c = NEXT_FISCAL_YEAR limit 999];
            }else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:2'){
                lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 2 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 1)];
            }else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:3'){
                lstage = [select id, name__c, brand1__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
            }else if (selectedYear == 'NEXT_N_FISCAL_​YEARS:4'){
                lstage = [select id, name__c, brand1__c,  npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName AND(npd_collections__r.Tentative_Launch_Month_Date__c <= NEXT_N_FISCAL_YEARS: 3 AND npd_collections__r.Tentative_Launch_Month_Date__c > NEXT_N_FISCAL_YEARS: 2)];
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
  
    public void selectModel() {
        npdModelOption = new list <selectoption> ();
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        List<String> ProjectName = new List<String>();
        system.debug('--------CollectionName.keyset()----------'+CollectionName.keyset());
        if (selectedCollectionName == 'All') {
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,PSY_No__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() AND NPD_Collections__r.Name != null]; 
            system.debug('--------lproject ----------'+lproject );
            for(NPD_Project_Name__c project : lproject){
                if(project.Name != null &&  project.Name != ''){
                    ProjectName.add(project.Name);
                }
                if(project.NPD_Collections__r.Name != null){
                    if(!mCollectionToProject.isEmpty() && mCollectionToProject.containsKey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null )
                    {
                        mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                    }
                    else if(project.NPD_Collections__r.Name != null){
                        mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                    }
                }
            }
        }else{
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name,PSY_No__c from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName];    
            for(NPD_Project_Name__c project : lproject){
                if(project.Name != null &&  project.Name != ''){
                    ProjectName.add(project.Name);
                }
                if(project.NPD_Collections__r.Name != null){
                    if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null)
                    {
                        mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                    }
                    else{
                        mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                    } 
                }
            }  
        }
        npdModelOption.add(new selectoption('None', '--None--'));
        npdModelOption.add(new selectoption('All', 'All'));
        for (String projct : ProjectName) {
            npdModelOption.add(new selectoption(projct , projct));
        }
    }
  
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
    
    public void displayMilestoneTable() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        } 
        system.debug('----------mCollectionToProject.keyset-----------'+mCollectionToProject.keyset() );
        List<NPD_Project_Name__c> lstProject = new List<NPD_Project_Name__c>();
        List<NPD_Stage__c > stageLst = new List<NPD_Stage__c >();
        list<NPD_Activity__c> actLst = new list<NPD_Activity__c>();
        
        if(selectedModelName == 'All') {
            list<String> lstAllProject = new list<String>();
            if(selectedCollectionName != 'All' ){
                if(mCollectionToProject.get(selectedCollectionName) != null){
                    for(NPD_Project_Name__c proj : mCollectionToProject.get(selectedCollectionName)){
                        if(proj.Name != null && proj.Name != ''){
                            lstAllProject.add(proj.Name);
                        }
                    }
                }
            }else{
                set<String> setProj = new set<String>();
                if(mCollectionToProject.containsKey(selectedCollectionName) && !mCollectionToProject.isEmpty()){
                    for(list<NPD_Project_Name__c> lstProj : mCollectionToProject.values()){
                        for(NPD_Project_Name__c proj: lstProj){
                            setProj.add(proj.Name);
                        }
                    }
                }
                if(setProj.size() >0){
                    for(String projName : setProj){
                        lstAllProject.add(projName);
                    }
                }
            
            }
            system.debug('----------lstAllProject -----------'+lstAllProject);
            lstProject = [select id,Name,Brand1__c,ImageUpload__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() AND Name IN :lstAllProject order by NPD_Collections__r.Name];
            system.debug('--------lstProject(for all)----------'+lstProject);
            stageLst = [Select Name__c,Planned_Start_Date__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, Planned_Lead_Time__c, NPD_Project_Name__r.Name, NPD_Collections__r.Collection_Name__c, NPD_Collections__c, Brand1__c From NPD_Stage__c where Name__c IN('Marketing Brief/Concept','Concept Briefing to ISCM','Proto Approval','Watch BO Component Development') AND NPD_Project_Name__r.Name IN :lstAllProject AND NPD_Collections__r.Collection_Name__c IN :CollectionName.keyset()];
            for(NPD_Stage__c stage : stageLst){
                if(!mProjectToStage.isEmpty() && mProjectToStage.containsKey(stage.NPD_Project_Name__r.Name) && mProjectToStage.get(stage.NPD_Project_Name__r.Name) != null){
                    mProjectToStage.get(stage.NPD_Project_Name__r.Name).add(stage);
                }
                else{
                    mProjectToStage.put(stage.NPD_Project_Name__r.Name,new List<NPD_Stage__c>{stage});
                }
            }
            actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Active__c, name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND NPD_Project_Name__r.Name IN :lstAllProject AND name__c IN ('Concept Design - IDS','Engineering Design - IDS','Proto Design Input','Cost Estimation and Approval','Proto Design - Release','Proto Manufacturing & Assembly','Input - Final Product Design','Final Product Drawing Release','Watch Deposition','Product Certification and Handing Over Note','Planned Order Loading')];
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
            lstProject = [select id,Name,Brand1__c,ImageUpload__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName AND Name = :selectedModelName order by NPD_Collections__r.Name]; 
            system.debug('--------lstProject(else )----------'+lstProject);
            stageLst = [Select Name__c,Planned_Start_Date__c, Planned_End_Date__c, Actual_Start_Date__c, Actual_End_Date__c, Planned_Lead_Time__c, NPD_Project_Name__r.Name, NPD_Collections__r.Collection_Name__c, NPD_Collections__c, Brand1__c From NPD_Stage__c where Name__c IN('Marketing Brief/Concept','Concept Briefing to ISCM','Proto Approval','Watch BO Component Development') AND NPD_Project_Name__r.Name =: selectedModelName AND NPD_Collections__r.Collection_Name__c =: selectedCollectionName];
            for(NPD_Stage__c stage : stageLst){
                if(!mProjectToStage.isEmpty() && mProjectToStage.containsKey(stage.NPD_Project_Name__r.Name) && mProjectToStage.get(stage.NPD_Project_Name__r.Name) != null){
                    mProjectToStage.get(stage.NPD_Project_Name__r.Name).add(stage);
                }
                else{
                    mProjectToStage.put(stage.NPD_Project_Name__r.Name,new List<NPD_Stage__c>{stage});
                }
            }
            actLst = [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Active__c, name__c,Actual_Start_Date__c,Actual_End_Date__c,Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND NPD_Project_Name__r.Name = :selectedModelName AND name__c IN ('Concept Design - IDS','Engineering Design - IDS','Proto Design Input','Cost Estimation and Approval','Proto Design - Release','Proto Manufacturing & Assembly','Input - Final Product Design','Final Product Drawing Release','Watch Deposition','Product Certification and Handing Over Note','Planned Order Loading')];
            for(NPD_Activity__c activityList: actLst){
                if(!mProjectToActivity.isEmpty() && mProjectToActivity.containsKey(activityList.NPD_Project_Name__r.Name) && mProjectToActivity.get(activityList.NPD_Project_Name__r.Name) != null)
                {
                    mProjectToActivity.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                }
                else{
                    mProjectToActivity.put(activityList.NPD_Project_Name__r.Name,new List<NPD_Activity__c>{activityList});
                }
            }
        }
        for(NPD_Project_Name__c proj : lstProject){
            
            wrapperProject wrapProj  = new wrapperProject();
            wrapProj.projObj = proj;
            
            
            if(mProjectToStage.size()>0 && mProjectToStage.containsKey(proj.Name) && mProjectToStage.get(proj.Name)!=null){
                system.debug('--------mProjectToStage(start date)----------'+mProjectToStage.get(proj.Name));
                for(NPD_Stage__c stageProj : mProjectToStage.get(proj.Name)){ 
                    system.debug('----------stageProj-----------'+stageProj);
                    if(stageProj.Name__c == 'Marketing Brief/Concept')
                    {
                        wrapProj.marketComponentName = 'Marketing Brief';
                        wrapProj.marketingBriefPSD = stageProj.Planned_Start_Date__c;
                        wrapProj.marketingBriefPED = stageProj.Planned_Start_Date__c.addDays(3);
                        wrapProj.marketingBriefASD = stageProj.Actual_Start_Date__c;
                        wrapProj.marketingBriefAED = stageProj.Actual_End_Date__c;
                        wrapProj.marketingBriefPLT = stageProj.Planned_Lead_Time__c;
                        wrapProj.marketingBriefLT = 0;
                    }
                    if(stageProj.Name__c == 'Concept Briefing to ISCM'){
                        wrapProj.briefComponentName = 'ISCM Briefing';
                        wrapProj.conceptBriefingPSD = stageProj.Planned_Start_Date__c;
                        wrapProj.conceptBriefingPED = stageProj.Planned_End_Date__c;
                        wrapProj.conceptBriefingASD = stageProj.Actual_Start_Date__c;
                        wrapProj.conceptBriefingAED = stageProj.Actual_End_Date__c;
                        wrapProj.conceptBriefingPLT = stageProj.Planned_Lead_Time__c;   
                    }
                    if(stageProj.Name__c == 'Proto Approval'){
                        wrapProj.protoAppComponentName = 'Proto & Cost App';
                        wrapProj.protoApprovalPSD = stageProj.Planned_Start_Date__c;
                        wrapProj.protoApprovalPED = stageProj.Planned_End_Date__c;
                        wrapProj.protoApprovalASD = stageProj.Actual_Start_Date__c;
                        wrapProj.protoApprovalAED = stageProj.Actual_End_Date__c;
                        wrapProj.protoApprovalPLT = stageProj.Planned_Lead_Time__c;   
                    }
                    if(stageProj.Name__c == 'Watch BO Component Development'){
                        wrapProj.watchBOComponentName = 'Sample Development';
                        wrapProj.watchBOCompPSD = stageProj.Planned_Start_Date__c;
                        wrapProj.watchBOCompPED = stageProj.Planned_End_Date__c;
                        wrapProj.watchBOCompASD = stageProj.Actual_Start_Date__c;
                        wrapProj.watchBOCompAED = stageProj.Actual_End_Date__c;
                        wrapProj.watchBOCompPLT = stageProj.Planned_Lead_Time__c;   
                    }
                }
            }
            if(mProjectToActivity.size()>0 && mProjectToActivity.containsKey(proj.Name) && mProjectToActivity.get(proj.Name)!=null){
                
                for(NPD_Activity__c act : mProjectToActivity.get(proj.Name)){
                    system.debug('----------act-----------'+act);
                    if(act.Name__c == 'Concept Design - IDS'){
                        wrapProj.conceptComponentName = 'Concept Design';
                        wrapProj.conceptDesignASD = act.Actual_Start_Date__c;
                        wrapProj.conceptDesignAED = act.Actual_End_Date__c;
                        wrapProj.conceptDesignPLT = act.Planned_Lead_Time__c ;    
                    }
                    if(act.Name__c == 'Engineering Design - IDS'){
                        wrapProj.engineerComponentName = 'Engg Design';
                        wrapProj.engineerDesignASD = act.Actual_Start_Date__c;
                        wrapProj.engineerDesignAED = act.Actual_End_Date__c;
                        wrapProj.engineerDesignPLT = act.Planned_Lead_Time__c ;   
                    }
                    if(act.Name__c == 'Proto Design Input'){
                        wrapProj.protoDesComponentName = 'FW Input';
                        wrapProj.protoDesignInputASD = act.Actual_Start_Date__c;
                        wrapProj.protoDesignInputAED = act.Actual_End_Date__c;
                        wrapProj.protoDesignInputPLT = act.Planned_Lead_Time__c ;     
                    }
                    if(act.Name__c == 'Cost Estimation and Approval'){
                        wrapProj.costEstComponentName = 'Tentative Cost Approval';
                        wrapProj.costEstimationASD = act.Actual_Start_Date__c;
                        wrapProj.costEstimationAED = act.Actual_End_Date__c;
                        wrapProj.costEstimationPLT = act.Planned_Lead_Time__c ;   
                    }
                    if(act.Name__c == 'Proto Design - Release'){
                        wrapProj.protoRelComponentName = 'Proto Tech Design';
                        wrapProj.protoDesgnRelsASD = act.Actual_Start_Date__c;
                        wrapProj.protoDesgnRelsAED = act.Actual_End_Date__c;
                        wrapProj.protoDesgnRelsPLT = act.Planned_Lead_Time__c ;     
                    }
                    if(act.Name__c == 'Proto Manufacturing & Assembly'){
                        wrapProj.protoManfComponentName = 'Proto Delivery';
                        wrapProj.protoManufacturingASD = act.Actual_Start_Date__c;
                        wrapProj.protoManufacturingAED = act.Actual_End_Date__c;
                        wrapProj.protoManufacturingPLT = act.Planned_Lead_Time__c ;   
                    }
                    if(act.Name__c == 'Input - Final Product Design'){
                        wrapProj.inputComponentName = 'Final Input';
                        wrapProj.inputFinalProdASD = act.Actual_Start_Date__c;
                        wrapProj.inputFinalProdAED = act.Actual_End_Date__c;
                        wrapProj.inputFinalProdPLT = act.Planned_Lead_Time__c ;    
                    }
                    if(act.Name__c == 'Final Product Drawing Release'){
                        wrapProj.finalComponentName = 'Final Drg';
                        wrapProj.finalProdDrawASD = act.Actual_Start_Date__c;
                        wrapProj.finalProdDrawAED = act.Actual_End_Date__c;
                        wrapProj.finalProdDrawPLT = act.Planned_Lead_Time__c ;    
                    }
                    if(act.Name__c == 'Watch Deposition'){
                        wrapProj.watchComponentName = 'Delivery';
                        wrapProj.watchDepositionASD = act.Actual_Start_Date__c;
                        wrapProj.watchDepositionAED = act.Actual_End_Date__c;
                        wrapProj.watchDepositionPLT = act.Planned_Lead_Time__c ;   
                    }
                    if(act.Name__c == 'Product Certification and Handing Over Note'){
                        wrapProj.prodComponentName = 'Handing Over';
                        wrapProj.prodCertificateASD = act.Actual_Start_Date__c;
                        wrapProj.prodCertificateAED = act.Actual_End_Date__c;
                        wrapProj.prodCertificatePLT = act.Planned_Lead_Time__c ;     
                    }
                    if(act.Name__c == 'Planned Order Loading'){
                        wrapProj.plannedComponentName = 'Plan Loading';
                        wrapProj.plannedOrderASD = act.Actual_Start_Date__c;
                        wrapProj.plannedOrderAED = act.Actual_End_Date__c;
                        wrapProj.plannedOrderPLT = act.Planned_Lead_Time__c ; 
                    }
                }
                if(wrapProj.engineerDesignAED != null && wrapProj.conceptBriefingAED != null){
                    wrapProj.conceptBriefingLT = wrapProj.engineerDesignAED.daysbetween(wrapProj.conceptBriefingAED);
                } 
                if(wrapProj.protoManufacturingAED != null && wrapProj.protoApprovalAED != null){
                    wrapProj.protoApprovalLT = wrapProj.protoManufacturingAED.daysbetween(wrapProj.protoApprovalAED);
                } 
                if(wrapProj.finalProdDrawAED != null && wrapProj.watchBOCompAED != null){
                    wrapProj.watchBOCompLT = wrapProj.finalProdDrawAED.daysbetween(wrapProj.watchBOCompAED);
                } 
                if(wrapProj.marketingBriefAED != null && wrapProj.conceptDesignAED != null){
                    wrapProj.conceptDesignLT = wrapProj.marketingBriefAED.daysbetween(wrapProj.conceptDesignAED);
                } 
                if(wrapProj.engineerDesignAED != null && wrapProj.conceptDesignAED != null){
                    wrapProj.engineerDesignLT = wrapProj.conceptDesignAED.daysbetween(wrapProj.engineerDesignAED);
                } 
                if(wrapProj.costEstimationAED != null && wrapProj.protoDesignInputAED != null){
                    wrapProj.costEstimationLT = wrapProj.protoDesignInputAED.daysbetween(wrapProj.costEstimationAED);
                } 
                if(wrapProj.conceptBriefingAED != null && wrapProj.protoDesignInputAED != null){
                    wrapProj.protoDesignInputLT = wrapProj.conceptBriefingAED.daysbetween(wrapProj.protoDesignInputAED);
                }
                if(wrapProj.protoDesgnRelsAED != null && wrapProj.costEstimationAED != null){
                    wrapProj.protoDesgnRelsLT = wrapProj.costEstimationAED.daysbetween(wrapProj.protoDesgnRelsAED);
                }
                if(wrapProj.protoManufacturingAED != null && wrapProj.protoDesgnRelsAED != null){
                    wrapProj.protoManufacturingLT = wrapProj.protoDesgnRelsAED.daysbetween(wrapProj.protoManufacturingAED);
                } 
                if(wrapProj.inputFinalProdAED != null && wrapProj.protoApprovalAED != null){
                    wrapProj.inputFinalProdLT = wrapProj.protoApprovalAED.daysbetween(wrapProj.inputFinalProdAED);
                } 
                if(wrapProj.finalProdDrawAED != null && wrapProj.inputFinalProdAED != null){
                    wrapProj.finalProdDrawLT = wrapProj.inputFinalProdAED.daysbetween(wrapProj.finalProdDrawAED); 
                }
                if(wrapProj.watchDepositionAED != null && wrapProj.plannedOrderAED != null){
                    wrapProj.watchDepositionLT = wrapProj.plannedOrderAED.daysbetween(wrapProj.watchDepositionAED); 
                } 
                if(wrapProj.prodCertificateAED != null && wrapProj.watchDepositionAED != null){
                    wrapProj.prodCertificateLT = wrapProj.watchDepositionAED.daysbetween(wrapProj.prodCertificateAED);
                }
                if(wrapProj.watchBOCompAED != null && wrapProj.plannedOrderAED != null){
                    wrapProj.plannedOrderLT = wrapProj.watchBOCompAED.daysbetween(wrapProj.plannedOrderAED);
                }  
            }
            lWrapperList.add(wrapProj);
        }
        
        if(lWrapperList.size() > 0){
            isDisplayTable = true;
        }
    }
    
    public class wrapperProject{
        public NPD_Project_Name__c projObj{get;set;}
        public String marketComponentName {get;set;}
        public Date marketingBriefPSD{get;set;}             //variable for marketing brief stage planned start date
        public Date marketingBriefPED{get;set;}             //variable for marketing brief stage planned end date
        public Decimal marketingBriefPLT{get;set;}          //variable for marketing brief stage planned lead time
        public Date marketingBriefASD{get;set;}             //variable for marketing brief stage actual start date
        public Date marketingBriefAED{get;set;}             //variable for marketing brief stage actual end date
        public Integer marketingBriefLT{get;set;}           //variable for calculating marketing brief lead time
        
        public String conceptComponentName {get;set;}
        public Date conceptDesignASD{get;set;}              //variable for concept design IDS activity actual start date
        public Date conceptDesignAED{get;set;}
        public Decimal conceptDesignPLT{get;set;}
        public Integer conceptDesignLT{get;set;}
        
        public String engineerComponentName {get;set;}
        public Date engineerDesignASD{get;set;}
        public Date engineerDesignAED{get;set;}
        public Decimal engineerDesignPLT{get;set;}
        public Integer engineerDesignLT{get;set;}
        
        public String briefComponentName {get;set;}
        public Date conceptBriefingPSD{get;set;}
        public Date conceptBriefingPED{get;set;}
        public Date conceptBriefingASD{get;set;}
        public Date conceptBriefingAED{get;set;}
        public Decimal conceptBriefingPLT{get;set;}
        public Integer conceptBriefingLT{get;set;}
        
        public String protoDesComponentName {get;set;}
        public Date protoDesignInputASD{get;set;}
        public Date protoDesignInputAED{get;set;}
        public Decimal protoDesignInputPLT{get;set;}
        public Integer protoDesignInputLT{get;set;}
        
        public String costEstComponentName {get;set;}
        public Date costEstimationASD{get;set;}
        public Date costEstimationAED{get;set;}
        public Decimal costEstimationPLT{get;set;}
        public Integer costEstimationLT{get;set;}
        
        public String protoRelComponentName {get;set;}
        public Date protoDesgnRelsASD{get;set;}
        public Date protoDesgnRelsAED{get;set;}
        public Decimal protoDesgnRelsPLT{get;set;}
        public Integer protoDesgnRelsLT{get;set;}
        
        public String protoManfComponentName {get;set;}
        public Date protoManufacturingASD{get;set;}
        public Date protoManufacturingAED{get;set;}
        public Decimal protoManufacturingPLT{get;set;}
        public Integer protoManufacturingLT{get;set;}
        
        public String protoAppComponentName {get;set;}
        public Date protoApprovalPSD{get;set;}
        public Date protoApprovalPED{get;set;}
        public Decimal protoApprovalPLT{get;set;}
        public Date protoApprovalASD{get;set;}
        public Date protoApprovalAED{get;set;}
        public Integer protoApprovalLT{get;set;}
        
        public String inputComponentName {get;set;}
        public Date inputFinalProdASD{get;set;}
        public Date inputFinalProdAED{get;set;}
        public Decimal inputFinalProdPLT{get;set;}
        public Integer inputFinalProdLT{get;set;}
        
        public String finalComponentName {get;set;}
        public Date finalProdDrawASD{get;set;}
        public Date finalProdDrawAED{get;set;}
        public Decimal finalProdDrawPLT{get;set;}
        public Integer finalProdDrawLT{get;set;}
        
        public String watchComponentName {get;set;}
        public Date watchDepositionASD{get;set;}
        public Date watchDepositionAED{get;set;}
        public Decimal watchDepositionPLT{get;set;}
        public Integer watchDepositionLT{get;set;}
        
        public String prodComponentName {get;set;}
        public Date prodCertificateASD{get;set;}
        public Date prodCertificateAED{get;set;}
        public Decimal prodCertificatePLT{get;set;}
        public Integer prodCertificateLT{get;set;}
        
        public String watchBOComponentName {get;set;}
        public Date watchBOCompPSD{get;set;}
        public Date watchBOCompPED{get;set;}
        public Date watchBOCompASD{get;set;}
        public Date watchBOCompAED{get;set;}
        public Decimal watchBOCompPLT{get;set;}
        public Integer watchBOCompLT{get;set;} 
        
        public String plannedComponentName{get;set;} 
        public Date plannedOrderASD {get;set;}
        public Date plannedOrderAED {get;set;}
        public Decimal plannedOrderPLT {get;set;}
        public Integer plannedOrderLT{get;set;}
    }   
}