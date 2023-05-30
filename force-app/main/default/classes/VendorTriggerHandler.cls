/*
 Created By   : Mutturaj Heroor
 Created Date : 15/10/2020
 Class Name   : VendorTriggerHandler
*/
public class VendorTriggerHandler {
	
    public static void vendorAfterUpdate(List<Vendor__c> newList, Map<id,Vendor__c> oldMap){
        Map<Id,List<Product__c>> mapOfProducts = new Map<Id,List<Product__c>>();
        Map<String,String> mapOfMaster = new Map<String,String>();
        List<Product__c>productUpdateList = new List<Product__c>();
        set<String> setOfMaster = new set<String>();
        Id productRecordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        setOfMaster.add('Base Colour');
        setOfMaster.add('Zari Type');
        for(Product__c prod : [SELECT Id,RecordTypeId, Product_Description__c,Border_Pattern__c,Body_Pattern__c,Vendor_custom__c,Pallu_Pattern__c,Base_Colour__c,Zari_Type__c FROM Product__c where Vendor_custom__c in: oldMap.keyset() AND RecordTypeId = : productRecordTypeId]){
            if(!mapOfProducts.isEmpty() && mapOfProducts.containsKey(prod.Vendor_custom__c)){
                mapOfProducts.get(prod.Vendor_custom__c).add(prod);
            }
            else{
                mapOfProducts.put(prod.Vendor_custom__c, new list <Product__c> {prod});
            }
        }
       for(Master__c mast : [SELECT Code__c,Id,Name, Name__c From Master__c Where Active__c= TRUE AND Name__c in: setOfMaster]){
           
           mapOfMaster.put(mast.Name , mast.Code__c);
           
        }
        for(Vendor__c each : newList){
                if(each.vendor_code__c != null && each.vendor_code__c != oldMap.get(each.Id).Vendor_Code__c && !mapOfProducts.IsEmpty() && mapOfProducts.containsKey(each.id) && mapOfProducts.get(each.id)!=null){
                    for(Product__c prod : mapOfProducts.get(each.Id)){
                        system.debug('**prod**'+prod);
                        string bodyPattern = '';
                        string borderPattern = '';
                        string palluPattern = '';
                        string baseColor = '';
                        string zari = '';
                        if(prod.Body_Pattern__c != null){
                            bodyPattern = prod.Body_Pattern__c.replaceAll( '\\s+', '');
                            bodyPattern = bodyPattern.left(8);
                            system.debug('**bodyPattern**'+bodyPattern);
                        }
                        
                        if(prod.Border_Pattern__c != null){
                            borderPattern = prod.Border_Pattern__c.replaceAll( '\\s+', '');
                            borderPattern = borderPattern.left(8) + 'B';
                            system.debug('**borderPattern**'+borderPattern );
                        }
                        if(prod.Pallu_Pattern__c != null){
                            palluPattern = prod.Pallu_Pattern__c.replaceAll( '\\s+', '');
                            palluPattern = palluPattern.left(8) + 'P';
                            system.debug('**palluPattern**'+palluPattern);
                        }
                        if(prod.Base_Colour__c != null){
                            baseColor = mapOfMaster.get(prod.Base_Colour__c);
                        }
                        if(prod.Zari_Type__c != null){
                            zari = mapOfMaster.get(prod.Zari_Type__c) + 'Z';
                        }
                        
                        system.debug('**baseColor**'+baseColor);
                        system.debug('**zari**'+zari);
                        if(bodyPattern != '' && borderPattern != '' && palluPattern!= '' && baseColor != '' && zari != ''){
                            prod.Product_Description__c = bodyPattern + '-'+borderPattern + '-' + palluPattern + '-' + baseColor + '-' + zari + '-'+each.vendor_code__c.left(3);
                            productUpdateList.add(prod);
                        }
                        
                    
                    }
                }
          
          }
          try{
              if(productUpdateList.size()>0){
                  update productUpdateList;
              }
          }
          catch(Exception ex){
              system.debug('**Exception**'+ex);
          }
      
    }
    
    public static void vendorBeforeInsert(List<Vendor__c>newList){
        set<String> setOfEmail = new set<String>();
        set<String> setOfPhone = new set<String>();
        for(Vendor__c each : newList){
            each.Active__c = true;
            setOfPhone.add(each.Mobile_Phone__c);
        }
        Map<String,Vendor__c> mapOfPhone = new Map<String,Vendor__c>();
        for(Vendor__c vend : [SELECT Id,Email_Id_Vendor__c,Mobile_Phone__c  FROM Vendor__c WHERE Mobile_Phone__c in : setOfPhone ]){
            if(vend.Mobile_Phone__c != null){
                mapOfPhone.put(vend.Mobile_Phone__c,vend);
            } 
        }
        system.debug('**mapOfPhone**'+mapOfPhone);
        for(Vendor__c each : newList){
            if( mapOfPhone.containsKey(each.Mobile_Phone__c)){
                each.addError('Vendor with same Mobile/Phone already exists in the system');
            }
        }
    }
}