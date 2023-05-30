public class CostBandSuggestion {
    public void suggestCostBand(list<Cost_Band_Master__c> newList){
        Map<string,Cost_band_value_Holder__c> customSettingData = Cost_band_value_Holder__c.getAll();
        list<Cost_band_value_Holder__c> csListInsert = new list<Cost_band_value_Holder__c>();
        list<Cost_band_value_Holder__c> csListUpdate = new list<Cost_band_value_Holder__c>();
        String key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZA';
        for(Cost_Band_Master__c cb : newList){
            string combination;
            if(customSettingData.ContainsKey(cb.combinedKey__c)){
                combination = customSettingData.get(cb.combinedKey__c).Cost_band__c;
                system.debug('combination -->'+ combination);
                if(combination.length()==1){
                    Integer index = key.indexOfChar(combination.charAt(0));
                    Cost_band_value_Holder__c cbvh1 = new Cost_band_value_Holder__c();
                    cbvh1.Id = customSettingData.get(cb.combinedKey__c).id;
                    cbvh1.Name = customSettingData.get(cb.combinedKey__c).name;
                    if(combination == 'Z'){
                        cbvh1.Cost_band__c = 'AA';
                            cb.Band__c = 'AA';
                    }else{
                        cbvh1.Cost_band__c = key.substring(index+1, index+2);
                        cb.Band__c = key.substring(index+1, index+2);
                    }
                    
                    csListUpdate.add(cbvh1);
                    
                }else if(combination.length()==2){
                    Integer index = key.indexOfChar(combination.charAt(0));
                    Integer index2 = key.indexOfChar(combination.charAt(1));
                    Cost_band_value_Holder__c cbvh1 = new Cost_band_value_Holder__c();
                    cbvh1.Id = customSettingData.get(cb.combinedKey__c).id;
                    cbvh1.Name = customSettingData.get(cb.combinedKey__c).name;
                    
                    string[] str= combination.split('');
                    if(str[1] == 'Z')
                    {
                        if(str[0] == 'Z')
                        {
                            str[0] = 'AA';
                            str[1] = 'A';
                        }
                        else{
                            str[0] = key.substring(index+1, index+2);
                            str[1] ='A';
                        }
                    }
                    else{
                        
                        str[1] = key.substring(index2+1, index2+2);
                    }
                    cbvh1.Cost_band__c = str[0] + str[1];
                    cb.Band__c = str[0] + str[1];
                    
                    csListUpdate.add(cbvh1);
                    
                }
            }else{
                Cost_band_value_Holder__c cbvh = new Cost_band_value_Holder__c();
                cbvh.Name = cb.combinedKey__c;
                cbvh.Cost_band__c = 'A';
                csListInsert.add(cbvh);
                cb.Band__c = 'A';
            }
            
        }
        if(csListInsert.size()>0){
            insert csListInsert;
        }
        if(csListUpdate.size()>0){
            Update csListUpdate;
        }
    }
    
    
}