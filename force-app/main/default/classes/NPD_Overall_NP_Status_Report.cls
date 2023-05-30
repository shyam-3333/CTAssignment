public class NPD_Overall_NP_Status_Report {
    public List < selectoption > npdBrandOption {get;set;}
    public List < selectoption > npdCollectionOption {get;set;}
    public map < String, npd_stage__c > CollectionName;
    public String selectedBrandName {get;set;}
    public String selectedCollectionName {get;set;}
    public Integer makeCount {get;set;}
    public Integer buyCount {get;set;}
    public Integer caseCount {get;set;}
    public Integer INDGCount {get;set;}
    public Integer CBEPlantCount {get;set;}
    public Integer nebulaMfgCount {get;set;}
    public NPD_Checklist__c npChk {get;set;}
    public boolean isDisplayTable {get;set;}

    public NPD_Overall_NP_Status_Report () {
        selectedBrandName = 'None';
        isDisplayTable = false;
        selectBrand();
        selectCollection();
    }
    
    public void selectBrand() {
        
        npdBrandOption = new List < selectoption > ();
        npdBrandOption.add(new selectoption('None', '--None--'));
        npdBrandOption.add(new selectoption('All', 'All'));
        for (NPD_Master__c master: [select id, Name from NPD_Master__c where Type__c = 'Brand' order By Name]) {
            npdBrandOption.add(new selectoption(master.name, master.Name));
        }
    }
    
    public void selectCollection() {
        npdCollectionOption = new List < selectoption > ();
        CollectionName = new map < String, npd_stage__c > ();
        List<String> collectionNamesLst = new list<String>();
        List < npd_stage__c > lstage = new List < npd_stage__c > ();
        npdCollectionOption.add(new selectoption('None', '--None--'));
        
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
    
    public void totalCount() {
        makeCount = 0;
        buyCount = 0;
        caseCount = 0;
        INDGCount = 0;
        CBEPlantCount = 0;
        nebulaMfgCount = 0;
        
        list<String> strSet = new list<String>();
        /*list<NPD_Checklist__c> chklst = [select Supply_Agency__c from NPD_Checklist__c where CollectionName__c = 'demo Ani'];
        for(NPD_Checklist__c np: chklst){
            if(np.Supply_Agency__c != null){
                strSet.add(np.Supply_Agency__c);
            }
        }*/
        
        list<NPD_Checklist__c> lstChklist = [select CollectionName__c,Case_Sourcing__c,Supply_Agency__c from NPD_Checklist__c where CollectionName__c = :selectedCollectionName ];
        system.debug('=========lstChklist ============='+lstChklist);
        
        if(lstChklist.size() > 0){
            npChk  = lstChklist[0];
            isDisplayTable = true;
        }
        for(NPD_Checklist__c chk : lstChklist){
            if(chk.Supply_Agency__c != null){
                strSet.add(chk.Supply_Agency__c);
            }
            if(chk.Case_Sourcing__c == 'Make'){
                makeCount ++;
            }
            if(chk.Case_Sourcing__c == 'Buy'){
                buyCount ++;
            }
            
        }
        system.debug('--------strSet-------'+strSet);
        system.debug('--------makeCount --------'+makeCount);
        system.debug('--------buyCount --------'+buyCount );
        
        for(String s : strSet){
            if(s.contains('Case Plant')){
                    caseCount ++;
                }
                if(s.contains('INDG')){
                    INDGCount ++;
                }
                if(s.contains('CBE Plant')){
                    CBEPlantCount ++;
                }
                if(s.contains('Nebula Mfg')){
                    nebulaMfgCount ++;
                }
         }
            system.debug('--------caseCount --------'+caseCount );
            system.debug('--------INDGCount --------'+INDGCount );
    
    }
}