@isTest
public class Qc_ComponentNewTriggerHandlerTest {
     @IsTest
    private static void testAsync() {
        Qc_ComponentNewTriggerHandler asyncTest = new Qc_ComponentNewTriggerHandler();
    }
 /*public static List<QC_Components__c > lcomp = new List<QC_Components__c> ();   
    
    public static testMethod void method1(){
        test.startTest();
         
            TriggerExecutionController__c trgExc = new TriggerExecutionController__c();
            trgExc.Name = 'Qc_Component_Lightning_Trigger';
            trgExc.TriggerIsActive__c = true ;
            insert trgExc;
            
            TriggerExecutionController__c trgExc2 = new TriggerExecutionController__c();
            trgExc2.Name = 'QC_ComponentUniqueRefTrigger';
            trgExc2.TriggerIsActive__c = false ;
            insert trgExc2;
            
        Qc_ComponentNewTriggerHandler.appendZeros('1');
        Qc_ComponentNewTriggerHandler.appendZeros('10');
        Qc_ComponentNewTriggerHandler.appendZeros('100');
        
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
           // system.assert(e.getmessage().contains('already exists')); 
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
           	System.debug('exceptions --->'+e.getCause());
            System.debug(e.getStackTraceString());
            
           	System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            system.assert(e.getmessage().contains('already exists')); 
        }
        comp5.name__c='Dial';
        comp5.SKU_Reference__c='kguyyguygf1';
        comp5.Watch_variant__c='fastrack';
        comp5.Sample_Category__c='New';
        try{
            update comp5;
        }catch(Exception e){
            System.debug('exceptions --->'+e.getCause());
            System.debug(e.getStackTraceString());
            
           	System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            system.debug('EXCEPTION::::'+e);
//            system.assert(e.getmessage().contains('already exists')); 
        }
        
    }
    
    public static testMethod void method2(){
        test.startTest();
        
		   TriggerExecutionController__c trgExc = new TriggerExecutionController__c();
            trgExc.Name = 'Qc_Component_Lightning_Trigger';
            trgExc.TriggerIsActive__c = true ;
            insert trgExc;
            
            TriggerExecutionController__c trgExc2 = new TriggerExecutionController__c();
            trgExc2.Name = 'QC_ComponentUniqueRefTrigger';
            trgExc2.TriggerIsActive__c = false ;
            insert trgExc2;
        
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
        comp2.Master__c = true;
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
        comp3.Parent__c = comp2.id;
        comp3.name__c='Watchsdvsdd-Head';
        comp3.SKU_Reference__c='jtgkftgfsfsfsdsdfdgdgfsffju';
        comp3.Watch_variant__c='fastrasdsfsfffffsfdsfck0809';
        comp3.approval_submitted_date__c = System.now();
        comp3.Sample_Date__c = System.today()-1;
        comp3.final_verdict__c = 'Accept';
        comp3.Document_Status__c='Published';
        comp3.Master_Variant__c = comp3.id;
        comp3.Master__c = false;
        
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
        Qc_ComponentNewTriggerHandler.initialize();
        Qc_ComponentNewTriggerHandler.uniqueCheckOnUpdate(testMap,testMap);
        Qc_ComponentNewTriggerHandler.uniqueCheckOnInsert(lcomp);
        Qc_ComponentNewTriggerHandler.reportRefNumber('0002', comp3);
        comp3.Sample_Category__c = 'New';
        Qc_ComponentNewTriggerHandler.reportRefNumber('0002', comp3);
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Full-Watch' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Full-Watch' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Watch-Head' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Watch-Head' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Case' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Case' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Dial' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Dial' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Metal-Strap' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Metal-Strap' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Leather-Strap' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Leather-Strap' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Module' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Module' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Battery' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Battery' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( 'Packaging' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('Packaging' , 'New');
        Qc_ComponentNewTriggerHandler.componentPrefix( '' , 'Competitor Products' );
        Qc_ComponentNewTriggerHandler.componentPrefix('' , 'New');
        Qc_ComponentNewTriggerHandler.incrementStr('a');
        Qc_ComponentNewTriggerHandler.resubmissionReportRefNumber('FW/0001/21-22');
        Qc_ComponentNewTriggerHandler.resubmissionReportRefNumber('FW/0001[a]/21-22');
        comp3.Document_Status__c = 'Approved' ;
        comp3.Final_Verdict__c = 'Reject';
        update comp3;
        test.stopTest();
    }*/
    
}