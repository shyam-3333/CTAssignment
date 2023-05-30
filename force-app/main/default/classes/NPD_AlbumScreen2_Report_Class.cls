public class NPD_AlbumScreen2_Report_Class {
    public string searchModel {get;set;}
    public String supplyAgency {get;set;}
    public String productionDesnr {get;set;}
    public String TechApprover {get;set;}
    public String EngineerDesgnr {get;set;}
    public String techDesgnrAlln {get;set;}
    public Date watchDepositionASD {get;set;}
    public Date watchDepositionAED {get;set;}
    public boolean isDisplayModel {get;set;}
    public NPD_Project_Name__c projectItems {get;set;}
    public NPD_Checklist__c chklist {get;set;}
    public list<NPD_Project_Name__c> lstPrjctName {get;set;}
    public list<NPD_Checklist__c> lstCheckList {get;set;}
    public list<NPD_Checklist__c> lstCheckListSupplyAgn {get;set;}
    
    
    public NPD_AlbumScreen2_Report_Class() {
        isDisplayModel = false;
    }
    
    public void displayModel() {
        list<NPD_Checklist__c> lstCheckListTech = new list<NPD_Checklist__c>();
        list<NPD_Activity__c > lstWatchDepositn = new list<NPD_Activity__c >();
        
        map < String, NPD_Checklist__c > mCheckListMakeBuy  = new map < String, NPD_Checklist__c > ();
        map < String, NPD_Checklist__c > mCheckListTech  = new map < String, NPD_Checklist__c > ();
        map < String, NPD_Activity__c > mActivityLaunchAD = new map < String, NPD_Activity__c > ();
        
        system.debug('-------searchModel------'+searchModel);
        lstCheckListSupplyAgn = new list<NPD_Checklist__c>();
        lstCheckList = new list<NPD_Checklist__c>();
        lstPrjctName = new list<NPD_Project_Name__c>();
        lstPrjctName = [Select n.Strap_Source__c, n.Strap_Type__r.Name,  n.NPD_Collections__r.SF_Project_Owner__r.UserID__c, n.PSY_No__c, n.NPD_Collections__r.Owner.Email, n.NPD_Collections__r.Team_Leader2__r.UserID__c, n.Momentfuntionvalue__c, n.Gender__c, n.Collection_Names__c, n.Case_Source__c, n.Case_Material__r.Name, n.Brand1__c, n.ImageUpload__c,n.Model_No__c, n.Model_Name__c  From NPD_Project_Name__c n where n.Model_No__c =:searchModel];
        system.debug('---------lstPrjctName-------'+lstPrjctName);
        lstCheckList = [select Id, CollectionName__c ,Product_Designer_Name__r.UserID__c , Product_Designer_Name__c, Engineering_Designer_Name__r.Name from NPD_Checklist__c where Model_No__c = :searchModel AND NPD_Activity_Chklist__r.name__c = 'Concept Presentation to PMG - IDS'];
        system.debug('--------lstCheckList------'+lstCheckList );
        for(NPD_Checklist__c checkMake: lstCheckList ){
            if (checkMake.CollectionName__c != null ) {
                mCheckListMakeBuy.put(checkMake.CollectionName__c,checkMake);
            }
            
        }
        system.debug('-------mCheckListMakeBuy---------'+mCheckListMakeBuy); 
        lstCheckListSupplyAgn = [select Id, Supply_Agency__c,CollectionName__c,Product_Designer_Name__c,Product_Designer_Name__r.UserID__c,Tech_Approver__r.Name, Tech_Designer_Allocation__r.UserID__c from NPD_Checklist__c where Model_No__c = :searchModel AND NPD_Activity_Chklist__r.name__c = 'Make or Buy and Model No. Allocation'];
        
           
        lstCheckListTech = [select Id, Tech_Approver__r.Name, Tech_Designer_Allocation__r.UserID__c,CollectionName__c from NPD_Checklist__c where Model_No__c = :searchModel AND NPD_Activity_Chklist__r.name__c = 'Tech Designer Allocation - Proto'];
        for(NPD_Checklist__c checkMake: lstCheckListTech ){
                if (checkMake.CollectionName__c != null ) {
                    mCheckListTech.put(checkMake.CollectionName__c,checkMake);
                }
                
            }
        system.debug('-------mCheckListTech---------'+mCheckListTech); 
        
        // used for capturing Watch Deposition Activity
        lstWatchDepositn = [Select id, NPD_Collections__r.name, Actual_End_Date__c, Actual_Start_Date__c from NPD_Activity__c where Model_Name__c = :searchModel AND Name__c = 'Watch Deposition'];
        system.debug('-----------lstWatchDepositn----------------'+lstWatchDepositn );    
            for(NPD_Activity__c activityList : lstWatchDepositn ){
                if (activityList.NPD_Collections__r.name!= null) {
                    mActivityLaunchAD.put(activityList.NPD_Collections__r.name, activityList);
                }
            } 
            system.debug('--------mActivityLaunchAD------------'+mActivityLaunchAD.values());
            
        supplyAgency = '';
        productionDesnr = '';
        TechApprover = '';
        EngineerDesgnr = '';
        techDesgnrAlln = '';
        
            for(NPD_Checklist__c chk : lstCheckListSupplyAgn){
            system.debug('-------chk---------'+chk);
            system.debug('-------mCheckListMakeBuy.get(chk.CollectionName__c)---------'+mCheckListMakeBuy.get(chk.CollectionName__c)); 
            system.debug('-------mActivityLaunchAD.get(chk.CollectionName__c)---------'+mActivityLaunchAD.get(chk.CollectionName__c));
                if(supplyAgency == '' || supplyAgency == null){
                    supplyAgency = chk.Supply_Agency__c;
                }
                if((productionDesnr == '' || productionDesnr == null) && chk.CollectionName__c != null && mCheckListMakeBuy.get(chk.CollectionName__c) != null && mCheckListMakeBuy.get(chk.CollectionName__c).Product_Designer_Name__c != null){
                    productionDesnr = mCheckListMakeBuy.get(chk.CollectionName__c).Product_Designer_Name__r.UserID__c ;
                }
                if((TechApprover == '' || TechApprover == null) && chk.CollectionName__c != null && mCheckListTech.get(chk.CollectionName__c) != null && mCheckListTech.get(chk.CollectionName__c).Tech_Approver__c != null){
                    TechApprover = mCheckListTech.get(chk.CollectionName__c).Tech_Approver__r.Name;
                }
                if((EngineerDesgnr == '' || EngineerDesgnr == null)&& chk.CollectionName__c != null && mCheckListMakeBuy.get(chk.CollectionName__c) != null && mCheckListMakeBuy.get(chk.CollectionName__c).Engineering_Designer_Name__c != null){
                        EngineerDesgnr = mCheckListMakeBuy.get(chk.CollectionName__c).Engineering_Designer_Name__r.Name;
                }
                if((techDesgnrAlln == '' || techDesgnrAlln == null) && chk.CollectionName__c != null && mCheckListTech.get(chk.CollectionName__c) != null && mCheckListTech.get(chk.CollectionName__c).Tech_Designer_Allocation__c != null){
                        techDesgnrAlln = mCheckListTech.get(chk.CollectionName__c).Tech_Designer_Allocation__r.UserID__c;
                }
                if(chk.CollectionName__c != null && mActivityLaunchAD.get(chk.CollectionName__c) != null ){
                    watchDepositionASD = mActivityLaunchAD.get(chk.CollectionName__c).Actual_Start_Date__c;
                    watchDepositionAED = mActivityLaunchAD.get(chk.CollectionName__c).Actual_End_Date__c;
                }
               
                isDisplayModel = true;
        }
        system.debug('-------supplyAgency -------'+supplyAgency );
        system.debug('-------productionDesnr -------'+productionDesnr );
        system.debug('--------TechApprover---------'+TechApprover);
        /*if(lstCheckList.size() > 0 ){
            supplyAgency = lstCheckList[0].Supply_Agency__c;
           // TechApprover = lstCheckList[0].Tech_Approver__r.Name;
           chklist = lstCheckList[0];
            //isDisplayModel = true;
            
        }*/
         
         if(lstPrjctName.size() > 0){
            projectItems = lstPrjctName[0];
            isDisplayModel = true;
           
        }else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No record found!!');
            ApexPages.addMessage(myMsg);
            isDisplayModel = false;
            
        }
    }

}