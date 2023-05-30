public class NPD_SearchProjectController {
    
    public list<NPD_Project_Name__c> lstProjects    {get;set;}
    public list<NPD_Collections__c> lstSearchCollection {get;set;}
    public string strActivityId             {get;set;}
    public String strCollectionsId          {get;set;}
    public String strCollectionsName        {get;set;}
    public String strModelId                {get;set;}
    public String strModelName              {get;set;}
    public String strNamefield              {get;set;}
    public String strIdfield                {get;set;}
    public String strPageName               {get;set;}
    public boolean blnShowTable             {get;set;}
    public list<NPD_Project_Name__c> projectList {get;set;}
    public string projectId{get;set;}
    
    public NPD_SearchProjectController(){
        
        lstSearchCollection =   new list<NPD_Collections__c>(); 
        lstProjects         =   new list<NPD_Project_Name__c>(); 
        projectList         =   new list<NPD_Project_Name__c>();
        blnShowTable        =   false;
        
        strNamefield        =   apexpages.currentpage().getparameters().get('namefield');
        strIdfield          =   apexpages.currentpage().getparameters().get('idfield');
        strPageName         =   apexpages.currentpage().getparameters().get('pageName');
        strCollectionsId    =   apexpages.currentpage().getparameters().get('collectionid');
        //projectId    =   apexpages.currentpage().getparameters().get('ProdId');
        
        System.debug('==strNamefield=='+strNamefield);
        System.debug('==strIdfield=='+strIdfield);
        System.debug('==strPageName=='+strPageName);
        System.debug('==strCollectionsId=='+strCollectionsId);
        if(!String.isBlank(strCollectionsId)) {
            try {
            strCollectionsName = [SELECT Name,Collection_Name__c FROM NPD_Collections__c WHERE id=:strCollectionsId LIMIT 1].Collection_Name__c;
            searchProject(); } catch(Exception excp) {System.debug('********excp******'+excp.getMessage());}
        }
        

        
        if(strPageName =='Collectionlookup'){
            set<id> collectionIds   =  new set<id>();
            for(NPD_Activity__c act : [SELECT id,NPD_Project_Name__c,NPD_Project_Name__r.NPD_Collections__c From NPD_Activity__c WHERE NPD_Project_Name__r.NPD_Collections__c != null]) {
                collectionIds.add(act.NPD_Project_Name__r.NPD_Collections__c);
            }
            
            system.debug('collectionIdscollectionIds'+collectionIds);
            
            lstSearchCollection=[select id,Name FROM NPD_Collections__c WHERE Name != null AND id IN:collectionIds];
        }
        
        if(strPageName =='Model') {
            set<id> projectids   =  new set<id>();
            for(NPD_Activity__c act : [SELECT id,NPD_Project_Name__c,NPD_Project_Name__r.NPD_Collections__c From NPD_Activity__c WHERE NPD_Project_Name__r.NPD_Collections__c != null]) {
                projectids.add(act.NPD_Project_Name__c);
            }
            String queryStr  = 'SELECT id,Model_No__c,NPD_Collections__r.Collection_Name__c FROM NPD_Project_Name__c WHERE Model_No__c != null AND NPD_Collections__c != null AND id in:projectids';
            
            lstProjects = (List<NPD_Project_Name__c>)DataBase.query(queryStr);
            
         }
    
    }
    
     
    
    public  void searchProject() {
        
        blnShowTable        =true;
        
        String query        =  'SELECT id,Name, Model_No__c FROM NPD_Project_Name__c WHERE Name != null';
        if((strModelId != '' && strModelId != null)) {
                query   =  query +' AND id=:strModelId';
        } else if((strCollectionsId!='' && strCollectionsId != null)) {
                query   =  query + ' AND NPD_Collections__c=:strCollectionsId';
        } 
        
        projectList  =  database.query(query);
    }
    
    public pagereference projectDetaiview() {
        string url = '/apex/NPD_DetailView_Page?proID='+projectId;
        pagereference pgr = new pagereference(url);
        pgr.setRedirect(true);
        return pgr;
    }
    
}