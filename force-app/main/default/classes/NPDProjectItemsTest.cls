@isTest
public class NPDProjectItemsTest {
     public static testMethod void test(){
     
         Test.StartTest(); 
         NPD_Project_Template__c tempid = new NPD_Project_Template__c();
         tempid.Active__c = true;
         tempid.Description__c ='hello roshi';
         insert tempid;
         
         
         
         NPD_Project_Items__c proItems = new NPD_Project_Items__c();
         proItems.Titan_Sr_No__c = 'titan1';
         proItems.Titan_SNo_Predecessor__c = 'qqqqqqq';
         proItems.Position__c = 5;
         proItems.Title__c  = 'aaaaa';
         proItems.Total_Lead_Time__c = 40;
         proItems.Complexity__c  = 'Low';
         proItems.Days_to_Complete__c  =90;
         proItems.Lead_Time__c = 100;
         proItems.Item_Type__c = 'Stage';
         proItems.Project_Template__c = tempid.id;
         insert proItems;
         
         NPD_Project_Items__c proItems1 = new NPD_Project_Items__c();
         proItems1.Titan_Sr_No__c = 'titan2';
         proItems1.Titan_SNo_Predecessor__c = 'qqqqqqq2';
         proItems1.Position__c = 51;
         proItems1.Title__c  = 'bbbbbb';
         proItems1.Total_Lead_Time__c = 40;
         proItems1.Complexity__c  = 'Low';
         proItems1.Days_to_Complete__c  =90;
         proItems1.Lead_Time__c = 100;
         proItems1.Item_Type__c = 'Sub-stage';
         proItems1.Project_Template__c = tempid.id;
         insert proItems1;
         
         NPD_Project_Items__c proItems2 = new NPD_Project_Items__c();
         proItems2.Titan_Sr_No__c = 'titan3';
         proItems2.Titan_SNo_Predecessor__c = 'qqqqqqq3';
         proItems2.Position__c = 1;
         proItems2.Title__c  = 'cccccc';
         proItems2.Total_Lead_Time__c = 40;
         proItems2.Complexity__c  = 'Low';
         proItems2.Days_to_Complete__c  =90;
         proItems2.Lead_Time__c = 100;
         proItems2.Item_Type__c = 'Activity';
         proItems2.Project_Template__c = tempid.id;
         proItems2.Parent_id__c = proItems.id;
         insert proItems2;
         
         NPD_Project_Items__c proItems3 = new NPD_Project_Items__c();
         proItems3.Titan_Sr_No__c = 'titan4';
         proItems3.Titan_SNo_Predecessor__c = 'qqqqqqq3';
         proItems3.Position__c = 53;
         proItems3.Title__c  = 'Case Development - INH';
         proItems3.Total_Lead_Time__c = 40;
         proItems3.Complexity__c  = 'Low';
         proItems3.Days_to_Complete__c  =90;
         proItems3.Lead_Time__c = 100;
         proItems3.Item_Type__c = 'Activity';
         proItems3.Project_Template__c = tempid.id;
         
         insert proItems3;
         
          NPD_Project_Items__c proItems4 = new NPD_Project_Items__c();
         proItems4.Titan_Sr_No__c = 'titan5';
         proItems4.Titan_SNo_Predecessor__c = 'qqqqqqq5';
         proItems4.Position__c = 54;
         proItems4.Title__c  = 'Case Development - INH';
         proItems4.Total_Lead_Time__c = 46;
         proItems4.Complexity__c  = 'Low';
         proItems4.Days_to_Complete__c  =97;
         proItems4.Lead_Time__c = 100;
         proItems4.Item_Type__c = 'Sub-Activity';
         proItems4.Project_Template__c = tempid.id;
         insert proItems4;
         
         
         NPD_Complexity__c comp1 = new NPD_Complexity__c();
         comp1.Record_Type__c = 'Complexity Type';
         comp1.Lead_Time_del__c =100;
         comp1.Type__c = 'Activity';
         comp1.NPD_Activity__c = proItems1.id;
         insert comp1;
         
         NPD_Complexity__c comp = new NPD_Complexity__c();
         comp.Record_Type__c = 'Complexity Category';
         comp.Lead_Time_del__c =150;
         comp.Type__c = 'Sub-stage';
         comp.NPD_Activity__c = proItems.id;
         insert comp;
         
         boolean selected;
         
         ApexPages.currentPage().getParameters().put('templateId',tempid.id);
         ApexPages.currentPage().getParameters().put('ItemId',proItems.id);
         ApexPages.currentPage().getParameters().put('type','Activity');
         ApexPages.currentPage().getParameters().put('comType',comp1.id);
         ApexPages.currentPage().getParameters().put('itemName','Activity');
         ApexPages.currentPage().getParameters().put('parentId',proItems.id);
          
         NPDCreateProjectItemsController  npd = new NPDCreateProjectItemsController ();
         
         NPDCreateProjectItemsController.complexWrapper wrp = new NPDCreateProjectItemsController.complexWrapper(comp1);
         NPDCreateProjectItemsController.projectItemWrapper pwrp = new NPDCreateProjectItemsController.projectItemWrapper(proItems);
         ApexPages.currentPage().getParameters().put('templateId',tempid.id);
         ApexPages.currentPage().getParameters().put('ItemId',proItems.id);
         ApexPages.currentPage().getParameters().put('type','Activity');
         ApexPages.currentPage().getParameters().put('comType',comp1.id);
         ApexPages.currentPage().getParameters().put('itemName','Activity');
         ApexPages.currentPage().getParameters().put('parentId',proItems.id);
         npd.strEvent  = 'create';
         npd.stageSave();
         npd.strEvent  = 'edit';
         npd.stageSave();
         wrp.selected = true;
         npd.projectItemsCreation();
         npd.DeleteRow();
         //npd.EditRec();
         
         npd.positionSort();
         npd.callRollupLeadTime();
         npd.redirectToProjectTemplate();
         npd.cancel();
         npd.closePopup();
         npd.showPopup();
         npd.doCheckListSelection();
         npd.doProjectItemRecSelection();
         npd.getcomplexityTypeValues();
         npd.getcomplexityValues();        
         npd.doComplexitySelection(); 
         npd.updateStageLeadTime();        
         Test.StopTest();
         
     }
     
