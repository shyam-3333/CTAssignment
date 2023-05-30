/************************************************************************************
Created By: Samarth Hegade
@description: This handler is used to map Fabric, Craft, Origin, Zari Type Based on product category Before insertion of L1L5 Master

**************************************************************************************/

public class RP_L1_L5_MasterTriggerHandler {
    /* @description: This method will insert the L1-L5 master records from trigger*/
    public static void createUniqueKey(List<L1_L5_Master__c> masterList){
        String fabric='';
        String origin='';
        String craft='';
        String zariType='';
        string uniqueKey='';
        for(L1_L5_Master__c m : masterList){
            if(m.Product_Category_1__c != null){
                switch on m.Product_Category_1__c.toLowerCase(){
                    when 'fabric'{
                        fabric=m.Product_category_value_1__c;
                    }
                    when 'craft'{
                        craft=m.Product_category_value_1__c;
                    }
                    when 'origin'{
                        origin=m.Product_category_value_1__c;
                    }
                    when 'zari type'{
                        zariType=m.Product_category_value_1__c;
                    }
                    
                }
            }
            if(m.Product_Category_2__c != null){
                switch on m.Product_Category_2__c.toLowerCase(){
                    when 'fabric'{
                        fabric=m.Product_category_value_2__c;
                    }
                    when 'craft'{
                        craft=m.Product_category_value_2__c;
                    }
                    when 'origin'{
                        origin=m.Product_category_value_2__c;
                    }
                    when 'zari type'{
                        zariType=m.Product_category_value_2__c;
                    }
                    
                }
            }
            if(m.Product_Category_3__c != null){
                switch on m.Product_Category_3__c.toLowerCase(){
                    when 'fabric'{
                        fabric=m.Product_category_value_3__c;
                    }
                    when 'craft'{
                        craft=m.Product_category_value_3__c;
                    }
                    when 'origin'{
                        origin=m.Product_category_value_3__c;
                    }
                    when 'zari type'{
                        zariType=m.Product_category_value_3__c;
                    }   
                }
            }
            if(m.Product_Category_4__c != null){
                switch on m.Product_Category_4__c.toLowerCase(){
                    when 'fabric'{
                        fabric=m.Product_category_value_4__c;
                    }
                    when 'craft'{
                        craft=m.Product_category_value_4__c;
                    }
                    when 'origin'{
                        origin=m.Product_category_value_4__c;
                    }
                    when 'zari type'{
                        zariType=m.Product_category_value_4__c;
                    }                    
                }
            }  
            uniqueKey = fabric+craft+origin+zariType;
            uniqueKey = uniqueKey.deleteWhitespace().toLowerCase();
            m.Unique_Key__c = uniqueKey;
			m.Fabric__c = fabric.deleteWhitespace().toLowerCase();
			m.Craft__c = craft.deleteWhitespace().toLowerCase();
			m.Origin__c = origin.deleteWhitespace().toLowerCase();
            m.Zari_Type__c = zariType.deleteWhitespace().toLowerCase();
        }      
    }
    
}