public class NPD_Case_Dev_ProductDesign_Report {
    Map<String,list<NPD_Project_Name__c> >  mCollectionToProject = new Map<String,list<NPD_Project_Name__c> >();
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public List < selectoption > npdModelOption {get;set;}
    public List < selectoption > npdStatusOption {get;set;}
    public List < selectoption > npdFunctionOption {get;set;}
    public list<wrapperTable> lWrapperList {get;set;}
    public map < String, npd_stage__c > CollectionName;
    public String selectedBrandName {get;set;}
    public String selectedCollectionName {get;set;}
    public String selectedModelName {get;set;}
    public String selectedStatus {get;set;}
    public String selectedFunctionName {get;set;}
    public Boolean isDisplayTable {get;set;}
    
    public NPD_Case_Dev_ProductDesign_Report() {
        //mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        selectedBrandName = 'None';
        isDisplayTable = false;
        selectBrand();
        selectCollection();
        selectModel();
        selectStatus ();
        selectFunction ();
        System.Debug('@@@@@@@@@@@@@@@'+mCollectionToProject);
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
        if(selectedBrandName == 'All'){
            
       lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c]; 
            
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None'){
            
       lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
            System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            
            //isDisplayTable = true;
        
        
        for (npd_stage__c stage: lstage) {
            if (stage.npd_collections__r.Name != null) {
                CollectionName.put(stage.npd_collections__r.Name, stage);
            }
            system.debug('+++++++++++++++CollectionName+++++++++++++' + CollectionName.values());   
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
       // mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        List<String> ProjectName = new List<String>();
        system.debug('--------CollectionName.keyset()----------'+CollectionName.keyset());
        if (selectedCollectionName == 'All') {
           // lproject=[select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name,PSY_No__c from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName];
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,PSY_No__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset() AND NPD_Collections__r.Name != null];    
            system.debug('--------lproject ----------'+lproject );
            for(NPD_Project_Name__c project : lproject){
                system.debug('--------project.NPD_Collections__r.Name----------'+project.NPD_Collections__r.Name);
                if(project.Name != null &&  project.Name != ''){
                    ProjectName.add(project.Name);
                }
                if(project.NPD_Collections__r.Name != null){
                    if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null )
                    {
                        mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                    }
                    else if(project.NPD_Collections__r.Name != null){
                        
                        mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                        System.debug('@@@@@@@@@@@@'+mCollectionToProject);
                    }   
               } 
            }
            system.debug('----------------ProjectName-------------------'+ProjectName);
            system.debug('----------------mCollectionToProject.keyset(if)-------------------'+mCollectionToProject.keyset());
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
                system.debug('------mCollectionToProject------'+mCollectionToProject.values());         
            }
        }
        npdModelOption.add(new selectoption('None', '--None--'));
        npdModelOption.add(new selectoption('All', 'All'));
        for (String projct : ProjectName) {
            npdModelOption.add(new selectoption(projct , projct));
        }
       
    }
    
    public void selectStatus () {
        npdStatusOption = new list <selectoption> ();
        npdStatusOption.add(new selectoption('None', '--None--'));
        npdStatusOption.add(new selectoption('Case Development - INH', 'Case Development - INH'));
        npdStatusOption.add(new selectoption('Product Design', 'Product Design'));
        npdStatusOption.add(new selectoption('Watch and Component Production', 'Watch and Component Production'));
    }
    
    public void selectFunction () {
        npdFunctionOption = new list <selectoption> ();
        npdFunctionOption.add(new selectoption('None', '--None--'));
        npdFunctionOption.add(new selectoption('All', 'All'));
        npdFunctionOption.add(new selectoption('Case Assembly', 'Case Assembly'));
        npdFunctionOption.add(new selectoption('Machining Pilot', 'Machining Pilot'));
        npdFunctionOption.add(new selectoption('Press Tool Try out', 'Press Tool Try out'));
        npdFunctionOption.add(new selectoption('Press Pilot', 'Press Pilot'));
        npdFunctionOption.add(new selectoption('Polishing Pilot', 'Polishing Pilot'));
        npdFunctionOption.add(new selectoption('Plating Pilot', 'Plating Pilot'));
        npdFunctionOption.add(new selectoption('Product Approval', 'Product Approval'));
        npdFunctionOption.add(new selectoption('Tool Design Release - Alternate', 'Tool Design Release - Alternate'));
        npdFunctionOption.add(new selectoption('Tool Design Release - IMP', 'Tool Design Release - IMP'));
        npdFunctionOption.add(new selectoption('Tool Design Release - Standard', 'Tool Design Release - Standard'));
        npdFunctionOption.add(new selectoption('Tool Manufacturing', 'Tool Manufacturing'));
           
    }
    
    public void displayTable() {
        system.debug('----------mCollectionToProject.keyset-----------'+mCollectionToProject.keyset() );
        //List<NPD_Activity__c > activityLst = new List<NPD_Activity__c >();
         map < String, NPD_Activity__c > mActivityFinalPrdtDrawing = new map < String, NPD_Activity__c > ();  
        List<NPD_Stage__c > stageLst = new List<NPD_Stage__c >();
        lWrapperList = new list<wrapperTable> ();
        if (selectedModelName == 'All') {
            list<String> lstAllProject = new list<String>();
            System.debug('**********selectedCollectionName***********'+selectedCollectionName);
            System.debug('***mCollectionToProject.get(selectedCollectionName)***'+mCollectionToProject.get(selectedCollectionName));
            //System.debug('@@@@@@@@@@@@@@@'+mCollectionToProject.get(selectedCollectionName).size());
            if(selectedCollectionName != 'All'){
                for(NPD_Project_Name__c proj : mCollectionToProject.get(selectedCollectionName)){
                    if(proj.Name != null && proj.Name != ''){
                        lstAllProject.add(proj.Name);
                    }
                }
            }else{
                set<String> setProj = new set<String>();
                for(list<NPD_Project_Name__c> lstProj : mCollectionToProject.values()){
                    for(NPD_Project_Name__c proj: lstProj){
                        setProj.add(proj.Name);
                    }
                }
                if(setProj.size() >0){
                    for(String projName : setProj){
                        lstAllProject.add(projName);
                    }
                }
            
            }
            system.debug('----------lstAllProject -----------'+lstAllProject);
            
            // activityLst = [select Name__c, Brand1__c ,NPD_Stage__r.Name__c, NPD_Stage__c,NPD_Collections__r.name,NPD_Project_Name__r.Name,NPD_Stage__r.Planned_Start_Date__c, NPD_Stage__r.Planned_End_Date__c from NPD_Activity__c where NPD_Stage__r.Name__c = 'Product Design' and NPD_Project_Name__r.Name IN :mCollectionToProject.keyset() and NPD_Collections__r.Name =: selectedCollectionName];
          //  system.debug('----------activityLst(if)-----------'+activityLst );
            stageLst = [Select n.Planned_Start_Date__c, n.Planned_End_Date__c, n.NPD_Project_Name__r.Name, n.NPD_Project_Name__c, n.NPD_Collections__r.Collection_Name__c, n.NPD_Collections__c, n.Brand1__c From NPD_Stage__c n where n.Name__c = 'Product Design' and NPD_Project_Name__r.Name IN :lstAllProject and n.NPD_Collections__r.Collection_Name__c =: CollectionName.keyset()];
            system.debug('----------stageLst -----------'+stageLst);
            //  used for capturing Final Product Drawing Release AD
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: CollectionName.keyset() AND name__c = 'Final Product Drawing Release' AND NPD_Project_Name__r.Name IN :lstAllProject ]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFinalPrdtDrawing.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
        }else{
           // activityLst = [select Name__c, Brand1__c ,NPD_Stage__r.Name__c, NPD_Stage__c,NPD_Collections__r.name,NPD_Project_Name__r.Name,NPD_Stage__r.Planned_Start_Date__c, NPD_Stage__r.Planned_End_Date__c from NPD_Activity__c where NPD_Stage__r.Name__c = 'Product Design' and NPD_Project_Name__r.Name = :selectedModelName and NPD_Collections__r.Name =: selectedCollectionName];
           // system.debug('----------activityLst(else)-----------'+activityLst );
           stageLst = [Select n.Planned_Start_Date__c, n.Planned_End_Date__c, n.NPD_Project_Name__r.Name, n.NPD_Project_Name__c, n.NPD_Collections__r.Collection_Name__c, n.NPD_Collections__c, n.Brand1__c From NPD_Stage__c n where n.Name__c = 'Product Design' and NPD_Project_Name__r.Name = :selectedModelName and n.NPD_Collections__r.Collection_Name__c =: selectedCollectionName];
            
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Final Product Drawing Release' AND NPD_Project_Name__r.Name = :selectedModelName]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFinalPrdtDrawing.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
        }
        for(NPD_Stage__c act : stageLst){
            system.debug('--------act--------'+act );
            wrapperTable collectionTable = new wrapperTable();
            collectionTable.brand = act.Brand1__c;
            collectionTable.collection = act.NPD_Collections__r.Collection_Name__c;
            system.debug('--------act.NPD_Project_Name__r.Name--------'+act.NPD_Project_Name__r.Name );
            collectionTable.model = act.NPD_Project_Name__r.Name;
            collectionTable.productDesignSD = act.Planned_Start_Date__c;
            collectionTable.productDesignED = act.Planned_End_Date__c;
            if(mActivityFinalPrdtDrawing.size()>0 && !(mActivityFinalPrdtDrawing.values()).isEmpty()&& mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name)!=null){
                collectionTable.toolDesignInputSD = mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name).Actual_Start_Date__c;
                collectionTable.toolDesignInputED = mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name).Actual_End_Date__c;
            }
            collectionTable.planLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;   
            collectionTable.actualLT = (collectionTable.toolDesignInputSD != null && collectionTable.toolDesignInputED != null) ? collectionTable.toolDesignInputSD.daysbetween(collectionTable.toolDesignInputED) : null;
            if(collectionTable.planLT != null && collectionTable.actualLT != null){
                collectionTable.variance = collectionTable.actualLT - collectionTable.planLT;
            }
            
            lWrapperList.add(collectionTable);
        }
        system.debug('--------wrapperTable--------'+lWrapperList);
        if(lWrapperList.size() > 0){
            isDisplayTable = true;
        }
    }
    
    public class wrapperTable{
        public String brand {get;set;}
        public String collection {get;set;}
        public String model {get;set;}
        public date productDesignSD {get;set;}
        public date productDesignED {get;set;}
        public date toolDesignInputSD {get;set;}
        public date toolDesignInputED {get;set;}
        public Integer planLT  {get;set;}
        public Integer actualLT  {get;set;}
        public Integer variance  {get;set;}
    }

}