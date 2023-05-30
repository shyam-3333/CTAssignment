@isTest
public class CombinedKeyGenerationTest {

    public static testMethod void testMethod1(){
        Cost_Band_Master__c cb1 = new Cost_Band_Master__c();
        cb1.Band__c = 'Q';
        cb1.Fabric__c = 'aaa';
        cb1.Max__c = 1000;
        cb1.Min__c = 100;
        cb1.Origin__c = 'wer';
        cb1.Occasion__c = 'qew';
        cb1.Zari_Type__c = 'efq';
        insert cb1;
        
        Cost_Band_Master__c cb2 = new Cost_Band_Master__c();
        cb2.Band__c = 'Q';
        cb2.Fabric__c = 'aaa';
        cb2.Max__c = 1000;
        cb2.Min__c = 100;
        cb2.Origin__c = 'wercss';
        cb2.Occasion__c = 'qew';
        cb2.Zari_Type__c = 'efq';
        insert cb2;
        cb2.Band__c = 'aaa';
        update cb2;
    }
}