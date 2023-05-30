public class NPD_Development_Controller {
    
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public list<wrapperTable> lWrapperList {get;set;}
    public String selectedCollectionName {get;set;}
    public map < String, npd_stage__c > CollectionName;
    public String selectedBrandName {get;set;}
    public Boolean isDisplayTable {get;set;}
    public date fromDate {get;set;}                             // collect date from visual force page (tentative lunch from date)
    public date toDate {get;set;}    
     
    public NPD_Development_Controller() {
        selectedBrandName = 'None';
        lWrapperList = new List < wrapperTable > ();
        isDisplayTable = false;
        selectBrand();
        selectCollection();
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
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        List<String> collectionNamesLst = new list<String>();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        npdCollectionOption.add(new selectoption('All', 'All'));
        if(selectedBrandName == 'All'){
            if(fromDate == null && toDate == null){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c];
            }
            else if(fromDate != null && toDate != null ){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate];
            }
            //isDisplayTable = true;
        }
        else if(selectedBrandName != 'All' && selectedBrandName != 'None'){
            if(fromDate == null && toDate == null ){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where brand1__c =: selectedBrandName];  
            }
            else if(fromDate != null && toDate != null){
                lstage = [select id, name__c, brand1__c, Approval_Submitted_Date__c, Approved_Date__c, npd_collections__r.name, npd_collections__r.Id from npd_stage__c where npd_collections__r.Tentative_Launch_Month_Date__c >=: fromDate AND npd_collections__r.Tentative_Launch_Month_Date__c <=: toDate AND brand1__c =: selectedBrandName];
                System.debug('++++++++++++++lstage Brand2++++++++++++++++++'+lstage);
            } 
            //isDisplayTable = true;
        }
        
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

    public void displayTableDev() {
        if (!lWrapperList.isEmpty()) {
            lWrapperList.clear();
        }
        
        Map<String,list<NPD_Project_Name__c>>  mCollectionToProject = new Map<String,List<NPD_Project_Name__c>>();
        map < String, NPD_Activity__c > mActivityProtoSubmissionAED = new map < String, NPD_Activity__c > ();  
        map < String, NPD_Activity__c > mActivityLaunchAED = new map < String, NPD_Activity__c > ();  
        map < String, NPD_Activity__c > mActivityPlanOrderAED = new map < String, NPD_Activity__c > (); 
        map < String, NPD_Activity__c > mActivityInputFinalProdAED = new map < String, NPD_Activity__c > ();
        map < String, NPD_Activity__c > mActivityProdCrtfnAED = new map < String, NPD_Activity__c > ();
        
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
            
            //  used for capturing Proto Submission by D&D Approval AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_End_Date__c, Approval_Status__c, Status__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Proto Submission by D&D for Approval' AND Approval_Status__c = 'Approved']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoSubmissionAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            
            //  used for capturing Planned Order Loading AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_End_Date__c, Approval_Status__c, Status__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Planned Order Loading']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityPlanOrderAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Watch Deposition AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_End_Date__c, Approval_Status__c, Status__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Watch Deposition']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityLaunchAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            } 
            //  used for capturing Input - Final Product Design AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Input - Final Product Design']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityInputFinalProdAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }    
            // used for capturing Product Certification and Handing Over Note
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,  Actual_End_Date__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name IN: CollectionName.keyset() AND name__c = 'Product Certification and Handing Over Note']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProdCrtfnAED.put(activityList.NPD_Project_Name__r.Name, activityList);
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
            }
            
            //  used for capturing Proto Submission by D&D Approval AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_End_Date__c, Approval_Status__c, Status__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Proto Submission by D&D for Approval']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProtoSubmissionAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Planned Order Loading AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Planned Order Loading']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityPlanOrderAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }   
            //  used for capturing Watch Deposition AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Watch Deposition']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityLaunchAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            } 
            //  used for capturing Input - Final Product Design AED
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name, Actual_Start_Date__c, Actual_End_Date__c, Approval_Status__c, Status__c, Complexity_Typess__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Input - Final Product Design']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityInputFinalProdAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            } 
            // used for capturing Product Certification and Handing Over Note
            for(NPD_Activity__c activityList: [Select id, NPD_Collections__r.name,NPD_Project_Name__r.Name,  Actual_End_Date__c, Planned_Lead_Time__c from NPD_Activity__c where NPD_Collections__r.name =: selectedCollectionName AND name__c = 'Product Certification and Handing Over Note']){
                if (activityList.NPD_Project_Name__r.Name != null) {
                    mActivityProdCrtfnAED.put(activityList.NPD_Project_Name__r.Name, activityList);
                }
            }
        } 
        
        for (NPD_Project_Name__c wProject : lproject) {
            wrapperTable collectionTable = new wrapperTable();
            collectionTable.collection = wProject.NPD_Collections__r.Name;             
            collectionTable.brand     = wProject.Brand1__c;
            collectionTable.model = wProject.Name;
            collectionTable.Psynum = wProject.PSY_No__c;
            
            if(mActivityProtoSubmissionAED.size()>0 && !(mActivityProtoSubmissionAED.values()).isEmpty()&& mActivityProtoSubmissionAED.get(wProject.Name)!=null){
                collectionTable.protoSubDnDAppAED = mActivityProtoSubmissionAED.get(wProject.Name).Actual_End_Date__c;
                collectiontable.ApprovStatus = mActivityProtoSubmissionAED.get(wProject.Name).Approval_Status__c;
            }
            if(mActivityPlanOrderAED.size()>0 && !(mActivityPlanOrderAED.values()).isEmpty()&& mActivityPlanOrderAED.get(wProject.Name)!=null){
                collectionTable.planedOrderLodingAED = mActivityPlanOrderAED.get(wProject.Name).Actual_End_Date__c;
            }
            if(mActivityLaunchAED.size()>0 && !(mActivityLaunchAED.values()).isEmpty()&& mActivityLaunchAED.get(wProject.Name)!=null){
                collectionTable.launchED = mActivityLaunchAED.get(wProject.Name).Actual_End_Date__c;
            }
            if(mActivityInputFinalProdAED.size()>0 && !(mActivityInputFinalProdAED.values()).isEmpty()&& mActivityInputFinalProdAED.get(wProject.Name)!=null){
                collectionTable.inputFinalProdDesgnAED= mActivityInputFinalProdAED.get(wProject.Name).Actual_End_Date__c;
            }
            collectionTable.planedOrderLodingLT =(collectionTable.planedOrderLodingAED != null && collectionTable.inputFinalProdDesgnAED != null) ? collectionTable.inputFinalProdDesgnAED.daysbetween(collectionTable.planedOrderLodingAED) : null;   
            collectionTable.planedOrderlaunchLT =(collectionTable.launchED != null && collectionTable.planedOrderLodingAED != null) ? collectionTable.planedOrderLodingAED.daysbetween(collectionTable.launchED) : null;
            collectionTable.launchLT =(collectionTable.launchED != null && collectionTable.inputFinalProdDesgnAED != null) ? collectionTable.inputFinalProdDesgnAED.daysbetween(collectionTable.launchED) : null;
            if(mActivityProdCrtfnAED.size()>0 && mActivityProdCrtfnAED.containskey(wProject.Name) && mActivityProdCrtfnAED.get(wProject.Name)!= null){
                collectionTable.prodctCertifnAED = mActivityProdCrtfnAED.get(wProject.Name).Actual_End_Date__c;
            }
            collectionTable.launchCertfcn = (collectionTable.launchED != null && collectionTable.prodctCertifnAED != null) ? collectionTable.launchED.daysbetween(collectionTable.prodctCertifnAED) : null;
            lWrapperList.add(collectionTable);
        }
        
        if(lWrapperList.size() > 0){
            isDisplayTable = true;
        }
    }


    public class wrapperTable{
        public date protoSubDnDAppAED {get;set;}
        public date inputFinalProdDesgnAED {get;set;}
        public date planedOrderLodingAED {get;set;}
        public date prodctCertifnAED {get;set;}
        public date launchED {get;set;}
        public Integer planedOrderLodingLT  {get;set;}
        public Integer planedOrderlaunchLT {get;set;}
        public Integer launchLT {get;set;} 
        public Integer launchCertfcn {get;set;} 
        public String brand {get;set;}
        public String collection {get;set;}
        public String model {get;set;}
        public String Psynum {get;set;}
        public String ApprovStatus {get;set;}
    }

}