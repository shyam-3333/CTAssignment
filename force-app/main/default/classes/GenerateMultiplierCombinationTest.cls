@isTest
public class GenerateMultiplierCombinationTest {

    public static testMethod void testMethod1(){
        Multiplier_Value_Master__c mv1 = new Multiplier_Value_Master__c();
        mv1.Cost_Band__c = 'A';
        mv1.Craft__c = 'BLOCK PRINT';
        mv1.Fabric__c = 'Silk Cotton';
        mv1.Multiplier__c = 11;
        mv1.Origin__c = 'Bagru';
        mv1.Pricing_Type__c = 'A';
        mv1.Zari__c = 'TESTED';
        insert mv1;
        
        mv1.Zari__c = 'Nil';
        update mv1;
    }
}