public class NPD_AlbumScreen1_Report_Class {
    public String searchStr {get;set;}
    public String supplyAgency {get;set;}
    public boolean isDisplayModel {get;set;}
    public NPD_Project_Name__c projectItems {get;set;}
    public list<NPD_Project_Name__c> lstPrjctName {get;set;}
    public list<NPD_Checklist__c> lstCheckList {get;set;}
   // public string psyNo {get;set;}
    
    public NPD_AlbumScreen1_Report_Class(){
        isDisplayModel = false;
    }
    
    public void displayModel() {
        system.debug('-------searchStr------'+searchStr);
        lstCheckList = new list<NPD_Checklist__c>();
        lstPrjctName = new list<NPD_Project_Name__c>();
        lstPrjctName = [Select n.Strap_Source__c, n.PSY_No__c,n.Momentfuntionvalue__c, n.Gender__c, n.Collection_Names__c, n.Case_Source__c, n.Case_Material__r.Name, n.Brand1__c, n.ImageUpload__c,n.Model_No__c, n.Model_Name__c  From NPD_Project_Name__c n where n.PSY_No__c =:searchStr OR n.Model_No__c =:searchStr];
        system.debug('---------lstPrjctName-------'+lstPrjctName);
        lstCheckList = [select Id, Supply_Agency__c from NPD_Checklist__c where Supply_Agency__c != null AND (PSY_No__c = :searchStr OR Model_No__c = :searchStr) ];
        if(lstCheckList.size() > 0 ){
            supplyAgency = lstCheckList[0].Supply_Agency__c;
            isDisplayModel = true;
        }
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