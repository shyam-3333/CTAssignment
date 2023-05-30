public class SyncProductToTaneiraView{
    
    public static void fetchProdData(List<Product__c> prodList){
        Set<String> prodfinderKeySet = new Set<String>();
        Set<String> attributionUserEmailSet = new Set<String>();
        String attributionUserName = '';
        Map<String,Taneira_View__c> prodfinderKeyMap1 = new Map<String,Taneira_View__c>();
        Map<Id,Taneira_View__c> taneiraViewIdMap = new Map<Id,Taneira_View__c>();
        Taneira_View__c obj;
        String valueHolder;
 //-------------------------------------------------------------------------------------------------------       
        if(!prodList.isEmpty()){
            for(Product__c each : prodList){
                prodfinderKeySet.add(each.Product_Key_Finder__c);
                attributionUserEmailSet.add(each.Attribution_User_Email__c);
            }
        }
        System.debug('---prodfinderKeySet---->>'+prodfinderKeySet);
        System.debug('---attributionUserEmailSet---->>'+attributionUserEmailSet);
        System.debug('---attributionUserEmailSet---->>'+attributionUserEmailSet.size());
        if(!attributionUserEmailSet.isEmpty()){
            for(User u : [Select Name from User where email IN: attributionUserEmailSet]){
                attributionUserName = u.Name;
            }
        }
 //-------------------------------------------------------------------------------------------------------       
        if(prodfinderKeySet.size()>0){
            for(Taneira_View__c each : [SELECT Id,Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c,Offline_UserName__c FROM Taneira_View__c WHERE Product_Key_Finder1__c IN :prodfinderKeySet]){
                prodfinderKeyMap1.put((each.Product_Key_Finder1__c).trim() , each);
            }
        }
        System.debug('---prodfinderKeyMap1----->>'+prodfinderKeyMap1);
//-------------------------------------------------------------------------------------------------------        
        if(!prodList.isEmpty()){           
            for(Product__c each : prodList){  
                System.debug('-----debbbbbb---->>'+each.Product_Key_Finder__c);
                if(each.Product_Key_Finder__c !=NULL && each.Product_Key_Finder__c !=''){
                    valueHolder = each.Product_Key_Finder__c;
                }
                //---------------------------------------------------------------------------------------
                if(!prodfinderKeyMap1.isEmpty() && prodfinderKeyMap1.containsKey(valueHolder)){
                    
                    System.debug('Coming inside to update');
                    obj = prodfinderKeyMap1.get(valueHolder);
                    
                    if(each.Quantity__c !=NULL && prodfinderKeyMap1.get(valueHolder).Total_Quantity__c !=NULL){
                        obj.Total_Quantity__c = prodfinderKeyMap1.get(valueHolder).Total_Quantity__c+each.Quantity__c;
                    }
                    if(each.Buyers_Cost__c!=NULL && each.Quantity__c!=NULL && prodfinderKeyMap1.get(valueHolder).Total_Value__c !=NULL){
                        obj.Total_Value__c =prodfinderKeyMap1.get(valueHolder).Total_Value__c +(each.Buyers_Cost__c*each.Quantity__c);
                    }
                    if(prodfinderKeyMap1.get(valueHolder).SKU__c !=NULL){
                        obj.SKU__c = prodfinderKeyMap1.get(valueHolder).SKU__c+1;
                    }
                    System.debug('----obj----->>'+obj);
                    prodfinderKeyMap1.put(obj.Product_Key_Finder1__c,obj);
                    
                }
               //-----------------------------------------------------------------------------------------
               else {
                    obj = new Taneira_View__c();
                    obj.vendor_custom__c= each.vendor_custom__c;
                    obj.Custom_Created_Date__c= each.CreatedDate;
                    obj.Origin__c=each.Cluster__c;
                    obj.Product_Category__c= each.Product_Category_Taneira__c;
                   obj.Proc_Type__c = each.Proc_Type__c;
                    if(each.Quantity__c !=NULL){
                        obj.Total_Quantity__c=each.Quantity__c;
                    }
                    if(each.Quantity__c !=NULL && each.Buyers_Cost__c!=NULL){
                        obj.Total_Value__c = (each.Buyers_Cost__c*each.Quantity__c);
                    }
                    obj.SKU__c =1;
                    obj.Account_Id__c = each.vendor_custom__c;
                    obj.Product_Key_Finder1__c= valueHolder;
                    obj.Offline_UserName__c=each.Offline_UserName__c;
                    obj.Re_order__c = each.RE_ORDER__c;
                    obj.Attribution_User__c = attributionUserName;
                    prodfinderKeyMap1.put(obj.Product_Key_Finder1__c,obj);
                }
                
            }//end of for
        }//end of if
        
        //System.debug('===tnraProdViewListToInsert---->>'+tnraProdViewListToInsert);
        System.debug('===taneiraViewIdMap---->>'+taneiraViewIdMap);
        if(!prodfinderKeyMap1.isEmpty()){
            upsert prodfinderKeyMap1.values();
        }
       
    }//method ends
    
        public static void reorder(List<Product__c> prodList){
        Set<String> prodfinderKeySet = new Set<String>();
        Map<String,Taneira_View__c> prodfinderKeyMap1 = new Map<String,Taneira_View__c>();
        Map<Id,Taneira_View__c> taneiraViewIdMap = new Map<Id,Taneira_View__c>();
        Taneira_View__c obj;
        String valueHolder;
 //-------------------------------------------------------------------------------------------------------       
        if(!prodList.isEmpty()){
            for(Product__c each : prodList){
                prodfinderKeySet.add(each.Product_Key_Finder__c);              
            }
        }
        System.debug('---prodfinderKeySet---->>'+prodfinderKeySet);
 //-------------------------------------------------------------------------------------------------------       
        if(prodfinderKeySet.size()>0){
            for(Taneira_View__c each : [SELECT Id,Product_Key_Finder1__c,SKU__c,Total_Quantity__c,Total_Value__c,Offline_UserName__c FROM Taneira_View__c WHERE Product_Key_Finder1__c IN :prodfinderKeySet]){
                prodfinderKeyMap1.put((each.Product_Key_Finder1__c).trim() , each);
            }
        }
        System.debug('---prodfinderKeyMap1----->>'+prodfinderKeyMap1);
//-------------------------------------------------------------------------------------------------------        
        if(!prodList.isEmpty()){           
            for(Product__c each : prodList){  
                System.debug('-----debbbbbb---->>'+each.Product_Key_Finder__c);
                if(each.Product_Key_Finder__c !=NULL && each.Product_Key_Finder__c !=''){
                    valueHolder = each.Product_Key_Finder__c;
                }
                //---------------------------------------------------------------------------------------
                if(!prodfinderKeyMap1.isEmpty() && prodfinderKeyMap1.containsKey(valueHolder)){
                    
                    System.debug('Coming inside to update');
                    obj = prodfinderKeyMap1.get(valueHolder);                   
                    obj.vendor_custom__c= each.vendor_custom__c;
                    obj.Product_Category__c= each.Product_Category_Taneira__c;
                    obj.Origin__c=each.Cluster__c;
                    obj.Proc_Type__c = each.Proc_Type__c;
                    obj.SKU__c = 1;
                    if(each.Quantity__c !=NULL){
                    obj.Total_Quantity__c = each.Quantity__c;
                    }
                    if(each.Buyers_Cost__c != NULL && each.Quantity__c!=NULL){
                    obj.Total_Value__c = (each.Buyers_Cost__c*each.Quantity__c);
                    }
                    obj.Custom_Created_Date__c= each.CreatedDate;
                    
                    prodfinderKeyMap1.put(obj.Product_Key_Finder1__c,obj);
                    
                }
                
            }//end of for
        }//end of if
        
        //System.debug('===tnraProdViewListToInsert---->>'+tnraProdViewListToInsert);
        System.debug('===taneiraViewIdMap---->>'+taneiraViewIdMap);
        if(!prodfinderKeyMap1.isEmpty()){
            update prodfinderKeyMap1.values();
        }
       
    }//method ends
        
}