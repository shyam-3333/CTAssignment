/*
*******************************************************************************************************************************************
ModifiedBy            Date      Tag     Description
*******************************************************************************************************************************************
Saradha  			11/27/2019   T01   Code Coverage
*/
@isTest
public class NPDProjectItemsTriggerHandlerTest{

    public static testMethod void nPDProjectItemsTriggerTest(){
    
    Test.StartTest();
    List<NPD_Project_Items__c> pitemDeleteList = new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c> pitemActiveUpdateList = new List<NPD_Project_Items__c>();
    List<NPD_Project_Items__c> pitemInActiveUpdateList = new List<NPD_Project_Items__c>();
    
    Map<Id,NPD_Project_Items__c> pitemMap = new Map<Id,NPD_Project_Items__c>();
    Map<Id,NPD_Project_Items__c> pitemMap2 = new Map<Id,NPD_Project_Items__c>();
    
    NPD_Project_Template__c oPrjctTemp  =    new NPD_Project_Template__c();
            oPrjctTemp.Name                     =    'Reguler';
            oPrjctTemp.Active__c                =    TRUE;
            oPrjctTemp.Description__c           =    'Testing';
            insert oPrjctTemp;
    
   // for(integer i=0;i>10;i++){
    NPD_Project_Items__c    oPrjctItem  =   new NPD_Project_Items__c();
        
            oPrjctItem.Item_Type__c             =    'Activity';
            oPrjctItem.Title__c                 =    'Test';
            oPrjctItem.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem.Lead_Time__c             =    2;
            oPrjctItem.Days_to_Complete__c      =    2;
            oPrjctItem.Complexity__c            =    'Medium';
            oPrjctItem.Project_Template__c      =    oPrjctTemp.id;
            oPrjctItem.Active__c                =    TRUE;
            oPrjctItem.Parent_Id__c             =    oPrjctItem.id;
            oPrjctItem.Copy_CheckList_Items__c  =    oPrjctItem.id;  
            oPrjctItem.Checklist_Columns__c     =    'Test';
            oPrjctItem.Columns_to_Copy__c       =    'Test';
            
            insert oPrjctItem  ;
            
            pitemMap.put(oPrjctItem.id,oPrjctItem);   
            
            oPrjctItem.Checklist_Columns__c     =    'Test1';
            update oPrjctItem  ;
            
            
                    
            
    NPD_Project_Items__c    oPrjctItem1  =   new NPD_Project_Items__c();
        
            oPrjctItem1.Item_Type__c             =    'Activity';
            oPrjctItem1.Title__c                 =    'Test';
            oPrjctItem1.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem1.Lead_Time__c             =    2;
            oPrjctItem1.Days_to_Complete__c      =    2;
            oPrjctItem1.Complexity__c            =    'Medium';
            oPrjctItem1.Project_Template__c      =    oPrjctTemp.id;
            oPrjctItem1.Active__c                =    TRUE;
            oPrjctItem1.Parent_Id__c             =    oPrjctItem.id;
            oPrjctItem1.Copy_CheckList_Items__c  =    oPrjctItem.id;  
            oPrjctItem1.Checklist_Columns__c     =    'Test';
            oPrjctItem1.Columns_to_Copy__c       =    'Test';
            pitemDeleteList.add(oPrjctItem1);
     
     NPD_Project_Items__c    oPrjctItem4  =   new NPD_Project_Items__c();       
            oPrjctItem4.Item_Type__c             =    'Activity';
            oPrjctItem4.Title__c                 =    'Test';
            oPrjctItem4.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem4.Lead_Time__c             =    2;
            oPrjctItem4.Days_to_Complete__c      =    2;
            oPrjctItem4.Complexity__c            =    'Medium';
            oPrjctItem4.Project_Template__c      =    oPrjctTemp.id;
            oPrjctItem4.Active__c                =    TRUE;
            oPrjctItem4.Parent_Id__c             =    oPrjctItem.id;
            oPrjctItem4.Copy_CheckList_Items__c  =    oPrjctItem.id;  
            oPrjctItem4.Checklist_Columns__c     =    'Test';
            oPrjctItem4.Columns_to_Copy__c       =    'Test';
            pitemDeleteList.add(oPrjctItem4);
            
            insert pitemDeleteList;
            
    for(NPD_Project_Items__c  npi : pitemDeleteList ){
    
        if(npi.active__c == true){
            npi.active__c = false;
        }
        else{
            npi.active__c = true;
        }
        pitemActiveUpdateList.add(npi); 
    }
    update pitemActiveUpdateList;        
    
    
    
           
   NPD_Project_Items__c    oPrjctItem2  =   new NPD_Project_Items__c();
        
            oPrjctItem2.Item_Type__c             =    'Project';
            oPrjctItem2.Title__c                 =    'Test';
            oPrjctItem2.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem2.Lead_Time__c             =    2;
            oPrjctItem2.Days_to_Complete__c      =    2;
            oPrjctItem2.Complexity__c            =    'Medium';
            oPrjctItem2.Project_Template__c      =    oPrjctTemp.id;
            oPrjctItem2.Active__c                =    TRUE;
            oPrjctItem2.Parent_Id__c             =    oPrjctItem2.id;
            oPrjctItem2.Copy_CheckList_Items__c  =    oPrjctItem2.id;  
            oPrjctItem2.Checklist_Columns__c     =    'Test';
        
            insert oPrjctItem2; 
            
            system.assertequals(oPrjctItem2.Active__c,true);
            //delete oPrjctItem  ;  //<T01>
            //insert oPrjctItem2; //<T01>
            pitemMap2.put(oPrjctItem2.id,oPrjctItem2);   
            
               NPD_Project_Items__c    oPrjctItem3  =   new NPD_Project_Items__c();
        
            oPrjctItem3.Item_Type__c             =    'Project';
            oPrjctItem3.Title__c                 =    'Test';
            oPrjctItem3.Titan_Sr_No__c           =    'AR-01';
            oPrjctItem3.Lead_Time__c             =    2;
            oPrjctItem3.Days_to_Complete__c      =    2;
            oPrjctItem3.Complexity__c            =    'Medium';
            oPrjctItem3.Project_Template__c      =    oPrjctTemp.id;
            oPrjctItem3.Active__c                =    TRUE;
            oPrjctItem3.Parent_Id__c             =    oPrjctItem2.id;
            oPrjctItem3.Copy_CheckList_Items__c  =    oPrjctItem2.id;  
            oPrjctItem3.Checklist_Columns__c     =    'Test';
        
            insert oPrjctItem3  ;
                        
            delete oPrjctItem3  ;
            
    
    //delete pitemDeleteList;    
    
    
    
    
    
    NPDProjectItemsTriggerHandler oPitems = new NPDProjectItemsTriggerHandler ();
    //oPitems.childActiveOrInactive(pitemMap2);
    oPitems.copyChecklistItemsOnSubActInsert(pitemDeleteList);
    oPitems.childDelete(pitemMap);
    
 
              
    Test.StopTest();        
    }
    
