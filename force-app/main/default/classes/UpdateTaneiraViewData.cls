global class UpdateTaneiraViewData implements DataBase.Batchable<sObject>,Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC){
        String recType=Schema.SObjectType.Product__c.getRecordTypeInfosByName().get('Taneira').getRecordTypeId();
        return Database.getQueryLocator('Select ID,Name,Quantity__c,Cost__c,Procurement_Cost__c,Product_Category_Taneira__c,CreatedDate,Cluster__c,vendor_custom__c,Offline_Username__c,Product_Key_Finder__c,Updated_in_TaneiraView__c FROM Product__c WHERE CreatedDate >2017-11-30T07:11:29.000Z  AND Product_Key_Finder__c !=NULL AND Product_Key_Finder__c !=\'\' AND Updated_in_TaneiraView__c =false AND RecordTypeId=:recType AND RE_ORDER__c !=true AND Created_From__c = \'Offline App\' ORDER BY CreatedDate DESC');
    }
     global void execute(Database.BatchableContext BC,List<Product__c> scope){
        
         Set<String> prodKeySet = new Set<String>();
         Map<String,Taneira_View__c> tnvMap = new Map<String,Taneira_View__c>();
         List<Product__c> updateProdList = new List<product__c>();
         Map<String,Taneira_View__c> taneiraViewMap = new Map<String,Taneira_View__c>();
         Map<Id,Product__c> keyProdMap = new Map<Id,Product__c>();
         Product__c prd;
         Taneira_View__c obj;
         
         for(Product__c each : scope){
             keyProdMap.put(each.Id,each);
             prodKeySet.add(each.Product_Key_Finder__c);
         }
         System.debug('---keyProdMap----->>'+keyProdMap);
         System.debug('---keyProdMap size----->>'+keyProdMap.size());
         System.debug('---prodKeySet----->>'+prodKeySet);
          System.debug('---prodKeySet size----->>'+prodKeySet.size());
             for(Taneira_View__c each : [SELECT Id,Product_Category__c,Origin__c,Custom_Created_Date__c,Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c,Offline_UserName__c FROM Taneira_View__c WHERE Product_Key_Finder1__c IN :prodKeySet]){
                 if(each !=NULL){
                 taneiraViewMap.put(each.Product_Key_Finder1__c, each);
                 }
             }
         //System.debug('---taneiraViewMap----->>'+taneiraViewMap);
         //System.debug('---taneiraViewMap size----->>'+taneiraViewMap.size());
            for(Id eachId :keyProdMap.keySet()){
                if(!taneiraViewMap.isEmpty() && taneiraViewMap.keySet().size()>0 && taneiraViewMap.containsKey(keyProdMap.get(eachId).Product_Key_Finder__c)){
                    obj = taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c);
                    obj.SKU__c=taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c).SKU__c + 1;
                    if(keyProdMap.get(eachId).Quantity__c !=NULL && taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c).Total_Quantity__c !=NULL){
                        obj.Total_Quantity__c=taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c).Total_Quantity__c + keyProdMap.get(eachId).Quantity__c ;
                    }
                    if(keyProdMap.get(eachId).Procurement_Cost__c!=NULL && taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c).Total_Value__c !=NULL && keyProdMap.get(eachId).Quantity__c !=NULL ){
                        obj.Total_Value__c = taneiraViewMap.get(keyProdMap.get(eachId).Product_Key_Finder__c).Total_Value__c +
                        (keyProdMap.get(eachId).Procurement_Cost__c * keyProdMap.get(eachId).Quantity__c);
                    }
                    taneiraViewMap.put(obj.Product_Key_Finder1__c, obj);
                    
                }//if ends
                else{
                    obj =new Taneira_View__c();
                    obj.vendor_custom__c = keyProdMap.get(eachId).vendor_custom__c;
                    obj.Custom_Created_Date__c= keyProdMap.get(eachId).CreatedDate;
                    obj.Offline_UserName__c =keyProdMap.get(eachId).Offline_UserName__c;
                    obj.Origin__c =keyProdMap.get(eachId).Cluster__c;
                    obj.Product_Category__c=keyProdMap.get(eachId).Product_Category_Taneira__c;
                    obj.Product_Key_Finder1__c=keyProdMap.get(eachId).Product_Key_Finder__c;
                    obj.SKU__c=1;
                    if(keyProdMap.get(eachId).Quantity__c !=NULL){
                        obj.Total_Quantity__c=keyProdMap.get(eachId).Quantity__c;
                    }
                    if(keyProdMap.get(eachId).Procurement_Cost__c!=NULL && keyProdMap.get(eachId).Quantity__c !=NULL ){
                        obj.Total_Value__c = (keyProdMap.get(eachId).Procurement_Cost__c* keyProdMap.get(eachId).Quantity__c);
                    }
                    taneiraViewMap.put(obj.Product_Key_Finder1__c,obj);
                    
                }//else ends
                //System.debug('-----eachId----'+eachId);
                prd= new Product__c();
                prd.Id =eachId;
                prd.Updated_in_TaneiraView__c =true;
                updateProdList.add(prd);
            }//for ends
            System.debug('-----tnvMap---->>'+taneiraViewMap);
            System.debug('-----tnvMap size---->>'+taneiraViewMap.size());
         if(taneiraViewMap.keySet().size()>0){
             upsert taneiraViewMap.values();
         }
         if(updateProdList.size()>0){
             update updateProdList;
         }
     }
    global void finish(Database.BatchableContext info){
        
    }
    global void execute(SchedulableContext sc) {        
        UpdateTaneiraViewData b1 = new UpdateTaneiraViewData();
        Database.executeBatch(b1,200);           
    }
}