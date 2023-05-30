/*********************************************************************
   Class Name       : NPDemailattachmentTest
   Type             : Test Class
   Description      : This test class covers code coverage of NPDemailattachment. 
   Created By       : Keyur Modi
   Created Date     : 7/12/2015
   LastModifiedby   : Deepti
   LastModifiedDate : 10/2/2016
*********************************************************************/
/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  11/19/2019   T01		T01- 	Hardcoded URL change fix
*/
@isTest
public class NPDemailattachmentTest{
    static testmethod void test(){
    
    Test.StartTest();
    
    NPD_Checklist__c ochecklist          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
    insert ochecklist;
    
    //Insert NPD MAster for Case Material
    NPD_Master__c  masterCM = NPD_TestUtilityClass.getNPDMaster('Case Material');
    insert masterCM;
    
  //Insert NPD MAster for strap type 
    NPD_Master__c  masterST = NPD_TestUtilityClass.getNPDMaster('Strap Type');
    insert masterST;
    
    //Insert NPD MAster for strap material 
    NPD_Master__c  masterSM = NPD_TestUtilityClass.getNPDMaster('Strap Material');
    insert masterSM;
    
    NPD_Collections__c oCollection       =     NPD_TestUtilityClass.getCollections();
    insert oCollection; 
    
    NPD_Project_Name__c projName = NPD_TestUtilityClass.getProjName(ochecklist.Id,'Regular',masterCM.Id,'Component Route',masterST.Id,masterSM.Id);
    
    NPD_Project_Template__c oProjTemp    =    NPD_TestUtilityClass.getProjectTemplate('Regular');
    insert oProjTemp; 
    
    NPD_Project_Items__c oProjItem       =    NPD_TestUtilityClass.getProjItemForStage('Briefing to IDS','Activity',oProjTemp.Id);
        //oProjItem.Field_Set__c = 'No_of_Designs__c';
    insert oProjItem;
    
    NPD_Stage__c oStage1                 =    NPD_TestUtilityClass.getNPDStage('Marketing Brief/Concept');
    oStage1.Type__c                      =    'Stage';
    oStage1.Actual_Start_Date__c                           =    System.today();           
    oStage1.Marketing_brief_concept_reference_number__c    =    'Mar123';
    oStage1.Market__c                                      =    'Domestic';
    oStage1.Status__c                                      =    'In Progress';
    oStage1.NPD_Project_Items__c                           =    oProjItem.Id;    
    oStage1.Marketing_brief_concept_reference_number__c    =    'MAR900';
    oStage1.Sub_Brand1__c                                  =    'Son';
    oStage1.Market__c                                      =    'ISD';
    oStage1.Source__c                                      =    'Dom';
    oStage1.Planned_Start_Date__c                          =    System.today();
    oStage1.Total_Lead_Time__c = 0;
    oStage1.Position__c        = 1;
    oStage1.SerialNo__c        =    'AR-0101';
    oStage1.Planned_Lead_Time__c = 10;
    oStage1.Planned_End_Date__c =     System.today().addYears(1);
    oStage1.Phase__c = 'Design';
    oStage1.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
    oStage1.No_of_Designs__c = 2;
    oStage1.NPD_Project_Name__c = projName.Id;
    oStage1.PrePredecessorSerialNo__c = '';
    oStage1.ImageUpload__c = 'dhgfcjvjv';
    insert oStage1;
    
    NPD_Stage__c oStage2                                   =    NPD_TestUtilityClass.getNPDStage('Briefing');
    oStage2.Actual_Start_Date__c                           =    System.today();
    oStage2.Type__c                                        =    'Sub-Stage';
    oStage2.Marketing_brief_concept_reference_number__c    =    'Mar123';
    oStage2.Market__c                                      =    'Domestic';
    oStage2.Status__c                                      =    'In Progress';
    oStage2.NPD_Project_Items__c                           =    oProjItem.Id;
    oStage2.NPD_Stage__c                                   =    oStage1.Id;
    oStage2.Planned_Start_Date__c                          =    System.today();
    oStage2.Total_Lead_Time__c = 0;
    oStage2.Position__c        = 1;
    oStage2.SerialNo__c        =    'AR-0101';
    oStage2.Planned_Lead_Time__c = 10;
    oStage2.Planned_End_Date__c =     System.today().addYears(1);
    oStage2.Phase__c = 'Design';
    oStage2.Tentative_Launch_Plan__c = Date.newInstance(2016,11,12);
    oStage2.No_of_Designs__c = 2;
    oStage2.NPD_Project_Name__c = projName.Id; 
    oStage2.PrePredecessorSerialNo__c = '';
    insert oStage2;
        
    NPD_Activity__c oActivity =  new NPD_Activity__c ();
    oActivity.Name__c = 'Briefing to IDS';
    oActivity.Type__c = 'Activity';
    oActivity.Actual_Start_Date__c = system.today();
    oActivity.Planned_Lead_Time__c = 10;
    oActivity.Status__c = 'In Progress';
    oActivity.No_of_Designs__c = 2;
    oActivity.Approval_Status__c = 'None';
    oActivity.Market__c = 'Domestic';
    oActivity.Marketing_Brief_Reference_No__c = 'Mar123';
    oActivity.Approval_Required__c = true;
    oActivity.NPD_Stage__c = oStage2.Id;
    oActivity.NPD_Project_Items__c = oProjItem.Id;
    oActivity.Approval_Status__c = 'Pending';
    oActivity.Line_Item_Approval_Required__c = true;
    oActivity.Position__c = 1;
    oActivity.SerialNo__c = 'AR-0101001';
    oActivity.Active__c = true;
    //oActivity.Approval_Status__c = 'Approved';
    oActivity.NPD_Project_Name__c = projName.id;
    //oActivity.Attachment_Required__c= true;
    insert oActivity;
    
    NPD_Activity__c oActivity1 = new NPD_Activity__c ()  ;
    oActivity1 .Name__c = 'Case/Model No Allocation';
    oActivity1.Type__c = 'Sub-Activity';
    oActivity1 .PredecessorSerialNo__c= null;
    oActivity1 .Actual_Start_Date__c = system.today();
    oActivity1 .Planned_Lead_Time__c = 10;
    oActivity1 .Status__c = 'In Progress';
    oActivity1 .No_of_Designs__c = 2;
    oActivity1 .Approval_Status__c = 'None';
    oActivity1 .Market__c = 'Domestic';       
    oActivity1 .Approval_Required__c = true;
    oActivity1 .NPD_Activity__c= oActivity.Id;
    oActivity1 .NPD_Project_Items__c = oProjItem.Id;
    oActivity1.NPD_Project_Name__c = projName.id;
    oActivity1 .Position__c = 1;
    oActivity1 .SerialNo__c = 'AR-0101001001';
    oActivity1 .Active__c = true;               
    oActivity1.NPD_Project_Name__c = projName.id;
    oActivity1 .Type__c = 'Sub-Activity';               
         
    insert oActivity1;
    
    oActivity .Checklist_Columns__c= 'PSY No,Case Sourcing,Vendor Name,Gender,Variant No,Dial No,Product Designer Name,Design No';
    update oActivity;         
    
    String apiNameString = 'Approval_Status__c';
    // NPD checklist 
    NPD_Checklist__c ochecklist1          =    NPD_TestUtilityClass.getChecklist('Make','Case Plant');
    ochecklist1.Approval_Status__c        =    'Dropped';
    ochecklist1.NPD_Activity_Chklist__c   =    oActivity.Id;
    insert ochecklist1;              
    
    List<Attachment> lstatt = new List<Attachment>();   
    Attachment at = new Attachment ();
        at.name = 'Cost123.jpj';
        at.Body = Blob.valueOf('ghfhjfjhggjh');
        at.parentid = ostage2.Id;      
        lstatt.add(at);
        
    if(lstatt.size()> 0){
        insert lstatt;
    }

    NPDemailattachment npdEmailAtt = new NPDemailattachment();
   	String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() ; //<T01>
    npdEmailAtt.link = sfdcURL+'/01pf00000003MoN';
    npdEmailAtt.getactid();
    npdEmailAtt.getlink();
    npdEmailAtt.getlinkcoll1();   
    npdEmailAtt.getattach();    
    npdEmailAtt.setactid(oActivity.Id);
    npdEmailAtt.setlink(oActivity.Id);
    npdEmailAtt.setattach(lstatt);
    npdEmailAtt.getfieldApi2();
    
    Test.StopTest();
    } 
}