    public static testMethod void nPDProjectItemsTriggerTest2(){
    
    Test.StartTest();
    
    Map<Id,NPD_Project_Items__c> pMap = new Map<Id,NPD_Project_Items__c>();
        NPD_Project_Template__c oPrjctTemp  =    new NPD_Project_Template__c();
            oPrjctTemp.Name                     =    'Reguler';
            oPrjctTemp.Active__c                =    TRUE;
            oPrjctTemp.Description__c           =    'Testing';
            insert oPrjctTemp;
    
        NPD_Project_Items__c    pitem1=   new NPD_Project_Items__c();
        
            pitem1.Item_Type__c             =    'Project';
            pitem1.Title__c                 =    'Test';
            pitem1.Titan_Sr_No__c           =    'AR-01';
            pitem1.Lead_Time__c             =    2;
            pitem1.Days_to_Complete__c      =    2;
            pitem1.Complexity__c            =    'Medium';
            pitem1.Project_Template__c      =    oPrjctTemp.id;
            pitem1.Active__c                =    TRUE;
            pitem1.Checklist_Columns__c     =    'Test';
        
            insert pitem1;
            system.debug('#pitem1'+pitem1);
            
            pMap.put(pitem1.id,pitem1);
            
       
        NPD_Project_Items__c    pitem2=   new NPD_Project_Items__c();
        
            pitem2.Item_Type__c             =    'Project';
            pitem2.Title__c                 =    'Test';
            pitem2.Titan_Sr_No__c           =    'AR-01';
            pitem2.Lead_Time__c             =    2;
            pitem2.Days_to_Complete__c      =    2;
            pitem2.Complexity__c            =    'Medium';
            pitem2.Project_Template__c      =    oPrjctTemp.id;
            pitem2.Active__c                =    TRUE;
            pitem2.Parent_Id__c             =    pitem1.id;
            pitem2.Copy_CheckList_Items__c  =    pitem1.id;  
            pitem2.Checklist_Columns__c     =    'Test';
        
            insert pitem2;
            system.debug('#pitem2'+pitem2);
            
            pMap.put(pitem2.id,pitem2);
            system.debug('#PMAP'+pMap);
            
            System.assertEquals(pitem2.Parent_Id__c,pitem1.id);
            
            NPDProjectItemsTriggerHandler oPitems = new NPDProjectItemsTriggerHandler ();
            oPitems.childActiveOrInactive(pMap);
            
        Test.StopTest(); 
    }
    
