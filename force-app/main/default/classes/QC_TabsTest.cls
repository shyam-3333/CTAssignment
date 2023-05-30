/*
    Name         : QC_TabsTest 
    Created By   : Anand Durga Prasad
    Created Date :
    Modified By  :Anand Durga Prasad
    Last Modified Date:
    Description: Test Class for QC_Tabs.
*/

@isTest
public class QC_TabsTest {

   @testsetup static void commonData(){
    	//Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
    }
   
    public static testMethod void method1(){
        
      QC_Components__c  comp = QC_TestHandlerCls.getIndividComponent();
      insert comp;
        
       list<QC_Components__c> compList = new list<QC_Components__c>();
       compList.addAll(QC_TestHandlerCls.getParentComponents()); 
       for(QC_Components__c each : compList){
          each.name__c = 'case';
          each.parent__c = comp.id;
       }
       insert compList;   
       
       ApexPages.StandardController controller = new ApexPages.StandardController(comp);
       System.currentPageReference().getParameters().put('id', comp.id);
       QC_Tabs tabs = new QC_Tabs(controller);
      
       id savedCompId = [select id from QC_Components__c where id=:comp.id].id; 
       system.assert(savedCompId != null);
    }

}