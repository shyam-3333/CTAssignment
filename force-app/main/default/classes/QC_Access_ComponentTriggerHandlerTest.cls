@isTest
public class QC_Access_ComponentTriggerHandlerTest {
    static testMethod void myUnitTest() {
        Map <Id,QC_Access_Component__c> omap= new Map<Id,QC_Access_Component__c>();
        Map <Id,QC_Access_Component__c> nmap= new Map<Id,QC_Access_Component__c>();
        List<QC_Access_Component__c> invList = new List<QC_Access_Component__c>();
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'BA';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
        QC_Access_Component__c obj2 = new QC_Access_Component__c();
        obj2.isConstructionTesting__c = true;
        insert obj2;
        
        QC_Access_Component__c obj = new QC_Access_Component__c();
        obj.SKU_Reference__c ='Test';
        obj.isReliabilityTesting__c =True;
        obj.Sample_Type__c ='New';
        obj.Sample_Category__c ='Bags';
        obj.isReferredConstructionTest__c = true;
        obj.Construction_Refer_Number__c = obj2.Id;
        insert obj;
        
        QC_Access_Component__c obj1 = new QC_Access_Component__c();
        obj1.SKU_Reference__c ='Test';
        obj1.Sub_Category__c ='Backpack';
        obj1.Sample_Category__c ='Bags';
        obj1.Sample_Type__c ='New';
        obj1.isConstructionTesting__c =True;
        obj1.Master__c =false;
        
        invList.add(obj1);
      
        omap.put(obj.id,obj);
        nmap.put(obj.id,obj);
        
       
        test.startTest();
		QC_Access_ComponentTriggerHandler.checkSKUReferOnInsert(invList);
        QC_Access_ComponentTriggerHandler.checkReferOnUpdate(omap,nmap);
        QC_Access_ComponentTriggerHandler.updateCompPrefix(nmap);
        test.stopTest();
        
    }
    
    public static testMethod void testMethod2(){
        
        Map <Id,QC_Access_Component__c> nmap= new Map<Id,QC_Access_Component__c>();
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'BAC';
        custSettObj.Sequence_Number__c = '0021';
        insert custSettObj;
        
        QC_Access_Component__c obj = new QC_Access_Component__c();
        obj.isConstructionTesting__c =True;
        obj.Sample_Type__c ='New';
        obj.Sample_Category__c ='Bags';
        obj.Master__c = true;
        obj.Report_Ref_Number__c = 'BAC/0021/19-20';
        obj.Master_Refer_Value__c = true;
        insert obj;
        
        nmap.put(obj.id,obj);
        test.startTest();
        QC_Access_ComponentTriggerHandler.updateCompPrefix(nmap);
        test.stopTest();
        
    }
    
    public static testMethod void testMethod3(){
        
        Map <Id,QC_Access_Component__c> nmap= new Map<Id,QC_Access_Component__c>();
        
        QC_Accessories_Component_Prefix__c custSettObj = new QC_Accessories_Component_Prefix__c();
        custSettObj.Name = 'CBA';
        custSettObj.Sequence_Number__c = '0222';
        insert custSettObj;
        
        QC_Access_Component__c obj = new QC_Access_Component__c();
        obj.isReliabilityTesting__c = True;
        obj.Sample_Type__c ='Competitor Products';
      //  obj.Sample_Category__c ='Bags';
        insert obj;
        
        nmap.put(obj.id,obj);
        test.startTest();
        QC_Access_ComponentTriggerHandler.updateCompPrefix(nmap);
        QC_Access_ComponentTriggerHandler.appendZeros(custSettObj.Sequence_Number__c);
        test.stopTest();
        
    }
}