/*
Name         : QC_ComponentTriggerHandler 
Created By   : Anand Durga Prasad
Created Date :
Modified By  :Anand Durga Prasad
Last Modified Date:
Description: Test Class for QC_Tabs.
*/

@isTest
public class QC_ComponentTriggerHandlerTest {
    public static List<QC_Components__c > lcomp = new List<QC_Components__c> ();   
    
    public static testMethod void method1(){
        test.startTest();
        QC_ComponentTriggerHandler.appendZeros('1');
        QC_ComponentTriggerHandler.appendZeros('10');
        QC_ComponentTriggerHandler.appendZeros('100');
        
        //Inserting custom setting records 
        list<QC_Component_Prefix__c> custSettingList = new list<QC_Component_Prefix__c>();
        custSettingList = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList;
        
        QC_Components__c  comp1 = QC_TestHandlerCls.getIndividComponent();
        comp1.name__c='Watch-Head';
        comp1.SKU_Reference__c='jtgkftgfju';
        comp1.Watch_variant__c='fastrack0809';
        comp1.Sample_Date__c = date.newInstance(2020, 4, 15);
        comp1.Published_Date__c = date.newInstance(2020, 4, 22);
        comp1.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        comp1.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        lcomp.add(comp1);
        try{
            insert comp1;
        }catch(Exception e){
            system.assert(e.getmessage().contains('already exists')); 
        }

        //Checking the duplicate validation on update   
        comp1.name__c='Full-Watch';
        comp1.SKU_Reference__c='kguyyguygf';
        comp1.Watch_variant__c='fastrack';
        comp1.Sample_Category__c='New';
        
        try{
            update comp1;
        }catch(Exception e){
            system.debug('EXCEPTION::::'+e);
            //  system.assert(e.getmessage().contains('already exists')); 
        }
        test.stopTest();
        QC_Components__c  comp5 = new QC_Components__c();
        comp5.name__c='Case';
        comp5.Sample_Category__c='New';
        comp5.SKU_Reference__c='jtgkftgdgdgfsffju';
        comp5.Watch_variant__c='fastrasdfsfdsfck0809';
        comp5.approval_submitted_date__c = System.now();
        comp5.Sample_Date__c = System.today()-1;
        comp5.final_verdict__c = 'Accept';
        comp5.Document_Status__c='Published';
        try{
            insert comp5;
        }catch(Exception e){
            system.assert(e.getmessage().contains('already exists')); 
        }
        comp5.name__c='Dial';
        comp5.SKU_Reference__c='kguyyguygf';
        comp5.Watch_variant__c='fastrack';
        comp5.Sample_Category__c='New';
        try{
            update comp5;
        }catch(Exception e){
            system.debug('EXCEPTION::::'+e);
            system.assert(e.getmessage().contains('already exists')); 
        }
        
    }
    
    public static testMethod void method2(){
        test.startTest();
        list<QC_Component_Prefix__c> custSettingList1 = new list<QC_Component_Prefix__c>();
        custSettingList1 = QC_TestHandlerCls.getCustomSetting();
        insert custSettingList1;
        
        QC_Components__c  comp2 = new QC_Components__c(name__c='Watch-Head',Sample_Category__c='Competitor Products');
        comp2.name__c='Watchsdvsdd-Head';
        comp2.SKU_Reference__c='jtgkftgdgdgfsffju';
        comp2.Watch_variant__c='fastrasdfsfdsfck0809';
        comp2.approval_submitted_date__c = System.now();
        comp2.Sample_Date__c = System.today()-1;
        comp2.final_verdict__c = 'Accept';
        comp2.Document_Status__c='Published';
        comp2.Sample_Date__c = date.newInstance(2020, 4, 15);
        comp2.Published_Date__c = date.newInstance(2020, 4, 22);
        comp2.First_Approval_Date__c = date.newInstance(2020, 4, 22);
        comp2.approval_submitted_date__c = date.newInstance(2020, 4, 20);
        lcomp.add(comp2);
        try{
            insert comp2;
        }catch(Exception e){
            system.assert(e.getmessage().contains('already exists')); 
        }
        
        //Checking the duplicate validation on update
        
        comp2.name__c='Full-Watch';
        comp2.SKU_Reference__c='kguyysfdsfdfguygf';
        comp2.Watch_variant__c='fassfsdfsdfsdftrack';
        try{
            update comp2;
        }catch(Exception e){
            system.debug('EXCEPTION::::'+e);
            system.assert(e.getmessage().contains('already exists')); 
        }  
        
        
        QC_Components__c  comp3 = new QC_Components__c(name__c='Case',Sample_Category__c='Competitor Products',Parent__c=comp2.id);
        comp3.name__c='Watchsdvsdd-Head';
        comp3.SKU_Reference__c='jtgkftgfsfsfsdsdfdgdgfsffju';
        comp3.Watch_variant__c='fastrasdsfsfffffsfdsfck0809';
        comp3.approval_submitted_date__c = System.now();
        comp3.Sample_Date__c = System.today()-1;
        comp3.final_verdict__c = 'Accept';
        comp3.Document_Status__c='Published';
        
        try{
            insert comp3;
        }catch(Exception e){
            system.assert(e.getmessage().contains('already exists')); 
        }
        
        //Checking the duplicate validation on update
        
        //  comp2.name__c='Watch-Headsfsddff';
        comp3.SKU_Reference__c='kgudfgfdgfyysfdsfdfguygf';
        comp3.Watch_variant__c='fassdsgddgfsdfsdfsdftrack';
        try{
            update comp3;
        }catch(Exception e){
            system.debug('EXCEPTION::::'+e);
            system.assert(e.getmessage().contains('already exists')); 
        } 
        
        
        map<id,QC_Components__c> testMap =  new map<id,QC_Components__c>();
        testMap.put(comp3.id,comp3);
        QC_ComponentTriggerHandler.initialize();
        QC_ComponentTriggerHandler.uniqueCheckOnUpdate(testMap,testMap);
        QC_ComponentTriggerHandler.updateComponentPrefix(testMap);
        QC_ComponentTriggerHandler.uniqueCheckOnInsert(lcomp);
        QC_ComponentTriggerHandler.updateComponentApprovalStatus(lcomp);
        
        test.stopTest();
    }
    
}