    public static testMethod void nPDProjectItemsTriggerTest3(){
    
    Test.StartTest();
    
    Map<Id,NPD_Project_Items__c> pMap = new Map<Id,NPD_Project_Items__c>();
        NPD_Project_Template__c oPrjctTemp  =    new NPD_Project_Template__c();
            oPrjctTemp.Name                     =    'Reguler';
            oPrjctTemp.Active__c                =    TRUE;
            oPrjctTemp.Description__c           =    'Testing';
            insert oPrjctTemp;
    
        NPD_Project_Items__c    pitem1=   new NPD_Project_Items__c();
        
            pitem1.Item_Type__c             =    'Project';
            pitem1.Title__c                 =    'Test';
            pitem1.Titan_Sr_No__c           =    'AR-01';
            pitem1.Lead_Time__c             =    2;
            pitem1.Days_to_Complete__c      =    2;
            pitem1.Complexity__c            =    'Medium';
            pitem1.Project_Template__c      =    oPrjctTemp.id;
            pitem1.Active__c                =    FALSE;
            pitem1.Checklist_Columns__c     =    'Test';
        
            insert pitem1;
            system.debug('#pitem1'+pitem1);
            
            pMap.put(pitem1.id,pitem1);
            
       
        NPD_Project_Items__c    pitem2=   new NPD_Project_Items__c();
        
            pitem2.Item_Type__c             =    'Project';
            pitem2.Title__c                 =    'Test';
            pitem2.Titan_Sr_No__c           =    'AR-01';
            pitem2.Lead_Time__c             =    2;
            pitem2.Days_to_Complete__c      =    2;
            pitem2.Complexity__c            =    'Medium';
            pitem2.Project_Template__c      =    oPrjctTemp.id;
            pitem2.Active__c                =    TRUE;
            pitem2.Parent_Id__c             =    pitem1.id;
            pitem2.Copy_CheckList_Items__c  =    pitem1.id;  
            pitem2.Checklist_Columns__c     =    'Test';
        
            insert pitem2;
            system.debug('#pitem2'+pitem2);
            
            pMap.put(pitem2.id,pitem2);
            system.debug('#PMAP'+pMap);
            
            System.assertEquals(pitem2.Parent_Id__c,pitem1.id);
            
            NPDProjectItemsTriggerHandler oPitems = new NPDProjectItemsTriggerHandler ();
            oPitems.childActiveOrInactive(pMap);
            
        Test.StopTest(); 
    }
     
}