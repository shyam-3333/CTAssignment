/***********************************************************************************************************************************************
 * Class Name   : NPD_TestUtilityClass 
 * Description  : Define the objects, that will be helpful to write test class.  
 * Created By   : Keyur Modi
 * Created Date : 28/November/2015
 * ********************************************************************************************************************************************/
public class NPD_TestUtilityClass {
    
    /** NPD Project Templates **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Project Templates(Regular/Adhoc)
         * **********************************************************************************************************************************************/
        public static NPD_Project_Template__c getProjectTemplate(String TemplateName) {
            NPD_Project_Template__c oPrjctTemp  =    new NPD_Project_Template__c();
            oPrjctTemp.Name                     =    TemplateName;
            oPrjctTemp.Active__c                =    TRUE;
            oPrjctTemp.Description__c           =    'Testing';
            return oPrjctTemp;
        }
        
    /** NPD CheckList **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Checklist
         * **********************************************************************************************************************************************/
        public static NPD_Checklist__c getChecklist(String CaseSource,String SupplyAgency) {
            NPD_Checklist__c ochecklist         =    new NPD_Checklist__c();
            ochecklist.Vendor_Ref_No__c         =    'Test';
            ochecklist.Model_No__c              =    'MODEL101';
            ochecklist.Case_Sourcing__c         =    CaseSource;
            ochecklist.Supply_Agency__c         =    SupplyAgency;
            return ochecklist;
        }
        
    
    /** NPD Project Items **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Project Items 
         * **********************************************************************************************************************************************/
        public static NPD_Project_Items__c getProjItemForStage(String Title,String ItemType,Id projTempId) {
           NPD_Project_Items__c    oPrjctItem  =   new NPD_Project_Items__c();
            oPrjctItem.Item_Type__c             =    ItemType;
            oPrjctItem.Title__c                 =    Title;
            oPrjctItem.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem.Lead_Time__c             =    2;
            oPrjctItem.Days_to_Complete__c      =    2;
            oPrjctItem.Complexity__c            =    'Medium';
            oPrjctItem.Project_Template__c      =    projTempId;
            oPrjctItem.Active__c                =    TRUE;
            return oPrjctItem;
        }
      
    /** NPD Collections **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Collections
         * **********************************************************************************************************************************************/
        public static NPD_Collections__c getCollections() {
            NPD_Collections__c  oCollectns              =   new NPD_Collections__c();
            oCollectns.Collection_Name__c               =    'Test collections';
            oCollectns.Tentative_Launch_Month_Date__c   =    System.Today();
            return oCollectns;
        }

    /** NPD Project **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Project
         * **********************************************************************************************************************************************/
        public static NPD_Project_Name__c getProjName(ID modelNo,String ProjectType,ID caseMaterialId,String devRoute,ID strapType,Id strapMatrl) {
            NPD_Project_Name__c  oProjName              =    new NPD_Project_Name__c();
            oProjName.Name                              =    'Test ProjectName';
            oProjName.Model_No__c                       =    modelNo ;
            oProjName.Project_Type__c                   =    ProjectType;    
            oProjName.Case_Material__c                  =    caseMaterialId;
            oProjName.Development_Route__c              =    devRoute;
            oProjName.Strap_Source__c                   =    'IND';
            oProjName.Strap_Type__c                     =    strapType;
            oProjName.Movement_Function__c              =    'Gents';
            oProjName.Project_Complexity__c             =    'Medium';
            oProjName.Strap_Material__c                 =    strapMatrl;
            return oProjName;
        }
    
     /** NPD Master **/
    
    /*************************************************************************************************************************************************
         * Method is used to return NPD Master
         * **********************************************************************************************************************************************/
        public static NPD_Master__c getNPDMaster(String Type) {
            NPD_Master__c  oMaster     =    new NPD_Master__c();
            oMaster.Name               =    'Test Master';
            oMaster.Type__c            =    Type;
            return oMaster;
        }
        
        /*************************************************************************************************************************************************
         * Method is used to return NPD Activity
         * **********************************************************************************************************************************************/
        public static NPD_Activity__c getNPDActivity(String type) {
            NPD_Activity__c  oActivity     =    new NPD_Activity__c();
            oActivity.Actual_Start_Date__c =    System.today().addDays(-1);
            oActivity.Type__c              =     type;
            return oActivity;
        }
        
        /*************************************************************************************************************************************************
         * Method is used to return NPD Activity
         * **********************************************************************************************************************************************/
        public static NPD_Stage__c getNPDStage(String name) {
            NPD_Stage__c  oStage     =    new NPD_Stage__c();
            oStage.Name__c        =    name;
            return oStage;
        }
        
        /*************************************************************************************************************************************************
         * Method is used to return Email template
         * **********************************************************************************************************************************************/
        public static EmailTemplate getEmailTemplate(String name) {
           EmailTemplate e = new EmailTemplate (developerName = name,TemplateType= 'Text', Name = name,FolderId = UserInfo.getUserId());
           return e;
        }
        
        
}