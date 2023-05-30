@isTest
public class CostBandSuggestionTest {

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
        cb2.Fabric__c = 'aaa';
        cb2.Max__c = 1000;
        cb2.Min__c = 100;
        cb2.Origin__c = 'wer';
        cb2.Occasion__c = 'qew';
        cb2.Zari_Type__c = 'efq';
        insert cb2;
        
        
        /*
        Cost_band_value_Holder__c cbv = new Cost_band_value_Holder__c();
        
        Map<string,Cost_band_value_Holder__c> customSettingData = Cost_band_value_Holder__c.getAll();
        cbv = customSettingData.get('weraaaqewefq');
        cbv.Cost_band__c = 'AA';
        update cbv;
*/
        
        for(Integer i=0;i<26;i++)
        {
          Cost_Band_Master__c cb3 = new Cost_Band_Master__c();
        cb3.Fabric__c = 'aaa';
        cb3.Max__c = 1000;
        cb3.Min__c = 100;
        cb3.Origin__c = 'wer';
        cb3.Occasion__c = 'qew';
        cb3.Zari_Type__c = 'efq';
        insert cb3;  
        }
        
       /* cbv.Cost_band__c = 'Q';
        cbv.Name = cb1.Origin__c+cb1.Fabric__c+cb1.Occasion__c+cb1.Zari_Type__c;
        insert cbv; 
        /*
        List<Cost_Band_Master__c> cbmList = new List<Cost_Band_Master__c>();
        cbmList.add(cb1);
        new CostBandSuggestion().suggestCostBand(cbmList);*/
    }
    
}