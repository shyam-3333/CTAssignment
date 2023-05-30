public class NPD_Case_Devel_INH_Report {
    
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public List < selectoption > npdModelOption {get;set;}
    public List < selectoption > npdStatusOption {get;set;}
    public List < selectoption > npdFunctionOption {get;set;}
    public list<wrapperTable> lWrapperList {get;set;}
    public list<String> All;
    public list<String> lstAllProject;
    public map < String, npd_stage__c > CollectionName;
    public Map<String,list<NPD_Project_Name__c>>  mCollectionToProject;
    public map<String, list<NPD_Activity__c> > mapActivitiesList;
    public String selectedBrandName {get;set;}
    public String selectedCollectionName {get;set;}
    public String selectedModelName {get;set;}
    public String selectedStatus {get;set;}
    public String selectedFunctionName {get;set;}
    public String headerVal {get;set;}
    public String header {get;set;}
    public String subHeader {get;set;}
    public Boolean isDisplayTable {get;set;}
    public Boolean isDisplayColumn {get;set;}
    public Boolean isNoDisplayTable {get;set;}
    
    public NPD_Case_Devel_INH_Report() {
        mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        selectedBrandName = 'None';
        isDisplayTable = false;
        isDisplayColumn = false;
        isNoDisplayTable = true;
        selectBrand();
        selectCollection();
        selectModel();
        selectStatus ();
        selectFunction ();
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
        //mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        List<NPD_Project_Name__c> lproject = new List<NPD_Project_Name__c>();
        List<String> ProjectName = new List<String>();
        
        if (selectedCollectionName == 'All') {
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,PSY_No__c, NPD_Collections__r.Name from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name IN: CollectionName.keyset()];    
            for(NPD_Project_Name__c project : lproject){
                ProjectName.add(project.Name);
                if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null)
                {
                    mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                }
                else{
                    mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
                }   
            }
        }else{
            lproject = [select id,Name,Brand1__c,NPD_Collections__c,NPD_Collections__r.Name,PSY_No__c from NPD_Project_Name__c where Name != 'Marketing Brief/Concept Stage' AND NPD_Collections__r.Name =: selectedCollectionName];    
            for(NPD_Project_Name__c project : lproject){
                ProjectName.add(project.Name);
                if(!mCollectionToProject.isEmpty() && mCollectionToProject.containskey(project.NPD_Collections__r.Name) && mCollectionToProject.get(project.NPD_Collections__r.Name) != null)
                {
                    mCollectionToProject.get(project.NPD_Collections__r.Name).add(project);
                }
                else{
                    mCollectionToProject.put(project.NPD_Collections__r.Name,new List<NPD_Project_Name__c>{project});
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
        //All = new list<String> ();
        All = new list<String> {'Press Tool Drawing Release - Case Development - INH','Alternate option - Press Tool Drawing Release','IMP Press Blank - Press Tool Drawing Release','Press Tool Delivery - Case Development - INH','Press Blank Trials - Case Development - INH','Pilot Lot Manufacturing - Press - Case Development - INH','Pilot Lot Manufacturing - Machining - Case Development - INH','Pilot Lot Manufacturing - Polishing - Case Development - INH','Pilot Lot Manufacturing -Plating - Case Development - INH','Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly','Pilot Lot Manufacturing - Case Assembly - Case Development - INH'};
        //All.add('Press Tool Drawing Release - Case Development - INH');
        //All.add('Alternate option - Press Tool Drawing Release');
        
        npdFunctionOption = new list <selectoption> ();
        npdFunctionOption.add(new selectoption('None', '--None--'));
        npdFunctionOption.add(new selectoption('All', 'All'));
        npdFunctionOption.add(new selectoption('Pilot Lot Manufacturing - Case Assembly - Case Development - INH', 'Case Assembly'));
        npdFunctionOption.add(new selectoption('Pilot Lot Manufacturing - Machining - Case Development - INH', 'Machining Pilot'));
        npdFunctionOption.add(new selectoption('Pilot Lot Manufacturing -Plating - Case Development - INH', 'Plating Pilot'));
        npdFunctionOption.add(new selectoption('Pilot Lot Manufacturing - Polishing - Case Development - INH', 'Polishing Pilot'));
        npdFunctionOption.add(new selectoption('Pilot Lot Manufacturing - Press - Case Development - INH', 'Press Pilot'));
        npdFunctionOption.add(new selectoption('Press Blank Trials - Case Development - INH', 'Press Tool Try out'));
        npdFunctionOption.add(new selectoption('Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly', 'Product Approval'));
        npdFunctionOption.add(new selectoption('Alternate option - Press Tool Drawing Release', 'Tool Design Release - Alternate'));
        npdFunctionOption.add(new selectoption('IMP Press Blank - Press Tool Drawing Release', 'Tool Design Release - IMP'));
        npdFunctionOption.add(new selectoption('Press Tool Drawing Release - Case Development - INH', 'Tool Design Release - Standard'));
        npdFunctionOption.add(new selectoption('Press Tool Delivery - Case Development - INH', 'Tool Manufacturing'));
           
    }
        
    public void displayTable() {
        
        isNoDisplayTable = false;
        system.debug('----------mCollectionToProject.keyset-----------'+mCollectionToProject.keyset() );
        //List<NPD_Activity__c > activityLst = new List<NPD_Activity__c >();
        map < String, NPD_Activity__c > mActivityFinalPrdtDrawing = new map < String, NPD_Activity__c > (); 
        map < String, NPD_Activity__c > mActivityCFTScheduling = new map < String, NPD_Activity__c > ();
        List<NPD_Stage__c > stageLst = new List<NPD_Stage__c >();
        lWrapperList = new list<wrapperTable> ();
        if (selectedModelName == 'All') {
            lstAllProject = new list<String>();
            for(NPD_Project_Name__c proj : mCollectionToProject.get(selectedCollectionName)){
                lstAllProject.add(proj.Name);
            }
            
            stageLst = [Select n.Planned_Start_Date__c, n.Planned_End_Date__c, n.NPD_Project_Name__r.Name, n.NPD_Project_Name__c, n.NPD_Collections__r.Collection_Name__c, n.NPD_Collections__c, n.Brand1__c From NPD_Stage__c n where n.Name__c = 'Product Design' and NPD_Project_Name__r.Name IN :lstAllProject and n.NPD_Collections__r.Collection_Name__c =: selectedCollectionName];
            system.debug('----------stageLst -----------'+stageLst);
            
            //  used for capturing Final Product Drawing Release AD
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Final Product Drawing Release' AND NPD_Project_Name__r.Name IN :lstAllProject ]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFinalPrdtDrawing.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            
            // used for capturing CFT Scheduling - Case Development INH SD
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Press_Tool_Design_Input_date__c, Pilot_Lot_Manufacturing__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'CFT Scheduling - Case Development - INH' AND NPD_Project_Name__r.Name IN :lstAllProject ]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityCFTScheduling.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            displayCaseINHActivity();
        }else{
           
           stageLst = [Select n.Planned_Start_Date__c, n.Planned_End_Date__c, n.NPD_Project_Name__r.Name, n.NPD_Project_Name__c, n.NPD_Collections__r.Collection_Name__c, n.NPD_Collections__c, n.Brand1__c From NPD_Stage__c n where n.Name__c = 'Product Design' and NPD_Project_Name__r.Name = :selectedModelName and n.NPD_Collections__r.Collection_Name__c =: selectedCollectionName];
            
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Final Product Drawing Release' AND NPD_Project_Name__r.Name = :selectedModelName]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityFinalPrdtDrawing.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            
            // used for capturing CFT Scheduling - Case Development INH SD
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Press_Tool_Design_Input_date__c, Pilot_Lot_Manufacturing__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'CFT Scheduling - Case Development - INH' AND NPD_Project_Name__r.Name = :selectedModelName ]){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityCFTScheduling.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            displayCaseINHActivity();
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
            if(mActivityCFTScheduling.size()>0 && mActivityCFTScheduling.containskey(act.NPD_Project_Name__r.Name) && mActivityCFTScheduling.get(act.NPD_Project_Name__r.Name)!=null){
                collectionTable.pressToolDesignInputSD = mActivityCFTScheduling.get(act.NPD_Project_Name__r.Name).Press_Tool_Design_Input_date__c;
                collectionTable.pilotLotManufacturingED = mActivityCFTScheduling.get(act.NPD_Project_Name__r.Name).Pilot_Lot_Manufacturing__c;
            }
            collectionTable.casePlanLT = (collectionTable.pressToolDesignInputSD != null && collectionTable.pilotLotManufacturingED != null) ? collectionTable.pressToolDesignInputSD.daysbetween(collectionTable.pilotLotManufacturingED) : null;
            if(mActivityFinalPrdtDrawing.size()>0 && mActivityFinalPrdtDrawing.containskey(act.NPD_Project_Name__r.Name) && mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name)!=null){
                collectionTable.toolDesignInputSD = mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name).Actual_Start_Date__c;
                collectionTable.toolDesignInputED = mActivityFinalPrdtDrawing.get(act.NPD_Project_Name__r.Name).Actual_End_Date__c;
            }
            collectionTable.planLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;   
            collectionTable.actualLT = (collectionTable.toolDesignInputSD != null && collectionTable.toolDesignInputED != null) ? collectionTable.toolDesignInputSD.daysbetween(collectionTable.toolDesignInputED) : null;
            if(collectionTable.planLT != null && collectionTable.actualLT != null){
                collectionTable.variance = collectionTable.actualLT - collectionTable.planLT;
            }
            
            if(mapActivitiesList.size()>0 && mapActivitiesList.containskey(act.NPD_Project_Name__r.Name) && mapActivitiesList.get(act.NPD_Project_Name__r.Name)!=null){
                system.debug('--------mapActivitiesList(start date)----------'+mapActivitiesList.get(act.NPD_Project_Name__r.Name));
                for(NPD_Activity__c activity : mapActivitiesList.get(act.NPD_Project_Name__r.Name)){
                    if(activity.name__c == 'Press Tool Drawing Release - Case Development - INH'){
                        collectionTable.pressToolDrawingRlsSD = activity.Actual_Start_Date__c;
                        collectionTable.pressToolDrawingRlsED = activity.Actual_End_Date__c;
                        collectionTable.pressToolPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pressToolActualLT = (collectionTable.pressToolDrawingRlsSD != null && collectionTable.pressToolDrawingRlsED != null) ? collectionTable.pressToolDrawingRlsSD.daysbetween(collectionTable.pressToolDrawingRlsED) : null;
                       // if(isDisplayColumn){
                            collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                            collectionTable.DynamicED = activity.Actual_End_Date__c;
                            collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                            collectionTable.DynamicActualLT = (collectionTable.pressToolDrawingRlsSD != null && collectionTable.pressToolDrawingRlsED != null) ? collectionTable.pressToolDrawingRlsSD.daysbetween(collectionTable.pressToolDrawingRlsED) : null;
                        
                       // }
                    }
                    if(activity.name__c == 'Alternate option - Press Tool Drawing Release'){
                        collectionTable.alternatePressToolDrawingRlsSD = activity.Actual_Start_Date__c;
                        collectionTable.alternatePressToolDrawingRlsED = activity.Actual_End_Date__c;
                        collectionTable.altrntPressToolPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.altrntPressToolActualLT = (collectionTable.alternatePressToolDrawingRlsSD != null && collectionTable.alternatePressToolDrawingRlsED != null) ? collectionTable.alternatePressToolDrawingRlsSD.daysbetween(collectionTable.alternatePressToolDrawingRlsED) : null;
                      //  if(isDisplayColumn){
                            collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                            collectionTable.DynamicED = activity.Actual_End_Date__c;
                            collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                            collectionTable.DynamicActualLT = (collectionTable.alternatePressToolDrawingRlsSD != null && collectionTable.alternatePressToolDrawingRlsED != null) ? collectionTable.alternatePressToolDrawingRlsSD.daysbetween(collectionTable.alternatePressToolDrawingRlsED) : null;
                        
                       // }
                    }
                    if(activity.name__c == 'IMP Press Blank - Press Tool Drawing Release'){
                        collectionTable.IMPpressBlankSD  = activity.Actual_Start_Date__c;
                        collectionTable.IMPpressBlankED  = activity.Actual_End_Date__c;
                        collectionTable.IMPpressBlankPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.IMPpressBlankActualLT = (collectionTable.IMPpressBlankSD != null && collectionTable.IMPpressBlankED != null) ? collectionTable.IMPpressBlankSD.daysbetween(collectionTable.IMPpressBlankED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.IMPpressBlankSD != null && collectionTable.IMPpressBlankED != null) ? collectionTable.IMPpressBlankSD.daysbetween(collectionTable.IMPpressBlankED) : null;

                    }
                    if(activity.name__c == 'Press Tool Delivery - Case Development - INH'){
                        collectionTable.pressToolDeliverySD   = activity.Actual_Start_Date__c;
                        collectionTable.pressToolDeliveryED   = activity.Actual_End_Date__c;
                        collectionTable.pressToolDeliveryPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pressToolDeliveryActualLT = (collectionTable.pressToolDeliverySD != null && collectionTable.pressToolDeliveryED != null) ? collectionTable.pressToolDeliverySD.daysbetween(collectionTable.pressToolDeliveryED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pressToolDeliverySD != null && collectionTable.pressToolDeliveryED != null) ? collectionTable.pressToolDeliverySD.daysbetween(collectionTable.pressToolDeliveryED) : null;
                    
                    }
                    if(activity.name__c == 'Press Blank Trials - Case Development - INH'){
                        collectionTable.pressBlankTrialsSD   = activity.Actual_Start_Date__c;
                        collectionTable.pressBlankTrialsED   = activity.Actual_End_Date__c;
                        collectionTable.pressBlankTrialsPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pressBlankTrialsActualLT = (collectionTable.pressBlankTrialsSD != null && collectionTable.pressBlankTrialsED != null) ? collectionTable.pressBlankTrialsSD.daysbetween(collectionTable.pressBlankTrialsED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pressBlankTrialsSD != null && collectionTable.pressBlankTrialsED != null) ? collectionTable.pressBlankTrialsSD.daysbetween(collectionTable.pressBlankTrialsED) : null;
                    
                    }
                    if(activity.name__c == 'Pilot Lot Manufacturing - Press - Case Development - INH'){
                        collectionTable.pilotManufPressSD   = activity.Actual_Start_Date__c;
                        collectionTable.pilotManufPressED   = activity.Actual_End_Date__c;
                        collectionTable.pilotManufPressPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pilotManufPressActualLT = (collectionTable.pilotManufPressSD != null && collectionTable.pilotManufPressED != null) ? collectionTable.pilotManufPressSD.daysbetween(collectionTable.pilotManufPressED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pilotManufPressSD != null && collectionTable.pilotManufPressED != null) ? collectionTable.pilotManufPressSD.daysbetween(collectionTable.pilotManufPressED) : null;
                    
                    }
                    if(activity.name__c == 'Pilot Lot Manufacturing - Machining - Case Development - INH'){
                        collectionTable.pilotManufMachineSD   = activity.Actual_Start_Date__c;
                        collectionTable.pilotManufMachineED   = activity.Actual_End_Date__c;
                        collectionTable.pilotManufMachinePlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pilotManufMachineActualLT = (collectionTable.pilotManufMachineSD != null && collectionTable.pilotManufMachineED != null) ? collectionTable.pilotManufMachineSD.daysbetween(collectionTable.pilotManufMachineED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pilotManufMachineSD != null && collectionTable.pilotManufMachineED != null) ? collectionTable.pilotManufMachineSD.daysbetween(collectionTable.pilotManufMachineED) : null;
                    
                    }
                    if(activity.name__c == 'Pilot Lot Manufacturing - Polishing - Case Development - INH'){
                        collectionTable.pilotManufPolishingSD    = activity.Actual_Start_Date__c;
                        collectionTable.pilotManufPolishingED    = activity.Actual_End_Date__c;
                        collectionTable.pilotManufPolishingPlanLT   = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pilotManufPolishingActualLT = (collectionTable.pilotManufPolishingSD != null && collectionTable.pilotManufPolishingED != null) ? collectionTable.pilotManufPolishingSD.daysbetween(collectionTable.pilotManufPolishingED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pilotManufPolishingSD != null && collectionTable.pilotManufPolishingED != null) ? collectionTable.pilotManufPolishingSD.daysbetween(collectionTable.pilotManufPolishingED) : null;
                    
                    }
                    if(activity.name__c == 'Pilot Lot Manufacturing -Plating - Case Development - INH'){
                        collectionTable.pilotManufPlatingSD    = activity.Actual_Start_Date__c;
                        collectionTable.pilotManufPlatingED    = activity.Actual_End_Date__c;
                        collectionTable.pilotManufPlatingPlanLT  = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pilotManufPlatingActualLT = (collectionTable.pilotManufPlatingSD != null && collectionTable.pilotManufPlatingED != null) ? collectionTable.pilotManufPlatingSD.daysbetween(collectionTable.pilotManufPlatingED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pilotManufPlatingSD != null && collectionTable.pilotManufPlatingED != null) ? collectionTable.pilotManufPlatingSD.daysbetween(collectionTable.pilotManufPlatingED) : null;
                    
                    }
                    if(activity.name__c == 'Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly'){
                        collectionTable.productApprvlSampleSD    = activity.Actual_Start_Date__c;
                        collectionTable.productApprvlSampleED    = activity.Actual_End_Date__c;
                        collectionTable.productApprvlSamplePlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.productApprvlSampleActualLT = (collectionTable.productApprvlSampleSD != null && collectionTable.productApprvlSampleED != null) ? collectionTable.productApprvlSampleSD.daysbetween(collectionTable.productApprvlSampleED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.productApprvlSampleSD != null && collectionTable.productApprvlSampleED != null) ? collectionTable.productApprvlSampleSD.daysbetween(collectionTable.productApprvlSampleED) : null;
                    
                    }
                    if(activity.name__c == 'Pilot Lot Manufacturing - Case Assembly - Case Development - INH'){
                        collectionTable.pilotManufCaseAssemblySD    = activity.Actual_Start_Date__c;
                        collectionTable.pilotManufCaseAssemblyED    = activity.Actual_End_Date__c;
                        collectionTable.pilotManufCaseAssemblyPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.pilotManufCaseAssemblyActualLT = (collectionTable.pilotManufCaseAssemblySD != null && collectionTable.pilotManufCaseAssemblyED != null) ? collectionTable.pilotManufCaseAssemblySD.daysbetween(collectionTable.pilotManufCaseAssemblyED) : null;
                    
                        collectionTable.DynamicSD = activity.Actual_Start_Date__c;
                        collectionTable.DynamicED = activity.Actual_End_Date__c;
                        collectionTable.DynamicPlanLT = (collectionTable.productDesignSD != null && collectionTable.productDesignED != null) ? collectionTable.productDesignSD.daysbetween(collectionTable.productDesignED) : null;
                        collectionTable.DynamicActualLT = (collectionTable.pilotManufCaseAssemblySD != null && collectionTable.pilotManufCaseAssemblyED != null) ? collectionTable.pilotManufCaseAssemblySD.daysbetween(collectionTable.pilotManufCaseAssemblyED) : null;
                    
                    }
                
                }
                
                
            }
            
            lWrapperList.add(collectionTable);
        }
       system.debug('--------wrapperTable--------'+lWrapperList);
        
    }
    
    public void displayCaseINHActivity() {
        mapActivitiesList = new map<String, list<NPD_Activity__c> > ();
        system.debug('--------All----------'+All);
        system.debug('-----lstAllProject-------'+lstAllProject);
        system.debug('-----selectedModelName-------'+selectedModelName);
        if(selectedFunctionName == 'All' && selectedModelName == 'All') {
            isDisplayTable = true;
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN :All  AND NPD_Project_Name__r.Name IN :lstAllProject]){
                system.debug('-------activityList(inside if)-------'+activityList);
                system.debug('-------activityList(inside if)-------'+activityList.NPD_Project_Name__r.Name);
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(!mapActivitiesList.containsKey(activityList.NPD_Project_Name__r.Name)){
                        list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                        lstAct.add(activityList);   
                        mapActivitiesList.put(activityList.NPD_Project_Name__r.Name,lstAct);
                    }else{
                        mapActivitiesList.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                    }
                
                    //mapActivitiesList.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
            system.debug('-------------mapActivitiesList---------------'+mapActivitiesList);
        }else if(selectedFunctionName == 'All' &&  selectedModelName != 'All') {
            isDisplayTable = true;
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c IN :All  AND NPD_Project_Name__r.Name = :selectedModelName]){
                system.debug('-------activityList(inside else 1)-------'+activityList);
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(!mapActivitiesList.containsKey(activityList.NPD_Project_Name__r.Name)){
                        list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                        lstAct.add(activityList);   
                        mapActivitiesList.put(activityList.NPD_Project_Name__r.Name,lstAct);
                    }else{
                        mapActivitiesList.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                    }
                }
            }
        }else if(selectedFunctionName != 'All' &&  selectedModelName == 'All'){
            isDisplayTable = false;
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = :selectedFunctionName  AND NPD_Project_Name__r.Name IN :lstAllProject]){
                system.debug('-------activityList(inside else 2)-------'+activityList);
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(!mapActivitiesList.containsKey(activityList.NPD_Project_Name__r.Name)){
                        list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                        lstAct.add(activityList);   
                        mapActivitiesList.put(activityList.NPD_Project_Name__r.Name,lstAct);
                    }else{
                        mapActivitiesList.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                    }
                }
            }
        }else if(selectedFunctionName != 'All' &&  selectedModelName != 'All'){
            isDisplayTable = false;
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c, Actual_Start_Date__c, Actual_End_Date__c  from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = :selectedFunctionName  AND NPD_Project_Name__r.Name = :selectedModelName]){
                system.debug('-------activityList(inside else 3)-------'+activityList);
                if (activityList.NPD_Project_Name__r.Name != null) {
                    if(!mapActivitiesList.containsKey(activityList.NPD_Project_Name__r.Name)){
                        list<NPD_Activity__c> lstAct = new list<NPD_Activity__c>();
                        lstAct.add(activityList);   
                        mapActivitiesList.put(activityList.NPD_Project_Name__r.Name,lstAct);
                    }else{
                        mapActivitiesList.get(activityList.NPD_Project_Name__r.Name).add(activityList);
                    }
                }
            }
        }
        if(selectedFunctionName != 'All'){
            isDisplayTable = false;
            for(NPD_Activity__c activityList : [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,name__c  from NPD_Activity__c where name__c = :selectedFunctionName ]){
                if(activityList.name__c == 'Press Tool Drawing Release - Case Development - INH'){
                    headerVal = 'Tool Design Release - Standard';
                    subHeader = 'Press Tool Drawing Release - Standard Option';
                   // isDisplayColumn = true;
                }
                if(activityList.name__c == 'Alternate option - Press Tool Drawing Release'){
                    headerVal = 'Tool Design Release - Alternate';
                    subHeader = 'Press Tool Drawing Release-Alternate Option';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'IMP Press Blank - Press Tool Drawing Release'){
                    headerVal = 'Tool Design Release - IMP';
                    subHeader = 'Press Tool Drawing Release - IMP';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Press Tool Delivery - Case Development - INH'){
                    headerVal = 'Tool Manufacturing';
                    subHeader = 'Tool Delivery';
                   // isDisplayColumn = true;
                }
                if(activityList.name__c == 'Press Blank Trials - Case Development - INH'){
                    headerVal = 'Press Tool Try out';
                    subHeader = 'Press Blank Trial';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Pilot Lot Manufacturing - Press - Case Development - INH'){
                    headerVal = 'Press - Pilot Lot';
                    subHeader = 'Press - Pilot Lot';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Pilot Lot Manufacturing - Machining - Case Development - INH'){
                    headerVal = 'Machining';
                    subHeader = 'Machining';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Pilot Lot Manufacturing - Polishing - Case Development - INH'){
                    headerVal = 'Polishing';
                    subHeader = 'Polishing';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Pilot Lot Manufacturing -Plating - Case Development - INH'){
                    headerVal = 'Plating';
                    subHeader = 'Plating';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Product Approval Sample Assembly - Pilot Lot Manufacturing - Case Assembly'){
                    headerVal = 'Product approval';
                    subHeader = 'Product approval';
                  //  isDisplayColumn = true;
                }
                if(activityList.name__c == 'Pilot Lot Manufacturing - Case Assembly - Case Development - INH'){
                    headerVal = 'Case Assembly';
                    subHeader = 'Case Assembly';
                  //  isDisplayColumn = true;
                }
            }
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
        public date pressToolDesignInputSD {get;set;}
        public date pilotLotManufacturingED {get;set;}
        public date pressToolDrawingRlsSD {get;set;}
        public date pressToolDrawingRlsED {get;set;}
        public date alternatePressToolDrawingRlsSD {get;set;}
        public date alternatePressToolDrawingRlsED {get;set;}
        public date IMPpressBlankSD {get;set;}
        public date IMPpressBlankED {get;set;}
        public date pressToolDeliverySD {get;set;}
        public date pressToolDeliveryED {get;set;}
        public date pressBlankTrialsSD {get;set;}
        public date pressBlankTrialsED {get;set;}
        public date pilotManufPressSD {get;set;}
        public date pilotManufPressED {get;set;}
        public date pilotManufMachineSD {get;set;}
        public date pilotManufMachineED {get;set;}
        public date pilotManufPolishingSD {get;set;}
        public date pilotManufPolishingED {get;set;}
        public date pilotManufPlatingSD {get;set;}
        public date pilotManufPlatingED {get;set;}
        public date productApprvlSampleSD {get;set;}
        public date productApprvlSampleED {get;set;}
        public date pilotManufCaseAssemblySD {get;set;}
        public date pilotManufCaseAssemblyED {get;set;}
        
        public Integer casePlanLT {get;set;}
        public Integer planLT  {get;set;}
        public Integer actualLT  {get;set;}
        public Integer variance  {get;set;}
        public Integer pressToolPlanLT {get;set;}
        public Integer pressToolActualLT {get;set;}
        public Integer altrntPressToolPlanLT {get;set;}
        public Integer altrntPressToolActualLT {get;set;}
        public Integer IMPpressBlankPlanLT {get;set;}
        public Integer IMPpressBlankActualLT {get;set;}
        public Integer pressToolDeliveryPlanLT {get;set;}
        public Integer pressToolDeliveryActualLT {get;set;}
        public Integer pressBlankTrialsPlanLT {get;set;}
        public Integer pressBlankTrialsActualLT {get;set;}
        public Integer pilotManufPressPlanLT {get;set;}
        public Integer pilotManufPressActualLT {get;set;}
        public Integer pilotManufMachinePlanLT {get;set;}
        public Integer pilotManufMachineActualLT {get;set;}
        public Integer pilotManufPolishingPlanLT {get;set;}
        public Integer pilotManufPolishingActualLT {get;set;}
        public Integer pilotManufPlatingPlanLT {get;set;}
        public Integer pilotManufPlatingActualLT {get;set;}
        public Integer productApprvlSamplePlanLT {get;set;}
        public Integer productApprvlSampleActualLT {get;set;}
        public Integer pilotManufCaseAssemblyPlanLT {get;set;}
        public Integer pilotManufCaseAssemblyActualLT {get;set;}
        
        public Integer DynamicPlanLT {get;set;}
        public Integer DynamicActualLT {get;set;}
        public date DynamicSD {get;set;}
        public date DynamicED {get;set;}
        
        
        
    }

}