     public static testMethod void test1(){
         Test.StartTest(); 
         NPD_Project_Template__c tempid = new NPD_Project_Template__c();
         tempid.Active__c = true;
         tempid.Description__c ='hello roshi';
         insert tempid;
         
         
         
         NPD_Project_Items__c proItems = new NPD_Project_Items__c();
         proItems.Titan_Sr_No__c = 'titan1';
         proItems.Titan_SNo_Predecessor__c = 'qqqqqqq';
         proItems.Position__c = 30;
         proItems.Title__c  = 'Case Development - INH';
         proItems.Total_Lead_Time__c = 40;
         proItems.Complexity__c  = 'Low';
         proItems.Days_to_Complete__c  =90;
         proItems.Lead_Time__c = 100;
         proItems.Item_Type__c = 'Stage';
         proItems.Project_Template__c = tempid.id;
         insert proItems;
         
         NPD_Project_Items__c proItems1 = new NPD_Project_Items__c();
         proItems1.Titan_Sr_No__c = 'titan2';
         proItems1.Titan_SNo_Predecessor__c = 'qqqqqqq2';
         proItems1.Position__c = 31;
         proItems1.Title__c  = 'Case Development - INH';
         proItems1.Total_Lead_Time__c = 40;
         proItems1.Complexity__c  = 'Low';
         proItems1.Days_to_Complete__c  =90;
         proItems1.Lead_Time__c = 100;
         proItems1.Item_Type__c = 'Sub-stage';
         proItems1.Project_Template__c = tempid.id;
         insert proItems1;
         
         NPD_Project_Items__c proItems2 = new NPD_Project_Items__c();
         proItems2.Titan_Sr_No__c = 'titan3';
         proItems2.Titan_SNo_Predecessor__c = 'qqqqqqq3';
         proItems2.Position__c = 31;
         proItems2.Title__c  = 'Case Development - INH';
         proItems2.Total_Lead_Time__c = 40;
         proItems2.Complexity__c  = 'Low';
         proItems2.Days_to_Complete__c  =90;
         proItems2.Lead_Time__c = 100;
         proItems2.Item_Type__c = 'Activity';
         proItems2.Project_Template__c = tempid.id;
         insert proItems2;
         
         NPD_Project_Items__c proItems3 = new NPD_Project_Items__c();
         proItems3.Titan_Sr_No__c = 'titan4';
         proItems3.Titan_SNo_Predecessor__c = 'qqqqqqq3';
         proItems3.Position__c = 31;
         proItems3.Title__c  = 'Case Development - INH';
         proItems3.Total_Lead_Time__c = 40;
         proItems3.Complexity__c  = 'Low';
         proItems3.Days_to_Complete__c  =90;
         proItems3.Lead_Time__c = 100;
         proItems3.Item_Type__c = 'Activity';
         proItems3.Project_Template__c = tempid.id;
         insert proItems3;
         
          NPD_Project_Items__c proItems4 = new NPD_Project_Items__c();
         proItems4.Titan_Sr_No__c = 'titan5';
         proItems4.Titan_SNo_Predecessor__c = 'qqqqqqq5';
         proItems4.Position__c = 31;
         proItems4.Title__c  = 'Case Development - INH';
         proItems4.Total_Lead_Time__c = 46;
         proItems4.Complexity__c  = 'Low';
         proItems4.Days_to_Complete__c  =97;
         proItems4.Lead_Time__c = 100;
         proItems4.Item_Type__c = 'Sub-Activity';
         proItems4.Project_Template__c = tempid.id;
         insert proItems4;
         
         
         NPD_Complexity__c comp1 = new NPD_Complexity__c();
         comp1.Record_Type__c = 'Complexity Type';
         comp1.Lead_Time_del__c =100;
         comp1.Type__c = 'Activity';
         comp1.NPD_Activity__c = proItems1.id;
         comp1.Sub_Stage__c = proItems1.id;
         insert comp1;
         
         NPD_Complexity__c comp = new NPD_Complexity__c();
         comp.Record_Type__c = 'Complexity Category';
         comp.Lead_Time_del__c =150;
         comp.Type__c = 'Sub-stage';
         comp.NPD_Activity__c = proItems.id;
         comp.Sub_Stage__c = proItems1.id;
         insert comp;
         
         boolean selected=true;
         
         ApexPages.currentPage().getParameters().put('templateId',tempid.id);
         ApexPages.currentPage().getParameters().put('ItemId',proItems.id);
         ApexPages.currentPage().getParameters().put('type','Sub-stage');
         ApexPages.currentPage().getParameters().put('comType',comp1.id);
         ApexPages.currentPage().getParameters().put('title','Case Development - INH');
        
         
         NPDCreateProjectItemsController  npd = new NPDCreateProjectItemsController ();
         npd.stageSave();
         npd.projectItemsCreation();
         npd.DeleteRow();
         npd.EditRec();
         
         npd.positionSort();
         npd.callRollupLeadTime();
         npd.redirectToProjectTemplate();
         npd.cancel();
         npd.closePopup();
         npd.showPopup();
         npd.doCheckListSelection();
         npd.doProjectItemRecSelection();
         npd.getcomplexityTypeValues();
         npd.getcomplexityValues();        
         npd.doComplexitySelection();       
         Test.StopTest();
     }
}