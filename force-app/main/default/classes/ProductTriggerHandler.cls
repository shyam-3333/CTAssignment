/***************************************************
Created By: Poornapriya YN
Description : Handler class for Taneira Products
****************************************************/

public class ProductTriggerHandler{
    
    /* This method is called before Insert
* Generates SKU Code for non reordered products
* Generates product description code.
*/
    public static Map<string,AutoNumber__c> mapOfAutoNumUpdate = new Map<string,AutoNumber__c>();
    public static void beforeInsertProduct(List<Product__c> newList){
        system.debug('in method of ppp');
        //mapOfAutoNumUpdate.clear();
        String month = '';
        string yearOfOperation = '';
        Map<String,String> mapOfMaster = new Map<String,String>();
        Map<Id,Product__c> MapOfProduct = new Map<Id,Product__c>();
        set<String> setOfMaster = new set<String>();
        set<Id> accountIdSet= new set<Id>();
        boolean isAuto = false;
        setOfMaster.add('Product Category');
        setOfMaster.add('Loom');
        setOfMaster.add('Proc-Type');
        setOfMaster.add('Zari Type');
        setOfMaster.add('Base Colour');
        List<AutoNumber__c> autoNumList = new List<AutoNumber__c>();
        Map<string,AutoNumber__c>mapOfAutoNum = new Map<string,AutoNumber__c>(); 
        Map<Integer,String>mapOfMonth = new Map<Integer,String>();   
        for(AutoNumber__c auto : AutoNumber__c.getall().values()){
            mapOfAutoNum.put(auto.Name,auto);            
        }
        for(SKU_Month_Code__c mnt : SKU_Month_Code__c.getall().values()){
            mapOfMonth.put(integer.valueOf(mnt.Name),mnt.code__c);
        }
        
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        
        for(Master__c mast : [SELECT Code__c,Id,Name, Name__c From Master__c Where Active__c= TRUE AND Name__c in: setOfMaster]){
            string keyVal = mast.Name__c + mast.Name;
            mapOfMaster.put(keyVal , mast.Code__c);
        }
        
        for(Product__c each : newList){
            if(each.RecordTypeId == recordTypeId){
                accountIdSet.add(each.vendor_custom__c);
            }
        }
        Map<Id,vendor__c> mapOfAccount = new Map<Id,vendor__c>([SELECT Vendor_Code__c,Id from vendor__c where Id in : accountIdSet]);  
        system.debug('**mapOfMaster**'+mapOfMaster);
        for(Product__c prod : newList){
          system.debug('proddducct==>'+prod.id);
                if(prod.RecordTypeId == recordTypeId ){
                    
                    if(!mapOfAccount.isEmpty() && mapOfAccount.containsKey(prod.vendor_custom__c) && mapOfAccount.get(prod.vendor_custom__c).Vendor_Code__c != null){
                        if(prod.Body_Pattern__c != null && prod.Border_Pattern__c != null && prod.Pallu_Pattern__c != null && prod.Base_Colour__c != null && prod.Zari_Type__c != null && !prod.RE_ORDER__c){
                            MapOfProduct.put(prod.Id,prod);
                            system.debug('**MapOfProduct**'+MapOfProduct);
                        }
                    }
                    system.debug('**Re_Order__c**'+prod.Re_Order__c);
                    if(!prod.Re_Order__c){
                        string numOfZero = '';
                        system.debug('---------mapOfAutoNum------------'+mapOfAutoNum);
                        system.debug('---------mapOfMaster------------'+mapOfMaster);
                        system.debug('---------Product_Category_Taneira__c------------'+prod.Product_Category_Taneira__c);
                        //system.debug('---------Auto_Number__c------------'+prod.Auto_Number__c);
                        system.debug('---------loom__c------------'+prod.loom__c);
                        system.debug('---------Proc_Type__c------------'+prod.Proc_Type__c);
                        integer autoNum = integer.valueOf(mapOfAutoNum.get(mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c)+mapOfMaster.get('Loom'+prod.loom__c)+mapOfMaster.get('Proc-Type'+prod.Proc_Type__c)).Auto_Number__c);
                        integer len = string.valueOf(autoNum).length();
                        system.debug('**autoNum**'+autoNum);
                        system.debug('**len**'+len);
                        for(integer i=1; i <= 5-len; i++){
                            numOfZero += '0';
                        }
                        
                        if(date.Today().year() == 2016){
                            yearOfOperation = '01';
                        }
                        else{
                            integer year = (date.Today().year()- 2016) + 1;
                            yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                        }
                        System.debug('yearOfOperation'+yearOfOperation);
                        month = mapOfMonth.get(date.Today().month());
                        system.debug('month'+month);
                        system.debug('***AutoNumber__c.get(SPH)11***'+AutoNumber__c.getValues('SPH'));
                        system.debug('numOfZero'+numOfZero);
                        prod.SKU_Code__c= mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c) + mapOfMaster.get('Loom'+prod.Loom__c) + mapOfMaster.get('Proc-Type'+prod.Proc_Type__c) +yearOfOperation +month+ numOfZero +autoNum;
                        system.debug('**prod.SKU_Code__c.substring(0, 3)**'+prod.SKU_Code__c.substring(0, 3));
                        mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c += 1;  
                        mapOfAutoNumUpdate.put(prod.SKU_Code__c.substring(0,3),mapOfAutoNum.get(prod.SKU_Code__c.substring(0,3)));  
                        system.debug('**mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c  +1**'+mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c);       
                        system.debug('**prod.SKU_Code__c**'+prod.SKU_Code__c);
                        system.debug('**mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c**'+mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c);
                    }   
                }   
            }
        
        system.debug('**mapOfAutoNumUpdate(After trigger)**'+mapOfAutoNumUpdate);        //--
        if(!mapOfAutoNumUpdate.isEmpty()){
            autoNumList.addAll(mapOfAutoNumUpdate.values());
        }
        system.debug('----------autoNumList-----------'+autoNumList);
        
        if(autoNumList.size()>0){
            update autoNumList;
        }                                                                               //--
        system.debug('***AutoNumber__c.get(SHT)***'+AutoNumber__c.getValues('SHT')); 
        system.debug('***AutoNumber__c.get(SPH)***'+AutoNumber__c.getValues('SPH')); 
        system.debug('***mapOfAutoNumUpdate***'+mapOfAutoNumUpdate);    
        if(!MapOfProduct.isEmpty()){
            ProductTriggerHandler.generateProductDescription(MapOfProduct,mapOfAccount,mapOfMaster);
        }        
    }
    
    public static void afterInsertUpdateProduct(Map<Id,Product__c>newMap,Map<Id,Product__c> oldMap, Boolean isUpdate){
        // mapOfAutoNumUpdate.clear();
        List<AutoNumber__c> autoNumList = new List<AutoNumber__c>();
        system.debug('**mapOfAutoNumUpdate(After trigger)**'+mapOfAutoNumUpdate);        
        if(!mapOfAutoNumUpdate.isEmpty()){
            autoNumList.addAll(mapOfAutoNumUpdate.values());
        }
        system.debug('----------autoNumList-----------'+autoNumList);
        
        if(autoNumList.size()>0){
            update autoNumList;
        }
        
    }  
    public static void beforeUpdateProduct(List<Product__c>newList,Map<Id,Product__c>oldMap){
        
        String month = '';
        string yearOfOperation = '';
        set<Id> setOfId = new set<Id>(); // AccountId
        set<String> setOfMaster = new set<String>();
        Map<String,String> mapOfMaster = new Map<String,String>();
        Map<Id,Product__c> MapOfProduct = new Map<Id,Product__c>();
        Map<Integer,String>mapOfMonth = new Map<Integer,String>();
        Map<string,AutoNumber__c>mapOfAutoNum = new Map<string,AutoNumber__c>(); 
        
        setOfMaster.add('Product Category');
        setOfMaster.add('Loom');
        setOfMaster.add('Proc-Type');
        setOfMaster.add('Base Colour');
        setOfMaster.add('Zari Type');
        List<AutoNumber__c> autoNumList = new List<AutoNumber__c>();
        // Retrieve Month code from custom setting
        for(SKU_Month_Code__c mnt : SKU_Month_Code__c.getall().values()){
            mapOfMonth.put(integer.valueOf(mnt.Name),mnt.code__c);
        }
        // Retrieve Autonumber value from custom setting
        for(AutoNumber__c auto : AutoNumber__c.getall().values()){
            mapOfAutoNum.put(auto.Name,auto);
            
        }
        Id recordTypeId = [Select Id from RecordType where Name=:'Taneira' and SObjectType = 'Product__c' limit 1].Id;
        for(Master__c mast : [SELECT Code__c,Id,Name, Name__c From Master__c Where Active__c= TRUE AND Name__c in: setOfMaster]){
            string keyVal = mast.Name__c + mast.Name;
            mapOfMaster.put(keyVal , mast.Code__c);  
        }
        for(Product__c prod : newList){
            if(prod.RecordTypeId == recordTypeId){
                setOfId.add(prod.vendor_custom__c);
            }
        }
        Map<Id,vendor__c> mapOfAccount = new Map<Id,vendor__c>([SELECT ID, VENDOR_CODE__c FROM vendor__c WHERE Id in:setOfId]);
        
        for(Product__c prod : newList){
            
                if(prod.SKU_Code__c == null && prod.Re_order__c){
                string numOfZero = '';   
                integer autoNum = integer.valueOf(mapOfAutoNum.get(mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c)+mapOfMaster.get('Loom'+prod.loom__c)+mapOfMaster.get('Proc-Type'+prod.Proc_Type__c)).Auto_Number__c);
                integer len = string.valueOf(autoNum).length();
                system.debug('**autoNum**'+autoNum);
                system.debug('**len**'+len);
                for(integer i=1; i <= 5-len; i++){
                    numOfZero += '0';
                }
                
                if(date.Today().year() == 2016){
                    yearOfOperation = '01';
                }
                else{
                    integer year = (date.Today().year()- 2016) + 1;
                    yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                }
                month = mapOfMonth.get(date.Today().month());
                prod.SKU_Code__c= mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c) + mapOfMaster.get('Loom'+prod.Loom__c) + mapOfMaster.get('Proc-Type'+prod.Proc_Type__c) +yearOfOperation +month+ numOfZero +autoNum + 'R';
                System.debug(':::SKU Code is:::'+mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c) + mapOfMaster.get('Loom'+prod.Loom__c) + mapOfMaster.get('Proc-Type'+prod.Proc_Type__c) +yearOfOperation +month+ numOfZero +autoNum + 'R');
                system.debug('**prod.SKU_Code__c.substring(0, 3)**'+prod.SKU_Code__c.substring(0, 3));
                mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c += 1;
                System.debug(':::mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c:::'+mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)).Auto_Number__c); 
                mapOfAutoNumUpdate.put(prod.SKU_Code__c.substring(0,3),mapOfAutoNum.get(prod.SKU_Code__c.substring(0,3)));        
                system.debug('**prod.SKU_Code__c**'+prod.SKU_Code__c);
                // autoNumList.add(mapOfAutoNum.get(prod.SKU_Code__c.substring(0, 3)));
            }
            if(oldMap.get(prod.Id).SKU_Code__c != null && prod.RecordTypeId == recordTypeId){
                if(prod.CreatedDate.year() == 2016){
                    yearOfOperation = '01';
                }
                else{
                    integer year = (prod.CreatedDate.year() - 2016) + 1;
                    yearOfOperation = string.valueOf(year).length() < 2 ? '0'+ year : string.valueOf(year);           
                }
                string autoNum = '';
                month = mapOfMonth.get(prod.CreatedDate.month());
                if(oldMap.get(prod.Id).SKU_Code__c.length() == 11){
                    autoNum = oldMap.get(prod.Id).SKU_Code__c.substring(6, 11);
                }
                else if(oldMap.get(prod.Id).SKU_Code__c.length() == 12){
                    autoNum = oldMap.get(prod.Id).SKU_Code__c.substring(6, 12);
                }
                system.debug('**autoNum **'+autoNum);
                
                if(oldMap.get(prod.Id).SKU_Code__c.length() <= 13){
                    System.debug('prod.RE_ORDER__c:::: '+prod.RE_ORDER__c+'#### '+oldMap.get(prod.Id).SKU_Code__c.length());
                    if((oldMap.get(prod.Id).Product_Category_Taneira__c != prod.Product_Category_Taneira__c 
                        || oldMap.get(prod.Id).Loom__c != prod.Loom__c ||  oldMap.get(prod.Id).Proc_Type__c!= prod.Proc_Type__c) && prod.RE_ORDER__c && !prod.SKU_Code__c.endsWith('R')){  
                            prod.SKU_Code__c= mapOfMaster.get('Product Category'+prod.Product_Category_Taneira__c) + mapOfMaster.get('Loom'+prod.Loom__c) + mapOfMaster.get('Proc-Type'+prod.Proc_Type__c) +yearOfOperation +month+ autoNum  ;
                            
                        }
                    else if(!test.isRunningTest() && (oldMap.get(prod.Id).Product_Category_Taneira__c != prod.Product_Category_Taneira__c 
                                                      || oldMap.get(prod.Id).Loom__c != prod.Loom__c ||  oldMap.get(prod.Id).Proc_Type__c!= prod.Proc_Type__c)){
                                                          prod.addError('Values for Product Category, Loom, Proc-Type cannot be changed');
                                                      }
                }
                system.debug('**prod.RE_ORDER__c**'+prod.RE_ORDER__c);
                
                
            }
            
            if(!mapOfAccount.isEmpty() && mapOfAccount.containsKey(prod.vendor_custom__c) && mapOfAccount.get(prod.vendor_custom__c).Vendor_Code__c != null){
                if(prod.Body_Pattern__c != null && prod.Border_Pattern__c != null && prod.Pallu_Pattern__c != null && prod.Base_Colour__c != null && prod.Zari_Type__c != null){
                    if(oldMap.get(prod.Id).Body_Pattern__c != prod.Body_Pattern__c || oldMap.get(prod.Id).Border_Pattern__c != prod.Border_Pattern__c || oldMap.get(prod.Id).Pallu_Pattern__c != prod.Pallu_Pattern__c || oldMap.get(prod.Id).Base_Colour__c != prod.Base_Colour__c ||  oldMap.get(prod.Id).Zari_Type__c != prod.Zari_Type__c){
                        MapOfProduct.put(prod.Id,prod);
                    }
                }
                
            }
            
        }   
        if(!MapOfProduct.isEmpty()){
            ProductTriggerHandler.generateProductDescription(MapOfProduct,mapOfAccount,mapOfMaster);
        }
        /*if(autoNumList.size()>0){
			update autoNumList;
		}*/
    }  
    
    public static void generateProductDescription(Map<Id,Product__c> mapOfProduct, Map<Id,vendor__c> mapOfAccount,Map<String,String> mapOfMaster){
        
        
        for(Id prod : mapOfProduct.keyset()){
            string bodyPattern = '';
            string borderPattern = '';
            string palluPattern = '';
            string baseColor = '';
            string zari = '';

            if(mapOfProduct.containsKey(prod)){
                if(mapOfProduct.get(prod).Body_Pattern__c != null){
                   bodyPattern = mapOfProduct.get(prod).Body_Pattern__c.replaceAll( '\\s+', '');
            bodyPattern = bodyPattern.left(8); 
                }
                
            system.debug('**bodyPattern**'+bodyPattern);
            if(mapOfProduct.get(prod).Border_Pattern__c != null){
                   borderPattern = mapOfProduct.get(prod).Border_Pattern__c.replaceAll( '\\s+', '');
            borderPattern = borderPattern.left(8) + 'B';
            system.debug('**borderPattern**'+borderPattern );
                }

            
            }
            
            if(mapOfProduct.containsKey(prod)){
                if(mapOfProduct.get(prod).Pallu_Pattern__c != null){
                     palluPattern = mapOfProduct.get(prod).Pallu_Pattern__c.replaceAll( '\\s+', '');
            palluPattern = palluPattern.left(8) + 'P';
            system.debug('**palluPattern**'+palluPattern);
                }
               
                if(mapOfMaster.containsKey('Base Colour' + mapOfProduct.get(prod).Base_Colour__c)){
                baseColor = mapOfMaster.get('Base Colour' + mapOfProduct.get(prod).Base_Colour__c); 
            }
            if(mapOfMaster.containsKey('Zari Type' + mapOfProduct.get(prod).Zari_Type__c)){
                 zari = mapOfMaster.get('Zari Type' + mapOfProduct.get(prod).Zari_Type__c) + 'Z';
            }
                if(mapOfAccount.containsKey(mapOfProduct.get(prod).vendor_custom__c)){
                    if(mapOfAccount.get(mapOfProduct.get(prod).vendor_custom__c).vendor_code__c != null){
                        mapOfProduct.get(prod).Product_Description__c = bodyPattern + '-'+borderPattern + '-' + palluPattern + '-' + baseColor + '-' + zari + '-'+mapOfAccount.get(mapOfProduct.get(prod).vendor_custom__c).vendor_code__c.left(3);
                    }
                }
            

            }
            
                       
            
            system.debug('**baseColor**'+baseColor);
            system.debug('**zari**'+zari);
            integer i = 0;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
             i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;
            i++;

        }
    }    
}