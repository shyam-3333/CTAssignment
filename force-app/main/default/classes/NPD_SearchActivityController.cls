public class NPD_SearchActivityController {

    


    public String row1 { get; set; }
    public list<npd_activity__c>lstActivity {get;set;}
    public list<npd_activity__c>lstSearchCollection {get;set;}
    public string strActivityId             {get;set;}
    public String strCollectionsId          {get;set;}
    public String strCollectionsName        {get;set;}
    public String strModelId        {get;set;}
    public String strModelName      {get;set;}
    public String strNamefield              {get;set;}
    public String strIdfield                {get;set;}
    public String strPageName               {get;set;}
    public boolean blnShowTable             {get;set;}
    public boolean blnShowTablesave         {get;set;}
    public NPD_SearchActivityController(){
        lstActivity= new list<npd_activity__c>();
        blnShowTable=false;
        blnShowTablesave=false;         
        strNamefield=apexpages.currentpage().getparameters().get('namefield');
        strIdfield=apexpages.currentpage().getparameters().get('idfield');
        strPageName=apexpages.currentpage().getparameters().get('pageName');
        if(strPageName =='Collectionlookup'){
        
            lstSearchCollection  =  [select id,name,SerialNo__c,NPD_Project_Name__r.NPD_Collections__r.Collection_Name__c,NPD_Project_Name__r.NPD_Collections__c from NPD_Activity__c where NPD_Project_Name__r.NPD_Collections__c!=null];
        
        }
        if(strPageName =='Model'){
        
            lstSearchCollection  = [select id,name,SerialNo__c,NPD_Project_Name__r.Model_No__c from NPD_Activity__c where NPD_Project_Name__r.Model_No__c!=null];
        
        }
    
    }
    
    public  void EditBulkActivity(){
    blnShowTable=false;
    blnShowTablesave=true;
    }
    
    
    public  void searchActivity(){
         blnShowTable=true;
        system.debug('blnShowTable++++++'+blnShowTable);
        system.debug('+strCollectionsId++++++'+strCollectionsId);
         string strFilter2='In Progress';
         string strFilter3='Not Started';
          string strFilter1='Planned Order Loading';
        string strActivityQuery ='select id,name,Status__c,Name__c,SerialNo__c,Actual_Start_Date__c,First_Month_Watch_Delivery_Date__c,NPD_Project_Name__c,Collection_reference__c,NPD_Project_Name__r.NPD_Collections__r.Collection_Name__c from NPD_Activity__c ';
        system.debug('strActivityQuerystrActivityQuery'+strActivityQuery);
        if((strModelId != '' || strModelId != null) && (strCollectionsId=='' || strCollectionsId == null)){
            system.debug('strActivityQuery++++++elseif1');
            strActivityQuery=strActivityQuery+' '+'where NPD_Project_Name__c=:strModelId and Name__c=:strFilter1 and (Status__c=:strFilter2 Or Status__c=:strFilter3)';
        
        }
        else if((strModelId == '' || strModelId == null) && (strCollectionsId!='' || strCollectionsId != null)){
            system.debug('strActivityQuery++++++elseif1');
            strActivityQuery=strActivityQuery+' '+' WHERE NPD_Project_Name__r.NPD_Collections__c=:strCollectionsId and Name__c=:strFilter1 and (Status__c=:strFilter2 Or Status__c=:strFilter3)';
        
        }
        
       else{
                system.debug('strActivityQuery++++++else');
            strActivityQuery=strActivityQuery+' '+' WHERE NPD_Project_Name__c=:strModelId and NPD_Project_Name__r.NPD_Collections__c=:strCollectionsId and NPD_Project_Name__r.NPD_Collections__c!=NULL and Name__c=:strFilter1 and (Status__c=:strFilter2 Or Status__c=:strFilter3) ';
        }
        system.debug('strActivityQuery++++++'+lstActivity);
        lstActivity=database.query(strActivityQuery);
        system.debug('lstActivitylstActivit'+lstActivity);
      
       
    }
    
    
    public void SaveBulkActivity() {
    
    try{
     upsert lstActivity;
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'ALL Activity updated Successfully')); 
      blnShowTable=true;
      blnShowTablesave=FALSE;
}
catch(exception e){system.debug('*******Error while updating*******'+e.getmessage());} 
}

}