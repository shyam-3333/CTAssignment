public class GenerateMultiplierCombination {
    
    public void whileInsert(list<Multiplier_Value_Master__c> newList){
        for(Multiplier_Value_Master__c m1 :newList){
            string combination;
            combination   = m1.Origin__c+m1.Pricing_Type__c+m1.Fabric__c+m1.Craft__c+m1.Zari__c+m1.Cost_Band__c;
            m1.Concatenation__c = combination.toUpperCase();
        }
    }
    
    public void whileUpdate(list<Multiplier_Value_Master__c> newList,map<id,Multiplier_Value_Master__c> oldMap){
        for(Multiplier_Value_Master__c m1 :newList){
            if(m1.Cost_Band__c != oldMap.get(m1.Id).Cost_Band__c || m1.Craft__c != oldMap.get(m1.Id).Craft__c || m1.Fabric__c != oldMap.get(m1.Id).Fabric__c ||
               m1.Origin__c != oldMap.get(m1.Id).Origin__c || m1.Pricing_Type__c != oldMap.get(m1.Id).Pricing_Type__c || m1.Zari__c != oldMap.get(m1.Id).Zari__c){
                   string combination;
                   combination   = m1.Origin__c+m1.Pricing_Type__c+m1.Fabric__c+m1.Craft__c+m1.Zari__c+m1.Cost_Band__c;
                   m1.Concatenation__c = combination.toUpperCase();
               }
        }
    }
}